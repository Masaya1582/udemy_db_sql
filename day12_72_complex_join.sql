-- 現在のデータベース一覧を表示します
SHOW DATABASES;

-- `dump_10_14_db` データベースを選択します
USE `dump_10_14_db`;

-- 現在選択されているデータベース内のテーブル一覧を表示します
SHOW TABLES;

---
## LEFT JOIN

-- employeesテーブルの全従業員と、対応する部門情報を取得します。
-- 部門情報がない従業員も表示し、そのdepartment_idは「該当なし」と表示されます。
SELECT
  emp.id,
  emp.first_name,
  emp.last_name,
  COALESCE(dt.id, '該当なし') AS department_id,
  dt.name AS department_name
FROM
  employees AS emp
LEFT JOIN
  departments AS dt
ON
  emp.department_id = dt.id;

-- students、enrollments、およびclassesテーブルをLEFT JOINで結合し、
-- 全ての生徒とそれに関連する履修情報、クラス情報を取得します。
-- 履修情報やクラス情報がない生徒も表示されます。
SELECT
  *
FROM
  students AS std
LEFT JOIN
  enrollments AS enr
ON
  std.id = enr.student_id
LEFT JOIN
  classes AS cs
ON
  enr.class_id = cs.id;

---
## RIGHT JOIN

-- students、enrollments、およびclassesテーブルをRIGHT JOINで結合し、
-- 全てのクラスとそれに関連する履修情報、生徒情報を取得します。
-- 生徒情報がない履修やクラスも表示されます。
SELECT
  *
FROM
  students AS std
RIGHT JOIN
  enrollments AS enr
ON
  std.id = enr.student_id
RIGHT JOIN
  classes AS cs
ON
  enr.class_id = cs.id;

---
## FULL JOIN (UNION を使用してシミュレート)

-- students、enrollments、およびclassesテーブルの完全外部結合をシミュレートします。
-- LEFT JOINとRIGHT JOINの結果をUNIONで結合することで、
-- どちらかのテーブルにのみ存在するレコードも全て取得します。
SELECT
  *
FROM
  students AS std
LEFT JOIN
  enrollments AS enr
ON
  std.id = enr.student_id
LEFT JOIN
  classes AS cs
ON
  enr.class_id = cs.id
UNION
SELECT
  *
FROM
  students AS std
RIGHT JOIN
  enrollments AS enr
ON
  std.id = enr.student_id
RIGHT JOIN
  classes AS cs
ON
  enr.class_id = cs.id;

---
## 複数テーブルの結合 (INNER JOIN)

-- customers、orders、items、storesの各テーブルをINNER JOINで結合し、
-- 顧客、注文、商品、店舗に関する情報を関連付けて取得します。
-- 全てのテーブルに一致するデータのみが表示されます。
SELECT
  ct.id,
  ct.last_name,
  od.item_id,
  od.order_amount,
  od.order_price,
  od.order_date,
  it.name AS item_name,
  st.name AS store_name
FROM
  customers AS ct
INNER JOIN
  orders AS od
ON
  ct.id = od.customer_id
INNER JOIN
  items AS it
ON
  od.item_id = it.id
INNER JOIN
  stores AS st
ON
  it.store_id = st.id
ORDER BY
  ct.id;

---
## 複数テーブルの結合と条件による絞り込み

-- customers_idが10で、かつorders.order_dateが'2020-08-01'より後の注文に絞り込んで、
-- 顧客、注文、商品、店舗に関する情報を取得します。
SELECT
  ct.id,
  ct.last_name,
  od.item_id,
  od.order_amount,
  od.order_price,
  od.order_date,
  it.name AS item_name,
  st.name AS store_name
FROM
  customers AS ct
INNER JOIN
  orders AS od
ON
  ct.id = od.customer_id
INNER JOIN
  items AS it
ON
  od.item_id = it.id
INNER JOIN
  stores AS st
ON
  it.store_id = st.id
WHERE
  ct.id = 10 AND od.order_date > '2020-08-01'
ORDER BY
  ct.id;

---
## サブクエリを使用した複数テーブルの結合と条件による絞り込み

-- サブクエリを使用して、事前にcustomersテーブルをidが10に、ordersテーブルをorder_dateが'2020-08-01'より後に絞り込んでから結合します。
-- これにより、メインクエリの結合処理を効率化できる場合があります。
SELECT
  ct.id,
  ct.last_name,
  od.item_id,
  od.order_amount,
  od.order_price,
  od.order_date,
  it.name AS item_name,
  st.name AS store_name
FROM
  (SELECT * FROM customers WHERE id = 10) AS ct
INNER JOIN
  (SELECT * FROM orders WHERE order_date > '2020-08-01') AS od
ON
  ct.id = od.customer_id
INNER JOIN
  items AS it
ON
  od.item_id = it.id
INNER JOIN
  stores AS st
ON
  it.store_id = st.id
ORDER BY
  ct.id;

---
## GROUP BY との結合

-- 各顧客の注文合計金額を計算し、その結果をcustomersテーブルと結合します。
-- これにより、各顧客のID、年齢、および注文合計金額を一覧で確認できます。
SELECT
  ct.*,
  order_summary.summary_price
FROM
  customers AS ct
INNER JOIN
  (SELECT customer_id, SUM(order_amount * order_price) AS summary_price FROM orders GROUP BY customer_id) AS order_summary
ON
  ct.id = order_summary.customer_id
ORDER BY
  ct.age;