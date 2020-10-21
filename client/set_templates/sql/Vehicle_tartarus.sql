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

INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (1, 'IS_2WD');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (2, 'IS_4WD');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (3, 'LS');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (4, 'NX_CONV');
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (5, 'NX_HV');


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
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_2WD/trim_20200302113414045.jpg', 285, 0, 527, 390, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_2WD/trim_20200302113414449.jpg', 286, 105, 721, 500, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_2WD/trim_20200302114855913.jpg', 290, 0, 531, 421, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114303521.jpg', 225, 0, 501, 441, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114303621.jpg', 227, 6, 528, 470, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_IS_4WD_2020-02-24_13-18-52_1_1.jpg', 315, 0, 569, 429, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114015730.jpg', 381, 135, 675, 582, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114027529.jpg', 357, 189, 679, 488, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114027929.jpg', 339, 314, 750, 559, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX_CONV/trim_20200302113735841.jpg', 277, 305, 725, 549, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX_CONV/trim_20200302115215509.jpg', 338, 393, 688, 714, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX_CONV/trim_NX_CONV_2020-02-24_13-12-02_2-2.jpg', 276, 217, 810, 464, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX_HV/trim_20200302120241289.jpg', 299, 30, 739, 349, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX_HV/trim_20200302120241489.jpg', 194, 207, 806, 479, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX_HV/trim_20200302120242189.jpg', 513, 343, 823, 697, 0.1, 0.8),
(1, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302113427842.jpg', 226, 503, 795, 590, 0.1, 0.8),
(1, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302114031829.jpg', 352, 488, 666, 607, 0.1, 0.8),
(1, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302114632917.jpg', 286, 491, 751, 569, 0.1, 0.8),
(1, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302115501197.jpg', 234, 417, 800, 523, 0.1, 0.8);