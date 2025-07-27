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
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/Create%20Table%20as%20SELECT/image/book_library.png)

```sql
SELECT * FROM book_library
);
```

