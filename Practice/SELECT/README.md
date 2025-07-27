# SELECT
Create tabel named Canada_data contains information about provinces and teritories in Canada with population and growth rate in 2021. Data can be found in https://en.wikipedia.org/wiki/Population_of_Canada_by_province_and_territory.

```sql
DROP TABLE IF EXISTS Canada_data;

CREATE TABLE Canada_data(
province_teritory VARCHAR(50) PRIMARY KEY,
capital VARCHAR(50),
population INTEGER,
growth_rate FLOAT,
areas FLOAT,
house INTEGER,
senate INTEGER,
border_with_USA VARCHAR(10)
);
```
Then input all the value of Canada_data table.
```sql
INSERT INTO Canada_data
VALUES 
('Yukon',                     'Whitehorse',     40232,    12.1, 474712.68,  1,   1,  'No'),
('British Columbia',          'Victoria',       5000879,  7.6,  922503.01,  43,  6,  'Yes'),
('Northwestern Teritories',   'Yellowknife',    41070,    -1.7, 1143793.86, 1,   1,  'No'),
('Alberta',                   'Edmonton',       4262635,  4.8,  640330.46,  37,  6,  'Yes'),
('Saskatchewan',              'Regina',         1132505,  3.1,  588243.54,  14,  6,  'Yes'),
('Nunavut',                   'Iqaluit',        36858,    2.5,  1877778.53, 1,   1,  'No'),
('Manitoba',                  'Winipeg',        1342153,  5,    552370.99,  14,  6,  'Yes'),
('Ontario',                   'Toronto',        14223942, 5.8,  908699.33,  122, 24, 'Yes'),
('Quebec',                    'Quebec City',    8501833,  4.1,  1356625.27, 78,  24, 'Yes'),
('New Brunswick',             'Fredericton',    775610,   3.8,  71388.81,   10,  10, 'Yes'),
('Newfoundland and Labrador', 'St. Johns',      510550,   -1.8, 370514.08,  7,   6,  'No'),
('Nova Scotia',               'Halifax',        969383,   5,    52942.27,   11,  10, 'No'),
('Prince Edward Island',      'Charlotte Town', 154331,   8,    5686.03,    4,   4,  'No');
```
Call the table with syntax:
```sql
SELECT * FROM Canada_data;
```
After that the Canada_data table is shown as:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/SELECT/image/Canada_data.png)

Count the population density by dividing the population with areas.
```sql
SELECT
	province_teritory,
	population,
	areas,
	population / areas as population_density
FROM Canada_data
```
Call the table with syntax:
```sql
SELECT * FROM Canada_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/SELECT/image/population_density.png)
