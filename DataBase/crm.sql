USE `ubercalc`;


DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `id`      INT(10) NOT NULL AUTO_INCREMENT,
  `name`    VARCHAR(128),
  `phones`  VARCHAR(128),
  `address` VARCHAR(255),

  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;


DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id`              INT(10)      NOT NULL AUTO_INCREMENT,
  `first_name`      VARCHAR(64),
  `middle_name`     VARCHAR(64),
  `last_name`       VARCHAR(64),
  `role`            ENUM('guest', 'client', 'agent', 'admin') DEFAULT 'guest',
  `email`           VARCHAR(128) NOT NULL,
  `password`        VARCHAR(64)  NOT NULL,
  `phone`           VARCHAR(14)  NOT NULL,
  `driving licence` VARCHAR(32),
  `company_id`      INT(10),

  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `ts`;
CREATE TABLE IF NOT EXISTS `ts` (
  `id`    INT(10) NOT NULL AUTO_INCREMENT,
  `make`  VARCHAR(128),
  `model` VARCHAR(128),
  `vin`   VARCHAR(17),
  `grn`   VARCHAR(16),
  `year`  YEAR(4),

  PRIMARY KEY (`id`),
  UNIQUE KEY `vin` (`vin`),
  UNIQUE KEY `grn` (`grn`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `user2ts`;
CREATE TABLE IF NOT EXISTS `user2ts` (
  `id`      INT(10) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `ts_id`   INT(10) NOT NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`ts_id`) REFERENCES `ts` (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;


DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
  `id`     INT(10)                                   NOT NULL AUTO_INCREMENT,
  `name`   VARCHAR(128)                              NOT NULL,
  `status` ENUM('draft', 'active', 'future', 'past') NOT NULL DEFAULT 'draft',

  PRIMARY KEY (`id`)

)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;


DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id`         INT(10)                                       NOT NULL AUTO_INCREMENT,
  `user2ts_id` INT(10)                                       NOT NULL,
  `group_id`   INT(10),
  `status`     ENUM('draft', 'approved', 'paid', 'rejected') NOT NULL DEFAULT 'draft',

  PRIMARY KEY (`id`),
  FOREIGN KEY (`user2ts_id`) REFERENCES `user2ts` (`id`),
  FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;


DROP TABLE IF EXISTS `order2history`;
CREATE TABLE IF NOT EXISTS `order2history` (
  `id`         INT(10) NOT NULL AUTO_INCREMENT,
  `order_id`   INT(10) NOT NULL,
  `history_id` INT(10) NOT NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  FOREIGN KEY (`history_id`) REFERENCES `calc_history` (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `ldu`;
CREATE TABLE IF NOT EXISTS `ldu` (
  `id`              INT(10)     NOT NULL AUTO_INCREMENT,
  `first_name`      VARCHAR(64) NOT NULL,
  `middle_name`     VARCHAR(64) NOT NULL,
  `last_name`       VARCHAR(64) NOT NULL,
  `driving licence` VARCHAR(32) NOT NULL,
  `exp_year_start`  YEAR(4)     NOT NULL,

  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `order2ldu`;
CREATE TABLE IF NOT EXISTS `order2ldu` (
  `id`       INT(10) NOT NULL AUTO_INCREMENT,
  `order_id` INT(10) NOT NULL,
  `ldu_id`   INT(10) NOT NULL,

  PRIMARY KEY (`id`),
  FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  FOREIGN KEY (`ldu_id`) REFERENCES `ldu` (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;






