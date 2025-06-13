SELECT DATABASE();
USE my_db;

# studentsテーブルの作成
CREATE TABLE students(
 id INT PRIMARY KEY,
 name CHAR(10)
)
DESCRIBE students;

# データ挿入
INSERT INTO students VALUES(1, "ABCDEF   ");

# studentsテーブルの中身を確認
SELECT * FROM students;

# CHARからVARCHARに変換
ALTER TABLE students MODIFY name VARCHAR(10);
INSERT INTO students VALUES(2, "ABCDEF   ");
SELECT * FROM students;

# 値の長さを確認
SELECT name, CHAR_LENGTH(name) FROM students;

