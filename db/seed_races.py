import requests
import time
from datetime import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from create_db import Race, RaceSeries, Base
from config import API_KEY, YEAR

SERIES_ALIASES = {
    'mc': 1,  # Cup Series ID
    'xf': 2,  # Xfinity Series ID
    'cw': 3   # Craftsman Truck Series ID
}

def fetch_schedule_data(api_key, series_alias, year, max_retries=3):
    url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/{year}/races/schedule.json"
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

def parse_datetime(datetime_str):
    if not datetime_str:
        return None
    try:
        return datetime.strptime(datetime_str, '%Y-%m-%dT%H:%M:%S%z')
    except ValueError:
        return None

def seed_races(api_key = API_KEY, year = YEAR):
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    try:
        for series_alias, series_id in SERIES_ALIASES.items():
            if series_alias != list(SERIES_ALIASES.keys())[0]:
                print("Ожидание 1 секунда перед следующим запросом...")
                time.sleep(1)
            
            data = fetch_schedule_data(api_key, series_alias, year)
            if not data or 'events' not in data:
                continue

            for event in data['events']:
                if 'races' not in event:
                    continue
                    
                for race_data in event['races']:
                    # Создаем или обновляем запись гонки
                    race = Race(
                        id=race_data['id'],
                        name=race_data['name'],
                        status=race_data.get('status', 'scheduled'),
                        date=parse_datetime(race_data.get('scheduled')),
                        distance=float(race_data.get('distance', 0)),
                        track_id=event['track']['id']
                    )
                    
                    # Пытаемся получить существующую гонку
                    existing_race = session.get(Race, race_data['id'])
                    if existing_race:
                        # Обновляем только если новые данные не None
                        for key, value in race.__dict__.items():
                            if key != '_sa_instance_state' and value is not None:
                                setattr(existing_race, key, value)
                    else:
                        session.add(race)

                    # Создаем связь с серией
                    race_series = RaceSeries(
                        race_id=race_data['id'],
                        series_id=series_id
                    )
                    session.merge(race_series)

        session.commit()
        print("Данные о гонках успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данн��х: {e}")
        raise e
    finally:
        session.close()

if __name__ == "__main__":
    seed_races() 