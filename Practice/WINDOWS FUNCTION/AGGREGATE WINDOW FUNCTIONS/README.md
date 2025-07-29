# AGGREGATE WINDOW FUNCTION

Create book_data table:
```sql
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
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/book_data.png)

### 1. Create a new column that contains the average price of the books
```sql
SELECT
	*,
	AVG(price) OVER() as average_price
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number1.png)

### 2. Create a new column to inform the total books in stock
```sql
SELECT
	*,
	SUM(in_stock) OVER() as total_book
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number2.png)

### 3. Create a new column that inform the most expensive book
```sql
SELECT
	*,
	MAX(price) OVER() as most_expensive
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number3.png)

### 4. Create a new column with information of the cheapest book
```sql
SELECT
	*,
	MIN(price) OVER() as most_expensive
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number4.png)

### 5. Create a new column with information about the number of book's titles available
```sql
SELECT
	*,
	COUNT(*) OVER() as book_title
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number5.png)

### 6. Create a new table with information of the average price of book based on genre
```sql
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre) as average_price
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number6.png)

### 7. Create a new table with information of the average price of book based on genre. Put the most pages on top for each category.

```sql
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC)::numeric(10,2) as average_price
FROM book_data;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number7.png)

The result is a little bit weird. The pages column is sorted for each category, but the average price result based the row data and the preceeding data in the same category (this is the default from frame clause which is ROWS BETWEEN CURRENT ROW AND UNBOUNDED PRECEEDING). For further understanting, look for frame clause in window functions. I myself still learning when the ORDER BY in aggregate window function supposed to be applied in the real problem.

### 8. Example of aggregate window function with frame clause

```sql
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC
	   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)::numeric(10,2) as average_price
FROM book_data;
```
The result is the same with the previous one.

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number8.png)

### 9. Example of aggregate window function with frame clause

```sql
SELECT
	*,
	AVG(price) OVER(PARTITION BY genre ORDER BY price DESC
	   ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)::numeric(10,2) as average_price_now_next_book
FROM book_data;
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/WINDOWS%20FUNCTION/AGGREGATE%20WINDOW%20FUNCTIONS/image/number9.png)







