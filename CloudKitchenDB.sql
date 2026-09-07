-- ============================================================
-- CLOUD KITCHEN PROJECT
-- SQL BUSINESS ANALYSIS
-- ============================================================

USE [CloudKitchenDB];


-- ============================================================
-- STEP 1: CHECK TABLES
-- ============================================================

SELECT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;


-- ============================================================
-- STEP 2: CHECK ROW COUNTS
-- ============================================================

SELECT 
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables AS t
INNER JOIN sys.partitions AS p
    ON t.object_id = p.object_id
WHERE p.index_id IN (0, 1)
GROUP BY t.name
ORDER BY t.name;


-- ============================================================
-- QUERY 1: TOP 10 RESTAURANTS BY REVENUE
-- ============================================================

SELECT TOP 10
    restaurant_id,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM dbo.orders
GROUP BY restaurant_id
ORDER BY total_revenue DESC;


-- ============================================================
-- QUERY 2: HIGH-REVENUE RESTAURANTS WITH RATINGS
-- ============================================================

SELECT TOP 10
    restaurant_id,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value,
    AVG(customer_rating) AS average_customer_rating
FROM dbo.orders
GROUP BY restaurant_id
HAVING COUNT(order_id) >= 200
ORDER BY total_revenue DESC;


-- ============================================================
-- QUERY 3: CUISINE PERFORMANCE
-- Business Question:
-- Which cuisines generate the highest orders and revenue?
-- ============================================================

SELECT
    ordered_cuisine AS cuisine,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM dbo.orders
GROUP BY ordered_cuisine
ORDER BY total_revenue DESC;



-- ============================================================
-- QUERY 4: PLATFORM PERFORMANCE
-- Business Question:
-- Which platforms generate the strongest order performance?
-- ============================================================

SELECT
    platform,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value,
    SUM(CASE 
            WHEN order_status = 'Delivered' THEN 1 
            ELSE 0 
        END) AS delivered_orders,
    SUM(CASE 
            WHEN order_status = 'Cancelled' THEN 1 
            ELSE 0 
        END) AS cancelled_orders,
    SUM(CASE 
            WHEN order_status = 'Failed' THEN 1 
            ELSE 0 
        END) AS failed_orders
FROM dbo.orders
GROUP BY platform
ORDER BY total_revenue DESC;


-- ============================================================
-- QUERY 5: DEMAND BY MEAL PERIOD
-- Business Question:
-- Which meal periods generate the highest demand and revenue?
-- ============================================================

SELECT
    meal_period,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value,
    SUM(CASE
            WHEN order_status = 'Delivered' THEN 1
            ELSE 0
        END) AS delivered_orders,
    SUM(CASE
            WHEN order_status = 'Cancelled' THEN 1
            ELSE 0
        END) AS cancelled_orders,
    SUM(CASE
            WHEN order_status = 'Failed' THEN 1
            ELSE 0
        END) AS failed_orders
FROM dbo.orders
GROUP BY meal_period
ORDER BY total_orders DESC;



-- ============================================================
-- QUERY 6: WEEKEND VS WEEKDAY DEMAND
-- Business Question:
-- How does weekend demand compare with weekday demand?
-- ============================================================

SELECT
    CASE
        WHEN is_weekend = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM dbo.orders
GROUP BY is_weekend
ORDER BY total_orders DESC;



-- ============================================================
-- QUERY 7: LOCALITY DEMAND AND REVENUE
-- Business Question:
-- Which localities currently generate the strongest demand?
-- ============================================================

SELECT
    l.locality_id,
    l.locality_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_value) AS total_revenue,
    AVG(o.order_value) AS average_order_value
FROM dbo.localities AS l
INNER JOIN dbo.orders AS o
    ON l.locality_id = o.locality_id
GROUP BY
    l.locality_id,
    l.locality_name
ORDER BY total_revenue DESC;



-- ============================================================
-- Query 8 — Demand + Competition by Locality
-- ============================================================
SELECT
    l.locality_name,
    l.competition_score,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_value) AS total_revenue,
    AVG(o.order_value) AS average_order_value
FROM dbo.localities AS l
INNER JOIN dbo.orders AS o
    ON l.locality_id = o.locality_id
GROUP BY
    l.locality_name,
    l.competition_score
ORDER BY
    total_revenue DESC;



-- ============================================================
-- Query 9 — Customer Segment Performance
-- ============================================================
SELECT
    customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM dbo.orders
GROUP BY customer_segment
ORDER BY total_revenue DESC;



-- ============================================================
-- Query 10 — Price Band Performance
-- ============================================================
SELECT
    price_band,
    COUNT(order_id) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM dbo.orders
GROUP BY price_band
ORDER BY total_revenue DESC;



-- ============================================================
-- QUERY 11: TOP RESTAURANT IN EACH LOCALITY
-- Business Question:
-- Which restaurant generates the highest revenue in each locality?
-- Demonstrates: CTE + Window Function (RANK)
-- ============================================================

WITH RestaurantRevenue AS
(
    SELECT
        locality_id,
        restaurant_id,
        COUNT(order_id) AS total_orders,
        SUM(order_value) AS total_revenue,
        AVG(order_value) AS average_order_value
    FROM dbo.orders
    GROUP BY
        locality_id,
        restaurant_id
),
RankedRestaurants AS
(
    SELECT
        locality_id,
        restaurant_id,
        total_orders,
        total_revenue,
        average_order_value,
        RANK() OVER
        (
            PARTITION BY locality_id
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM RestaurantRevenue
)
SELECT
    locality_id,
    restaurant_id,
    total_orders,
    total_revenue,
    average_order_value,
    revenue_rank
FROM RankedRestaurants
WHERE revenue_rank = 1
ORDER BY total_revenue DESC;


-- ============================================================
-- QUERY 12: CUSTOMERS ABOVE THEIR SEGMENT AVERAGE
-- Business Question:
-- Which customers generate more revenue than the average
-- customer within their customer segment?
-- Demonstrates: CTE + Subquery
-- ============================================================
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        customer_segment,
        COUNT(order_id) AS total_orders,
        SUM(order_value) AS total_revenue
    FROM dbo.orders
    GROUP BY
        customer_id,
        customer_segment
),
SegmentAverage AS
(
    SELECT
        customer_segment,
        AVG(total_revenue) AS segment_avg_revenue
    FROM CustomerRevenue
    GROUP BY customer_segment
)
SELECT
    c.customer_id,
    c.customer_segment,
    c.total_orders,
    c.total_revenue,
    s.segment_avg_revenue
FROM CustomerRevenue c
JOIN SegmentAverage s
    ON c.customer_segment = s.customer_segment
WHERE c.total_revenue > s.segment_avg_revenue
ORDER BY c.total_revenue DESC;
