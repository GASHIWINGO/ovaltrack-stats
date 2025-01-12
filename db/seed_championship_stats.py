import requests
import time
from sqlalchemy import create_engine, select, func, extract, distinct
from sqlalchemy.orm import sessionmaker
from create_db import DriverChampionshipStats, Base, Driver, DriverRaceStats, Race, RacingSeries
from config import API_KEY, YEAR
from datetime import datetime

SERIES_ALIASES = {
    'mc': 1,  # Cup Series ID
    'xf': 2,  # Xfinity Series ID
    'cw': 3   # Craftsman Truck Series ID
}

def fetch_standings_data(api_key, series_alias, year, max_retries=3):
    url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/{year}/standings/drivers.json"
    params = {"api_key": api_key}
    
    for attempt in range(max_retries):
        try:
            response = requests.get(url, params=params)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            if response.status_code == 429:
                wait_time = (attempt + 1) * 2
                print(f"Превышен лимит запросов. Ожидание {wait_time} секунд...")
                time.sleep(wait_time)
                continue
            print(f"Ошибка при получении данных из API для серии {series_alias}: {e}")
            return None
    return None

def calculate_championship_stats(session, driver_id, series_id, year):
    """Рассчитывает статистику для гонщика в заданной серии за указанный год."""
    
    # Получаем все гонки для заданной серии и года
    stmt_races = select(Race.id).join(Race.series).where(
        RacingSeries.id == series_id,
        extract('year', Race.date) == year
    )
    race_ids = [race_id for race_id, in session.execute(stmt_races).all()]
    
    # Получаем статистику гонщика в этих гонках
    stmt_stats = select(DriverRaceStats).where(
        DriverRaceStats.driver_id == driver_id,
        DriverRaceStats.race_id.in_(race_ids)
    )
    race_stats = session.execute(stmt_stats).scalars().all()
    
    base_points = sum(stat.points for stat in race_stats if stat.points is not None)
    wins = sum(1 for stat in race_stats if stat.finish_position == 1)
    poles = sum(1 for stat in race_stats if stat.start_position == 1)
    top5_finishes = sum(1 for stat in race_stats if stat.finish_position <= 5)
    top10_finishes = sum(1 for stat in race_stats if stat.finish_position <= 10)
    
    # Логика расчета плей-офф бонуса (только для NASCAR Cup Series)
    playoff_bonus = 0
    if series_id == 1 and base_points > 800:
        # Получаем текущее количество гонщиков в серии
        stmt_drivers_count = select(func.count(distinct(DriverRaceStats.driver_id))).join(Race).join(Race.series).where(
            RacingSeries.id == series_id,
            extract('year', Race.date) == year
        )
        drivers_count = session.execute(stmt_drivers_count).scalar()

        # Получаем количество гонщиков с большим количеством очков
        stmt_higher_points_count = select(func.count(distinct(DriverRaceStats.driver_id))).join(Race).join(Race.series).where(
            RacingSeries.id == series_id,
            extract('year', Race.date) == year,
            DriverRaceStats.driver_id.in_(
                select(DriverRaceStats.driver_id).where(
                    DriverRaceStats.race_id.in_(race_ids),
                    DriverRaceStats.points > base_points
                )
            )
        )
        higher_points_count = session.execute(stmt_higher_points_count).scalar()
        
        if higher_points_count < 8:
            playoff_bonus = 5000
        elif higher_points_count < 16:
            playoff_bonus = 2000
            
    total_points = base_points + playoff_bonus

    return {
        'base_points': base_points,
        'playoff_bonus': playoff_bonus,
        'total_points': total_points,
        'wins': wins,
        'poles': poles,
        'top5_finishes': top5_finishes,
        'top10_finishes': top10_finishes
    }

def seed_championship_stats(api_key=API_KEY, year=YEAR):
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    try:
        for series_alias, series_id in SERIES_ALIASES.items():
            if series_alias != list(SERIES_ALIASES.keys())[0]:
                print("Ожидание 1 секунда перед следующим запросом...")
                time.sleep(1)
            
            data = fetch_standings_data(api_key, series_alias, year)
            if not data or 'drivers' not in data:
                continue

            for driver_data in data['drivers']:
                # Рассчитываем статистику
                stats = calculate_championship_stats(session, driver_data['id'], series_id, year)
                
                # Создаем или обновляем статистику чемпионата
                championship_stats = DriverChampionshipStats(
                    driver_id=driver_data['id'],
                    points=driver_data.get('points', 0),
                    playoff_eligible=driver_data.get('in_chase', False),
                    avg_start=float(driver_data.get('avg_start_position', 0)),
                    avg_finish=float(driver_data.get('avg_finish_position', 0)),
                    wins=driver_data.get('wins', 0),
                    poles=driver_data.get('poles', 0),
                    # Добавляем новые поля
                    base_points=stats['base_points'],
                    playoff_bonus=stats['playoff_bonus'],
                    total_points=stats['total_points'],
                    top5_finishes=stats['top5_finishes'],
                    top10_finishes=stats['top10_finishes']
                )
                
                session.merge(championship_stats)

        session.commit()
        print("Данные о статистике чемпионата успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данных: {e}")
        raise e
    finally:
        session.close()

if __name__ == "__main__":
    seed_championship_stats()