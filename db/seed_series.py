from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from create_db import RacingSeries, Base

def seed_racing_series():
    # Создаем подключение к базе данных
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Session = sessionmaker(bind=engine)
    session = Session()

    # Список серий NASCAR
    series = [
        RacingSeries(id=1, name='Cup Series'),
        RacingSeries(id=2, name='Xfinity Series'),
        RacingSeries(id=3, name='Craftsman Truck Series')
    ]

    try:
        # Добавляем серии в базу данных
        session.add_all(series)
        session.commit()
        print("Гоночные серии успешно добавлены в базу данных")
    except Exception as e:
        session.rollback()
        print(f"Произошла ошибка при добавлении данных: {e}")
    finally:
        session.close()

if __name__ == "__main__":
    seed_racing_series() 