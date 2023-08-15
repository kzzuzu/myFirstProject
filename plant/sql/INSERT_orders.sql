INSERT INTO orders
	(id, customer_id, order_date, order_time,status, 
    payment_type, payment_fee,  payment_note,
    shipping_type, shipping_fee, shipping_address, 
    recipient_name, recipient_email, recipient_phone)
    VALUES(?,?,?,?,0, ?,?,'', ?,?,?, ?,?,?);
    
INSERT INTO order_items
	(order_id, product_id, color_name, size_name, price, quantity)
    VALUES(?,?,?,?, ?,?);