from flask import Blueprint, render_template
from db.models import RacingSeries, Manufacturer
from sqlalchemy import func

manufacturers = Blueprint('manufacturers', __name__)

@manufacturers.route('/manufacturers')
def index():
    try:
        series = RacingSeries.query.all()
        manufacturers_by_series = {}
        
        for s in series:
            # Используем связь manufacturers из модели RacingSeries
            manufacturers = s.manufacturers
            manufacturers_by_series[s.name] = manufacturers
        
        return render_template('manufacturers.html',
            series=series,
            manufacturers_by_series=manufacturers_by_series
        )
    except Exception as e:
        print(f"Error: {e}")
        return render_template('manufacturers.html',
            series=series,
            manufacturers_by_series={},
            error=str(e)
        ) 