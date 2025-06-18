SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;

SELECT * FROM customers WHERE name IS NULL;

# COUNT (*より主キーを使う方が高速？)
SELECT COUNT(*) FROM customers; # 何行データがあるか
SELECT COUNT(name) FROM customers; # 列指定 (NULLはカウントしない)

SELECT COUNT(id) FROM customers WHERE id > 80;

# MAX, MIN
SELECT MAX(age) AS "最年長", MIN(age) AS "最年少" FROM users
WHERE birth_place = "日本";
SELECT MAX(birth_day) AS "最新誕生日", MIN(birth_day) AS "最古誕生日" FROM users

# SUM、AVG
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;

# AVG: NULLが面倒
CREATE TABLE temp_count(
num INT
);
SHOW TABLES;

INSERT INTO temp_count VALUE(1);
INSERT INTO temp_count VALUE(2);
INSERT INTO temp_count VALUE(3);
INSERT INTO temp_count VALUE(4);
INSERT INTO temp_count VALUE(5);
INSERT INTO temp_count VALUE(NULL);
SELECT * FROM temp_count;

SELECT AVG(COALESCE(num, 0)) FROM temp_count; # NULLを含める



