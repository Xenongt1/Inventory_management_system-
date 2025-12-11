SELECT 
    p.product_id,
    p.product_name,
    SUM(i.quantity) AS total_quantity,
    SUM(o.total_amount) AS total_sales,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    products p
LEFT JOIN 
    inventory i ON p.product_id = i.product_id
LEFT JOIN 
    order_items oi ON p.product_id = oi.product_id
LEFT JOIN 
    orders o ON oi.order_id = o.order_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    total_sales DESC; 

-- Query to get low stock products
SELECT 
    p.product_id,
    p.product_name,
    i.quantity AS current_stock
FROM 
    products p
JOIN 
    inventory i ON p.product_id = i.product_id
WHERE 
    i.quantity < 10
ORDER BY 
    i.quantity ASC; 

-- Query to get inventory status by category
SELECT 
    p.category,
    SUM(i.quantity) AS total_quantity
FROM 
    products p
JOIN 
    inventory i ON p.product_id = i.product_id
GROUP BY 
    p.category
ORDER BY 
    total_quantity DESC;