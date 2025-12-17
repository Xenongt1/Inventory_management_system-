USE inventory_system;

CALL ProcessNewOrder (3, 6, 2, @order_id, @message);

SELECT @message AS CallMessage;