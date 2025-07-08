SHOW DATABASES;
USE `dump_10_14_db`;
SHOW TABLES;
SELECT
  *
FROM orders;

-- 全従業員の平均年齢算出。`OVER ()` 句は、集計関数 (AVG) が結果セット全体に適用される意
SELECT
  *,
  AVG(age) OVER () AS average_age -- 全従業員の平均年齢
FROM employees;

-- 部門ごとにデータを分割し、各部門の平均年齢と従業員数を算出
-- `PARTITION BY department` は、データを 'department' 列でグループ分け
-- `AVG(age) OVER (PARTITION BY department)` は、各部門の平均年齢を算出
-- `COUNT(*) OVER (PARTITION BY department)` は、各部門の従業員数をカウント
SELECT
  *,
  AVG(age) OVER (PARTITION BY department) AS avg_age_per_department, -- 部門ごとの平均年齢
  COUNT(*) OVER (PARTITION BY department) AS count_per_department -- 部門ごとの従業員数
FROM employees;

-- 従業員を10歳ごとの年齢階級にグループ化し、各年齢階級の従業員数をカウント
-- `FLOOR(age / 10)` は、年齢階級を特定
SELECT
  *,
  COUNT(*) OVER (PARTITION BY FLOOR(age / 10)) AS age_decade_count, -- 年齢階級ごとの従業員数
  FLOOR(age / 10) AS age_decade -- 年齢階級（例：20代なら2、30代なら3）
FROM employees;

-- 重複なしで年齢階級ごとの従業員数を表示
-- `DISTINCT` は、`age_decade_count` と `age_decade` の一意な組み合わせのみを返す
SELECT DISTINCT
  COUNT(*) OVER (PARTITION BY FLOOR(age / 10)) AS age_decade_count, -- 年齢階級ごとの従業員数
  FLOOR(age / 10) AS age_decade -- 年齢階級
FROM employees;

-- 「〇〇人」という形式で年齢階級ごとの従業員数を表示
-- `CONCAT()` は、カウントに「人」という文字列を追加
SELECT DISTINCT
  CONCAT(COUNT(*) OVER (PARTITION BY FLOOR(age / 10)), '人') AS age_decade_count_formatted, -- 「〇〇人」と表示
  FLOOR(age / 10) AS age_decade -- 年齢階級
FROM employees;

-- 注文日ごとに、各注文品目の合計金額を合算して総売上を算出
-- `order_amount * order_price` は、各注文品目の合計金額
-- `SUM(...) OVER (PARTITION BY order_date)` は、各注文日ごとの合計金額を合算
SELECT
  *,
  SUM(order_amount * order_price) OVER (PARTITION BY order_date) AS total_sales_per_day -- 注文日ごとの合計売上
FROM orders;

-- 月ごとにデータを分割し、各月の合計売上を算出
-- `DATE_FORMAT(order_date, '%Y/%m')` は、注文日から「年/月」の形式（例: '2023/01'）を抽出
-- `SUM(...) OVER (PARTITION BY DATE_FORMAT(order_date, '%Y/%m'))` は、各月ごとの売上を合算
SELECT
  *,
  SUM(order_amount * order_price) OVER (PARTITION BY DATE_FORMAT(order_date, '%Y/%m')) AS total_sales_per_month -- 月ごとの合計売上
FROM orders;