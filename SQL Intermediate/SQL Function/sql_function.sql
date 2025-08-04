--=============================================================================
-- 1. First sql function
--=============================================================================
CREATE OR REPLACE FUNCTION practice_function(VARCHAR, INTEGER, INTEGER)
RETURNS VARCHAR
AS
$$
BEGIN
	RETURN SUBSTRING($1, $2, $3);
END;
$$
LANGUAGE plpgsql;

-- Call the function:
SELECT * FROM practice_function('PostgreSQL', 5, 4);

--=============================================================================
-- 2. Second sql function
--=============================================================================
CREATE OR REPLACE FUNCTION practice_function2(VARCHAR, INTEGER, INTEGER)
RETURNS VARCHAR
AS
$$
DECLARE phrase ALIAS FOR $1;
		start_from ALIAS FOR $2;
		how_long ALIAS FOR $3;
BEGIN
	RETURN SUBSTRING(phrase, start_from, how_long);
END;
$$
LANGUAGE plpgsql;

-- Call the practice_function2 function:
SELECT * FROM practice_function2('PostgreSQL', 5, 4);

--=============================================================================
-- 3. Third sql function
--=============================================================================
CREATE OR REPLACE FUNCTION practice_function3(phrase VARCHAR, start_from INTEGER, how_long INTEGER)
RETURNS VARCHAR
AS
$$
BEGIN
	RETURN SUBSTRING(phrase, start_from, how_long);
END;
$$
LANGUAGE plpgsql;

-- Call practice_function3 function:
SELECT * FROM practice_function3('PostgreSQL', 5, 4);

--=============================================================================
-- 4. Create function to generate full name
--=============================================================================
CREATE OR REPLACE FUNCTION full_name(first_name VARCHAR, last_name VARCHAR)
RETURNS VARCHAR
AS
$$
BEGIN
	IF first_name IS NOT NULL AND last_name IS NOT NULL THEN
		RETURN CONCAT(first_name, ' ', last_name);
	ELSEIF first_name IS NOT NULL AND last_name IS NULL THEN
		RETURN first_name;
	ELSEIF first_name IS NULL AND last_name IS NOT NULL THEN
		RETURN last_name;
	ELSE
		RETURN 'No Name Inserted';
	END IF;
END;
$$
LANGUAGE plpgsql;

-- Call full_name function:
SELECT * FROM full_name('Leylah', 'Fernandez');
SELECT * FROM full_name('Leylah', NULL);
SELECT * FROM full_name(NULL, 'Fernandez');
SELECT * FROM full_name(NULL, NULL);

--=============================================================================
-- 5. Create function to calculate average of data array.
--=============================================================================
CREATE OR REPLACE FUNCTION average(numeric[])
RETURNS numeric
AS
$$
DECLARE adding numeric := 0;
		value_array numeric;
		len_array INTEGER := 0;
		input_array ALIAS FOR $1;

BEGIN
	FOREACH value_array in ARRAY input_array
	loop
		adding := adding + value_array;
		len_array := len_array + 1;
	END LOOP;

	RETURN (adding/len_array)::numeric(10,2);
END;
$$
LANGUAGE plpgsql;


SELECT * FROM average(ARRAY[1,2,3,4,5,6]);

--=============================================================================
-- 6. Create function to find all data about product that manufactured in 2024 from the following table:
--=============================================================================
-- First create and inser table data:
DROP TABLE IF EXISTS production_status;
CREATE TABLE production_status (
product_id VARCHAR(10) PRIMARY KEY,
production_date DATE,
batch INTEGER,
total_product INTEGER,
status VARCHAR(25)
);

INSERT INTO production_status
VALUES
('P101', '2023-08-17', 1, 100, 'Delivered'),
('P102', '2024-01-01', 2, 200, 'Shipped'),
('P103', '2024-05-11', 3, 300, 'Check Out'),
('P104', '2024-12-31', 4, 400, 'Delivered'),
('P105', '2025-02-21', 5, 500, 'Delivered'),
('P106', '2025-07-30', 6, 600, 'Shipped');

SELECT * FROM production_status;

-- Second step: create function
CREATE OR REPLACE FUNCTION function_production_status (start_date DATE, end_date DATE)
RETURNS TABLE
(
	product_id VARCHAR,
	production_date DATE,
	batch INTEGER,
	total_product INTEGER,
	status VARCHAR
)
AS
$$
BEGIN
	RETURN QUERY
	SELECT
		ps.product_id,
		ps.production_date,
		ps.batch,
		ps.total_product,
		ps.status
	FROM production_status as ps
	WHERE ps.production_date BETWEEN start_date AND end_date;
END;
$$
LANGUAGE plpgsql;

-- Third step: call the function_production_status
SELECT * FROM function_production_status('2024-01-01', '2024-12-31')

