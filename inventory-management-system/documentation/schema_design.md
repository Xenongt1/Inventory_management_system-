# Schema Design Documentation for Inventory and Order Management System

## Introduction
This document provides an overview of the database schema design for the Inventory and Order Management System. It includes the Entity-Relationship Diagram (ERD) and detailed explanations of each table, their relationships, and constraints.

## Entity-Relationship Diagram (ERD)
[Insert ERD image or link here]

## Tables Overview

### 1. Customers
- **Description**: Stores information about customers.
- **Key Columns**: 
  - `customer_id` (Primary Key)
  - `name`
  - `email`
  - `phone`
  - `address`

### 2. Products
- **Description**: Contains details about products available for sale.
- **Key Columns**: 
  - `product_id` (Primary Key)
  - `name`
  - `description`
  - `price`
  - `category`

### 3. Orders
- **Description**: Records customer orders.
- **Key Columns**: 
  - `order_id` (Primary Key)
  - `customer_id` (Foreign Key)
  - `order_date`
  - `status`
  - `total_amount`

### 4. Order Items
- **Description**: Links products to orders, detailing quantities and prices.
- **Key Columns**: 
  - `order_item_id` (Primary Key)
  - `order_id` (Foreign Key)
  - `product_id` (Foreign Key)
  - `quantity`
  - `price`

### 5. Inventory
- **Description**: Tracks stock levels for products.
- **Key Columns**: 
  - `inventory_id` (Primary Key)
  - `product_id` (Foreign Key)
  - `quantity_in_stock`
  - `reorder_level`

## Relationships
- A **Customer** can have multiple **Orders** (One-to-Many).
- An **Order** can contain multiple **Order Items** (One-to-Many).
- A **Product** can be associated with multiple **Order Items** (One-to-Many).
- Each **Product** has a corresponding entry in the **Inventory** (One-to-One).

## Constraints
- Primary keys ensure each record is unique.
- Foreign keys maintain referential integrity between tables.
- Check constraints can be applied to ensure valid data entries (e.g., non-negative quantities).

## Conclusion
This schema design provides a robust foundation for managing inventory and orders efficiently. The relationships and constraints ensure data integrity and facilitate complex queries for reporting and analytics.