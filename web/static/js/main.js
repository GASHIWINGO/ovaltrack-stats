document.addEventListener('DOMContentLoaded', function() {
    // Фильтрация по сериям
    const seriesButtons = document.querySelectorAll('.series-button');
    
    // Функция фильтрации строк по серии
    function filterBySeries(selectedSeries) {
        const rows = document.querySelectorAll('tr[data-series]');
        rows.forEach(row => {
            if (row.dataset.series === selectedSeries) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // Обработчик клика по кнопкам серий
    seriesButtons.forEach(button => {
        button.addEventListener('click', function() {
            seriesButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            filterBySeries(this.dataset.series);
        });
    });

    // Автоматически выбираем Cup Series при загрузке страницы
    const cupSeriesButton = Array.from(seriesButtons).find(button => 
        button.textContent.includes('Cup Series')
    );
    if (cupSeriesButton) {
        cupSeriesButton.classList.add('active');
        filterBySeries(cupSeriesButton.dataset.series);
    }

    // Обработка клика по строке с гонкой
    const raceRows = document.querySelectorAll('.race-row');
    if (raceRows.length > 0) {
        const raceModal = new bootstrap.Modal(document.getElementById('raceDetailsModal'));
        
        raceRows.forEach(row => {
            row.addEventListener('click', async function() {
                const raceId = this.dataset.raceId;
                try {
                    const response = await fetch(`/race/${raceId}`);
                    const data = await response.json();
                    
                    document.getElementById('raceName').textContent = data.race.name;
                    document.getElementById('raceDate').textContent = data.race.date;
                    document.getElementById('raceTrack').textContent = data.race.track;
                    document.getElementById('raceSeries').textContent = data.race.series;
                    document.getElementById('raceDistance').textContent = `${data.race.distance} миль`;
                    
                    const resultsTable = document.querySelector('#raceResultsTable');
                    if (data.stats && data.stats.length > 0) {
                        resultsTable.style.display = '';
                        const tbody = resultsTable.querySelector('tbody');
                        tbody.innerHTML = '';
                        data.stats.forEach(stat => {
                            tbody.innerHTML += `
                                <tr>
                                    <td>${stat.position}</td>
                                    <td>${stat.driver}</td>
                                    <td data-start="${stat.start}">${stat.start}</td>
                                    <td data-laps="${stat.laps}">${stat.laps}</td>
                                    <td data-points="${stat.points}">${stat.points}</td>
                                    <td data-pit_stops="${stat.pit_stops}">${stat.pit_stops}</td>
                                    <td data-best_lap="${stat.best_lap}">${stat.best_lap}</td>
                                </tr>
                            `;
                        });
                    } else {
                        resultsTable.style.display = 'none';
                    }
                    
                    raceModal.show();
                } catch (error) {
                    console.error('Error:', error);
                }
            });
        });
    }

    // Обработка клика по строке с гонщиком
    const driverRows = document.querySelectorAll('.driver-row');
    if (driverRows.length > 0) {
        const driverModal = new bootstrap.Modal(document.getElementById('driverDetailsModal'));
        
        driverRows.forEach(row => {
            row.addEventListener('click', async function() {
                const driverId = this.dataset.driverId;
                try {
                    const response = await fetch(`/driver/${driverId}`);
                    const data = await response.json();
                    
                    document.getElementById('driverName').textContent = data.driver.name;
                    document.getElementById('driverTeam').textContent = data.driver.team;
                    document.getElementById('driverSeries').textContent = data.driver.series.join(', ');
                    document.getElementById('driverPoints').textContent = data.stats.points;
                    document.getElementById('driverWins').textContent = data.stats.wins;
                    document.getElementById('driverPoles').textContent = data.stats.poles;
                    document.getElementById('driverTop5').textContent = data.stats.top5;
                    document.getElementById('driverTop10').textContent = data.stats.top10;
                    document.getElementById('driverAvgStart').textContent = data.stats.avg_start.toFixed(1);
                    document.getElementById('driverAvgFinish').textContent = data.stats.avg_finish.toFixed(1);
                    document.getElementById('driverPlayoff').textContent = data.stats.playoff_eligible ? 'Да' : 'Нет';
                    
                    const photoElement = document.getElementById('driverPhoto');
                    if (data.driver.photo_url) {
                        photoElement.src = data.driver.photo_url;
                        photoElement.style.display = '';
                    } else {
                        photoElement.style.display = 'none';
                    }
                    
                    driverModal.show();
                } catch (error) {
                    console.error('Error:', error);
                }
            });
        });
    }

    // Добавляем функционал сортировки
    const sortableHeaders = document.querySelectorAll('.sortable');
    let currentSort = {
        column: null,
        direction: 'asc'
    };

    // Функция сортировки таблицы
    function sortTable(header) {
        const table = header.closest('table');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr:not([style*="display: none"])'));
        const column = header.dataset.sort;
        const isNumeric = ['points', 'wins', 'poles', 'top5', 'top10'].includes(column);

        // Определяем направление сортировки
        let direction = 'asc';
        if (currentSort.column === column) {
            direction = currentSort.direction === 'asc' ? 'desc' : 'asc';
        }

        // Обновляем иконки сортировки
        sortableHeaders.forEach(h => {
            h.classList.remove('sorting-asc', 'sorting-desc');
        });
        header.classList.add(`sorting-${direction}`);

        // Сортируем строки
        rows.sort((a, b) => {
            const aValue = a.querySelector(`[data-${column}]`).dataset[column];
            const bValue = b.querySelector(`[data-${column}]`).dataset[column];

            if (isNumeric) {
                return direction === 'asc' 
                    ? Number(aValue) - Number(bValue)
                    : Number(bValue) - Number(aValue);
            } else {
                return direction === 'asc'
                    ? aValue.localeCompare(bValue)
                    : bValue.localeCompare(aValue);
            }
        });

        // Обновляем таблицу
        rows.forEach(row => tbody.appendChild(row));

        // Сохраняем текущую сортировку
        currentSort = { column, direction };
    }

    // Добавляем обработчики для заголовков
    sortableHeaders.forEach(header => {
        header.addEventListener('click', () => sortTable(header));
    });
});