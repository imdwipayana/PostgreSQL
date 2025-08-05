--=================================================================================
-- DROP sales_data table if it exists
--=================================================================================
DROP TABLE IF EXISTS sales_data;

--=================================================================================
-- CREATE sales_data table 
--=================================================================================
CREATE TABLE sales_data(
order_id VARCHAR(10) PRIMARY KEY,
order_date DATE,
sales FLOAT
);

--=================================================================================
-- INSERT book_data_sold table value
--=================================================================================
INSERT INTO sales_data
VALUES 
('S001', '2025-07-01', 100),
('S002', '2025-07-02', 200),
('S003', '2025-07-03', 300),
('S004', '2025-07-04', 400),
('S005', '2025-07-05', 500),
('S006', '2025-07-06', 600),
('S007', '2025-07-07', 700),
('S008', '2025-07-08', 800),
('S009', '2025-07-09', 900),
('S010', '2025-07-10', 1000);

--=================================================================================
-- Call the sales_data table
--=================================================================================
SELECT * FROM sales_data;

--=================================================================================
-- 1. Compare LEAD() and LAG() for sales that order by daily sales
--=================================================================================
SELECT
	*,
	LEAD(sales) OVER(ORDER BY order_date) as lead_sales,
	LAG(sales) OVER(ORDER BY order_date) as lag_sales
FROM sales_data;
-- Notice that the frame clause default is ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

--=================================================================================
-- 2. Compare the previous result by adding frame clause ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--=================================================================================
SELECT
	*,
	LEAD(sales) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as lead_sales,
	LAG(sales) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as lag_sales
FROM sales_data;

--=================================================================================
-- 3. Compare the result of LEAD(sales,2) and LAG(sales,2)
--=================================================================================
SELECT
	*,
	LEAD(sales,2) OVER(ORDER BY order_date) as lead_sales,
	LAG(sales,2) OVER(ORDER BY order_date) as lag_sales
FROM sales_data;

--=================================================================================
-- 4. The default of LEAD() and LAG()
--=================================================================================
SELECT
	*,
	LEAD(sales,1,NULL) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as lead_sales,
	LAG(sales,1,NULL) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as lag_sales
FROM sales_data;

--=================================================================================
-- 5. Assume the value of data that not available is 0.
--=================================================================================
SELECT
	*,
	LEAD(sales,1,0) OVER(ORDER BY order_date) as lead_sales,
	LAG(sales,1,0) OVER(ORDER BY order_date) as lag_sales
FROM sales_data;

--=================================================================================
-- 6. Compare FIRST_VALUE() and LAST_VALUE of sales that ordered based on daily sales.
--=================================================================================
SELECT
	*,
	FIRST_VALUE(sales) OVER(ORDER BY order_date) as first_sales,
	LAST_VALUE(sales) OVER(ORDER BY order_date) as last_sales
FROM sales_data;

--=================================================================================
-- 7. Add the default frame clause ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW to previous syntax.
--=================================================================================
SELECT
	*,
	FIRST_VALUE(sales) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as first_sales,
	LAST_VALUE(sales) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as last_sales
FROM sales_data;

-- The results are the same because the frame clause default is ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.
