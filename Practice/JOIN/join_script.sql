CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE);

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255));

INSERT INTO orders VALUES
(1, 101, 1, '2021-01-01'),
(2, 102, 2, '2021-02-01'),
(3, 103, 3, '2021-03-01')

INSERT INTO customers VALUES
(101, 'John Doe'),
(102, 'Jane Smith');

SELECT * FROM orders

SELECT * FROM customers

SELECT *
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id

SELECT *
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id

SELECT *
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id

SELECT *
FROM customers
JOIN product
ON customers.order_id = product.product_id

SELECT *
FROM customers
LEFT JOIN product
ON customers.order_id = product.product_id

SELECT *
FROM product
LEFT JOIN customers
ON customers.order_id = product.product_id

CREATE TABLE product (
product_id INT PRIMARY KEY,
product_name VARCHAR(255));

INSERT INTO product VALUES
(1, 'Rendang'),
(2, 'Babi Guling'),
(3, 'Soto');

SELECT * 
FROM customers

ALTER TABLE customers
ADD Column order_id INTEGER DEFAULT(1);

DELETE FROM customers
WHERE customer_id in (1,2,3)

ALTER TABLE customers
DROP COLUMN order_id;

UPDATE customers
SET order_id = 2
WHERE customer_id 
    IN (102);

DROP TABLE customers

DROP TABLE orders

DROP TABLE product


CREATE TABLE customer(
customer_id VARCHAR(15) PRIMARY KEY,
costomer_name VARCHAR(50),
order_id VARCHAR(15),
number_item INTEGER
);

SELECT * FROM customer

INSERT INTO customer
VALUES 
('H101001', 'Robert Blake',     'F201', 2),
('H101002', 'Jonathan Matheus', 'F203', 1),
('H101003', 'Dona Doni',        'D301', 3),
('H101004', 'Patrick Kluivert', 'F201', 4)

CREATE TABLE cust_order(
order_id VARCHAR(15) PRIMARY KEY,
product_name VARCHAR(50)
);

INSERT INTO cust_order
VALUES
('F201', 'Burger'),
('F202', 'Pizza'),
('F203', 'Sandwich'),
('F204', 'Pancake'),
('D301', 'Diet Coke'),
('D302', 'Water');

SELECT * FROM cust_order

SELECT *
FROM customer
JOIN cust_order
ON customer.order_id = cust_order.order_id

SELECT *
FROM customer
RIGHT JOIN cust_order
ON customer.order_id = cust_order.order_id

SELECT *
FROM customer
FULL JOIN cust_order
ON customer.order_id = cust_order.order_id

