# Host: localhost  (Version: 5.0.96-community-nt)
# Date: 2018-06-29 12:41:54
# Generator: MySQL-Front 5.3  (Build 4.214)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "player"
#

DROP TABLE IF EXISTS `player`;
CREATE TABLE `player` (
  `playerId` int(4) NOT NULL auto_increment COMMENT '选手id:自动增长 PK',
  `playername` varchar(20) NOT NULL default '' COMMENT '选手姓名',
  `state` int(2) NOT NULL default '0' COMMENT '选手状态:0为未淘汰，1为淘汰',
  `num` int(4) NOT NULL default '0' COMMENT '选手参赛次数:默认为0，记录选手参赛次数，次数与比赛轮数等同，参与一轮比赛+1',
  `picAddress` text NOT NULL COMMENT '选手大图片地址',
  `dateOfBirth` date NOT NULL default '0000-00-00' COMMENT '选手出生日期',
  `smallImg` text NOT NULL COMMENT '选手小图片地址',
  `sex` int(2) NOT NULL default '0' COMMENT '选手性别:0为男，1为女',
  PRIMARY KEY  (`playerId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

#
# Data for table "player"
#

INSERT INTO `player` VALUES (1,'张三',0,1,'/OnlineVoteSystem/upload/1.jpg','1985-10-24','/OnlineVoteSystem/upload/1.jpg',1),(2,'李四',1,1,'/OnlineVoteSystem/upload/2.jpg','1986-11-25','/OnlineVoteSystem/upload/2.jpg',1),(3,'王五',0,0,'/OnlineVoteSystem/upload/3.jpg','1988-10-10','/OnlineVoteSystem/upload/3.jpg',1),(4,'王麻子',0,1,'/OnlineVoteSystem/upload/4.jpg','1999-10-25','/OnlineVoteSystem/upload/4.jpg',1),(5,'王一',0,0,'/OnlineVoteSystem/upload/4.jpg','1999-05-20','/OnlineVoteSystem/upload/4.jpg',1),(6,'王二',0,0,'/OnlineVoteSystem/upload/4.jpg','1862-05-20','/OnlineVoteSystem/upload/4.jpg',1),(7,'王三',0,0,'/OnlineVoteSystem/upload/1.jpg','2008-05-08','/OnlineVoteSystem/upload/1.jpg',1),(8,'王四',0,0,'/OnlineVoteSystem/upload/1.jpg','1862-05-22','/OnlineVoteSystem/upload/1.jpg',1),(9,'王六',0,0,'/OnlineVoteSystem/upload/4.jpg','2017-05-02','/OnlineVoteSystem/upload/4.jpg',1),(10,'李蚂蚱',0,0,'/OnlineVoteSystem/upload/12.png','1997-08-09','/OnlineVoteSystem/upload/12 (2).png',1),(11,'李大宝',0,0,'/OnlineVoteSystem/upload/4.jpg','1996-06-07','/OnlineVoteSystem/upload/4.jpg',1);

#
# Structure for table "sessiontable"
#

DROP TABLE IF EXISTS `sessiontable`;
CREATE TABLE `sessiontable` (
  `id` int(11) NOT NULL auto_increment,
  `wheel` int(4) NOT NULL default '0' COMMENT '比赛轮数:比赛轮数对应player表中的num，自动生成轮数，选手总数模2，余一则随机数取出一选手轮空',
  `nowSession` varchar(20) NOT NULL default '' COMMENT '当前场次:场次安排以wheel字段后加3位数为样式，例如：3001代表第3轮第一场；获取选手num值，若小于nowSession的值则两两之间匹配',
  `winner` int(4) NOT NULL default '0' COMMENT '当前场次获胜者,对应player表中的playerId',
  `votesContrastA` int(10) NOT NULL default '0' COMMENT 'A选手票数:记录本场比赛选手A的具体票数，来自singleCount表中的values字段',
  `votesContrastB` int(10) NOT NULL default '0' COMMENT 'B选手票数:记录本场比赛选手B的具体票数，来自singleCount表中的values字段',
  `playerA` int(4) NOT NULL default '0' COMMENT '选手A:对应选手表中的playerId',
  `playerB` int(4) NOT NULL default '0' COMMENT '选手B:对应选手表中的playerId',
  `playerAscore` int(4) default NULL COMMENT '选手A评委打分:保留，暂不使用',
  `playerBscore` int(4) default NULL COMMENT '选手B评委打分:保留，暂不使用',
  `gameNow` int(4) NOT NULL default '0' COMMENT '默认为0,0为比赛未开始，1为开始，2为结束，3为暂停',
  PRIMARY KEY  (`id`),
  KEY `winner` (`winner`),
  KEY `playerA` (`playerA`),
  KEY `playerB` (`playerB`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "sessiontable"
#

INSERT INTO `sessiontable` VALUES (1,1,'1001',1,2,1,1,2,NULL,NULL,2),(2,1,'1002',1,0,0,3,5,NULL,NULL,1),(3,1,'1003',1,0,0,6,7,NULL,NULL,0),(4,1,'1004',1,0,0,8,9,NULL,NULL,0),(5,1,'1005',1,0,0,10,11,NULL,NULL,0);

#
# Structure for table "user"
#

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL auto_increment COMMENT '用户id,自动增长 PK',
  `keywords` varchar(20) NOT NULL default '' COMMENT '用户key值',
  `type` int(2) NOT NULL default '0' COMMENT '用户类型:0为默认 普通用户，1为管理员',
  PRIMARY KEY  (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

#
# Data for table "user"
#

INSERT INTO `user` VALUES (1,'aaa111',1),(5,'aaaab0838',0),(8,'aaaae1224',0),(9,'aaaaf5336',0),(14,'aaaaa4458',0),(15,'aaaaa0678',0),(16,'aaaaa0173',0);

#
# Structure for table "singlecount"
#

DROP TABLE IF EXISTS `singlecount`;
CREATE TABLE `singlecount` (
  `id` int(11) NOT NULL auto_increment,
  `value` int(2) NOT NULL default '0' COMMENT '投票给选手:0选手A的票，1选手B的票,',
  `nowSession` varchar(20) NOT NULL default '' COMMENT '当前场次：与userId形成联合主键，避免主键重复与保证单个用户只能投一票',
  `userId` int(11) NOT NULL default '0' COMMENT '用户id：user表中的userId对应',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `联合主键` (`nowSession`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `singlecount_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "singlecount"
#

INSERT INTO `singlecount` VALUES (1,0,'1001',5),(2,1,'1001',15),(3,0,'1001',16),(4,0,'1002',5);
