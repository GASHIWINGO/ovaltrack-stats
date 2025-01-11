import requests
import time
from sqlalchemy import create_engine, select
from sqlalchemy.orm import sessionmaker
from create_db import DriverRaceStats, Race, RaceSeries, Base
from config import API_KEY

SERIES_ALIASES = {
    'mc': 1,  # Cup Series ID
    'xf': 2,  # Xfinity Series ID
    'cw': 3   # Craftsman Truck Series ID
}

def fetch_race_results(api_key, series_alias, race_id, max_retries=3):
    url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/races/{race_id}/results.json"
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
            print(f"Ошибка при получении данных из API для гонки {race_id}: {e}")
            return None
    return None

def get_series_alias_by_race_id(session, race_id):
    """Получаем алиас серии по race_id"""
    stmt = select(RaceSeries.series_id).where(RaceSeries.race_id == race_id)
    series_id = session.execute(stmt).scalar()
    
    for alias, id_ in SERIES_ALIASES.items():
        if id_ == series_id:
            return alias
    return None

def seed_race_stats(api_key=API_KEY):
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    try:
        # Получаем все гонки
        races = session.query(Race).all()
        total_races = len(races)

        for index, race in enumerate(races, 1):
            print(f"Обработка гонки {index}/{total_races}: {race.name}")
            
            # Получаем алиас серии для данной гонки
            series_alias = get_series_alias_by_race_id(session, race.id)
            if not series_alias:
                print(f"Не удалось определить серию для гонки {race.id}")
                continue

            # Добавляем задержку между запросами
            if index > 1:
                print("Ожидание 1 секунда перед следующим запросом...")
                time.sleep(1)

            # Получаем результаты гонки
            data = fetch_race_results(api_key, series_alias, race.id)
            if not data or 'results' not in data:
                continue

            for result in data['results']:
                # Создаем или обновляем статистику гонки
                race_stats = DriverRaceStats(
                    driver_id=result['driver']['id'],
                    race_id=race.id,
                    start_position=result.get('start_position', 0),
                    finish_position=result.get('position', 0),
                    points=result.get('points', 0),
                    laps_completed=result.get('laps_completed', 0),
                    pit_stops=result.get('pit_stop_count', 0),
                    best_lap_time=float(result.get('best_lap_time', 0))
                )
                
                session.merge(race_stats)

            # Сохраняем результаты каждой гонки отдельно
            session.commit()
            print(f"Статистика гонки {race.name} успешно добавлена")

        print("Все данные о статистике гонок успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данных: {e}")
        raise e
    finally:
        session.close()

if __name__ == "__main__":
    seed_race_stats() 