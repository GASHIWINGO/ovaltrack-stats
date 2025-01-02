class Config:
    SECRET_KEY = 'your-secret-key'  # для безопасности в продакшене использовать env
    SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:123@localhost/nascar_stats'
    SQLALCHEMY_TRACK_MODIFICATIONS = False