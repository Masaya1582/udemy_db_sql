SHOW DATABASES;
USE `dump_10_14_db`;
SHOW TABLES;

SELECT * FROM employees;
SELECT * FROM departments;

SELECT * FROM employees AS emp
INNER JOIN departments AS dt
ON emp.department_id = dt.id;

# 特定のCOLUMN取り出し
SELECT 
emp.id, emp.first_name, emp.last_name, dt.id AS department_id, dt.name AS department_name FROM employees AS emp
INNER JOIN departments AS dt
ON emp.department_id = dt.id;

# 複数レコードで紐付け
SELECT * FROM students AS std
INNER JOIN 
users AS usr
ON std.first_name = usr.first_name AND std.last_name = usr.last_name;

# = 以外の紐付け
SELECT * FROM employees AS emp
INNER JOIN
students AS std 
ON emp.id < std.id;








