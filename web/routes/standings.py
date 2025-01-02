from flask import Blueprint, render_template
from db.models import DriverChampionshipStats

standings = Blueprint('standings', __name__)

@standings.route('/standings')
def index():
    return render_template('standings.html')