CREATE PROCEDURE process_order (
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    OUT p_order_id INT
)
BEGIN
    DECLARE v_inventory_count INT;

    -- Check inventory for the product
    SELECT quantity INTO v_inventory_count
    FROM inventory
    WHERE product_id = p_product_id;

    IF v_inventory_count >= p_quantity THEN
        -- Insert new order
        INSERT INTO orders (customer_id, order_date, status)
        VALUES (p_customer_id, NOW(), 'Pending');

        SET p_order_id = LAST_INSERT_ID();

        -- Insert order items
        INSERT INTO order_items (order_id, product_id, quantity)
        VALUES (p_order_id, p_product_id, p_quantity);

        -- Update inventory
        CALL update_inventory(p_product_id, p_quantity);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient inventory for the requested product.';
    END IF;
END;