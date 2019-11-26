-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: budget
-- ------------------------------------------------------
-- Server version	5.7.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Category ID',
  `category_name` varchar(127) NOT NULL COMMENT 'Category',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Home'),(2,'Education'),(3,'Recreation'),(4,'Appliances'),(5,'Food'),(6,'Health');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchased_item`
--

DROP TABLE IF EXISTS `purchased_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchased_item` (
  `purchased_item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased Item ID',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User ID',
  `category_id` int(10) unsigned NOT NULL COMMENT 'Category ID',
  `purchased_item` varchar(127) NOT NULL COMMENT 'Purchased Item',
  `price` decimal(20,6) NOT NULL COMMENT 'Purchased Item Price',
  `purchased_at` datetime NOT NULL COMMENT 'Purchased As',
  PRIMARY KEY (`purchased_item_id`),
  KEY `PURCHASED_ITEM_USER_ID_USER_USER_ID` (`user_id`),
  KEY `PURCHASED_ITEM_CATEGORY_ID_CATEGORY_CATEGORY_ID` (`category_id`),
  CONSTRAINT `PURCHASED_ITEM_CATEGORY_ID_CATEGORY_CATEGORY_ID` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `PURCHASED_ITEM_USER_ID_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Purchased Items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchased_item`
--

LOCK TABLES `purchased_item` WRITE;
/*!40000 ALTER TABLE `purchased_item` DISABLE KEYS */;
INSERT INTO `purchased_item` VALUES (1,1,4,'Microwave oven',1999.000000,'2019-11-10 00:00:00'),(2,1,5,'Milk',31.350000,'2019-11-12 00:00:00'),(3,1,5,'Coffee',233.000000,'2019-11-12 00:00:00'),(4,1,5,'Fish',142.350000,'2019-11-13 00:00:00'),(5,1,2,'Docker course',1999.000000,'2019-11-14 00:00:00'),(6,2,3,'Yosemite national park',7500.000000,'2019-10-29 00:00:00'),(7,2,3,'Weekend in Miami',8000.000000,'2019-11-12 00:00:00'),(8,2,3,'New Year celebration',5400.000000,'2020-01-01 00:00:00'),(9,3,1,'Garland',350.000000,'2019-11-13 00:00:00'),(10,3,1,'Candles',300.000000,'2019-11-14 00:00:00'),(11,4,3,'New bike for me',1999.000000,'2019-11-10 00:00:00'),(12,4,3,'New bike for Emily',31.350000,'2019-11-12 00:00:00'),(13,4,3,'Crisps',333.000000,'2019-11-12 00:00:00'),(14,4,3,'Beer',230.000000,'2019-11-12 00:00:00'),(15,6,2,'Virus - Petya',230.000000,'2018-11-12 00:00:00'),(16,6,2,'Virus - Vasya',230.000000,'2018-11-12 00:00:00');
/*!40000 ALTER TABLE `purchased_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchased_item_tag`
--

DROP TABLE IF EXISTS `purchased_item_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchased_item_tag` (
  `purchased_item_id` bigint(20) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  KEY `PURCHASED_ITEM_TAG_PIID_PURCHASED_ITEM_PURCHASED_ITEM_ID` (`purchased_item_id`),
  KEY `PURCHASED_ITEM_TAG_TAG_ID_TAG_TAG_ID` (`tag_id`),
  CONSTRAINT `PURCHASED_ITEM_TAG_PIID_PURCHASED_ITEM_PURCHASED_ITEM_ID` FOREIGN KEY (`purchased_item_id`) REFERENCES `purchased_item` (`purchased_item_id`) ON DELETE CASCADE,
  CONSTRAINT `PURCHASED_ITEM_TAG_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Purchased Item Tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchased_item_tag`
--

LOCK TABLES `purchased_item_tag` WRITE;
/*!40000 ALTER TABLE `purchased_item_tag` DISABLE KEYS */;
INSERT INTO `purchased_item_tag` VALUES (1,1),(2,2),(3,2),(4,2),(5,3),(6,5),(7,5),(8,5),(9,6),(10,6),(11,7),(12,7),(13,8),(14,8),(13,9),(14,9),(15,10),(16,10);
/*!40000 ALTER TABLE `purchased_item_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag ID',
  `tag` varchar(127) NOT NULL COMMENT 'Tags',
  `user_id` int(10) unsigned NOT NULL COMMENT 'User ID',
  PRIMARY KEY (`tag_id`),
  KEY `TAG_USER_ID_USER_USER_ID` (`user_id`),
  CONSTRAINT `TAG_USER_ID_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'Home',1),(2,'Family',1),(3,'Programming',1),(4,'Ballroom',1),(5,'Trips',2),(6,'Home',2),(7,'Bikes',4),(8,'Party',4),(9,'Rest',4),(10,'Hacking equipment',4),(11,'Hacking equipment',4),(12,'Hacking equipment',4);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `user_group_id` int(10) unsigned DEFAULT NULL COMMENT 'User Group ID',
  `user_name` varchar(127) NOT NULL COMMENT 'User Name',
  `email` varchar(127) NOT NULL COMMENT 'Email',
  `login` varchar(127) NOT NULL COMMENT 'Login',
  `password` char(40) NOT NULL COMMENT 'Password',
  `dob` date DEFAULT NULL COMMENT 'Date of Birth',
  PRIMARY KEY (`user_id`),
  KEY `USER_USER_ID_USER_GROUP_USER_GROUP_ID` (`user_group_id`),
  CONSTRAINT `USER_USER_ID_USER_GROUP_USER_GROUP_ID` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`user_group_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,NULL,'Maksym Zaporozhets','maksimz@default-value.com','maksymz','dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs','1988-10-22'),(2,2,'John Doe','john-doe@example.com','john_doe','dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs',NULL),(3,2,'Jane Doe','jane-doe@example.com','jane_doe','dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs',NULL),(4,3,'James Smith','james_smith@example.com','james_smith','dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs',NULL),(5,3,'Emily Smith','emily_smith@example.com','emily_smith','dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs',NULL),(6,NULL,'Anonymous','anonymous@example.com','anonymous','dsgfv;dfsxjvxm,gkh;hkft;ftmjhtrjihjrhfs',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `user_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User Group ID',
  `user_group_name` varchar(127) NOT NULL COMMENT 'User Group Name',
  PRIMARY KEY (`user_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='User Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,'My family'),(2,'John Doe\'s Family'),(3,'Yet another family');
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-26 18:35:05
