SELECT DATABASE();
DESCRIBE customers;

# NULL値取り出し
SELECT * FROM customers WHERE name IS NULL;

# Not NULL値取り出し
SELECT * FROM customers WHERE name IS NOT NUll;

# 空白
SELECT * FROM prefectures;
SELECT * FROM prefectures WHERE name = "";

# Between, NOT BETWEEN
SELECT * FROM users WHERE age BETWEEN 5 AND 10;

# LIKE, NOT LIKE
SELECT * FROM users WHERE name LIKE "村%"; -- 前方一致
SELECT * FROM users WHERE name LIKE "%三郎"; -- 後方一致
SELECT * FROM users WHERE name LIKE "%ed%"; -- 中間一致
SELECT * FROM prefectures WHERE name LIKE "福_県"; -- _一致



