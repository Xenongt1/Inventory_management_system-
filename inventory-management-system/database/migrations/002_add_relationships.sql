ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (customer_id) REFERENCES Customers(id);

ALTER TABLE Order_Items
ADD CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY (order_id) REFERENCES Orders(id),
ADD CONSTRAINT FK_OrderItems_Products
FOREIGN KEY (product_id) REFERENCES Products(id);

ALTER TABLE Inventory
ADD CONSTRAINT FK_Inventory_Products
FOREIGN KEY (product_id) REFERENCES Products(id);