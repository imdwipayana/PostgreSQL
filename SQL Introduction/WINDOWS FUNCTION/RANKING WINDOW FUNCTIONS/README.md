# RANKING WINDOW FUNCTION
Create book_data_sold table:
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
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/book_data_sold.png)

### 1. Create ranking based on price which the most expensive book comes first.

```sql
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY price DESC) as price_ranking
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number1.png)

### 2. For each genre, list the price of book starting from the most expensive.

```sql
SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY genre ORDER BY price DESC) as price_ranking
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number2.png)

### 3. Find the most expensive book for each genre.

Add constrain to previous problem with WHERE

```sql
SELECT
	*
FROM (SELECT
	     *,
	     ROW_NUMBER() OVER(PARTITION BY genre ORDER BY price DESC) as price_ranking
      FROM book_data_sold
)
WHERE price_ranking = 1;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number3.png)

### 4. Compares ROW_NUMBER(), RANK() and DENSE_RANK window function to sort the book based on the number books in stock.

```sql
SELECT
	book_id,
	book_title,
	in_stock,
	ROW_NUMBER() OVER(ORDER BY in_stock DESC) as unique_rank,
	RANK() OVER(ORDER BY in_stock DESC) as share_rank,
	DENSE_RANK() OVER(ORDER BY in_stock DESC) as rank_dense
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number4.png)

### 5. Compares ROW_NUMBER(), RANK() and DENSE_RANK window function to sort the book based on the number books were sold.


```sql
SELECT
	book_id,
	book_title,
	number_sold,
	ROW_NUMBER() OVER(ORDER BY number_sold DESC) as unique_rank,
	RANK() OVER(ORDER BY number_sold DESC) as share_rank,
	DENSE_RANK() OVER(ORDER BY number_sold DESC) as rank_dense
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number5.png)

### 6. Rank the best 3 book titles that were sold.

First step: counting sales as number book sold multiply by the price of the book.
```sql
SELECT
	*,
	number_sold*price as sales
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number6step1.png)

Second step: use ROW_NUMBER() to rank the book based on sales.
```sql
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY sales DESC) as rank_sales
FROM (
SELECT
	*,
	number_sold*price as sales
FROM book_data_sold
);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number6step2.png)

Thirsd step: use LIMIT to find out the top three book sales.
```sql
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY sales DESC) as rank_sales
FROM (SELECT
	     *,
	     number_sold*price as sales
      FROM book_data_sold
)
LIMIT 3;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number6step3.png)

### 7. USE NTILE() to divide the book data through some groups based on price.

```sql
SELECT
	*,
	NTILE(1) OVER(ORDER BY price DESC) as one_group,
	NTILE(2) OVER(ORDER BY price DESC) as two_groups,
	NTILE(3) OVER(ORDER BY price DESC) as three_groups,
	NTILE(4) OVER(ORDER BY price DESC) as four_groups,
	NTILE(5) OVER(ORDER BY price DESC) as five_groups,
	NTILE(6) OVER(ORDER BY price DESC) as six_groups
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number7.png)

### 8. USE NTILE() to categorize the book based on price into 3 groups: expensive, medium and cheap

First step: use NTILE(3) to group table into 3 category
```sql
SELECT
	*,
	NTILE(3) OVER(ORDER BY price DESC) as three_group
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number8step1.png)

-- Second step: use CASE to categorize data based on the NTILE() result
```sql
SELECT
	*,
	CASE
		WHEN three_group = 1 THEN 'expensive'
		WHEN three_group = 2 THEN 'medium'
		ELSE 'cheap'
	END as price_category
FROM (SELECT
	     *,
	  NTILE(3) OVER(ORDER BY price DESC) as three_group
      FROM book_data_sold
);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number8step2.png)

### 9. Categorize the books to be two groups based on sales: top_selling and less_selling

First step: calculate sales for each book.
```sql
SELECT
	*,
	number_sold*price as sales
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number9step1.png)

Second step: use NTILE(2) to divide the sales becomes two groups.
```sql
SELECT
	*,
	NTILE(2) OVER(ORDER BY sales DESC) as sales_category
FROM (SELECT
	     *,
	     number_sold*price as sales
      FROM book_data_sold
);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number9step2.png)

Third step: use CASE to make category based on sales
```sql
SELECT
	*,
	CASE
		WHEN sales_category = 1 THEN 'top_selling'
		ELSE 'less_selling'
	END as top_less_selling
FROM (SELECT
         *,
	     NTILE(2) OVER(ORDER BY sales DESC) as sales_category
      FROM (SELECT
	           *,
	           number_sold*price as sales
            FROM book_data_sold
)
);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number9step3.png)

### 10. USE CUME_DIST() to find out the top 40% from book price

First step: use CUM_DIST() to find the top percentage
```sql
SELECT
	*,
	CUME_DIST() OVER(ORDER BY price DESC) as cumulative_dist 
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number10step1.png)

Second step: use WHERE to constrain the only top 40%
```sql
SELECT
	*
FROM(SELECT
	    *,
	 CUME_DIST() OVER(ORDER BY price DESC) as cumulative_dist 
     FROM book_data_sold
)
WHERE cumulative_dist<=0.4;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number10step2.png)

Third step: use CONCAT to write in percentage
```sql
SELECT
	*,
	CONCAT(cumulative_dist*100,'%') as percentage_dist
FROM (SELECT
  	     *
      FROM(SELECT
      	      *,
	          CUME_DIST() OVER(ORDER BY price DESC) as cumulative_dist 
           FROM book_data_sold
)
WHERE cumulative_dist<=0.4
);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number10step3.png)

### 11. USE PERCENT_RANK() to find out the top 40% from book price

First step: use CUM_DIST() to find the top percentage

```sql
SELECT
	*,
	PERCENT_RANK() OVER(ORDER BY price DESC)::numeric(10,2) as cumulative_dist 
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number11step1.png)


Second step: use WHERE to constrain the only top 40%
```sql
SELECT
	*
FROM(SELECT
	    *,
	 PERCENT_RANK() OVER(ORDER BY price DESC)::numeric(10,2) as cumulative_dist 
     FROM book_data_sold
)
WHERE cumulative_dist<=0.4;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number11step2.png)

Third step: use CONCAT to write in percentage
```sql
SELECT
	*,
	CONCAT(cumulative_dist*100,'%') as percentage_dist
FROM (SELECT
  	     *
      FROM(SELECT
      	      *,
	          PERCENT_RANK() OVER(ORDER BY price DESC)::numeric(10,2) as cumulative_dist 
           FROM book_data_sold
)
WHERE cumulative_dist<=0.4
);
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number11step3.png)

### 12. Compare CUME_DIST() and PERCENT_RANK() from book price

```sql
SELECT
	*,
	CUME_DIST() OVER(ORDER BY price DESC)::numeric(10,2) as example_cume_dist,
	PERCENT_RANK() OVER(ORDER BY price DESC)::numeric(10,2) as example_percent_rank
FROM book_data_sold;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/WINDOWS%20FUNCTION/RANKING%20WINDOW%20FUNCTIONS/image/number12.png)
