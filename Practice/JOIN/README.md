# JOIN Tables

There are four types of joins: JOIN (INNER JOIN), LEFT JOIN, RIGHT JOIN and FULL JOIN. There are two tables that will be created which are costomer and cust_order table. Create the customer table:
```sql
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
customer_id VARCHAR(15) PRIMARY KEY,
costomer_name VARCHAR(50),
order_id VARCHAR(15),
number_item INTEGER
);
```
Insert the customer table value:
```sql
INSERT INTO customer
VALUES 
('H101001', 'Robert Blake',     'F201', 2),
('H101002', 'Jonathan Matheus', 'F203', 1),
('H101003', 'Dona Doni',        'D301', 3),
('H101004', 'Patrick Kluivert', 'F201', 4),
('H101005', 'Ronaldo Messi',    Null, Null);
```
Call the customer table:
```sql
SELECT * FROM customer
```

The customer table is
![JOIN](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/JOIN/image/customer_pict.png) 

Then create the cust_order table:
```sql
DROP TABLE IF EXISTS cust_order;
CREATE TABLE cust_order(
order_id VARCHAR(15) PRIMARY KEY,
product_name VARCHAR(50)
);
```
Insert the cust_order table value:
```sql
INSERT INTO cust_order
VALUES
('F201', 'Burger'),
('F202', 'Pizza'),
('F203', 'Sandwich'),
('F204', 'Pancake'),
('D301', 'Diet Coke'),
('D302', 'Water');
```
Call the cust_order table:
```sql
SELECT * FROM cust_order
```

The cust_order table is
![JOIN](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/JOIN/image/order_pict.png) 

# For JOIN or INNER JOIN table, the sql syntax is
```sql
SELECT *
FROM customer
JOIN cust_order
ON customer.order_id = cust_order.order_id
```
The result of JOIN table is
![JOIN](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/JOIN/image/join_sql.png) 

# FOR LEFT JOIN table, the sql syntax is
```sql
SELECT *
FROM customer
LEFT JOIN cust_order
ON customer.order_id = cust_order.order_id
```
The result of LEFT JOIN table is
![JOIN](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/JOIN/image/left_join_sql.png) 

# FOR RIGHT JOIN table, the sql syntax is
```sql
SELECT *
FROM customer
RIGHT JOIN cust_order
ON customer.order_id = cust_order.order_id
```
The result of LEFT JOIN table is
![JOIN](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/JOIN/image/right_join_sql.png) 

# FOR FULL JOIN table, the sql syntax is
```sql
SELECT *
FROM customer
FULL JOIN cust_order
ON customer.order_id = cust_order.order_id
```
The result of FULL JOIN table is
![JOIN](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/JOIN/image/full_join_sql.png) 

I hope this will hellp understanding the concept of JOIN in sql.
