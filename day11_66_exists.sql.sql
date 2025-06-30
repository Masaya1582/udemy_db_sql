SHOW DATABASES;
USE `dump_10_14_db`;
SHOW TABLES;

SELECT * FROM customers AS ct
WHERE EXISTS(SELECT * FROM orders AS od WHERE ct.id = od.customer_id AND od.order_date = "2020-12-31");

SELECT * FROM customers AS ct
WHERE NOT EXISTS(SELECT * FROM orders AS od WHERE ct.id = od.customer_id AND od.order_date = "2020-12-31");

SELECT * FROM employees AS em1 
WHERE EXISTS(SELECT 1 FROM employees AS em2 WHERE em1.manager_id = em2.id);

