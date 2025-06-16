SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;
SELECT * FROM users;

# ROUND, FLOOR, CEILING
SELECT ROUND(3.14);
SELECT ROUND(3.14, 1);
SELECT FLOOR(3.14);
SELECT FLOOR(3.99);
SELECT CEILING(3.14);
SELECT CEILING(3.99);
SELECT RAND(); # 0 ~ 1
SELECT RAND() * 10; # 0 ~ 1
SELECT FLOOR(RAND() * 10); # 0 ~ 1
SELECT POWER(3, 4);
SELECT name, weight / POWER(height/100, 2) AS BMI FROM students WHERE weight / POWER(height/100, 2) >= 30;

# COALESCE
SELECT * FROM tests_score;
SELECT COALESCE(NULL, NULL, "A", NULL, NULL, "B");
SELECT test_score_1, test_score_2, test_score_3, COALESCE(test_score_1, test_score_2, test_score_3) FROM tests_score;