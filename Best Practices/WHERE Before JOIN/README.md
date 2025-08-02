# WHERE Before JOIN

Create first table:
```sql
DROP TABLE IF EXISTS product_join;

CREATE TABLE product_join (
product_id VARCHAR(10) PRIMARY KEY,
manufacturer VARCHAR(25),
total_production INTEGER
);

INSERT INTO product_join
VALUES
('P101', 'Tesla', 100),
('P102', 'LG', 200),
('P103', 'LG', 300),
('P104', 'Tesla', 400),
('P105', 'Tesla', 500);

SELECT * FROM product_join
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/table1.png)

Create second table:
```sql
DROP TABLE IF EXISTS sales_join;

CREATE TABLE sales_join (
product_id VARCHAR(10) PRIMARY KEY,
total_sales INTEGER
);

INSERT INTO sales_join
VALUES
('P101', 50000),
('P102', 200000),
('P103', 75000),
('P104', 125000),
('P105', 90000),
('P106', 65000),
('P107', 85000);

SELECT * FROM sales_join
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/table2.png)

### 1. Use LEFT JOIN first table and second table where manufacturer is Tesla
```sql
SELECT
	pj.product_id,
	pj.manufacturer,
	pj.total_production,
	sj.total_sales
FROM product_join as pj
LEFT JOIN sales_join as sj
ON pj.product_id = sj.product_id
WHERE manufacturer = 'Tesla'
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/number1.png)


### 2. This is the best practice
Filter first table with WHERE then do the JOIN.
```sql
WITH CTE_best_join as (
	SELECT
		*
	FROM product_join
	WHERE manufacturer = 'Tesla'
)
SELECT
	cbj.product_id,
	cbj.manufacturer,
	cbj.total_production,
	sj.total_sales
FROM CTE_best_join as cbj
LEFT JOIN sales_join as sj
ON cbj.product_id = sj.product_id;
```
Here result of CTE_best_join

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/number2part1.png)

And here is the final result:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/number2part2.png)

By filtering the first table, then the row size of the table is decreasing. It will make the join process faster. The first attempt is not efficient because the data that we don't want will do the JOIN process then filtered through WHERE. You get the feeling.
