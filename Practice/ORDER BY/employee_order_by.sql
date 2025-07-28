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
-- 1. Order table based on salary
--=================================================================================
SELECT 
	*
FROM employee_data
ORDER BY salary

--=================================================================================
-- 2. Order table based on salary. Starting from the highest salary.
--=================================================================================
SELECT 
	*
FROM employee_data
ORDER BY salary DESC

--=================================================================================
-- 3. Order table based on date of birth starting from the youngest
--=================================================================================
SELECT 
	*
FROM employee_data
ORDER BY date_of_birth DESC

--=================================================================================
-- 4. Order table based on working experience 
--=================================================================================
SELECT 
	*
FROM employee_data
ORDER BY hire_date 

--=================================================================================
-- 5. Find the average salary of group of employee based on job title.
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
ORDER BY AVG(salary) 

--=================================================================================
-- 6. Find the average salary of group of employee based on job title. The highest first.
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
ORDER BY AVG(salary) DESC

--=================================================================================
-- 7. Find top three higest average salary based on job title
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
ORDER BY AVG(salary) DESC
LIMIT 3

--=================================================================================
-- 8. Top three average salary based on job title for millenial only
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE date_of_birth < '1997-01-01'
GROUP BY job_title
ORDER BY AVG(salary) DESC
LIMIT 3

--=================================================================================
-- 9. Find the average salary of millenial based on job_title where average salari bigger than 60000
--=================================================================================
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE date_of_birth < '1997-01-01'
GROUP BY job_title
HAVING AVG(salary) > 60000
ORDER BY AVG(salary) DESC

--=================================================================================
-- 10. Find data who is an accountant with the lowest salary.
--=================================================================================
-- First step: calculate the amount of least salary for accountant
SELECT 
	MIN(salary) as average_salary
FROM employee_data
WHERE job_title = 'Accountant'
ORDER BY MIN(salary)

-- Second step: find the accountant using subquery
SELECT
*
FROM employee_data
WHERE job_title = 'Accountant' 
	  AND salary = (SELECT 
						MIN(salary) as average_salary
					FROM employee_data
					WHERE job_title = 'Accountant'
					ORDER BY MIN(salary)
					)

