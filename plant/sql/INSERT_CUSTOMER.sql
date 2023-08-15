SELECT * FROM vgb.customers;
USE vgb;

INSERT INTO customers (id, email, password, name, birthday, gender)
VALUES ('A123456789', 'test01@uuu.com.tw', '12345;lkj', '狄會貴', '2000-01-15', 'M');

INSERT INTO customers (address, id, email, password, name, birthday, gender) 
VALUES ('台北市信義路二段100號', 'A123123132', 'test020@uuu.com.tw', '12345;lkj', '張再豐', '2000-01-15', 'M');

INSERT INTO `customers` (id, email, name,gender, birthday, address,
	password, phone, blood_type, subscribed)
    VALUES ('A223456781', 'test03@uuu.com.tw', '林梅莉', 'F', '2005-08-15', '', 
    '12345;lkj', '02-25149191', 'AB', '1');

UPDATE customers 
	SET email='test02@uuu.com.tw', name='張三', gender='M', birthday='1999-02-15'
    WHERE id='A123456789';
    
UPDATE customers 
	SET email=?, password=?, name=?, birthday=?, gender=?,
		address=?, phone=?, blood_type=?, subscribed=?
    WHERE id=?;