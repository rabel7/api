create database redpack;
use redpack;

DROP TABLE IF EXISTS `cookie`;

CREATE TABLE `cookie` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `value` varchar(4096) comment 'cookie值' NOT NULL,
  `service` tinyint(1) NOT NULL,
  `application` tinyint(1) comment '0=微信1=QQ2=小程序' NOT NULL,
  `open_id` varchar(64) 'cookie中的open_id' NOT NULL,
  `nickname` varchar(128) comment '微信昵称' DEFAULT NULL,
  `head_img_url` varchar(512)  DEFAULT NULL,
  `user_id` bigint(20) '贡献cookie的用户id' NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_open_id` (`open_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `cookie_use_count`;

-- 用户领取cookie计数
CREATE TABLE `cookie_use_count` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL,
  `application` tinyint(1) NOT NULL,
  `open_id` varchar(64) NOT NULL,
  `cookie_id` bigint(20) NOT NULL,
  `cookie_user_id` bigint(20) NOT NULL,
  `receiving_id` bigint(20) NOT NULL,
  `receiving_user_id` bigint(20) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_open_id` (`open_id`),
  KEY `idx_cookie_id` (`cookie_id`),
  KEY `idx_cookie_user_id` (`cookie_user_id`),
  KEY `idx_receiving_id` (`receiving_id`),
  KEY `idx_receiving_user_id` (`receiving_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `receiving`;

-- 领取表
CREATE TABLE `receiving` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url_key` varchar(32) NOT NULL,
  `url` varchar(512) comment '红包url地址' NOT NULL,
  `phone` varchar(11) comment '领取的手机号' NOT NULL,
  `application` tinyint(1) NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `message` varchar(512) DEFAULT NULL,
  `nickname` varchar(256) DEFAULT NULL,
  `price` decimal(5,2) '领取红包的金额' DEFAULT NULL,
  `date` varchar(64) DEFAULT NULL,
  `user_id` bigint(20) '领取的用户' NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_url_key` (`url_key`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `user`;

-- 用户表
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(256) comment '头像' DEFAULT NULL,
  `name` varchar(32) comment '昵称' DEFAULT NULL,
  `password` char(128) NOT NULL,
  `salt` char(32) NOT NULL,
  `mail` varchar(128) DEFAULT NULL,
  `phone` varchar(11) comment '手机号，领红包用' DEFAULT NULL,
  `open_id` varchar(30) comment '公众号id，用户关注后会有' NOT NULL,
  `token` char(128) NULL,
  `is_locked` tinyint(1) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  UNIQUE KEY `uk_phone` (`phone`),
  UNIQUE KEY `uk_openid` (`open_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `verification`;

CREATE TABLE `verification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `object` varchar(512) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `code` char(128) comment NOT NULL,
  `purpose` tinyint(1) NOT NULL,
  `is_used` tinyint(1) NOT NULL,
  `gmt_create` datetime NOT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

