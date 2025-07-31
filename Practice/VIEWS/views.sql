--=================================================================================
-- DROP book_data_sold table if it exists
--=================================================================================
DROP TABLE IF EXISTS book_data_sold;

--=================================================================================
-- CREATE book_data_sold table 
--=================================================================================
CREATE TABLE book_data_sold(
book_id VARCHAR(10) PRIMARY KEY,
book_title VARCHAR(50),
genre VARCHAR(25),
in_stock INTEGER,
number_sold INTEGER,
pages INTEGER,
price FLOAT
);

--=================================================================================
-- INSERT book_data_sold table value
--=================================================================================
INSERT INTO book_data_sold
VALUES 
('M101', 'The Who',            'Mystery',  15, 75,  315, 100),
('T201', 'Back to Zero',       'Thriller', 20, 50,  295, 400),
('C301', 'Kill Billy',         'Crime',    25, 100, 415, 50),
('T202', 'What If',            'Thriller', 5,  50,  394, 500),
('C302', 'The Killer',         'Crime',    40, 75,  452, 100),
('M102', 'Unwanted',           'Mystery',  35, 100, 512, 200),
('M103', 'Right or Wrong',     'Mystery',  15, 50,  314, 300),
('C303', 'Stolen Soul',        'Crime',    20, 25,  399, 150),
('T203', 'The Broken Promise', 'Thriller', 25, 25,  418, 600),
('C304', 'The Culprit',        'Crime',    35, 100, 550, 200);

--=================================================================================
-- Call the book_data table
--=================================================================================
SELECT * FROM book_data_sold;

--=================================================================================
-- 1. FIND the book total sales of all books.
--=================================================================================
-- First method: using subquery. 
---- First step: calculate the total sales of each book by multiplying number_sold column with price.
SELECT
	*,
	number_sold*price as sales
FROM book_data_sold
---- Second step: using SUM() for column sales to find out the total sales.
SELECT
	SUM(sales) as total_sales
FROM (SELECT
	     *,
	     number_sold*price as sales
      FROM book_data_sold
)

-- Second method: using Common Table Expression (CTE)
with CTE_sales as (
	SELECT
		*,
		number_sold*price as sales
	FROM book_data_sold
)

SELECT
	SUM(sales) as total_sales
FROM CTE_sales

--=================================================================================
-- 2. with CTE, find all the most expensive book for each genre
--=================================================================================
with CTE_expensive_genre as (
	SELECT
		*,
		RANK() OVER(PARTITION BY genre ORDER BY price DESC) as price_category
	FROM book_data_sold
)

SELECT
	*
FROM CTE_expensive_genre
WHERE price_category = 1

--=================================================================================
-- 3. Create a new category based on the price. The book that higher than the average price is expensive. Menwhile, if it is less than the average then it is cheap.
--=================================================================================
with CTE_book_average as (
	SELECT 
		*,
		AVG(price) OVER() as price_average
	FROM book_data_sold
)

SELECT
	*,
	CASE
		WHEN price < price_average THEN 'cheap'
		ELSE 'expensive'
	END as price_category
FROM CTE_book_average
ORDER BY price

--=================================================================================
-- 4. Compare the previous result when we use NTILE() instead.
--=================================================================================
with CTE_group_ntile as (
	SELECT
		*,
		NTILE(2) OVER(ORDER BY price) as two_group
	FROM book_data_sold
)

SELECT 
	*,
	CASE
		WHEN two_group = 1 THEN 'cheap'
		ELSE 'expensive'
	END as price_category
FROM CTE_group_ntile
--=================================================================================
-- 5. Find top three selling book based on price category.
--=================================================================================
with CTE_book_average as (
	SELECT 
		*,
		AVG(price) OVER() as price_average
	FROM book_data_sold
),
CTE_price_category as (
	SELECT
		*,
		CASE
			WHEN price < price_average THEN 'cheap'
			ELSE 'expensive'
		END as price_category
	FROM CTE_book_average
	ORDER BY price
),
CTE_rank_number_sold as (
	SELECT 
		*,
		ROW_NUMBER() OVER(PARTITION BY price_category ORDER BY number_sold DESC) as rank_number_sold
	FROM CTE_price_category
)

SELECT
	*
FROM CTE_rank_number_sold
WHERE rank_number_sold <=3

-- This is confusing at first, but lets do it step by step.
-- First step:

with CTE_book_average as (
	SELECT 
		*,
		AVG(price) OVER() as price_average
	FROM book_data_sold
)
SELECT
	*
FROM CTE_book_average

-- Second step:
with CTE_book_average as (
	SELECT 
		*,
		AVG(price) OVER() as price_average
	FROM book_data_sold
),
CTE_price_category as (
	SELECT
		*,
		CASE
			WHEN price < price_average THEN 'cheap'
			ELSE 'expensive'
		END as price_category
	FROM CTE_book_average
	ORDER BY price
)

SELECT
	*
FROM CTE_price_category

--The thirst step as last step is the full syntax which is same as the syntax above.

--=================================================================================
-- 6. Find all the book which sales is in top 40%
--=================================================================================
with CTE_sales as (
	SELECT
		*,
		number_sold*price as sales
	FROM book_data_sold
),
CTE_sales_dist as (
	SELECT 
		*,
		CUME_DIST() OVER(ORDER BY sales DESC) as sales_dist
	FROM CTE_sales
)

SELECT
	*,
	CONCAT(sales_dist*100,'%') as top_sales_dist_percentage
FROM CTE_sales_dist
WHERE sales_dist <= 0.4

-- First step:
with CTE_sales as (
	SELECT
		*,
		number_sold*price as sales
	FROM book_data_sold
)

SELECT
	*
FROM CTE_sales

-- Second step is the same as the full syntax above.
