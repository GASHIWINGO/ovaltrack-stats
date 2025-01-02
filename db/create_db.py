from sqlalchemy import create_engine, Column, Integer, String, Float, DateTime, Boolean, Date, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()

class DriverChampionshipStats(Base):
    __tablename__ = 'driver_championship_stats'
    
    driver_id = Column(String, ForeignKey('driver.id'), primary_key=True)
    points = Column(Integer)
    playoff_eligible = Column(Boolean)
    avg_start = Column(Float)
    avg_finish = Column(Float)
    wins = Column(Integer)
    poles = Column(Integer)
    
    # Отношения
    driver = relationship("Driver", back_populates="championship_stats")

class Driver(Base):
    __tablename__ = 'driver'
    
    id = Column(String, primary_key=True)
    name = Column(String)
    team = Column(String)
    birth_date = Column(Date)
    country = Column(String)
    twitter = Column(String)
    manufacturer_id = Column(String, ForeignKey('manufacturer.id'))
    
    # Отношения
    championship_stats = relationship("DriverChampionshipStats", back_populates="driver", uselist=False)
    race_stats = relationship("DriverRaceStats", back_populates="driver")
    manufacturer = relationship("Manufacturer", back_populates="drivers")
    series = relationship("RacingSeries", secondary="driver_series", back_populates="drivers")

class DriverRaceStats(Base):
    __tablename__ = 'driver_race_stats'
    
    driver_id = Column(String, ForeignKey('driver.id'), primary_key=True)
    race_id = Column(String, ForeignKey('race.id'), primary_key=True)
    start_position = Column(Integer)
    finish_position = Column(Integer)
    points = Column(Integer)
    laps_completed = Column(Integer)
    pit_stops = Column(Integer)
    best_lap_time = Column(Float)
    
    # Отношения
    driver = relationship("Driver", back_populates="race_stats")
    race = relationship("Race", back_populates="driver_stats")

class Manufacturer(Base):
    __tablename__ = 'manufacturer'
    
    id = Column(String, primary_key=True)
    name = Column(String)
    points = Column(Integer)
    wins = Column(Integer)
    
    # Отношения
    drivers = relationship("Driver", back_populates="manufacturer")
    series = relationship("RacingSeries", secondary="manufacturer_series", back_populates="manufacturers")

class Track(Base):
    __tablename__ = 'track'
    
    id = Column(String, primary_key=True)
    name = Column(String)
    location = Column(String)
    length = Column(Float)
    shape = Column(String)
    type = Column(String)
    
    # Отношения
    races = relationship("Race", back_populates="track")

class Race(Base):
    __tablename__ = 'race'
    
    id = Column(String, primary_key=True)
    name = Column(String)
    status = Column(String)
    date = Column(DateTime)
    distance = Column(Float)
    track_id = Column(String, ForeignKey('track.id'))
    
    # Отношения
    track = relationship("Track", back_populates="races")
    driver_stats = relationship("DriverRaceStats", back_populates="race")
    series = relationship("RacingSeries", secondary="race_series", back_populates="races")

class RacingSeries(Base):
    __tablename__ = 'racing_series'
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    
    # Отношения
    drivers = relationship("Driver", secondary="driver_series", back_populates="series")
    manufacturers = relationship("Manufacturer", secondary="manufacturer_series", back_populates="series")
    races = relationship("Race", secondary="race_series", back_populates="series")

# Таблицы для связей many-to-many
class DriverSeries(Base):
    __tablename__ = 'driver_series'
    
    driver_id = Column(String, ForeignKey('driver.id'), primary_key=True)
    series_id = Column(Integer, ForeignKey('racing_series.id'), primary_key=True)

class ManufacturerSeries(Base):
    __tablename__ = 'manufacturer_series'
    
    manufacturer_id = Column(String, ForeignKey('manufacturer.id'), primary_key=True)
    series_id = Column(Integer, ForeignKey('racing_series.id'), primary_key=True)

class RaceSeries(Base):
    __tablename__ = 'race_series'
    
    race_id = Column(String, ForeignKey('race.id'), primary_key=True)
    series_id = Column(Integer, ForeignKey('racing_series.id'), primary_key=True)

def create_tables():
    engine = create_engine('postgresql://postgres:123@localhost/nascar_stats')
    Base.metadata.create_all(engine)

if __name__ == "__main__":
    create_tables()