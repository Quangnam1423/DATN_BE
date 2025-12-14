-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: new_bej_sp3
-- ------------------------------------------------------
-- Server version	8.4.7

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
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `id` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` text,
  `display_order` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_active` bit(1) NOT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Apple'),(2,'Samsung'),(3,'Xiaomi'),(4,'ASUS'),(5,'Lenovo'),(6,'Dell'),(7,'HP'),(8,'Sony');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `id` varchar(255) NOT NULL,
  `added_at` date DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `attribute_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7ysjorv4gw0drqhrgehr9nd3a` (`attribute_id`),
  KEY `FKjnaj4sjyqjkr4ivemf9gb25w` (`user_id`),
  CONSTRAINT `FK7ysjorv4gw0drqhrgehr9nd3a` FOREIGN KEY (`attribute_id`) REFERENCES `product_attribute` (`id`),
  CONSTRAINT `FKjnaj4sjyqjkr4ivemf9gb25w` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES ('00829fb6-4bdf-4f14-a333-8ad810d0fdcc','2025-12-10','Xám bạc',41990000,'Samsung Galaxy Z Fold7 5G',1,'b7b7dda1-d5c5-40d9-839e-37dd2cadec9d','33ff2646-2922-416c-8216-c877201ed659'),('38006691-d488-417c-aa45-8403c4ee31ef','2025-12-07','Tím Oải Hương',24990000,'iPhone 17 256GB - Chính hãng Apple Việt Nam',1,'c0c5e0c9-6114-4988-bd67-d6520e7e4837','24daab77-a1cb-4e14-b002-cb0754acbc52'),('39b0f24b-c944-43f7-b1dc-8e9dc2f0839e','2025-12-10','Xanh Lam Khói',30990000,'iPhone 17 256GB - Chính hãng Apple Việt Nam',2,'2f6d8da8-0b89-41a1-8401-f14ef3bb3962','33ff2646-2922-416c-8216-c877201ed659');
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (10,'Điện Thoại','DT'),(11,'Dịch Vụ','DVV'),(12,'Phụ Kiện','PK'),(24,'Linh Kiện','LK'),(25,'Laptop','LT'),(26,'Tablet','TB'),(27,'Màn hình','MH'),(28,'Linh kiện máy tính','LK'),(29,'Điện máy','DM'),(30,'Đồng hồ','DH'),(31,'Âm thanh','AT'),(32,'Smart home','SH'),(33,'Sửa chữa','SC');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fcm_device_token`
--

DROP TABLE IF EXISTS `fcm_device_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fcm_device_token` (
  `id` varchar(255) NOT NULL,
  `last_used` datetime(6) NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKlnb5a9bngbhyqiow17xgpn8m5` (`token`),
  KEY `FKb819s29v9iebdx6egnu2dwboa` (`user_id`),
  CONSTRAINT `FKb819s29v9iebdx6egnu2dwboa` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fcm_device_token`
--

LOCK TABLES `fcm_device_token` WRITE;
/*!40000 ALTER TABLE `fcm_device_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `fcm_device_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invalidated_token`
--

DROP TABLE IF EXISTS `invalidated_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invalidated_token` (
  `id` varchar(255) NOT NULL,
  `expiry_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invalidated_token`
--

LOCK TABLES `invalidated_token` WRITE;
/*!40000 ALTER TABLE `invalidated_token` DISABLE KEYS */;
INSERT INTO `invalidated_token` VALUES ('04c69e7b-6fa0-4524-bd0b-810459635b3c','2025-04-02 15:27:51.000000'),('05c6a35d-5ff9-4636-ac0a-b5c27e22613e','2025-04-02 16:35:57.000000'),('0d06c23f-8b67-4f85-a0ae-93505531e26b','2026-01-06 04:25:03.000000'),('104a26f8-1a58-4b5c-bfb4-d4bdefd776de','2025-11-07 23:59:21.000000'),('10c242cf-f2b9-4697-9f7e-2eefac7c919f','2026-01-08 09:13:12.000000'),('198d41eb-bbac-4ab5-9a1c-19d7eb496360','2025-04-02 16:05:37.000000'),('33041d8e-5815-4dc5-a44d-2487e3002b06','2025-04-02 16:41:11.000000'),('39eb7e24-c938-4d80-9950-32355979884c','2025-04-02 16:07:54.000000'),('466bd302-75fa-45f4-b9ee-4eb0b060aca2','2025-04-02 16:53:52.000000'),('4673a5d1-d548-4dc6-8472-ed919234b24c','2026-01-08 09:16:52.000000'),('4f7607e1-de89-49ac-b273-0815b7b2c9c6','2025-04-02 15:14:22.000000'),('66f2e950-566f-4c38-ac09-b0eac84e7d32','2025-04-02 16:17:11.000000'),('767467bb-a37d-4eab-b710-eede84d09424','2025-04-02 16:43:32.000000'),('8882a836-a1bb-4c48-b392-74d005c2a910','2025-04-02 16:40:25.000000'),('89606b19-82b6-4f33-b998-5eaeffb0867c','2025-04-02 16:24:37.000000'),('8a411fab-dae5-4752-97c5-2f5e12d50eb8','2025-04-02 16:36:41.000000'),('8edb7c59-047a-4f4d-bf11-18758bce4528','2025-11-07 23:57:58.000000'),('9d24daad-527a-4974-8953-1d64c40f87e0','2026-01-09 14:27:33.000000'),('9e49a3f0-da89-4dc5-a3a6-339717266977','2026-01-09 15:06:16.000000'),('ae753261-fa61-4a4b-9200-db29dbeecb04','2026-01-08 10:23:59.000000'),('bfb2211c-5fc9-4777-a25d-7223c13d5909','2025-04-02 16:34:42.000000'),('c2db5871-6442-4832-b269-7b00af3ae9d8','2025-04-02 16:45:58.000000'),('c3daa5d2-6397-4690-bf78-dc84126b71f7','2025-04-02 16:46:52.000000'),('cca41f47-8cb2-4dfd-a40c-d57fad3d04ca','2025-04-02 16:51:38.000000'),('d1b08af2-e4c9-48c8-a261-9077370b786a','2025-04-02 15:41:40.000000'),('db61c0b8-e1a0-47ad-a4f1-a9de3996fc40','2025-04-02 16:37:15.000000'),('e365086d-9ea9-4b79-86b5-806d15e551e9','2026-01-09 15:09:48.000000'),('eb2c93a9-d4d6-4d48-b761-ff0e2dfa78e4','2025-11-08 00:48:48.000000'),('ef717bfd-e608-44ab-9e2a-00477114b23b','2025-04-02 16:48:41.000000'),('f41f72d9-288b-400b-99a8-110d814eaf70','2025-11-10 04:33:12.000000'),('fa901276-deec-4765-9416-43722b64ab21','2026-01-09 15:18:04.000000');
/*!40000 ALTER TABLE `invalidated_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` varchar(255) NOT NULL,
  `body` varchar(1000) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_read` bit(1) NOT NULL,
  `resource_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('GENERAL_ANNOUNCEMENT','NEW_PROMOTION','ORDER_PLACED','ORDER_STATUS_UPDATE','REPAIR_REQUEST_RECEIVED','REPAIR_STATUS_UPDATE','REPAIR_TECHNICIAN_MESSAGE') NOT NULL,
  `recipient_user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgtksickis1kjl98281hxsqsc0` (`recipient_user_id`),
  CONSTRAINT `FKgtksickis1kjl98281hxsqsc0` FOREIGN KEY (`recipient_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES ('029751a6-9441-46d1-bf36-0603b91fffb3','Đơn hàng #f0faf57e-d3b0-4d47-a741-f872826b03a5 đã được cập nhật: Đã thanh toán','2025-12-07 09:13:04.792181',_binary '\0','f0faf57e-d3b0-4d47-a741-f872826b03a5','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('02cd8362-47ba-4e40-a4a2-3ff52584ef4c','Đơn hàng #32082142-3208-4c0f-bb69-2f9ca462ae56 đã được cập nhật: Đã xác nhận - aasdsasdas','2025-12-13 12:10:49.732741',_binary '\0','32082142-3208-4c0f-bb69-2f9ca462ae56','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('04899c67-22fc-4232-99ba-5b86114cc6ec','Đơn hàng #32082142-3208-4c0f-bb69-2f9ca462ae56 đã được cập nhật: Đã xác nhận - aaaaaa','2025-12-13 11:44:17.566046',_binary '\0','32082142-3208-4c0f-bb69-2f9ca462ae56','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('233fb049-7087-4c44-b60e-d077258c43a1','Đơn hàng #30adcfca-21c9-4248-8897-274d38b500f8 đã được cập nhật: Đã xác nhận - đang sửa chữa','2025-12-07 14:08:12.394046',_binary '\0','2','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('4af388fb-0356-42e5-bd9e-72734a9747de','Đơn hàng #994e8b08-ae0d-4989-b5eb-b21e6bd20b7c đã được cập nhật: Đã xác nhận - chờ xác nhận','2025-12-14 13:00:04.716995',_binary '\0','994e8b08-ae0d-4989-b5eb-b21e6bd20b7c','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('59037cd5-50aa-4138-946f-3b757a207a4e','Đơn hàng #f0faf57e-d3b0-4d47-a741-f872826b03a5 đã được cập nhật: Đã thanh toán','2025-12-07 09:13:20.335485',_binary '\0','f0faf57e-d3b0-4d47-a741-f872826b03a5','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('5d0d9b3d-0b7b-4155-9900-bd7b3cec65e2','Đơn hàng #32082142-3208-4c0f-bb69-2f9ca462ae56 đã được cập nhật: Đã xác nhận - asdadasdasd','2025-12-13 11:45:49.778599',_binary '\0','32082142-3208-4c0f-bb69-2f9ca462ae56','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('70e89552-c088-48d7-a82e-f3246e7707ba','Đơn hàng #c16d490b-b60c-4b4a-88eb-dffa03edc386 đã được cập nhật: Đã xác nhận - cập nhật linh kiện sử dụng','2025-12-14 13:20:42.364593',_binary '\0','c16d490b-b60c-4b4a-88eb-dffa03edc386','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('7e24a264-142b-4651-b4b3-016ae5200e6a','Đơn hàng #30adcfca-21c9-4248-8897-274d38b500f8 đã được cập nhật: Chờ xử lý - adu','2025-12-07 12:39:23.686657',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('91cd7b5e-57f8-4364-ae99-936df6c099f3','Đơn hàng #30adcfca-21c9-4248-8897-274d38b500f8 đã được cập nhật: Đã thanh toán','2025-12-07 14:07:04.448393',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('9abe0333-23d8-4cd2-b668-0d7e91f83005','Đơn hàng #30adcfca-21c9-4248-8897-274d38b500f8 đã được cập nhật: Chờ xử lý - 23425ewgfedfgdfg','2025-12-07 12:47:51.508861',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('9d6731c2-7369-4a0c-8777-e307749536cd','Đơn hàng #46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5 đã được cập nhật: Chờ xử lý - ssss','2025-12-07 09:20:12.558990',_binary '\0','46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('9e323b64-7fe3-4c7a-9f98-42f575edd958','Đơn hàng #30adcfca-21c9-4248-8897-274d38b500f8 đã được cập nhật: Chờ xử lý - asdasdasdasd','2025-12-07 12:47:46.821983',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('a22b792b-2c28-494e-a9f2-6f0a9650a8f9','Đơn hàng #b63534 của bạn đã được giao thành công.','2025-11-12 15:30:00.000000',_binary '','b63534c6-c51b-4164-9e2c-591efb2f7ef6','Đơn hàng đã giao','ORDER_STATUS_UPDATE','6895cccc-4891-4c15-981a-e59a2d16a939'),('a5da1f15-bbbf-4f56-9960-95497cba416e','Đơn hàng #30adcfca-21c9-4248-8897-274d38b500f8 đã được cập nhật: Chờ xử lý - dự tính chi phí\nchờ khách gửi hàng','2025-12-07 14:03:48.658519',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('ae115945-914a-418e-8086-098711f84829','Đơn hàng #37036055-b58b-4cbb-9437-6aba043cd4ad đã được cập nhật: Đã xác nhận - chờ xác nhận đơn','2025-12-14 12:30:53.294386',_binary '\0','37036055-b58b-4cbb-9437-6aba043cd4ad','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('b150ad1d-c9c5-4ae9-a60a-306ad3f5b3d4','Đơn hàng #f0faf57e-d3b0-4d47-a741-f872826b03a5 đã được cập nhật: Đã xác nhận','2025-12-07 09:12:56.123882',_binary '\0','f0faf57e-d3b0-4d47-a741-f872826b03a5','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('b33c803c-3d39-4a5f-b0a3-7a1b0761b9a0','Giảm giá 20% cho tất cả các dịch vụ sửa chữa. Đừng bỏ lỡ!','2025-11-13 11:00:00.000000',_binary '\0',NULL,'Khuyến mãi cuối tuần!','NEW_PROMOTION','7cacd02a-7e5b-4321-ba46-b3500ccf8589'),('c028c34a-ddf3-41c8-ac5f-f7a466346581','Đơn hàng #f0faf57e-d3b0-4d47-a741-f872826b03a5 đã được cập nhật: Chờ xử lý','2025-12-07 09:09:42.550743',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('c44d914d-4e4a-4b6a-c1b4-8b2c1872c0b1','Khách hàng (ID: ...a939) vừa tạo một yêu cầu sửa chữa mới cho iPhone 17.','2025-11-13 12:00:00.000000',_binary '\0','R-12345','Yêu cầu sửa chữa mới','REPAIR_REQUEST_RECEIVED','b78ae41e-2ec3-4065-a876-06a16a039f15'),('d4cdceae-7de4-4ac7-9313-f0296e0146c0','Đơn hàng #37036055-b58b-4cbb-9437-6aba043cd4ad đã được cập nhật: Đã xác nhận - a','2025-12-14 12:56:32.665550',_binary '\0','37036055-b58b-4cbb-9437-6aba043cd4ad','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('d7b793d1-ce7f-4880-9029-cd12c507b09e','Đơn hàng #2fce0551-f869-4464-a681-732411d9c5ba đã được cập nhật: Chờ xử lý - qqeqweqweqw','2025-12-09 04:33:23.032654',_binary '\0','0','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('e11a681a-1b17-483d-98e1-5e9f8549f7e8','Đơn hàng #c1828a của bạn đã được xác nhận và đang được chuẩn bị.','2025-11-13 10:00:00.000000',_binary '\0','c1828a7b-92fb-4e18-84bc-3ef957cf937f','Đơn hàng đã được xác nhận','ORDER_STATUS_UPDATE','6895cccc-4891-4c15-981a-e59a2d16a939'),('f1ffc8bb-1c23-4b0b-80d9-675a07bef0d8','Đơn hàng #32082142-3208-4c0f-bb69-2f9ca462ae56 đã được cập nhật: Đã xác nhận - asdasdasd','2025-12-13 11:49:51.009394',_binary '\0','1','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','33ff2646-2922-416c-8216-c877201ed659'),('f24c9db5-39ea-440a-9ea7-02e389da5bd7','Đơn hàng #46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5 đã được cập nhật: Chờ xử lý - test 1','2025-12-07 09:19:54.154754',_binary '\0','46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('f4d7a8e1-fe47-4344-b50a-99a99a037585','Đơn hàng #46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5 đã được cập nhật: Chờ xử lý','2025-12-07 09:25:06.837814',_binary '\0','46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5','Cập nhật đơn hàng','ORDER_STATUS_UPDATE','24daab77-a1cb-4e14-b002-cb0754acbc52'),('n1a2b3c4-d5e6-7890-abcd-ef1234567890','Đơn hàng của bạn đã được tạo thành công. Mã đơn hàng: #o1a2b3c4','2025-11-15 10:15:00.000000',_binary '\0','o1a2b3c4-d5e6-7890-abcd-ef1234567890','Đơn hàng mới đã được tạo','ORDER_PLACED','a1b2c3d4-e5f6-7890-abcd-ef1234567890'),('n2b3c4d5-e6f7-8901-bcde-f12345678901','Đơn hàng #o2b3c4d5 của bạn đang được vận chuyển.','2025-11-16 14:20:00.000000',_binary '\0','o2b3c4d5-e6f7-8901-bcde-f12345678901','Đơn hàng đang được giao','ORDER_STATUS_UPDATE','b2c3d4e5-f6a7-8901-bcde-f12345678901'),('n3c4d5e6-f7a8-9012-cdef-123456789012','Hệ thống sẽ bảo trì vào ngày 25/11/2025 từ 2h-4h sáng.','2025-11-17 09:00:00.000000',_binary '\0',NULL,'Thông báo hệ thống','GENERAL_ANNOUNCEMENT','c3d4e5f6-a7b8-9012-cdef-123456789012'),('n4d5e6f7-a8b9-0123-def0-234567890123','Giảm giá lên đến 50% cho tất cả sản phẩm điện tử. Áp dụng từ 24-26/11/2025.','2025-11-18 08:30:00.000000',_binary '\0',NULL,'Khuyến mãi Black Friday','NEW_PROMOTION','d4e5f6a7-b8c9-0123-def0-234567890123'),('n5e6f7a8-b9c0-1234-ef01-345678901234','Đơn hàng #o5e6f7a8 của bạn đã được xác nhận và đang được chuẩn bị.','2025-11-19 11:45:00.000000',_binary '','o5e6f7a8-b9c0-1234-ef01-345678901234','Đơn hàng đã được xác nhận','ORDER_STATUS_UPDATE','e5f6a7b8-c9d0-1234-ef01-345678901234'),('n6f7a8b9-c0d1-2345-f012-456789012345','Yêu cầu sửa chữa của bạn đang được xử lý. Dự kiến hoàn thành trong 3-5 ngày.','2025-11-20 13:00:00.000000',_binary '\0','R-67890','Trạng thái sửa chữa đã cập nhật','REPAIR_STATUS_UPDATE','a1b2c3d4-e5f6-7890-abcd-ef1234567890');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `attribute_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt4dc2r9nbvbujrljv3e23iibt` (`order_id`),
  KEY `FKsengwq8ybpln1qnhy438hfr93` (`attribute_id`),
  CONSTRAINT `FKsengwq8ybpln1qnhy438hfr93` FOREIGN KEY (`attribute_id`) REFERENCES `product_attribute` (`id`),
  CONSTRAINT `FKt4dc2r9nbvbujrljv3e23iibt` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES ('03658116-90fd-4a14-bf1c-422d608a7535',1150000,1,'c16d490b-b60c-4b4a-88eb-dffa03edc386','ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053'),('05e442e0-4894-4d5b-931a-d6b031cd0c18',41990000,1,'2fce0551-f869-4464-a681-732411d9c5ba','cd3841c8-3587-4d0c-a237-779287830cfa'),('15d248cb-6b20-443e-a048-22038526456c',30990000,1,'46e7f0c8-7e87-45f8-9d61-16bb1e8d1ff5','d6160e8c-c48a-4548-9acc-a4c93d6eb007'),('1614a48f-4b9b-4027-809d-2b4029244642',1150000,1,'37036055-b58b-4cbb-9437-6aba043cd4ad','ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053'),('45562de1-1173-4575-bb20-282877ae97bb',41990000,1,'32082142-3208-4c0f-bb69-2f9ca462ae56','b7b7dda1-d5c5-40d9-839e-37dd2cadec9d'),('56e945ef-db24-4aaa-b3b0-250e3b58fa2f',1150000,1,'37036055-b58b-4cbb-9437-6aba043cd4ad','ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053'),('8672ce96-205f-4c51-8724-78d1df3da5ae',30990000,1,'39d3400d-a14f-413d-8151-5c2dade6065e','2f6d8da8-0b89-41a1-8401-f14ef3bb3962'),('9505db94-6ff6-4835-ae1a-ad861804044f',1150000,1,'37036055-b58b-4cbb-9437-6aba043cd4ad','ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053'),('a1b9ed3d-42b4-4be6-9012-0b41616ec95e',30990000,1,'32082142-3208-4c0f-bb69-2f9ca462ae56','37c1a9e8-2664-4f54-a6e6-2d555d05712d'),('a43423c0-be10-4ba8-bd62-ee86d1456e87',30990000,1,'82774596-0c83-47b2-953e-fb78a81e17ba','2f6d8da8-0b89-41a1-8401-f14ef3bb3962'),('a49bd119-deee-46ad-881a-df14198e9d99',1150000,1,'37036055-b58b-4cbb-9437-6aba043cd4ad','ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053'),('b292c2b7-5161-42c9-80ce-44300e5bc7ad',30990000,1,'f0faf57e-d3b0-4d47-a741-f872826b03a5','2f6d8da8-0b89-41a1-8401-f14ef3bb3962'),('fb74d5de-3b73-4463-b2ae-a9b789110a87',200000,1,'37036055-b58b-4cbb-9437-6aba043cd4ad','bb955a7b-b3cf-43f2-98ee-bfe7db48b7a3'),('ff60f77e-10ca-4b85-982b-83f1beaadae0',1200000,1,'994e8b08-ae0d-4989-b5eb-b21e6bd20b7c','c4af9cee-db4d-4d90-a916-d82da1ea7295');
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_note`
--

DROP TABLE IF EXISTS `order_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_note` (
  `id` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7oseoi525qtfc1ku5247l77gi` (`order_id`),
  KEY `FK6ivnl33gom046f86n2voe59j9` (`user_id`),
  CONSTRAINT `FK6ivnl33gom046f86n2voe59j9` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK7oseoi525qtfc1ku5247l77gi` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_note`
--

LOCK TABLES `order_note` WRITE;
/*!40000 ALTER TABLE `order_note` DISABLE KEYS */;
INSERT INTO `order_note` VALUES ('00d096b8-f343-4345-85d7-6ebf721a3ef9','Cập nhật linh kiện sử dụng','2025-12-14 11:51:28.723983','37036055-b58b-4cbb-9437-6aba043cd4ad','33ff2646-2922-416c-8216-c877201ed659'),('0ecb9c33-70fe-4b0c-8d9e-a3899f21d9ee','Cập nhật linh kiện sử dụng','2025-12-14 13:20:07.827226','c16d490b-b60c-4b4a-88eb-dffa03edc386','33ff2646-2922-416c-8216-c877201ed659'),('38d6c796-e2de-48d6-8f67-3649560c7060','a','2025-12-14 12:56:32.598874','37036055-b58b-4cbb-9437-6aba043cd4ad','33ff2646-2922-416c-8216-c877201ed659'),('6059dd4f-9ab8-48c6-bb89-c099d50e67b5','Khách hàng xác nhận đơn sửa chữa','2025-12-14 13:20:58.123936','c16d490b-b60c-4b4a-88eb-dffa03edc386','33ff2646-2922-416c-8216-c877201ed659'),('61b1320b-bfe1-4f65-a5c6-4e37a739ecc7','chờ xác nhận đơn','2025-12-14 12:30:53.267193','37036055-b58b-4cbb-9437-6aba043cd4ad','33ff2646-2922-416c-8216-c877201ed659'),('72c97d67-7e0b-4a7d-a9a7-5257023c19d1','chờ xác nhận','2025-12-14 13:00:04.700406','994e8b08-ae0d-4989-b5eb-b21e6bd20b7c','33ff2646-2922-416c-8216-c877201ed659'),('7f4f7c3d-ccc6-4cb2-861a-0a65c0c69587','Khách hàng xác nhận đơn sửa chữa','2025-12-14 13:03:07.874996','994e8b08-ae0d-4989-b5eb-b21e6bd20b7c','33ff2646-2922-416c-8216-c877201ed659'),('a467e10e-5fe5-4cc0-b546-9fc65d421803','Khách hàng xác nhận đơn sửa chữa','2025-12-14 12:55:35.204248','37036055-b58b-4cbb-9437-6aba043cd4ad','33ff2646-2922-416c-8216-c877201ed659'),('aba4e0f0-c3c8-44e6-8486-64e64d4e2a88','aasdsasdas','2025-12-13 12:10:49.703151','32082142-3208-4c0f-bb69-2f9ca462ae56','33ff2646-2922-416c-8216-c877201ed659'),('adc2152a-7c40-44c6-b405-88366dcac445','Khách hàng xác nhận đơn sửa chữa','2025-12-14 13:03:11.399172','994e8b08-ae0d-4989-b5eb-b21e6bd20b7c','33ff2646-2922-416c-8216-c877201ed659'),('d9f004e7-4eac-4ee7-b990-a19aa7ef9966','Cập nhật linh kiện sử dụng','2025-12-14 12:02:18.465006','37036055-b58b-4cbb-9437-6aba043cd4ad','33ff2646-2922-416c-8216-c877201ed659'),('e38cc63d-9950-4b02-bd5f-bf4de35471fb','Khách hàng xác nhận đơn sửa chữa','2025-12-14 12:58:38.723893','37036055-b58b-4cbb-9437-6aba043cd4ad','33ff2646-2922-416c-8216-c877201ed659'),('f9605aa1-5901-4242-9f5c-479d16d722fb','cập nhật linh kiện sử dụng','2025-12-14 13:20:42.343926','c16d490b-b60c-4b4a-88eb-dffa03edc386','33ff2646-2922-416c-8216-c877201ed659');
/*!40000 ALTER TABLE `order_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `order_at` date DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `total_price` double NOT NULL,
  `type` int NOT NULL,
  `updated_at` date DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKel9kyl84ego2otj2accfd8mr7` (`user_id`),
  CONSTRAINT `FKel9kyl84ego2otj2accfd8mr7` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('32082142-3208-4c0f-bb69-2f9ca462ae56','test1',NULL,'admin@gmail.com','2025-12-10','admin',1,30990000,0,'2025-12-13','33ff2646-2922-416c-8216-c877201ed659'),('37036055-b58b-4cbb-9437-6aba043cd4ad',NULL,'iPhone 13 | chai pin aaaa','','2025-12-14','0123123123',2,3650000,1,'2025-12-14','33ff2646-2922-416c-8216-c877201ed659'),('39d3400d-a14f-413d-8151-5c2dade6065e','test1','sssss','admin@gmail.com','2025-12-09','admin',0,30990000,0,NULL,'33ff2646-2922-416c-8216-c877201ed659'),('994e8b08-ae0d-4989-b5eb-b21e6bd20b7c',NULL,'iPhone 11 | sssssdasdasdasd','','2025-12-09','0123123123',2,0,1,'2025-12-14','33ff2646-2922-416c-8216-c877201ed659'),('c16d490b-b60c-4b4a-88eb-dffa03edc386',NULL,'iPhone 13 | chai pin, nhanh hết pin','','2025-12-14','0123123123',2,1150000,1,'2025-12-14','33ff2646-2922-416c-8216-c877201ed659');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES ('MANAGE_PRODUCT','creata/update product data'),('MANAGE_ROLE','give roles for staff'),('MANAGE_STAFF','manage staff');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` varchar(255) NOT NULL,
  `create_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `p_sku` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1mtsbur82frn64de7balymq9s` (`category_id`),
  CONSTRAINT `FK1mtsbur82frn64de7balymq9s` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('2b93e3b7-85d8-41a2-901b-bf9db01cc9fd','2025-12-14',NULL,'https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724039/bej/products/pgf98kqufzuz2awvq05f.webp','Chân sạc iPhone 11 Pro Max',NULL,1,24),('37b4cf27-a191-4086-ac99-61038beb729e','2025-12-07',NULL,'https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088451/bej/products/wxewkwpq0pbdrj8rjv4x.webp','iPhone 17 - Chính hãng Apple Việt Nam',NULL,1,10),('660a1160-c655-4fb8-8cde-8dee50a3c1be','2025-12-07',NULL,'https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725342/bej/products/e7rwa4ze1q0gs3vdpvlz.webp','Samsung Galaxy S25',NULL,1,10),('bb0762fa-840e-4de1-adb7-d191ebe7d57f','2025-12-07',NULL,'https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724716/bej/products/vhv22cqkrwvoiuiwdta6.webp','Samsung Galaxy Z Flip7 5G',NULL,1,10),('d6cec6d1-e959-450d-b646-23de4258c0bb','2025-12-14',NULL,'https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701713/bej/products/cmrm46xt21juid58mfme.webp','Pin iPhone 11 Pro Max',NULL,1,24),('f262fea0-9e58-4863-85bf-c80bd28e62fa','2025-12-07',NULL,'https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112031/bej/products/wttxgjapgmknj8m1bgbx.webp','Samsung Galaxy Z Fold7 5G',NULL,1,10);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attribute`
--

DROP TABLE IF EXISTS `product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_attribute` (
  `id` varchar(255) NOT NULL,
  `discount` double NOT NULL,
  `final_price` double NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `original_price` double NOT NULL,
  `sold_quantity` int NOT NULL,
  `status` int NOT NULL,
  `stock_quantity` int NOT NULL,
  `variant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdxxu30j9j8nasm7w87624i9ku` (`variant_id`),
  CONSTRAINT `FKdxxu30j9j8nasm7w87624i9ku` FOREIGN KEY (`variant_id`) REFERENCES `product_variant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attribute`
--

LOCK TABLES `product_attribute` WRITE;
/*!40000 ALTER TABLE `product_attribute` DISABLE KEYS */;
INSERT INTO `product_attribute` VALUES ('0256c9b9-93c0-4be6-97fc-6bf0cc568142',0,1100000,'',1100000,1,0,1,'5394056d-3a8d-430c-a8ba-ac29459747ab'),('2f6d8da8-0b89-41a1-8401-f14ef3bb3962',0,30990000,'512 GB',30990000,21,0,211,'9474de3c-3158-4724-abd8-1ceed03d6ec9'),('345de1a2-1d7c-49dd-8e6a-d0e250c24bc7',0,30990000,'512 GB',30990000,21,0,12,'bb5d5194-344e-4f7f-9386-c6671981f22b'),('37c1a9e8-2664-4f54-a6e6-2d555d05712d',0,30990000,'512 GB',30990000,21,0,211,'1bbd8a48-ff12-4744-b7b6-58acdeae5940'),('3d038e44-a3d4-48c6-ba45-b94f1d8dce43',0,24990000,'256 GB',24990000,221,0,212,'bb5d5194-344e-4f7f-9386-c6671981f22b'),('5dabc04d-f222-4e26-84f9-aa49321e0293',0,25990000,'12 / 512 GB',31990000,342,0,3214,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f'),('6294ca85-c862-4456-8583-e7bd64de5652',0,17990000,'256 GB',22990000,33,0,2,'f4646957-1ba8-4b63-93ca-6ccdd4c32659'),('6baa992a-2960-4668-80b2-8e7299738dbc',0,1000000,'Cơ bản',1000000,312,0,231,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2'),('74060578-7be8-48ad-bae4-ad8f9f81b624',0,37990000,'12 / 256 GB',46990000,23,0,2,'57a1dea6-0216-4c60-9eb8-bbfc12647e17'),('9eb6b200-3f86-4ff5-a220-94b73104ee52',0,24990000,'256 GB',24990000,121,0,222,'1bbd8a48-ff12-4744-b7b6-58acdeae5940'),('a3c54274-956e-45ef-8a5c-989cb13ad3e0',0,22990000,'12 / 256 GB',28990000,23,0,2,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f'),('b7b7dda1-d5c5-40d9-839e-37dd2cadec9d',0,41990000,'12 / 512 GB',50990000,432,0,2,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670'),('bb955a7b-b3cf-43f2-98ee-bfe7db48b7a3',0,200000,'',200000,0,0,0,'06a1affa-af1e-48f6-85ca-dfd08d55e711'),('c0c5e0c9-6114-4988-bd67-d6520e7e4837',0,24990000,'256 GB',24990000,221,0,212,'73aea84a-350c-4dbd-9440-e31380f7d802'),('c4af9cee-db4d-4d90-a916-d82da1ea7295',0,1200000,'Dung lượng cao',1200000,2313,0,123,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2'),('c6bfd849-0006-48fe-9b85-f78c23a06000',0,17990000,'256 GB',22990000,2,0,2,'706b8987-aff6-4f11-a60b-047eca77ac7c'),('cbb6c151-2739-4ea0-ac1b-6a8fca460870',0,37990000,'12 / 256 GB',46990000,2,0,2,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670'),('cd3841c8-3587-4d0c-a237-779287830cfa',0,25990000,'12 / 512 GB',31990000,432,0,2,'e7df39fd-0db5-400b-868d-92bbaa275df3'),('d6160e8c-c48a-4548-9acc-a4c93d6eb007',0,30990000,'512 GB',30990000,21,0,12,'73aea84a-350c-4dbd-9440-e31380f7d802'),('d71b0222-f133-4e32-a615-a25a13e30213',0,46990000,'12 / 512 GB',50990000,342,0,3214,'57a1dea6-0216-4c60-9eb8-bbfc12647e17'),('f06df638-6254-48a6-a8e8-6112bcffc301',0,24990000,'256 GB',24990000,121,0,222,'9474de3c-3158-4724-abd8-1ceed03d6ec9'),('ff42ee7b-cef7-4345-a74c-56e135b46400',0,22990000,'12 / 256 GB',28990000,2,0,2,'e7df39fd-0db5-400b-868d-92bbaa275df3'),('ff42fd0d-0a32-4e84-8f6e-f1c9bd1d6053',0,1150000,'Dung lượng cao',1150000,23,0,12,'c9e48711-ed3c-484d-8158-2cef705fb45e');
/*!40000 ALTER TABLE `product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `id` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `variant_id` varchar(255) DEFAULT NULL,
  `sort_index` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6oo0cvcdtb6qmwsga468uuukk` (`product_id`),
  KEY `FKe67ln3cxyqqfleou64mihh4gg` (`variant_id`),
  CONSTRAINT `FK6oo0cvcdtb6qmwsga468uuukk` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKe67ln3cxyqqfleou64mihh4gg` FOREIGN KEY (`variant_id`) REFERENCES `product_variant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` VALUES ('00ce159e-b090-43fa-9808-d03915ba115b','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724730/bej/products/ukhgytx1unf9dvy9wwgg.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',0),('01c68645-3dc3-4665-b36b-25d9090d2257','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112046/bej/products/oyz4m7zboiww6iekm0w7.webp',NULL,'57a1dea6-0216-4c60-9eb8-bbfc12647e17',2),('027072f6-86dc-49ba-8d45-6a9e6a54e538','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725364/bej/products/hcpsdqb549mtuhhv0vnz.webp',NULL,'73aea84a-350c-4dbd-9440-e31380f7d802',0),('03821906-1f45-49be-bef9-a465373c0cd2','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725352/bej/products/t3nzzagucmqzt0ihnuhp.webp','660a1160-c655-4fb8-8cde-8dee50a3c1be',NULL,3),('05be8326-de3f-42b4-bd51-e5f56ba9b3de','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112033/bej/products/ptiszvywiku8a3re4ril.webp','f262fea0-9e58-4863-85bf-c80bd28e62fa',NULL,0),('05cf9356-0950-4c1a-bba0-734e820de136','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088470/bej/products/gxkjnfrh4przwxqsfzmk.webp',NULL,'bb5d5194-344e-4f7f-9386-c6671981f22b',1),('06f942a1-ca53-4eba-8d19-2d13f70d127a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725381/bej/products/haebtamibfpnovbzdel7.webp',NULL,'706b8987-aff6-4f11-a60b-047eca77ac7c',3),('078912c3-7917-49dd-935b-091fd4e377fb','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724050/bej/products/l5k43vphieqlpz50pryf.webp',NULL,'5394056d-3a8d-430c-a8ba-ac29459747ab',3),('08500da1-3c26-4a9f-b293-e1b53b157a37','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112050/bej/products/e8wk9xckhxptvsry2ku0.webp',NULL,'57a1dea6-0216-4c60-9eb8-bbfc12647e17',4),('08b00286-f562-4de6-88d5-083915276113','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112039/bej/products/vripqri4p05nq603ipdc.webp',NULL,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670',3),('09caffdf-a1cc-4dba-a5de-300a89157c95','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725358/bej/products/kyt8yvazqy1bhjnakbwj.webp',NULL,'1bbd8a48-ff12-4744-b7b6-58acdeae5940',1),('0bdb2923-9eae-429e-a14b-309f727094f3','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724044/bej/products/fmegswby3ropxvkfrm6u.webp',NULL,'5394056d-3a8d-430c-a8ba-ac29459747ab',0),('0f8883a4-6bc7-40cf-b209-026d8075d758','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725348/bej/products/rgnuy4qsdu2t2icdfvre.webp','660a1160-c655-4fb8-8cde-8dee50a3c1be',NULL,2),('11d07d7a-e86a-4da0-b89f-45e7dbd8556a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725376/bej/products/verd5qatfpcswevepzhp.webp',NULL,'706b8987-aff6-4f11-a60b-047eca77ac7c',0),('156c9cf3-bc23-4fbb-be8d-977666c94587','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701954/bej/products/iksy5h26rxdvt7hcrwta.webp',NULL,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2',3),('18020a6b-ecc2-431d-b22a-3d18d4c110e6','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725368/bej/products/kcijabveu0nd9uty4ufx.webp',NULL,'73aea84a-350c-4dbd-9440-e31380f7d802',2),('1d8b906b-511a-4f3e-9acd-833e99218267','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088456/bej/products/i7jtttz8uimhquq5x5vi.webp','37b4cf27-a191-4086-ac99-61038beb729e',NULL,2),('20072aff-da57-4126-a7de-edf10aecd5b3','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724734/bej/products/sfqcxjvtr6vmk3dimad8.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',3),('211d0d3b-7ec1-42d2-9614-4a22a6ae2ec1','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724718/bej/products/hpfbaoycnhgyeqcacdeb.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',0),('232b4433-4a7e-4d03-a861-7be761b42c96','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725370/bej/products/z52tiowbwtpr5zqmxy3f.webp',NULL,'73aea84a-350c-4dbd-9440-e31380f7d802',3),('2779f01c-540f-4d6a-ab05-26edbd47d707','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701714/bej/products/rvbrdhv88ezg6y7zfajh.webp',NULL,'c9e48711-ed3c-484d-8158-2cef705fb45e',0),('27af2081-ea03-4569-8ca0-aac4bcf36709','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701720/bej/products/sbsl5bwz5fntkxgv8vho.webp',NULL,'c9e48711-ed3c-484d-8158-2cef705fb45e',3),('350fd49c-a3fc-40ff-a9c1-5b0f21a58551','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725359/bej/products/xvywssrxpb13x7hsptmb.webp',NULL,'1bbd8a48-ff12-4744-b7b6-58acdeae5940',2),('356991a4-5d5b-430b-a997-320c9f897210','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725390/bej/products/iyiro5qwq4ukwnzk67do.webp',NULL,'f4646957-1ba8-4b63-93ca-6ccdd4c32659',3),('36ede998-b853-429b-806d-c21b7b9c61a5','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112043/bej/products/sjxlk8ylvcvv0vynwceg.webp',NULL,'57a1dea6-0216-4c60-9eb8-bbfc12647e17',0),('37f0f4b8-dde5-4e74-849d-5ea57da835b9','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725380/bej/products/xvcfdyhvlxn3vcdpifiv.webp',NULL,'706b8987-aff6-4f11-a60b-047eca77ac7c',2),('394e1715-ca9a-448d-8c6e-14ceb53a1374','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725386/bej/products/sx6agemxri6h2qbkvtvn.webp',NULL,'f4646957-1ba8-4b63-93ca-6ccdd4c32659',0),('39e76ea9-57bf-49fe-b1e5-2d33181ea1f7','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701950/bej/products/psazpx3il6tpylofnr3u.webp',NULL,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2',1),('3d909e61-cfd9-4268-91fb-5a85c5bcd7af','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724733/bej/products/maamjt3hfmvuesb1bh91.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',2),('3e873715-de6b-464c-8599-2bfbdc10f85a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724711/bej/products/ttxtblyhbv7k6vxqv3uh.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',6),('420e5eea-4001-4013-8181-7f7a3f6c43e5','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088468/bej/products/pgijxwlwo5f5yyrhn97y.webp',NULL,'bb5d5194-344e-4f7f-9386-c6671981f22b',0),('4273daf1-a6cd-4d46-bc71-56207f872c11','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112051/bej/products/ukqkiauwth6iwr3hmh0j.webp',NULL,'57a1dea6-0216-4c60-9eb8-bbfc12647e17',5),('429a982e-cbb7-4fd0-ab23-7aa7a2c9fd72','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088453/bej/products/efolm7xm1uyhfr3fpjum.webp','37b4cf27-a191-4086-ac99-61038beb729e',NULL,0),('42dc5bf6-d634-4ec3-9078-35f9b7bdc710','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725354/bej/products/ho2ptxpggjhrsjhfyk4t.webp','660a1160-c655-4fb8-8cde-8dee50a3c1be',NULL,4),('464e95d0-015d-44a0-8d63-7e4d3b2470d9','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088466/bej/products/gw5gutwjb5lm5iwiup6f.webp',NULL,'9474de3c-3158-4724-abd8-1ceed03d6ec9',3),('4840140a-ea6b-4d44-bd96-e79348e5d60c','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701948/bej/products/dguqbwkz4qokfbffm2or.webp',NULL,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2',0),('49baf4cd-e6d7-416e-a255-bbd2ddb6922a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088463/bej/products/bkwytl9b4xjxx2htxbwt.webp',NULL,'9474de3c-3158-4724-abd8-1ceed03d6ec9',1),('4d019d23-28bf-4ab5-acc3-5334e0abe54b','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724722/bej/products/fx8bim5usvmblqnvtx2m.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',2),('4fa220d5-a335-41e8-9b41-987641f57d3a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725375/bej/products/rqbql6hj5sq4851r9oxl.webp',NULL,'73aea84a-350c-4dbd-9440-e31380f7d802',5),('4fced4bc-58a9-4199-ac1e-eb1741fc4edb','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725393/bej/products/zjyq95tjwmewnjndrw7d.webp',NULL,'f4646957-1ba8-4b63-93ca-6ccdd4c32659',4),('58fe5e6c-7def-4ba2-9afe-0adf7305bfbe','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725362/bej/products/hkbxhvgcnv5lwvspagqg.webp',NULL,'1bbd8a48-ff12-4744-b7b6-58acdeae5940',4),('5b675b15-4a31-4230-b42f-5211382e8e8c','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701956/bej/products/zbwzq2tjtqc6jlomf0ua.webp',NULL,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2',4),('5cbf2b9a-6717-48b0-96f6-e0d3444be000','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724724/bej/products/aky2wsp6bji9dlpuxe8g.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',3),('6652dfd8-e475-4141-864a-a3d919a9ce5a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701722/bej/products/zbhask7rrel9z7rn4pzg.webp',NULL,'c9e48711-ed3c-484d-8158-2cef705fb45e',4),('6c572be5-1bec-4bee-8aa8-2459bcd6e734','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724727/bej/products/tkmoqms7cheofhmaej0e.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',5),('6d667a7b-d537-4e48-af75-6eab4a2c2f69','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724048/bej/products/bfmkzathexig9jqqgmvu.webp',NULL,'5394056d-3a8d-430c-a8ba-ac29459747ab',2),('7166b075-a671-4dcc-9a3d-1e9591a659e9','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088467/bej/products/ojqbct0eyzckc7ndrog5.webp',NULL,'9474de3c-3158-4724-abd8-1ceed03d6ec9',4),('7771b576-9033-4315-813f-955bd245b9d1','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112037/bej/products/qfckvvxzhukfvw9fizce.webp',NULL,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670',2),('77bccb30-5ca4-4ec1-b0d8-cf6dcaa631ee','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088454/bej/products/c8cbfyx1j47jhbuar5dt.webp','37b4cf27-a191-4086-ac99-61038beb729e',NULL,1),('7c18b00e-4c53-4085-a66c-428f2ae22f66','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725360/bej/products/ber0lxjwhznkq4vzfljz.webp',NULL,'1bbd8a48-ff12-4744-b7b6-58acdeae5940',3),('817966f0-57de-41ff-b0d1-b96e5433b295','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725345/bej/products/hbaabx1vqfpkelaeaems.webp','660a1160-c655-4fb8-8cde-8dee50a3c1be',NULL,0),('8209a5ba-7605-4d75-93a8-e1f89991c7f9','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725363/bej/products/bqq2oz4ncmshxaqbtarl.webp',NULL,'1bbd8a48-ff12-4744-b7b6-58acdeae5940',5),('8c9dc5b5-d178-419e-ba0a-009d0c974eb4','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725388/bej/products/v97waoilofnauisowzac.webp',NULL,'f4646957-1ba8-4b63-93ca-6ccdd4c32659',1),('8d64a750-3485-495f-9882-bbd87a7cccf9','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701716/bej/products/r2qoyufcwx72hmkasz7c.webp',NULL,'c9e48711-ed3c-484d-8158-2cef705fb45e',1),('8f955373-35bc-46f2-b2a0-e5c336c06b17','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112040/bej/products/gi7olscfjtbuzfult5xv.webp',NULL,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670',4),('946ad13e-4906-4b5a-b21a-3b87c93020b2','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725383/bej/products/e6khnroqwbcjxsxdcaul.webp',NULL,'706b8987-aff6-4f11-a60b-047eca77ac7c',4),('94caa173-de8c-4b46-9f65-bff932322e11','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112042/bej/products/n2svn2zsf31uobnlyhin.webp',NULL,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670',5),('956869d2-4192-40df-99b3-d32d80b4f315','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112036/bej/products/clb7xoqkvihcnu61m2yg.webp',NULL,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670',1),('963146a6-1afc-42bc-b068-e52361a7ffaf','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088464/bej/products/g5dethcvxc5vjw4fdl42.webp',NULL,'9474de3c-3158-4724-abd8-1ceed03d6ec9',2),('99390d50-7219-475e-83d9-b849bd74ca1d','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701718/bej/products/tqbpccjrefxmdqh9mmrk.webp',NULL,'c9e48711-ed3c-484d-8158-2cef705fb45e',2),('a067775f-c994-4af8-b03e-86c0477f5dab','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088461/bej/products/jmb29catynsrijxvcm9f.webp',NULL,'9474de3c-3158-4724-abd8-1ceed03d6ec9',0),('a33976e7-75ec-4648-a74c-22e24080f5c8','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112034/bej/products/fppbdhbrzy7xloxynuga.webp',NULL,'ccb1f63d-8fcb-4ca3-bef7-56669ee30670',0),('a946506e-f76e-445d-836c-bfd5176f473a','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725378/bej/products/fx3wtzdut2edkck7qn2o.webp',NULL,'706b8987-aff6-4f11-a60b-047eca77ac7c',1),('aa393a24-639f-4fee-b5e3-0cbc57260c89','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088458/bej/products/amxqh207tn56c4q9rfmg.webp','37b4cf27-a191-4086-ac99-61038beb729e',NULL,3),('b03d65c6-0446-4ce7-b138-50b7f96009ce','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724730/bej/products/cjbmjogsy4lk1zvy1syq.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',6),('b092ebd7-6595-4c78-b658-09d074c51f5f','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088475/bej/products/ipe0gzt1nrunhsvlkz18.webp',NULL,'bb5d5194-344e-4f7f-9386-c6671981f22b',4),('b0cc713f-f955-47b9-8d24-132f2f709bc3','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724738/bej/products/bmll7qhikg9twzd8sicj.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',6),('b30c867c-c1b6-49b2-8289-5510cf151897','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701957/bej/products/mp1del6ftd7bjnlzyhzu.webp',NULL,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2',5),('b9b1f169-e008-446f-b058-b0796978b3b6','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725347/bej/products/irqlvpgtftxwojob4gt8.webp','660a1160-c655-4fb8-8cde-8dee50a3c1be',NULL,1),('be6d45a5-2c69-449c-853b-77b7231b6846','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724731/bej/products/jj06vz7by1qgtuchkhde.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',1),('be7bc228-4b8e-4d6c-9b9e-341a0013f374','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724736/bej/products/mqdslzq7c5gjxocsbx3x.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',4),('c2fddc24-4230-4416-87aa-7a1af00215b0','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725384/bej/products/fb9m0whrlyuogmsxmhk0.webp',NULL,'706b8987-aff6-4f11-a60b-047eca77ac7c',5),('c6f89c06-b50a-4123-aae6-e23633357b2e','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725366/bej/products/ymkbmblml3eraaoacdbr.webp',NULL,'73aea84a-350c-4dbd-9440-e31380f7d802',1),('cfac0dbf-eb15-4e1d-9785-7fc6841fca67','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725389/bej/products/zswgjwxfqnwekyzjwy6t.webp',NULL,'f4646957-1ba8-4b63-93ca-6ccdd4c32659',2),('d4e40823-9294-4d3a-8dad-6027e8dc43b5','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724725/bej/products/c45hgovqhkiingge4a4s.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',4),('d5a21b89-3328-40cc-bf89-b6f4489d4756','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765701951/bej/products/ldcyxdtijysgy5z3rdpj.webp',NULL,'1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2',2),('d75d8931-a93a-429f-af69-99fdf213d9ed','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724046/bej/products/gnv41yciqz2arr8mgal2.webp',NULL,'5394056d-3a8d-430c-a8ba-ac29459747ab',1),('d8f6ec2f-d7ac-4454-bbad-9104eeb28fb1','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724737/bej/products/hy7nt2mtlq94lkloghvh.webp',NULL,'9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f',5),('d8fbd3e4-3f3b-4681-9d92-99c60e032e3c','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088460/bej/products/slanysokjimf3rpevesk.webp','37b4cf27-a191-4086-ac99-61038beb729e',NULL,4),('d990d9fc-0fbb-433f-a80b-8af4dbd12c06','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088473/bej/products/s9hyjnxiqjxbi62nv0le.webp',NULL,'bb5d5194-344e-4f7f-9386-c6671981f22b',3),('e3688c05-0dac-44d2-a777-959399e322ab','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765088472/bej/products/sgs4ztgwcm4n5rtjeg8w.webp',NULL,'bb5d5194-344e-4f7f-9386-c6671981f22b',2),('eb46a301-8acf-430a-8c50-fb597ea543d7','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724720/bej/products/okzoapw8hk8dghau8spx.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',1),('ec0f382e-9df0-42fd-8efd-f2efaafedd1c','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725372/bej/products/xwjt3aqbmm64hudtxctg.webp',NULL,'73aea84a-350c-4dbd-9440-e31380f7d802',4),('ee58c181-fb29-4228-940d-946e414fd2f3','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765724728/bej/products/gxd7vxpyabnx0yd29brp.webp',NULL,'e7df39fd-0db5-400b-868d-92bbaa275df3',6),('f52106cc-73f5-457f-94ca-8125f095dd20','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765725356/bej/products/xw3qws0okcbnamqsepds.webp',NULL,'1bbd8a48-ff12-4744-b7b6-58acdeae5940',0),('f669336d-6eb0-40a1-9328-d3336c809122','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112045/bej/products/msriqybz2gydzldq0sqk.webp',NULL,'57a1dea6-0216-4c60-9eb8-bbfc12647e17',1),('fe4c6176-2fd0-4ed3-9195-5c8859122580','https://res.cloudinary.com/dkbfbc5s9/image/upload/v1765112049/bej/products/csrgdl4h47cegewukj46.webp',NULL,'57a1dea6-0216-4c60-9eb8-bbfc12647e17',3);
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variant`
--

DROP TABLE IF EXISTS `product_variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variant` (
  `id` varchar(255) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `sort_index` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgrbbs9t374m9gg43l6tq1xwdj` (`product_id`),
  CONSTRAINT `FKgrbbs9t374m9gg43l6tq1xwdj` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variant`
--

LOCK TABLES `product_variant` WRITE;
/*!40000 ALTER TABLE `product_variant` DISABLE KEYS */;
INSERT INTO `product_variant` VALUES ('06a1affa-af1e-48f6-85ca-dfd08d55e711','Công thay',NULL,'d6cec6d1-e959-450d-b646-23de4258c0bb',2),('1bbd8a48-ff12-4744-b7b6-58acdeae5940','Xanh Dương Nhạt',NULL,'660a1160-c655-4fb8-8cde-8dee50a3c1be',0),('1ecfc9b5-e9d7-4aca-b9af-ada38ebac9f2','Pisen',NULL,'d6cec6d1-e959-450d-b646-23de4258c0bb',1),('5394056d-3a8d-430c-a8ba-ac29459747ab','',NULL,'2b93e3b7-85d8-41a2-901b-bf9db01cc9fd',0),('57a1dea6-0216-4c60-9eb8-bbfc12647e17','Xanh Navy',NULL,'f262fea0-9e58-4863-85bf-c80bd28e62fa',1),('706b8987-aff6-4f11-a60b-047eca77ac7c','Xanh Dương Đậm',NULL,'660a1160-c655-4fb8-8cde-8dee50a3c1be',2),('73aea84a-350c-4dbd-9440-e31380f7d802','Xanh Lá',NULL,'660a1160-c655-4fb8-8cde-8dee50a3c1be',1),('9474de3c-3158-4724-abd8-1ceed03d6ec9','Xanh Lam Khói',NULL,'37b4cf27-a191-4086-ac99-61038beb729e',0),('9f9b6aca-b8f8-413d-a4a8-5b967b06ac1f','Đỏ San Hô',NULL,'bb0762fa-840e-4de1-adb7-d191ebe7d57f',1),('bb5d5194-344e-4f7f-9386-c6671981f22b','Tím Oải Hương',NULL,'37b4cf27-a191-4086-ac99-61038beb729e',1),('c9e48711-ed3c-484d-8158-2cef705fb45e','GENA',NULL,'d6cec6d1-e959-450d-b646-23de4258c0bb',0),('ccb1f63d-8fcb-4ca3-bef7-56669ee30670','Xám bạc',NULL,'f262fea0-9e58-4863-85bf-c80bd28e62fa',0),('e7df39fd-0db5-400b-868d-92bbaa275df3','Đen Tuyền',NULL,'bb0762fa-840e-4de1-adb7-d191ebe7d57f',0),('f4646957-1ba8-4b63-93ca-6ccdd4c32659','Xám Bạc',NULL,'660a1160-c655-4fb8-8cde-8dee50a3c1be',3);
/*!40000 ALTER TABLE `product_variant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('ADMIN','system admin'),('EMPLOYEE_MANAGER','hr'),('SHOP_MANAGER','hr'),('USER','user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_name` varchar(255) NOT NULL,
  `permissions_name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_name`,`permissions_name`),
  KEY `FKf5aljih4mxtdgalvr7xvngfn1` (`permissions_name`),
  CONSTRAINT `FKcppvu8fk24eqqn6q4hws7ajux` FOREIGN KEY (`role_name`) REFERENCES `role` (`name`),
  CONSTRAINT `FKf5aljih4mxtdgalvr7xvngfn1` FOREIGN KEY (`permissions_name`) REFERENCES `permission` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES ('ADMIN','MANAGE_PRODUCT'),('SHOP_MANAGER','MANAGE_PRODUCT'),('ADMIN','MANAGE_ROLE'),('ADMIN','MANAGE_STAFF'),('EMPLOYEE_MANAGER','MANAGE_STAFF');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift`
--

DROP TABLE IF EXISTS `shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shift` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `end_time` time(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `start_time` time(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shift`
--

LOCK TABLES `shift` WRITE;
/*!40000 ALTER TABLE `shift` DISABLE KEYS */;
INSERT INTO `shift` VALUES (1,'22:00:00.000000','ca tối','16:00:00.000000'),(2,'13:00:00.000000','ca chiều','17:00:00.000000'),(3,'12:00:00.000000','ca sáng','08:00:00.000000');
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supply`
--

DROP TABLE IF EXISTS `supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supply` (
  `id` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `type` int NOT NULL,
  `attribute_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfxksjbbr3yohhqkijo04w6l7x` (`attribute_id`),
  CONSTRAINT `FKfxksjbbr3yohhqkijo04w6l7x` FOREIGN KEY (`attribute_id`) REFERENCES `product_attribute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supply`
--

LOCK TABLES `supply` WRITE;
/*!40000 ALTER TABLE `supply` DISABLE KEYS */;
/*!40000 ALTER TABLE `supply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `schedule_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4qtkj48h77kpufjk5lxqh1hrr` (`schedule_id`),
  CONSTRAINT `FK4qtkj48h77kpufjk5lxqh1hrr` FOREIGN KEY (`schedule_id`) REFERENCES `work_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('33ff2646-2922-416c-8216-c877201ed659','test1','2025-12-03','admin@gmail.com','admin','$2a$10$Dkxp5l6Bs0z9cTDFdRDz5u7th3l8MsM3U6Qm/OfRpuB1z35CrawRe','admin'),('6895cccc-4891-4c15-981a-e59a2d16a939',NULL,NULL,'culacgi0ntan27@gmail.com',NULL,'$2a$10$K6kdNc7TE24egJ9.pnnSqO2vBddj5BgUDNkp./fu.r4H1xoXQGYoK','044'),('7cacd02a-7e5b-4321-ba46-b3500ccf8589',NULL,NULL,'abcdzyx027@gmail.com','Đặng Tiến Dũng','$2a$10$pGAEaNAdoORJD1c.kPxnRegR2ce6CB.rRXGlNBYO1uxJuZYc7gcRC','0986068436'),('8460cfc0-ca09-4ce2-98bc-0fe5f6ba015b',NULL,NULL,'adu113@gmail.com','adu1111','$2a$10$wGmzfiyfIjKeQHhmNPseguTnpWt59VyH4nlEr6GJt/35zUPBRNPRe','0333333333'),('8d04670e-170d-40fe-9477-545169f62832',NULL,NULL,'adu112@gmail.com',NULL,'$2a$10$ADiI.Gd7rgcTno9fUNzGp.AuSZm74atoVQ3ikg2r0R.xC60AnOMs2','0222222222'),('a1b2c3d4-e5f6-7890-abcd-ef1234567890','Hà Nội','1995-05-15','nguyenvana@gmail.com','Nguyễn Văn A','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0912345678'),('b2c3d4e5-f6a7-8901-bcde-f12345678901','TP.HCM','1998-08-20','tranthib@gmail.com','Trần Thị B','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0923456789'),('b78ae41e-2ec3-4065-a876-06a16a039f15','Hn','2003-07-21','adu111','Đặng Tiến Dũng','$2a$10$5qXSUvNSFkqO50707YPGdul.JlbAzXnwTgHfexPagSx5UHAPxEvhC','0111111111'),('c3d4e5f6-a7b8-9012-cdef-123456789012','Đà Nẵng','1990-12-10','levanc@gmail.com','Lê Văn C','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0934567890'),('d4e5f6a7-b8c9-0123-def0-234567890123','Hải Phòng','1992-03-25','phamthid@gmail.com','Phạm Thị D','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0945678901'),('e5f6a7b8-c9d0-1234-ef01-345678901234','Cần Thơ','1988-11-30','hoangvane@gmail.com','Hoàng Văn E','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0956789012'),('ff5e7dc7-0c39-4b37-aba3-da4b267c88cf','An Duong, Yen Phu, Tay Ho, Ha Noi','2003-01-01','test1@gmail.com','test12','$2a$10$WOlG6yMjBfjjXwJCRwniGuSGBnYtL3mg052yCMLsapxTfMC3snt3m','0123123123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` varchar(255) NOT NULL,
  `roles_name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`,`roles_name`),
  KEY `FK6pmbiap985ue1c0qjic44pxlc` (`roles_name`),
  CONSTRAINT `FK55itppkw3i07do3h7qoclqd4k` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK6pmbiap985ue1c0qjic44pxlc` FOREIGN KEY (`roles_name`) REFERENCES `role` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES ('33ff2646-2922-416c-8216-c877201ed659','ADMIN'),('c3d4e5f6-a7b8-9012-cdef-123456789012','EMPLOYEE_MANAGER'),('b78ae41e-2ec3-4065-a876-06a16a039f15','SHOP_MANAGER'),('e5f6a7b8-c9d0-1234-ef01-345678901234','SHOP_MANAGER'),('33ff2646-2922-416c-8216-c877201ed659','USER'),('6895cccc-4891-4c15-981a-e59a2d16a939','USER'),('7cacd02a-7e5b-4321-ba46-b3500ccf8589','USER'),('8460cfc0-ca09-4ce2-98bc-0fe5f6ba015b','USER'),('8d04670e-170d-40fe-9477-545169f62832','USER'),('a1b2c3d4-e5f6-7890-abcd-ef1234567890','USER'),('b2c3d4e5-f6a7-8901-bcde-f12345678901','USER'),('d4e5f6a7-b8c9-0123-def0-234567890123','USER'),('ff5e7dc7-0c39-4b37-aba3-da4b267c88cf','USER');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_schedule`
--

DROP TABLE IF EXISTS `work_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_schedule` (
  `id` varchar(255) NOT NULL,
  `work_date` date DEFAULT NULL,
  `shift_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKecv0f0fbx9xaugnudb23j73yf` (`shift_id`),
  CONSTRAINT `FKecv0f0fbx9xaugnudb23j73yf` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_schedule`
--

LOCK TABLES `work_schedule` WRITE;
/*!40000 ALTER TABLE `work_schedule` DISABLE KEYS */;
INSERT INTO `work_schedule` VALUES ('21f9f857-b1e1-4f01-b17a-2461e119ddb4','2025-11-12',1),('80a11c40-d34c-4b11-aee1-c008580f06a6','2025-11-08',1),('8233fff7-19ee-4495-993c-98c87a52d5f9','2025-11-13',1),('dab0a215-7455-4b8f-b777-8992202799a9','2025-11-19',1),('w1a2b3c4-d5e6-7890-abcd-ef1234567890','2025-11-20',2),('w2b3c4d5-e6f7-8901-bcde-f12345678901','2025-11-21',3),('w3c4d5e6-f7a8-9012-cdef-123456789012','2025-11-22',1),('w4d5e6f7-a8b9-0123-def0-234567890123','2025-11-23',2),('w5e6f7a8-b9c0-1234-ef01-345678901234','2025-11-24',3);
/*!40000 ALTER TABLE `work_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_schedule_users`
--

DROP TABLE IF EXISTS `work_schedule_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_schedule_users` (
  `work_schedule_id` varchar(255) NOT NULL,
  `users_id` varchar(255) NOT NULL,
  PRIMARY KEY (`work_schedule_id`,`users_id`),
  KEY `FKlclio9mgtepvvgj2iwmu29ps6` (`users_id`),
  CONSTRAINT `FKlclio9mgtepvvgj2iwmu29ps6` FOREIGN KEY (`users_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKoorh76k38she07yiv2ublql86` FOREIGN KEY (`work_schedule_id`) REFERENCES `work_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_schedule_users`
--

LOCK TABLES `work_schedule_users` WRITE;
/*!40000 ALTER TABLE `work_schedule_users` DISABLE KEYS */;
INSERT INTO `work_schedule_users` VALUES ('21f9f857-b1e1-4f01-b17a-2461e119ddb4','24daab77-a1cb-4e14-b002-cb0754acbc52'),('80a11c40-d34c-4b11-aee1-c008580f06a6','24daab77-a1cb-4e14-b002-cb0754acbc52'),('8233fff7-19ee-4495-993c-98c87a52d5f9','24daab77-a1cb-4e14-b002-cb0754acbc52'),('dab0a215-7455-4b8f-b777-8992202799a9','24daab77-a1cb-4e14-b002-cb0754acbc52'),('w2b3c4d5-e6f7-8901-bcde-f12345678901','24daab77-a1cb-4e14-b002-cb0754acbc52'),('21f9f857-b1e1-4f01-b17a-2461e119ddb4','b78ae41e-2ec3-4065-a876-06a16a039f15'),('80a11c40-d34c-4b11-aee1-c008580f06a6','b78ae41e-2ec3-4065-a876-06a16a039f15'),('8233fff7-19ee-4495-993c-98c87a52d5f9','b78ae41e-2ec3-4065-a876-06a16a039f15'),('dab0a215-7455-4b8f-b777-8992202799a9','b78ae41e-2ec3-4065-a876-06a16a039f15'),('w3c4d5e6-f7a8-9012-cdef-123456789012','b78ae41e-2ec3-4065-a876-06a16a039f15'),('w1a2b3c4-d5e6-7890-abcd-ef1234567890','c3d4e5f6-a7b8-9012-cdef-123456789012'),('w4d5e6f7-a8b9-0123-def0-234567890123','c3d4e5f6-a7b8-9012-cdef-123456789012'),('w1a2b3c4-d5e6-7890-abcd-ef1234567890','e5f6a7b8-c9d0-1234-ef01-345678901234'),('w5e6f7a8-b9c0-1234-ef01-345678901234','e5f6a7b8-c9d0-1234-ef01-345678901234');
/*!40000 ALTER TABLE `work_schedule_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-14 22:22:17
