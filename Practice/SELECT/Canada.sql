--=================================================================================
-- DROP Canada_data table if it exists
--=================================================================================
DROP TABLE IF EXISTS Canada_data;

--=================================================================================
-- CREATE Canada_data table year 2021
--=================================================================================
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

--=================================================================================
-- INSERT player table value
--=================================================================================
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

--=================================================================================
-- Call the Canada_data table
--=================================================================================
SELECT * FROM Canada_data;

--=================================================================================
-- Count population density in column population_density (people/area)
--=================================================================================
SELECT
	province_teritory,
	population,
	areas,
	population / areas as population_density
FROM Canada_data

--=================================================================================
-- House and Senante representation
--=================================================================================
SELECT
	province_teritory,
	population,
	house,
	population/house as house_rep,
	senate,
	population/senate as senate_rep
FROM Canada_data

--=================================================================================
-- Population in 2020
-- NOTE that population2021 = population2020+population2020*growth_rate/100
-- So that population2020 = population2021/(1+(growth_rate/100))
--=================================================================================
SELECT
	province_teritory,
	population,
	growth_rate,
	population/(1+(growth_rate/100)) as population_2020
FROM Canada_data

--=================================================================================
-- Population province and teritory that have border with The USA
--=================================================================================
SELECT
	border_with_USA,
	SUM(population) as population_in_border
FROM Canada_data
GROUP BY border_with_USA

--=================================================================================
-- Calculation of total population by SUM aggregation function
--=================================================================================
SELECT 
	SUM(population) 
FROM Canada_data

--=================================================================================
-- Calculation of total population using SUM() window function
--=================================================================================
SELECT 
	province_teritory,
	population,
	SUM(population) OVER() as total_population
FROM Canada_data

--=================================================================================
-- Calculation of percentage population from total Canada's population using nested function.
--=================================================================================
SELECT
	*,
	(((population::decimal)*100/(total_population::decimal))::numeric(10,5)) as percentage_population
FROM (
	SELECT 
		province_teritory,
		population,
		SUM(population) OVER() as total_population
	FROM Canada_data
)

--=================================================================================
-- Checking the total percentage population is 100% by using double nested function
--=================================================================================
SELECT
	SUM(percentage_population) as total_percentage_population
FROM(
	SELECT
		*,
		(((population::decimal)*100/(total_population::decimal))::numeric(10,5)) as percentage_population
	FROM (
		SELECT 
			province_teritory,
			population,
			SUM(population) OVER() as total_population
		FROM Canada_data
)
)

--=================================================================================
-- Using SUM() window function to calculate the percentage of house and senate
--=================================================================================
SELECT
	province_teritory,
	house,
	SUM(house) OVER() as total_house_seat,
	senate,
	SUM(senate) OVER() as total_senate_seat
FROM Canada_data

--=================================================================================
-- Calculate percentage house and senate using nested function
--=================================================================================
SELECT
	province_teritory,
	house,
	((house::decimal/total_house_seat::decimal)*100)::numeric(10,5) as percentage_house,
	senate,
	((senate::decimal/total_senate_seat::decimal)*100)::numeric(10,5) as percentage_senate
FROM (
	SELECT
		province_teritory,
		house,
		SUM(house) OVER() as total_house_seat,
		senate,
		SUM(senate) OVER() as total_senate_seat
	FROM Canada_data
)

--=================================================================================
-- Checking wheter both of the total percentage are 100%
--=================================================================================
SELECT
	SUM(percentage_house)::numeric(10,2) as total_house_percentage,
	SUM(percentage_senate)::numeric(10,2) as total_senate_percentage
FROM (
	SELECT
		province_teritory,
		house,
		((house::decimal/total_house_seat::decimal)*100)::numeric(10,5) as percentage_house,
		senate,
		((senate::decimal/total_senate_seat::decimal)*100)::numeric(10,5) as percentage_senate
	FROM (
		SELECT
			province_teritory,
			house,
			SUM(house) OVER() as total_house_seat,
			senate,
			SUM(senate) OVER() as total_senate_seat
		FROM Canada_data
)
)