/*E12:通知已轉帳*/
UPDATE orders
	SET payment_note=?, status=1
    WHERE customer_id=? AND id=? 
		AND payment_type='ATM' AND status='0';
        
        
/*信用卡已付款*/
UPDATE orders
	SET payment_note=?, status=2
    WHERE customer_id=? AND id=? 
		AND payment_type='CARD' AND status='0';        