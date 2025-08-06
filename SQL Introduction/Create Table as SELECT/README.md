# CREATE Table AS SELECT

CREATE table as select is the same with save the table that we need through SELECT command. At first we create table book_library. 

```sql
DROP TABLE IF EXISTS book_library;
CREATE TABLE book_library(
book_id VARCHAR(15) PRIMARY KEY,
book_title VARCHAR(200),
borrowed_id VARCHAR(50),
borrowed_date DATE,
return_date DATE
);
```
Then insert the value of the table with syntax:
```sql
INSERT INTO book_library
VALUES 
('A1001', 'To Kill a Mockingbird',  'W2206', CURRENT_DATE - INTERVAL '55 days', CURRENT_DATE - INTERVAL '25 days'),
('A1002', 'The Alchemist',          'M0609', CURRENT_DATE - INTERVAL '50 days', NULL),
('B2001', 'No Country for Old Man', 'T2305', CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '20 days'),
('B2002', 'Cloud Cuckoo Land',      'F1512', CURRENT_DATE - INTERVAL '35 days', NULL),
('C3001', 'The Grapes of Wrath',    'S0511', CURRENT_DATE - INTERVAL '31 days', CURRENT_DATE - INTERVAL '15 days'),
('C3002', 'Harry Potter',           'S0511', CURRENT_DATE - INTERVAL '25 days', NULL),
('C3003', 'River Sing Me Home',     'M1809', CURRENT_DATE - INTERVAL '15 days', NULL);
```
Call the book_library table with:

```sql
SELECT * FROM book_library
);
```
The book_library table is shown as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/Create%20Table%20as%20SELECT/image/book_library.png)


NOTE: The date will appear in your table will be different with the date in this table because it will depends on when you run the program. This is caused by the CURRENT_DATE and INTERVAL Commands. The purpose of this fluid date format is to adapt with the late book regulation which is 30 days after borrowed date. It means the date will be different but the result after that will be the same with the tables shown here later. The NULL value in return_date column means the book hasn't been returned yet. If we want to find all books that have been returned, we can use the syntax:

```sql
CREATE TABLE book_returned AS
SELECT * FROM book_library
WHERE return_date IS NOT NULL;

SELECT * FROM book_returned;
```
The result is the table book returned as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/Create%20Table%20as%20SELECT/image/book_returned.png)

Meanwhile if we want to see the book that hasn't been returned yet, we can use the syntax:
```sql
CREATE TABLE book_not_returned AS
SELECT * FROM book_library
WHERE return_date IS NULL;

SELECT * FROM book_not_returned;
```
The book_not_returned table is shown as:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/Create%20Table%20as%20SELECT/image/book_not_returned.png)

If the late regulation is the book that returned more than 30 days after borrowed date, we can check all the book that late with syntax:
```sql
CREATE TABLE book_late AS
SELECT *,
	CURRENT_DATE - borrowed_date as days_borrowed
FROM book_library
WHERE CURRENT_DATE - borrowed_date > 30;

SELECT * FROM book_late;
```
The books that late are shown in book late table as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/Create%20Table%20as%20SELECT/image/book_late.png)

Meanwhile if we want to find out all title of books and days they have been borrowed, we can use the syntax:
```sql
CREATE TABLE days_borrowed AS
SELECT 
	book_title,
	CURRENT_DATE - borrowed_date as days_borrowed
FROM book_library
WHERE return_date is NULL;

SELECT * FROM days_borrowed;
```
The table days_borrowed is shown as follow:


![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/Create%20Table%20as%20SELECT/image/days_borrowed.png)
