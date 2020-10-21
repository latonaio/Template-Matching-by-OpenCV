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
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113224110.jpg', 516, 374, 720, 503, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113228910.jpg', 394, 389, 614, 667, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200306113235410.jpg', 549, 383, 787, 489, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121752286.jpg', 568, 131, 662, 253, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121801486.jpg', 685, 235, 793, 465, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200306121806286.jpg', 352, 510, 648, 689, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306112939518.jpg', 474, 424, 631, 549, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306113643794.jpg', 425, 33, 635, 169, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200306114536870.jpg', 516, 557, 685, 612, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306121202502.jpg', 401, 372, 561, 676, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306121205002.jpg', 450, 488, 665, 583, 0.1, 0.8),
(7, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/RC/trim_20200306121205502.jpg', 423, 306, 674, 508, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/IS/trim_20200306115213554.jpg', 982, 377, 1168, 465, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/LS/trim_20200306121827386.jpg', 1121, 411, 1206, 515, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/NX/trim_20200306114037486.jpg', 1111, 210, 1254, 281, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/end/RC/trim_20200306115509946.jpg', 1014, 378, 1196, 453, 0.1, 0.8);
