SHOW TABLES;
DESCRIBE people;

ALTER TABLE people ADD age INT AFTER name;
DESCRIBE people;

INSERT INTO people VALUES(1, "Donald", 28, "1950-01-01");
INSERT INTO people VALUES(2, "Jane", 34, "1989-02-15");
INSERT INTO people VALUES(3, "Michael", 45, "1978-03-22");
INSERT INTO people VALUES(4, "Emily", 29, "1994-05-10");
INSERT INTO people VALUES(5, "Chris", 50, "1973-07-30");
INSERT INTO people VALUES(6, "Sarah", 41, "1982-11-25");
INSERT INTO people VALUES(7, "David", 37, "1986-12-05");

SELECT * FROM people;

# ORDER BY (昇順)
SELECT * FROM people ORDER BY age;

# ORDER BY (降順)
SELECT * FROM people ORDER BY age desc;

# ORDER BY アルファベット
SELECT * FROM people ORDER BY name;

# 2つColumn
SELECT * FROM people ORDER BY birth_day, name;

# DISTINCT (重複)
SELECT DISTINCT birth_day FROM people;

# LIMIT
SELECT * FROM people LIMIT 3;

# 飛ばして表示 (3飛ばし2表示)
SELECT * FROM people LIMIT 3, 2;

# TRUNCATE
TRUNCATE people;
SELECT * FROM people;



