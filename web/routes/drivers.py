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
                # Получаем статистику чемпионата для текущего года
                stats = (
                    DriverChampionshipStats.query
                    .filter(
                        DriverChampionshipStats.driver_id == driver.id,
                    )
                    .first()
                )
                
                # Пропускаем гонщиков без статистики в текущем сезоне
                if not stats:
                    continue
                
                drivers_data.append({
                    'id': driver.id,
                    'name': driver.name,
                    'team': driver.team,
                    'series_id': s.id,
                    'series_name': s.name,
                    'points': stats.total_points,
                    'wins': stats.wins,
                    'poles': stats.poles,
                    'top5': stats.top5_finishes,
                    'top10': stats.top10_finishes,
                    'playoff_bonus': stats.playoff_bonus > 0
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
                'points': stats.total_points if stats else 0,
                'wins': stats.wins if stats else 0,
                'poles': stats.poles if stats else 0,
                'top5': stats.top5_finishes if stats else 0,
                'top10': stats.top10_finishes if stats else 0,
                'avg_start': float(stats.avg_start) if stats and stats.avg_start else 0.0,
                'avg_finish': float(stats.avg_finish) if stats and stats.avg_finish else 0.0,
                'playoff_eligible': stats.playoff_eligible if stats else False
            }
        })
    except Exception as e:
        print(f"Error in get_driver_details: {e}")
        return jsonify({'error': str(e)}), 400