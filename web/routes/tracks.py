from flask import Blueprint, render_template
from db.models import Track

tracks = Blueprint('tracks', __name__)

@tracks.route('/tracks')
def index():
    try:
        # Получаем все уникальные трассы
        tracks = Track.query.distinct().all()
        
        return render_template('tracks.html', tracks=tracks)
    except Exception as e:
        print(f"Error: {e}")
        return render_template('tracks.html', tracks=[], error=str(e)) 