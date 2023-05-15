CREATE TABLE IF NOT EXISTS `player_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) NOT NULL,
  `location` varchar(30) NOT NULL,
  `credit` int(11) NOT NULL DEFAULT 0,
  `roomid` int(11) DEFAULT NULL,
  `active` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
