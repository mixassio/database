
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customer_id` INT NOT NULL COMMENT 'Unique identification of customers, auto-generate.',
  `first_name` VARCHAR(255) NULL COMMENT 'First name of customer.',
  `second_name` VARCHAR(255) NULL COMMENT 'Second name of customer.',
  `birth_date` DATETIME NULL COMMENT 'Date of birthday',
  `marital_status` VARCHAR(45) NULL COMMENT 'Status',
  `gender` ENUM('male', 'female') NULL COMMENT 'Enum type, has MALE, FEMALE',
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The table contains customer data\n';

CREATE INDEX `full_name_idx` ON `mydb`.`customers` (`first_name` ASC, `second_name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`countries` ;

CREATE TABLE IF NOT EXISTS `mydb`.`countries` (
  `country_id` VARCHAR(2) NOT NULL COMMENT 'Auto generate identification.',
  `country_name` VARCHAR(45) NULL COMMENT 'Title of country',
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;

CREATE INDEX `country_name_idx` ON `mydb`.`countries` (`country_name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`regions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`regions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`regions` (
  `region_id` INT NOT NULL COMMENT 'auto generate identification',
  `region_name` VARCHAR(45) NULL COMMENT 'Title of region',
  `country_id` VARCHAR(2) NOT NULL COMMENT 'Foreign key to country',
  PRIMARY KEY (`region_id`, `country_id`))
ENGINE = InnoDB
COMMENT = 'the table contains regions data';

CREATE INDEX `region_name_idx` ON `mydb`.`regions` (`region_name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cities` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cities` (
  `city_id` INT NOT NULL COMMENT 'Auto generate identification.',
  `city_name` VARCHAR(45) NULL COMMENT 'title of City',
  `region_id` INT NULL COMMENT 'Foreign key to region.',
  `country_id` VARCHAR(2) NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
COMMENT = 'the table contains cities data';

CREATE INDEX `city_idx` ON `mydb`.`cities` (`city_name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`streets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`streets` ;

CREATE TABLE IF NOT EXISTS `mydb`.`streets` (
  `street_id` INT NOT NULL COMMENT 'Auto generate identification.',
  `street_name` VARCHAR(45) NULL COMMENT 'Title of street.',
  `city_id` INT NOT NULL COMMENT 'Foreign key to city',
  PRIMARY KEY (`street_id`))
ENGINE = InnoDB
COMMENT = 'the table contains address data';

CREATE INDEX `street_name_idx` ON `mydb`.`streets` (`street_name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`appeal_lang`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`appeal_lang` ;

CREATE TABLE IF NOT EXISTS `mydb`.`appeal_lang` (
  `appeal_lang_id` INT NOT NULL COMMENT 'Auto generate identification.',
  `appeal_lang` VARCHAR(45) NULL COMMENT 'Title language appeal to person, RU, EN, etc.',
  PRIMARY KEY (`appeal_lang_id`))
ENGINE = InnoDB
COMMENT = 'The table contains language of appeal to person.';


-- -----------------------------------------------------
-- Table `mydb`.`appeal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`appeal` ;

CREATE TABLE IF NOT EXISTS `mydb`.`appeal` (
  `appeal_id` INT NOT NULL COMMENT 'Auto generate identification.',
  `appeal` VARCHAR(45) NULL COMMENT 'Appeal to person, append of language, Mister, Madam, etc.',
  `appeal_lang_id` INT NULL COMMENT 'Foreign key for language of appeal.',
  PRIMARY KEY (`appeal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`categories` ;

CREATE TABLE IF NOT EXISTS `mydb`.`categories` (
  `category_id` INT NOT NULL COMMENT 'Auto generate identification.',
  `category_name` VARCHAR(45) NULL COMMENT 'Title of category',
  `parent_id` INT NULL COMMENT 'Parent category - recursive relationship.',
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
COMMENT = 'Table of category data, could has parent category - recursive relationship.';


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`products` ;

CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `products_id` INT NOT NULL COMMENT 'Auto generate identification.',
  `category_id` INT NULL COMMENT 'foreign key to category',
  `created_at` DATETIME NULL COMMENT 'Date and time created product.',
  `product` VARCHAR(45) NULL,
  PRIMARY KEY (`products_id`))
ENGINE = InnoDB
COMMENT = 'The table contains products data';

CREATE INDEX `product_idx` ON `mydb`.`products` (`product` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`manufactures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`manufactures` ;

CREATE TABLE IF NOT EXISTS `mydb`.`manufactures` (
  `manufacturer_id` INT NOT NULL COMMENT 'Auto generate identifikator',
  `manufacturer_title` VARCHAR(255) NULL COMMENT 'Title of manufacture.',
  `address_id` INT NULL COMMENT 'Foreign key to street',
  PRIMARY KEY (`manufacturer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category_params`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category_params` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category_params` (
  `param_id` INT NOT NULL COMMENT 'Auto generate identification',
  `param_name` VARCHAR(45) NULL,
  `param_type` VARCHAR(45) NULL,
  `default_value` VARCHAR(45) NULL,
  PRIMARY KEY (`param_id`))
ENGINE = InnoDB
COMMENT = 'Table of params. Which param dependencies from category.';


-- -----------------------------------------------------
-- Table `mydb`.`cross_category_params`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cross_category_params` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cross_category_params` (
  `category_params_param_id` INT NOT NULL,
  `categories_category_id` INT NOT NULL COMMENT 'Cross-table for relationship between params and category.',
  PRIMARY KEY (`category_params_param_id`, `categories_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_params`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`product_params` ;

CREATE TABLE IF NOT EXISTS `mydb`.`product_params` (
  `product_params_id` INT NOT NULL,
  `product_id` INT NULL,
  `param_id` INT NULL,
  `value` VARCHAR(45) NULL,
  PRIMARY KEY (`product_params_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`currencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`currencies` ;

CREATE TABLE IF NOT EXISTS `mydb`.`currencies` (
  `currency_id` INT NOT NULL,
  `currency_code` VARCHAR(45) NULL,
  `currency_name` VARCHAR(45) NULL,
  PRIMARY KEY (`currency_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`prices` ;

CREATE TABLE IF NOT EXISTS `mydb`.`prices` (
  `price_id` INT NOT NULL,
  `price` INT NULL DEFAULT 0 CHECK(price >= 0),
  `currency_id` INT NULL,
  `product_id` INT NULL,
  `created_at` DATETIME NULL,
  `type_price` ENUM('purchase', 'sale') NULL,
  PRIMARY KEY (`price_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sales` ;

CREATE TABLE IF NOT EXISTS `mydb`.`sales` (
  `sale_id` INT NOT NULL,
  `customer_id` INT NULL,
  `product_id` INT NULL,
  `count` INT NULL,
  `price_id` INT NULL,
  `created_at` DATETIME NULL,
  `address_id` INT NULL,
  `appeal_lang_id` INT NULL,
  `building_number` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  PRIMARY KEY (`sale_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manufactures_has_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`manufactures_has_products` ;

CREATE TABLE IF NOT EXISTS `mydb`.`manufactures_has_products` (
  `manufactures_manufacturer_id` INT NOT NULL,
  `products_products_id` INT NOT NULL,
  PRIMARY KEY (`manufactures_manufacturer_id`, `products_products_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`providers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`providers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`providers` (
  `provider_id` INT NOT NULL,
  `provider_name` VARCHAR(45) NULL,
  PRIMARY KEY (`provider_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`stock` ;

CREATE TABLE IF NOT EXISTS `mydb`.`stock` (
  `product_id` INT NOT NULL,
  `manufacturer_id` INT NOT NULL,
  `count` INT NULL DEFAULT 0 CHECK(count >=0),
  `provider_id` INT NULL,
  `price_id` INT NULL,
  PRIMARY KEY (`product_id`, `manufacturer_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Data for table `mydb`.`countries`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('IT', 'Italy');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('GB', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('DE', 'Denmark');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('PL', 'Poland');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('BE', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('NO', 'Norwey');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('IE', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('FR', 'France');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('NL', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('CZ', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('CH', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('ES', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('SE', 'Sweden');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('HU', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('FI', 'Finland');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('UA', 'Ukraine');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('RO', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('PT', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('SK', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('DK', '');
INSERT INTO `mydb`.`countries` (`country_id`, `country_name`) VALUES ('AT', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`regions`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (1, 'East sussex', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (2, 'Ancona', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (3, 'Cornwall', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (4, 'Surrey', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (5, 'Offaly', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (6, 'Utrecht', 'NL');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (7, 'Piacenza', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (8, 'West midlands', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (9, 'Clwyd', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (10, 'Hampshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (11, 'Varese', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (12, 'Donegal', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (13, 'Lecce', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (14, 'Reggio calabria', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (15, 'Limerick', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (16, 'Vmm - no state', 'HU');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (17, 'Pavia', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (18, 'Kent', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (19, 'Staffordshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (20, 'Bergamo', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (21, 'Brescia', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (22, 'Transportzone 1', 'BE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (23, 'Milan', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (24, 'Cork', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (25, 'Hertfordshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (26, 'Ayrshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (27, 'Essex', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (28, 'Warwickshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (29, 'Lincolnshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (30, 'Galway', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (31, 'Fife', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (32, 'North yorkshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (33, 'Bologna', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (34, 'Berkshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (35, 'Gwynedd', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (36, 'South yorkshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (37, 'Viterbo', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (38, 'Cambridgeshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (39, 'Novara', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (40, 'County tyrone', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (41, 'Trier', 'DE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (42, 'Vicenza', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (43, 'Monza e brianza', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (44, 'Norfolk', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (45, 'Morayshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (46, 'Dublin', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (47, 'Mantova', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (48, 'West sussex', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (49, 'Shropshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (50, 'Dyfed', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (51, 'Cluj', 'RO');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (52, 'Cosenza', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (53, 'Northamptonshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (54, 'South glamorgan', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (55, 'Naples', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (56, 'Latina', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (57, 'Verona', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (58, 'Turin', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (59, 'Palermo', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (60, 'Mikolaivska', 'UA');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (61, 'Derbyshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (62, 'Merseyside', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (63, 'Gloucestershire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (64, 'Florence', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (65, 'Donetska', 'UA');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (66, 'Pescara', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (67, 'Lancashire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (68, 'Genova', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (69, 'Cleveland', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (70, 'West yorkshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (71, 'Renfrewshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (72, 'Cheshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (73, 'Rome', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (74, 'Nottinghamshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (75, 'Venice', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (76, 'Devon', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (77, 'Dortmund', 'DE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (78, 'Suffolk', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (79, 'Dorset', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (80, 'Crotone', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (81, 'Arezzo', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (82, 'Powys', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (83, 'County down', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (84, 'Pordenone', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (85, 'Rimini', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (86, 'Cumbria', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (87, 'Iasi', 'RO');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (88, 'Wiltshire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (89, 'Savona', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (90, 'Perugia', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (91, 'Avon', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (92, 'Salerno', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (93, 'Longford', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (94, 'Wicklow', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (95, 'Catania', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (96, 'Waterford', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (97, 'Macerata', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (98, 'Somerset', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (99, 'Mid glamorgan', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (100, 'Padova', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (101, 'Kildare', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (102, 'Trento', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (103, 'Leicestershire', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (104, 'Caserta', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (105, 'Northumberland', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (106, 'County durham', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (107, 'Midlothian', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (108, 'Middlesex', 'GB');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (109, 'Cremona', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (110, 'Cuneo', 'IT');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (111, 'Louth', 'IE');
INSERT INTO `mydb`.`regions` (`region_id`, `region_name`, `country_id`) VALUES (112, 'County antrim', 'GB');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`cities`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (1, 'Moscow', 3, 'FI');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (2, 'Haywards heath', 4, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (3, 'Hirschberg an der bergstraße', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (4, 'Crowborough', 1, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (5, 'Beccles', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (6, 'Denny', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (7, 'Horfield', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (8, 'Newark', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (9, 'Montemarciano', 2, 'IT');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (10, 'Düsseldorf', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (11, 'York', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (12, 'Dresden', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (13, 'Szczecin', NULL, 'PL');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (14, 'Kiel', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (15, 'St leonards-on-sea', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (16, 'Bolton', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (17, 'Truro', 3, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (18, 'Ecaussinnes-lalaing', NULL, 'BE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (19, 'Wiesbaden', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (20, 'Skudeneshavn', NULL, 'NO');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (21, 'Dorking', 4, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (22, 'Hamburg', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (23, 'Preston', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (24, 'Wolverhampton', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (25, 'Czarne', NULL, 'PL');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (26, 'Birr', 5, 'IE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (27, 'Moyvillers', NULL, 'FR');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (28, 'Great harwood', NULL, 'GB');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (29, 'Esch/alzette', NULL, 'BE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (30, 'Limburg', NULL, 'DE');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (31, 'Mijdrecht', 6, 'NL');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (32, 'Osek', NULL, 'CZ');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (33, 'Podenzano', 7, 'IT');
INSERT INTO `mydb`.`cities` (`city_id`, `city_name`, `region_id`, `country_id`) VALUES (34, 'Flörsheim am main', NULL, 'DE');


COMMIT;
