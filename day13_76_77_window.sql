-- データベースサーバー上の全利用可能データベース表示
SHOW DATABASES;

-- `dump_10_14_db` データベースを選択
USE `dump_10_14_db`;

-- 現在選択中のデータベース内の全テーブル表示
SHOW TABLES;

-- `orders` テーブルの全列・全行取得
SELECT
  *
FROM orders;

---

## ウィンドウ関数: ORDER BY

`ORDER BY` 句を使ったウィンドウ関数。順序に基づいて集計値を計算。

-- 全従業員のカウント。`ORDER BY` なしで全体カウント
SELECT
  *,
  COUNT(*) OVER ()
FROM employees;

-- 年齢で並べた場合の累積カウント。年齢の昇順でレコードが増えるごとにカウントも増加
SELECT
  *,
  COUNT(*) OVER (ORDER BY age) AS tmp_count
FROM employees;

-- 注文日で並べた場合の累積注文価格合計。注文日の昇順で価格を累積加算
SELECT
  *,
  SUM(order_price) OVER (ORDER BY order_date)
FROM orders;

-- 注文日で降順に並べた場合の累積注文価格合計。注文日の降順で価格を累積加算
SELECT
  *,
  SUM(order_price) OVER (ORDER BY order_date DESC)
FROM orders;

-- 注文日、顧客IDの順で並べた場合の累積注文価格合計。複数のキーで順序付け
SELECT
  *,
  SUM(order_price) OVER (ORDER BY order_date, customer_id)
FROM orders;

-- 年齢階級で並べた場合の累積カウント。同じ年齢階級内ではカウントが同じになる
SELECT
  FLOOR(age / 10),
  COUNT(*) OVER (ORDER BY FLOOR(age / 10))
FROM employees;

---

## ウィンドウ関数: PARTITION BY + ORDER BY

`PARTITION BY` でグループ化し、そのグループ内で `ORDER BY` で順序付けして集計値を計算。

-- `employees` テーブルの全データ取得
SELECT
  *
FROM employees;

-- 部門IDごとの従業員数カウント
SELECT
  *,
  COUNT(*) OVER (PARTITION BY department_id)
FROM employees;

-- 部門IDごとに年齢の昇順で並べた累積カウント
-- 各部門内で、年齢が若い順にレコードが増えるごとにカウントが累積
SELECT
  *,
  COUNT(*) OVER (PARTITION BY department_id ORDER BY age) AS count_value
FROM employees;

-- 部門IDごとに年齢の昇順で並べた累積最大年齢
-- 各部門内で、年齢が若い順に見ていった場合のその時点での最大年齢
SELECT
  *,
  MAX(age) OVER (PARTITION BY department_id ORDER BY age) AS max_age_in_partition
FROM employees;

-- 部門IDごとに年齢の昇順で並べた累積最小年齢
-- 各部門内で、年齢が若い順に見ていった場合のその時点での最小年齢
SELECT
  *,
  MIN(age) OVER (PARTITION BY department_id ORDER BY age) AS min_age_in_partition
FROM employees;

-- `employees` と `salaries` テーブルを従業員IDで結合
SELECT
  *
FROM employees AS emp
INNER JOIN salaries AS sa
  ON emp.id = sa.employee_id;

-- 従業員ごとの最大収入（全期間）
-- 各従業員の全給与記録の中から最高額を抽出
SELECT
  *,
  MAX(payment) OVER (PARTITION BY emp.id) AS max_payment_per_employee
FROM employees AS emp
INNER JOIN salaries AS sa
  ON emp.id = sa.employee_id;

-- 月ごとの合計給与額（従業員ID順に累積）
-- 同じ支払い日（月）内で、従業員IDの昇順で給与額を累積
SELECT
  *,
  SUM(sa.payment) OVER (PARTITION BY sa.paid_date ORDER BY emp.id) AS cumulative_monthly_payment
FROM employees AS emp
INNER JOIN salaries AS sa
  ON emp.id = sa.employee_id;