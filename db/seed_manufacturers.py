import requests
import time
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from create_db import Manufacturer, ManufacturerSeries, Base
from config import API_KEY, YEAR

SERIES_ALIASES = {
    'mc': 1,  # Cup Series ID
    'xf': 2,  # Xfinity Series ID
    'cw': 3   # Craftsman Truck Series ID
}

def fetch_manufacturer_data(api_key, series_alias, year, max_retries=3):
    url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/{year}/standings/manufacturers.json"
    params = {"api_key": api_key}
    
    for attempt in range(max_retries):
        try:
            response = requests.get(url, params=params)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            if response.status_code == 429:  # Too Many Requests
                wait_time = (attempt + 1) * 2  # Увеличиваем время ожидания с каждой попыткой
                print(f"Превышен лимит запросов. Ожидание {wait_time} секунд...")
                time.sleep(wait_time)
                continue
            print(f"Ошибка при получении данных из API для серии {series_alias}: {e}")
            return None
    
    print(f"Не удалось получить данные для серии {series_alias} после {max_retries} попыток")
    return None

def seed_manufacturers(api_key = API_KEY, year = YEAR):
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    try:
        # Получаем данные для каждой серии
        for series_alias, series_id in SERIES_ALIASES.items():
            # Добавляем задержку между запросами к разным сериям
            if series_alias != list(SERIES_ALIASES.keys())[0]:  # Пропускаем задержку для первого запроса
                print("Ожидание 1 секунда перед следующим запросом...")
                time.sleep(1)
            
            data = fetch_manufacturer_data(api_key, series_alias, year)
            if not data or 'manufacturers' not in data:
                continue

            for mfr_data in data['manufacturers']:
                # Создаем уникальный ID для производителя в каждой серии
                series_specific_id = f"{mfr_data['id']}_{series_id}"
                
                # Создаем или обновляем производителя
                manufacturer = Manufacturer(
                    id=series_specific_id,
                    name=mfr_data['name'],
                    points=mfr_data.get('points', 0),
                    wins=mfr_data.get('wins', 0)
                )
                session.merge(manufacturer)

                # Создаем связь с серией
                manufacturer_series = ManufacturerSeries(
                    manufacturer_id=series_specific_id,
                    series_id=series_id
                )
                session.merge(manufacturer_series)

        session.commit()
        print("Данные о производителях успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данных: {e}")
    finally:
        session.close()

if __name__ == "__main__":
    seed_manufacturers()