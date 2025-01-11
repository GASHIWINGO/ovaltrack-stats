import requests
import time
from datetime import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from create_db import Driver, DriverSeries, Base
from config import API_KEY, YEAR 

SERIES_ALIASES = {
    'mc': 1,  # Cup Series ID
    'xf': 2,  # Xfinity Series ID
    'cw': 3   # Craftsman Truck Series ID
}

def fetch_drivers_data(api_key, series_alias, year, max_retries=3):
    url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/{year}/drivers/list.json"
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

def parse_date(date_str):
    if not date_str:
        return None
    try:
        return datetime.strptime(date_str, '%Y-%m-%d').date()
    except ValueError:
        return None

def get_manufacturer_id(driver_data, series_id):
    """Получаем ID производителя для конкретной серии"""
    if not driver_data.get('cars'):
        return None
    
    for car in driver_data['cars']:
        if 'manufacturer' in car:
            return f"{car['manufacturer']['id']}_{series_id}"
    return None

def get_team_name(driver_data):
    """Получаем название команды из данных о машине"""
    if not driver_data.get('cars'):
        return None
    
    for car in driver_data['cars']:
        if 'team' in car and 'name' in car['team']:
            return car['team']['name']
    return None

def seed_drivers(api_key=API_KEY, year=YEAR):
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    try:
        for series_alias, series_id in SERIES_ALIASES.items():
            if series_alias != list(SERIES_ALIASES.keys())[0]:
                print("Ожидание 1 секунда перед следующим запросом...")
                time.sleep(1)
            
            data = fetch_drivers_data(api_key, series_alias, year)
            if not data or 'drivers' not in data:
                continue

            for driver_data in data['drivers']:
                # Создаем или обновляем запись водителя
                driver = Driver(
                    id=driver_data['id'],
                    name=driver_data['full_name'],
                    birth_date=parse_date(driver_data.get('birthday')),
                    country=driver_data.get('country'),
                    manufacturer_id=get_manufacturer_id(driver_data, series_id),
                    team=get_team_name(driver_data),
                    twitter=driver_data.get('twitter')
                )
                
                # Пытаемся получить существующего водителя
                existing_driver = session.get(Driver, driver_data['id'])
                if existing_driver:
                    # Обновляем только если новые данные не None
                    for key, value in driver.__dict__.items():
                        if key != '_sa_instance_state' and value is not None:
                            setattr(existing_driver, key, value)
                else:
                    session.add(driver)

                # Создаем связь с серией
                driver_series = DriverSeries(
                    driver_id=driver_data['id'],
                    series_id=series_id
                )
                session.merge(driver_series)

        session.commit()
        print("Данные о гонщиках успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данных: {e}")
    finally:
        session.close()

if __name__ == "__main__":
    seed_drivers() 