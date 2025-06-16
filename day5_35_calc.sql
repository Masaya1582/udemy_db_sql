SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES; 

# 算術演算子
# +, -, *, /, %
SELECT 1 + 1;
SELECT * FROM customers LIMIT 20;

SELECT name, age, age + 3 AS age_3 FROM customers LIMIT 10;

SELECT name, age - 1 AS age_1 FROM customers LIMIT 10;
SELECT name, birth_day + 2 AS birth_day_2 FROM customers LIMIT 10;
SELECT age % 2 AS age_percent FROM customers LIMIT 20;

# CONCAT (文字連結)
SHOW TABLES;
SELECT * FROM employees LIMIT 20;
SELECT CONCAT(department, ":", name) AS "部署" FROM employees LIMIT 20;

# 日付
SELECT NOW();
SELECT NOW() AS "Current Time", name FROM employees LIMIT 20;
SELECT CURDATE();
SELECT DATE_FORMAT (NOW(), "%y");

