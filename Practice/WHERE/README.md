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
SELECT 
	*
FROM planet_data
WHERE distance_from_sun < 149.6
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number1.png)

### 2. Find all planets that distance farther to the Sun than the Earth
```sql
SELECT 
	*
FROM planet_data
WHERE distance_from_sun > 149.6
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number2.png)

### 3. Find all planets that smaller than the Earth
```sql
SELECT 
	*
FROM planet_data
WHERE diameter < 12756
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number3.png)

### 4. Find all planets that bigger than the Earth
```sql
SELECT 
	*
FROM planet_data
WHERE diameter > 12756
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number4.png)

### 5. Find all planets that bigger than the Earth but smaller than the Saturn
```sql
SELECT 
	*
FROM planet_data
WHERE diameter > 12756 AND diameter < 120536
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number5.png)

### 6. Find all planets that bigger but colder than the Earth
```sql
SELECT 
	*
FROM planet_data
WHERE diameter > 12756 AND temperature < 15
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number6.png)

### 7. Find the biggest planet
First step: using MAX() aggregate function to find the longest diameter
```sql
SELECT 
	MAX(diameter) as biggest_planet
FROM planet_data;
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number7step1.png)
Second step: find the planet that has the longest diameter
```sql
SELECT
	*
FROM planet_data
WHERE diameter = (SELECT 
					  MAX(diameter) as biggest_planet
				  FROM planet_data);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WHERE/image/number7.png)
