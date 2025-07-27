--=================================================================================
-- DROP player table if it exists
--=================================================================================
DROP TABLE IF EXISTS book_library;

--=================================================================================
-- CREATE player table
--=================================================================================
CREATE TABLE book_library(
book_id VARCHAR(15) PRIMARY KEY,
book_title VARCHAR(200),
borrowed_id VARCHAR(50),
borrowed_date DATE,
return_date DATE
);

--=================================================================================
-- INSERT player table value
--=================================================================================
INSERT INTO book_library
VALUES 
('A1001', 'To Kill a Mockingbird',  'W2206', CURRENT_DATE - INTERVAL '55 days', CURRENT_DATE - INTERVAL '25 days'),
('A1002', 'The Alchemist',          'M0609', CURRENT_DATE - INTERVAL '50 days', NULL),
('B2001', 'No Country for Old Man', 'T2305', CURRENT_DATE - INTERVAL '45 days', CURRENT_DATE - INTERVAL '20 days'),
('B2002', 'Cloud Cuckoo Land',      'F1512', CURRENT_DATE - INTERVAL '35 days', NULL),
('C3001', 'The Grapes of Wrath',    'S0511', CURRENT_DATE - INTERVAL '31 days', CURRENT_DATE - INTERVAL '15 days'),
('C3002', 'Harry Potter',           'S0511', CURRENT_DATE - INTERVAL '25 days', NULL),
('C3003', 'River Sing Me Home',     'M1809', CURRENT_DATE - INTERVAL '15 days', NULL);

--=================================================================================
-- Call the book_library table
--=================================================================================
SELECT * FROM book_library

--=================================================================================
-- Save table which books have been returned
--=================================================================================
CREATE TABLE book_returned AS
SELECT * FROM book_library
WHERE return_date IS NOT NULL;

--=================================================================================
-- Call the book_returned table
--=================================================================================
SELECT * FROM book_returned;

--=================================================================================
-- Save table which books haven't been returned yet
--=================================================================================
CREATE TABLE book_not_returned AS
SELECT * FROM book_library
WHERE return_date IS NULL;

--=================================================================================
-- Call the book_returned table
--=================================================================================
SELECT * FROM book_not_returned;



