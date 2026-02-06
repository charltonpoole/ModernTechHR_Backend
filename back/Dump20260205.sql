 -- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: moderntech_hr
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `date` date NOT NULL,
  `status` enum('Present','Absent') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,1,'2025-07-25','Present'),(2,1,'2025-07-26','Absent'),(3,1,'2025-07-27','Present'),(4,1,'2025-07-28','Present'),(5,1,'2025-07-29','Present'),(6,2,'2025-07-25','Present'),(7,2,'2025-07-26','Present'),(8,2,'2025-07-27','Absent'),(9,2,'2025-07-28','Present'),(10,2,'2025-07-29','Present'),(11,3,'2025-07-25','Present'),(12,3,'2025-07-26','Present'),(13,3,'2025-07-27','Present'),(14,3,'2025-07-28','Absent'),(15,3,'2025-07-29','Present'),(16,4,'2025-07-25','Absent'),(17,4,'2025-07-26','Present'),(18,4,'2025-07-27','Present'),(19,4,'2025-07-28','Present'),(20,4,'2025-07-29','Present'),(21,1,'2025-07-25','Present'),(22,1,'2025-07-26','Absent'),(23,1,'2025-07-27','Present'),(24,1,'2025-07-28','Present'),(25,1,'2025-07-29','Present'),(26,2,'2025-07-25','Present'),(27,2,'2025-07-26','Present'),(28,2,'2025-07-27','Absent'),(29,2,'2025-07-28','Present'),(30,2,'2025-07-29','Present'),(31,3,'2025-07-25','Present'),(32,3,'2025-07-26','Present'),(33,3,'2025-07-27','Present'),(34,3,'2025-07-28','Absent'),(35,3,'2025-07-29','Present'),(36,4,'2025-07-25','Absent'),(37,4,'2025-07-26','Present'),(38,4,'2025-07-27','Present'),(39,4,'2025-07-28','Present'),(40,4,'2025-07-29','Present'),(41,5,'2025-07-25','Present'),(42,5,'2025-07-26','Present'),(43,5,'2025-07-27','Absent'),(44,5,'2025-07-28','Present'),(45,5,'2025-07-29','Present'),(46,6,'2025-07-25','Present'),(47,6,'2025-07-26','Present'),(48,6,'2025-07-27','Absent'),(49,6,'2025-07-28','Present'),(50,6,'2025-07-29','Present'),(51,7,'2025-07-25','Present'),(52,7,'2025-07-26','Present'),(53,7,'2025-07-27','Present'),(54,7,'2025-07-28','Absent'),(55,7,'2025-07-29','Present'),(56,8,'2025-07-25','Present'),(57,8,'2025-07-26','Absent'),(58,8,'2025-07-27','Present'),(59,8,'2025-07-28','Present'),(60,8,'2025-07-29','Present'),(61,9,'2025-07-25','Present'),(62,9,'2025-07-26','Present'),(63,9,'2025-07-27','Present'),(64,9,'2025-07-28','Absent'),(65,9,'2025-07-29','Present'),(66,10,'2025-07-25','Present'),(67,10,'2025-07-26','Present'),(68,10,'2025-07-27','Absent'),(69,10,'2025-07-28','Present'),(70,10,'2025-07-29','Present');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL,
  `department` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `employment_history` varchar(255) DEFAULT NULL,
  `contact` varchar(150) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Sibongile Nkosi','Software Engineer','Development',70000.00,'Joined in 2015, promoted to Senior in 2018','sibongile.nkosi@moderntech.com'),(2,'Lungile Moyo','HR Manager','HR',80000.00,'Joined in 2013, promoted to Manager in 2017','lungile.moyo@moderntech.com'),(3,'Thabo Molefe','Quality Analyst','QA',55000.00,'Joined in 2018','thabo.molefe@moderntech.com'),(4,'Keshav Naidoo','Sales Representative','Sales',60000.00,'Joined in 2020','keshav.naidoo@moderntech.com'),(5,'Zanele Khumalo','Marketing Specialist','Marketing',58000.00,'Joined in 2019','zanele.khumalo@moderntech.com'),(6,'Sipho Zulu','UI/UX Designer','Design',65000.00,'Joined in 2016','sipho.zulu@moderntech.com'),(7,'Naledi Moeketsi','DevOps Engineer','IT',72000.00,'Joined in 2017','naledi.moeketsi@moderntech.com'),(8,'Farai Gumbo','Content Strategist','Marketing',56000.00,'Joined in 2021','farai.gumbo@moderntech.com'),(9,'Karabo Dlamini','Accountant','Finance',62000.00,'Joined in 2018','karabo.dlamini@moderntech.com'),(10,'Fatima Patel','Customer Support Lead','Support',58000.00,'Joined in 2016','fatima.patel@moderntech.com');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_requests`
--

DROP TABLE IF EXISTS `leave_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `type` varchar(50) NOT NULL,
  `status` enum('Pending','Approved','Denied') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `leave_requests_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_requests`
--

LOCK TABLES `leave_requests` WRITE;
/*!40000 ALTER TABLE `leave_requests` DISABLE KEYS */;
INSERT INTO `leave_requests` VALUES (1,1,'2025-07-22','2025-07-22','Sick Leave','Approved','2026-02-03 09:10:58'),(2,1,'2024-12-01','2024-12-01','Personal','Pending','2026-02-03 09:10:58'),(3,2,'2025-07-15','2025-07-15','Family Responsibility','Denied','2026-02-03 09:10:58'),(4,2,'2024-12-02','2024-12-02','Vacation','Approved','2026-02-03 09:10:58'),(5,3,'2025-07-10','2025-07-10','Medical Appointment','Approved','2026-02-03 09:10:58'),(6,3,'2024-12-05','2024-12-05','Personal','Pending','2026-02-03 09:10:58'),(7,4,'2025-07-20','2025-07-20','Bereavement','Approved','2026-02-03 09:10:58'),(8,5,'2024-12-01','2024-12-01','Childcare','Pending','2026-02-03 09:10:58'),(9,6,'2025-07-18','2025-07-18','Sick Leave','Approved','2026-02-03 09:10:58'),(10,7,'2025-07-22','2025-07-22','Vacation','Pending','2026-02-03 09:10:58'),(11,8,'2024-12-02','2024-12-02','Medical Appointment','Approved','2026-02-03 09:10:58'),(12,9,'2025-07-19','2025-07-19','Childcare','Denied','2026-02-03 09:10:58'),(13,10,'2024-12-03','2024-12-03','Vacation','Pending','2026-02-03 09:10:58'),(14,2,'2025-12-20','2025-12-24','Emergency','Pending','2026-02-03 09:10:58'),(15,3,'2025-12-01','2025-12-02','Sick','Pending','2026-02-03 09:10:58');
/*!40000 ALTER TABLE `leave_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payroll_calculations`
--

DROP TABLE IF EXISTS `payroll_calculations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payroll_calculations` (
  `employee_id` int NOT NULL,
  `hours_worked` int DEFAULT NULL,
  `leave_deductions` int DEFAULT NULL,
  `final_salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `payroll_calculations_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payroll_calculations`
--

LOCK TABLES `payroll_calculations` WRITE;
/*!40000 ALTER TABLE `payroll_calculations` DISABLE KEYS */;
INSERT INTO `payroll_calculations` VALUES (1,160,8,69500.00),(2,150,10,79000.00),(3,170,4,54800.00),(4,165,6,59700.00),(5,158,5,57850.00),(6,168,2,64800.00),(7,175,3,71800.00),(8,160,0,56000.00),(9,155,5,61500.00),(10,162,4,57750.00);
/*!40000 ALTER TABLE `payroll_calculations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payroll_history`
--

DROP TABLE IF EXISTS `payroll_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payroll_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `month` char(7) DEFAULT NULL,
  `gross` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `net` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `payroll_history_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payroll_history`
--

LOCK TABLES `payroll_history` WRITE;
/*!40000 ALTER TABLE `payroll_history` DISABLE KEYS */;
INSERT INTO `payroll_history` VALUES (1,2,'2025-11',9000.00,1350.00,7650.00),(2,3,'2025-11',6200.00,930.00,5270.00),(3,9,'2025-11',5800.00,870.00,4930.00),(4,7,'2025-11',6000.00,900.00,5100.00);
/*!40000 ALTER TABLE `payroll_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_accounts` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Manager','Employee') DEFAULT 'Employee',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `user_accounts_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_accounts`
--

LOCK TABLES `user_accounts` WRITE;
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;
INSERT INTO `user_accounts` VALUES (1,1,'sibongile.nkosi','password123','Employee','2026-02-03 09:03:36'),(2,2,'lungile.moyo','admin123','Manager','2026-02-03 09:03:36'),(3,3,'thabo.molefe','password123','Employee','2026-02-03 09:03:36'),(4,4,'keshav.naidoo','password123','Employee','2026-02-03 09:03:36'),(5,5,'zanele.khumalo','password123','Employee','2026-02-03 09:03:36'),(6,6,'sipho.zulu','password123','Employee','2026-02-03 09:03:36'),(7,7,'naledi.moeketsi','password123','Employee','2026-02-03 09:03:36'),(8,8,'farai.gumbo','password123','Employee','2026-02-03 09:03:36'),(9,9,'karabo.dlamini','password123','Employee','2026-02-03 09:03:36'),(10,10,'fatima.patel','password123','Employee','2026-02-03 09:03:36');
/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-05  9:13:54
