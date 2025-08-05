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
-- 1. Find the total of employee
--=================================================================================
SELECT
	COUNT(*) as total_employee
FROM employee_data

--=================================================================================
-- 2. Find the average salary of all the employees
--=================================================================================
SELECT
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data

--=================================================================================
-- 3. Find the highest salary of all employees
--=================================================================================
SELECT
	MAX(salary) as highest_salary
FROM employee_data

--=================================================================================
-- 4. Find the lowest salary of all employees
--=================================================================================
SELECT
	MIN(salary) as highest_salary
FROM employee_data

--=================================================================================
-- 5. Calculate the total salary of all the employees
--=================================================================================
SELECT
	SUM(salary) as total_salary
FROM employee_data

--=================================================================================
-- 6. Find the average salary for employee with education is Bachelor degree
--=================================================================================
-- First method: using WHERE statement
SELECT
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE education = 'Bachelor'

-- Second method: using HAVING statement (it is not recommended)
SELECT
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY education
HAVING education = 'Bachelor'

--=================================================================================
-- 7. Find the number of employee for each level of education
--=================================================================================
SELECT
	education,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY education

--=================================================================================
-- 8. Find out the majority of employee's education level.
--=================================================================================
-- First step: using GROUP BY statement and COUNT() aggregate function to find out the total of employee in every level of education
SELECT
	education,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY education

-- Second step: using ORDER BY statement with DESC to sort the number of employee from the highest to lowest in the groups. Then use LIMIT 1 to get the highest number of employees in the group.
SELECT
	education,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY education
ORDER BY COUNT(*) DESC
LIMIT 1

-- The same result if using the nested method like the following:
SELECT
	education,
	number_employee
FROM (SELECT
	     education,
	     COUNT(*) as number_employee
      FROM employee_data
      GROUP BY education
)
ORDER BY number_employee DESC
LIMIT 1







