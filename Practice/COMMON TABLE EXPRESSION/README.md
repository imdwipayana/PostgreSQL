# COMMON TABLE EXPRESSION(CTE)

Create table book_sold and insert all the values:
```sql
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
);
```
The book_sold table is shown as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/COMMON%20TABLE%20EXPRESSION/image/book_sold_for_CTE.png)

### 1. FIND the book total sales of all books.
#### First method: using subquery. 
First step: calculate the total sales of each book by multiplying number_sold column with price.
```sql
SELECT
	*,
	number_sold*price as sales
FROM book_data_sold
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/COMMON%20TABLE%20EXPRESSION/image/number1method1step1.png)

Second step: using SUM() for column sales to find out the total sales.
```sql
SELECT
	SUM(sales) as total_sales
FROM (SELECT
	     *,
	     number_sold*price as sales
      FROM book_data_sold
)
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/COMMON%20TABLE%20EXPRESSION/image/number1method1step2.png)

#### Second method: using Common Table Expression (CTE)
```sql
SELECT
	SUM(sales) as total_sales
FROM (SELECT
	     *,
	     number_sold*price as sales
      FROM book_data_sold
)
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/COMMON%20TABLE%20EXPRESSION/image/number1.png)
Both methods have the same result.

### 
```sql

```
![Library_project]()

### 
```sql

```
![Library_project]()

### 
```sql

```
![Library_project]()

### 
```sql

```
![Library_project]()
