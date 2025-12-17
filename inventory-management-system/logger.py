import logging
import os
from datetime import datetime

class FileLogger:
    def __init__(self, log_file="debug.log"):
        """
        Initialize the logger.
        :param log_file: The name of the file to write logs to.
        """
        self.log_file = log_file
        
        # Configure logging
        logging.basicConfig(
            filename=self.log_file,
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        self.logger = logging.getLogger('InventoryApp')

    def log_info(self, message):
        """Log an informational message."""
        print(f"[INFO] {message}")  # Print to console
        self.logger.info(message)  # Write to file

    def log_error(self, message):
        """Log an error message."""
        print(f"[ERROR] {message}") # Print to console
        self.logger.error(message) # Write to file

    def log_transaction(self, action, details, status):
        """
        Log a specific business transaction.
        :param action: The action being performed (e.g., "Process Order")
        :param details: Dictionary or string with details (e.g., {customer_id: 1})
        :param status: "Success" or "Failure"
        """
        entry = f"ACTION: {action} | STATUS: {status} | DETAILS: {details}"
        self.log_info(entry)

if __name__ == "__main__":
    # Test the logger
    logger = FileLogger()
    logger.log_info("Logger initialized.")
    logger.log_transaction("Test Transaction", "Checking system", "Success")
    print(f"Check {os.path.abspath('debug.log')} for logs.")
