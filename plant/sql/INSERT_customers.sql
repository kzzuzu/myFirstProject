INSERT INTO customers
	(id, email, name, password, birthday, gender)
	VALUES('A223456781', 'test781@uuu.com.tw', '林梅莉', '12345;lkj', '2000-03-16', 'F');

/* 以下為 E02:註冊 的查詢指令*/     
INSERT INTO customers   
	(id, email, name, password, birthday, gender,
		address, phone, subscribed) 	
	VALUES('A223456718', 'test718@uuu.com.tw', "林又莉", '12345;lkj', '2000-03-16', 'F',
	'台北市復興北路99號12F','02-25149191',false);
	
INSERT INTO customers   
	(id, email, name, password, birthday, gender,
		address, phone, subscribed) 	
	VALUES(?,?,?,?,?,?, ?,?,?);	
    
