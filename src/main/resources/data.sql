-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: new_bej_sp3
-- ------------------------------------------------------
-- Server version 8.0.40

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
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT IGNORE INTO `brand` (`id`, `name`) VALUES (1,'Apple'),(2,'Samsung'),(3,'Xiaomi'),(4,'ASUS'),(5,'Lenovo'),(6,'Dell'),(7,'HP'),(8,'Sony');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT IGNORE INTO `cart_item` (`id`, `added_at`, `color`, `price`, `product_name`, `quantity`, `attribute_id`, `user_id`) VALUES ('60c5b0ed-73a9-457d-a1e8-324da4d79695', '2025-11-15', 'Xám Chạng Vạng', 17990000, 'Điện thoại Gaming REDMAGIC 10 PRO', 1, 'e90790cb-53e9-4698-9c48-ef1b68595c1e', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('a4730218-5959-4e69-a391-d6f538d65f23', '2025-11-15', 'Xanh Mint', 24990000, 'iPhone 17 - Chính hãng VN/A', 1, '4fe5a207-37aa-48e4-ad07-d3efe85808d0', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('f67df6c1-2092-4c23-b42f-5e606c434057', '2025-11-15', 'Tím Oải Hương', 24990000, 'iPhone 17 - Chính hãng VN/A', 2, '55fc806d-2bb8-4084-98a5-e013df320bc3', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('c1a2b3c4-d5e6-7890-abcd-ef1234567890', '2025-11-20', 'Đen Titanium', 29990000, 'Samsung Galaxy S24 Ultra', 1, 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'), ('c2b3c4d5-e6f7-8901-bcde-f12345678901', '2025-11-20', 'Xám Space', 69990000, 'MacBook Pro 16 inch M3', 1, 'a4b5c6d7-e8f9-0123-def0-234567890123', 'b2c3d4e5-f6a7-8901-bcde-f12345678901'), ('c3c4d5e6-f7a8-9012-cdef-123456789012', '2025-11-21', 'Xám Space', 24990000, 'iPad Pro 12.9 inch', 2, 'a7b8c9d0-e1f2-3456-0123-567890123456', 'c3d4e5f6-a7b8-9012-cdef-123456789012'), ('c4d5e6f7-a8b9-0123-def0-234567890123', '2025-11-21', 'Titanium', 19990000, 'Apple Watch Ultra 2', 1, 'a9b0c1d2-e3f4-5678-2345-789012345678', 'd4e5f6a7-b8c9-0123-def0-234567890123');
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT IGNORE INTO `category` (`id`, `name`, `sku`) VALUES (10,'Điện Thoại','DT'),(11,'Dịch Vụ','DVV'),(12,'Phụ Kiện','PK'),(13,'Laptop','LT'),(14,'Tablet','TB'),(15,'Smartwatch','SW'),(16,'Tai Nghe','TN');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `invalidated_token`
--

LOCK TABLES `invalidated_token` WRITE;
/*!40000 ALTER TABLE `invalidated_token` DISABLE KEYS */;
INSERT IGNORE INTO `invalidated_token` VALUES ('04c69e7b-6fa0-4524-bd0b-810459635b3c','2025-04-02 15:27:51.000000'),('05c6a35d-5ff9-4636-ac0a-b5c27e22613e','2025-04-02 16:35:57.000000'),('104a26f8-1a58-4b5c-bfb4-d4bdefd776de','2025-11-07 23:59:21.000000'),('198d41eb-bbac-4ab5-9a1c-19d7eb496360','2025-04-02 16:05:37.000000'),('33041d8e-5815-4dc5-a44d-2487e3002b06','2025-04-02 16:41:11.000000'),('39eb7e24-c938-4d80-9950-32355979884c','2025-04-02 16:07:54.000000'),('466bd302-75fa-45f4-b9ee-4eb0b060aca2','2025-04-02 16:53:52.000000'),('4f7607e1-de89-49ac-b273-0815b7b2c9c6','2025-04-02 15:14:22.000000'),('66f2e950-566f-4c38-ac09-b0eac84e7d32','2025-04-02 16:17:11.000000'),('767467bb-a37d-4eab-b710-eede84d09424','2025-04-02 16:43:32.000000'),('8882a836-a1bb-4c48-b392-74d005c2a910','2025-04-02 16:40:25.000000'),('89606b19-82b6-4f33-b998-5eaeffb0867c','2025-04-02 16:24:37.000000'),('8a411fab-dae5-4752-97c5-2f5e12d50eb8','2025-04-02 16:36:41.000000'),('8edb7c59-047a-4f4d-bf11-18758bce4528','2025-11-07 23:57:58.000000'),('bfb2211c-5fc9-4777-a25d-7223c13d5909','2025-04-02 16:34:42.000000'),('c2db5871-6442-4832-b269-7b00af3ae9d8','2025-04-02 16:45:58.000000'),('c3daa5d2-6397-4690-bf78-dc84126b71f7','2025-04-02 16:46:52.000000'),('cca41f47-8cb2-4dfd-a40c-d57fad3d04ca','2025-04-02 16:51:38.000000'),('d1b08af2-e4c9-48c8-a261-9077370b786a','2025-04-02 15:41:40.000000'),('db61c0b8-e1a0-47ad-a4f1-a9de3996fc40','2025-04-02 16:37:15.000000'),('eb2c93a9-d4d6-4d48-b761-ff0e2dfa78e4','2025-11-08 00:48:48.000000'),('ef717bfd-e608-44ab-9e2a-00477114b23b','2025-04-02 16:48:41.000000'),('f41f72d9-288b-400b-99a8-110d814eaf70','2025-11-10 04:33:12.000000');
/*!40000 ALTER TABLE `invalidated_token` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT IGNORE INTO `order_item` (`id`, `price`, `quantity`, `order_id`, `attribute_id`) VALUES ('1177a06a-52b8-4ee3-8d3c-8cdf49dc1c18', 234234234, 1, 'b63534c6-c51b-4164-9e2c-591efb2f7ef6', '4fe5a207-37aa-48e4-ad07-d3efe85808d0'), ('12ce3e6f-6f24-4822-956d-d90ec8a78c99', 234234234, 1, 'f0889d76-ac83-4fba-ac1c-d29a03aef7a2', '4fe5a207-37aa-48e4-ad07-d3efe85808d0'), ('1d5e9d3e-f6a2-419b-885d-b985b8849fc3', 234234234, 1, 'f0889d76-ac83-4fba-ac1c-d29a03aef7a2', 'e90790cb-53e9-4698-9c48-ef1b68595c1e'), ('46011f9a-5dec-456b-a662-d4abac52c45a', 234234234, 1, 'c1828a7b-92fb-4e18-84bc-3ef957cf937f', 'e90790cb-53e9-4698-9c48-ef1b68595c1e'), ('541d449f-9182-4966-b632-f49e0b18daa6', 234234234, 1, 'cd39ee4a-ac3a-48a2-9057-e8476f4994b0', 'e90790cb-53e9-4698-9c48-ef1b68595c1e'), ('59d63a6c-32ae-4d3e-b904-ce4fae2d6ebe', 234234234, 1, 'b63534c6-c51b-4164-9e2c-591efb2f7ef6', 'e90790cb-53e9-4698-9c48-ef1b68595c1e'), ('5abe2628-5c7c-4857-87b7-d51c71240568', 234234234, 1, 'cd39ee4a-ac3a-48a2-9057-e8476f4994b0', '4fe5a207-37aa-48e4-ad07-d3efe85808d0'), ('c90a3324-40ba-4595-8d94-039915f79ba0', 234234234, 1, 'c1828a7b-92fb-4e18-84bc-3ef957cf937f', '4fe5a207-37aa-48e4-ad07-d3efe85808d0'), ('i1a2b3c4-d5e6-7890-abcd-ef1234567890', 29990000, 1, 'o1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'), ('i2b3c4d5-e6f7-8901-bcde-f12345678901', 69990000, 1, 'o2b3c4d5-e6f7-8901-bcde-f12345678901', 'a4b5c6d7-e8f9-0123-def0-234567890123'), ('i3c4d5e6-f7a8-9012-cdef-123456789012', 24990000, 1, 'o3c4d5e6-f7a8-9012-cdef-123456789012', 'a7b8c9d0-e1f2-3456-0123-567890123456'), ('i4d5e6f7-a8b9-0123-def0-234567890123', 19990000, 1, 'o4d5e6f7-a8b9-0123-def0-234567890123', 'a9b0c1d2-e3f4-5678-2345-789012345678'), ('i5e6f7a8-b9c0-1234-ef01-345678901234', 6990000, 1, 'o5e6f7a8-b9c0-1234-ef01-345678901234', 'a0b1c2d3-e4f5-6789-3456-890123456789');
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT IGNORE INTO `orders` (`id`, `address`, `description`, `email`, `order_at`, `phone_number`, `status`, `total_price`, `type`, `updated_at`, `user_id`) VALUES ('b63534c6-c51b-4164-9e2c-591efb2f7ef6', 'Hn', 'giao hang', 'adu112@gmail.com', '2025-11-10', '01234123413', 0, 468468468, 0, '2025-11-10', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('c1828a7b-92fb-4e18-84bc-3ef957cf937f', 'Hn', 'giao hang', 'adu112@gmail.com', '2025-11-09', '01234123413', 0, 234234234, 0, '2025-11-09', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('cd39ee4a-ac3a-48a2-9057-e8476f4994b0', 'Hn', 'giao hang', 'adu112@gmail.com', '2025-11-10', '01234123413', 0, 234234234, 0, '2025-11-10', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('f0889d76-ac83-4fba-ac1c-d29a03aef7a2', 'Hn', 'giao hang', 'adu112@gmail.com', '2025-11-09', '01234123413', 0, 468468468, 0, '2025-11-09', '6895cccc-4891-4c15-981a-e59a2d16a939'), ('o1a2b3c4-d5e6-7890-abcd-ef1234567890', '123 Đường ABC, Quận 1, TP.HCM', 'Giao hàng trong giờ hành chính', 'nguyenvana@gmail.com', '2025-11-15', '0912345678', 1, 29990000, 0, '2025-11-15', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'), ('o2b3c4d5-e6f7-8901-bcde-f12345678901', '456 Đường XYZ, Quận 2, TP.HCM', 'Giao hàng nhanh', 'tranthib@gmail.com', '2025-11-16', '0923456789', 2, 69990000, 0, '2025-11-16', 'b2c3d4e5-f6a7-8901-bcde-f12345678901'), ('o3c4d5e6-f7a8-9012-cdef-123456789012', '789 Đường DEF, Quận Hải Châu, Đà Nẵng', 'Giao hàng tiết kiệm', 'levanc@gmail.com', '2025-11-17', '0934567890', 0, 24990000, 0, '2025-11-17', 'c3d4e5f6-a7b8-9012-cdef-123456789012'), ('o4d5e6f7-a8b9-0123-def0-234567890123', '321 Đường GHI, Quận Ngô Quyền, Hải Phòng', 'Giao hàng trong ngày', 'phamthid@gmail.com', '2025-11-18', '0945678901', 1, 19990000, 0, '2025-11-18', 'd4e5f6a7-b8c9-0123-def0-234567890123'), ('o5e6f7a8-b9c0-1234-ef01-345678901234', '654 Đường JKL, Quận Ninh Kiều, Cần Thơ', 'Giao hàng tiêu chuẩn', 'hoangvane@gmail.com', '2025-11-19', '0956789012', 0, 6990000, 0, '2025-11-19', 'e5f6a7b8-c9d0-1234-ef01-345678901234');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT IGNORE INTO `permission` VALUES ('MANAGE_PRODUCT','creata/update product data'),('MANAGE_ROLE','give roles for staff'),('MANAGE_STAFF','manage staff');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT IGNORE INTO `product` VALUES ('d037bdf6-50a0-4663-a073-98534b070412','2025-10-30',NULL,'http://localhost:8080/bej3/images/redmagic-pro-10-thumb-ads.webp','Điện thoại Gaming REDMAGIC 10 PRO',NULL,1,10),('feac3c08-0803-4393-9a87-64e5d2d7811f','2025-10-19',NULL,'http://localhost:8080/bej3/images/iphone-17-thuong.webp','iPhone 17 - Chính hãng VN/A',NULL,1,10),('f1a2b3c4-d5e6-7890-abcd-ef1234567890','2025-11-01',NULL,'http://localhost:8080/bej3/images/samsung-s24-ultra.webp','Samsung Galaxy S24 Ultra','Điện thoại flagship với camera 200MP và S Pen',1,10),('a2b3c4d5-e6f7-8901-bcde-f12345678901','2025-11-02',NULL,'http://localhost:8080/bej3/images/macbook-pro-16.webp','MacBook Pro 16 inch M3','Laptop chuyên nghiệp với chip Apple M3',1,13),('b3c4d5e6-f7a8-9012-cdef-123456789012','2025-11-03',NULL,'http://localhost:8080/bej3/images/ipad-pro-12.webp','iPad Pro 12.9 inch','Tablet mạnh mẽ với màn hình Liquid Retina XDR',1,14),('c4d5e6f7-a8b9-0123-def0-234567890123','2025-11-04',NULL,'http://localhost:8080/bej3/images/apple-watch-ultra.webp','Apple Watch Ultra 2','Smartwatch cao cấp cho thể thao và phiêu lưu',1,15),('d5e6f7a8-b9c0-1234-ef01-345678901234','2025-11-05',NULL,'http://localhost:8080/bej3/images/airpods-pro-2.webp','AirPods Pro 2','Tai nghe không dây với chống ồn chủ động',1,16),('e6f7a8b9-c0d1-2345-f012-456789012345','2025-11-06',NULL,'http://localhost:8080/bej3/images/xiaomi-14-pro.webp','Xiaomi 14 Pro','Điện thoại flagship với camera Leica',1,10);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_attribute`
--

LOCK TABLES `product_attribute` WRITE;
/*!40000 ALTER TABLE `product_attribute` DISABLE KEYS */;
INSERT IGNORE INTO `product_attribute` VALUES ('4fe5a207-37aa-48e4-ad07-d3efe85808d0',0,24990000,'256 GB',24990000,0,0,0,'f9b528cb-f6c7-4eb6-a457-3590fa3efb94'),('55fc806d-2bb8-4084-98a5-e013df320bc3',0,24990000,'256 GB',24990000,54,0,1221,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8'),('6670f5da-7bd5-4e00-ae35-b43bbdff2f5e',0,21990000,'16 / 512 GB',23990000,222,0,222,'b0a23544-1067-444b-b7f3-f0eaad9c1b55'),('d10c5f96-724b-433b-b049-9111a0938582',0,31490000,'512 GB',31490000,5443,0,24,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8'),('e90790cb-53e9-4698-9c48-ef1b68595c1e',0,17990000,'12 / 256 GB',21990000,21,0,11,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3'),('a1b2c3d4-e5f6-7890-abcd-ef1234567890',0,29990000,'256 GB',29990000,0,0,0,'v1a2b3c4-d5e6-7890-abcd-ef1234567890'),('a2b3c4d5-e6f7-8901-bcde-f12345678901',0,32990000,'512 GB',32990000,0,0,0,'v1a2b3c4-d5e6-7890-abcd-ef1234567890'),('a3b4c5d6-e7f8-9012-cdef-123456789012',0,27990000,'256 GB',27990000,0,0,0,'v2b3c4d5-e6f7-8901-bcde-f12345678901'),('a4b5c6d7-e8f9-0123-def0-234567890123',0,69990000,'M3 Pro 18GB/512GB',69990000,0,0,0,'v3c4d5e6-f7a8-9012-cdef-123456789012'),('a5b6c7d8-e9f0-1234-ef01-345678901234',0,79990000,'M3 Max 36GB/1TB',79990000,0,0,0,'v3c4d5e6-f7a8-9012-cdef-123456789012'),('a6b7c8d9-e0f1-2345-f012-456789012345',0,84990000,'M3 Max 36GB/1TB',84990000,0,0,0,'v4d5e6f7-a8b9-0123-def0-234567890123'),('a7b8c9d0-e1f2-3456-0123-567890123456',0,24990000,'128 GB',24990000,0,0,0,'v5e6f7a8-b9c0-1234-ef01-345678901234'),('a8b9c0d1-e2f3-4567-1234-678901234567',0,29990000,'256 GB',29990000,0,0,0,'v5e6f7a8-b9c0-1234-ef01-345678901234'),('a9b0c1d2-e3f4-5678-2345-789012345678',0,19990000,'49mm Titanium',19990000,0,0,0,'v7a8b9c0-d1e2-3456-0123-567890123456'),('a0b1c2d3-e4f5-6789-3456-890123456789',0,6990000,'Chuẩn',6990000,0,0,0,'v8b9c0d1-e2f3-4567-1234-678901234567'),('b1c2d3e4-f5a6-7890-4567-901234567890',0,6990000,'Chuẩn',6990000,0,0,0,'v9c0d1e2-f3a4-5678-2345-789012345678'),('b2c3d4e5-f6a7-8901-5678-012345678901',0,15990000,'128 GB',15990000,0,0,0,'v0d1e2f3-a4b5-6789-3456-890123456789'),('b3c4d5e6-f7a8-9012-6789-123456789012',0,17990000,'256 GB',17990000,0,0,0,'v0d1e2f3-a4b5-6789-3456-890123456789'),('b4c5d6e7-f8a9-0123-7890-234567890123',0,17990000,'128 GB',17990000,0,0,0,'v1e2f3a4-b5c6-7890-4567-901234567890'),('b5c6d7e8-f9a0-1234-8901-345678901234',0,19990000,'256 GB',19990000,0,0,0,'v1e2f3a4-b5c6-7890-4567-901234567890');
/*!40000 ALTER TABLE `product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT IGNORE INTO `product_image` VALUES ('0944667b-aea4-43c4-a9e3-e3ffad564514','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-8-usb-c-charge-cable-vn-vi.webp',NULL,'f9b528cb-f6c7-4eb6-a457-3590fa3efb94',4),('09d4cd50-0a4c-462c-830b-7b5f7d438ab7','http://localhost:8080/bej3/images/redmagic-10-pro-xam-2.webp',NULL,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3',1),('155fecea-3b50-4967-a927-c2fc5aa6e563','http://localhost:8080/bej3/images/iphone-17-lavender-pdp-image-position-3-design-vn-vi.webp',NULL,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8',2),('242f33a0-141f-4095-80c5-cc3d84b58c5c','http://localhost:8080/bej3/images/iphone-17-lavender-pdp-image-position-4-design-detail-vn-vi.webp',NULL,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8',3),('2ae39886-49bb-4ef1-9ae3-7933b95d0516','http://localhost:8080/bej3/images/redmagic-10-pro-bac-3.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',2),('2d1863c5-bfbd-4e42-ab88-0faafd6cf17c','http://localhost:8080/bej3/images/iphone-17-lavender-pdp-image-position-2-lavender-color-vn-vi.webp',NULL,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8',1),('3673bdb2-1a93-49ee-8a93-613622d1b3d1','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-10-accessory-detail-vn-vi.webp','feac3c08-0803-4393-9a87-64e5d2d7811f',NULL,4),('386eef01-3059-4321-bcc6-3859b119a5d0','http://localhost:8080/bej3/images/3.webp','d037bdf6-50a0-4663-a073-98534b070412',NULL,2),('3baed11a-dde8-4003-9c16-3bc276c612c9','http://localhost:8080/bej3/images/iphone-17-lavender-pdp-image-position-8-usb-c-charge-cable-vn-vi.webp',NULL,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8',4),('43dcad39-640e-451a-8613-4166158b4348','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-9-accessory-vn-vi.webp','feac3c08-0803-4393-9a87-64e5d2d7811f',NULL,3),('4cf56a95-8474-4b09-bf47-20f0c1089fa9','http://localhost:8080/bej3/images/dsc05944.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',5),('52e3b31f-b4c5-4108-9653-922bf795c54e','http://localhost:8080/bej3/images/2.webp','d037bdf6-50a0-4663-a073-98534b070412',NULL,1),('5cbc30e2-3ed1-4de5-9c40-43f1a24ab8c3','http://localhost:8080/bej3/images/redmagic-10-pro-xam-3.webp',NULL,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3',2),('5ea0ff64-6d63-4ab6-9a10-15c0f666c7b7','http://localhost:8080/bej3/images/1.webp','d037bdf6-50a0-4663-a073-98534b070412',NULL,0),('61bd425d-9657-44ad-a671-ac38d4f91717','http://localhost:8080/bej3/images/dsc05996.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',6),('69a70530-4d57-4c9e-83c7-5c98e09f1227','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-4-design-detail-vn-vi.webp',NULL,'f9b528cb-f6c7-4eb6-a457-3590fa3efb94',3),('69adb161-7833-4823-a87b-f4b99d673450','http://localhost:8080/bej3/images/redmagic-10-pro-xam-4.webp',NULL,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3',3),('72879626-60e4-4bd4-9573-679e36eec98c','http://localhost:8080/bej3/images/redmagic-10-pro-bac-4.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',3),('810865ca-9a09-4fb9-9de1-d18527e332b5','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-7-colors-vn-vi.webp','feac3c08-0803-4393-9a87-64e5d2d7811f',NULL,2),('a09f0a56-eb94-45e8-a0e0-3a558636679b','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-3-design-vn-vi.webp',NULL,'f9b528cb-f6c7-4eb6-a457-3590fa3efb94',2),('a10cd238-985a-4d46-a2ef-00a9bacdaea6','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-2-mist-blue-color-vn-vi.webp',NULL,'f9b528cb-f6c7-4eb6-a457-3590fa3efb94',1),('a3b5d48a-2e8e-4380-9e56-97a6cc864801','http://localhost:8080/bej3/images/iphone-17-lavender-pdp-image-position-1-lavender-color-vn-vi.webp',NULL,'b3ff6a44-daa6-499c-98dc-f3da2fd940b8',0),('a86ba093-37cd-4def-8270-468ea929c8e3','http://localhost:8080/bej3/images/redmagic-10-pro-bac-2.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',1),('bb3e255b-37b8-48da-b783-63c96b0c9074','http://localhost:8080/bej3/images/redmagic-10-pro-bac-5.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',4),('bb682157-96cd-4b23-8dec-405766ad0b17','http://localhost:8080/bej3/images/redmagic-10-pro-xam-1.webp',NULL,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3',0),('bedf78a3-c072-47bd-9a24-48c36ea13fda','http://localhost:8080/bej3/images/dsc05820.webp',NULL,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3',4),('ce4b24f3-554f-4de8-b6a0-0d5f89230448','http://localhost:8080/bej3/images/dsc05949.webp',NULL,'5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3',5),('d3b8f1f0-42fa-4c97-a7b4-26ad4ab10787','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-6-features-and-specs-vn-vi.webp','feac3c08-0803-4393-9a87-64e5d2d7811f',NULL,1),('dba884ab-ff8e-48ab-a874-3862e2db108d','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-5-feature-story-vn-vi.webp','feac3c08-0803-4393-9a87-64e5d2d7811f',NULL,0),('e7505f7d-de6e-45ad-8122-95ee8aa28d64','http://localhost:8080/bej3/images/iphone-17-mist-blue-pdp-image-position-1-mist-blue-color-vn-vi.webp',NULL,'f9b528cb-f6c7-4eb6-a457-3590fa3efb94',0),('e997d3d8-bf0d-448b-97bf-db8a4ee3a140','http://localhost:8080/bej3/images/redmagic-10-pro-bac-1.webp',NULL,'b0a23544-1067-444b-b7f3-f0eaad9c1b55',0),('i1a2b3c4-d5e6-7890-abcd-ef1234567890','http://localhost:8080/bej3/images/samsung-s24-ultra-1.webp',NULL,'v1a2b3c4-d5e6-7890-abcd-ef1234567890',0),('i2b3c4d5-e6f7-8901-bcde-f12345678901','http://localhost:8080/bej3/images/samsung-s24-ultra-2.webp',NULL,'v1a2b3c4-d5e6-7890-abcd-ef1234567890',1),('i3c4d5e6-f7a8-9012-cdef-123456789012','http://localhost:8080/bej3/images/samsung-s24-ultra-3.webp',NULL,'v2b3c4d5-e6f7-8901-bcde-f12345678901',0),('i4d5e6f7-a8b9-0123-def0-234567890123','http://localhost:8080/bej3/images/macbook-pro-16-1.webp',NULL,'v3c4d5e6-f7a8-9012-cdef-123456789012',0),('i5e6f7a8-b9c0-1234-ef01-345678901234','http://localhost:8080/bej3/images/macbook-pro-16-2.webp',NULL,'v3c4d5e6-f7a8-9012-cdef-123456789012',1),('i6f7a8b9-c0d1-2345-f012-456789012345','http://localhost:8080/bej3/images/macbook-pro-16-3.webp',NULL,'v4d5e6f7-a8b9-0123-def0-234567890123',0),('i7a8b9c0-d1e2-3456-0123-567890123456','http://localhost:8080/bej3/images/ipad-pro-12-1.webp',NULL,'v5e6f7a8-b9c0-1234-ef01-345678901234',0),('i8b9c0d1-e2f3-4567-1234-678901234567','http://localhost:8080/bej3/images/ipad-pro-12-2.webp',NULL,'v5e6f7a8-b9c0-1234-ef01-345678901234',1),('i9c0d1e2-f3a4-5678-2345-789012345678','http://localhost:8080/bej3/images/apple-watch-ultra-1.webp',NULL,'v7a8b9c0-d1e2-3456-0123-567890123456',0),('i0d1e2f3-a4b5-6789-3456-890123456789','http://localhost:8080/bej3/images/airpods-pro-1.webp',NULL,'v8b9c0d1-e2f3-4567-1234-678901234567',0),('i1e2f3a4-b5c6-7890-4567-901234567890','http://localhost:8080/bej3/images/airpods-pro-2.webp',NULL,'v9c0d1e2-f3a4-5678-2345-789012345678',0),('i2f3a4b5-c6d7-8901-5678-012345678901','http://localhost:8080/bej3/images/xiaomi-14-pro-1.webp',NULL,'v0d1e2f3-a4b5-6789-3456-890123456789',0),('i3a4b5c6-d7e8-9012-6789-123456789012','http://localhost:8080/bej3/images/xiaomi-14-pro-2.webp',NULL,'v0d1e2f3-a4b5-6789-3456-890123456789',1),('i4b5c6d7-e8f9-0123-7890-234567890123','http://localhost:8080/bej3/images/xiaomi-14-pro-3.webp',NULL,'v1e2f3a4-b5c6-7890-4567-901234567890',0);
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `product_variant`
--

LOCK TABLES `product_variant` WRITE;
/*!40000 ALTER TABLE `product_variant` DISABLE KEYS */;
INSERT IGNORE INTO `product_variant` VALUES ('5f3c16e2-7a3a-4dd2-bffd-7fe00b503fc3','Xám Chạng Vạng',NULL,'d037bdf6-50a0-4663-a073-98534b070412',0),('b0a23544-1067-444b-b7f3-f0eaad9c1b55','Bạc Ánh Trăng',NULL,'d037bdf6-50a0-4663-a073-98534b070412',1),('b3ff6a44-daa6-499c-98dc-f3da2fd940b8','Tím Oải Hương',NULL,'feac3c08-0803-4393-9a87-64e5d2d7811f',0),('f9b528cb-f6c7-4eb6-a457-3590fa3efb94','Xanh Mint',NULL,'feac3c08-0803-4393-9a87-64e5d2d7811f',1),('v1a2b3c4-d5e6-7890-abcd-ef1234567890','Đen Titanium',NULL,'f1a2b3c4-d5e6-7890-abcd-ef1234567890',0),('v2b3c4d5-e6f7-8901-bcde-f12345678901','Tím Titanium',NULL,'f1a2b3c4-d5e6-7890-abcd-ef1234567890',1),('v3c4d5e6-f7a8-9012-cdef-123456789012','Xám Space',NULL,'a2b3c4d5-e6f7-8901-bcde-f12345678901',0),('v4d5e6f7-a8b9-0123-def0-234567890123','Bạc',NULL,'a2b3c4d5-e6f7-8901-bcde-f12345678901',1),('v5e6f7a8-b9c0-1234-ef01-345678901234','Xám Space',NULL,'b3c4d5e6-f7a8-9012-cdef-123456789012',0),('v6f7a8b9-c0d1-2345-f012-456789012345','Bạc',NULL,'b3c4d5e6-f7a8-9012-cdef-123456789012',1),('v7a8b9c0-d1e2-3456-0123-567890123456','Titanium',NULL,'c4d5e6f7-a8b9-0123-def0-234567890123',0),('v8b9c0d1-e2f3-4567-1234-678901234567','Trắng',NULL,'d5e6f7a8-b9c0-1234-ef01-345678901234',0),('v9c0d1e2-f3a4-5678-2345-789012345678','Đen',NULL,'d5e6f7a8-b9c0-1234-ef01-345678901234',1),('v0d1e2f3-a4b5-6789-3456-890123456789','Xanh',NULL,'e6f7a8b9-c0d1-2345-f012-456789012345',0),('v1e2f3a4-b5c6-7890-4567-901234567890','Đen',NULL,'e6f7a8b9-c0d1-2345-f012-456789012345',1);
/*!40000 ALTER TABLE `product_variant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT IGNORE INTO `role` VALUES ('ADMIN','system admin'),('EMPLOYEE_MANAGER','hr'),('SHOP_MANAGER','hr'),('USER','user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT IGNORE INTO `role_permissions` VALUES ('ADMIN','MANAGE_PRODUCT'),('SHOP_MANAGER','MANAGE_PRODUCT'),('ADMIN','MANAGE_ROLE'),('ADMIN','MANAGE_STAFF'),('EMPLOYEE_MANAGER','MANAGE_STAFF');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `shift`
--

LOCK TABLES `shift` WRITE;
/*!40000 ALTER TABLE `shift` DISABLE KEYS */;
INSERT IGNORE INTO `shift` VALUES (1,'22:00:00.000000','ca tối','16:00:00.000000'),(2,'13:00:00.000000','ca chiều','17:00:00.000000'),(3,'12:00:00.000000','ca sáng','08:00:00.000000');
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `supply`
--

LOCK TABLES `supply` WRITE;
/*!40000 ALTER TABLE `supply` DISABLE KEYS */;
INSERT IGNORE INTO `supply` (`id`, `type`, `attribute_id`, `quantity`, `price`) VALUES ('s1a2b3c4-d5e6-7890-abcd-ef1234567890', 0, 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 50, 25000000), ('s2b3c4d5-e6f7-8901-bcde-f12345678901', 0, 'a4b5c6d7-e8f9-0123-def0-234567890123', 20, 65000000), ('s3c4d5e6-f7a8-9012-cdef-123456789012', 1, 'e90790cb-53e9-4698-9c48-ef1b68595c1e', 5, 17990000), ('s4d5e6f7-a8b9-0123-def0-234567890123', 0, 'a7b8c9d0-e1f2-3456-0123-567890123456', 30, 23000000), ('s5e6f7a8-b9c0-1234-ef01-345678901234', 0, 'a9b0c1d2-e3f4-5678-2345-789012345678', 15, 18000000);
/*!40000 ALTER TABLE `supply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT IGNORE INTO `task` (`id`, `title`, `description`, `status`, `schedule_id`) VALUES ('t1a2b3c4-d5e6-7890-abcd-ef1234567890', 'Kiểm tra kho hàng', 'Kiểm tra tồn kho sản phẩm điện thoại', 0, 'w1a2b3c4-d5e6-7890-abcd-ef1234567890'), ('t2b3c4d5-e6f7-8901-bcde-f12345678901', 'Đóng gói đơn hàng', 'Đóng gói các đơn hàng đã xác nhận', 1, 'w2b3c4d5-e6f7-8901-bcde-f12345678901'), ('t3c4d5e6-f7a8-9012-cdef-123456789012', 'Tư vấn khách hàng', 'Tư vấn sản phẩm mới cho khách hàng', 0, 'w3c4d5e6-f7a8-9012-cdef-123456789012'), ('t4d5e6f7-a8b9-0123-def0-234567890123', 'Cập nhật giá sản phẩm', 'Cập nhật giá các sản phẩm khuyến mãi', 1, 'w4d5e6f7-a8b9-0123-def0-234567890123'), ('t5e6f7a8-b9c0-1234-ef01-345678901234', 'Kiểm kê cuối ngày', 'Kiểm kê tồn kho và doanh thu cuối ngày', 0, 'w5e6f7a8-b9c0-1234-ef01-345678901234');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT IGNORE INTO `user` VALUES ('24daab77-a1cb-4e14-b002-cb0754acbc52','admin',NULL,'admin','admin','$2a$10$RTI7cImKcc2PPOASLnjt7ejD7Fe0wx0o9x8/skFvtn6yMhIM9A4cS','admin'),('6895cccc-4891-4c15-981a-e59a2d16a939',NULL,NULL,'culacgi0ntan27@gmail.com',NULL,'$2a$10$K6kdNc7TE24egJ9.pnnSqO2vBddj5BgUDNkp./fu.r4H1xoXQGYoK','044'),('7cacd02a-7e5b-4321-ba46-b3500ccf8589',NULL,NULL,'abcdzyx027@gmail.com','Đặng Tiến Dũng','$2a$10$pGAEaNAdoORJD1c.kPxnRegR2ce6CB.rRXGlNBYO1uxJuZYc7gcRC','0986068436'),('8460cfc0-ca09-4ce2-98bc-0fe5f6ba015b',NULL,NULL,'adu113@gmail.com','adu1111','$2a$10$wGmzfiyfIjKeQHhmNPseguTnpWt59VyH4nlEr6GJt/35zUPBRNPRe','0333333333'),('8d04670e-170d-40fe-9477-545169f62832',NULL,NULL,'adu112@gmail.com',NULL,'$2a$10$ADiI.Gd7rgcTno9fUNzGp.AuSZm74atoVQ3ikg2r0R.xC60AnOMs2','0222222222'),('b78ae41e-2ec3-4065-a876-06a16a039f15','Hn','2003-07-21','adu111','Đặng Tiến Dũng','$2a$10$5qXSUvNSFkqO50707YPGdul.JlbAzXnwTgHfexPagSx5UHAPxEvhC','0111111111'),('a1b2c3d4-e5f6-7890-abcd-ef1234567890','Hà Nội','1995-05-15','nguyenvana@gmail.com','Nguyễn Văn A','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0912345678'),('b2c3d4e5-f6a7-8901-bcde-f12345678901','TP.HCM','1998-08-20','tranthib@gmail.com','Trần Thị B','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0923456789'),('c3d4e5f6-a7b8-9012-cdef-123456789012','Đà Nẵng','1990-12-10','levanc@gmail.com','Lê Văn C','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0934567890'),('d4e5f6a7-b8c9-0123-def0-234567890123','Hải Phòng','1992-03-25','phamthid@gmail.com','Phạm Thị D','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0945678901'),('e5f6a7b8-c9d0-1234-ef01-345678901234','Cần Thơ','1988-11-30','hoangvane@gmail.com','Hoàng Văn E','$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy','0956789012');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT IGNORE INTO `user_roles` VALUES ('24daab77-a1cb-4e14-b002-cb0754acbc52','ADMIN'),('b78ae41e-2ec3-4065-a876-06a16a039f15','SHOP_MANAGER'),('6895cccc-4891-4c15-981a-e59a2d16a939','USER'),('7cacd02a-7e5b-4321-ba46-b3500ccf8589','USER'),('8460cfc0-ca09-4ce2-98bc-0fe5f6ba015b','USER'),('8d04670e-170d-40fe-9477-545169f62832','USER'),('a1b2c3d4-e5f6-7890-abcd-ef1234567890','USER'),('b2c3d4e5-f6a7-8901-bcde-f12345678901','USER'),('c3d4e5f6-a7b8-9012-cdef-123456789012','EMPLOYEE_MANAGER'),('d4e5f6a7-b8c9-0123-def0-234567890123','USER'),('e5f6a7b8-c9d0-1234-ef01-345678901234','SHOP_MANAGER');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_schedule`
--

LOCK TABLES `work_schedule` WRITE;
/*!40000 ALTER TABLE `work_schedule` DISABLE KEYS */;
INSERT IGNORE INTO `work_schedule` (`id`, `work_date`, `shift_id`) VALUES ('21f9f857-b1e1-4f01-b17a-2461e119ddb4', '2025-11-12', 1), ('80a11c40-d34c-4b11-aee1-c008580f06a6', '2025-11-08', 1), ('8233fff7-19ee-4495-993c-98c87a52d5f9', '2025-11-13', 1), ('dab0a215-7455-4b8f-b777-8992202799a9', '2025-11-19', 1), ('w1a2b3c4-d5e6-7890-abcd-ef1234567890', '2025-11-20', 2), ('w2b3c4d5-e6f7-8901-bcde-f12345678901', '2025-11-21', 3), ('w3c4d5e6-f7a8-9012-cdef-123456789012', '2025-11-22', 1), ('w4d5e6f7-a8b9-0123-def0-234567890123', '2025-11-23', 2), ('w5e6f7a8-b9c0-1234-ef01-345678901234', '2025-11-24', 3);
/*!40000 ALTER TABLE `work_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `work_schedule_users`
--

LOCK TABLES `work_schedule_users` WRITE;
/*!40000 ALTER TABLE `work_schedule_users` DISABLE KEYS */;
INSERT IGNORE INTO `work_schedule_users` VALUES ('21f9f857-b1e1-4f01-b17a-2461e119ddb4','24daab77-a1cb-4e14-b002-cb0754acbc52'),('80a11c40-d34c-4b11-aee1-c008580f06a6','24daab77-a1cb-4e14-b002-cb0754acbc52'),('8233fff7-19ee-4495-993c-98c87a52d5f9','24daab77-a1cb-4e14-b002-cb0754acbc52'),('dab0a215-7455-4b8f-b777-8992202799a9','24daab77-a1cb-4e14-b002-cb0754acbc52'),('21f9f857-b1e1-4f01-b17a-2461e119ddb4','b78ae41e-2ec3-4065-a876-06a16a039f15'),('80a11c40-d34c-4b11-aee1-c008580f06a6','b78ae41e-2ec3-4065-a876-06a16a039f15'),('8233fff7-19ee-4495-993c-98c87a52d5f9','b78ae41e-2ec3-4065-a876-06a16a039f15'),('dab0a215-7455-4b8f-b777-8992202799a9','b78ae41e-2ec3-4065-a876-06a16a039f15'),('w1a2b3c4-d5e6-7890-abcd-ef1234567890','c3d4e5f6-a7b8-9012-cdef-123456789012'),('w1a2b3c4-d5e6-7890-abcd-ef1234567890','e5f6a7b8-c9d0-1234-ef01-345678901234'),('w2b3c4d5-e6f7-8901-bcde-f12345678901','24daab77-a1cb-4e14-b002-cb0754acbc52'),('w3c4d5e6-f7a8-9012-cdef-123456789012','b78ae41e-2ec3-4065-a876-06a16a039f15'),('w4d5e6f7-a8b9-0123-def0-234567890123','c3d4e5f6-a7b8-9012-cdef-123456789012'),('w5e6f7a8-b9c0-1234-ef01-345678901234','e5f6a7b8-c9d0-1234-ef01-345678901234');
/*!40000 ALTER TABLE `work_schedule_users` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT IGNORE INTO `notification` (`id`, `recipient_user_id`, `type`, `title`, `body`, `is_read`, `resource_id`, `created_at`) VALUES
('a22b792b-2c28-494e-a9f2-6f0a9650a8f9', '6895cccc-4891-4c15-981a-e59a2d16a939', 'ORDER_STATUS_UPDATE', 'Đơn hàng đã giao', 'Đơn hàng #b63534 của bạn đã được giao thành công.', b'1', 'b63534c6-c51b-4164-9e2c-591efb2f7ef6', '2025-11-12 15:30:00.000000'),
('b33c803c-3d39-4a5f-b0a3-7a1b0761b9a0', '7cacd02a-7e5b-4321-ba46-b3500ccf8589', 'NEW_PROMOTION', 'Khuyến mãi cuối tuần!', 'Giảm giá 20% cho tất cả các dịch vụ sửa chữa. Đừng bỏ lỡ!', b'0', NULL, '2025-11-13 11:00:00.000000'),
('c44d914d-4e4a-4b6a-c1b4-8b2c1872c0b1', 'b78ae41e-2ec3-4065-a876-06a16a039f15', 'REPAIR_REQUEST_RECEIVED', 'Yêu cầu sửa chữa mới', 'Khách hàng (ID: ...a939) vừa tạo một yêu cầu sửa chữa mới cho iPhone 17.', b'0', 'R-12345', '2025-11-13 12:00:00.000000'),
('e11a681a-1b17-483d-98e1-5e9f8549f7e8', '6895cccc-4891-4c15-981a-e59a2d16a939', 'ORDER_STATUS_UPDATE', 'Đơn hàng đã được xác nhận', 'Đơn hàng #c1828a của bạn đã được xác nhận và đang được chuẩn bị.', b'0', 'c1828a7b-92fb-4e18-84bc-3ef957cf937f', '2025-11-13 10:00:00.000000'),
('n1a2b3c4-d5e6-7890-abcd-ef1234567890', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'ORDER_PLACED', 'Đơn hàng mới đã được tạo', 'Đơn hàng của bạn đã được tạo thành công. Mã đơn hàng: #o1a2b3c4', b'0', 'o1a2b3c4-d5e6-7890-abcd-ef1234567890', '2025-11-15 10:15:00.000000'),
('n2b3c4d5-e6f7-8901-bcde-f12345678901', 'b2c3d4e5-f6a7-8901-bcde-f12345678901', 'ORDER_STATUS_UPDATE', 'Đơn hàng đang được giao', 'Đơn hàng #o2b3c4d5 của bạn đang được vận chuyển.', b'0', 'o2b3c4d5-e6f7-8901-bcde-f12345678901', '2025-11-16 14:20:00.000000'),
('n3c4d5e6-f7a8-9012-cdef-123456789012', 'c3d4e5f6-a7b8-9012-cdef-123456789012', 'GENERAL_ANNOUNCEMENT', 'Thông báo hệ thống', 'Hệ thống sẽ bảo trì vào ngày 25/11/2025 từ 2h-4h sáng.', b'0', NULL, '2025-11-17 09:00:00.000000'),
('n4d5e6f7-a8b9-0123-def0-234567890123', 'd4e5f6a7-b8c9-0123-def0-234567890123', 'NEW_PROMOTION', 'Khuyến mãi Black Friday', 'Giảm giá lên đến 50% cho tất cả sản phẩm điện tử. Áp dụng từ 24-26/11/2025.', b'0', NULL, '2025-11-18 08:30:00.000000'),
('n5e6f7a8-b9c0-1234-ef01-345678901234', 'e5f6a7b8-c9d0-1234-ef01-345678901234', 'ORDER_STATUS_UPDATE', 'Đơn hàng đã được xác nhận', 'Đơn hàng #o5e6f7a8 của bạn đã được xác nhận và đang được chuẩn bị.', b'1', 'o5e6f7a8-b9c0-1234-ef01-345678901234', '2025-11-19 11:45:00.000000'),
('n6f7a8b9-c0d1-2345-f012-456789012345', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'REPAIR_STATUS_UPDATE', 'Trạng thái sửa chữa đã cập nhật', 'Yêu cầu sửa chữa của bạn đang được xử lý. Dự kiến hoàn thành trong 3-5 ngày.', b'0', 'R-67890', '2025-11-20 13:00:00.000000');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;