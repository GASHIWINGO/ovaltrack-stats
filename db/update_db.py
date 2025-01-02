# NASCARStats/db/update_db.py

import requests
import time
from datetime import datetime, timedelta
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import logging
from create_db import Race, DriverRaceStats, DriverChampionshipStats

logging.basicConfig(
    filename='nascar_updates.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class NASCARDatabaseUpdater:
    def __init__(self, api_key):
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

    def update_championship_stats(self, series_alias):
        """Обновляет статистику чемпионата"""
        url = f"https://api.sportradar.com/nascar-ot3/{series_alias}/2024/standings/drivers.json"
        standings_data = self.make_api_request(url)
        
        if not standings_data:
            return False

        session = self.Session()
        try:
            for driver_data in standings_data.get('drivers', []):
                stats = DriverChampionshipStats(
                    driver_id=driver_data['id'],
                    points=driver_data.get('points', 0),
                    playoff_eligible=driver_data.get('in_chase', False),
                    avg_start=float(driver_data.get('avg_start_position', 0)),
                    avg_finish=float(driver_data.get('avg_finish_position', 0)),
                    wins=driver_data.get('wins', 0),
                    poles=driver_data.get('poles', 0)
                )
                session.merge(stats)

            session.commit()
            logging.info(f"Успешно обновлена статистика чемпионата для серии {series_alias}")
            return True
        except Exception as e:
            session.rollback()
            logging.error(f"Ошибка при обновлении статистики чемпионата: {str(e)}")
            return False
        finally:
            session.close()

    def make_api_request(self, url, max_retries=3):
        """Выполняет запрос к API с обработкой ошибок"""
        params = {"api_key": self.api_key}
        
        for attempt in range(max_retries):
            try:
                response = requests.get(url, params=params)
                response.raise_for_status()
                return response.json()
            except requests.exceptions.RequestException as e:
                if response.status_code == 429:  # Rate limit
                    wait_time = (attempt + 1) * 2
                    logging.warning(f"Превышен лимит запросов. Ожидание {wait_time} секунд...")
                    time.sleep(wait_time)
                    continue
                logging.error(f"Ошибка API запроса: {str(e)}")
                return None
        return None

    def run_daily_update(self):
        """Запускает ежедневное обновление данных"""
        print("\nНачало ежедневного обновления...")
        
        changes = self.check_daily_changes()
        if not changes:
            print("Нет новых изменений в данных")
            return

        print("\nНайдены изменения:")
        
        # Отслеживаем изменения в таблицах
        updates_log = {
            'Race': [],
            'DriverRaceStats': [],
            'DriverChampionshipStats': []
        }

        if changes.get('races'):
            print(f"\nГонки для обновления: {len(changes['races'])}")
            for race in changes['races']:
                print(f"\n- ID гонки: {race['id']}")
                for series_alias in self.series_aliases:
                    print(f"  Серия {series_alias}:")
                    race_data = self.make_api_request(
                        f"https://api.sportradar.com/nascar-ot3/{series_alias}/races/{race['id']}/results.json"
                    )
                    
                    if race_data:
                        # Отслеживаем изменения в Race
                        if race_data.get('status'):
                            updates_log['Race'].append({
                                'race_id': race['id'],
                                'field': 'status',
                                'new_value': race_data['status']
                            })
                            print(f"    ✓ Обновлен статус гонки: {race_data['status']}")

                        # Отслеживаем изменения в DriverRaceStats
                        for result in race_data.get('results', []):
                            updates_log['DriverRaceStats'].append({
                                'race_id': race['id'],
                                'driver_id': result['driver']['id'],
                                'fields': {
                                    'position': result.get('position'),
                                    'points': result.get('points'),
                                    'laps_completed': result.get('laps_completed')
                                }
                            })
                            print(f"    ✓ Обновлена статистика гонщика {result['driver']['full_name']}")

        print("\nОбновление статистики чемпионата:")
        for series_alias in self.series_aliases:
            print(f"\n- Серия {series_alias}:")
            standings_data = self.make_api_request(
                f"https://api.sportradar.com/nascar-ot3/{series_alias}/2024/standings/drivers.json"
            )
            
            if standings_data:
                for driver in standings_data.get('drivers', []):
                    updates_log['DriverChampionshipStats'].append({
                        'driver_id': driver['id'],
                        'fields': {
                            'points': driver.get('points'),
                            'wins': driver.get('wins'),
                            'playoff_eligible': driver.get('in_chase')
                        }
                    })
                    print(f"  ✓ Обновлена статистика чемпионата для {driver['full_name']}")

        print("\nСводка обновлений:")
        print(f"- Обновлено гонок: {len(updates_log['Race'])}")
        print(f"- Обновлено записей статистики гонок: {len(updates_log['DriverRaceStats'])}")
        print(f"- Обновлено записей статистики чемпионата: {len(updates_log['DriverChampionshipStats'])}")
        
        print("\nЕжедневное обновление завершено")

if __name__ == "__main__":
    API_KEY = "62squzqJVdEnljubRtjFR3BlQfnY4F2ign8oiVmE"
    updater = NASCARDatabaseUpdater(API_KEY)
    updater.run_daily_update()