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

--========================================================================
-- 1. Find out 3 months after the borrowed_date
--========================================================================
SELECT 
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date

--========================================================================
-- 2. It was considered late if the book is returned more than 3 months. Find out all books that were returned late.
--========================================================================
SELECT 
	*,
	date_borrowed + interval '3 months' as next_3months_borrowed
FROM book_date
WHERE date_borrowed + interval '3 months' >= date_returned


--========================================================================
-- 3. Label the book that returned late and not late in new table
--========================================================================
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

--========================================================================
-- 4. How if the late regulation is 90 days after borrowed date? Label all books that were returned late or early.
--========================================================================
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

--========================================================================
-- 5. Count how many days each book was borrowed? Then use the result to categorize the book tobe early or late.
--========================================================================
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

--========================================================================
-- 6. Compare the question above with this method.
--========================================================================
SELECT
	*,
	EXTRACT(YEAR FROM AGE(date_returned,date_borrowed))*12*30 +  
	EXTRACT(MONTH FROM AGE(date_returned,date_borrowed))*12+
	EXTRACT(DAY FROM AGE(date_returned,date_borrowed))as month_returned_borrowed
FROM book_date

--========================================================================
-- 7. Count how many month the book was returned after borrowed.
--========================================================================

SELECT
	*,
	EXTRACT(YEAR FROM AGE(date_returned,date_borrowed))*12 +  
	EXTRACT(MONTH FROM AGE(date_returned,date_borrowed))  as month_returned_borrowed
FROM book_date

--========================================================================
-- 8. Check the date using function in PostgreSQL
--========================================================================
CREATE OR REPLACE FUNCTION is_date(s VARCHAR) RETURNS BOOLEAN AS $$
BEGIN
    PERFORM s::DATE;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

SELECT is_date('2023-07-14'); -- Returns TRUE
SELECT is_date('not-a-date'); -- Returns FALSE





