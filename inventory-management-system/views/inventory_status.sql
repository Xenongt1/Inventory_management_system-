CREATE VIEW inventory_status AS
SELECT 
    p.product_id,
    p.product_name,
    i.quantity_on_hand,
    i.reorder_level,
    (i.quantity_on_hand - COALESCE(SUM(oi.quantity), 0)) AS available_quantity
FROM 
    products p
JOIN 
    inventory i ON p.product_id = i.product_id
LEFT JOIN 
    order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id, p.product_name, i.quantity_on_hand, i.reorder_level;