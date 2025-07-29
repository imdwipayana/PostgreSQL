--=================================================================================
-- DROP book_data table if it exists
--=================================================================================
DROP TABLE IF EXISTS book_data;

--=================================================================================
-- CREATE book_data table 
--=================================================================================
CREATE TABLE book_data(
book_id VARCHAR(10) PRIMARY KEY,
book_title VARCHAR(50),
genre VARCHAR(25),
in_stock INTEGER,
pages INTEGER,
price FLOAT
);

--=================================================================================
-- INSERT book_data table value
--=================================================================================
INSERT INTO book_data
VALUES 
('M101', 'The Who',            'Mystery',  15, 315, 100),
('T201', 'Back to Zero',       'Thriller', 20, 295, 400),
('C301', 'Kill Billy',         'Crime',    25, 415, 50),
('T202', 'What If',            'Thriller', 5,  394, 500),
('C302', 'The Killer',         'Crime',    40, 452, 100),
('M102', 'Unwanted',           'Mystery',  35, 512, 200),
('M103', 'Right or Wrong',     'Mystery',  15, 314, 300),
('C303', 'Stolen Soul',        'Crime',    20, 399, 150),
('T203', 'The Broken Promise', 'Thriller', 25, 418, 600),
('C304', 'The Culprit',        'Crime',    35, 550, 200);

--=================================================================================
-- Call the book_data table
--=================================================================================
SELECT * FROM book_data;

--=================================================================================
-- 1. Create a new column that contains the average price of the books
--=================================================================================
SELECT
	*,
	AVG(price) OVER() as average_price
FROM book_data

--=================================================================================
-- 2. Create a new column to inform the total books in stock
--=================================================================================
SELECT
	*,
	SUM(in_stock) OVER() as total_book
FROM book_data

--=================================================================================
-- 3. Create a new column that inform the most expensive book
--=================================================================================
SELECT
	*,
	MAX(price) OVER() as most_expensive
FROM book_data

--=================================================================================
-- 4. Create a new column with information of the cheapest book
--=================================================================================
SELECT
	*,
	MIN(price) OVER() as most_expensive
FROM book_data

--=================================================================================
-- 5. Create a new column with information about the number of book's titles available
--=================================================================================
SELECT
	*,
	COUNT(*) OVER() as book_title
FROM book_data

--=================================================================================
-- 6. 
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







