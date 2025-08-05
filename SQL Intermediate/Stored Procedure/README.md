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

### 

```sql

```

![Library_project]()

### 

```sql

```

![Library_project]()


