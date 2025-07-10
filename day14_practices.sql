SHOW DATABASES;
USE `dump-day_10_14_db`;
SHOW TABLES;

# employeesテーブルとcustomersテーブルの両方から、それぞれidが10より小さいレコードを取り出します。両テーブルのfirst_name, last_name, ageカラムを取り出し、行方向に連結します。連結の際は、重複を削除するようにしてください
SELECT first_name, last_name, age
FROM employees
WHERE id < 10

UNION

SELECT first_name, last_name, age
FROM customers
WHERE id < 10

ORDER BY last_name, first_name;


# departmentsテーブルのnameカラムが営業部の人の、月収の最大値、最小値、平均値、合計値を計算してください。
# employeesテーブルのdepartment_idとdepartmentsテーブルのidが紐づけられ
# salariesテーブルのemployee_idとemployeesテーブルのidが紐づけられます。
# 月収はsalariesテーブルのpaymentカラムに格納されています
SELECT
    MAX(s.payment) AS max_payment,
    MIN(s.payment) AS min_payment,
    AVG(s.payment) AS avg_payment,
    SUM(s.payment) AS total_payment
FROM salaries s
JOIN employees e ON s.employee_id = e.id
JOIN departments d ON e.department_id = d.id
WHERE d.name = '営業部';

# classesテーブルのidが、5よりも小さいレコードとそれ以外のレコードを履修している生徒の数を計算してください。
# classesテーブルのidとenrollmentsテーブルのclass_id、enrollmentsテーブルのstudent_idとstudents.idが紐づく
# classesにはクラス名が格納されていて、studentsと多対多で結合される
SELECT
  CASE 
    WHEN c.id < 5 THEN 'id < 5'
    ELSE 'id >= 5'
  END AS class_group,
  COUNT(DISTINCT e.student_id) AS student_count
FROM classes c
JOIN enrollments e ON c.id = e.class_id
JOIN students s ON e.student_id = s.id
GROUP BY class_group;

# ageが40より小さい全従業員で月収の平均値が7,000,000よりも大きい人の、月収の合計値と平均値を計算してください。
# employeesテーブルのidとsalariesテーブルのemployee_idが紐づけでき、salariesテーブルのpaymentに月収が格納されています
SELECT
  SUM(sub.avg_payment) AS total_payment,
  AVG(sub.avg_payment) AS average_payment
FROM (
  SELECT e.id AS employee_id, AVG(s.payment) AS avg_payment
  FROM employees e
  JOIN salaries s ON e.id = s.employee_id
  WHERE e.age < 40
  GROUP BY e.id
  HAVING AVG(s.payment) > 7000000
) sub;

# customer毎に、order_amountの合計値を計算してください。
# customersテーブルとordersテーブルは、idカラムとcustomer_idカラムで紐づけができます
# ordersテーブルのorder_amountの合計値を取得します。
# SELECTの対象カラムに副問い合わせを用いて値を取得してください。
SELECT 
  c.id,
  c.first_name,
  c.last_name,
  (
    SELECT SUM(o.order_amount)
    FROM orders o
    WHERE o.customer_id = c.id
  ) AS total_order_amount
FROM customers c;

# customersテーブルからlast_nameに田がつくレコード、
# ordersテーブルからorder_dateが2020-12-01以上のレコード、
# storesテーブルからnameが山田商店のレコード同士を連結します
# customersとorders, ordersとitems, itemsとstoresが紐づきます。
# first_nameとlast_nameの値を連結(CONCAT)して集計(GROUP BY)し、そのレコード数をCOUNTしてください。
SELECT 
  CONCAT(c.first_name, c.last_name) AS full_name,
  COUNT(*) AS order_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN items i ON o.id = i.id
JOIN stores s ON i.store_id = s.id
WHERE c.last_name LIKE '%田%'
  AND o.order_date >= '2020-12-01'
  AND s.name = '山田商店'
GROUP BY full_name;

# salariesのpaymentが9,000,000よりも大きいものが存在するレコードを、employeesテーブルから取り出してください。
# employeesテーブルとsalariesテーブルを紐づけます。
# EXISTSとINとINNER JOIN、それぞれの方法で記載してください
SELECT *
FROM employees e
WHERE EXISTS (
  SELECT 1
  FROM salaries s
  WHERE s.employee_id = e.id
    AND s.payment > 9000000
);

SELECT DISTINCT e.*
FROM employees e
INNER JOIN salaries s ON e.id = s.employee_id
WHERE s.payment > 9000000;

# employeesテーブルから、salariesテーブルと紐づけのできないレコードを取り出してください。
# EXISTSとINとLEFT JOIN、それぞれの方法で記載してください
SELECT *
FROM employees e
WHERE NOT EXISTS (
  SELECT 1
  FROM salaries s
  WHERE s.employee_id = e.id
);

# employeesテーブルとcustomersテーブルのage同士を比較します
# customersテーブルの最小age, 平均age, 最大ageとemployeesテーブルのageを比較して、
# employeesテーブルのageが、最小age未満のものは最小未満、最小age以上で平均age未満のものは平均未満、
# 平均age以上で最大age未満のものは最大未満、それ以外はその他と表示します
# WITH句を用いて記述します
SELECT * FROM employees;
WITH customer_age_stats AS (
  SELECT 
    MIN(age) AS min_age,
    AVG(age) AS avg_age,
    MAX(age) AS max_age
  FROM customers
)
SELECT 
  e.id,
  e.first_name,
  e.age,
  cas.min_age,
  cas.avg_age,
  cas.max_age,
  CASE 
    WHEN e.age < cas.min_age THEN '最小未満'
    WHEN e.age >= cas.min_age AND e.age < cas.avg_age THEN '平均未満'
    WHEN e.age >= cas.avg_age AND e.age < cas.max_age THEN '最大未満'
    ELSE 'その他'
  END AS age_category
FROM employees e
CROSS JOIN customer_age_stats cas
ORDER BY e.age;

# customersテーブルからageが50よりも大きいレコードを取り出して、ordersテーブルと連結します。
# customersテーブルのidに対して、ordersテーブルのorder_amount*order_priceのorder_date毎の合計値。
# 合計値の7日間平均値、合計値の15日平均値、合計値の30日平均値を計算します。
# 7日間平均、15日平均値、30日平均値が計算できない区間(対象よりも前の日付のデータが十分にない区間)は、空白を表示してください。

WITH filtered_customers AS (
  SELECT *
  FROM customers
  WHERE age > 50
),
daily_sales AS (
  SELECT 
    c.id,
    c.name,
    c.age,
    o.order_date,
    SUM(o.order_amount * o.order_price) AS daily_total
  FROM filtered_customers c
  JOIN orders o ON c.id = o.customer_id
  GROUP BY c.id, c.name, c.age, o.order_date
),
moving_averages AS (
  SELECT 
    id,
    name,
    age,
    order_date,
    daily_total,
    -- 7日移動平均（7日分のデータがある場合のみ計算）
    CASE 
      WHEN COUNT(*) OVER (
        PARTITION BY id 
        ORDER BY order_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ) = 7 THEN 
        AVG(daily_total) OVER (
          PARTITION BY id 
          ORDER BY order_date 
          ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        )
      ELSE NULL
    END AS avg_7days,
    -- 15日移動平均（15日分のデータがある場合のみ計算）
    CASE 
      WHEN COUNT(*) OVER (
        PARTITION BY id 
        ORDER BY order_date 
        ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
      ) = 15 THEN 
        AVG(daily_total) OVER (
          PARTITION BY id 
          ORDER BY order_date 
          ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
        )
      ELSE NULL
    END AS avg_15days,
    -- 30日移動平均（30日分のデータがある場合のみ計算）
    CASE 
      WHEN COUNT(*) OVER (
        PARTITION BY id 
        ORDER BY order_date 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
      ) = 30 THEN 
        AVG(daily_total) OVER (
          PARTITION BY id 
          ORDER BY order_date 
          ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
        )
      ELSE NULL
    END AS avg_30days
  FROM daily_sales
)
SELECT 
  id,
  name,
  age,
  order_date,
  daily_total,
  CASE 
    WHEN avg_7days IS NULL THEN ''
    ELSE CAST(ROUND(avg_7days, 2) AS VARCHAR)
  END AS avg_7days,
  CASE 
    WHEN avg_15days IS NULL THEN ''
    ELSE CAST(ROUND(avg_15days, 2) AS VARCHAR)
  END AS avg_15days,
  CASE 
    WHEN avg_30days IS NULL THEN ''
    ELSE CAST(ROUND(avg_30days, 2) AS VARCHAR)
  END AS avg_30days
FROM moving_averages
ORDER BY id, order_date;


 