import requests
import time
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from create_db import DriverChampionshipStats, Base
from config import API_KEY, YEAR

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
                # Создаем или обновляем статистику чемпионата
                championship_stats = DriverChampionshipStats(
                    driver_id=driver_data['id'],
                    points=driver_data.get('points', 0),
                    playoff_eligible=driver_data.get('in_chase', False),
                    avg_start=float(driver_data.get('avg_start_position', 0)),
                    avg_finish=float(driver_data.get('avg_finish_position', 0)),
                    wins=driver_data.get('wins', 0),
                    poles=driver_data.get('poles', 0)
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