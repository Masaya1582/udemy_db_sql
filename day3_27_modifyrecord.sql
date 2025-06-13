SELECT DATABASE();
USE my_db;

# Table作成
CREATE TABLE people(
 id INT PRIMARY KEY,
 name VARCHAR(50),
 birth_day DATE DEFAULT "1990-01-01"
);
DESCRIBE people;

# 値の追加
INSERT INTO people VALUES(1, "Taro", "2001-01-01");
SELECT * FROM people;

# INSERTのColumn指定
INSERT INTO people(id, name) VALUES(2, "JIRO");
SELECT * FROM people;

# シングルクォート
INSERT INTO people(id, name) VALUES(3, 'SABURO');
SELECT * FROM people;

# シングルクォートの中にダブルクォート
INSERT INTO people VALUES(4, 'John"s brother', '2021-01-01');
SELECT * FROM people;

# 全レコード、全カラム
SELECT * FROM people;

# カラムの一部
SELECT id FROM people;

# as付け
SELECT id AS "番号", name AS "名前" FROM people;

# WHERE絞り
SELECT * FROM people WHERE id = 3;

# UPDATE文 (全レコード)
UPDATE people SET birth_day = "1919-01-01";
SELECT * FROM people;

# UPDATE WHERE
UPDATE people SET name = "Donald", birth_day = "1929-01-01" WHERE id = 3;
SELECT * FROM people;

# DELETE
DELETE FROM people WHERE id = 2;
SELECT * FROM people;





