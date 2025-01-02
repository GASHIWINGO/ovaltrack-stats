from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from web.config import Config

# Создаем объект db глобально
db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # Инициализируем db с приложением
    db.init_app(app)
    
    # Импортируем модели
    from db.models import Race, Driver, DriverChampionshipStats
    
    # Регистрируем blueprints
    from web.routes.main import main
    from web.routes.races import races
    from web.routes.drivers import drivers
    from web.routes.standings import standings
    from web.routes.manufacturers import manufacturers
    from web.routes.tracks import tracks
    
    app.register_blueprint(main)
    app.register_blueprint(races)
    app.register_blueprint(drivers)
    app.register_blueprint(standings)
    app.register_blueprint(manufacturers)
    app.register_blueprint(tracks)

    return app