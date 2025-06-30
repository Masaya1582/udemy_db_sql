-- 現在のデータベース一覧を表示します
SHOW DATABASES;

-- `dump_10_14_db` データベースを選択します
USE `dump_10_14_db`;

-- 現在選択されているデータベース内のテーブル一覧を表示します
SHOW TABLES;

---
## SELF JOIN

-- 同じ `employees` テーブルを2回参照し、`manager_id` を使って従業員とその上司の名前、年齢を関連付けます。
-- `emp1` が部下、`emp2` が上司を表します。
SELECT
  CONCAT(emp1.last_name, emp1.first_name) AS "部下の名前",
  emp1.age AS "部下の年齢",
  CONCAT(emp2.last_name, emp2.first_name) AS "上司の名前", 
  emp2.age AS "上司の年齢"
FROM
  employees AS emp1
INNER JOIN
  employees AS emp2
ON
  emp1.manager_id = emp2.id;

---
## CROSS JOIN

-- `employees` テーブル自身とCROSS JOINを実行し、テーブルの全ての行の組み合わせを生成します。
-- `ON` 句はCROSS JOINでは通常使用されませんが、ここでは `emp1.id < emp2.id` という条件で特定の組み合わせに絞り込んでいます。
-- （一般的なデータベースシステムではCROSS JOINの後にWHERE句で条件を指定するのがより標準的です。）
SELECT
  *
FROM
  employees AS emp1
CROSS JOIN
  employees AS emp2
ON
  emp1.id < emp2.id;

---
## 計算結果とCASE文 (顧客の平均年齢との比較)

-- `customers` テーブルの各顧客について、全体の平均年齢と比較し、
-- その顧客の年齢が平均年齢よりも高い場合は「○」、そうでない場合は「×」を表示します。
SELECT
  *,
  CASE
    WHEN cs.age > summary_customers.avg_age THEN "○"
    ELSE "×"
  END AS "平均年齢よりも年齢が高いか"
FROM
  customers AS cs
CROSS JOIN
  (SELECT AVG(age) AS avg_age FROM customers) AS summary_customers;

---
## 計算結果とCASE文 (従業員の平均月収との比較)

-- 各従業員の月収が全従業員の平均月収以上であるかを判定し、
-- 平均月収以上の場合は「○」、そうでない場合は「×」を表示します。
-- `employees` と `salaries` を結合し、平均月収はサブクエリで取得しています。
SELECT
  emp.id,
  CASE
    WHEN AVG(sa.payment) >= summary.avg_payment THEN "○"
    ELSE "×"
  END AS "平均月収以上か"
FROM
  employees AS emp
INNER JOIN
  salaries AS sa
ON
  emp.id = sa.employee_id
CROSS JOIN
  (SELECT AVG(payment) AS avg_payment FROM salaries) AS summary
GROUP BY
  emp.id;