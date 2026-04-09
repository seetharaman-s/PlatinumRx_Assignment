-- Q1. For every user in the system, get the user_id and the LAST booked room_no

SELECT
    u.user_id,
    u.name,
    b.room_no   AS last_booked_room_no,
    b.booking_date AS last_booking_date
FROM users u
JOIN bookings b
    ON u.user_id = b.user_id
JOIN (
    SELECT user_id, MAX(booking_date) AS max_date
    FROM   bookings
    GROUP  BY user_id
) latest
    ON b.user_id    = latest.user_id
   AND b.booking_date = latest.max_date;

-- Q2. Get booking_id and TOTAL BILLING AMOUNT of every booking created in November 2021

SELECT
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc
    ON b.booking_id = bc.booking_id
JOIN items i
    ON bc.item_id = i.item_id
WHERE YEAR(b.booking_date)  = 2021
  AND MONTH(b.booking_date) = 11          
GROUP BY b.booking_id;

-- Q3. Get bill_id and BILL AMOUNT of all bills raised in October 2021 having bill amount > 1000

SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i
    ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date)  = 2021
  AND MONTH(bc.bill_date) = 10            
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4. Determine the MOST and LEAST ordered item of each month of year 2021

WITH monthly_item_totals AS (
    SELECT
        MONTH(bc.bill_date)           AS order_month,
        MONTHNAME(bc.bill_date)       AS month_name,
        i.item_id,
        i.item_name,
        SUM(bc.item_quantity)         AS total_qty
    FROM booking_commercials bc
    JOIN items i
        ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), MONTHNAME(bc.bill_date), i.item_id, i.item_name
),
ranked AS (
    SELECT
        order_month,
        month_name,
        item_id,
        item_name,
        total_qty,
        RANK() OVER (PARTITION BY order_month ORDER BY total_qty DESC) AS rank_most,
        RANK() OVER (PARTITION BY order_month ORDER BY total_qty ASC)  AS rank_least
    FROM monthly_item_totals
)
SELECT
    order_month,
    month_name,
    MAX(CASE WHEN rank_most  = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rank_most  = 1 THEN total_qty  END) AS most_ordered_qty,
    MAX(CASE WHEN rank_least = 1 THEN item_name END) AS least_ordered_item,
    MAX(CASE WHEN rank_least = 1 THEN total_qty  END) AS least_ordered_qty
FROM ranked
WHERE rank_most = 1 OR rank_least = 1
GROUP BY order_month, month_name
ORDER BY order_month;

-- Q5. Find the customers with the SECOND HIGHEST BILL VALUE of each month of year 2021

WITH bill_totals AS (
    SELECT
        MONTH(bc.bill_date)                       AS bill_month,
        MONTHNAME(bc.bill_date)                   AS month_name,
        bc.booking_id,
        b.user_id,
        u.name                                    AS customer_name,
        SUM(bc.item_quantity * i.item_rate)       AS total_bill_value
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users    u ON b.user_id     = u.user_id
    JOIN items    i ON bc.item_id    = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY
        MONTH(bc.bill_date),
        MONTHNAME(bc.bill_date),
        bc.booking_id,
        b.user_id,
        u.name
),
ranked_bills AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY bill_month
            ORDER BY total_bill_value DESC
        ) AS bill_rank
    FROM bill_totals
)
SELECT
    bill_month,
    month_name,
    booking_id,
    user_id,
    customer_name,
    total_bill_value  AS second_highest_bill_value
FROM ranked_bills
WHERE bill_rank = 2
ORDER BY bill_month;

