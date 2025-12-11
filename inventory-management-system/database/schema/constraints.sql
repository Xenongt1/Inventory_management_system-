-- This file defines the constraints for the tables, including primary keys, foreign keys, and check constraints to ensure data integrity.

-- Customers Table Constraints
ALTER TABLE Customers
ADD CONSTRAINT PK_Customers PRIMARY KEY (customer_id);

-- Products Table Constraints
ALTER TABLE Products
ADD CONSTRAINT PK_Products PRIMARY KEY (product_id);

-- Orders Table Constraints
ALTER TABLE Orders
ADD CONSTRAINT PK_Orders PRIMARY KEY (order_id);

-- Order Items Table Constraints
ALTER TABLE Order_Items
ADD CONSTRAINT PK_Order_Items PRIMARY KEY (order_item_id),
ADD CONSTRAINT FK_Order_Items_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
ADD CONSTRAINT FK_Order_Items_Products FOREIGN KEY (product_id) REFERENCES Products(product_id);

-- Inventory Table Constraints
ALTER TABLE Inventory
ADD CONSTRAINT PK_Inventory PRIMARY KEY (inventory_id),
ADD CONSTRAINT FK_Inventory_Products FOREIGN KEY (product_id) REFERENCES Products(product_id);

-- Check Constraints
ALTER TABLE Products
ADD CONSTRAINT CHK_Products_Price CHECK (price >= 0);

ALTER TABLE Inventory
ADD CONSTRAINT CHK_Inventory_Quantity CHECK (quantity >= 0);