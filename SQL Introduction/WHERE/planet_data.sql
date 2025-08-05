--=================================================================================
-- DROP planet_data table if it exists
--=================================================================================
DROP TABLE IF EXISTS planet_data;

--=================================================================================
-- CREATE planet_data table 
--=================================================================================
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

--=================================================================================
-- INSERT planet_data table value
--=================================================================================
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

--=================================================================================
-- Call the planet_data table
--=================================================================================
SELECT * FROM planet_data;

--=================================================================================
-- 1. All planets that distance closer to the Sun than the Earth
--=================================================================================
SELECT 
	*
FROM planet_data
WHERE distance_from_sun < 149.6

--=================================================================================
-- 2. All planets that distance farther to the Sun than the Earth
--=================================================================================
SELECT 
	*
FROM planet_data
WHERE distance_from_sun > 149.6

--=================================================================================
-- 3. All planets that smaller than the Earth
--=================================================================================
SELECT 
	*
FROM planet_data
WHERE diameter < 12756
--=================================================================================
-- 4. All planets that bigger than the Earth
--=================================================================================
SELECT 
	*
FROM planet_data
WHERE diameter > 12756

--=================================================================================
-- 5. All planets that bigger than the Earth but smaller than the Saturn
--=================================================================================
SELECT 
	*
FROM planet_data
WHERE diameter > 12756 AND diameter < 120536

--=================================================================================
-- 6. All planets that bigger but colder than the Earth
--=================================================================================
SELECT 
	*
FROM planet_data
WHERE diameter > 12756 AND temperature < 15

--=================================================================================
-- 7. Find the biggest planet
--=================================================================================
SELECT 
	MAX(diameter) as biggest_planet
FROM planet_data

SELECT
	*
FROM planet_data
WHERE diameter = (SELECT 
					  MAX(diameter) as biggest_planet
				  FROM planet_data)
--=================================================================================
-- 8. Find the farthest planet
--=================================================================================
SELECT 
	MAX(distance_from_sun) as farthest_planet
FROM planet_data

SELECT
	*
FROM planet_data
WHERE distance_from_sun = (SELECT 
					          MAX(distance_from_sun) as farthest_planet
				           FROM planet_data)

--=================================================================================
-- 9. Find all planets that father from the sun than the smallest planet but closer to 
--    the Sun than the planet that has the most moon.
--=================================================================================
-- First step: Find the smallest diameter of the planets
SELECT 
	MIN(diameter) as smallest_planet
FROM planet_data

-- Second step: find the distance from the Sun of the smallest planet
SELECT
	distance_from_sun 
FROM planet_data
WHERE diameter = (SELECT 
				     MIN(diameter) as smallest_planet
				  FROM planet_data)

-- Third step: Find the number of most moon
SELECT
	MAX(number_of_moon) as most_moon
FROM planet_data

-- Fourth step: Find the distance from the sun of the planet that has the most moon
SELECT
	distance_from_sun 
FROM planet_data
WHERE number_of_moon = (SELECT
					       MAX(number_of_moon) as most_moon
						FROM planet_data)
						
-- Fifth step: Use nested function in WHERE statement.
SELECT
	*
FROM planet_data
WHERE distance_from_sun > (SELECT
						      distance_from_sun 
						   FROM planet_data
					       WHERE diameter = (SELECT 
				                                MIN(diameter) as smallest_planet
				                             FROM planet_data)) 
AND distance_from_sun < (SELECT
	                        distance_from_sun 
                         FROM planet_data
                         WHERE number_of_moon = (SELECT
					                                MAX(number_of_moon) as most_moon
						                         FROM planet_data))