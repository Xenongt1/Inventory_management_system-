CREATE PROCEDURE generate_reports()
BEGIN
    -- Report for total sales by product
    SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold, SUM(oi.quantity * p.price) AS total_sales
    FROM order_items oi
    JOIN products p ON oi.product_id = p.id
    JOIN orders o ON oi.order_id = o.id
    WHERE o.status = 'completed'
    GROUP BY p.product_name
    ORDER BY total_sales DESC;

    -- Report for inventory status
    SELECT p.product_name, i.quantity AS inventory_quantity, p.reorder_level
    FROM products p
    JOIN inventory i ON p.id = i.product_id
    ORDER BY p.product_name;

    -- Report for total orders by customer
    SELECT c.customer_name, COUNT(o.id) AS total_orders, SUM(oi.quantity * p.price) AS total_spent
    FROM customers c
    JOIN orders o ON c.id = o.customer_id
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
    WHERE o.status = 'completed'
    GROUP BY c.customer_name
    ORDER BY total_spent DESC;
END;