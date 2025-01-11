import requests
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from create_db import Track, Base
from config import API_KEY

def fetch_tracks_data(api_key):
    url = f"https://api.sportradar.com/nascar-ot3/tracks/list.json?api_key={api_key}"
    headers = {"accept": "application/json"}
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при получении данных из API: {e}")
        return None

def seed_tracks(api_key = API_KEY):
    # Создаем подключение к базе данных
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    # Получаем данные о трассах
    tracks_data = fetch_tracks_data(api_key)
    if not tracks_data:
        return

    try:
        for track_data in tracks_data:
            track = Track(
                id=track_data['id'],
                name=track_data['name'],
                location=f"{track_data.get('city', '')}, {track_data.get('state', '')}, {track_data.get('country', '')}",
                length=float(track_data.get('distance', 0)),
                shape=track_data.get('shape', ''),
                type=track_data.get('track_type', '')
            )
            session.merge(track)  # Используем merge вместо add для обновления существующих записей
        
        session.commit()
        print("Данные о трассах успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данных: {e}")
    finally:
        session.close()

if __name__ == "__main__":
    seed_tracks() 