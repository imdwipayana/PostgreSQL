# GROUP BY

Create employee_data table
```sql
DROP TABLE IF EXISTS employee_data;

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
```
Input all the data and call the table
```sql
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

SELECT * FROM employee_data;
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/GROUP%20BY/image/employee_data.png)

### 1. Find the average salary of every job title

```sql
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/GROUP%20BY/image/number1.png)

### 2. Find the average salary based on level of education

```sql
SELECT 
	education,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY education
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/GROUP%20BY/image/number2.png)

### 3. Find the age average of every job title

First step: find the days from data of birth until now

```sql
SELECT
	*,
	CURRENT_DATE - date_of_birth as age_in_days
FROM employee_data
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/GROUP%20BY/image/number3step1.png)

Second step: find the age average by using nested function from table of the first step above.

```sql
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
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/GROUP%20BY/image/number3step2.png)
