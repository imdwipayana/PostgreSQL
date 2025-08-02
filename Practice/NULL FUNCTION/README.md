# NULL FUNCTIONS


Here is the data of chess player in one tournament.
```sql
DROP TABLE IF EXISTS chess_player;

CREATE TABLE chess_player(
player_id VARCHAR(10) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
time_check_in TIMESTAMP,
time_check_out TIMESTAMP,
winner_prize FLOAT
);

INSERT INTO chess_player
VALUES
('F101', 'Zhu',     'Jinner',       '2025-08-01 07:15:25', '2025-08-01 17:30:21', 100000),
('M201', 'Magnus',   NULL,          '2025-08-01 07:40:15', '2025-08-01 15:51:51', 90000),
('F102', 'Hou',     'Yivan',        '2025-08-01 07:28:11', '2025-08-01 16:23:29', 80000),
('M202', 'Wei',     'Yi',           '2025-08-01 07:25:05', '2025-08-01 18:43:13', NULL),
('M203', 'Fabiano', 'Caruana',      '2025-08-01 07:26:02', '2025-08-01 17:32:07', 70000),
('M204', 'Hikaru',   NULL,          '2025-08-01 07:21:21', '2025-08-01 18:29:31', 70000),
('M205', 'Susanto', 'Megaranto',    '2025-08-01 07:22:35', '2025-08-01 18:15:41', 50000),
('M206', 'Anish',   'Giri',         '2025-08-01 07:29:01', '2025-08-01 19:19:59', NULL),
('M207', 'Garry',   'Kasparov',     '2025-08-01 07:30:15', '2025-08-01 19:03:25', 70000),
('M208', NULL,      'Neponimiachi', '2025-08-01 07:32:25', '2025-08-01 17:49:27', 80000),
('F103', NULL,       NULL,          '2025-08-01 07:24:59', '2025-08-01 17:41:31', 50000);

SELECT * FROM chess_player;
```
The result of table is shown as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/NULL%20FUNCTION/image/null_chess_player.png)

### 1. Find out 3 months after the borrowed_date
```sql
SELECT 
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number1.png)

### 2. It was considered late if the book is returned more than 3 months. Find out all books that were returned late.
```sql
SELECT 
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date
WHERE date_borrowed + interval '3 months' >= date_returned
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number2.png)

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
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number3.png)

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
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number4.png)

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
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number5.png)

### 6. Compare the question above with this method.
```sql
SELECT
	*,
	EXTRACT(YEAR FROM AGE(date_returned,date_borrowed))*12*30 +  
	EXTRACT(MONTH FROM AGE(date_returned,date_borrowed))*12+
	EXTRACT(DAY FROM AGE(date_returned,date_borrowed))as month_returned_borrowed
FROM book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number6.png)

### 7. Count how many month the book was returned after borrowed.
```sql
SELECT
	*,
	EXTRACT(YEAR FROM AGE(date_returned,date_borrowed))*12 +  
	EXTRACT(MONTH FROM AGE(date_returned,date_borrowed))  as month_returned_borrowed
FROM book_date
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/DATE%20and%20TIME%20FUNCTION/image/number7.png)


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




