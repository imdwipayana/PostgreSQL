DROP TABLE IF EXISTS production_status;

CREATE TABLE production_status (
product_id      VARCHAR(10) PRIMARY KEY,
production_date DATE,
batch           INTEGER,
total_product   INTEGER,
status          VARCHAR(25)
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

--=============================================================================
-- 1. Modify the following SQL query to be a stored procedure
--=============================================================================
-- The query:
SELECT
	COUNT(*) as total_status
FROM production_status
WHERE status = 'Delivered'

-- The stored procedure:
DROP PROCEDURE sp_query(
	IN sp_status VARCHAR,
	OUT sp_total_status INTEGER
);
CREATE PROCEDURE SP_query (
	IN sp_status VARCHAR,
	OUT sp_total_status INTEGER
)
LANGUAGE plpgsql
AS
$$
BEGIN
	SELECT
		COUNT(*)
	INTO sp_total_status
	FROM production_status
	WHERE status = sp_status;
END;
$$;

-- Call the stored procedure
CALL SP_query('Delivered', NULL)

-- Do the other call to see how the stored procedure works.
CALL SP_query('Shipped', NULL)

CALL SP_query('Check Out', NULL)

CALL SP_query('On Hold', NULL)
--=============================================================================
-- 2. Create stored procedure to transfer a number of product between two warehouse.
--=============================================================================
-- Create table:
DROP TABLE IF EXISTS table_warehouse_transfer;
CREATE TABLE table_warehouse_transfer(
warehouse_id VARCHAR(10) PRIMARY KEY,
warehouse VARCHAR(25),
in_stock INTEGER
);

INSERT INTO table_warehouse_transfer
VALUES
('W101', 'Toronto',  10000),
('W102', 'Winnipeg', 20000),
('W103', 'Calgary',  30000),
('W104', 'Regina',   40000),
('W105', 'Montreal', 50000);

SELECT * FROM table_warehouse_transfer;

-- Crate the stored procedure to calculate the product transfer between warehouse.
-- Note: The transfer will decrease the number of product from the warehouse origin and add the number of product into the warehpuse detination.
CREATE OR REPLACE PROCEDURE SP_delivery(
	sp_origin_id VARCHAR,
	sp_destination_id VARCHAR,
	sp_number_product_transfer INTEGER
)
LANGUAGE plpgsql
AS
$$
BEGIN
	-- decrese the number product in stock in warehouse origin
	UPDATE table_warehouse_transfer
	SET in_stock = in_stock - sp_number_product_transfer
	WHERE warehouse_id = sp_origin_id;

	-- increase the number product in stock in warehouse destination
	UPDATE table_warehouse_transfer
	SET in_stock = in_stock + sp_number_product_transfer
	WHERE warehouse_id = sp_destination_id;

	COMMIT;

END;
$$;

-- Call the store procedure to update 3000 products transfer from warehouse in Toronto into Montreal.
CALL SP_delivery('W101', 'W105', 3000);

-- Call the table to see the update.
SELECT * FROM table_warehouse_transfer;

-- Call the store procedure to update 5000 products transfer from warehouse in Regina into Toronto.
CALL SP_delivery('W103', 'W101', 5000);

-- Call the table to see the update.
SELECT * FROM table_warehouse_transfer;
--=============================================================================
-- 3. Use stored procedure to insert data and the result is the table as folows: 
--=============================================================================
-- Display table 1 (the first table in this page).
-------------------------------------------------------------------------------
-- Create the header of the table:
DROP TABLE IF EXISTS stored_procedure;

CREATE TABLE stored_procedure (
product_id      VARCHAR(10) PRIMARY KEY,
production_date DATE,
batch           INTEGER,
total_product   INTEGER,
status          VARCHAR(25)
);

-- Create the insert stored procedure:
CREATE PROCEDURE SP_insert_data(product_id VARCHAR, production_date DATE, batch INTEGER, total_product INTEGER, status VARCHAR)
AS
$$
BEGIN
	INSERT INTO stored_procedure (product_id, production_date, batch, total_product, status) VALUES ($1, $2, $3, $4, $5);
	COMMIT;
END;
$$
LANGUAGE plpgsql;

-- Call the procedure to insert the first row data:
CALL SP_insert_data('P101', '2023-08-17', 1, 100, 'Delivered');

-- Call the table to update the inserted data:
SELECT * FROM stored_procedure;

-- Second row data inserted (run CALL first then run SELECT):
CALL SP_insert_data('P102', '2024-01-01', 2, 200, 'Shipped');

SELECT * FROM stored_procedure;

-- Third row data inserted (run CALL first then run SELECT):
CALL SP_insert_data('P103', '2024-05-11', 3, 300, 'Check Out');

SELECT * FROM stored_procedure;

-- Fourth row data inserted (run CALL first then run SELECT):
CALL SP_insert_data('P104', '2024-12-31', 4, 400, 'Delivered');

SELECT * FROM stored_procedure;

-- Fifth row data inserted (run CALL first then run SELECT):
CALL SP_insert_data('P105', '2025-02-21', 5, 500, 'Delivered');

SELECT * FROM stored_procedure;

-- Sixth row data inserted (run CALL first then run SELECT):
CALL SP_insert_data('P106', '2025-07-30', 6, 600, 'Shipped');

SELECT * FROM stored_procedure;

--=============================================================================
-- 4. Insert stored procedure to create table.
--=============================================================================
DROP TABLE IF EXISTS table_stored_procedure;
CREATE TABLE  table_stored_procedure(
product_id      VARCHAR(10) PRIMARY KEY,
manufacturer    VARCHAR(50) NOT NULL,
production_date TIMESTAMP   DEFAULT NOW() - INTERVAL '30 days',
sold_out        TIMESTAMP   DEFAULT NOW(),
total_sales     FLOAT
)

CREATE OR REPLACE PROCEDURE SP_stored_procedure (
product_id      VARCHAR(10),
manufacturer    VARCHAR(50),
total_sales     FLOAT
)
AS
$$
BEGIN
	-- notifications:
	IF product_id IS NULL THEN
		RAISE EXCEPTION 'fill the product_id value';
	END IF;

	IF manufacturer IS NULL THEN
		RAISE EXCEPTION 'fill the manufacturer value';
	END IF;

	INSERT INTO table_stored_procedure(product_id, manufacturer, total_sales) 
	VALUES ($1, $2, $3);
	COMMIT;
	
END;
$$
LANGUAGE plpgsql;

-- Call the stored procedure to insert first row data:
CALL SP_stored_procedure('P101','Calgary',NULL)

-- Call the table to find the inserted data:
SELECT * FROM table_stored_procedure

-- Call the stored procedure to insert second row data:
CALL SP_stored_procedure('P102', 'Toronto', 200000)

-- Call the table to find the inserted data:
SELECT * FROM table_stored_procedure

-- Call the stored procedure to insert third row data:
CALL SP_stored_procedure('P103', 'Winnipeg', 300000)

-- Call the table to find the inserted data:
SELECT * FROM table_stored_procedure

