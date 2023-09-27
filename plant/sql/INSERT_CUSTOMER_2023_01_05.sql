/*
-- Query: SELECT * FROM vgb.customers LIMIT 0, 1000
-- Date: 2023-01-05 11:06
*/
INSERT INTO customers (id,email, password,name,birthday,gender,
		address,phone,blood_type,subscribed) 
        VALUES ('A123123123','test01@uuu.com.tw','12345;lkj','狄會貴','2000-01-15','M',
			'','',NULL,0);
INSERT INTO customers (id,email,password,name,birthday,gender,
		address,phone,blood_type,subscribed) 
        VALUES ('A123123132','test020@uuu.com.tw','12345;lkj','張再豐','2000-01-15','M',
			'台北市信義路二段100號','',NULL,0);
INSERT INTO customers (id,email,password,name,birthday,gender,
		address,phone,blood_type,subscribed) 
        VALUES ('A123456789','test02@uuu.com.tw','12345;lkj','張三豐','2000-01-15','M','','',NULL,0);
INSERT INTO customers (id,email,password,name,birthday,gender,
		address,phone,blood_type,subscribed) 
        VALUES ('A223456781','test03@uuu.com.tw','12345;lkj','林梅莉','2005-08-15','F','','02-25149191','AB',1);
        
INSERT INTO customers (id,email,password,name,birthday,gender,
		address,phone,blood_type,subscribed) 
        VALUES (?,?,?,?,?,?,  ?,?,?,?);        
