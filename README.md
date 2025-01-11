# NASCAR Stats Web Application

This is a web application built using Flask that provides statistics and information about NASCAR drivers, races, and manufacturers. The application allows users to view driver statistics, upcoming races, and more.

## Features

- View a list of NASCAR drivers and their statistics.
- Filter drivers by racing series.
- View detailed information about individual drivers.
- Display upcoming and past races with their results.
- Responsive design using Bootstrap for a better user experience.

## Technologies Used

- **Flask**: A lightweight WSGI web application framework for Python.
- **Flask-SQLAlchemy**: An extension for Flask that adds support for SQLAlchemy.
- **PostgreSQL**: A powerful, open-source object-relational database system.
- **Bootstrap**: A front-end framework for developing responsive and mobile-first websites.
- **JavaScript**: For dynamic content updates and interactivity.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/nascar-stats.git
   cd nascar-stats
   ```

2. Create a virtual environment:

   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```

3. Install the required packages:

   ```bash
   pip install -r requirements.txt
   ```

4. Set up the database:

   - Make sure you have PostgreSQL installed and running.
   - Create a database named `nascar_stats`.
   - Update the database URI in `web/config.py` if necessary.
   - Open a configuration file `config.py` in the `ovaltrack-stats/db/` directory and specify your API key and year:

     ```python
     API_KEY = "YOUR_API_KEY"  # Replace with your API key
     YEAR = "2024"  # Specify the desired year
     ```

5. Create and fill the database using the script:

   ```bash
   python ovaltrack-stats/db/run_all.py
   ```

6. Run the application:

   ```bash
   python run.py
   ```

7. Open your web browser and go to `http://127.0.0.1:5000` to view the application.

## Usage

- Navigate to the `/drivers` route to view the list of drivers.
- Click on a driver's name to see detailed statistics.
- Use the buttons to filter drivers by series.
- View upcoming and past races on their respective pages.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## Acknowledgments

- Thanks to the Flask community for their excellent documentation and support.
- Special thanks to the NASCAR community for providing the data and inspiration for this project.