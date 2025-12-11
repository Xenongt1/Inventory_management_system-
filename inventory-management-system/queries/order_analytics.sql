SELECT 
    o.order_id,
    o.order_date,
    SUM(oi.quantity * p.price) AS total_revenue,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    COUNT(oi.order_item_id) AS total_items
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    o.order_id, o.order_date
ORDER BY 
    o.order_date DESC; 

-- Query to analyze order trends over time
SELECT 
    DATE(o.order_date) AS order_date,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * p.price) AS total_revenue
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    DATE(o.order_date)
ORDER BY 
    order_date; 

-- Query to find the most popular products based on order quantity
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM 
    order_items oi
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 10; 

-- Query to analyze order status distribution
SELECT 
    o.status,
    COUNT(o.order_id) AS order_count,
    SUM(oi.quantity * p.price) AS total_revenue
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    o.status;