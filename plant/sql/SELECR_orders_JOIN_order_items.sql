SELECT id, customer_id, created_date, created_time, 
	order_id, product_id, color_name, size_name, price, quantity,
    price * quantity AS amount, SUM(price * quantity) AS total_amount,
	shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note, status, 
    recipient_name, recipient_email, recipient_phone, shipping_address	
 FROM orders 
	INNER JOIN order_items ON orders.id=order_items.order_id
WHERE orders.customer_id="A223456781"
GROUP BY orders.id
ORDER BY created_date DESC, created_time DESC; 

/* E10 歷史訂單查詢  */
SELECT id, customer_id, created_date, created_time,
	shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note, status
    , SUM(price * quantity) AS total_amount
 FROM orders 
	INNER JOIN order_items ON orders.id=order_items.order_id
WHERE orders.customer_id="A223456781"
GROUP BY orders.id
ORDER BY created_date DESC, created_time DESC; 

/* E11 查詢訂單明細  */
SELECT orders.id, customer_id, created_date, created_time, 
	order_items.order_id, order_items.product_id, order_items.color_name, order_items.size_name, 
    price, quantity, price * quantity AS amount,
    products.name as product_name, 
    products.photo_url, product_colors.photo_url AS color_photo,
	shipping_type, shipping_fee, shipping_note, payment_type, payment_fee, payment_note, status, 
    recipient_name, recipient_email, recipient_phone, shipping_address	
 FROM orders 
	INNER JOIN order_items ON orders.id=order_items.order_id
    INNER JOIN products ON order_items.product_id = products.id
    LEFT JOIN product_colors ON order_items.product_id = product_colors.product_id AND order_items.color_name=product_colors.color_name
WHERE orders.customer_id="A223456781" AND orders.id='1';