-- Q1. Find the revenue from EACH SALES CHANNEL in a given year

SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021          
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- Q2. Find the TOP 10 MOST VALUABLE CUSTOMERS for a given year

SELECT
    cs.uid,
    c.name          AS customer_name,
    c.mobile,
    SUM(cs.amount)  AS total_spend
FROM clinic_sales cs
JOIN customer c
    ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021      
GROUP BY cs.uid, c.name, c.mobile
ORDER BY total_spend DESC
LIMIT 10;

-- Q3. Month-wise REVENUE, EXPENSE, PROFIT and STATUS (Profitable / Not-Profitable) for a given year

WITH monthly_revenue AS (
    SELECT
        MONTH(datetime)     AS month_num,
        MONTHNAME(datetime) AS month_name,
        SUM(amount)         AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime), MONTHNAME(datetime)
),
monthly_expenses AS (
    SELECT
        MONTH(datetime)     AS month_num,
        SUM(amount)         AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT
    r.month_num,
    r.month_name,
    r.total_revenue,
    COALESCE(e.total_expense, 0)                          AS total_expense,
    (r.total_revenue - COALESCE(e.total_expense, 0))      AS profit,
    CASE
        WHEN (r.total_revenue - COALESCE(e.total_expense, 0)) > 0
             THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expenses e
    ON r.month_num = e.month_num
ORDER BY r.month_num;


-- Q4. For each CITY find the MOST PROFITABLE CLINIC for a given month

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        COALESCE(SUM(cs.amount),   0) AS revenue,
        COALESCE(SUM(ex.amount),   0) AS expense,
        COALESCE(SUM(cs.amount),0) - COALESCE(SUM(ex.amount),0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
        ON cl.cid = cs.cid
       AND YEAR(cs.datetime)  = 2021    
       AND MONTH(cs.datetime) = 3       
    LEFT JOIN expenses ex
        ON cl.cid = ex.cid
       AND YEAR(ex.datetime)  = 2021
       AND MONTH(ex.datetime) = 3
    GROUP BY cl.cid, cl.clinic_name, cl.city
),
ranked AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rk
    FROM clinic_profit
)
SELECT
    city,
    cid,
    clinic_name,
    revenue,
    expense,
    profit AS most_profitable_clinic_profit
FROM ranked
WHERE rk = 1
ORDER BY city;


-- Q5. For each STATE find the SECOND LEAST PROFITABLE CLINIC for a given month

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(ex.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs
        ON cl.cid = cs.cid
       AND YEAR(cs.datetime)  = 2021    
       AND MONTH(cs.datetime) = 3       
    LEFT JOIN expenses ex
        ON cl.cid = ex.cid
       AND YEAR(ex.datetime)  = 2021
       AND MONTH(ex.datetime) = 3
    GROUP BY cl.cid, cl.clinic_name, cl.state
),
ranked AS (
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rk
    FROM clinic_profit
)
SELECT
    state,
    cid,
    clinic_name,
    profit AS second_least_profit
FROM ranked
WHERE rk = 2
ORDER BY state;
