from web import db

# Промежуточные таблицы
driver_series = db.Table('driver_series',
    db.Column('driver_id', db.String, db.ForeignKey('driver.id'), primary_key=True),
    db.Column('series_id', db.Integer, db.ForeignKey('racing_series.id'), primary_key=True)
)

manufacturer_series = db.Table('manufacturer_series',
    db.Column('manufacturer_id', db.String, db.ForeignKey('manufacturer.id'), primary_key=True),
    db.Column('series_id', db.Integer, db.ForeignKey('racing_series.id'), primary_key=True)
)

race_series = db.Table('race_series',
    db.Column('race_id', db.String, db.ForeignKey('race.id'), primary_key=True),
    db.Column('series_id', db.Integer, db.ForeignKey('racing_series.id'), primary_key=True)
)

# Основные модели
class RacingSeries(db.Model):
    __tablename__ = 'racing_series'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String)
    
    drivers = db.relationship("Driver", secondary=driver_series, back_populates="series")
    manufacturers = db.relationship("Manufacturer", secondary=manufacturer_series, back_populates="series")
    races = db.relationship("Race", secondary=race_series, back_populates="series")

class Track(db.Model):
    __tablename__ = 'track'
    
    id = db.Column(db.String, primary_key=True)
    name = db.Column(db.String)
    location = db.Column(db.String)
    length = db.Column(db.Float)
    shape = db.Column(db.String)
    type = db.Column(db.String)
    
    races = db.relationship("Race", back_populates="track")

class Race(db.Model):
    __tablename__ = 'race'
    
    id = db.Column(db.String, primary_key=True)
    name = db.Column(db.String)
    status = db.Column(db.String)
    date = db.Column(db.DateTime)
    distance = db.Column(db.Float)
    track_id = db.Column(db.String, db.ForeignKey('track.id'))
    
    track = db.relationship("Track", back_populates="races")
    driver_stats = db.relationship("DriverRaceStats", back_populates="race")
    series = db.relationship("RacingSeries", secondary=race_series, back_populates="races")

class Driver(db.Model):
    __tablename__ = 'driver'
    
    id = db.Column(db.String, primary_key=True)
    name = db.Column(db.String)
    team = db.Column(db.String)
    birth_date = db.Column(db.Date)
    country = db.Column(db.String)
    twitter = db.Column(db.String)
    manufacturer_id = db.Column(db.String, db.ForeignKey('manufacturer.id'))
    
    championship_stats = db.relationship("DriverChampionshipStats", back_populates="driver", uselist=False)
    race_stats = db.relationship("DriverRaceStats", back_populates="driver")
    manufacturer = db.relationship("Manufacturer", back_populates="drivers")
    series = db.relationship("RacingSeries", secondary=driver_series, back_populates="drivers")

class DriverRaceStats(db.Model):
    __tablename__ = 'driver_race_stats'
    
    driver_id = db.Column(db.String, db.ForeignKey('driver.id'), primary_key=True)
    race_id = db.Column(db.String, db.ForeignKey('race.id'), primary_key=True)
    start_position = db.Column(db.Integer)
    finish_position = db.Column(db.Integer)
    points = db.Column(db.Integer)
    laps_completed = db.Column(db.Integer)
    pit_stops = db.Column(db.Integer)
    best_lap_time = db.Column(db.Float)
    
    driver = db.relationship("Driver", back_populates="race_stats")
    race = db.relationship("Race", back_populates="driver_stats")

class DriverChampionshipStats(db.Model):
    __tablename__ = 'driver_championship_stats'
    
    driver_id = db.Column(db.String, db.ForeignKey('driver.id'), primary_key=True)
    points = db.Column(db.Integer)
    playoff_eligible = db.Column(db.Boolean)
    avg_start = db.Column(db.Float)
    avg_finish = db.Column(db.Float)
    wins = db.Column(db.Integer)
    poles = db.Column(db.Integer)
    
    driver = db.relationship("Driver", back_populates="championship_stats")

class Manufacturer(db.Model):
    __tablename__ = 'manufacturer'
    
    id = db.Column(db.String, primary_key=True)
    name = db.Column(db.String)
    points = db.Column(db.Integer)
    wins = db.Column(db.Integer)
    
    drivers = db.relationship("Driver", back_populates="manufacturer")
    series = db.relationship("RacingSeries", secondary=manufacturer_series, back_populates="manufacturers")