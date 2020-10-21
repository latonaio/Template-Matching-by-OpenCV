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
INSERT INTO Vehicle.vehicle (id, vehicle_name) VALUES (6, 'CAR_END');


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
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302113413545.jpg', 159, 201, 249, 322, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302113413745.jpg', 480, 450, 609, 563, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114902313.jpg', 313, 213, 730, 314, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302113413945.jpg', 388, 61, 428, 261, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302113414149.jpg', 485, 124, 556, 271, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302113414645.jpg', 486, 193, 553, 291, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302113414845.jpg', 388, 66, 463, 238, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114905810.jpg', 365, 269, 453, 465, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114857713.jpg', 359, 250, 639, 346, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114910009.jpg', 395, 533, 613, 637, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114858813_2.jpg', 263, 282, 778, 393, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114901413_2.jpg', 775, 164, 839, 339, 0.1, 0.8),
(1, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS/trim_20200302114859813.jpg', 403, 401, 634, 452, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302113413545.jpg', 159, 201, 249, 322, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302113413745.jpg', 480, 450, 609, 563, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114303222.jpg', 325, 23, 403, 251, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114303721.jpg', 484, 195, 558, 337, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114902313.jpg', 313, 213, 730, 314, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302113414645.jpg', 486, 193, 553, 291, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302113414845.jpg', 388, 66, 463, 238, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114901413_2.jpg', 775, 164, 839, 339, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114857713.jpg', 359, 250, 639, 346, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114905810.jpg', 365, 269, 453, 465, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114910009.jpg', 395, 533, 613, 637, 0.1, 0.8),
(2, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/IS_4WD/trim_20200302114858813_2.jpg', 263, 282, 778, 393, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114014329.jpg', 412, 343, 544, 501, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114015033.jpg', 476, 61, 584, 313, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114015134.jpg', 487, 59, 573, 333, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114015629.jpg', 124, 251, 206, 357, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114016529.jpg', 442, 84, 579, 180, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114017629.jpg', 363, 180, 641, 291, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114017930.jpg', 465, 16, 589, 115, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114019533.jpg', 372, 296, 454, 363, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114019633.jpg', 580, 312, 658, 376, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114024933.jpg', 431, 195, 569, 230, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114025133.jpg', 456, 117, 576, 212, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114025829.jpg', 766, 163, 808, 377, 0.1, 0.8),
(3, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/LS/trim_20200302114027829.jpg', 353, 193, 678, 244, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113116249.jpg', 356, 213, 480, 315, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113117649.jpg', 633, 171, 733, 349, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113118853.jpg', 424, 403, 602, 480, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113119749.jpg', 404, 384, 599, 477, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113120254.jpg', 647, 310, 863, 403, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113120850.jpg', 441, 159, 588, 342, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113122054.jpg', 669, 417, 748, 513, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113123354.jpg', 375, 416, 631, 458, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113125154.jpg', 284, 412, 746, 521, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113128150.jpg', 555, 405, 653, 486, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113129555.jpg', 629, 405, 760, 519, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113130649.jpg', 581, 432, 750, 494, 0.1, 0.8),
(4, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/NX/trim_20200302113133353.jpg', 475, 561, 536, 629, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120235881.jpg', 357, 291, 482, 382, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120236781.jpg', 752, 191, 842, 242, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120237985.jpg', 271, 327, 341, 533, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120238786.jpg', 646, 290, 777, 441, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120239285.jpg', 630, 181, 762, 281, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120239785.jpg', 548, 137, 723, 228, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120240485.jpg', 305, 178, 711, 245, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120243089.jpg', 400, 259, 637, 374, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120244585_2.jpg', 670, 347, 776, 375, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120247586.jpg', 658, 340, 757, 449, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120248381.jpg', 795, 336, 827, 603, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120248681.jpg', 293, 362, 471, 433, 0.1, 0.8),
(5, 0, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/HV/trim_20200302120249881.jpg', 488, 354, 546, 411, 0.1, 0.8),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302113427842.jpg', 226, 503, 795, 590, 0.1, 0.7),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302114031829.jpg', 352, 488, 666, 607, 0.1, 0.7),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302114632917.jpg', 286, 491, 751, 569, 0.1, 0.7),
(6, 1, '/var/lib/aion/Data/template-matching-set-templates_1/Annotations/CAR_END/trim2_20200302115501197.jpg', 234, 417, 800, 523, 0.1, 0.7);