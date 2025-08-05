# AGGREGATE FUNCTIONS

There are some statement for agregate function. The most commons are:
#### 1. COUNT() to count the number of data.
#### 2. SUM() to count the total value.
#### 3. AVG() to count the average of data
#### 4. MAX() to find out the maximum in the data
#### 5. MIN() to find out the minimum in the data

Those statements are used with GROUP BY (HAVING) and ORDER BY. The WHERE statement can not be followed with aggregation function, instead we can utilize HAVING statement.

We will apply the employment data with the following syntax:

```sql
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
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/employee_data.png)


### 1. Find the total of employee
```sql
SELECT
	COUNT(*) as total_employee
FROM employee_data
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number1.png)

### 2. Find the average salary of all the employees
```sql
SELECT
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number2.png)

### 3. Find the highest salary of all employees
```sql
SELECT
	MAX(salary) as highest_salary
FROM employee_data
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number3.png)

### 4. Find the lowest salary of all employees
```sql
SELECT
	MIN(salary) as highest_salary
FROM employee_data
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number4.png)

### 5. Calculate the total salary of all the employees
```sql
SELECT
	SUM(salary) as total_salary
FROM employee_data
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number5.png)

### 6. Find the average salary for employee with education is Bachelor degree

First method: using WHERE statement
```sql
SELECT
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
WHERE education = 'Bachelor'
```
Second method: using HAVING statement (it is not recommended)
```sql
SELECT
	AVG(salary)::numeric(10,2) as average_salary
FROM employee_data
GROUP BY education
HAVING education = 'Bachelor'
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number6method1.png)

### 7. Find the number of employee for each level of education
```sql
SELECT
	education,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY education
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number7.png)

### 8. Find out the majority of employee's education level.

First step: using GROUP BY statement and COUNT() aggregate function to find out the total of employee in every level of education

```sql
SELECT
	education,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY education
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number8step1.png)


Second step: using ORDER BY statement with DESC to sort the number of employee from the highest to lowest in the groups. Then use LIMIT 1 to get the highest number of employees in the group.

```sql
SELECT
	education,
	COUNT(*) as number_employee
FROM employee_data
GROUP BY education
ORDER BY COUNT(*) DESC
LIMIT 1
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/AGGREGATE%20FUNCTIONS/image/number8step2.png)

The same result if using the nested method like the following:

```sql
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
```
