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
-- 1. Find all groups of employee based on job title that average salary higher than 70000
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
Having AVG(salary) > 70000

--=================================================================================
-- 2. Find out the number of employee for each category based on job title.
--=================================================================================
SELECT 
	job_title,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY job_title

--=================================================================================
-- 3. Find all the employee category based on job_title who has more than 1 member.
--=================================================================================
SELECT 
	job_title,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY job_title
HAVING COUNT(*) > 1

--=================================================================================
-- 4. Find the group of employee based on education that their average work experience is longer than 6 years.
--=================================================================================
-- First step: calculate the work experience as a new column work_exp_years
SELECT
	*,
	DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as work_exp_years
FROM employee_data

-- Second step: use aggregate function to aggregate the average of work_exp_years
SELECT
	education,
	AVG(work_exp_years)::numeric(10,2) as average_work_exp
FROM(
SELECT
	*,
	DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as work_exp_years
FROM employee_data
)
GROUP BY education

-- Third step: using having to give contrain for average work experience bigger than 6
SELECT
	education,
	AVG(work_exp_years)::numeric(10,2) as average_work_exp
FROM(
SELECT
	*,
	DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR', hire_date) as work_exp_years
FROM employee_data
)
GROUP BY education
HAVING AVG(work_exp_years) > 6

--=================================================================================
-- 5. In this example, WHERE and HAVING work interchangeably
--=================================================================================
-- First step: using WHERE statement
SELECT
	education,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE education = 'Bachelor' 
GROUP BY education

-- Second step: using HAVING statement
SELECT
	education,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY education
HAVING education = 'Bachelor'



