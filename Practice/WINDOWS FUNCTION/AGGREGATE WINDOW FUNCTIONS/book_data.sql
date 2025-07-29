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
FROM book_data;

--=================================================================================
-- 2. Create a new column to inform the total books in stock
--=================================================================================
SELECT
	*,
	SUM(in_stock) OVER() as total_book
FROM book_data;

--=================================================================================
-- 3. Create a new column that inform the most expensive book
--=================================================================================
SELECT
	*,
	MAX(price) OVER() as most_expensive
FROM book_data;

--=================================================================================
-- 4. Create a new column with information of the cheapest book
--=================================================================================
SELECT
	*,
	MIN(price) OVER() as most_expensive
FROM book_data;

--=================================================================================
-- 5. Create a new column with information about the number of book's titles available
--=================================================================================
SELECT
	*,
	COUNT(*) OVER() as book_title
FROM book_data;

--=================================================================================
-- 6. Create a new table with information of the average price of book based on genre
--=================================================================================
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre) as average_price
FROM book_data;

--=================================================================================
-- 7. Create a new table with information of the average price of book based on genre. Put the most pages on top for each category.
--=================================================================================
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC)::numeric(10,2) as average_price
FROM book_data;

-- The result is a little bit weird. The pages column is sorted for each category, but the average price result based the row data and the preceeding data in the same category (this is the default from frame clause which is ROWS BETWEEN CURRENT ROW AND UNBOUNDED PRECEEDING). For further understanting, look for frame clause in window functions
-- I myself still learning when the ORDER BY in aggregate window function supposed to be applied in the real problem.
--=================================================================================
-- 8. Example of aggregate window function with frame clause
--=================================================================================
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC
	   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)::numeric(10,2) as average_price
FROM book_data;
-- The result is the same with the previous one.
--=================================================================================
-- 9. Example of aggregate window function with frame clause
--=================================================================================
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC
	   ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)::numeric(10,2) as average_price_now_next_book
FROM book_data;

--=================================================================================
-- 10. Example of aggregate window function with frame clause
--=================================================================================
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC
	   ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)::numeric(10,2) as average_price_now_next_two_books
FROM book_data;

--=================================================================================
-- 11. Example of aggregate window function with frame clause
--=================================================================================
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC
	   ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)::numeric(10,2) as two_days_moving_average
FROM book_data;

-- The ROWS statement in here can be used to calculate moving average in time series data.

--=================================================================================
-- 12. The following two syntaxs using RANGE give the qustion result?
--=================================================================================
-- Part one:
SELECT
	*,
	AVG(pages) OVER(PARTITION BY genre ORDER BY price DESC
	   RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING)::numeric(10,2) as total_pages
FROM book_data;

-- Part two:
SELECT
	*,
	SUM(pages) OVER(PARTITION BY genre ORDER BY price DESC
	   RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING)::numeric(10,2) as total_pages
FROM book_data;

--=================================================================================
-- 13. Use COUNT() windows function to detect NULL
--=================================================================================
-- Create a new table named book_duplicate that contain NULL and duplicate data.
CREATE TABLE book_duplicate(
book_id VARCHAR(10),
book_title VARCHAR(50),
genre VARCHAR(25),
in_stock INTEGER,
pages INTEGER,
price FLOAT
);

INSERT INTO book_duplicate(book_id, book_title, genre, in_stock, pages, price)
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
('C304', 'The Culprit',        'Crime',    35, 550, 200),
('C304', 'The Culprit',        'Crime',    35, 550, 200),
('T203', 'The Broken Promise', 'Thriller', 25, 418, 600),
('T203', 'The Broken Promise', 'Thriller', 25, 418, 600),
(NULL,   'Me and You',         'Crime',    35, 550, 200);

SELECT * FROM book_duplicate;

-- Using COUNT() window functions to detect the NULL value:
SELECT
	book_id,
	COUNT(*) OVER() as number_title,
	COUNT(book_id) OVER () as no_null
FROM book_duplicate;

--=================================================================================
-- 14. Use COUNT() windows function to detect data duplicate
--=================================================================================
SELECT 
	book_id,
	COUNT(*) OVER(PARTITION BY book_id) as number_repetitive
FROM book_data;

-- The following syntax looks like has the same result, but if there is NULL data in book_id column, then the result will be different.
SELECT 
	book_id,
	COUNT(book_id) OVER(PARTITION BY book_id) as number_repetitive
FROM book_data;

-- Based on the previous problem, the different must be clear. Try use the same syntax in book_duplicate table
SELECT 
	book_id,
	COUNT(*) OVER(PARTITION BY book_id) as number_repetitive
FROM book_duplicate;

-- If the number of repetitive is more than 1, it means there must be duplication.
SELECT
	*
FROM (SELECT 
	     book_id,
	  COUNT(*) OVER(PARTITION BY book_id) as number_repetitive
      FROM book_duplicate
)
WHERE number_repetitive >1;

-- Finding the unique book_id that has duplicate:
SELECT
	DISTINCT(book_id),
	number_repetitive
FROM (SELECT 
	     book_id,
	  COUNT(*) OVER(PARTITION BY book_id) as number_repetitive
      FROM book_duplicate
)
WHERE number_repetitive >1;