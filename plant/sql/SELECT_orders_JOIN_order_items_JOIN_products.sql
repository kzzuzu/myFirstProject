/*E10: 查詢歷史訂單 */
SELECT id, order_date, order_time, payment_type, shipping_type, payment_fee, shipping_fee,
	SUM(order_items.price * order_items.quantity) as total_amount    
 FROM orders
   LEFT JOIN order_items ON orders.id=order_items.order_id
   WHERE orders.customer_id='A223456781'
   GROUP BY orders.id
   ORDER BY order_date DESC, order_time DESC;
   
/*E10: 查詢訂單明細 */   
SELECT orders.id, customer_id, order_date, order_time, status, 
		payment_type, payment_fee, payment_note, shipping_type, shipping_fee, shipping_note, 
		shipping_address, recipient_name, recipient_email, recipient_phone,
	order_items.product_id, order_items.color_name, order_items.size_name, 
		order_items.price, order_items.quantity,
		products.name AS product_name, 
		IFNULL(product_colors.photo_url,products.photo_url) as photo_url
 FROM orders
   LEFT JOIN order_items ON orders.id=order_items.order_id
   LEFT JOIN products ON order_items.product_id = products.id
   LEFT JOIN product_colors ON order_items.product_id = products.id
	AND order_items.color_name = product_colors.color_name
   WHERE orders.id='1' AND orders.customer_id='A223456781';   