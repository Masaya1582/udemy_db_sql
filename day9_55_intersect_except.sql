SHOW DATABASES;
USE `dump-day_4_9_db`;
SHOW TABLES;

# INTERSECT: 重複を表示、Column数は揃える
SELECT * FROM new_students
INTERSECT
SELECT * FROM students;

# EXCEPT: new_studentsに存在してstudentsに存在しない
SELECT * FROM new_students
EXCEPT
SELECT * FROM students
ORDER BY id;

# EXCEPT: studentsに存在してnew_studentsに存在しない
SELECT * FROM students
EXCEPT
SELECT * FROM new_students
ORDER BY id;

# UNION ALL、どちらかに存在
(SELECT * FROM new_students
EXCEPT
SELECT * FROM students)
UNION ALL
(SELECT * FROM students
EXCEPT
SELECT * FROM new_students)
ORDER BY id;

SELECT * FROM students WHERE id < 10
EXCEPT
SELECT * FROM new_students WHERE id < 10;