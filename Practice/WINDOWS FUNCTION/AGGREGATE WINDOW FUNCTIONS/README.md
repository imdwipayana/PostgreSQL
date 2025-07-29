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


















