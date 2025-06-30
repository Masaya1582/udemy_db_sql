SHOW DATABASES;
USE `dump_10_14_db`;
SHOW TABLES;

# LEFT JOIN
SELECT emp.id, emp.first_name, emp.last_name, COALESCE(dt.id, "該当なし") AS department_id, dt.name AS department_name FROM employees AS emp
LEFT JOIN departments AS dt
ON emp.department_id = dt.id;

SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN
classes AS cs
ON enr.class_id = cs.id;

# RIGHT JOIN
SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN
classes AS cs
ON enr.class_id = cs.id;

# FULL JOIN
SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN
classes AS cs
ON enr.class_id = cs.id
UNION
SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN
classes AS cs
ON enr.class_id = cs.id;









