-- データベースサーバー上の全利用可能データベース表示
SHOW DATABASES;

-- `dump_10_14_db` データベースを選択
USE `dump_10_14_db`;

-- 現在選択中のデータベース内の全テーブル表示
SHOW TABLES;

-- ▼ 元データの確認（注文データ）
SELECT * FROM orders;

-- ▼ 注文日でソートして表示（集計の確認に便利）
SELECT * 
FROM orders 
ORDER BY order_date;

-- ▼ 累積売上の集計（注文日順に合計を足していく）
SELECT *, 
       SUM(order_price * order_amount) OVER (ORDER BY order_date) AS cumulative_sales
FROM orders;


-- ▼（BAD CASE）各注文行ごとの移動平均：※明確に誤りではないが、集計の粒度が細かすぎて意味がない
-- 「注文日」単位ではなく、「注文レコード」単位で集計されるため、1日に複数レコードがあると平均がブレる
SELECT *, 
       SUM(order_price * order_amount) OVER (
           ORDER BY order_date 
           ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS bad_7day_total
FROM orders;


-- ▼（GOOD CASE）1日単位で売上を集計した上で、移動平均を取る
-- 「注文日ごとの売上」を集計し、そのうえで7日間の移動平均を計算している
WITH daily_summary AS (
    SELECT 
        order_date, 
        SUM(order_price * order_amount) AS sale
    FROM orders 
    GROUP BY order_date
)
SELECT 
    order_date,
    sale,
    AVG(sale) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7day
FROM daily_summary;

-- ▼ 社員ごとの給与支払い合計と社員情報の結合（社員マスタと給与集計テーブルのJOIN）

SELECT * 
FROM employees AS emp
INNER JOIN (
    SELECT 
        employee_id, 
        SUM(payment) AS total_payment
    FROM salaries 
    GROUP BY employee_id
) AS summary_salary
ON emp.id = summary_salary.employee_id;
