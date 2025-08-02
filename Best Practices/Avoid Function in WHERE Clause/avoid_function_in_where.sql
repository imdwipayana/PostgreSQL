DROP TABLE IF EXISTS function_where;

CREATE TABLE function_where (
product_id VARCHAR(10) PRIMARY KEY,
production_date DATE,
batch INTEGER,
total_product INTEGER,
status VARCHAR(25)
);

INSERT INTO function_where
VALUES
('P101', '2023-08-17', 1, 100, 'Delivered'),
('Q102', '2024-01-01', 2, 200, 'Shipped'),
('R103', '2024-05-11', 3, 300, 'Check Out'),
('P104', '2024-12-31', 4, 400, 'Delivered'),
('P105', '2025-02-21', 5, 500, 'Delivered'),
('Q106', '2025-07-30', 6, 600, 'Shipped');

SELECT * FROM function_where

--========================================================================
-- 1. Check the status of all product that product_id is starting with P.
--========================================================================
-- Bad practice:
SELECT
	product_id,
	status
FROM function_where
WHERE SUBSTRING(product_id,1,1) = 'P'

-- Best practice:
SELECT
	product_id,
	status
FROM function_where
WHERE product_id LIKE 'P%'

-- Note: LIKE is an operator, not a function.

--========================================================================
-- 2. Find out all products that have been delivered
--========================================================================
-- Bad practice:
SELECT 
	*
FROM function_where
WHERE UPPER(status) = 'DELIVERED'

-- Best practice:
SELECT 
	*
FROM function_where
WHERE status = 'Delivered'

--========================================================================
-- 3. Find all product that manufactured in 2024
--========================================================================
-- Bad practice
SELECT
	*
FROM function_where
WHERE EXTRACT(YEAR FROM production_date) = '2024'

-- Best Practice
SELECT
	*
FROM function_where
WHERE production_date BETWEEN '2024-01-01' AND '2024-12-31'
