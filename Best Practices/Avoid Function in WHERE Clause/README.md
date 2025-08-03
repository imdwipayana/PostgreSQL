# Avoid Function in WHERE Clause

Create  table:
```sql
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
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/Avoid%20Function%20in%20WHERE%20Clause/image/production_data.png)

### 1. Check the status of all product that product_id is starting with P.
First method:
```sql
SELECT
	product_id,
	status
FROM function_where
WHERE SUBSTRING(product_id,1,1) = 'P'
```

Second method::
```sql
SELECT
	product_id,
	status
FROM function_where
WHERE product_id LIKE 'P%'
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/Avoid%20Function%20in%20WHERE%20Clause/image/number1.png)

Note: LIKE is an operator, not a function.
The second method is the best practice

### 2. Find out all products that have been delivered
First method:
```sql
SELECT 
	*
FROM function_where
WHERE UPPER(status) = 'DELIVERED'
```
Second method:
```sql
SELECT 
	*
FROM function_where
WHERE status = 'Delivered'
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/Avoid%20Function%20in%20WHERE%20Clause/image/number2.png)

The second method is the best practice

### 3. Find all product that manufactured in 2024
First method:
```sql
SELECT
	*
FROM function_where
WHERE EXTRACT(YEAR FROM production_date) = '2024'
```
Second method:
```sql
SELECT
	*
FROM function_where
WHERE production_date BETWEEN '2024-01-01' AND '2024-12-31'
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/Avoid%20Function%20in%20WHERE%20Clause/image/number3.png)

And here is the final result:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/number2part2.png)

The second method is the best practice.

By filtering the first table, then the row size of the table is decreasing. It will make the join process faster. The first attempt is not efficient because the data that we don't want will do the JOIN process then filtered through WHERE. You get the feeling.
