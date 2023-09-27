INSERT INTO products
	(id, name, unit_price, stock, category,discount)
    VALUES(1, "最新Java程式語言 修訂第七版", 680, 5, '書籍', 21);
    
INSERT INTO products
	(id, name, unit_price, stock,photo_url, description, category,discount)
    VALUES(2, "OCP：Java SE 11 Developer認證指南(下)API剖析運用篇", 820, 10, 
			'https://im2.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/093/45/0010934577.jpg&v=6305fe08k&w=348&h=348',
            'Oracle公司繼Java 8推出1Z0-808與1Z0-809認證考試科目後，原本在次一個長期支援版本的Java 11也推出1Z0-815與1Z0-816的雙考試，但在2020/10/01之後，改以1Z0-819取代前兩者，成為現行要取得「Oracle Certified Professional: Java SE 11 Developer」證照的唯一考試科目。',
			'書籍', 21);
            
INSERT INTO products
	(id, name, unit_price, stock,photo_url, description, category,lunch_date)
    VALUES(10, "[MUJI無印良品]繪圖色鉛筆/12色(R)", 145, 7,
    'https://im2.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/100/24/N001002483.jpg&v=5d22e5b9k&w=348&h=348',
    '使用不經塗裝加工之木質筆桿製成，包含基本的12款顏色。產地：日本。',
    '文具', '2022-5-6');