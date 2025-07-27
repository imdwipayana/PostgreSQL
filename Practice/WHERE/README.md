# WHERE

WHERE statement can be used for retrieving data that follows certain criteria. In this example, the data source will be found in https://nssdc.gsfc.nasa.gov/planetary/factsheet/.
At first we need to create the table named planet_data.
```sql
DROP TABLE IF EXISTS planet_data;

CREATE TABLE planet_data(
planet_name VARCHAR(25) PRIMARY KEY,
mass FLOAT,
diameter FLOAT,
density FLOAT,
gravity FLOAT,
length_of_day FLOAT,
distance_from_sun FLOAT,
temperature FLOAT,
number_of_moon INTEGER,
ring_system VARCHAR(10)
);
```
Then input the values with syntax:
```sql
INSERT INTO planet_data
VALUES 
('Mercury', 0.33,  4879,   5429, 3.7,  4222.6, 57.9,  167,  0,   'No'),
('Venus',   4.87,  12104,  5243, 8.9,  2802,   108.2, 464,  0,   'No'),
('Earth',   5.97,  12756,  5514, 9.8,  24,     149.6, 15,   1,   'No'),
('Mars',    0.642, 6792,   3934, 3.7,  24.7,   228,   -65,  2,   'No'),
('Jupyter', 1898,  142984, 1326, 23.1, 9.9,    778.5, -110, 95,  'Yes'),
('Saturn',  568,   120536, 687,  9,    10.7,   1432,  -140, 274, 'Yes'),
('Uranus',  86.8,  51118,  1270, 8.7,  17.2,   2867,  -195, 28,  'Yes'),
('Neptune', 102,   49528,  1638, 11,   16.1,   4515,  -200, 16,  'Yes');

SELECT * FROM planet_data;
```
The planet_data table is
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/planet_data.png)

### 1. Find all planets that closer to the sun than the earth
```sql
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/planet_data.png)

