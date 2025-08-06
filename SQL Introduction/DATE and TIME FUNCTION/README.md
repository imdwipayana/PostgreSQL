# DATE and TIME FUNCTIONS

Create table book_sold and insert all the values:
```sql
DROP TABLE IF EXISTS book_date;

CREATE TABLE book_date(
book_id VARCHAR(10) PRIMARY KEY,
book_title VARCHAR(50),
date_borrowed DATE,
date_returned DATE
);

INSERT INTO book_date
VALUES
('M101', 'The Who',            '2025-03-10', '2025-03-28'),
('T201', 'Back to Zero',       '2025-03-15', '2025-04-21'),
('C301', 'Kill Billy',         '2025-04-04', '2025-07-05'),
('T202', 'What If',            '2025-04-11', '2025-08-21'),
('C302', 'The Killer',         '2025-04-27', '2025-06-13'),
('M102', 'Unwanted',           '2025-05-09', '2025-09-09'),
('M103', 'Right or Wrong',     '2025-05-18', '2025-06-25'),
('C303', 'Stolen Soul',        '2025-06-06', '2025-09-05'),
('T203', 'The Broken Promise', '2025-06-19', '2025-08-06'),
('C304', 'The Culprit',        '2025-06-29', '2025-10-01');

SELECT * FROM book_date;

```
The result of table is shown as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/data_book_datetime.png)

### 1. Find out 3 months after the borrowed_date
```sql
SELECT 
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number1.png)

### 2. It was considered late if the book is returned more than 3 months. Find out all books that were returned late.
```sql
SELECT 
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date
WHERE date_borrowed + interval '3 months' >= date_returned
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number2.png)

### 3. Label the book that returned late and not late in new table
```sql
WITH CTE_book_date as (
SELECT
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date
)
SELECT
	*,
	CASE
		WHEN next_3months_borrowed < date_returned THEN 'late'
		ELSE 'early'
	END as late_or_early
FROM CTE_book_date

```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number3.png)

### 4. How if the late regulation is 90 days after borrowed date? Label all books that were returned late or early.
```sql
WITH CTE_book_date as (
SELECT
	*,
	date_borrowed + interval '90 days' as next_90days_borrowed
FROM book_date
)
SELECT
	*,
	CASE
		WHEN next_90days_borrowed < date_returned THEN 'late'
		ELSE 'early'
	END as late_or_early
FROM CTE_book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number4.png)

### 5. Count how many days each book was borrowed? Then use the result to categorize the book tobe early or late.
```sql
WITH CTE_returned_borrowed as (
	SELECT
		*,
		date_returned - date_borrowed as days_borrowed
	FROM book_date
)

SELECT 
	*,
	CASE
		WHEN days_borrowed > 90 THEN 'late'
		ELSE 'early'
	END as late_early
FROM CTE_returned_borrowed
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number5.png)

### 6. Compare the question above with this method.
```sql
SELECT
	*,
	EXTRACT(YEAR FROM AGE(date_returned,date_borrowed))*12*30 +  
	EXTRACT(MONTH FROM AGE(date_returned,date_borrowed))*12+
	EXTRACT(DAY FROM AGE(date_returned,date_borrowed))as month_returned_borrowed
FROM book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number6.png)

### 7. Count how many month the book was returned after borrowed.
```sql
SELECT
	*,
	EXTRACT(YEAR FROM AGE(date_returned,date_borrowed))*12 +  
	EXTRACT(MONTH FROM AGE(date_returned,date_borrowed))  as month_returned_borrowed
FROM book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/DATE%20and%20TIME%20FUNCTION/image/number7.png)


### 8. Check the date using function in PostgreSQL
```sql
CREATE OR REPLACE FUNCTION is_date(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM s::DATE;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

SELECT is_date('2025-08-01'); -- Returns TRUE
SELECT is_date('2025-08'); -- Returns FALSE
SELECT is_date('what a date?'); -- Returns FALSE
```




