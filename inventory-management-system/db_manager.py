import mysql.connector
from mysql.connector import Error
from logger import FileLogger
import sys

# Configuration
DB_CONFIG = {
    'host': 'localhost',
    'database': 'inventory_system',
    'user': 'root',
    # 'password': 'password' # Uncomment and set your password if needed
}

def process_order(customer_id, product_id, quantity, password=None):
    """
    Connects to the DB and calls the ProcessNewOrder stored procedure.
    Logs the result to debug.log.
    """
    logger = FileLogger()
    
    if password:
        DB_CONFIG['password'] = password

    connection = None
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        
        if connection.is_connected():
            logger.log_info(f"Connected to MySQL database: {DB_CONFIG['database']}")
            
            cursor = connection.cursor()
            
            # Input parameters for the stored procedure
            args = (customer_id, product_id, quantity, 0, '') 
            
            logger.log_info(f"Attempting to process order: Customer={customer_id}, Product={product_id}, Qty={quantity}")

            # Call Stored Procedure
            # ProcessNewOrder(IN p_cust, IN p_prod, IN p_qty, OUT p_id, OUT p_msg)
            result_args = cursor.callproc('ProcessNewOrder', args)
            
            # Retrieve OUT parameters
            # p_order_id is at index 3, p_message is at index 4
            p_order_id = result_args[3]
            p_message = result_args[4]
            
            if p_order_id and p_order_id != 0:
                logger.log_transaction("ProcessNewOrder", f"Order ID: {p_order_id}, Product ID: {product_id}", "Success")
                logger.log_info(f"Database Message: {p_message}")
            else:
                logger.log_error(f"Order Failed. Database Message: {p_message}")

    except Error as e:
        logger.log_error(f"MySQL Error: {e}")
        
    except Exception as e:
        logger.log_error(f"Unexpected Error: {e}")

    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()
            logger.log_info("MySQL connection is closed")

if __name__ == "__main__":
    print("Inventory System Automation Tool")
    print("--------------------------------")
    
    # Simple CLI for interaction
    try:
        cust_id = int(input("Enter Customer ID: "))
        prod_id = int(input("Enter Product ID: "))
        qty = int(input("Enter Quantity: "))
        pwd = input("Enter MySQL Root Password (press Enter if none): ")
        
        process_order(cust_id, prod_id, qty, pwd if pwd else None)
        
    except ValueError:
        print("Invalid input. Please enter numbers for IDs and Quantity.")
