CREATE PROCEDURE update_inventory (
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_current_quantity INT;

    -- Get the current inventory level for the product
    SELECT quantity INTO v_current_quantity
    FROM inventory
    WHERE product_id = p_product_id;

    -- Update the inventory level
    UPDATE inventory
    SET quantity = v_current_quantity + p_quantity
    WHERE product_id = p_product_id;

    -- Optionally, you can add error handling or logging here
END;