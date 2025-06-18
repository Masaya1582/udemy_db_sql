SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;

# GROUP BY
SELECT age, COUNT(*) AS "年代合計" FROM users
WHERE birth_place = "日本"
GROUP BY age;

SELECT age, COUNT(*) AS "年代合計", MAX(birth_day), MIN(birth_day) FROM users
WHERE birth_place = "日本"
GROUP BY age;

SELECT age, COUNT(*) AS "年代合計", MAX(birth_day), MIN(birth_day) FROM users
WHERE birth_place = "日本"
GROUP BY age
ORDER BY COUNT(*);

SELECT department, SUM(salary) AS "給与合計", AVG(salary) AS "給与平均"
FROM employees 
GROUP BY department;




