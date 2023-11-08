/*
 Navicat Premium Data Transfer

 Source Server         : Virtual Shiva
 Source Server Type    : MariaDB
 Source Server Version : 100519
 Source Host           : localhost:3306
 Source Schema         : sp_dw_1223

 Target Server Type    : MariaDB
 Target Server Version : 100519
 File Encoding         : 65001

 Date: 27/08/2023 21:10:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_commande
-- ----------------------------
DROP TABLE IF EXISTS `t_commande`;
CREATE TABLE `t_commande`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_creation` bigint(20) NULL DEFAULT NULL,
  `fk_user` int(11) NULL DEFAULT NULL,
  `fk_statut` int(11) NULL DEFAULT NULL,
  `n_commande` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_commande_produit
-- ----------------------------
DROP TABLE IF EXISTS `t_commande_produit`;
CREATE TABLE `t_commande_produit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_commande` int(11) NULL DEFAULT NULL,
  `fk_produit` int(11) NULL DEFAULT NULL,
  `qte` int(11) NULL DEFAULT NULL,
  `prixHT` decimal(10, 2) NULL DEFAULT NULL,
  `tva` decimal(10, 2) NULL DEFAULT NULL,
  `prixTTC` decimal(10, 2) NULL DEFAULT NULL,
  `reduction` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_interface
-- ----------------------------
DROP TABLE IF EXISTS `t_interface`;
CREATE TABLE `t_interface`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user` int(11) NULL DEFAULT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_langue
-- ----------------------------
DROP TABLE IF EXISTS `t_langue`;
CREATE TABLE `t_langue`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_langue
-- ----------------------------
INSERT INTO `t_langue` VALUES (1, 'Francais', 'fr.png');
INSERT INTO `t_langue` VALUES (2, 'Anglais', 'gb.png');

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ordre` int(11) NULL DEFAULT NULL,
  `fk_parent` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES (1, 'index.php?page=fo_home', 1, 0);
INSERT INTO `t_menu` VALUES (4, 'index.php?page=fo_galerie', 2, 0);

-- ----------------------------
-- Table structure for t_menu_trad
-- ----------------------------
DROP TABLE IF EXISTS `t_menu_trad`;
CREATE TABLE `t_menu_trad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_menu` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `libelle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_menu_trad
-- ----------------------------
INSERT INTO `t_menu_trad` VALUES (5, 2, 1, 'Mon Panier');
INSERT INTO `t_menu_trad` VALUES (6, 2, 2, 'Cart');
INSERT INTO `t_menu_trad` VALUES (7, 3, 1, 'Mon Compte');
INSERT INTO `t_menu_trad` VALUES (8, 3, 2, 'My Compte');
INSERT INTO `t_menu_trad` VALUES (9, 1, 1, 'Accueil');
INSERT INTO `t_menu_trad` VALUES (10, 1, 2, 'Home');
INSERT INTO `t_menu_trad` VALUES (11, 0, 1, 'Galerie');
INSERT INTO `t_menu_trad` VALUES (12, 0, 2, 'Photography');
INSERT INTO `t_menu_trad` VALUES (15, 4, 1, 'Galerie');
INSERT INTO `t_menu_trad` VALUES (16, 4, 2, 'Photography');

-- ----------------------------
-- Table structure for t_pays
-- ----------------------------
DROP TABLE IF EXISTS `t_pays`;
CREATE TABLE `t_pays`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_pays
-- ----------------------------
INSERT INTO `t_pays` VALUES (1, 'France');

-- ----------------------------
-- Table structure for t_photo
-- ----------------------------
DROP TABLE IF EXISTS `t_photo`;
CREATE TABLE `t_photo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photographie` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ordre` int(11) NULL DEFAULT NULL,
  `fk_user` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_photo
-- ----------------------------
INSERT INTO `t_photo` VALUES (1, 'img_64e5f25b44552.png', NULL, NULL, 1, 1);
INSERT INTO `t_photo` VALUES (2, 'img_64e5f90525f0d.jpg', NULL, NULL, 2, 1);

-- ----------------------------
-- Table structure for t_photo_trad
-- ----------------------------
DROP TABLE IF EXISTS `t_photo_trad`;
CREATE TABLE `t_photo_trad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_photo` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `titre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_photo_trad
-- ----------------------------
INSERT INTO `t_photo_trad` VALUES (7, 1, 1, 'Drone', 'Photo de Drone');
INSERT INTO `t_photo_trad` VALUES (8, 1, 2, 'Drone', 'Photo de Drone');
INSERT INTO `t_photo_trad` VALUES (9, 2, 1, 'sqdfds', 'sdfsdf');
INSERT INTO `t_photo_trad` VALUES (10, 2, 2, 'sdfsd', 'sdqfdsqf');

-- ----------------------------
-- Table structure for t_produit
-- ----------------------------
DROP TABLE IF EXISTS `t_produit`;
CREATE TABLE `t_produit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_tva` int(11) NULL DEFAULT NULL,
  `fk_promotion` int(11) NULL DEFAULT NULL,
  `fk_user` int(11) NULL DEFAULT NULL,
  `prixHT` decimal(10, 2) NULL DEFAULT NULL,
  `poids` decimal(10, 2) NULL DEFAULT NULL,
  `date_creation` bigint(20) NULL DEFAULT NULL,
  `date_modification` bigint(20) NULL DEFAULT NULL,
  `date_debut_promotion` bigint(20) NULL DEFAULT NULL,
  `date_fin_promotion` bigint(20) NULL DEFAULT NULL,
  `isActif` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_produit
-- ----------------------------
INSERT INTO `t_produit` VALUES (1, 1, 1, 1, 999.00, 1.20, 1691492969, 1692620128, 1690833600, 1693425600, 1);
INSERT INTO `t_produit` VALUES (2, 1, 1, 1, 25.00, 0.65, 1691493162, 1692620134, 0, 0, 1);
INSERT INTO `t_produit` VALUES (15, 1, 0, 1, 999.00, 0.80, 1691641644, 1692592238, 0, 0, 1);
INSERT INTO `t_produit` VALUES (21, 1, 0, 1, 1990.00, 2.30, 1692689333, 1692689333, 0, 0, 1);
INSERT INTO `t_produit` VALUES (22, 1, 0, 1, 1490.00, 2.00, 1692689668, 1692689725, 0, 0, 1);
INSERT INTO `t_produit` VALUES (23, 1, 0, 1, 1000.00, 0.00, 1692698847, 1692699301, 0, 0, 1);
INSERT INTO `t_produit` VALUES (24, 1, 0, 1, 1000.00, 0.00, 1692698869, 1692699317, 0, 0, 1);

-- ----------------------------
-- Table structure for t_produit_image
-- ----------------------------
DROP TABLE IF EXISTS `t_produit_image`;
CREATE TABLE `t_produit_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_produit` int(11) NULL DEFAULT NULL,
  `nom_fichier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_produit_image
-- ----------------------------
INSERT INTO `t_produit_image` VALUES (1, 1, 'img_64d2226915196.jpg');
INSERT INTO `t_produit_image` VALUES (2, 1, 'img_64d22269aeb49.jpg');
INSERT INTO `t_produit_image` VALUES (3, 1, 'img_64d22269b8d1c.jpg');
INSERT INTO `t_produit_image` VALUES (4, 2, 'img_64d2232a8e978.jpeg');
INSERT INTO `t_produit_image` VALUES (5, 2, 'img_64d2232b3495e.jpg');
INSERT INTO `t_produit_image` VALUES (6, 2, 'img_64d2232b3c57c.jpg');
INSERT INTO `t_produit_image` VALUES (7, 15, 'img_64d4672d41617.jpeg');
INSERT INTO `t_produit_image` VALUES (8, 15, 'img_64d4672d4960d.jpeg');
INSERT INTO `t_produit_image` VALUES (9, 15, 'img_64d4672d50022.jpeg');
INSERT INTO `t_produit_image` VALUES (10, 21, 'img_64e463b53a29b.jpg');
INSERT INTO `t_produit_image` VALUES (11, 21, 'img_64e463b5d5b15.png');
INSERT INTO `t_produit_image` VALUES (12, 22, 'img_64e465046d0f9.jpg');
INSERT INTO `t_produit_image` VALUES (13, 22, 'img_64e465051dad5.jpg');
INSERT INTO `t_produit_image` VALUES (14, 23, 'img_64e488dfc0a48.jpg');
INSERT INTO `t_produit_image` VALUES (15, 24, 'img_64e488f52423c.png');

-- ----------------------------
-- Table structure for t_produit_rayon
-- ----------------------------
DROP TABLE IF EXISTS `t_produit_rayon`;
CREATE TABLE `t_produit_rayon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_produit` int(11) NULL DEFAULT NULL,
  `fk_rayon` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_produit_rayon
-- ----------------------------
INSERT INTO `t_produit_rayon` VALUES (21, 15, 2);
INSERT INTO `t_produit_rayon` VALUES (22, 1, 2);
INSERT INTO `t_produit_rayon` VALUES (23, 2, 2);
INSERT INTO `t_produit_rayon` VALUES (24, 21, 1);
INSERT INTO `t_produit_rayon` VALUES (26, 22, 1);
INSERT INTO `t_produit_rayon` VALUES (31, 23, 1);
INSERT INTO `t_produit_rayon` VALUES (32, 24, 1);

-- ----------------------------
-- Table structure for t_produit_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_produit_stock`;
CREATE TABLE `t_produit_stock`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_produit` int(11) NULL DEFAULT NULL,
  `fk_stock` int(11) NULL DEFAULT NULL,
  `qte` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_produit_stock
-- ----------------------------
INSERT INTO `t_produit_stock` VALUES (17, 15, 1, 18);
INSERT INTO `t_produit_stock` VALUES (18, 1, 1, 9);
INSERT INTO `t_produit_stock` VALUES (19, 2, 1, 4);
INSERT INTO `t_produit_stock` VALUES (20, 21, 1, 10);
INSERT INTO `t_produit_stock` VALUES (22, 22, 1, 5);
INSERT INTO `t_produit_stock` VALUES (27, 23, 1, 10);
INSERT INTO `t_produit_stock` VALUES (28, 24, 1, 10);

-- ----------------------------
-- Table structure for t_produit_trad
-- ----------------------------
DROP TABLE IF EXISTS `t_produit_trad`;
CREATE TABLE `t_produit_trad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_produit` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `titre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description_courte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description_longue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_produit_trad
-- ----------------------------
INSERT INTO `t_produit_trad` VALUES (35, 15, 1, 'DJI FPV Combo', 'Le DJI FPV est un drone de type \"racer\", destiné à être piloté en immersion, c\'est à dire avec un masque FPV pour voir en temps réel ce que filme le drone et le piloter comme si l\'on se trouvait à l\'intérieur. Il est fourni avec un masque FPV, une radiocommande et une batterie.', 'Reprenant le principe de la transmission DJI FPV sortie en 2019, DJI propose ici un ensemble d\'accessoires conçu pour fonctionner en boucle fermée : un drone FPV, une radiocommande et un casque. \r\n\r\nLe drone DJI FPV repose sur un châssis 5 pouces de 795 grammes qui filme en 4K 60p (ou FullHD 120p) grâce à sa caméra stabilisée via RockSteady et montée sur une nacelle 1 axe. Facile à prendre en main, le drone DJI FPV dispose de trois modes de pilotage différents : mode N qui ressemble à un pilotage Mavic avec un twist FPV, mode M apparenté au mode Acro connu des pilotes aguerris et le mode S qui fait un pont entre les deux pour les aventuriers souhaitant pousser le pilotage au niveau supérieur.\r\n\r\nL\'immersion sera complète grâce au beau FOV de 150° de la caméra. Le retour vidéo et le pilotage se font dans le casque DJI FPV V2. L\'immersion est incomparable et avec très peu de latence (28 millisecondes). La radiocommande 2 DJI FPV reprend le form factor de vos manettes de consoles pour une ergonomie impeccable.\r\n\r\nPrésentation\r\nPressenti sur le segment des \"racers\" depuis l\'introduction en 2019 d\'un kit FPV System, DJI arrive finalement 2 ans plus tard avec sa propre vision du drone de course. Sobrement baptisée DJI FPV, sa dernière création ne renie pas ses origines et se place finalement à mi-chemin entre la caméra volante stabilisée (comme les Mavic) et le racer que l\'on pilote en immersion avec un masque en vue à la première personne (FPV pour First-Person View). Une vraie machine à sensations fortes qui fait le pari d\'arriver sous la forme d\'une solution prête à l\'emploi, comprenant le drone avec sa caméra 4K intégrée, sa radiocommande et son masque FPV compatible. Quitte à viser le haut de gamme avec un prix de lancement placé à 1349 €.\r\n\r\nPrise en main\r\nContrairement à ce que l\'on pouvait craindre à la découverte des premiers visuels, le DJI FPV est bien plus compact qu\'il n\'en a l\'air. Il est trapu, mais n\'occupe en fait pas beaucoup plus d\'espace que la plupart des drones de course (17,8 x 23,2 x 12,7 cm — 25,5 x 31,2 x 12,7 cm hélices comprises).');
INSERT INTO `t_produit_trad` VALUES (36, 15, 2, 'DJI FPV Combo', 'The DJI FPV is a \"racer\" type drone, intended to be piloted in immersion, i.e. with an FPV mask to see in real time what the drone is filming and pilot it as if we were in the air. inside. It is supplied with an FPV mask, a remote control and a battery.', 'Taking up the principle of the DJI FPV transmission released in 2019, DJI offers here a set of accessories designed to operate in a closed loop: an FPV drone, a radio control and a headset.\r\n\r\nThe DJI FPV drone is based on a 5-inch frame weighing 795 grams which films in 4K 60p (or FullHD 120p) thanks to its stabilized camera via RockSteady and mounted on a 1-axis gimbal. Easy to handle, the DJI FPV drone has three different piloting modes: N mode which resembles Mavic piloting with an FPV twist, M mode similar to the Acro mode known to experienced pilots and S mode which makes a bridge between both for adventurers looking to take piloting to the next level.\r\n\r\nImmersion will be complete thanks to the beautiful 150° FOV of the camera. Video feedback and piloting are done in the DJI FPV V2 headset. The immersion is incomparable and with very little latency (28 milliseconds). The DJI FPV 2 remote control uses the form factor of your console controllers for impeccable ergonomics.\r\n\r\nPresentation\r\nTipped into the \"racers\" segment since the introduction in 2019 of an FPV System kit, DJI finally arrives 2 years later with its own vision of the racing drone. Soberly baptized DJI FPV, its latest creation does not deny its origins and is finally placed halfway between the stabilized flying camera (like the Mavic) and the racer that we pilot in immersion with a mask in first person view. (FPV for First-Person View). A real thrill machine that bets on arriving in the form of a ready-to-use solution, including the drone with its integrated 4K camera, its radio control and its compatible FPV mask. Even if it means aiming for the top of the range with an introductory price placed at 1349 €.\r\n\r\nGetting started\r\nContrary to what one might have feared when discovering the first visuals, the DJI FPV is much more compact than it looks. It\'s chunky, but actually doesn\'t take up much more space than most racing drones (7\" x 9.25\" x 5\" — 10\" x 12.25\" x 5\" propellers included).');
INSERT INTO `t_produit_trad` VALUES (37, 1, 1, 'DJI Mavic 3 Pro', 'Le DJI Mavic 3T est un drone thermique compacte adapté pour les opérations de lutte contre les incendies, de recherche et sauvetage et d’inspection.', 'DJI Mavic 3T gamme Enterprise redéfinit les normes du secteur pour les petits drones commerciaux. Avec un obturateur mécanique, une caméra avec zoom 56x et un module RTK pour une précision au centimètre près, DJI Mavic 3 gamme Enterprise rehausse l’efficacité des missions. Une version thermique est disponible pour les opérations de lutte contre les incendies, de recherche et sauvetage, d’inspection et de nuit.\r\n\r\nÉpuré et compact, DJI Mavic 3 gamme Enterprise peut être transporté d’une seule main et déployé en un instant. Parfait pour les pilotes débutants comme pour les vétérans, il est conçu pour de longues missions.\r\n\r\nAgrandir pour découvrir\r\nMavic 3T est équipé d’une caméra avec zoom de 12 MP, prenant en charge jusqu’à 56x le zoom hybride max. pour voir les détails essentiels de loin.\r\n\r\nVoir l’invisible\r\nLa caméra thermique d’une définition de 640 x 512 de Mavic 3T gère la mesure de la température des points et des zones, les alertes de température élevée, les palettes de couleurs et les isothermes pour trouver vos cibles et prendre des décisions rapides.\r\n\r\nDJI Mavic 3T Zoom simultané sur écran partagé\r\nLes caméras thermiques et avec zoom de Mavic 3T prennent en charge le zoom côte à côte continu 28x pour faciliter les comparaisons.');
INSERT INTO `t_produit_trad` VALUES (38, 1, 2, 'DJI Mavic 3 Pro', 'The DJI Mavic 3T is a compact thermal drone suitable for firefighting, search and rescue and inspection operations.\r\n', 'DJI Mavic 3T Enterprise Series redefines industry standards for small commercial drones. With a mechanical shutter, 56x zoom camera, and RTK module for centimeter-level accuracy, DJI Mavic 3 Enterprise Series elevates mission efficiency. A thermal version is available for firefighting, search and rescue, inspection and night operations.\r\n\r\nSleek and compact, DJI Mavic 3 Enterprise Series can be carried with one hand and deployed in an instant. Perfect for new and veteran pilots alike, it\'s built for long missions.\r\n\r\nExpand to discover\r\nMavic 3T is equipped with a 12 MP zoom camera, supporting up to 56x max hybrid zoom. to see essential details from afar.\r\n\r\nSee the invisible\r\nThe Mavic 3T\'s 640 x 512 resolution thermal camera handles point and area temperature measurement, high temperature alerts, color palettes and isotherms to find your targets and make quick decisions.\r\n\r\nDJI Mavic 3T Split Screen Simultaneous Zoom\r\nMavic 3T thermal and zoom cameras support 28x continuous side-to-side zoom for easy comparisons.');
INSERT INTO `t_produit_trad` VALUES (39, 2, 1, 'DJI Mavic Air', 'Qu\'il paraît loin, le temps où DJI était un obscur constructeur de drones qui commençait à s\'aventurer dans le monde du cinéma et de la prise de vue aérienne ! Aujourd\'hui le géant de Shenzhen est numéro 1 sur un marché où la concurrence est rare, et ce n\'est pas le Mavic Air qui va modifier la tendance, bien au contraire.', 'Présentation\r\n\r\nEn janvier dernier, de notre première prise en main du Mavic Air dans le Sud de la France, nous avions tiré le constat que DJI avait fait d\'énormes progrès tant dans le style que la facilité d\'usage. Exit la silhouette un peu empâtée des Phantom 3 et 4 : depuis le Mavic Pro, DJI s\'appuie sur un \"bio design\" s\'inspirant de la nature et des insectes pour une meilleure aérodynamique. Le Mavic Air en est le fruit et l\'on trouve sur ce petit corps ramassé des appuis sustentateurs qui accroissent la stabilité et la fluidité de vol.\r\n\r\nAprès ce premier contact, nous sommes donc repartis affronter les rigueurs d\'un hiver bien trop long pour tester le quadricoptère en conditions réelles, à la campagne puis au bord de l\'eau, et enfin vous livrer notre verdict. Pas de suspense inutile : le Mavic Air est tout simplement bluffant, et sur bien des aspects. La preuve dans ce test.\r\n\r\nPrise en main\r\n\r\nCommençons donc avec ce dessin retravaillé et sa compacité. DJI poursuit sa quête de \"transportabilité\" et offre au Mavic Air la possibilité de replier ses quatre bras pour se glisser partout. Encore plus petit que le Mavic Pro avec 168 x 83 x 49 mm replié contre 198 x 83 x 83 (L×l×H), le Mavic Air se range dans n\'importe quel sac ou grande poche de veste. Pour vous donner un ordre d\'idée, si nous comparons le Mavic Pro à un reflex sans objectif, le Mavic Air a quant à lui l\'encombrement d\'un hybride. Même constat pour la radiocommande, minuscule, dont nous apprécions les joysticks amovibles qui facilitent encore le transport.\r\n\r\nVol\r\n\r\nLe Mavic Air répond à la même procédure de mise en route que les autres membres de sa famille. On allume d\'abord la radiocommande, on déplie le drone comme un robot, on active la mise sous tension par un double clic sur le bouton de la batterie, puis on enfiche son smartphone dans le corps de la radiocommande. L\'application DJI Go 4, inchangée, offre toujours des menus exhaustifs et complets qui satisferont l\'amateur avancé mais risquent de perdre les débutants. Compte tenu de la volonté de DJI de cibler un très large public, il aurait peut-être été préférable d\'opérer par paliers, en proposant une première approche en automatisation complète, puis un déverrouillage des fonctions au fil de l\'apprentissage. En outre, les messages et autres pop-up nécessaires à la prévention, bien qu\'utiles, finissent par irriter par leur prégnance.\r\n');
INSERT INTO `t_produit_trad` VALUES (40, 2, 2, 'DJI Mavic Air', 'It seems a long time ago when DJI was an obscure drone manufacturer who was beginning to venture into the world of cinema and aerial photography! Today the Shenzhen giant is number 1 in a market where competition is rare, and it is not the Mavic Air that will change the trend, quite the contrary.', 'Presentation\r\n\r\nLast January, from our first handling of the Mavic Air in the South of France, we learned that DJI had made enormous progress both in style and ease of use. Exit the somewhat thick silhouette of the Phantom 3 and 4: since the Mavic Pro, DJI has relied on a \"bio design\" inspired by nature and insects for better aerodynamics. The Mavic Air is the fruit of this and we find on this small compact body lift supports which increase stability and fluidity of flight.\r\n\r\nAfter this first contact, we therefore left to face the rigors of a far too long winter to test the quadricopter in real conditions, in the countryside then at the water\'s edge, and finally to give you our verdict. No unnecessary suspense: the Mavic Air is simply stunning, and in many ways. The proof in this test.\r\n\r\nGetting started\r\n\r\nSo let\'s start with this reworked design and its compactness. DJI continues its quest for \"transportability\" and offers the Mavic Air the possibility of folding its four arms to slip everywhere. Even smaller than the Mavic Pro at 168 x 83 x 49mm folded up compared to 198 x 83 x 83 (L×W×H), the Mavic Air fits in any bag or large jacket pocket. To give you an idea, if we compare the Mavic Pro to a DSLR without a lens, the Mavic Air has the size of a hybrid. Same observation for the radio control, tiny, of which we appreciate the removable joysticks which make transport even easier.\r\n\r\nFlight\r\n\r\nThe Mavic Air responds to the same start-up procedure as the other members of its family. First turn on the remote control, unfold the drone like a robot, activate the power-on by double-clicking the battery button, then plug your smartphone into the body of the remote control. The unchanged DJI Go 4 app still offers extensive and comprehensive menus that will satisfy the advanced hobbyist but risk losing beginners. Given DJI\'s desire to target a very wide audience, it might have been preferable to operate in stages, by offering a first approach in complete automation, then unlocking the functions as you learn. In addition, messages and other pop-ups necessary for prevention, although useful, end up irritating by their significance.');
INSERT INTO `t_produit_trad` VALUES (41, 21, 1, 'Alienware M16', 'L’Alienware M16 est le PC portable gaming grand format du fabricant étasunien. Avec sa dalle de 16 pouces et son processeur AMD Ryzen HX, il compte sur sa GeForce RTX 4070 pour venir à bout des jeux vidéo les plus récents.', 'Inutile de présenter Alienware, la marque à l’extraterrestre présente sur le marché des PC depuis près de 17 ans. La filiale dédiée au gaming de Dell propose des PC à demeure et portables conçus pour les jeux vidéo, avec évidemment à chaque fois des composants à la pointe et un marketing savamment orchestré.\r\n\r\nL’Alienware M16 est le PC portable grand format du fabricant. Il embarque une dalle de 16 pouces et peut être équipé d\'un processeur Intel ou AMD, le tout accompagné de la carte graphique Nvidia GeForce RTX 40. Le M16 mis à notre disposition par Alienware pour ce test est doté d’un processeur AMD Ryzen 9 7845HX et d’une Nvidia GeForce RTX 4070 à son plein potentiel.\r\n\r\nCette machine est vendue 2599 € sur le site du constructeur et d’autres options de personnalisation sont disponibles, comme le clavier à switchs mécaniques Cherry.\r\n\r\nConstruction\r\nL’Alienware M16 dispose d’un châssis imposant qui mêle le plastique et l\'aluminium pour le capot. Son design est reconnaissable avec toujours cette tête d\'extraterrestre placée au milieu. Un énorme “16” embossé prend place dans le coin inférieur droit du capot et un filet rétroéclairé, synchronisé avec le logo, encercle les aérations arrière et la connectique.\r\n\r\nCapot ouvert, l’Alienware 16 révèle son clavier rétroéclairé dépourvu de pavé numérique. La frappe est agréable et le rétroéclairage RGB personnalisable grâce au logiciel Command Center du fabricant. Le pavé tactile est placé au bord du châssis. Si les clics et la glisse sont corrects, sa taille réduite n’invite pas à son utilisation et le branchement d’une souris se fera vite pressant. La cause de ce “manque” d’espace se trouve au-dessus du clavier où l\'on identifie d’énormes aérations chargées de maintenir les composants au frais. Le placement inversé de la carte mère joue aussi, nous y reviendrons un peu plus loin.\r\n\r\nLa connectique est répartie sur la tranche arrière. On dénombre deux ports USB-C (un qui prend en charge le DisplayPort et le second l\'USB 3.3 Gen1), un port USB-A (lui aussi à 5 Gb/s), un port HDMI 2.1, un antique port Mini DisplayPort, un lecteur de cartes SD et enfin le port de charge. Cette connectique est complétée par un port RJ45 2,5 Gb/s, un port USB 5 Gb/s et une prise jack sur le côté gauche.\r\n\r\nUne fois n’est pas coutume, la connectivité wifi est assurée par une puce Qualcomm compatible wifi 6E et Bluetooth 5.3. Enfin, la webcam profite d’un capteur 1080p compatible Windows Hello, à défaut d\'un lecteur d’empreintes digitales. La qualité de l’image est correcte, sans toutefois se démarquer du tout-venant.');
INSERT INTO `t_produit_trad` VALUES (42, 21, 2, 'Alienware M16', 'The Alienware M16 is the large-format gaming laptop from the American manufacturer. With its 16-inch panel and its AMD Ryzen HX processor, it relies on its GeForce RTX 4070 to overcome the most recent video games.', 'No need to introduce Alienware, the extraterrestrial brand present on the PC market for almost 17 years. Dell\'s dedicated gaming subsidiary offers home PCs and laptops designed for video games, obviously each time with state-of-the-art components and cleverly orchestrated marketing.\r\n\r\nThe Alienware M16 is the manufacturer\'s full-size laptop. It features a 16-inch panel and can be equipped with an Intel or AMD processor, all accompanied by the Nvidia GeForce RTX 40 graphics card. The M16 made available to us by Alienware for this test is equipped with an AMD Ryzen processor 9 7845HX and an Nvidia GeForce RTX 4070 to its full potential.\r\n\r\nThis machine is sold for €2,599 on the manufacturer\'s website and other customization options are available, such as the Cherry mechanical switch keyboard.\r\n\r\nConstruction\r\nThe Alienware M16 has an imposing chassis that combines plastic and aluminum for the cover. Its design is recognizable with always this extraterrestrial head placed in the middle. A huge embossed “16” takes place in the lower right corner of the bonnet and a backlit mesh, synchronized with the logo, encircles the rear air vents and connectors.\r\n\r\nCover open, the Alienware 16 reveals its backlit keyboard without a numeric keypad. Typing is pleasant and the RGB backlighting is customizable using the manufacturer\'s Command Center software. The touchpad is placed at the edge of the chassis. If the clicks and slides are correct, its small size does not invite its use and connecting a mouse will quickly become urgent. The cause of this \"lack\" of space is above the keyboard where we identify huge vents responsible for keeping the components cool. The reverse placement of the motherboard also plays a role, we will come back to this a little later.\r\n\r\nThe connectors are distributed on the rear edge. There are two USB-C ports (one that supports DisplayPort and the second USB 3.3 Gen1), a USB-A port (also at 5 Gb / s), an HDMI 2.1 port, an old Mini DisplayPort port , an SD card reader and finally the charging port. This connection is completed by a 2.5 Gb/s RJ45 port, a 5 Gb/s USB port and a jack on the left side.');
INSERT INTO `t_produit_trad` VALUES (45, 22, 1, 'Alienware M15', 'L\'Alienware m15 R2 veut réunir le gaming PC et la mobilité en conservant un grand niveau de performance. Au programme : écran OLED, Geforce RTX et SSD NVMe ! Voyons ça de plus près.', 'Design\r\nChez FrAndroid, on a encore beaucoup l’habitude de tester des ultraportables, alors le design de l’Alienware m15 R2 surprend forcément au déballage. On a là une machine costaude, assez épaisse avec de la connectique de chaque côté, même derrière l’écran. On retrouve la charnière typique de ce genre de machine, où le PC est en fait un peu plus profond que l’écran en dépassant à l’arrière.\r\n\r\nSur son site, Dell met surtout en avant le design intérieur de la machine conçu pour intégrer des composants performants avec le meilleur refroidissement possible — on verra cela plus tard. Surtout, on comprend pourquoi la marque évite de trop discuter du design extérieur : on est loin du niveau de finition proposé sur les gammes d’ultraportables. Point ici de matières noble comme l’aluminium ou de la fibre de carbone, place au plastique sous différentes formes.\r\n\r\nAutant le plastique effet gomme utilisé autour du clavier est plutôt réussi, autant le plastique brillant utilisé pour le cadre de l’écran est beaucoup moins convaincant, d’autant que sur notre exemplaire de test, il y avait un léger défaut en haut de l’écran avec un jeu entre le cadre et la dalle.\r\n\r\nPlongez l’ordinateur dans le noir, et il vous éclairera la pièce avec les lumières intégrées un peu partout : sur le logo de la marque, autour de l’alimentation, sur le clavier ou encore à l’arrière du PC.\r\n\r\nClavier et touchpad\r\nMachine de jeu oblige, l’Alienware m15 intègre un clavier rétroéclairé avec des lumières RGB qu’il sera possible de configurer avec un logiciel. Si l’éclairage ne vous plait pas, un raccourci permet de le désactiver en un clic. Il s’agit d’un clavier assez classique pour un PC portable, avec malheureusement des touches assez resserrées malgré un large espace laissé à gauche et à droite. La frappe est un peu molle, ce qui pourrait déplaire à certaines personnes en jeu, mais dans l’ensemble le clavier est réussi.\r\n\r\nPour une machine avec un écran de 15 pouces, le touchpad est également assez petit. On peut voir que la ventilation de la machine prend en fait la place qu’auraient pu occuper le clavier et le touchpad. On paye en partie le choix d’une machine performante ici. La surface du touchpad est en tout cas très agréable, avec un effet verre très réussi. J’ai trouvé le touchpad particulièrement réactif.\r\n\r\nConnectique\r\nSur une machine aussi imposante, on a de la place pour y mettre beaucoup de connecteurs et Alienware a fait parfaitement le job de ce côté. On a d’abord 3 ports USB au format classique (Type-A) et un port RJ45 Ethernet qui réjouira les joueuses et joueurs.\r\n');
INSERT INTO `t_produit_trad` VALUES (46, 22, 2, 'Alienware M15', 'The Alienware m15 R2 wants to combine PC gaming and mobility while maintaining a high level of performance. On the program: OLED screen, Geforce RTX and NVMe SSD! Let\'s take a closer look.', 'Design\r\nAt FrAndroid, we are still very used to testing ultraportables, so the design of the Alienware m15 R2 is necessarily surprising when unpacking. We have a sturdy machine, quite thick with connectors on each side, even behind the screen. We find the typical hinge of this kind of machine, where the PC is in fact a little deeper than the screen by protruding at the back.\r\n\r\nOn its site, Dell mainly highlights the interior design of the machine designed to integrate high-performance components with the best possible cooling – we will see that later. Above all, we understand why the brand avoids discussing the exterior design too much: we are far from the level of finish offered on the ranges of ultraportables. No noble materials here such as aluminum or carbon fiber, instead plastic in different forms.\r\n\r\nAs much as the rubber effect plastic used around the keyboard is rather successful, the shiny plastic used for the frame of the screen is much less convincing, especially since on our test copy, there was a slight defect at the top of the screen. screen with a gap between the frame and the slab.\r\n\r\nImmerse the computer in the dark, and it will light up the room for you with the lights integrated everywhere: on the brand logo, around the power supply, on the keyboard or even on the back of the PC.\r\n\r\nKeyboard and touchpad\r\nGaming machine requires, the Alienware m15 incorporates a backlit keyboard with RGB lights that can be configured with software. If you don\'t like the lighting, a shortcut allows you to deactivate it in one click. This is a fairly standard keyboard for a laptop, unfortunately with fairly tight keys despite a large space left on the left and right. The typing is a little soft, which might displease some people in game, but overall the keyboard is successful.\r\n\r\nFor a machine with a 15-inch screen, the touchpad is also quite small. We can see that the ventilation of the machine actually takes up the space that the keyboard and touchpad could have occupied. We partly pay for the choice of a high-performance machine here. The surface of the touchpad is in any case very pleasant, with a very successful glass effect. I found the touchpad particularly responsive.');
INSERT INTO `t_produit_trad` VALUES (55, 23, 1, 'Alienware M12', 'sd', 'sd');
INSERT INTO `t_produit_trad` VALUES (56, 23, 2, 'Alienware M12', 'sd', 'sd');
INSERT INTO `t_produit_trad` VALUES (57, 24, 1, 'Alienware m11', 'fgh', 'thgfd');
INSERT INTO `t_produit_trad` VALUES (58, 24, 2, 'sfghd', 'fddsg', 'hdhghf');

-- ----------------------------
-- Table structure for t_promotion
-- ----------------------------
DROP TABLE IF EXISTS `t_promotion`;
CREATE TABLE `t_promotion`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reduction` decimal(10, 2) NULL DEFAULT NULL,
  `isActif` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_promotion
-- ----------------------------
INSERT INTO `t_promotion` VALUES (1, 20.00, 1);
INSERT INTO `t_promotion` VALUES (2, 10.00, 1);

-- ----------------------------
-- Table structure for t_promotion_trad
-- ----------------------------
DROP TABLE IF EXISTS `t_promotion_trad`;
CREATE TABLE `t_promotion_trad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_promotion` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_promotion_trad
-- ----------------------------
INSERT INTO `t_promotion_trad` VALUES (3, 2, 1, 'SOLDE_HIVER_20232');
INSERT INTO `t_promotion_trad` VALUES (4, 2, 2, 'SALES_WINTER_2023');
INSERT INTO `t_promotion_trad` VALUES (5, 1, 1, 'SOLDE_ETE_2023');
INSERT INTO `t_promotion_trad` VALUES (6, 1, 2, 'SALES_SUMMER_2023');

-- ----------------------------
-- Table structure for t_rayon
-- ----------------------------
DROP TABLE IF EXISTS `t_rayon`;
CREATE TABLE `t_rayon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isActif` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_rayon
-- ----------------------------
INSERT INTO `t_rayon` VALUES (1, 1);
INSERT INTO `t_rayon` VALUES (2, 1);

-- ----------------------------
-- Table structure for t_rayon_trad
-- ----------------------------
DROP TABLE IF EXISTS `t_rayon_trad`;
CREATE TABLE `t_rayon_trad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_rayon` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_rayon_trad
-- ----------------------------
INSERT INTO `t_rayon_trad` VALUES (1, 1, 1, 'Informatique');
INSERT INTO `t_rayon_trad` VALUES (2, 1, 2, 'Computer');
INSERT INTO `t_rayon_trad` VALUES (3, 2, 1, 'Drones');
INSERT INTO `t_rayon_trad` VALUES (4, 2, 2, 'Drones');

-- ----------------------------
-- Table structure for t_statut_commande
-- ----------------------------
DROP TABLE IF EXISTS `t_statut_commande`;
CREATE TABLE `t_statut_commande`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isActif` tinyint(4) NULL DEFAULT NULL,
  `isStock` tinyint(4) NULL DEFAULT NULL,
  `isBlock` tinyint(4) NULL DEFAULT NULL,
  `isDefault` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_statut_commande
-- ----------------------------
INSERT INTO `t_statut_commande` VALUES (1, 1, 0, 0, 1);
INSERT INTO `t_statut_commande` VALUES (2, 1, 0, 0, 0);
INSERT INTO `t_statut_commande` VALUES (3, 1, 1, 0, 0);
INSERT INTO `t_statut_commande` VALUES (4, 1, 0, 1, 0);
INSERT INTO `t_statut_commande` VALUES (5, 1, 0, 1, 0);

-- ----------------------------
-- Table structure for t_statut_commande_trad
-- ----------------------------
DROP TABLE IF EXISTS `t_statut_commande_trad`;
CREATE TABLE `t_statut_commande_trad`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_statut_commande` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_statut_commande_trad
-- ----------------------------
INSERT INTO `t_statut_commande_trad` VALUES (1, 1, 1, 'En cours');
INSERT INTO `t_statut_commande_trad` VALUES (2, 1, 2, 'In progress');
INSERT INTO `t_statut_commande_trad` VALUES (3, 2, 1, 'En attente de Paiement');
INSERT INTO `t_statut_commande_trad` VALUES (4, 2, 2, ' Waiting for payment');
INSERT INTO `t_statut_commande_trad` VALUES (5, 3, 1, 'Payée');
INSERT INTO `t_statut_commande_trad` VALUES (6, 3, 2, ' Paid');
INSERT INTO `t_statut_commande_trad` VALUES (7, 4, 1, 'Expédiée');
INSERT INTO `t_statut_commande_trad` VALUES (8, 4, 2, ' Shipped');
INSERT INTO `t_statut_commande_trad` VALUES (9, 5, 1, 'Annulée');
INSERT INTO `t_statut_commande_trad` VALUES (10, 5, 2, 'Canceled');

-- ----------------------------
-- Table structure for t_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_stock`;
CREATE TABLE `t_stock`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `isActif` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_stock
-- ----------------------------
INSERT INTO `t_stock` VALUES (1, 'Saint Pierre', 1);
INSERT INTO `t_stock` VALUES (2, 'Saint Denis', 1);

-- ----------------------------
-- Table structure for t_tva
-- ----------------------------
DROP TABLE IF EXISTS `t_tva`;
CREATE TABLE `t_tva`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_tva` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tva
-- ----------------------------
INSERT INTO `t_tva` VALUES (1, 'TVA_20', 20.00);
INSERT INTO `t_tva` VALUES (2, 'TVA_10', 10.00);
INSERT INTO `t_tva` VALUES (3, 'TVA_5', 5.50);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `prenom` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `adresse_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `adresse_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cp` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fk_ville` int(11) NULL DEFAULT NULL,
  `fk_pays` int(11) NULL DEFAULT NULL,
  `fk_langue` int(11) NULL DEFAULT NULL,
  `login` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `session` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `isAdmin` tinyint(4) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'Back Office', 'Administrateur', 'Adresse 1', 'Adresse 2', '97423', 1, 1, 1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'img_64cbdd8835167.png', NULL, 1);

-- ----------------------------
-- Table structure for t_ville
-- ----------------------------
DROP TABLE IF EXISTS `t_ville`;
CREATE TABLE `t_ville`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_ville
-- ----------------------------
INSERT INTO `t_ville` VALUES (1, 'Saint Pierre');

SET FOREIGN_KEY_CHECKS = 1;
