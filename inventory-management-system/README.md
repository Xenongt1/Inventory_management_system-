# Inventory and Order Management System

## Overview
The Inventory and Order Management System is designed to streamline the management of inventory and orders for businesses. This project provides a comprehensive database schema, along with SQL queries and stored procedures to facilitate efficient data handling and reporting.

## Project Structure
- `database/DDL.sql`: Creates all tables, keys, and constraints for the system.
- `database/DML.sql`: Seeds sample data and includes KPI/analytical queries, the `CustomerSalesSummary` view, and the `ProcessNewOrder` stored procedure.
- `ERD/`: Entity-relationship diagram assets.

## Setup Instructions
1. **Database Setup**: 
   - Create a new database for the Inventory and Order Management System.
   - Run `database/DDL.sql` to create tables, indexes, and constraints.
   - Run `database/DML.sql` to load seed data, KPI/analytical queries, the `CustomerSalesSummary` view, and the `ProcessNewOrder` procedure.

2. **Running Queries**: 
   - KPI and analytical examples are inside `database/DML.sql`. Adjust as needed for your reporting.

3. **Stored Procedures & Views**: 
   - `ProcessNewOrder` and `CustomerSalesSummary` are defined in `database/DML.sql`.

## Documentation
Refer to the files in the `documentation` directory for detailed information on the database schema design and a guide on how to use the SQL queries and stored procedures effectively.

## Contribution
Contributions to enhance the functionality and performance of the Inventory and Order Management System are welcome. Please follow the standard practices for contributing to open-source projects.