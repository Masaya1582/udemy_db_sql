SELECT DATABASE();
USE my_db;
SHOW TABLES;

# Table名変更
ALTER TABLE users RENAME TO users_table;ALTER 
SHOW TABLES;
DESCRIBE users_table;

# Columnの削除
ALTER TABLE users_table DROP COLUMN message;ALTER 
DESCRIBE users_table;

# Columnの追加
ALTER TABLE users_table ADD post_code CHAR(8);
DESCRIBE users_table;

# Columnを特定のColumnの後に追加
ALTER TABLE users_table ADD gender CHAR(1) AFTER age;
DESCRIBE users_table;

# 一番最初のColumn
ALTER TABLE users_table ADD new_id INT FIRST;
DESCRIBE users_table;

# Columnの削除
ALTER TABLE users_table DROP COLUMN new_id;
DESCRIBE users_table;

# Columnの定義変更
ALTER TABLE users_table MODIFY name VARCHAR(50);
DESCRIBE users_table;

# Column名の変更
ALTER TABle users_table CHANGE COLUMN name 名前 VARCHAR(50);
DESCRIBE users_table;

# Column場所の変更
ALTER TABLE users_table CHANGE COLUMN gender gender CHAR(1) AFTER post_code;
DESCRIBE users_table;

# 主キーの削除
ALTER TABLE users_table DROP PRIMARY KEY;
DESCRIBE users_table;







