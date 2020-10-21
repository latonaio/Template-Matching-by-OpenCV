/* MySQL User */
GRANT ALL ON *.* TO 'latona'@'%';

/* Database */
DROP DATABASE IF EXISTS Vehicle;
CREATE DATABASE Vehicle;


/* Vehicle.vehicle Table */
CREATE TABLE Vehicle.vehicle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_name VARCHAR(255)
);

INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (1, 'IS');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (3, 'LS');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (4, 'NX');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (6, 'END');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (7, 'RC');


/* Vehicle.vehicle Table */
CREATE TABLE Vehicle.template (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    is_car_end TINYINT NOT NULL DEFAULT 0,
    template_path VARCHAR(255) NOT NULL UNIQUE,
    `left` INT UNSIGNED NOT NULL,
    `top` INT UNSIGNED NOT NULL,
    `right` INT UNSIGNED NOT NULL,
    `bottom` INT UNSIGNED NOT NULL,
    trim_points_ratio FLOAT NOT NULL DEFAULT 0.1,
    pass_threshold FLOAT DEFAULT 0.8,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle.vehicle (id)
);

INSERT INTO Vehicle.template
(vehicle_id, is_car_end, template_path, `left`, `top`, `right`, `bottom`, trim_points_ratio, pass_threshold)
VALUES
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113209506.jpg', 566, 404, 737, 508, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113209806.jpg', 389, 437, 678, 539, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113214506.jpg', 291, 45, 343, 265, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113223110.jpg', 473, 296, 671, 383, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113223910.jpg', 501, 367, 640, 504, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113227610.jpg', 401, 363, 568, 489, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113230306.jpg', 456, 585, 614, 667, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113234910.jpg', 535, 381, 773, 659, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113256606.jpg', 1057, 294, 1121, 439, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113259006.jpg', 1103, 298, 1177, 427, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121744382.jpg', 544, 389, 814, 495, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121746686.jpg', 63, 43, 135, 267, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121757786.jpg', 443, 327, 655, 411, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121800386.jpg', 564, 273, 687, 463, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121801286.jpg', 377, 419, 706, 546, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121805886.jpg', 297, 272, 465, 321, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121805986.jpg', 336, 314, 586, 417, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121812286.jpg', 487, 507, 748, 682, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121826186.jpg', 667, 339, 739, 479, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121833086.jpg', 841, 459, 925, 592, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112913414.jpg', 276, 397, 503, 466, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112913914.jpg', 174, 471, 307, 699, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112916718.jpg', 650, 236, 739, 280, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112923214.jpg', 690, 379, 776, 691, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112926014.jpg', 259, 232, 467, 316, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112930814.jpg', 634, 43, 773, 145, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112930915.jpg', 498, 406, 711, 461, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112935118.jpg', 384, 551, 539, 616, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112946318.jpg', 621, 423, 764, 543, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112946418.jpg', 517, 277, 639, 415, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115357346.jpg', 312, 395, 507, 497, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115359247.jpg', 0, 44, 311, 188, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115404046.jpg', 94, 677, 353, 713, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115405746.jpg', 357, 386, 479, 603, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115408750.jpg', 641, 115, 697, 258, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115413150.jpg', 622, 157, 780, 247, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115416350.jpg', 449, 306, 596, 497, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115418750.jpg', 473, 577, 629, 662, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115425350.jpg', 573, 306, 673, 441, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306115435746.jpg', 758, 470, 794, 583, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/IS/trim_20200306115213554.jpg', 982, 377, 1168, 465, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/LS/trim_20200306121827386.jpg', 741, 467, 818, 592, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/NX/trim_20200306114037486.jpg', 1111, 210, 1254, 281, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/RC/trim_20200306115509946.jpg', 1014, 378, 1196, 453, 0.1, 0.8);
