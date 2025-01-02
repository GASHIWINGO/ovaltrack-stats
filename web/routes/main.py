from flask import Blueprint, render_template
from db.models import Race, Driver, DriverChampionshipStats, RacingSeries
from sqlalchemy import desc
from datetime import datetime

main = Blueprint('main', __name__)

@main.route('/')
def index():
    try:
        # Получаем ближайшие гонки
        upcoming_races = Race.query.filter(
            Race.date >= datetime.now()
        ).order_by(Race.date).limit(3).all()

        # Получаем последние результаты
        latest_results = Race.query.filter(
            Race.status == 'completed'
        ).order_by(desc(Race.date)).limit(3).all()

        # Получаем лидеров чемпионата по каждой серии
        championship_leaders = {}
        series = RacingSeries.query.all()
        
        for s in series:
            # Находим всех гонщиков этой серии
            drivers = Driver.query.join(Driver.series).filter(RacingSeries.id == s.id).all()
            # Получаем их статистику
            stats = []
            for driver in drivers:
                if driver.championship_stats:
                    stats.append(driver.championship_stats)
            # Сортируем по очкам
            stats.sort(key=lambda x: x.points if x.points else 0, reverse=True)
            championship_leaders[s.name] = stats[:5]  # Берем топ-5

        return render_template('index.html',
            upcoming_races=upcoming_races,
            latest_results=latest_results,
            championship_leaders=championship_leaders
        )
    except Exception as e:
        print(f"Error: {e}")
        return render_template('index.html', error=str(e))