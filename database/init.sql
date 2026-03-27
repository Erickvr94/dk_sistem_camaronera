-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: camaronera01
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `casos`
--

DROP TABLE IF EXISTS `casos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `USUARIO_ID` int NOT NULL COMMENT 'Quién reporta',
  `EQUIPO_ID` int NOT NULL COMMENT 'Qué equipo se dañó',
  `CODIGO_CASO` varchar(300) DEFAULT NULL,
  `DIA` int DEFAULT NULL,
  `MES` int DEFAULT NULL,
  `ANIO` int DEFAULT NULL,
  `HORA` time DEFAULT NULL,
  `TIPO_SOPORTE` varchar(255) DEFAULT NULL COMMENT 'Correctivo | Preventivo | Predictivo',
  `MOTIVO` text,
  `ESTADOCASO` varchar(100) DEFAULT NULL COMMENT 'Abierto | En proceso | Cerrado',
  `FECHA_REGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_CASOS_USUARIO` (`USUARIO_ID`),
  KEY `idx_CASOS_EQUIPO` (`EQUIPO_ID`),
  CONSTRAINT `fk_CASOS_EQUIPO` FOREIGN KEY (`EQUIPO_ID`) REFERENCES `equipos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_CASOS_USUARIO` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casos`
--

LOCK TABLES `casos` WRITE;
/*!40000 ALTER TABLE `casos` DISABLE KEYS */;
/*!40000 ALTER TABLE `casos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(255) NOT NULL,
  `UBICACION` varchar(300) DEFAULT NULL,
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `TABLEROINDIVIDUAL_ID` int DEFAULT NULL,
  `TABLEROCOMPARTIDO_ID` int DEFAULT NULL,
  `CODIGO` varchar(255) NOT NULL,
  `NOMBRE` varchar(255) DEFAULT NULL,
  `MARCA` varchar(255) DEFAULT NULL,
  `MODELO` varchar(255) DEFAULT NULL,
  `SERIE` varchar(255) DEFAULT NULL,
  `IP` varchar(60) DEFAULT NULL,
  `MASCARA` varchar(60) DEFAULT NULL,
  `GATEWAY` varchar(60) DEFAULT NULL,
  `MAC_ADDRESS1` varchar(60) DEFAULT NULL,
  `MAC_ADDRESS2` varchar(60) DEFAULT NULL,
  `UBICACION` varchar(300) DEFAULT NULL,
  `ESTADOOPERATIVO` varchar(200) DEFAULT NULL COMMENT 'Operativo | En mantenimiento | Fuera de servicio',
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  `DESCRIPCION` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_EQUIPOS_codigo` (`CODIGO`),
  KEY `idx_EQUIPOS_TABIND` (`TABLEROINDIVIDUAL_ID`),
  KEY `idx_EQUIPOS_TABCOMPAR` (`TABLEROCOMPARTIDO_ID`),
  CONSTRAINT `fk_EQUIPOS_TABLEROCOMPARTIDO` FOREIGN KEY (`TABLEROCOMPARTIDO_ID`) REFERENCES `tablerocompartido` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_EQUIPOS_TABLEROINDIVIDUAL` FOREIGN KEY (`TABLEROINDIVIDUAL_ID`) REFERENCES `tableroindividual` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `finca`
--

DROP TABLE IF EXISTS `finca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `finca` (
  `id` int NOT NULL AUTO_INCREMENT,
  `EMPRESA_ID` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `REFERENCIA` text,
  `UBICACION` text,
  PRIMARY KEY (`id`),
  KEY `idx_FINCA_EMPRESA` (`EMPRESA_ID`),
  CONSTRAINT `fk_FINCA_EMPRESA` FOREIGN KEY (`EMPRESA_ID`) REFERENCES `empresa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finca`
--

LOCK TABLES `finca` WRITE;
/*!40000 ALTER TABLE `finca` DISABLE KEYS */;
/*!40000 ALTER TABLE `finca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `informes_tecnicos`
--

DROP TABLE IF EXISTS `informes_tecnicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `informes_tecnicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `USUARIO_ID` int NOT NULL COMMENT 'Quién elabora el informe',
  `ORDENDESERVICIO_ID` int NOT NULL,
  `FECHA_EMISION` datetime DEFAULT NULL,
  `CODIGO_INFORME` varchar(250) DEFAULT NULL,
  `URL_ARCHIVO` varchar(500) DEFAULT NULL,
  `ESTADO` varchar(100) DEFAULT NULL COMMENT 'Borrador | Revisión | Aprobado',
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_IT_USUARIO` (`USUARIO_ID`),
  KEY `idx_IT_OS` (`ORDENDESERVICIO_ID`),
  CONSTRAINT `fk_IT_ORDENDESERVICIO` FOREIGN KEY (`ORDENDESERVICIO_ID`) REFERENCES `ordendeservicio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_IT_USUARIO` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `informes_tecnicos`
--

LOCK TABLES `informes_tecnicos` WRITE;
/*!40000 ALTER TABLE `informes_tecnicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `informes_tecnicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordendecompra`
--

DROP TABLE IF EXISTS `ordendecompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordendecompra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `NUMERO_FACTURA` varchar(100) DEFAULT NULL,
  `MONTO` decimal(10,2) DEFAULT NULL,
  `PROVEEDOR` varchar(255) DEFAULT NULL,
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordendecompra`
--

LOCK TABLES `ordendecompra` WRITE;
/*!40000 ALTER TABLE `ordendecompra` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordendecompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordendeservicio`
--

DROP TABLE IF EXISTS `ordendeservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordendeservicio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `CASOS_ID` int NOT NULL,
  `EMPRESA_ID` int NOT NULL,
  `USUARIO_ID` int NOT NULL COMMENT 'Técnico asignado',
  `ORDENDETRABAJO_ID` int DEFAULT NULL,
  `ORDENDECOMPRA_ID` int DEFAULT NULL,
  `FECHAEMISION` datetime DEFAULT NULL,
  `FECHACIERRE` datetime DEFAULT NULL,
  `TIPOMANTENIMIENTO` varchar(150) DEFAULT NULL COMMENT 'Correctivo | Preventivo | Predictivo',
  `DESCRIPCION` text,
  `OBSERVACIONES` text,
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_OS_CASOS` (`CASOS_ID`),
  KEY `idx_OS_EMPRESA` (`EMPRESA_ID`),
  KEY `idx_OS_USUARIO` (`USUARIO_ID`),
  KEY `idx_OS_TRABAJO` (`ORDENDETRABAJO_ID`),
  KEY `idx_OS_COMPRA` (`ORDENDECOMPRA_ID`),
  CONSTRAINT `fk_OS_CASOS` FOREIGN KEY (`CASOS_ID`) REFERENCES `casos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_OS_EMPRESA` FOREIGN KEY (`EMPRESA_ID`) REFERENCES `empresa` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_OS_ORDENDECOMPRA` FOREIGN KEY (`ORDENDECOMPRA_ID`) REFERENCES `ordendecompra` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_OS_ORDENDETRABAJO` FOREIGN KEY (`ORDENDETRABAJO_ID`) REFERENCES `ordendetrabajo` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_OS_USUARIO` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordendeservicio`
--

LOCK TABLES `ordendeservicio` WRITE;
/*!40000 ALTER TABLE `ordendeservicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordendeservicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordendetrabajo`
--

DROP TABLE IF EXISTS `ordendetrabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordendetrabajo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `FECHAEMISION` datetime DEFAULT NULL,
  `FECHACIERRE` datetime DEFAULT NULL,
  `PRIORIDAD` int DEFAULT NULL COMMENT '1=Alta | 2=Media | 3=Baja',
  `ESTADO` varchar(255) DEFAULT NULL,
  `DESCRIPCION` text,
  `INSTRUCCIONES` text,
  `SEGURIDADES` text,
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordendetrabajo`
--

LOCK TABLES `ordendetrabajo` WRITE;
/*!40000 ALTER TABLE `ordendetrabajo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordendetrabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piscinas`
--

DROP TABLE IF EXISTS `piscinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `piscinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `FINCA_ID` int NOT NULL,
  `TABLEROCOMPARTIDO_ID` int DEFAULT NULL COMMENT 'NULL si la piscina no usa tablero compartido',
  `NOMBREPS` varchar(255) NOT NULL,
  `REFERENCIA` text,
  PRIMARY KEY (`id`),
  KEY `idx_PISCINAS_FINCA` (`FINCA_ID`),
  KEY `idx_PISCINAS_TABCOMPARTIDO` (`TABLEROCOMPARTIDO_ID`),
  CONSTRAINT `fk_PISCINAS_FINCA` FOREIGN KEY (`FINCA_ID`) REFERENCES `finca` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PISCINAS_TABCOMPARTIDO` FOREIGN KEY (`TABLEROCOMPARTIDO_ID`) REFERENCES `tablerocompartido` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piscinas`
--

LOCK TABLES `piscinas` WRITE;
/*!40000 ALTER TABLE `piscinas` DISABLE KEYS */;
/*!40000 ALTER TABLE `piscinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tablerocompartido`
--

DROP TABLE IF EXISTS `tablerocompartido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tablerocompartido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` text,
  `DESCRIPCION` text,
  `FUNCION` text,
  `UBICACION` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tablerocompartido`
--

LOCK TABLES `tablerocompartido` WRITE;
/*!40000 ALTER TABLE `tablerocompartido` DISABLE KEYS */;
/*!40000 ALTER TABLE `tablerocompartido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tableroindividual`
--

DROP TABLE IF EXISTS `tableroindividual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tableroindividual` (
  `id` int NOT NULL AUTO_INCREMENT,
  `PISCINA_ID` int NOT NULL,
  `NOMBRE` text,
  `DESCRIPCION` text,
  `FUNCION` text,
  `UBICACION` text,
  PRIMARY KEY (`id`),
  KEY `idx_TABLEROINDIVIDUAL_PISCINA` (`PISCINA_ID`),
  CONSTRAINT `fk_TABLEROINDIVIDUAL_PISCINA` FOREIGN KEY (`PISCINA_ID`) REFERENCES `piscinas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tableroindividual`
--

LOCK TABLES `tableroindividual` WRITE;
/*!40000 ALTER TABLE `tableroindividual` DISABLE KEYS */;
/*!40000 ALTER TABLE `tableroindividual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(50) NOT NULL,
  `APELLIDO` varchar(50) NOT NULL,
  `IDENTIFICACION` varchar(30) NOT NULL,
  `CORREO` varchar(50) NOT NULL,
  `TELEFONO` varchar(30) DEFAULT NULL,
  `ROL` varchar(50) NOT NULL COMMENT 'Administrador | Técnico | Ingeniero',
  `FECHAREGISTRO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_USUARIO_identificacion` (`IDENTIFICACION`),
  UNIQUE KEY `uq_USUARIO_correo` (`CORREO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-27 14:58:37
