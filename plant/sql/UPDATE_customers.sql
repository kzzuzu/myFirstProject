UPDATE customers
	SET email='test781@uuu.com.tw', name='林莉', birthday='2000-03-16', gender='F',
		address='110台北市信義區信義路五段7號', phone='02-8108800', subscribed=true
	WHERE id='A223456781';
    
/*修改會員(包含密碼)*/        
UPDATE customers
	SET email=?, name=?, birthday=?, gender=?, 
		address=?, phone=?, subscribed=?
	WHERE id=?;
    
/*修改會員(不包含密碼)*/        
UPDATE customers
	SET email=?, name=?, birthday=?, gender=?, 
		address=?, phone=?, subscribed=?
	WHERE id=?;

/*修改密碼*/    
UPDATE customers
	SET password = ?
	WHERE id=?;     