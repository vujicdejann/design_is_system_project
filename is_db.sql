/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : is_db

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 19/03/2023 16:58:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `customerID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`customerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (1, 'Bambi', '0113334445', 'Karađorđeva, Beograd', 'office@bambi.rs');
INSERT INTO `customers` VALUES (2, 'Štark', '0145738539', 'Sinđelićeva, Valjevo', 'kontakt@stark.com');
INSERT INTO `customers` VALUES (3, 'Plazma', '0114564356', 'Cvijićeva, Beograd', 'office@plazma.com');
INSERT INTO `customers` VALUES (4, 'Banini', '0114564321', 'Jovana Cvijića, Beograd', 'baninioffice@banini.com');

-- ----------------------------
-- Table structure for materials
-- ----------------------------
DROP TABLE IF EXISTS `materials`;
CREATE TABLE `materials`  (
  `materialID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `ordered_materialID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`materialID`) USING BTREE,
  INDEX `fk_materials_ordered_materialID`(`ordered_materialID` ASC) USING BTREE,
  CONSTRAINT `fk_materials_ordered_materialID` FOREIGN KEY (`ordered_materialID`) REFERENCES `ordered_materials` (`ordered_materialID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of materials
-- ----------------------------

-- ----------------------------
-- Table structure for ordered_materials
-- ----------------------------
DROP TABLE IF EXISTS `ordered_materials`;
CREATE TABLE `ordered_materials`  (
  `ordered_materialID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `mateiral_name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ordered_date` datetime NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `quantity` int NOT NULL,
  `status_order` enum('ordered','sent','delivered') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `supplierID` int UNSIGNED NOT NULL,
  `userID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`ordered_materialID`) USING BTREE,
  INDEX `fk_ordered_materials_supplierID`(`supplierID` ASC) USING BTREE,
  INDEX `fk_ordered_materials_userID`(`userID` ASC) USING BTREE,
  CONSTRAINT `fk_ordered_materials_supplierID` FOREIGN KEY (`supplierID`) REFERENCES `suppliers` (`supplierID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ordered_materials_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ordered_materials
-- ----------------------------

-- ----------------------------
-- Table structure for productions
-- ----------------------------
DROP TABLE IF EXISTS `productions`;
CREATE TABLE `productions`  (
  `productionID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `productID` int UNSIGNED NOT NULL,
  `userID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`productionID`) USING BTREE,
  INDEX `fk_productions_productID`(`productID` ASC) USING BTREE,
  INDEX `fk_productions_userID`(`userID` ASC) USING BTREE,
  CONSTRAINT `fk_productions_productID` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_productions_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productions
-- ----------------------------
INSERT INTO `productions` VALUES (1, 'graphic preparation', NULL, 1, 21);
INSERT INTO `productions` VALUES (2, 'printing', 'Zakašnjenje 3 dana', 2, 21);
INSERT INTO `productions` VALUES (3, 'stamping', NULL, 3, 21);
INSERT INTO `productions` VALUES (4, 'sending to warehouse', NULL, 4, 21);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `productID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ordered_date` datetime NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `customerID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`productID`) USING BTREE,
  INDEX `fk_products_customerID`(`customerID` ASC) USING BTREE,
  CONSTRAINT `fk_products_customerID` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Bambi ambalaža', '2023-02-20 23:00:00', 60, 98000.00, 1);
INSERT INTO `products` VALUES (2, 'Štark', '2023-02-20 10:00:00', 150, 178500.00, 2);
INSERT INTO `products` VALUES (3, 'Plazma', '2023-01-20 14:00:00', 500, 560000.00, 3);
INSERT INTO `products` VALUES (4, 'Banini', '2019-03-20 23:00:00', 400, 387900.00, 4);

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `supplierID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`supplierID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES (1, 'Sitologika', '0145678968', 'Karađorđeva, Valjevo', 'office@sitlogika.com');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `userID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `typeUser` enum('worker','admin') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` varchar(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `position` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (21, 'dvujic', '$2y$10$2EwfySbTXD75Hs8zqw/tu.svk6Z2fZSjVJ9Yd2U425/MZ2FKrYIgy', 'worker', 'Dejan Vujić', '0600146235', 'Milana Tešića 3', 'dejan.vujic.fzp@singimail.rs', 'worker');

-- ----------------------------
-- Table structure for warehouses
-- ----------------------------
DROP TABLE IF EXISTS `warehouses`;
CREATE TABLE `warehouses`  (
  `warehouseID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `location_number` int NOT NULL,
  `productionID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`warehouseID`) USING BTREE,
  INDEX `fk_warehouses_productionID`(`productionID` ASC) USING BTREE,
  CONSTRAINT `fk_warehouses_productionID` FOREIGN KEY (`productionID`) REFERENCES `productions` (`productionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehouses
-- ----------------------------
INSERT INTO `warehouses` VALUES (1, 'Banini', 400, 5674, 4);

SET FOREIGN_KEY_CHECKS = 1;
