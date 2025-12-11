SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS total_orders, 
    SUM(o.total_amount) AS total_spent 
FROM 
    customers c 
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id 
GROUP BY 
    c.customer_id 
ORDER BY 
    total_spent DESC 
LIMIT 10;

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS order_frequency 
FROM 
    customers c 
JOIN 
    orders o ON c.customer_id = o.customer_id 
GROUP BY 
    c.customer_id 
HAVING 
    order_frequency > 5 
ORDER BY 
    order_frequency DESC;

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    MAX(o.order_date) AS last_order_date 
FROM 
    customers c 
JOIN 
    orders o ON c.customer_id = o.customer_id 
GROUP BY 
    c.customer_id 
ORDER BY 
    last_order_date DESC;