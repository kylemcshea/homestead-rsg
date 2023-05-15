CREATE TABLE `player_weapons`
(
    `id` int NOT NULL AUTO_INCREMENT,
    `serial` varchar(16) NOT NULL,
    `citizenid` varchar(9) NOT NULL,
    `components` varchar(4096) NOT NULL DEFAULT '{}',
    PRIMARY KEY (`id`)
)
ENGINE=InnoDB;

-- Sample Data
INSERT INTO `player_weapons` (`id`, `serial`, `citizenid`, `components`) VALUES
(1, 'BM123456', '666', '[{\"label\":\"Medium Scope\",\"comp\":\"comp\",\"name\":-1844750633,\"type\":\"scope\",\"model\":2044211697},{\"label\":\"Improved Rifling\",\"comp\":\"comp\",\"name\":488786388,\"type\":\"rifling\",\"model\":0},{\"label\":\"Wrap\",\"comp\":\"comp\",\"name\":1419411400,\"type\":\"wrap\",\"model\":890000845},{\"label\":\"Gold\",\"model\":0,\"name\":681399557,\"comp\":\"barrel\"},{\"label\":\"Gold\",\"model\":0,\"name\":-1217972306,\"comp\":\"trigger\"},{\"label\":\"Gold\",\"model\":0,\"name\":-1217972306,\"comp\":\"trigger\"},{\"label\":\"Gold\",\"model\":0,\"name\":1906948138,\"comp\":\"frame\"},{\"label\":\"Gold\",\"model\":0,\"name\":-897983242,\"comp\":\"cylinder\"},{\"label\":\"Gold\",\"model\":0,\"name\":-897983242,\"comp\":\"cylinder\"},{\"label\":\"Bounty Hunter Grain\",\"model\":680020185,\"name\":1043980328,\"comp\":\"gripbody\"},{\"label\":\"Flying Eagle\",\"model\":0,\"name\":2110982730,\"comp\":\"grip\"},{\"label\":\"Art Nouveau\",\"comp\":\"decal\",\"name\":1338763465,\"type\":\"frame\",\"model\":0},{\"label\":\"Art Nouveau\",\"comp\":\"decal\",\"name\":-1719565838,\"type\":\"barrel\",\"model\":0},{\"label\":\"Blued Steel\",\"comp\":\"decalcolor\",\"name\":-1822969329,\"type\":\"frame\",\"model\":0},{\"label\":\"Blued Steel\",\"comp\":\"decalcolor\",\"name\":1585980544,\"type\":\"barrel\",\"model\":0},{\"label\":\"Gold\",\"model\":0,\"name\":-1021999895,\"comp\":\"scope\"},{\"label\":\"White\",\"model\":0,\"name\":1170373926,\"comp\":\"wrapcolor\"}]');