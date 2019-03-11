/* CREATE DATABASE */

CREATE DATABASE IF NOT EXISTS `master`;

USE master;

DROP DATABASE IF EXISTS `reminderdb`;

CREATE DATABASE IF NOT EXISTS `reminderdb`;

DROP DATABASE IF EXISTS `master`;


USE reminderdb;


/* CREATE TABLE */

CREATE TABLE `styles`
(
  `id`                        int(11) NOT NULL,
  `text_color`                varchar(10)  DEFAULT NULL,
  `text_color_press`          varchar(10)  DEFAULT NULL,
  `text_color_disabled`       varchar(10)  DEFAULT NULL,
  `background_color`          varchar(10)  DEFAULT NULL,
  `background_color_press`    varchar(10)  DEFAULT NULL,
  `background_color_disabled` varchar(10)  DEFAULT NULL,
  `background_image`          varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `actions`
(
  `id`   int(11) NOT NULL,
  `url`  varchar(255) DEFAULT NULL,
  `type` int(11)      DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `contents`
(
  `id`          int(11) NOT NULL,
  `title`       varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `template`    varchar(255) DEFAULT NULL,
  `action_id`   int(11)      DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `content_action_idx` (`action_id`),
  CONSTRAINT `content_action` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `components`
(
  `id`         int(11) NOT NULL,
  `type`       varchar(10)                                             DEFAULT NULL,
  `text`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `image_url`  varchar(255)                                            DEFAULT NULL,
  `style_id`   int(11)                                                 DEFAULT NULL,
  `action_id`  int(11)                                                 DEFAULT NULL,
  `content_id` int(11)                                                 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `component_action_idx` (`action_id`),
  KEY `component_content_idx` (`content_id`),
  KEY `component_style_idx` (`style_id`),
  CONSTRAINT `component_action` FOREIGN KEY (`action_id`) REFERENCES `actions` (`id`),
  CONSTRAINT `component_content` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`),
  CONSTRAINT `component_style` FOREIGN KEY (`style_id`) REFERENCES `styles` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE `reminders`
(
  `id`         bigint(20) NOT NULL,
  `created_at` timestamp  NULL  DEFAULT NULL,
  `updated_at` timestamp  NULL  DEFAULT NULL,
  `deleted_at` timestamp  NULL  DEFAULT NULL,
  `type`       int(10) unsigned DEFAULT NULL,
  `priority`   int(11)          DEFAULT NULL,
  `due`        timestamp  NULL  DEFAULT NULL,
  `content_id` int(11)          DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminder_content_idx` (`content_id`),
  CONSTRAINT `reminder_content` FOREIGN KEY (`content_id`) REFERENCES `contents` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE `user_reminder`
(
  `userid`      bigint(20) NOT NULL,
  `reminder_id` bigint(20) NOT NULL,
  PRIMARY KEY (`reminder_id`, `userid`),
  CONSTRAINT `user_reminder` FOREIGN KEY (`reminder_id`) REFERENCES `reminders` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;


/* DUMMY DATA: */

INSERT IGNORE INTO actions (id, url, type)
VALUES (1, "zalopay://launch/app/17", 1),
       (2, "zalopay://launch/app/12", 1),
       (3, "zalopay://launch/app/16", 1),
       (4, "zalopay://launch/app/18", 1),
       (5, "zalopay://launch/app/20", 1),
       (6, "", 1);

INSERT IGNORE INTO `reminderdb`.`contents`(`id`, `title`, `description`, `template`, `action_id`)
VALUES (1, "Nạp điện thoại Viettel ngay hôm nay", "Hôm nay Viettel khuyến mãi 50%", "1", 1),
       (2, "Nạp điện thoại Mobiphone ngay hôm nay", "Hôm nay Viettel khuyến mãi 50%", "1", 1),
       (3, "Nạp điện thoại Gmobile ngay hôm nay", "Hôm nay Viettel khuyến mãi 50%", "1", 1),
       (4, "Nạp điện thoại Vinaphone ngay hôm nay", "Hôm nay Viettel khuyến mãi 50%", "1", 1),
       (5, "Bạn có voucher chưa sử dụng", "Còn 1 ngày nữa để sử dụng Voucher 123Phim", "1", 2),
       (6, "Bạn có hóa đơn tiền điện cần thanh toán", "Hóa đơn tiền điện còn 1 ngày nữa cần thanh toán", "1", 3),
       (7, "Cần định danh tài khoản để nhận nhiều ưu đãi hơn", "Cần định danh tài khoản để nhận nhiều ưu đãi hơn", "1",
        4);

INSERT INTO `reminderdb`.`styles`
(`id`, `text_color`, `text_color_press`, `text_color_disabled`, `background_color`, `background_color_press`,
 `background_color_disabled`, `background_image`)
VALUES (1, "#ff0000", "#ff0001", "#ff0001", "#ff0001", "#ff0001", "#ff0001",
        "https://www.pexels.com/photo/beautiful-beauty-blue-bright-414612"),
       (2, "#ff0000", "#ff0001", "#ff0001", "#ff0001", "#ff0001", "#ff0001",
        "https://gizmodo.com/some-of-the-most-spectacular-astronomy-images-of-2018-1827695259"),
       (3, "#ff0000", "#ff0001", "#ff0001", "#ff0001", "#ff0001", "#ff0001",
        "https://gizmodo.com/some-of-the-most-spectacular-astronomy-images-of-2018-1827695259");

INSERT IGNORE INTO `reminderdb`.`components`(`id`, `type`, `text`, `image_url`, `style_id`, `action_id`, `content_id`)
VALUES (1, "Button", "Nạp ngay", "", 1, 1, 1),
       (2, "Button", "Đóng", "", 2, 6, 1),
       (3, "Button", "Nạp ngay", "", 1, 1, 2),
       (4, "Button", "Đóng", "", 1, 6, 2),
       (5, "Button", "Nạp ngay", "", 1, 1, 3),
       (6, "Button", "Nạp ngay", "", 1, 1, 4),
       (7, "Button", "Định danh ngay", "", 1, 1, 7);

INSERT IGNORE INTO `reminderdb`.`reminders`
(`id`, `created_at`, `updated_at`, `deleted_at`, `type`, `priority`, `due`, `content_id`)
VALUES (1, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 1),
       (2, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 2),
       (3, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 3),
       (4, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 4),
       (5, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 5),
       (6, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 5),
       (7, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 6),
       (8, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 7),
       (9, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 6),
       (10, UNIX_TIMESTAMP(), null, null, 1, 1, UNIX_TIMESTAMP(), 4);

INSERT IGNORE INTO `reminderdb`.`user_reminder` (`userid`, `reminder_id`)
VALUES (19010111, 1),
       (19010112, 2),
       (19010113, 2),
       (19010114, 2),
       (19010115, 2);
