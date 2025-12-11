-- ============================================================================
-- INVENTORY AND ORDER MANAGEMENT SYSTEM - DML (DATA MANIPULATION LANGUAGE)
-- ============================================================================
-- This script contains seed data, views, and stored procedures for analysis
-- and order processing.
-- ============================================================================

-- ============================================================================
-- SECTION 1: SEED DATA
-- ============================================================================
-- Drop existing procedures if they exist
DROP PROCEDURE IF EXISTS ProcessNewOrder;
DROP PROCEDURE IF EXISTS UpdateOrderStatus;
DROP PROCEDURE IF EXISTS GetCustomerOrderHistory;
-- Insert sample customers
INSERT IGNORE INTO Customers (first_name, last_name, email, phone, shipping_address) VALUES
('John', 'Doe', 'john.doe@example.com', '555-0101', '123 Elm St, Springfield, IL 62701'),
('Jane', 'Smith', 'jane.smith@example.com', '555-0102', '456 Oak Ave, Springfield, IL 62702'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555-0103', '789 Pine Rd, Springfield, IL 62703'),
('Bob', 'Brown', 'bob.brown@example.com', '555-0104', '321 Maple Dr, Springfield, IL 62704'),
('Charlie', 'Davis', 'charlie.davis@example.com', '555-0105', '654 Cedar Ln, Springfield, IL 62705'),
('Diana', 'Wilson', 'diana.wilson@example.com', '555-0106', '987 Birch St, Springfield, IL 62706'),
('Edward', 'Miller', 'edward.miller@example.com', '555-0107', '246 Spruce Ave, Springfield, IL 62707'),
('Fiona', 'Moore', 'fiona.moore@example.com', '555-0108', '135 Ash Rd, Springfield, IL 62708'),
('George', 'Taylor', 'george.taylor@example.com', '555-0109', '579 Willow Dr, Springfield, IL 62709'),
('Hannah', 'Anderson', 'hannah.anderson@example.com', '555-0110', '802 Hickory Ln, Springfield, IL 62710');

-- Insert sample products
INSERT IGNORE INTO Products (product_name, category, price) VALUES
('Wireless Mouse', 'Electronics', 25.99),
('Mechanical Keyboard', 'Electronics', 89.99),
('HDMI Cable', 'Accessories', 15.49),
('USB-C Hub', 'Accessories', 39.99),
('Laptop Stand', 'Furniture', 29.99),
('Office Chair', 'Furniture', 199.99),
('Desk Organizer', 'Furniture', 19.99),
('Webcam 1080p', 'Electronics', 49.99),
('Noise Cancelling Headphones', 'Electronics', 129.99),
('Portable Charger 10000mAh', 'Accessories', 34.99),
('USB-A Cable 6ft', 'Accessories', 8.99),
('Monitor Stand', 'Furniture', 44.99),
('Desk Lamp', 'Accessories', 24.99),
('Phone Case', 'Accessories', 12.99),
('Screen Protector', 'Accessories', 9.99);

-- Insert inventory for products
INSERT IGNORE INTO Inventory (product_id, quantity_on_hand) VALUES
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
(15, 180);

-- Insert sample orders
INSERT IGNORE INTO Orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-01-15 10:30:00', 115.97, 'Delivered'),
(2, '2024-01-20 14:15:00', 89.99, 'Delivered'),
(3, '2024-02-05 09:45:00', 249.98, 'Shipped'),
(1, '2024-02-10 11:20:00', 64.98, 'Delivered'),
(4, '2024-02-15 13:00:00', 159.97, 'Pending'),
(5, '2024-03-01 15:30:00', 199.99, 'Delivered'),
(2, '2024-03-05 10:15:00', 139.97, 'Shipped'),
(6, '2024-03-10 12:45:00', 94.98, 'Delivered'),
(7, '2024-03-15 14:20:00', 74.98, 'Delivered'),
(3, '2024-03-20 16:00:00', 399.97, 'Pending'),
(8, '2024-04-01 09:30:00', 129.99, 'Delivered'),
(9, '2024-04-05 11:15:00', 184.97, 'Shipped'),
(10, '2024-04-10 13:45:00', 64.97, 'Delivered'),
(1, '2024-04-15 15:20:00', 224.97, 'Delivered'),
(4, '2024-04-20 10:00:00', 149.98, 'Pending');

-- Insert order items
INSERT IGNORE INTO Order_Items (order_id, product_id, quantity, price_at_purchase) VALUES
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
(15, 15, 1, 9.99);

 -- SECTION 2: KPI QUERIES (BUSINESS INTELLIGENCE)


-- KPI 1: TOTAL REVENUE
-- Calculate the total revenue from all 'Shipped' or 'Delivered' orders
SELECT 
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    AVG(o.total_amount) AS average_order_value,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM 
    Orders o
WHERE 
    o.status IN ('Shipped', 'Delivered');

-- KPI 2: TOP 10 CUSTOMERS BY SPENDING
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS average_order_value,
    MAX(o.order_date) AS last_order_date
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
    p.price,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS number_of_orders
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
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS avg_order_value,
    COUNT(DISTINCT o.customer_id) AS unique_customers
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
    RANK() OVER (PARTITION BY p.category ORDER BY COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) DESC) AS revenue_rank,
    ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) DESC) AS row_num
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
    LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS previous_order_date,
    DATEDIFF(
        o.order_date,
        LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date)
    ) AS days_since_last_order,
    ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS order_number
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
ORDER BY 
    c.customer_id, o.order_date;

-- ANALYTICAL 3: RUNNING TOTAL OF REVENUE BY CUSTOMER
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (
        PARTITION BY c.customer_id 
        ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_spending
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

-- VIEW 2: PRODUCT PERFORMANCE SUMMARY
CREATE OR REPLACE VIEW ProductPerformanceSummary AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    COALESCE(i.quantity_on_hand, 0) AS current_stock,
    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
    COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS total_revenue,
    COALESCE(COUNT(DISTINCT oi.order_id), 0) AS number_of_orders,
    CASE 
        WHEN COALESCE(i.quantity_on_hand, 0) = 0 THEN 'Out of Stock'
        WHEN COALESCE(i.quantity_on_hand, 0) < 20 THEN 'Low Stock'
        WHEN COALESCE(i.quantity_on_hand, 0) < 50 THEN 'Medium Stock'
        ELSE 'Good Stock'
    END AS stock_status
FROM 
    Products p
LEFT JOIN 
    Inventory i ON p.product_id = i.product_id
LEFT JOIN 
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id, p.product_name, p.category, p.price, i.quantity_on_hand;

-- VIEW 3: ORDER SUMMARY WITH DETAILS
CREATE OR REPLACE VIEW OrderSummary AS
SELECT 
    o.order_id,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    o.order_date,
    o.total_amount,
    o.status,
    COUNT(DISTINCT oi.product_id) AS item_count,
    SUM(oi.quantity) AS total_items
FROM 
    Orders o
JOIN 
    Customers c ON o.customer_id = c.customer_id
LEFT JOIN 
    Order_Items oi ON o.order_id = oi.order_id
GROUP BY 
    o.order_id, c.customer_id, c.first_name, c.last_name, c.email, 
    o.order_date, o.total_amount, o.status;

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
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        ROLLBACK;
        SET p_message = 'Error: Customer does not exist';
        SET p_order_id = 0;
    ELSEIF NOT EXISTS (SELECT 1 FROM Products WHERE product_id = p_product_id) THEN
        ROLLBACK;
        SET p_message = 'Error: Product does not exist';
        SET p_order_id = 0;
    ELSE
        SELECT quantity_on_hand INTO p_current_stock
        FROM Inventory
        WHERE product_id = p_product_id;

        IF p_current_stock < p_quantity THEN
            ROLLBACK;
            SET p_message = CONCAT('Error: Insufficient stock. Available: ', p_current_stock, ', Requested: ', p_quantity);
            SET p_order_id = 0;
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
        END IF;
    END IF;

END$$

DELIMITER ;

-- STORED PROCEDURE 2: UPDATE ORDER STATUS
DELIMITER $$

CREATE PROCEDURE UpdateOrderStatus(
    IN p_order_id INT,
    IN p_new_status VARCHAR(50),
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE p_current_status VARCHAR(50);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_message = 'Error: Failed to update order status';
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM Orders WHERE order_id = p_order_id) THEN
        ROLLBACK;
        SET p_message = 'Error: Order does not exist';
    ELSE
        SELECT status INTO p_current_status
        FROM Orders
        WHERE order_id = p_order_id;

        IF p_current_status = 'Cancelled' THEN
            ROLLBACK;
            SET p_message = 'Error: Cannot update a cancelled order';
        ELSE
            UPDATE Orders
            SET status = p_new_status
            WHERE order_id = p_order_id;

            COMMIT;
            SET p_message = CONCAT('Success: Order ', p_order_id, ' status updated to ', p_new_status);
        END IF;
    END IF;

END$$

DELIMITER ;

-- STORED PROCEDURE 3: GET CUSTOMER ORDER HISTORY
DELIMITER $$

CREATE PROCEDURE GetCustomerOrderHistory(
    IN p_customer_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        SELECT 'Customer does not exist' AS error;
    ELSE
        SELECT 
            o.order_id,
            o.order_date,
            o.total_amount,
            o.status,
            GROUP_CONCAT(DISTINCT p.product_name SEPARATOR ', ') AS products,
            COUNT(DISTINCT oi.product_id) AS item_count,
            SUM(oi.quantity) AS total_items
        FROM 
            Orders o
        LEFT JOIN 
            Order_Items oi ON o.order_id = oi.order_id
        LEFT JOIN 
            Products p ON oi.product_id = p.product_id
        WHERE 
            o.customer_id = p_customer_id
        GROUP BY 
            o.order_id, o.order_date, o.total_amount, o.status
        ORDER BY 
            o.order_date DESC;
    END IF;

END$$

DELIMITER ;

-- ============================================================================
-- SECTION 6: ADDITIONAL UTILITY QUERIES
-- ============================================================================

-- LOW STOCK ALERT QUERY
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    i.quantity_on_hand,
    CASE 
        WHEN i.quantity_on_hand = 0 THEN 'OUT OF STOCK - URGENT'
        WHEN i.quantity_on_hand < 10 THEN 'CRITICAL - REORDER NOW'
        WHEN i.quantity_on_hand < 20 THEN 'LOW - MONITOR'
        ELSE 'ADEQUATE'
    END AS stock_status
FROM 
    Products p
LEFT JOIN 
    Inventory i ON p.product_id = i.product_id
WHERE 
    i.quantity_on_hand < 20
ORDER BY 
    i.quantity_on_hand ASC;

-- CATEGORY PERFORMANCE REPORT
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS num_products,
    COUNT(DISTINCT oi.order_id) AS num_orders,
    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
    COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS category_revenue,
    COALESCE(AVG(oi.price_at_purchase), 0) AS avg_product_price
FROM 
    Products p
LEFT JOIN 
    Order_Items oi ON p.product_id = oi.product_id
GROUP BY 
    p.category
ORDER BY 
    category_revenue DESC;

-- PENDING ORDERS REPORT
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.phone,
    o.order_date,
    o.total_amount,
    DATEDIFF(CURDATE(), DATE(o.order_date)) AS days_pending
FROM 
    Orders o
JOIN 
    Customers c ON o.customer_id = c.customer_id
WHERE 
    o.status = 'Pending'
ORDER BY 
    o.order_date ASC;

-- CUSTOMER SEGMENTATION
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    CASE 
        WHEN SUM(o.total_amount) >= 1000 THEN 'VIP'
        WHEN SUM(o.total_amount) >= 500 THEN 'High Value'
        WHEN SUM(o.total_amount) >= 100 THEN 'Regular'
        ELSE 'Prospect'
    END AS customer_segment,
    MAX(o.order_date) AS last_order_date
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email
ORDER BY 
    total_spent DESC;