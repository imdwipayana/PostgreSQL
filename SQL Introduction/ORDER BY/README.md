# ORDER BY
We will use employee dataset. At first we need to create the table and input all the data in it. Here is the syntax:
```sql
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


SELECT * FROM employee_data;
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/employee_data.png)

### 1. Order table based on salary

```sql
SELECT 
	*
FROM employee_data
ORDER BY salary
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number1.png)

### 2. Order table based on salary. Starting from the highest salary.

```sql
SELECT 
	*
FROM employee_data
ORDER BY salary DESC
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number2.png)

### 3. Order table based on date of birth starting from the youngest

```sql
SELECT 
	*
FROM employee_data
ORDER BY date_of_birth DESC
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number3.png)

### 4. Order table based on working experience 

```sql
SELECT 
	*
FROM employee_data
ORDER BY hire_date 
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number4.png)

### 5. Find the average salary of group of employee based on job title.

```sql
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
ORDER BY AVG(salary) 
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number5.png)

### 6. Find the average salary of group of employee based on job title. The highest first.

```sql
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
ORDER BY AVG(salary) DESC
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number6.png)

### 7. Find top three higest average salary based on job title

```sql
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY job_title
ORDER BY AVG(salary) DESC
LIMIT 3
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number7.png)

### 8. Top three average salary based on job title for millenial only

```sql
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE date_of_birth < '1997-01-01'
GROUP BY job_title
ORDER BY AVG(salary) DESC
LIMIT 3
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number8.png)

### 9. Find the average salary of millenial based on job_title where average salari bigger than 60000

```sql
SELECT 
	job_title,
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE date_of_birth < '1997-01-01'
GROUP BY job_title
HAVING AVG(salary) > 60000
ORDER BY AVG(salary) DESC
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number9.png)

### 10. Find data who is an accountant with the lowest salary.

First step: calculate the amount of least salary for accountant

```sql
SELECT 
	MIN(salary) as average_salary
FROM employee_data
WHERE job_title = 'Accountant'
ORDER BY MIN(salary)
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number10step1.png)

Second step: find the accountant using subquery

```sql
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
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/ORDER%20BY/image/number10step2.png)
