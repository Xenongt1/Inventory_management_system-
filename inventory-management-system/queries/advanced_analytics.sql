SELECT 
    o.order_id,
    c.customer_name,
    SUM(oi.quantity) AS total_items,
    SUM(oi.quantity * p.price) AS total_revenue,
    COUNT(DISTINCT o.order_id) OVER (PARTITION BY c.customer_id) AS order_count,
    RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) AS revenue_rank
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    o.order_id, c.customer_name
ORDER BY 
    total_revenue DESC; 

WITH inventory_summary AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(i.quantity) AS total_inventory,
        SUM(oi.quantity) AS total_sold
    FROM 
        products p
    LEFT JOIN 
        inventory i ON p.product_id = i.product_id
    LEFT JOIN 
        order_items oi ON p.product_id = oi.product_id
    GROUP BY 
        p.product_id, p.product_name
)
SELECT 
    product_id,
    product_name,
    total_inventory,
    total_sold,
    total_inventory - total_sold AS remaining_stock
FROM 
    inventory_summary
WHERE 
    remaining_stock < 10
ORDER BY 
    remaining_stock ASC;