SHOW DATABASES;
USE `day_4_9_db`;
SHOW TABLES;

# CASE、ORDER BY, UPDATE
SELECT * FROM prefectures
ORDER BY 
CASE
	WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN "近畿"
    ELSE "その他"
END;

SELECT *,
CASE
	WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN "近畿"
    ELSE "その他" END AS "地域名"
FROM prefectures
ORDER BY 
CASE
	WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN "四国"
    WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN "近畿"
    ELSE "その他"
END;

SELECT * FROM prefectures
ORDER BY 
CASE
	WHEN name IN("香川県", "愛媛県", "徳島県", "高知県") THEN 0
    WHEN name IN("兵庫県", "大阪府", "京都府", "滋賀県", "奈良県", "三重県", "和歌山県") THEN 1
    ELSE 2
END;

# UPDATE
SELECT * FROM users;
ALTER TABLE users ADD birth_era VARCHAR(2) AFTER birth_day;

SELECT *, 
CASE
	WHEN birth_day < "1989-01-07" THEN "昭和"
	WHEN birth_day < "2019-05-01" THEN "平成"
	WHEN birth_day >= "2019-05-01" THEN "令和"
	ELSE "不明"
END AS "元号"
FROM users;

UPDATE users 
SET birth_era = CASE
	WHEN birth_day < "1989-01-07" THEN "昭和"
	WHEN birth_day < "2019-05-01" THEN "平成"
	WHEN birth_day >= "2019-05-01" THEN "令和"
	ELSE "不明"
END;

SELECT * FROM users;

# CASEのNULL
SELECT * FROM customers WHERE name IS NULL;

# BADパターン
SELECT *,
CASE name
WHEN NULL THEN "不明"
ELSE ""
END AS "NULL CHECK"
FROM customers WHERE name IS NULL;

# GOODパターン
SELECT *,
CASE 
WHEN name IS NULL THEN "不明"
ELSE ""
END AS "NULL CHECK"
FROM customers WHERE name IS NULL;

SELECT *,
CASE 
WHEN name IS NULL THEN "不明"
WHEN name IS NOT NULL THEN "NULL以外"
ELSE ""
END AS "NULL CHECK"
FROM customers;







