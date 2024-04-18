drop database if exists `library`;

CREATE DATABASE  IF NOT EXISTS `library`;

USE `library`;


DROP TABLE IF EXISTS `member_state`;

CREATE TABLE `member_state` (
  `ms_num` int NOT NULL AUTO_INCREMENT,
  `ms_name` varchar(15) NOT NULL,
  PRIMARY KEY (`ms_num`)
) ;

DROP TABLE IF EXISTS `grade`;

CREATE TABLE `grade` (
  `gr_num` int NOT NULL AUTO_INCREMENT,
  `gr_name` varchar(10) NOT NULL,
  `gr_discount` int NOT NULL DEFAULT '0',
  `gr_loan_condition` int NOT NULL,
  `gr_post_condition` int NOT NULL,
  PRIMARY KEY (`gr_num`)
) ;

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `me_id` varchar(12) NOT NULL,
  `me_pw` varchar(255) NOT NULL,
  `me_email` varchar(30) NOT NULL,
  `me_phone` varchar(13) NOT NULL,
  `me_nick` varchar(12) NOT NULL,
  `me_date` date NOT NULL,
  `me_fail_count` int NOT NULL DEFAULT '0',
  `me_block` date DEFAULT NULL,
  `me_loan_block` date DEFAULT NULL,
  `me_count` int NOT NULL DEFAULT '0',
  `me_ms_num` int NOT NULL,
  `me_gr_num` int NOT NULL,
  PRIMARY KEY (`me_id`),
  UNIQUE KEY `me_nick` (`me_nick`),
  KEY `FK_member_state_TO_member_1` (`me_ms_num`),
  KEY `FK_grade_TO_member_1` (`me_gr_num`),
  CONSTRAINT `FK_grade_TO_member_1` FOREIGN KEY (`me_gr_num`) REFERENCES `grade` (`gr_num`),
  CONSTRAINT `FK_member_state_TO_member_1` FOREIGN KEY (`me_ms_num`) REFERENCES `member_state` (`ms_num`)
) ;

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
  `rp_num` int NOT NULL AUTO_INCREMENT,
  `rp_note` text NOT NULL,
  `rp_type` varchar(15) NOT NULL,
  `rp_target` varchar(12) NOT NULL,
  `rp_me_id` varchar(12) NOT NULL,
  PRIMARY KEY (`rp_num`),
  KEY `FK_member_TO_report_1` (`rp_me_id`),
  CONSTRAINT `FK_member_TO_report_1` FOREIGN KEY (`rp_me_id`) REFERENCES `member` (`me_id`)
);




DROP TABLE IF EXISTS `upper`;

CREATE TABLE `upper` (
  `up_num` int NOT NULL,
  `up_name` varchar(10) NOT NULL,
  PRIMARY KEY (`up_num`)
) ;


DROP TABLE IF EXISTS `under`;

CREATE TABLE `under` (
  `un_num` int NOT NULL  auto_increment,
  `un_name` varchar(10) NOT NULL,
  `un_code` int NOT NULL,
  `un_up_num` int NOT NULL,
  PRIMARY KEY (`un_num`),
  KEY `FK_upper_TO_under_1` (`un_up_num`),
  CONSTRAINT `FK_upper_TO_under_1` FOREIGN KEY (`un_up_num`) REFERENCES `upper` (`up_num`)
) ;

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `bo_num` int NOT NULL auto_increment,
  `bo_title` varchar(100) NOT NULL,
  `bo_contents` longtext NOT NULL,
  `bo_date` date NOT NULL,
  `bo_publisher` varchar(50) NOT NULL,
  `bo_price` int NOT NULL,
  `bo_sale_price` int NOT NULL,
  `bo_thumbnail` longtext NOT NULL,
  `bo_isbn` varchar(13) NOT NULL,
  `bo_code` varchar(30) default null,
  `bo_un_num` int NOT NULL,
  PRIMARY KEY (`bo_num`),
  KEY `FK_under_TO_book_1` (`bo_un_num`),
  CONSTRAINT `FK_under_TO_book_1` FOREIGN KEY (`bo_un_num`) REFERENCES `under` (`un_num`)
) ;

DROP TABLE IF EXISTS `authors`;

CREATE TABLE `authors` (
  `au_num` int NOT NULL AUTO_INCREMENT,
  `au_name` varchar(30) NOT NULL,
  `au_bo_num` int NOT NULL,
  PRIMARY KEY (`au_num`),
  KEY `FK_book_TO_authors_1` (`au_bo_num`),
  CONSTRAINT `FK_book_TO_authors_1` FOREIGN KEY (`au_bo_num`) REFERENCES `book` (`bo_num`) ON DELETE CASCADE
) ;

DROP TABLE IF EXISTS `translators`;

CREATE TABLE `translators` (
  `tr_num` int NOT NULL AUTO_INCREMENT,
  `tr_name` varchar(30) NOT NULL,
  `tr_bo_num` int  NOT NULL,
  PRIMARY KEY (`tr_num`),
  KEY `FK_book_TO_translators_1` (`tr_bo_num`),
  CONSTRAINT `FK_book_TO_translators_1` FOREIGN KEY (`tr_bo_num`) REFERENCES `book` (`bo_num`) ON DELETE CASCADE
) ;


DROP TABLE IF EXISTS `loan`;

CREATE TABLE `loan` (
  `lo_num` int NOT NULL AUTO_INCREMENT,
  `lo_date` date NOT NULL,
  `lo_return` date DEFAULT NULL,
  `lo_limit` date NOT NULL,
  `lo_state` int NOT NULL,
  `lo_me_id` varchar(12) NOT NULL,
  `lo_bo_num` int  NOT NULL,
  PRIMARY KEY (`lo_num`),
  KEY `FK_member_TO_loan_1` (`lo_me_id`),
  KEY `FK_book_TO_loan_1` (`lo_bo_num`),
  CONSTRAINT `FK_book_TO_loan_1` FOREIGN KEY (`lo_bo_num`) REFERENCES `book` (`bo_num`),
  CONSTRAINT `FK_member_TO_loan_1` FOREIGN KEY (`lo_me_id`) REFERENCES `member` (`me_id`)
) ;


DROP TABLE IF EXISTS `reserve`;

CREATE TABLE `reserve` (
  `re_num` int NOT NULL AUTO_INCREMENT,
  `re_date` date NOT NULL,
  `re_bo_num` int  NOT NULL,
  `re_state` int NOT NULL,
  `re_me_id` varchar(12) NOT NULL,
  PRIMARY KEY (`re_num`),
  KEY `FK_book_TO_reserve_1` (`re_bo_num`),
  KEY `FK_member_TO_reserve_1` (`re_me_id`),
  CONSTRAINT `FK_book_TO_reserve_1` FOREIGN KEY (`re_bo_num`) REFERENCES `book` (`bo_num`),
  CONSTRAINT `FK_member_TO_reserve_1` FOREIGN KEY (`re_me_id`) REFERENCES `member` (`me_id`)
) ;

DROP TABLE IF EXISTS `sale`;

CREATE TABLE `sale` (
  `sa_num` int NOT NULL AUTO_INCREMENT,
  `sa_price` int NOT NULL,
  `sa_date` datetime not null,
  `sa_bo_num` int  NOT NULL,
  `sa_me_id` varchar(12) NOT NULL,
  PRIMARY KEY (`sa_num`),
  KEY `FK_book_TO_sale_1` (`sa_bo_num`),
  KEY `FK_member_TO_sale_1` (`sa_me_id`),
  CONSTRAINT `FK_book_TO_sale_1` FOREIGN KEY (`sa_bo_num`) REFERENCES `book` (`bo_num`),
  CONSTRAINT `FK_member_TO_sale_1` FOREIGN KEY (`sa_me_id`) REFERENCES `member` (`me_id`)
) ;

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `rv_num` int NOT NULL AUTO_INCREMENT,
  `rv_content` text NOT NULL,
  `rv_score` int NOT NULL,
  `rv_date` datetime not null,
  `rv_me_id` varchar(12) NOT NULL,
  `rv_bo_num` int  NOT NULL,
  PRIMARY KEY (`rv_num`),
  KEY `FK_member_TO_review_1` (`rv_me_id`),
  KEY `FK_book_TO_review_1` (`rv_bo_num`),
  CONSTRAINT `FK_book_TO_review_1` FOREIGN KEY (`rv_bo_num`) REFERENCES `book` (`bo_num`),
  CONSTRAINT `FK_member_TO_review_1` FOREIGN KEY (`rv_me_id`) REFERENCES `member` (`me_id`)
) ;

DROP TABLE IF EXISTS `opinion`;

CREATE TABLE `opinion` (
  `op_num` int NOT NULL AUTO_INCREMENT,
  `op_state` int DEFAULT NULL,
  `op_rv_num` int NOT NULL,
  `op_me_id` varchar(12) NOT NULL,
  PRIMARY KEY (`op_num`),
  KEY `FK_member_TO_opinion_1` (`op_me_id`),
  KEY `FK_review_TO_opinion_1` (`op_rv_num`),
  CONSTRAINT `FK_member_TO_opinion_1` FOREIGN KEY (`op_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_review_TO_opinion_1` FOREIGN KEY (`op_rv_num`) REFERENCES `review` (`rv_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ;




DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `ca_num` int NOT NULL AUTO_INCREMENT,
  `ca_name` varchar(15) NOT NULL,
  PRIMARY KEY (`ca_num`)
) ;

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `po_num` int NOT NULL AUTO_INCREMENT,
  `po_title` varchar(50) NOT NULL,
  `po_content` longtext NOT NULL,
  `po_view` int NOT NULL DEFAULT '0',
  `po_datetime` datetime NOT NULL,
  `po_me_id` varchar(12) NOT NULL,
  `po_ca_num` int NOT NULL,
  PRIMARY KEY (`po_num`),
  KEY `FK_member_TO_post_1` (`po_me_id`),
  KEY `FK_category_TO_post_1` (`po_ca_num`),
  CONSTRAINT `FK_category_TO_post_1` FOREIGN KEY (`po_ca_num`) REFERENCES `category` (`ca_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_member_TO_post_1` FOREIGN KEY (`po_me_id`) REFERENCES `member` (`me_id`)
) ;

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `co_num` int NOT NULL AUTO_INCREMENT,
  `co_ori_num` int NOT NULL DEFAULT '0',
  `co_content` text NOT NULL,
  `co_datetime` datetime NOT NULL,
  `co_state` int NOT NULL DEFAULT '0',
  `co_me_id` varchar(12) NOT NULL,
  `co_po_num` int NOT NULL,
  PRIMARY KEY (`co_num`),
  KEY `FK_member_TO_comment_1` (`co_me_id`),
  KEY `FK_post_TO_comment_1` (`co_po_num`),
  CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (`co_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_post_TO_comment_1` FOREIGN KEY (`co_po_num`) REFERENCES `post` (`po_num`) ON DELETE CASCADE
) ;

DROP TABLE IF EXISTS `heart`;

CREATE TABLE `heart` (
  `he_num` int NOT NULL AUTO_INCREMENT,
  `he_state` int NOT NULL,
  `he_po_num` int NOT NULL,
  `he_me_id` varchar(12) NOT NULL,
  PRIMARY KEY (`he_num`),
  KEY `FK_member_TO_heart_1` (`he_me_id`),
  KEY `FK_post_TO_heart_1` (`he_po_num`),
  CONSTRAINT `FK_member_TO_heart_1` FOREIGN KEY (`he_me_id`) REFERENCES `member` (`me_id`),
  CONSTRAINT `FK_post_TO_heart_1` FOREIGN KEY (`he_po_num`) REFERENCES `post` (`po_num`) ON DELETE CASCADE
) ;

DROP TABLE IF EXISTS `vote`;

CREATE TABLE `vote` (
  `vo_num` int NOT NULL AUTO_INCREMENT,
  `vo_title` varchar(30) default "",
  `vo_dup` int not null,
  `vo_state` int NOT NULL,
  `vo_date` datetime NOT NULL,
  `vo_po_num` int NOT NULL,
  PRIMARY KEY (`vo_num`),
  KEY `FK_post_TO_vote_1` (`vo_po_num`),
  CONSTRAINT `FK_post_TO_vote_1` FOREIGN KEY (`vo_po_num`) REFERENCES `post` (`po_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `it_num` int NOT NULL AUTO_INCREMENT,
  `it_name` varchar(50) NOT NULL,
  `it_count` int NOT NULL,
  `it_vo_num` int NOT NULL,
  PRIMARY KEY (`it_num`),
  KEY `FK_vote_TO_item_1` (`it_vo_num`),
  CONSTRAINT `FK_vote_TO_item_1` FOREIGN KEY (`it_vo_num`) REFERENCES `vote` (`vo_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

DROP TABLE IF EXISTS `choose`;

CREATE TABLE `choose` (
  `ch_num` int NOT NULL AUTO_INCREMENT,
  `ch_state` int not null,
  `ch_it_num` int NOT NULL,
  `ch_me_id` varchar(12) NOT NULL,
  PRIMARY KEY (`ch_num`),
  KEY `FK_member_TO_choose_1` (`ch_me_id`),
  KEY `FK_item_TO_choose_1` (`ch_it_num`),
  CONSTRAINT `FK_item_TO_choose_1` FOREIGN KEY (`ch_it_num`) REFERENCES `item` (`it_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_member_TO_choose_1` FOREIGN KEY (`ch_me_id`) REFERENCES `member` (`me_id`)
) ;


SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));