--=================================================================================
-- Create customer table
--=================================================================================
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
customer_id VARCHAR(15) PRIMARY KEY,
costomer_name VARCHAR(50),
order_id VARCHAR(15),
number_item INTEGER
);

--=================================================================================
-- Insert customer table value
--=================================================================================
INSERT INTO customer
VALUES 
('H101001', 'Robert Blake',     'F201', 2),
('H101002', 'Jonathan Matheus', 'F203', 1),
('H101003', 'Dona Doni',        'D301', 3),
('H101004', 'Patrick Kluivert', 'F201', 4),
('H101005', 'Ronaldo Messi',    Null, Null);

--=================================================================================
-- Call the customer table
--=================================================================================
SELECT * FROM customer

--=================================================================================
-- Create cust_order table
--=================================================================================
DROP TABLE IF EXISTS cust_order;
CREATE TABLE cust_order(
order_id VARCHAR(15) PRIMARY KEY,
product_name VARCHAR(50)
);

--=================================================================================
-- Insert cust_order table value
--=================================================================================
INSERT INTO cust_order
VALUES
('F201', 'Burger'),
('F202', 'Pizza'),
('F203', 'Sandwich'),
('F204', 'Pancake'),
('D301', 'Diet Coke'),
('D302', 'Water');

--=================================================================================
-- Call cust_order table
--=================================================================================
SELECT * FROM cust_order

--=================================================================================
-- JOIN syntax
--=================================================================================
SELECT *
FROM customer
JOIN cust_order
ON customer.order_id = cust_order.order_id

--=================================================================================
-- LEFT JOIN syntax
--=================================================================================
SELECT *
FROM customer
LEFT JOIN cust_order
ON customer.order_id = cust_order.order_id

--=================================================================================
-- RIGHT JOIN syntax
--=================================================================================
SELECT *
FROM customer
RIGHT JOIN cust_order
ON customer.order_id = cust_order.order_id

--=================================================================================
-- FULL JOIN syntax
--=================================================================================
SELECT *
FROM customer
FULL JOIN cust_order
ON customer.order_id = cust_order.order_id

