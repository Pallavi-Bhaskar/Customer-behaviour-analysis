-- Total records
SELECT COUNT(*) FROM customer;

-- Distinct customers
SELECT COUNT(DISTINCT customer_id) FROM customer;

-- Null check (important columns)
SELECT 
    SUM(CASE WHEN purchase_amount IS NULL THEN 1 ELSE 0 END) AS null_purchase,
    SUM(CASE WHEN review_rating IS NULL THEN 1 ELSE 0 END) AS null_rating
FROM customer;

-- REVENUE ANALYSIS

-- Total revenue
SELECT SUM(purchase_amount) AS total_revenue FROM customer;

-- Revenue by gender
SELECT gender, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender
ORDER BY revenue DESC;

-- Revenue by category
SELECT category, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY category
ORDER BY revenue DESC;

-- Revenue by age group
SELECT age_buckets, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY age_buckets;

-- CUSTOMER SEGMENTATION

-- Revenue by gender
SELECT gender, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender;

-- Subscription impact
SELECT 
    subscription_status,
    AVG(purchase_amount) AS avg_spend,
    SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY subscription_status;

--CUSTOMER BEHAVIOUR

-- Customer type segmentation
SELECT 
    CASE 
        WHEN previous_purchases = 0 THEN 'New'
        WHEN previous_purchases <= 5 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_type,
    COUNT(*) AS customers,
    AVG(purchase_amount) AS avg_spend
FROM customer
GROUP BY 
    CASE 
        WHEN previous_purchases = 0 THEN 'New'
        WHEN previous_purchases <= 5 THEN 'Returning'
        ELSE 'Loyal'
    END;

--DISCOUNT ANALYSIS 

SELECT 
    discount_applied,
    COUNT(*) AS orders,
    AVG(purchase_amount) AS avg_spend
FROM customer
GROUP BY discount_applied;

-- PRODUCT AND CATEGORY PERFORMANCE 

-- Top products by revenue
SELECT TOP 5 item_purchased, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY item_purchased
ORDER BY revenue DESC;

-- Top products by rating
SELECT TOP 5 item_purchased, AVG(review_rating) AS avg_rating
FROM customer
GROUP BY item_purchased
ORDER BY avg_rating DESC;

-- SHIPPING EXPERIENCE 

SELECT 
    shipping_type,
    AVG(review_rating) AS avg_rating,
    AVG(purchase_amount) AS avg_spend
FROM customer
GROUP BY shipping_type;

-- SEASONAL TRENDS

SELECT 
    season,
    SUM(purchase_amount) AS revenue,
    COUNT(*) AS orders
FROM customer
GROUP BY season
ORDER BY revenue DESC;

-- PURCHASE BEHAIVIOUR

SELECT 
    payment_method,
    COUNT(*) AS usage,
    AVG(purchase_amount) AS avg_spend
FROM customer
GROUP BY payment_method
ORDER BY usage DESC;

-- PURCHASE FREQUENCY IMPACT

SELECT 
    frequency_of_purchases,
    AVG(purchase_amount) AS avg_spend,
    COUNT(*) AS customers
FROM customer
GROUP BY frequency_of_purchases;