SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;
SELECT * FROM employees LIMIT 20;

# LENGTH, CHAR_LENGTH
SELECT LENGTH("ABC"); # 結果: 3
SELECT LENGTH("あいう"); # 結果: 9
SELECT CHAR_LENGTH("ABC"); # 結果: 3
SELECT CHAR_LENGTH("あいう"); # 結果: 3
SELECT name, LENGTH(name) FROM employees LIMIT 20;
SELECT name, CHAR_LENGTH(name) FROM employees LIMIT 20;

# TRIM, RTRIM, LTRIM (空白削除)
SELECT LTRIM(" ABC ");
SELECT RTRIM(" ABC ") AS a;
SELECT TRIM(" ABC ") AS a;

# 空白を探し出す
SELECT * FROM employees WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));
# UPDATEしてTRIMする
UPDATE employees
SET name = TRIM(name)
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));

# REPLACE
SELECT REPLACE("I like an apple", "appple", "orange");

SELECT REPLACE(name, "Mrs", "Ms") FROM users WHERE name LIKE "Mrs%";

# UPPER, LOWER
SELECT UPPER("apple");
SELECT LOWER("APPLE");

SELECT name, UPPER(name), LOWER(name) FROM users;

# SUBSTRING
SELECT SUBSTRING(name, 2, 3), name FROM employees;
SELECT * FROM employees WHERE SUBSTR(name, 2, 1) = "田";

# REVERSE
SELECT REVERSE(name), name FROM employees;