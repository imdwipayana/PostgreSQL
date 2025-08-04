# JOIN vs EXISTS vs IN

Create  the first table:
```sql
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

SELECT * FROM production_status;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/table1.png)

Create  the second table:
```sql
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

SELECT * FROM sales_product;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/table2.png)

### 1. Find out the total sales of delivered status by using WHERE, EXISTS and IN.
First method: using WHERE

First method first step:
```sql
SELECT
	*
FROM production_status as ps
INNER JOIN sales_product as sp
ON ps.product_id = sp.product_id
WHERE ps.status = 'Delivered';
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/firstmethodstep1.png)

First method second step: select all columns that required
```sql
SELECT
	ps.product_id,
	sp.total_sales
FROM production_status as ps
INNER JOIN sales_product as sp
ON ps.product_id = sp.product_id
WHERE ps.status = 'Delivered';
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/firstmethodstep2.png)

Second method: using EXISTS
Second step: 
```sql
SELECT
	sp.product_id,
	sp.total_sales
FROM sales_product as sp
WHERE EXISTS (SELECT 2
			  FROM production_status as ps
			  WHERE sp.product_id = ps.product_id 
			     AND ps.status = 'Delivered'
);
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/secondmethod.png)

Third method: using IN

Third method first step:
```sql
SELECT
	product_id
FROM production_status
WHERE status = 'Delivered'
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/thirdmethodstep1.png)

Third step second step:
```sql
WITH CTE_in as (
SELECT
	product_id
FROM production_status
WHERE status = 'Delivered'
)
SELECT 
	sp.product_id,
	sp.total_sales
FROM sales_product as sp
WHERE sp.product_id in (SELECT * FROM CTE_in);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/JOIN%20vs%20EXISTS%20vs%20IN/image/thirdmethodstep2.png)

The syntax above can be written as subquery as follow:
```sql
SELECT 
	sp.product_id,
	sp.total_sales
FROM sales_product as sp
WHERE sp.product_id in (SELECT
			     product_id
			FROM production_status
			WHERE status = 'Delivered'
);
```

All of the sytaxes have the same result. But the second one is the best practice for large dataset, then followed by the first one.




