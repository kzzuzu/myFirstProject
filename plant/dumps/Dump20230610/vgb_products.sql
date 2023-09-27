-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vgb
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `unit_price` double NOT NULL,
  `stock` int NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  `photo_url` varchar(250) DEFAULT NULL,
  `launch_date` date NOT NULL DEFAULT (curdate()),
  `category` varchar(20) NOT NULL DEFAULT '書籍',
  `discount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Java 7 教學手冊 第五版(附光碟)',650,5,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/055/52/0010555220.jpg&w=374&h=374&v=5020f27b','2023-01-14','書籍',10),(2,'Java SE 17 技術手冊',680,12,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/092/37/0010923732.jpg&w=374&h=374&v=626bbe47','2023-02-06','書籍',21),(3,'你就是不寫測試才會沒時間：Kuma的單元測試實戰-Java篇（iThome鐵人賽系列書）',650,15,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/093/90/0010939063.jpg&w=374&h=374&v=634d2f78','2023-02-17','書籍',30),(4,'Java 技術手冊(第六版)',680,7,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/068/26/0010682675.jpg&w=374&h=374&v=559cfbe4','2023-02-14','書籍',21),(5,'色鉛筆的基本：從選筆、色彩、筆觸到作品，自然風手繪的必修課',450,6,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/092/20/0010922002.jpg&w=374&h=374&v=6321ad52','2023-02-14','書籍',10),(6,'水彩色鉛筆的必修9堂課',250,9,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/043/78/0010437840.jpg&w=374&h=374&v=4a27be52','2023-02-14','書籍',10),(7,'圖說演算法：使用Java',490,11,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/084/55/0010845577.jpg&w=374&h=374&v=5e0b2337','2021-12-14','書籍',10),(8,'色鉛筆花卉著色學習書',360,16,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/082/83/0010828315.jpg&w=374&h=374&v=5d2701ac','2023-02-14','書籍',21),(9,'從零開始!Java 程式設計入門',580,5,'大量範例＋實作練習＋遊戲專案, 密集式範例學習最有效！ 主題最完整！保證紮穩物件導向程式設計基礎！','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/001/079/54/0010795433.jpg&w=374&h=374&v=5b642ecb','2023-02-14','書籍',21),(10,'STAEDTLER 施德樓】ABS水彩色鉛筆組 36色',575,8,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/016/82/N000168202.jpg&w=374&h=374&v=5f2cc89d','2021-02-14','文具',0),(11,'【德國LYRA】Groove三角洞洞色鉛筆',70,15,'GROOVE系列榮獲德國reddot紅點設計大獎|孩子能自然無拘束的使用，吸引力十足的造型|還能防止手指滑落~|鼓勵孩子大膽自信的書寫。','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N01/142/02/N011420245.jpg&w=374&h=374&v=5b9f4e22','2023-02-23','文具',10),(12,'【德國LYRA】Groove三角洞洞鉛筆(6入) ',288,11,'','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/019/62/N000196271.jpg&w=374&h=374&v=62c28d20','2023-02-23','文具',0),(13,' Pentel百點橡皮擦',15,45,'標準型橡皮擦; 不易損耗，更經濟實惠\r S尺寸：43 x 17.5 x 11.5mm\rM尺寸：65×24.5×12.5mm\rL尺寸：74×32.5×13.5mm\rXL尺寸：11×4.6×2cm','https://www.9x9.tw/public/files/product/thumb/N90888-41314S.jpg','2023-03-02','文具',20),(14,'【德國LYRA】GROOVE三角洞洞色鉛筆(細) 24色',380,10,'推薦【德國LYRA】GROOVE三角洞洞色鉛筆(細24色/48支裝), 來自永續森林的天然木材,超好握創新筆身的凹洞設計,優惠便宜好價格,值得推薦！','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/106/80/N001068013.jpg&w=374&h=374&v=5d005bf1','2023-03-02','文具',0),(15,'KUTSUWA 超值文具優惠組 PUMA筆袋 PUMA鉛筆 筆蓋 蜂格筆袋紅藍銀套組',1140,12,'KUTSUWA 開學超值文具優惠組\n每組包含\n1.puma鉛筆盒1個(款式可選) 市價750\n2.puma閃鑽鉛筆1組(6入3色) 市價270\n3.彩色金屬鉛筆蓋1組(5入) 市價120','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N01/250/25/N012502588.jpg&v=610b8f41k&w=348&h=348','2023-03-10','文具',0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-10 18:34:50
