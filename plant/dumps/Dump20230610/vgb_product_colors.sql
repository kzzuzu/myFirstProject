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
-- Table structure for table `product_colors`
--

DROP TABLE IF EXISTS `product_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_colors` (
  `product_id` int NOT NULL,
  `color_name` varchar(20) NOT NULL,
  `photo_url` varchar(250) DEFAULT NULL,
  `icon_url` varchar(250) DEFAULT NULL,
  `stock` int NOT NULL,
  `ordinal` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`color_name`),
  CONSTRAINT `fkey_product_colors_TO_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_colors`
--

LOCK TABLES `product_colors` WRITE;
/*!40000 ALTER TABLE `product_colors` DISABLE KEYS */;
INSERT INTO `product_colors` VALUES (11,'白','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N01/142/02/N011420241.jpg&w=374&h=374&v=5b9f4e21',NULL,10,1),(11,'紅','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N01/142/02/N011420245.jpg&w=374&h=374&v=5b9f4e22',NULL,2,0),(11,'綠','https://im2.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N01/142/02/N011420255.jpg&v=5b9f4e22k&w=348&h=348',NULL,3,2),(11,'藍','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N01/142/02/N011420252.jpg&w=187&h=187&v=5b9f4e22',NULL,5,3),(12,'櫻花粉','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/084/29/N000842993.jpg&w=374&h=374&v=62c28d21',NULL,3,2),(12,'湖水綠','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/084/29/N000842992.jpg&w=374&h=374&v=62c28c6c',NULL,7,1),(12,'藍','https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/019/62/N000196271.jpg&w=374&h=374&v=62c28d20',NULL,6,0),(13,'白','https://www.9x9.tw/public/files/product/thumb/N71282-41327S.jpg',NULL,15,0),(13,'黑','https://www.9x9.tw/public/files/product/thumb/N51202-53104S.jpg',NULL,10,1);
/*!40000 ALTER TABLE `product_colors` ENABLE KEYS */;
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
