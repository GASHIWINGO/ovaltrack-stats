from flask import Blueprint, render_template, jsonify
from db.models import Race, RacingSeries, Track, DriverRaceStats
from sqlalchemy import desc
from datetime import datetime

races = Blueprint('races', __name__)

@races.route('/races')
def index():
    try:
        # Получаем все серии для фильтра
        series = RacingSeries.query.all()
        
        # Добавляем первые гонки 2025 года
        upcoming_races = [
            {
                'id': '2025_clash',
                'date': datetime(2025, 2, 2, 20, 0),  # Примерная дата
                'name': 'Busch Light Clash at The Coliseum',
                'series': [{'id': 1, 'name': 'NASCAR Cup Series'}],
                'track': {'name': 'Los Angeles Memorial Coliseum'},
                'distance': 150,
                'status': 'scheduled'
            },
            {
                'id': '2025_daytona500',
                'date': datetime(2025, 2, 16, 20, 30),  # Примерная дата
                'name': 'Daytona 500',
                'series': [{'id': 1, 'name': 'NASCAR Cup Series'}],
                'track': {'name': 'Daytona International Speedway'},
                'distance': 500,
                'status': 'scheduled'
            },
            {
                'id': '2025_xfinity_daytona',
                'date': datetime(2025, 2, 15, 19, 0),  # Примерная дата
                'name': 'United Rentals 300',
                'series': [{'id': 2, 'name': 'NASCAR Xfinity Series'}],
                'track': {'name': 'Daytona International Speedway'},
                'distance': 300,
                'status': 'scheduled'
            },
            {
                'id': '2025_truck_daytona',
                'date': datetime(2025, 2, 14, 19, 30),  # Примерная дата
                'name': 'Fresh From Florida 250',
                'series': [{'id': 3, 'name': 'NASCAR Truck Series'}],
                'track': {'name': 'Daytona International Speedway'},
                'distance': 250,
                'status': 'scheduled'
            }
        ]
        
        # Получаем прошедшие гонки
        past_races = Race.query.filter(
            Race.date < datetime.now()
        ).order_by(desc(Race.date)).all()
        
        return render_template('races.html',
            series=series,
            upcoming_races=upcoming_races,
            past_races=past_races
        )
    except Exception as e:
        print(f"Error: {e}")
        return render_template('races.html', error=str(e))

@races.route('/race/<race_id>')
def get_race_details(race_id):
    try:
        # Для заглушек возвращаем только общую информацию
        if race_id.startswith('2025_'):
            race_data = next((r for r in [
                {
                    'id': '2025_clash',
                    'name': 'Busch Light Clash at The Coliseum',
                    'date': '02.02.2025',
                    'track': 'Los Angeles Memorial Coliseum',
                    'series': 'NASCAR Cup Series',
                    'distance': 150
                },
                {
                    'id': '2025_daytona500',
                    'name': 'Daytona 500',
                    'date': '16.02.2025',
                    'track': 'Daytona International Speedway',
                    'series': 'NASCAR Cup Series',
                    'distance': 500
                },
                {
                    'id': '2025_xfinity_daytona',
                    'name': 'United Rentals 300',
                    'date': '15.02.2025',
                    'track': 'Daytona International Speedway',
                    'series': 'NASCAR Xfinity Series',
                    'distance': 300
                },
                {
                    'id': '2025_truck_daytona',
                    'name': 'Fresh From Florida 250',
                    'date': '14.02.2025',
                    'track': 'Daytona International Speedway',
                    'series': 'NASCAR Truck Series',
                    'distance': 250
                }
            ] if r['id'] == race_id), None)
            
            if race_data:
                return jsonify({
                    'race': race_data,
                    'stats': []  # Пустой список для предстоящих гонок
                })
            
        # Для реальных гонок из БД
        race = Race.query.get_or_404(race_id)
        driver_stats = DriverRaceStats.query.filter_by(race_id=race_id).all()
        
        return jsonify({
            'race': {
                'name': race.name,
                'date': race.date.strftime('%d.%m.%Y'),
                'track': race.track.name if race.track else '-',
                'series': race.series[0].name if race.series else '-',
                'distance': race.distance
            },
            'stats': [{
                'position': stat.finish_position,
                'driver': stat.driver.name,
                'start': stat.start_position,
                'laps': stat.laps_completed,
                'points': stat.points,
                'pit_stops': stat.pit_stops,
                'best_lap': stat.best_lap_time
            } for stat in driver_stats]
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 400