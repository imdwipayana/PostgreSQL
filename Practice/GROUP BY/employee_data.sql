--=================================================================================
-- DROP employee_data table if it exists
--=================================================================================
DROP TABLE IF EXISTS employee_data;

--=================================================================================
-- CREATE employee_data table 
--=================================================================================
CREATE TABLE employee_data(
employee_id VARCHAR(25) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
date_of_birth DATE,
hire_date DATE,
job_title VARCHAR(25),
salary FLOAT,
education VARCHAR(25)
);

--=================================================================================
-- INSERT employee_data table value
--=================================================================================
INSERT INTO employee_data
VALUES 
('M105', 'Bob',      'Smith',     '1990-09-25', '2020-01-18', 'Accountant', 80000, 'Bachelor'),
('M102', 'Anderson', 'Brown',     '1995-11-09', '2015-02-13', 'Manager',    90000, 'Magister'),
('M101', 'Cameron',  'Blake',     '1981-12-04', '2010-03-11', 'Manager',    85000, 'Bachelor'),
('M103', 'Bill',     'Martin',    '1988-01-02', '2015-04-15', 'Driver',     50000, 'High School'),
('M107', 'Roy',      'Nilson',    '2000-03-18', '2022-05-25', 'Auditor',    80000, 'Bachelor'),
('M106', 'Cash',     'Macdonald', '1997-04-27', '2021-06-27', 'Driver',     60000, 'High School'),
('M104', 'Clint',    'Gagnon',    '1992-07-11', '2018-07-21', 'Accountant', 75000, 'Bachelor'),
('F202', 'Annie',    'Bouchard',  '1987-02-13', '2020-08-03', 'Writer',     65000, 'High School'),
('F203', 'Elsa',     'Starship',  '1989-03-08', '2024-09-01', 'Auditor',    65000, 'Bachelor'),
('F201', 'Clara',    'Woodland',  '1988-04-29', '2019-10-04', 'Accountant', 70000, 'Bachelor'),
('M108', 'Carson',   'Palmer',    '1999-08-16', '2023-11-05', 'Auditor',    75000, 'Magister');

--=================================================================================
-- Call the employee_data table
--=================================================================================
SELECT * FROM employee_data;

--=================================================================================
-- 1. Find the average salary of every job title
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title

--=================================================================================
-- 2. Find the average salary based on level of education
--=================================================================================
SELECT 
	education,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY education

--=================================================================================
-- 3. Find the age average of every job title
--=================================================================================
-- First step: find the days from data of birth until now
SELECT
	*,
	CURRENT_DATE - date_of_birth as age_in_days
FROM employee_data

-- Second step: find the age average by using nested function from table of the first step above.
SELECT
	job_title,
	(AVG(age_in_days)::numeric(10,2)) as average_age
FROM (
SELECT
	*,
	CURRENT_DATE - date_of_birth as age_in_days
FROM employee_data
)
GROUP BY job_title

--=================================================================================
-- 4. Find all employee who born in 1995 or later
--=================================================================================

SELECT *
FROM employee_data
WHERE date_of_birth > '1995-01-01'

--=================================================================================
-- 5. Find the age of employee when they were hired (in days)
--=================================================================================

SELECT 
	first_name,
	last_name,
	date_of_birth,
	hire_date,
	(hire_date - date_of_birth) as age_hired_days
FROM employee_data

--=================================================================================
-- 6. Find the age of employee when they were hired (in months)
--=================================================================================

SELECT 
	first_name,
	last_name,
	date_of_birth,
	hire_date,
	(DATE_PART('YEAR',hire_date) - DATE_PART('YEAR', date_of_birth))*12 + 
	   (DATE_PART('MONTH',hire_date) - DATE_PART('MONTH', date_of_birth)) as age_hired_months
FROM employee_data

--=================================================================================
-- 7. Find the age of employee when they were hired (in years)
--=================================================================================
SELECT 
	first_name,
	last_name,
	date_of_birth,
	hire_date,
	DATE_PART('YEAR',hire_date) - DATE_PART('YEAR', date_of_birth) as age_hired_years
FROM employee_data

--=================================================================================
-- 8. Someone who was born before 1997 is called millenial and called gen z if they 
--    were born in 1997-2012. Based on this clasification, calculate the average 
--    salary of millenial and gen z from employee_table.
--=================================================================================
-- First step; divide the employee to be either millenial or gen z by using CASE
SELECT
	*,
	CASE
		WHEN date_of_birth < '1997-01-01' THEN 'Millenial'
		ELSE 'Gen Z'
	END as employee_categorical
FROM employee_data

-- Second step: use AVG() aggregate functions to calculate the average salary foe each category
SELECT
	employee_categorical,
	AVG(salary)::numeric(10,2) as average_salary
FROM (
SELECT
	*,
	CASE
		WHEN date_of_birth < '1997-01-01' THEN 'Millenial'
		ELSE 'Gen Z'
	END as employee_categorical
FROM employee_data
)
GROUP BY employee_categorical

--=================================================================================
-- 9. There are three level of employee based on years of experience. Junior level 
--    with less tan 5 years of work experience. Mid level with 5-10 years of experience. 
--    The rest is the senior level. Based on that category, find the average salary of 
--    every level of employee.
--=================================================================================
-- FIRST step: count the number of work experience in years.
SELECT 
	first_name,
	last_name,
	date_of_birth,
	hire_date,
	salary,
	DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as age_hired_years
FROM employee_data

-- Second step: Make category based on the work experience with CASE statement.
SELECT
	*,
	CASE 
		WHEN age_hired_years >= 10 THEN 'Senior'
		WHEN age_hired_years < 5 THEN 'Junior'
		ELSE 'Middle Level'
	END as level_employee
FROM(
	SELECT 
		first_name,
		last_name,
		date_of_birth,
		hire_date,
		salary,
		DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as age_hired_years
	FROM employee_data
)

-- Third step: Use nested function then AVG() agregate functions to calculate the average 
--             work experience of the employee category based on salary
SELECT
	level_employee,
	AVG(salary)::numeric(10,2) as average_salary
FROM (
	SELECT
	*,
	CASE 
		WHEN age_hired_years >= 10 THEN 'Senior'
		WHEN age_hired_years < 5 THEN 'Junior'
		ELSE 'Middle Level'
	END as level_employee
FROM(
SELECT 
	first_name,
	last_name,
	date_of_birth,
	hire_date,
	salary,
	DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as age_hired_years
FROM employee_data
)
)
GROUP BY level_employee

--=================================================================================
-- 10. There are 3 groups based on the salary: high, medium and low. The high 
--     earn employee is the one who earns more than 80000. Lower than 70000 
--     is considered as low earning. Meanwhile the rest is the medium. 
--     Find out the average of work experience in years for all 3 groups.
--=================================================================================
-- First step: Calculate the work experience in years (the same as the first step in previous problem).
--             Then use CASE to make categorical group based on salary.
SELECT 
	first_name,
	last_name,
	date_of_birth,
	hire_date,
	salary,
	DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as age_hired_years,
	CASE
		WHEN salary >= 80000 THEN 'High'
		WHEN salary < 70000 THEN 'Low'
		ELSE 'Middle'
	End as salary_category
FROM employee_data

-- Second step: Use nested function from the previous table to calculate the average 
--              experience of 3 group based on salary.
SELECT
	salary_category,
	AVG(age_hired_years)::numeric(10,2) as average_experience_years
FROM (
	SELECT 
		first_name,
		last_name,
		date_of_birth,
		hire_date,
		salary,
		DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as age_hired_years,
		CASE
			WHEN salary >= 80000 THEN 'High'
			WHEN salary < 70000 THEN 'Low'
			ELSE 'Middle'
		End as salary_category
	FROM employee_data
)
GROUP BY salary_category


