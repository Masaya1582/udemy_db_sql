-- 現在のデータベース一覧を表示します
SHOW DATABASES;

---
-- `dump_10_14_db` データベースを選択します
USE `dump_10_14_db`;

---
-- 現在選択されているデータベース内のテーブル一覧を表示します
SHOW TABLES;

---
-- 副問い合わせを使用しないバージョン
-- 「営業部」に所属する従業員の情報を、従業員テーブルと部署テーブルを結合して取得します
SELECT *
FROM employees AS e
INNER JOIN departments AS d
  ON e.department_id = d.id
WHERE d.name = "営業部";

---
-- WITH句（共通テーブル式）を使用するバージョン
-- 「営業部」の部署情報を一時テーブルとして定義し、その一時テーブルと従業員テーブルを結合して情報を取得します
WITH tmp_departments AS (
  SELECT *
  FROM departments
  WHERE name = "営業部"
)
SELECT *
FROM employees AS e
INNER JOIN tmp_departments
  ON e.department_id = tmp_departments.id;

---
-- 店舗ごとの合計売上を計算するクエリ
-- IDが1, 2, 3の店舗に限定し、関連する商品と注文情報を結合して売上を算出します
WITH tmp_stores AS (
  -- IDが1, 2, 3の店舗を一時テーブルとして選択します
  SELECT *
  FROM stores
  WHERE id IN (1, 2, 3)
), tmp_items_orders AS (
  -- 一時テーブルの店舗情報と、商品、注文情報を結合し、必要なカラムを選択します
  SELECT
    items.id AS item_id,
    tmp_stores.id AS store_id,
    orders.id AS order_id,
    orders.order_amount AS order_amount,
    orders.order_price AS order_price,
    tmp_stores.name AS store_name
  FROM tmp_stores
  INNER JOIN items
    ON tmp_stores.id = items.store_id
  INNER JOIN orders
    ON items.id = orders.item_id
)
-- 店舗名ごとに注文数量と注文価格の積を合計し、店舗ごとの総売上を算出します
SELECT
  store_name,
  SUM(order_amount * order_price) AS total_sales
FROM tmp_items_orders
GROUP BY
  store_name;