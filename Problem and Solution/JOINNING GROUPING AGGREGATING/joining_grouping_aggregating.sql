-- Create the first table
DROP TABLE IF EXISTS production_status;

CREATE TABLE production_status (
product_id VARCHAR(10) PRIMARY KEY,
production_date DATE,
batch INTEGER,
total_product INTEGER,
status VARCHAR(25)
);

INSERT INTO production_status
VALUES
('P101', '2023-08-17', 1, 100, 'Delivered'),
('P102', '2024-01-01', 2, 200, 'Shipped'),
('P103', '2024-05-11', 3, 300, 'Check Out'),
('P104', '2024-12-31', 4, 400, 'Delivered'),
('P105', '2025-02-21', 5, 500, 'Delivered'),
('P106', '2025-07-30', 6, 600, 'Shipped');

SELECT * FROM production_status
--========================================================================
--The second table
DROP TABLE IF EXISTS sales_product;

CREATE TABLE sales_product (
product_id VARCHAR(10) PRIMARY KEY,
warehouse VARCHAR(50),
total_sales FLOAT
);

INSERT INTO sales_product
VALUES
('P101', 'Edmonton',  200000),
('P102', 'Toronto',   300000),
('P103', 'Regina',    400000),
('P104', 'Saskatoon', 500000),
('P105', 'Vancouver', 600000),
('P106', 'Ottawa',    700000),
('P107', 'Winnippeg', 800000),
('P108', 'Calgary',   900000);

SELECT * FROM sales_product
--========================================================================
-- 1. Find out total sales based on their status
--========================================================================
WITH CTE_status_sales as (
	SELECT
		*
	FROM production_status as ps
	LEFT JOIN sales_product as sp
	ON ps.product_id = sp.product_id
), CTE_sum_sales as (
		SELECT
			status,
		SUM(total_sales) OVER(PARTITION BY status)
		FROM CTE_status_sales
)
SELECT DISTINCT
 *
FROM CTE_sum_sales

-- Joining then aggregating is not a best practice (I'll update again later).


