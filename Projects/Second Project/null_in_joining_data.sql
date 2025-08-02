--========================================================================
-- Create product_color_production table
--========================================================================
DROP TABLE IF EXISTS product_color_production;
CREATE TABLE product_color_production (
production_date DATE,
product_color VARCHAR(25),
total_production INTEGER
);
INSERT INTO product_color_production
VALUES
('2020-01-01', 'red',    100),
('2020-02-01', NULL,     200),
('2020-03-01', 'yellow', 300),
('2020-04-01', NULL,     400),
('2020-05-01', 'blue',   500),
('2020-06-01', NULL,     600);

SELECT * FROM product_color_production;

--========================================================================
-- Create product_color_sales table
--========================================================================
DROP TABLE IF EXISTS product_color_sales;
CREATE TABLE product_color_sales (
production_date DATE,
product_color VARCHAR(25),
total_sales FLOAT
);

INSERT INTO product_color_sales
VALUES
('2020-01-01', 'red',    20000),
('2020-02-01', NULL,     40000),
('2020-03-01', 'yellow', 50000),
('2020-04-01', NULL,     60000),
('2020-05-01', 'blue',   80000),
('2020-06-01', NULL,     100000);

SELECT * FROM product_color_sales;

--========================================================================
-- 1. Ignoring NULL value and do LEFT JOIN data with keys are production date and product_color
--========================================================================
SELECT
	production.production_date,
	production.product_color,
	production.total_production,
	sales.total_sales
FROM product_color_production as production
JOIN product_color_sales as sales
ON production.production_date = sales.production_date AND production.product_color = sales.product_color;
--Ignoring the NULL value will impact to lose a number of data

--========================================================================
-- 2. Treating NULL value first and then do LEFT JOIN data with keys are production date and product_color
--========================================================================
WITH CTE_production as (
	SELECT
		*,
		COALESCE(product_color,'') as no_null_color
	FROM product_color_production
),
CTE_sales as (
	SELECT
		*,
		COALESCE(product_color,'') as no_null_color
	FROM product_color_sales
)

SELECT
	production.production_date,
	production.product_color,
	production.total_production,
	sales.total_sales
FROM CTE_production as production
JOIN CTE_sales as sales
ON production.production_date = sales.production_date AND production.no_null_color = sales.no_null_color;
-- With NULL value tratment before the join, the data can be conserved