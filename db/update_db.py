# NASCARStats/db/update_db.py

import requests
import time
from datetime import datetime, timedelta
from sqlalchemy import create_engine, select, func, extract, distinct
from sqlalchemy.orm import sessionmaker
import logging
from create_db import Race, DriverRaceStats, DriverChampionshipStats, RacingSeries, Driver
from config import API_KEY 

logging.basicConfig(
    filename='nascar_updates.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class NASCARDatabaseUpdater:
    def __init__(self, api_key = API_KEY):
        self.api_key = api_key
        self.engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
        self.Session = sessionmaker(bind=self.engine)
        self.series_aliases = {
            'mc': 1,  # Cup Series ID
            'xf': 2,  # Xfinity Series ID
            'cw': 3   # Craftsman Truck Series ID
        }

    def check_daily_changes(self, date=None):
        """Проверяет изменения за указанную дату"""
        if date is None:
            date = datetime.now()

        url = f"https://api.sportradar.com/nascar-ot3/{date.year}/{date.strftime('%m')}/{date.strftime('%d')}/changes.json"
        response = self.make_api_request(url)
        
        if not response:
            return None

        return self.process_changes(response)

    def process_changes(self, changes_data):
        """Обрабатывает полученные изменения"""
        updates = {
            'races': [],
            'drivers': [],
            'standings': []
        }

        if 'races' in changes_data:
            for race in changes_data['races']:
                updates['races'].append({
                    'id': race['id'],
                    'last_modified': race['last_modified']
                })

        if 'standings' in changes_data:
            for standing in changes_data.get('standings', []):
                if 'drivers' in standing:
                    for driver in standing['drivers']:
                        updates['standings'].append({
                            'driver_id': driver['id'],
                            'last_modified': driver['last_modified']
                        })

        return updates
       
    def update_race_data(self, race_id, series_alias):
        """Обновляет данные конкретной гонки"""
        url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/races/{race_id}/results.json"
        race_data = self.make_api_request(url)
        
        if not race_data:
            return False

        session = self.Session()
        try:
            # Обновляем статус гонки
            race = session.query(Race).filter_by(id=race_id).first()
            if race:
                race.status = race_data.get('status', race.status)
                
            # Обновляем статистику гонщиков
            for result in race_data.get('results', []):
                stats = DriverRaceStats(
                    driver_id=result['driver']['id'],
                    race_id=race_id,
                    start_position=result.get('start_position', 0),
                    finish_position=result.get('position', 0),
                    points=result.get('points', 0),
                    laps_completed=result.get('laps_completed', 0),
                    pit_stops=len(result.get('pit_stops', [])),
                    best_lap_time=float(result.get('best_lap_time', 0))
                )
                session.merge(stats)

            session.commit()
            logging.info(f"Успешно обновлены данные гонки {race_id}")
            return True
        except Exception as e:
            session.rollback()
            logging.error(f"Ошибка при обновлении гонки {race_id}: {str(e)}")
            return False
        finally:
            session.close()
           
    def calculate_championship_stats(self, session, driver_id, series_id, year):
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

            if drivers_count < 8:
                playoff_bonus = 5000
            elif drivers_count < 16:
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
    
    def update_championship_stats(self, session, series_alias, year):
        """Обновляет статистику чемпионата для всех гонщиков в заданной серии."""
        series_id = self.series_aliases[series_alias]
        
        # Получаем всех гонщиков в заданной серии
        stmt_drivers = select(Driver.id).join(Driver.series).where(RacingSeries.id == series_id)
        driver_ids = [driver_id for driver_id, in session.execute(stmt_drivers).all()]
        
        for driver_id in driver_ids:
            # Рассчитываем статистику для каждого гонщика
            stats = self.calculate_championship_stats(session, driver_id, series_id, year)
            
            # Получаем существующую запись статистики чемпионата
            championship_stats = session.query(DriverChampionshipStats).filter_by(driver_id=driver_id).first()
            
            if championship_stats:
                # Обновляем существующую запись
                championship_stats.base_points = stats['base_points']
                championship_stats.playoff_bonus = stats['playoff_bonus']
                championship_stats.total_points = stats['total_points']
                championship_stats.wins = stats['wins']
                championship_stats.poles = stats['poles']
                championship_stats.top5_finishes = stats['top5_finishes']
                championship_stats.top10_finishes = stats['top10_finishes']
                session.commit()
                logging.info(f"Обновлена статистика чемпионата для гонщика {driver_id} в серии {series_alias}")
            else:
                logging.warning(f"Не найдена запись статистики чемпионата для гонщика {driver_id} в серии {series_alias}")

    def run_daily_update(self):
        """Запускает ежедневное обновление данных"""
        session = self.Session()
        try:
            print("Ежедневное обновление начато")
            logging.info("Ежедневное обновление начато")

            # Проверяем изменения за последние 2 дня
            for i in range(2):
                date = datetime.now() - timedelta(days=i)
                changes_data = self.check_daily_changes(date)
                
                if changes_data:
                    self.process_changes(changes_data)

            # Обновляем статистику чемпионата для каждой серии
            for series_alias in self.series_aliases:
                self.update_championship_stats(session, series_alias, 2024)

            print("Ежедневное обновление завершено")
            logging.info("Ежедневное обновление завершено")
        except Exception as e:
            logging.error(f"Ошибка при обновлении данных: {e}")
            print(f"Произошла ошибка: {e}")
        finally:
            session.close()

if __name__ == "__main__":
    updater = NASCARDatabaseUpdater()
    updater.run_daily_update()