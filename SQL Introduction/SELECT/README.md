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
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/Canada_data.png)

Basically, the * symbol represents that all the column data will be represented. If we want just a certain column, we can type the name of columns to replace the * symbol. At last, we can create a new column by doing calculation of the other column, for example by dividing population to area to find out the population density.

Count the population density by dividing the population with areas.
```sql
SELECT
	province_teritory,
	population,
	areas,
	population / areas as population_density
FROM Canada_data
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/population_density.png)

After that, count the house and senate representation by dividing population with number of house and senate seat for each province and teritory.
```sql
SELECT
	province_teritory,
	population,
	house,
	population/house as house_rep,
	senate,
	population/senate as senate_rep
FROM Canada_data
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/house_senate_rep.png)

Count the population of the previous year by noticing the formula: population2021 = population2020+population2020*(growth_rate/100). It means the population2020 = population2021/(1+(growth_rate/100))
```sql
SELECT
	province_teritory,
	population,
	growth_rate,
	population/(1+(growth_rate/100)) as population_2020
FROM Canada_data
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/population_2020.png)

Lastly, we count the population of province and teritory that has border with the USA.
```sql
SELECT
	border_with_USA,
	SUM(population) as population_in_border
FROM Canada_data
GROUP BY border_with_USA
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/population_in_border.png)

We can see that the population in the provinces and teritories that has border with USA are almost 20 times with those without sharing border.

If we want to calculate the total population, the SUM() aggregate function can be used as the following syntax:
```sql
SELECT 
	SUM(population) 
FROM Canada_data
```
The result of that SUM() aggregation function is a number as shown as follow:


![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/sum_agg.png)

We can use SUM() window functions instead of the aggregation function. The different between those two results are aggregate function will give one number meanwhile window functions will create a new column with all of the column values are the total population.
```sql
SELECT 
	province_teritory,
	population,
	SUM(population) OVER() as total_population
FROM Canada_data
```
The result of that SUM() window functions can be seen in the following table:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/sum_window.png)
From here, we can see the benefit using window functions to calculate the percentage of population with the nested function from the previous table:
```sql
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
```
The population percentage table can be seen as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/percentage_population.png)
To make it sure, we can add all the percentage to make it 100% with the syntax:
```sql
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
```
The total percentage of population is exactly 100% as expected.


![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/total_percentage_population.png)

We can do the same ide to calculate the percentage of house and senate seats by calculating the total of house and senate seats with window function and then using nested function to find out the percentage of house and senate for each province and teritory.
```sql
SELECT
	province_teritory,
	house,
	SUM(house) OVER() as total_house_seat,
	senate,
	SUM(senate) OVER() as total_senate_seat
FROM Canada_data
```
The total house and senate seats are in the following table.
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/total_house_senate.png)

```sql
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
```
The percentage of house and senate seats for each province and teritory can be seen in the following table.
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/percentage_house_senate.png)

To check the total percentage (must be 100%), we can use the double nested function as follow:
```sql
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
```
The total percentage of house and senate seats are:


![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/SELECT/image/house_senate_100.png)


