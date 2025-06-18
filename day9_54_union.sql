SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;

# UNION: 重複は削除、Columnの数は合わせる
SELECT * FROM new_students
UNION 
SELECT * FROM students;

SELECT * FROM new_students
UNION 
SELECT * FROM students ORDER BY id;

# UNION ALL: 重複削除はしない
SELECT * FROM new_students
UNION ALL 
SELECT * FROM students;

SELECT * FROM new_students
UNION ALL 
SELECT * FROM students ORDER BY id;

SELECT * FROM students WHERE id < 10
UNION ALL
SELECT * FROM students WHERE id > 250;