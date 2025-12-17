-- ============================================================================
-- INVENTORY AND ORDER MANAGEMENT SYSTEM - DML (DATA MANIPULATION LANGUAGE)
-- ============================================================================
-- This script contains seed data, views, and stored procedures for analysis
-- and order processing.

-- SECTION 1: SEED DATA

-- Insert sample customers (idempotent without IGNORE)
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, shipping_address) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '555-0101', '123 Elm St, Springfield, IL 62701'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '555-0102', '456 Oak Ave, Springfield, IL 62702'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-0103', '789 Pine Rd, Springfield, IL 62703'),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '555-0104', '321 Maple Dr, Springfield, IL 62704'),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com', '555-0105', '654 Cedar Ln, Springfield, IL 62705'),
(6, 'Diana', 'Wilson', 'diana.wilson@example.com', '555-0106', '987 Birch St, Springfield, IL 62706'),
(7, 'Edward', 'Miller', 'edward.miller@example.com', '555-0107', '246 Spruce Ave, Springfield, IL 62707'),
(8, 'Fiona', 'Moore', 'fiona.moore@example.com', '555-0108', '135 Ash Rd, Springfield, IL 62708'),
(9, 'George', 'Taylor', 'george.taylor@example.com', '555-0109', '579 Willow Dr, Springfield, IL 62709'),
(10, 'Hannah', 'Anderson', 'hannah.anderson@example.com', '555-0110', '802 Hickory Ln, Springfield, IL 62710'),
(11, 'Irene', 'Clark', 'irene.clark@example.com', '555-0111', '77 Walnut St, Springfield, IL 62711'),
(12, 'Jack', 'Lopez', 'jack.lopez@example.com', '555-0112', '88 Poplar Ave, Springfield, IL 62712'),
(13, 'Karen', 'Evans', 'karen.evans@example.com', '555-0113', '99 Aspen Rd, Springfield, IL 62713'),
(14, 'Leo', 'Price', 'leo.price@example.com', '555-0114', '101 Chestnut Blvd, Springfield, IL 62714'),
(15, 'Mia', 'Reed', 'mia.reed@example.com', '555-0115', '202 Cypress Ln, Springfield, IL 62715')
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    last_name = VALUES(last_name),
    phone = VALUES(phone),
    shipping_address = VALUES(shipping_address);

-- Insert sample products
INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99),
(2, 'Mechanical Keyboard', 'Electronics', 89.99),
(3, 'HDMI Cable', 'Accessories', 15.49),
(4, 'USB-C Hub', 'Accessories', 39.99),
(5, 'Laptop Stand', 'Furniture', 29.99),
(6, 'Office Chair', 'Furniture', 199.99),
(7, 'Desk Organizer', 'Furniture', 19.99),
(8, 'Webcam 1080p', 'Electronics', 49.99),
(9, 'Noise Cancelling Headphones', 'Electronics', 129.99),
(10, 'Portable Charger 10000mAh', 'Accessories', 34.99),
(11, 'USB-A Cable 6ft', 'Accessories', 8.99),
(12, 'Monitor Stand', 'Furniture', 44.99),
(13, 'Desk Lamp', 'Accessories', 24.99),
(14, 'Phone Case', 'Accessories', 12.99),
(15, 'Screen Protector', 'Accessories', 9.99),
(16, 'Bluetooth Speaker', 'Electronics', 59.99),
(17, 'Ergonomic Mouse Pad', 'Accessories', 14.99),
(18, 'Standing Desk', 'Furniture', 349.99),
(19, 'USB-C Charger 65W', 'Accessories', 49.99),
(20, 'Noise Meter', 'Electronics', 79.99)
ON DUPLICATE KEY UPDATE
    product_name = VALUES(product_name),
    category = VALUES(category),
    price = VALUES(price);

-- Insert inventory for products
INSERT INTO Inventory (product_id, quantity_on_hand) VALUES
(1, 150),
(2, 75),
(3, 200),
(4, 100),
(5, 50),
(6, 30),
(7, 120),
(8, 60),
(9, 40),
(10, 80),
(11, 250),
(12, 45),
(13, 90),
(14, 110),
(15, 180),
(16, 85),
(17, 140),
(18, 25),
(19, 95),
(20, 60)
ON DUPLICATE KEY UPDATE
    quantity_on_hand = VALUES(quantity_on_hand);

-- Insert sample orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2024-01-15 10:30:00', 115.97, 'Delivered'),
(2, 2, '2024-01-20 14:15:00', 89.99, 'Delivered'),
(3, 3, '2024-02-05 09:45:00', 249.98, 'Shipped'),
(4, 1, '2024-02-10 11:20:00', 64.98, 'Delivered'),
(5, 4, '2024-02-15 13:00:00', 159.97, 'Pending'),
(6, 5, '2024-03-01 15:30:00', 199.99, 'Delivered'),
(7, 2, '2024-03-05 10:15:00', 139.97, 'Shipped'),
(8, 6, '2024-03-10 12:45:00', 94.98, 'Delivered'),
(9, 7, '2024-03-15 14:20:00', 74.98, 'Delivered'),
(10, 3, '2024-03-20 16:00:00', 399.97, 'Pending'),
(11, 8, '2024-04-01 09:30:00', 129.99, 'Delivered'),
(12, 9, '2024-04-05 11:15:00', 184.97, 'Shipped'),
(13, 10, '2024-04-10 13:45:00', 64.97, 'Delivered'),
(14, 1, '2024-04-15 15:20:00', 224.97, 'Delivered'),
(15, 4, '2024-04-20 10:00:00', 149.98, 'Pending'),
(16, 11, '2024-05-02 11:05:00', 189.97, 'Delivered'),
(17, 12, '2024-05-06 14:30:00', 279.96, 'Shipped'),
(18, 13, '2024-05-09 09:50:00', 89.98, 'Delivered'),
(19, 14, '2024-05-12 10:45:00', 414.97, 'Delivered'),
(20, 15, '2024-05-15 13:15:00', 139.96, 'Pending'),
(21, 11, '2024-06-01 08:40:00', 349.98, 'Shipped'),
(22, 12, '2024-06-04 16:10:00', 104.98, 'Delivered'),
(23, 13, '2024-06-08 12:25:00', 289.97, 'Delivered'),
(24, 14, '2024-06-12 15:55:00', 179.97, 'Delivered'),
(25, 15, '2024-06-18 09:35:00', 229.96, 'Shipped')
ON DUPLICATE KEY UPDATE
    customer_id = VALUES(customer_id),
    order_date = VALUES(order_date),
    total_amount = VALUES(total_amount),
    status = VALUES(status);

-- Insert order items
INSERT INTO Order_Items (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 2, 25.99),
(1, 3, 1, 15.49),
(2, 2, 1, 89.99),
(3, 5, 3, 29.99),
(3, 7, 1, 19.99),
(4, 10, 1, 34.99),
(4, 11, 3, 8.99),
(5, 6, 1, 199.99),
(6, 6, 1, 199.99),
(7, 8, 1, 49.99),
(7, 13, 2, 24.99),
(8, 2, 1, 89.99),
(9, 1, 1, 25.99),
(9, 4, 1, 39.99),
(10, 9, 2, 129.99),
(10, 12, 1, 44.99),
(11, 9, 1, 129.99),
(12, 8, 1, 49.99),
(12, 14, 2, 12.99),
(13, 3, 2, 15.49),
(13, 11, 1, 8.99),
(14, 5, 4, 29.99),
(14, 13, 2, 24.99),
(15, 4, 2, 39.99),
(15, 15, 1, 9.99),
(16, 16, 2, 59.99),
(16, 17, 1, 14.99),
(17, 18, 1, 349.99),
(17, 3, 2, 15.49),
(18, 19, 2, 49.99),
(18, 11, 1, 8.99),
(19, 6, 1, 199.99),
(19, 8, 1, 49.99),
(19, 17, 1, 14.99),
(20, 2, 1, 89.99),
(20, 9, 1, 129.99),
(21, 18, 1, 349.99),
(21, 7, 2, 19.99),
(22, 16, 1, 59.99),
(22, 19, 1, 49.99),
(23, 20, 2, 79.99),
(23, 5, 1, 29.99),
(24, 10, 2, 34.99),
(24, 12, 1, 44.99),
(25, 4, 2, 39.99),
(25, 14, 2, 12.99)
ON DUPLICATE KEY UPDATE
    quantity = VALUES(quantity),
    price_at_purchase = VALUES(price_at_purchase);

 -- SECTION 2: KPI QUERIES (BUSINESS INTELLIGENCE)


-- KPI 1: TOTAL REVENUE
-- Calculate the total revenue from all 'Shipped' or 'Delivered' orders
SELECT 
    SUM(o.total_amount) AS total_revenue
FROM 
    Orders o
WHERE 
    o.status IN ('Shipped', 'Delivered');

-- KPI 2: TOP 10 CUSTOMERS BY SPENDING
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id
ORDER BY 
    total_spent DESC
LIMIT 10;
-- KPI 3: BEST-SELLING PRODUCTS (TOP 5 BY QUANTITY)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold
FROM 
    Products p
LEFT JOIN 
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id
ORDER BY 
    total_quantity_sold DESC
LIMIT 5;

-- KPI 4: MONTHLY SALES TREND
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(o.total_amount) AS total_revenue
FROM 
    Orders o
WHERE 
    o.status IN ('Shipped', 'Delivered')
GROUP BY 
    DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY 
    month DESC;

-- SECTION 3: ANALYTICAL QUERIES (WINDOW FUNCTIONS)

-- ANALYTICAL 1: SALES RANK BY CATEGORY
SELECT 
    p.category,
    p.product_id,
    p.product_name,
    COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS product_revenue,
    RANK() OVER (PARTITION BY p.category ORDER BY COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) DESC) AS revenue_rank
FROM 
    Products p
LEFT JOIN 
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY 
    p.category, p.product_id, p.product_name
ORDER BY 
    p.category, revenue_rank;

-- ANALYTICAL 2: CUSTOMER ORDER FREQUENCY
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_date AS current_order_date,
    LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS previous_order_date
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
ORDER BY 
    c.customer_id, o.order_date;

-- SECTION 4: VIEWS FOR PERFORMANCE OPTIMIZATION


-- VIEW 1: CUSTOMER SALES SUMMARY
CREATE OR REPLACE VIEW CustomerSalesSummary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.phone,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value,
    MAX(o.order_date) AS last_order_date,
    MIN(o.order_date) AS first_order_date,
    COALESCE(DATEDIFF(CURDATE(), MAX(o.order_date)), 0) AS days_since_last_order
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id AND o.status IN ('Shipped', 'Delivered')
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email, c.phone;

-- ============================================================================
-- SECTION 5: STORED PROCEDURES
-- ============================================================================

-- STORED PROCEDURE 1: PROCESS NEW ORDER
DELIMITER $$

CREATE PROCEDURE ProcessNewOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    OUT p_order_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE p_current_stock INT;
    DECLARE p_product_price DECIMAL(10, 2);
    DECLARE p_order_total DECIMAL(10, 2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_message = 'Transaction failed: Error processing order';
        SET p_order_id = 0;
        INSERT INTO SystemLog (
            event_type, severity, message, customer_id, order_id, product_id, details
        ) VALUES (
            'ORDER_PROCESS', 'ERROR', p_message, p_customer_id, NULL, p_product_id, 'Unhandled SQL exception in ProcessNewOrder'
        );
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        ROLLBACK;
        SET p_message = 'Error: Customer does not exist';
        SET p_order_id = 0;
        INSERT INTO SystemLog (
            event_type, severity, message, customer_id, order_id, product_id, details
        ) VALUES (
            'ORDER_PROCESS', 'ERROR', p_message, p_customer_id, NULL, p_product_id, 'Customer ID not found when processing order'
        );
    ELSEIF NOT EXISTS (SELECT 1 FROM Products WHERE product_id = p_product_id) THEN
        ROLLBACK;
        SET p_message = 'Error: Product does not exist';
        SET p_order_id = 0;
        INSERT INTO SystemLog (
            event_type, severity, message, customer_id, order_id, product_id, details
        ) VALUES (
            'ORDER_PROCESS', 'ERROR', p_message, p_customer_id, NULL, p_product_id, 'Product ID not found when processing order'
        );
    ELSE
        SELECT quantity_on_hand INTO p_current_stock
        FROM Inventory
        WHERE product_id = p_product_id
        FOR UPDATE;

        IF p_current_stock IS NULL THEN
            ROLLBACK;
            SET p_message = 'Error: Inventory record not found';
            SET p_order_id = 0;
            INSERT INTO SystemLog (
                event_type, severity, message, customer_id, order_id, product_id, details
            ) VALUES (
                'ORDER_PROCESS', 'ERROR', p_message, p_customer_id, NULL, p_product_id, 'Inventory record missing for product'
            );
        ELSEIF p_current_stock < p_quantity THEN
            ROLLBACK;
            SET p_message = CONCAT('Error: Insufficient stock. Available: ', p_current_stock, ', Requested: ', p_quantity);
            SET p_order_id = 0;
            INSERT INTO SystemLog (
                event_type, severity, message, customer_id, order_id, product_id, details
            ) VALUES (
                'ORDER_PROCESS', 'ERROR', p_message, p_customer_id, NULL, p_product_id,
                CONCAT('Insufficient stock. Available: ', p_current_stock, ', Requested: ', p_quantity)
            );
        ELSE
            SELECT price INTO p_product_price
            FROM Products
            WHERE product_id = p_product_id;

            SET p_order_total = p_quantity * p_product_price;

            INSERT INTO Orders (customer_id, order_date, total_amount, status)
            VALUES (p_customer_id, NOW(), p_order_total, 'Pending');

            SET p_order_id = LAST_INSERT_ID();

            INSERT INTO Order_Items (order_id, product_id, quantity, price_at_purchase)
            VALUES (p_order_id, p_product_id, p_quantity, p_product_price);

            UPDATE Inventory
            SET quantity_on_hand = quantity_on_hand - p_quantity
            WHERE product_id = p_product_id;

            COMMIT;
            SET p_message = CONCAT('Success: Order ', p_order_id, ' created successfully');
            INSERT INTO SystemLog (
                event_type, severity, message, customer_id, order_id, product_id, details
            ) VALUES (
                'ORDER_PROCESS', 'INFO', p_message, p_customer_id, p_order_id, p_product_id,
                CONCAT('Quantity: ', p_quantity, ', Unit price: ', p_product_price, ', Order total: ', p_order_total)
            );
        END IF;
    END IF;

END$$

DELIMITER ;
