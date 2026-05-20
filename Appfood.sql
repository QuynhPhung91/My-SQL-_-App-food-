/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `Food`;
CREATE TABLE `Food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `description` varchar(255) DEFAULT 'Chưa có thông tin',
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `Food_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `FoodType` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `FoodType`;
CREATE TABLE `FoodType` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `Like_res`;
CREATE TABLE `Like_res` (
  `user_id` int NOT NULL,
  `res_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`res_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `Like_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `Like_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `Restaurant` (`res_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `Order`;
CREATE TABLE `Order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `arr_sub_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `Order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `Order_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `Food` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `Rate_res`;
CREATE TABLE `Rate_res` (
  `user_id` int NOT NULL,
  `res_id` int NOT NULL,
  `amount` int DEFAULT NULL,
  `date_rate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`res_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `Rate_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `Rate_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `Restaurant` (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `Restaurant`;
CREATE TABLE `Restaurant` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT 'Chưa có thông tin',
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `SubFood`;
CREATE TABLE `SubFood` (
  `sub_id` int NOT NULL AUTO_INCREMENT,
  `sub_name` varchar(255) NOT NULL,
  `price` float DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  PRIMARY KEY (`sub_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `SubFood_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `Food` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Food` (`food_id`, `food_name`, `image`, `price`, `description`, `type_id`) VALUES
(1, 'Phở bò', 'pho_bo.jpg', 65000, 'Phở bò truyền thống nước dùng đậm đà', 1),
(2, 'Bún bò Huế', 'bun_bo_hue.jpg', 60000, 'Bún bò cay đặc trưng miền Trung', 1),
(3, 'Hủ tiếu', 'hu_tieu.jpg', 55000, 'Hủ tiếu Nam Vang đặc biệt', 1),
(4, 'Cơm tấm', 'com_tam.jpg', 55000, 'Cơm tấm sườn bì chả', 2),
(5, 'Sinh tố', 'sinh_to.jpg', 40000, 'Sinh tố trái cây tươi', 3),
(6, 'Nước ép', 'nuoc_ep.jpg', 35000, 'Nước ép trái cây tươi nguyên chất', 3),
(7, 'Chè thập cẩm', 'che.jpg', 35000, 'Chè thập cẩm đặc biệt', 4),
(8, 'Bánh flan', 'banh_flan.jpg', 25000, 'Bánh flan caramen mềm mịn', 4);
INSERT INTO `FoodType` (`type_id`, `type_name`) VALUES
(1, 'Món nước'),
(2, 'Món khô'),
(3, 'Đồ uống'),
(4, 'Tráng miệng'),
(5, 'Món chay'),
(6, 'Món nước'),
(7, 'Món khô'),
(8, 'Đồ uống'),
(9, 'Tráng miệng'),
(10, 'Món chay');
INSERT INTO `Like_res` (`user_id`, `res_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(1, 2),
(5, 2),
(7, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(1, 4),
(4, 4),
(1, 5),
(2, 5),
(6, 5),
(1, 6),
(3, 6),
(2, 7),
(4, 7),
(6, 7),
(2, 8),
(3, 8);
INSERT INTO `Order` (`id`, `user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(1, 1, 1, 2, 'ORD-001', '1,2'),
(2, 1, 4, 1, 'ORD-002', '13'),
(3, 1, 7, 3, 'ORD-003', '16,17'),
(4, 1, 2, 2, 'ORD-004', '6,7'),
(5, 1, 3, 2, 'ORD-006', '9,10'),
(6, 2, 1, 1, 'ORD-007', '1'),
(7, 2, 4, 2, 'ORD-008', '12,13'),
(8, 2, 7, 1, 'ORD-009', '16'),
(9, 3, 2, 1, 'ORD-010', '6'),
(10, 3, 5, 2, 'ORD-011', NULL),
(11, 3, 8, 1, 'ORD-012', '20'),
(12, 4, 4, 3, 'ORD-013', '13,14,15'),
(13, 4, 6, 1, 'ORD-014', NULL),
(14, 5, 1, 1, 'ORD-015', '3'),
(15, 5, 8, 2, 'ORD-016', NULL),
(16, 6, 7, 2, 'ORD-017', '17,18'),
(17, 7, 3, 1, 'ORD-019', '11');
INSERT INTO `Rate_res` (`user_id`, `res_id`, `amount`, `date_rate`) VALUES
(1, 1, 5, '2026-05-20 19:13:22'),
(1, 3, 4, '2026-05-20 19:13:22'),
(1, 5, 3, '2026-05-20 19:13:22'),
(1, 7, 5, '2026-05-20 19:13:22'),
(2, 1, 4, '2026-05-20 19:13:22'),
(2, 2, 5, '2026-05-20 19:13:22'),
(2, 4, 4, '2026-05-20 19:13:22'),
(2, 6, 3, '2026-05-20 19:13:22'),
(3, 2, 5, '2026-05-20 19:13:22'),
(3, 3, 4, '2026-05-20 19:13:22'),
(3, 5, 4, '2026-05-20 19:13:22'),
(3, 8, 5, '2026-05-20 19:13:22'),
(4, 1, 3, '2026-05-20 19:13:22'),
(4, 4, 5, '2026-05-20 19:13:22'),
(4, 6, 4, '2026-05-20 19:13:22'),
(4, 7, 4, '2026-05-20 19:13:22'),
(5, 2, 4, '2026-05-20 19:13:22'),
(5, 3, 5, '2026-05-20 19:13:22'),
(5, 5, 3, '2026-05-20 19:13:22'),
(5, 8, 4, '2026-05-20 19:13:22'),
(6, 1, 4, '2026-05-20 19:13:22'),
(6, 3, 5, '2026-05-20 19:13:22'),
(6, 6, 3, '2026-05-20 19:13:22'),
(7, 2, 3, '2026-05-20 19:13:22'),
(7, 4, 4, '2026-05-20 19:13:22'),
(7, 8, 5, '2026-05-20 19:13:22');
INSERT INTO `Restaurant` (`res_id`, `res_name`, `image`, `description`) VALUES
(1, 'Phở Thìn Hà Nội', 'pho_thin.jpg', 'Quán phở bò truyền thống Hà Nội nổi tiếng từ 1955'),
(2, 'Bún Bò Huế Mụ Rớt', 'bun_bo.jpg', 'Bún bò Huế cay đặc trưng, công thức gia truyền'),
(3, 'Cơm Tấm Thuận Kiều', 'com_tam.jpg', 'Cơm tấm sườn bì chả ngon nhất Sài Gòn'),
(4, 'Nhà Hàng Hải Sản Biển Đông', 'hai_san.jpg', 'Hải sản tươi sống, đặc sản miền biển'),
(5, 'Lẩu Nấm Thiên Nhiên', 'lau_nam.jpg', 'Lẩu nấm chay thanh đạm, tốt cho sức khỏe'),
(6, 'Quán Ăn Bà Ba', 'ba_ba.jpg', 'Món ăn Nam Bộ dân dã, đậm đà hương vị quê hương'),
(7, 'BBQ Sân Vườn Xanh', 'bbq.jpg', 'Nướng than hoa ngoài trời, không gian thoáng mát'),
(8, 'Dimsum Cát Tường', 'dimsum.jpg', 'Dimsum Hồng Kông chuẩn vị, phục vụ cả ngày'),
(9, 'Phở Thìn Hà Nội', 'pho_thin.jpg', 'Quán phở bò truyền thống Hà Nội nổi tiếng từ 1955'),
(10, 'Bún Bò Huế Mụ Rớt', 'bun_bo.jpg', 'Bún bò Huế cay đặc trưng, công thức gia truyền'),
(11, 'Cơm Tấm Thuận Kiều', 'com_tam.jpg', 'Cơm tấm sườn bì chả ngon nhất Sài Gòn'),
(12, 'Nhà Hàng Hải Sản Biển Đông', 'hai_san.jpg', 'Hải sản tươi sống, đặc sản miền biển'),
(13, 'Lẩu Nấm Thiên Nhiên', 'lau_nam.jpg', 'Lẩu nấm chay thanh đạm, tốt cho sức khỏe'),
(14, 'Quán Ăn Bà Ba', 'ba_ba.jpg', 'Món ăn Nam Bộ dân dã, đậm đà hương vị quê hương'),
(15, 'BBQ Sân Vườn Xanh', 'bbq.jpg', 'Nướng than hoa ngoài trời, không gian thoáng mát'),
(16, 'Dimsum Cát Tường', 'dimsum.jpg', 'Dimsum Hồng Kông chuẩn vị, phục vụ cả ngày'),
(17, 'Phở Thìn Hà Nội', 'pho_thin.jpg', 'Quán phở bò truyền thống Hà Nội nổi tiếng từ 1955'),
(18, 'Bún Bò Huế Mụ Rớt', 'bun_bo.jpg', 'Bún bò Huế cay đặc trưng, công thức gia truyền'),
(19, 'Cơm Tấm Thuận Kiều', 'com_tam.jpg', 'Cơm tấm sườn bì chả ngon nhất Sài Gòn'),
(20, 'Nhà Hàng Hải Sản Biển Đông', 'hai_san.jpg', 'Hải sản tươi sống, đặc sản miền biển'),
(21, 'Lẩu Nấm Thiên Nhiên', 'lau_nam.jpg', 'Lẩu nấm chay thanh đạm, tốt cho sức khỏe'),
(22, 'Quán Ăn Bà Ba', 'ba_ba.jpg', 'Món ăn Nam Bộ dân dã, đậm đà hương vị quê hương'),
(23, 'BBQ Sân Vườn Xanh', 'bbq.jpg', 'Nướng than hoa ngoài trời, không gian thoáng mát'),
(24, 'Dimsum Cát Tường', 'dimsum.jpg', 'Dimsum Hồng Kông chuẩn vị, phục vụ cả ngày');
INSERT INTO `SubFood` (`sub_id`, `sub_name`, `price`, `food_id`) VALUES
(1, 'Phở tái', 65000, 1),
(2, 'Phở chín', 65000, 1),
(3, 'Phở tái chín', 68000, 1),
(4, 'Phở đặc biệt', 75000, 1),
(5, 'Bún bò thường', 60000, 2),
(6, 'Bún bò đặc biệt', 75000, 2),
(7, 'Bún bò gân', 68000, 2),
(8, 'Hủ tiếu khô', 55000, 3),
(9, 'Hủ tiếu nước', 55000, 3),
(10, 'Hủ tiếu đặc biệt', 65000, 3),
(11, 'Cơm sườn đơn', 45000, 4),
(12, 'Cơm sườn bì chả', 55000, 4),
(13, 'Cơm đặc biệt', 65000, 4),
(14, 'Cơm sườn trứng', 50000, 4),
(15, 'Trà sữa matcha', 48000, 7),
(16, 'Trà sữa khoai môn', 48000, 7),
(17, 'Sinh tố bơ', 40000, 8),
(18, 'Sinh tố xoài', 40000, 8),
(19, 'Sinh tố dâu', 40000, 8);
INSERT INTO `User` (`user_id`, `full_name`, `email`, `password`) VALUES
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com', '$2b$10$hash1'),
(2, 'Trần Thị Bình', 'binh.tran@gmail.com', '$2b$10$hash2'),
(3, 'Lê Hoàng Nam', 'nam.le@gmail.com', '$2b$10$hash3'),
(4, 'Phạm Thị Lan', 'lan.pham@gmail.com', '$2b$10$hash4'),
(5, 'Hoàng Minh Dũng', 'tuan.hoang@gmail.com', '$2b$10$hash5'),
(6, 'Đặng Thị Thu', 'thu.dang@gmail.com', '$2b$10$hash6'),
(7, 'Vũ Quốc Hùng', 'hung.vu@gmail.com', '$2b$10$hash7'),
(8, 'Bùi Thị Hoa', 'hoa.bui@gmail.com', '$2b$10$hash8'),
(9, 'Ngô Văn Đức', 'duc.ngo@gmail.com', '$2b$10$hash9'),
(10, 'Đinh Thị Mai', 'mai.dinh@gmail.com', '$2b$10$hash10');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;