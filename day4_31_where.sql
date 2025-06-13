SHOW DATABASES;

SHOW TABLES;
DESCRIBE users;

# usersテーブルから10件取得
SELECT * FROM users LIMIT 10;

SELECT * FROM users WHERE name = "奥村 成美";
SELECT * FROM users WHERE birth_place = "日本";

# 順番 = FROM → WHERE → ORDER BY → LIMIT
SELECT * FROM users WHERE birth_place <> "日本" ORDER BY age;

# 1 or 0
SELECT * FROM users WHERE is_admin = 1;

# UPDATE
UPDATE users SET name = "奥山 成美" WHERE id = 1;
SELECT * FROM users WHERE id = 1;

# DELETE
SELECT * FROM users ORDER BY id DESC LIMIT 1;
DELETE FROM users WHERE id = 200;
SELECT * FROM users ORDER BY id DESC LIMIT 1;


