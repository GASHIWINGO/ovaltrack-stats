from flask import Blueprint, render_template, jsonify
from db.models import Driver, RacingSeries, DriverChampionshipStats, DriverRaceStats, Race
from datetime import datetime
from sqlalchemy import func, extract

drivers = Blueprint('drivers', __name__)

@drivers.route('/drivers')
def index():
    try:
        series = RacingSeries.query.all()
        drivers_data = []
        current_year = datetime.now().year
        
        for s in series:
            # Получаем гонщиков основного состава серии
            primary_drivers = (
                Driver.query
                .join(Driver.series)
                .filter(RacingSeries.id == s.id)
                .all()
            )
            
            for driver in primary_drivers:
                # Получаем статистику только для текущей серии
                race_stats = (
                    DriverRaceStats.query
                    .join(Race, DriverRaceStats.race_id == Race.id)
                    .join(Race.series)
                    .filter(
                        DriverRaceStats.driver_id == driver.id,
                        RacingSeries.id == s.id,
                        extract('year', Race.date) == current_year
                    )
                    .all()
                )
                
                # Пропускаем гонщиков без гонок в текущем сезоне
                if not race_stats:
                    continue
                
                # Подсчитываем базовые очки
                base_points = sum(stat.points for stat in race_stats if stat.points is not None)
                
                # Добавляем плей-офф бонус (5000 для первых 8 и 2000 для следующих 8)
                playoff_bonus = 0
                if s.name == "NASCAR Cup Series" and base_points > 800:  # Примерный порог для плей-офф
                    if len([d for d in drivers_data if d['series_name'] == s.name]) < 8:
                        playoff_bonus = 5000
                    elif len([d for d in drivers_data if d['series_name'] == s.name]) < 16:
                        playoff_bonus = 2000
                
                total_points = base_points + playoff_bonus
                
                # Подсчитываем остальную статистику
                wins = sum(1 for stat in race_stats if stat.finish_position == 1)
                poles = sum(1 for stat in race_stats if stat.start_position == 1)
                top5_count = sum(1 for stat in race_stats if stat.finish_position <= 5)
                top10_count = sum(1 for stat in race_stats if stat.finish_position <= 10)
                
                drivers_data.append({
                    'id': driver.id,
                    'name': driver.name,
                    'team': driver.team,
                    'series_id': s.id,
                    'series_name': s.name,
                    'points': total_points,
                    'wins': wins,
                    'poles': poles,
                    'top5': top5_count,
                    'top10': top10_count,
                    'playoff_bonus': playoff_bonus > 0
                })
        
        # Сортируем по очкам
        drivers_data.sort(key=lambda x: x['points'], reverse=True)
        
        return render_template('drivers.html',
            series=series,
            drivers=drivers_data
        )
    except Exception as e:
        print(f"Error: {e}")
        return render_template('drivers.html', error=str(e))

@drivers.route('/driver/<driver_id>')
def get_driver_details(driver_id):
    try:
        driver = Driver.query.get_or_404(driver_id)
        stats = driver.championship_stats

        # Подсчитываем количество финишей в топ-5 и топ-10
        race_stats = DriverRaceStats.query.filter_by(driver_id=driver_id).all()
        top5_count = sum(1 for stat in race_stats if stat.finish_position <= 5)
        top10_count = sum(1 for stat in race_stats if stat.finish_position <= 10)

        # Словарь с URL фотографий гонщиков
        driver_photos = {
            'Kyle Larson': 'https://www.nascar.com/wp-content/uploads/sites/7/2021/11/18/kyle-larson-hero-image-2022.png',
            'Christopher Bell': 'https://www.nascar.com/wp-content/uploads/sites/7/2021/11/18/christopher-bell-hero-image-2022.png',
            'William Byron': 'https://www.nascar.com/wp-content/uploads/sites/7/2021/11/18/william-byron-hero-image-2022.png',
        }

        photo_url = driver_photos.get(driver.name)
        
        return jsonify({
            'driver': {
                'name': driver.name,
                'team': driver.team,
                'photo_url': photo_url,
                'series': [s.name for s in driver.series],
            },
            'stats': {
                'points': stats.points if stats else 0,
                'wins': stats.wins if stats else 0,
                'poles': stats.poles if stats else 0,
                'top5': top5_count,  # Используем подсчитанное значение
                'top10': top10_count,  # Используем подсчитанное значение
                'avg_start': float(stats.avg_start) if stats and stats.avg_start else 0.0,
                'avg_finish': float(stats.avg_finish) if stats and stats.avg_finish else 0.0,
                'playoff_eligible': stats.playoff_eligible if stats else False
            }
        })
    except Exception as e:
        print(f"Error in get_driver_details: {e}")
        return jsonify({'error': str(e)}), 400