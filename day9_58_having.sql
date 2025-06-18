SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;

# HAVING: 集計結果に対しての絞り込み
SELECT department, AVG(salary)
FROM employees
GROUP BY department;

SELECT department, AVG(salary)
FROM employees
GROUP BY department HAVING AVG(salary) > 3980000;

SELECT birth_place, age, COUNT(*)
FROM users
GROUP BY birth_place, age
HAVING COUNT(*) > 2
ORDER BY COUNT(*);

# HAVINGのみ
SELECT DISTINCT name FROM users;

SELECT "重複なし" FROM users HAVING COUNT(DISTINCT name) = COUNT(name);
SELECT "重複なし" FROM users HAVING COUNT(DISTINCT age) = COUNT(age);


