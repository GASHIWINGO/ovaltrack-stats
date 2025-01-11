from create_db import create_tables  # Импортируем функцию для создания таблиц
from seed_tracks import seed_tracks
from seed_series import seed_racing_series
from seed_manufacturers import seed_manufacturers
from seed_drivers import seed_drivers
from seed_races import seed_races
from seed_race_stats import seed_race_stats
from seed_championship_stats import seed_championship_stats

def main():
    print("Создание таблиц в базе данных...")
    create_tables()  # Создаем таблицы и связи между ними
    
    print("Запуск заполнения базы данных NASCAR...")
    
    # Заполнение базы данных в правильном порядке
    seed_tracks()  # Заполнение данных о трассах
    seed_racing_series()  # Заполнение данных о гоночных сериях
    seed_manufacturers()  # Заполнение данных о производителях
    seed_drivers()  # Заполнение данных о гонщиках
    seed_races()  # Заполнение данных о гонках
    seed_race_stats()  # Заполнение статистики гонок
    seed_championship_stats()  # Заполнение статистики чемпионата

    print("Заполнение базы данных завершено.")

if __name__ == "__main__":
    main() 