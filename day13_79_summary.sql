-- データベースサーバー上の全利用可能データベース表示
SHOW DATABASES;

-- `dump_10_14_db` データベースを選択
USE `dump_10_14_db`;

-- 現在選択中のデータベース内の全テーブル表示
SHOW TABLES;

-- `employees` テーブルの全データ
SELECT
  *
FROM employees;

---

## ROW_NUMBER(), RANK(), DENSE_RANK()

これらは、結果セット内の行に順位や番号を付与する関数です。

-- `employees` テーブルの年齢順に行番号、ランク、高密度ランクを付与
-- `ROW_NUMBER()`: 重複値があっても一意の連番
-- `RANK()`: 重複値には同じランクを付与し、次のランクはスキップされる
-- `DENSE_RANK()`: 重複値には同じランクを付与し、次のランクはスキップされない
SELECT
  *,
  ROW_NUMBER() OVER (ORDER BY age),
  RANK() OVER (ORDER BY age),
  DENSE_RANK() OVER (ORDER BY age)
FROM employees;

---

## CUME_DIST(), PERCENT_RANK()

これらは、特定の行が全体のデータの中でどの位置にあるかを示す統計関数です。

-- 従業員の年齢を基準に、ランク、総カウント、パーセントランク、累積分布を算出
-- `PERCENT_RANK()`: (ランク-1) / (総行数-1) で算出される0から1の間のパーセンタイル
-- `CUME_DIST()`: (特定の行までのカウント) / (総行数) で算出される累積分布
SELECT
  age,
  RANK() OVER (ORDER BY age) AS row_rank,
  COUNT(*) OVER () AS cnt,
  PERCENT_RANK() OVER (ORDER BY age) AS p_age,
  CUME_DIST() OVER (ORDER BY age) AS c_age
FROM employees;

---

## LAG(), LEAD()

これらは、現在の行の前または後の行のデータにアクセスするための関数です。時系列データ分析などで役立ちます。

-- 顧客の年齢を昇順に並べ、現在の行の**前の**行の年齢を取得
SELECT
  age,
  LAG(age) OVER (ORDER BY age)
FROM customers;

-- 顧客の年齢を昇順に並べ、現在の行の**3つ前の**行の年齢を取得。該当がない場合はデフォルト値 `0`
SELECT
  age,
  LAG(age, 3, 0) OVER (ORDER BY age)
FROM customers;

-- 顧客の年齢を昇順に並べ、現在の行の**次の**行の年齢を取得
SELECT
  age,
  LEAD(age) OVER (ORDER BY age)
FROM customers;

-- 顧客の年齢を昇順に並べ、現在の行の**3つ後の**行の年齢を取得。該当がない場合はデフォルト値 `NULL`
SELECT
  age,
  LEAD(age, 3, NULL) OVER (ORDER BY age)
FROM customers;

---

## FIRST_VALUE(), LAST_VALUE()

これらは、ウィンドウフレーム内の最初または最後の値を返す関数です。

-- 部門IDごとに年齢の昇順で並べ、各部門の**年齢が最も若い**従業員のファーストネームを取得
SELECT
  *,
  FIRST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY age)
FROM employees;

-- 部門IDごとに年齢の昇順で並べ、各部門の**現在の行までで年齢が最も高い**従業員のファーストネームを取得 (デフォルトのウィンドウフレームのため)
SELECT
  *,
  LAST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY age)
FROM employees;

-- 部門IDごとに年齢の昇順で並べ、各部門の**年齢が最も高い**従業員のファーストネームを取得
-- `RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` でウィンドウフレームを部門全体に拡張
SELECT
  *,
  LAST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY age RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM employees;

---

## NTILE()

`NTILE(n)` は、結果セットを指定された `n` 個のグループに均等に分割し、各行がどのグループに属するかを示す番号を割り当てます。

-- 従業員を年齢順に2つのグループに分割（半分より少なければ1、多ければ2）
SELECT
  age,
  NTILE(2) OVER (ORDER BY age)
FROM employees;

---

## WHERE句とウィンドウ関数（サブクエリの利用）

ウィンドウ関数は `WHERE` 句で直接フィルタリングできません。そのため、**サブクエリ**や **CTE (Common Table Expression)** を使って、ウィンドウ関数の結果を一度生成し、その結果に対して `WHERE` 句を適用する必要があります。

-- 従業員を年齢順に10個のグループに分割し、そのうち8番目のグループに属する従業員のみを抽出
SELECT
  *
FROM (
  SELECT
    age,
    NTILE(10) OVER (ORDER BY age) AS ntile_value
  FROM employees
) AS tmp
WHERE
  tmp.ntile_value = 8;

