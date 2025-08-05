# Stored Procedure

Create  the table:
```sql
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
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/table1.png)


### 1. Modify the following SQL query to be a stored procedure
The query:
```sql
SELECT
	COUNT(*) as total_status
FROM production_status
WHERE status = 'Delivered'
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number22query.png)

The stored procedure:
```sql
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
```
Call the stored procedure
```sql
CALL SP_query('Delivered', NULL)
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number11update1.png)

Do the other call to see how the stored procedure works.
```sql
CALL SP_query('Shipped', NULL)
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number11update2.png)

```sql
CALL SP_query('Check Out', NULL)
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number11update3.png)

```sql
CALL SP_query('On Hold', NULL)
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number11update4.png)


### 2. Create stored procedure to transfer a number of product between two warehouse.
Create table:
```sql
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
```

![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number22table.png)

Crate the stored procedure to calculate the product transfer between warehouse.

Note: The transfer will decrease the number of product from the warehouse origin and add the number of product into the warehpuse detination.

```sql
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
```
Call the store procedure to update 3000 products transfer from warehouse in Toronto into Montreal.
```sql
CALL SP_delivery('W101', 'W105', 3000);
```
Call the table to see the update.
```sql
SELECT * FROM table_warehouse_transfer;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number22update1.png)

Call the store procedure to update 5000 products transfer from warehouse in Regina into Toronto.
```sql
CALL SP_delivery('W103', 'W101', 5000);
```
Call the table to see the update.
```sql
SELECT * FROM table_warehouse_transfer;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/number22update2.png)


### 3. Use stored procedure to insert data and the result is the table as folows: 
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Intermediate/Stored%20Procedure/image/table1.png)

```sql

```

![Library_project]()

### 

```sql

```

![Library_project]()

### 

```sql

```

![Library_project]()

### 

```sql

```

![Library_project]()

### 

```sql

```

![Library_project]()

### 

```sql

```

![Library_project]()


