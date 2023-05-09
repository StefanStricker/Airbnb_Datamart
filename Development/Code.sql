-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Airbnb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Airbnb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET utf8mb3 ;
USE `Airbnb` ;

-- -----------------------------------------------------
-- Table `Airbnb`.`guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`guests` (
  `guest_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `profile_picture` TEXT NULL,
  `birthdate` DATE NULL,
  PRIMARY KEY (`guest_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`hosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`hosts` (
  `host_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `profile_picture` TEXT NULL,
  `bithdate` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`host_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`property_adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`property_adress` (
  `property_adress_id` INT NOT NULL AUTO_INCREMENT,
  `country_country_id` INT NOT NULL,
  `city_city_id` INT NOT NULL,
  `zip` INT NULL,
  `street` VARCHAR(80) NULL,
  `number` VARCHAR(12) NULL,
  PRIMARY KEY (`property_adress_id`),
  INDEX `fk_property_adress_city1_idx` (`city_city_id` ASC) VISIBLE,
  INDEX `fk_property_adress_country1_idx` (`country_country_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_adress_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `Airbnb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_adress_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `Airbnb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`property_rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`property_rules` (
  `property_rules_id` INT NOT NULL AUTO_INCREMENT,
  `check_in` TIME NULL,
  `check_out` TIME NULL,
  `max_guests` INT NULL,
  PRIMARY KEY (`property_rules_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`properties` (
  `property_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  `type` VARCHAR(60) NULL,
  `description` TEXT NULL,
  `bathrooms` INT NULL,
  `rooms` INT NULL,
  `property_adress_property_adress_id` INT NOT NULL,
  `property_rules_property_rules_id` INT NOT NULL,
  `hosts_host_id` INT NOT NULL,
  PRIMARY KEY (`property_id`),
  INDEX `fk_properties_property_adress1_idx` (`property_adress_property_adress_id` ASC) VISIBLE,
  INDEX `fk_properties_property_rules1_idx` (`property_rules_property_rules_id` ASC) VISIBLE,
  INDEX `fk_properties_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_properties_property_adress1`
    FOREIGN KEY (`property_adress_property_adress_id`)
    REFERENCES `Airbnb`.`property_adress` (`property_adress_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_properties_property_rules1`
    FOREIGN KEY (`property_rules_property_rules_id`)
    REFERENCES `Airbnb`.`property_rules` (`property_rules_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_properties_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`property_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`property_review` (
  `property_review_id` INT NOT NULL AUTO_INCREMENT,
  `review` TEXT NULL,
  `star_review` TINYINT NULL,
  `properties_property_id` INT NOT NULL,
  `guests_guest_id` INT NOT NULL,
  PRIMARY KEY (`property_review_id`),
  INDEX `fk_property_review_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  INDEX `fk_property_review_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_review_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_review_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`property_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`property_images` (
  `image` TEXT NULL,
  `properties_property_id` INT NOT NULL,
  INDEX `fk_property_images_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_images_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`guest_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`guest_review` (
  `guest_review_id` INT NOT NULL AUTO_INCREMENT,
  `review` TEXT NULL,
  `star_review` TINYINT NULL,
  `guests_guest_id` INT NOT NULL,
  `hosts_host_id` INT NOT NULL,
  PRIMARY KEY (`guest_review_id`),
  INDEX `fk_guest_review_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_guest_review_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_guest_review_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guest_review_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`booking` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `start` DATE NULL,
  `end` DATE NULL,
  `number_guests` INT NULL,
  `guests_guest_id` INT NOT NULL,
  `properties_property_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_booking_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_booking_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`administrators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`administrators` (
  `administrator_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`administrator_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`payment_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`payment_information` (
  `payment_information_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `payment_details` VARCHAR(200) NULL,
  `hosts_host_id` INT NULL,
  `guests_guest_id` INT NULL,
  PRIMARY KEY (`payment_information_id`),
  INDEX `fk_payment_information_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  INDEX `fk_payment_information_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_information_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_information_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `currency` VARCHAR(45) NULL,
  `amount` DECIMAL(7,2) NULL,
  `payment_date` DATETIME NULL,
  `payment_status` VARCHAR(45) NULL,
  `properties_property_id` INT NOT NULL,
  `hosts_host_id` INT NOT NULL,
  `guests_guest_id` INT NOT NULL,
  `booking_booking_id` INT NOT NULL,
  `administrators_administrator_id` INT NOT NULL,
  `payment_information_payment_information_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  INDEX `fk_payment_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  INDEX `fk_payment_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_payment_booking1_idx` (`booking_booking_id` ASC) VISIBLE,
  INDEX `fk_payment_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `fk_payment_payment_information1_idx` (`payment_information_payment_information_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_booking1`
    FOREIGN KEY (`booking_booking_id`)
    REFERENCES `Airbnb`.`booking` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `Airbnb`.`administrators` (`administrator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_payment_information1`
    FOREIGN KEY (`payment_information_payment_information_id`)
    REFERENCES `Airbnb`.`payment_information` (`payment_information_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`amenities` (
  `amenities_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL,
  `description` VARCHAR(300) NULL,
  PRIMARY KEY (`amenities_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`guest_adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`guest_adress` (
  `guest_adress_id` INT NOT NULL AUTO_INCREMENT,
  `country_country_id` INT NOT NULL,
  `city_city_id` INT NOT NULL,
  `zip` INT NULL,
  `street` VARCHAR(80) NULL,
  `number` VARCHAR(12) NULL,
  `guests_guest_id` INT NOT NULL,
  PRIMARY KEY (`guest_adress_id`),
  INDEX `fk_guest_adress_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_guest_adress_country1_idx` (`country_country_id` ASC) VISIBLE,
  INDEX `fk_guest_adress_city1_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_guest_adress_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guest_adress_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `Airbnb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guest_adress_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `Airbnb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`property_availability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`property_availability` (
  `properties_property_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `available` TINYINT(1) NULL,
  INDEX `fk_property_availability_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_availability_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`languages` (
  `languages_id` INT NOT NULL AUTO_INCREMENT,
  `language` VARCHAR(80) NULL,
  PRIMARY KEY (`languages_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`telephone_numbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`telephone_numbers` (
  `telephone_numbers_id` INT NOT NULL AUTO_INCREMENT,
  `telephone_number` VARCHAR(80) NULL,
  `administrators_administrator_id` INT NULL,
  `guests_guest_id` INT NULL,
  `hosts_host_id` INT NULL,
  PRIMARY KEY (`telephone_numbers_id`),
  INDEX `fk_telephone_numbers_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `fk_telephone_numbers_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_telephone_numbers_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_telephone_numbers_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `Airbnb`.`administrators` (`administrator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telephone_numbers_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telephone_numbers_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`e_mail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`e_mail` (
  `e_mail_id` INT NOT NULL AUTO_INCREMENT,
  `e_mail` VARCHAR(100) NULL,
  `guests_guest_id` INT NULL,
  `administrators_administrator_id` INT NULL,
  `hosts_host_id` INT NULL,
  PRIMARY KEY (`e_mail_id`),
  INDEX `fk_e_mail_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_e_mail_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `fk_e_mail_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_e_mail_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_e_mail_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `Airbnb`.`administrators` (`administrator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_e_mail_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`costs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`costs` (
  `costs_id` INT NOT NULL AUTO_INCREMENT,
  `price_per_night` DECIMAL(6,2) NULL,
  `service_fee` DECIMAL(5,2) NULL,
  `cleaning_costs` DECIMAL(5,2) NULL,
  `properties_property_id` INT NOT NULL,
  PRIMARY KEY (`costs_id`),
  INDEX `fk_costs_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_costs_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`property_has_amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`property_has_amenities` (
  `properties_property_id` INT NOT NULL,
  `amenities_amenities_id` INT NOT NULL,
  PRIMARY KEY (`properties_property_id`, `amenities_amenities_id`),
  INDEX `fk_properties_has_amenities_amenities1_idx` (`amenities_amenities_id` ASC) VISIBLE,
  INDEX `fk_properties_has_amenities_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_properties_has_amenities_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_properties_has_amenities_amenities1`
    FOREIGN KEY (`amenities_amenities_id`)
    REFERENCES `Airbnb`.`amenities` (`amenities_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`hosts_has_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`hosts_has_languages` (
  `hosts_host_id` INT NOT NULL,
  `languages_languages_id` INT NOT NULL,
  `level` VARCHAR(45) NULL,
  PRIMARY KEY (`hosts_host_id`, `languages_languages_id`),
  INDEX `fk_hosts_has_languages_languages1_idx` (`languages_languages_id` ASC) VISIBLE,
  INDEX `fk_hosts_has_languages_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_hosts_has_languages_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `Airbnb`.`hosts` (`host_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hosts_has_languages_languages1`
    FOREIGN KEY (`languages_languages_id`)
    REFERENCES `Airbnb`.`languages` (`languages_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`guests_has_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`guests_has_languages` (
  `guests_guest_id` INT NOT NULL,
  `languages_languages_id` INT NOT NULL,
  `level` VARCHAR(45) NULL,
  PRIMARY KEY (`guests_guest_id`, `languages_languages_id`),
  INDEX `fk_guests_has_languages_languages1_idx` (`languages_languages_id` ASC) VISIBLE,
  INDEX `fk_guests_has_languages_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_guests_has_languages_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `Airbnb`.`guests` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_guests_has_languages_languages1`
    FOREIGN KEY (`languages_languages_id`)
    REFERENCES `Airbnb`.`languages` (`languages_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`administrators_has_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`administrators_has_languages` (
  `administrators_administrator_id` INT NOT NULL,
  `languages_languages_id` INT NOT NULL,
  `level` VARCHAR(45) NULL,
  PRIMARY KEY (`administrators_administrator_id`, `languages_languages_id`),
  INDEX `fk_administrators_has_languages_languages1_idx` (`languages_languages_id` ASC) VISIBLE,
  INDEX `fk_administrators_has_languages_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  CONSTRAINT `fk_administrators_has_languages_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `Airbnb`.`administrators` (`administrator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_administrators_has_languages_languages1`
    FOREIGN KEY (`languages_languages_id`)
    REFERENCES `Airbnb`.`languages` (`languages_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`beds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`beds` (
  `bed_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`bed_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airbnb`.`properties_has_beds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airbnb`.`properties_has_beds` (
  `properties_property_id` INT NOT NULL,
  `beds_bed_id` INT NOT NULL,
  `number` INT NULL,
  PRIMARY KEY (`properties_property_id`, `beds_bed_id`),
  INDEX `fk_properties_has_beds_beds1_idx` (`beds_bed_id` ASC) VISIBLE,
  INDEX `fk_properties_has_beds_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_properties_has_beds_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `Airbnb`.`properties` (`property_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_properties_has_beds_beds1`
    FOREIGN KEY (`beds_bed_id`)
    REFERENCES `Airbnb`.`beds` (`bed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `airbnb` ;

-- -----------------------------------------------------
-- Table `airbnb`.`administrators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`administrators` (
  `administrator_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`administrator_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`languages` (
  `languages_id` INT NOT NULL AUTO_INCREMENT,
  `language` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`languages_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`administrators_has_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`administrators_has_languages` (
  `administrators_administrator_id` INT NOT NULL,
  `languages_languages_id` INT NOT NULL,
  `level` VARCHAR(80) NULL DEFAULT NULL,
  INDEX `administrators_administrator_id` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `languages_languages_id` (`languages_languages_id` ASC) VISIBLE,
  CONSTRAINT `administrators_has_languages_ibfk_1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `airbnb`.`administrators` (`administrator_id`),
  CONSTRAINT `administrators_has_languages_ibfk_2`
    FOREIGN KEY (`languages_languages_id`)
    REFERENCES `airbnb`.`languages` (`languages_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`amenities` (
  `amenities_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL DEFAULT NULL,
  `description` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`amenities_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`beds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`beds` (
  `bed_id` INT NOT NULL,
  `type` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`bed_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`guests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`guests` (
  `guest_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `profile_picture` TEXT NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`guest_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`hosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`hosts` (
  `host_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `profile_picture` TEXT NULL DEFAULT NULL,
  `birthdate` VARCHAR(45) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`host_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 65
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`property_adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property_adress` (
  `property_adress_id` INT NOT NULL AUTO_INCREMENT,
  `country_country_id` INT NULL DEFAULT NULL,
  `city_city_id` INT NULL DEFAULT NULL,
  `zip` INT NULL DEFAULT NULL,
  `street` VARCHAR(80) NULL DEFAULT NULL,
  `number` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`property_adress_id`),
  INDEX `fk_property_adress_city1_idx` (`city_city_id` ASC) VISIBLE,
  INDEX `fk_property_adress_country1_idx` (`country_country_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_adress_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `airbnb`.`city` (`city_id`),
  CONSTRAINT `fk_property_adress_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `airbnb`.`country` (`country_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`property_rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property_rules` (
  `property_rules_id` INT NOT NULL AUTO_INCREMENT,
  `check_in` TIME NULL DEFAULT NULL,
  `check_out` TIME NULL DEFAULT NULL,
  `max_guests` INT NULL DEFAULT NULL,
  PRIMARY KEY (`property_rules_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`properties` (
  `property_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NULL DEFAULT NULL,
  `type` VARCHAR(60) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `bathrooms` INT NULL DEFAULT NULL,
  `rooms` INT NULL DEFAULT NULL,
  `property_adress_property_adress_id` INT NOT NULL,
  `property_rules_property_rules_id` INT NOT NULL,
  `hosts_host_id` INT NOT NULL,
  PRIMARY KEY (`property_id`),
  INDEX `fk_properties_property_adress1_idx` (`property_adress_property_adress_id` ASC) VISIBLE,
  INDEX `fk_properties_property_rules1_idx` (`property_rules_property_rules_id` ASC) VISIBLE,
  INDEX `fk_properties_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_properties_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`),
  CONSTRAINT `fk_properties_property_adress1`
    FOREIGN KEY (`property_adress_property_adress_id`)
    REFERENCES `airbnb`.`property_adress` (`property_adress_id`),
  CONSTRAINT `fk_properties_property_rules1`
    FOREIGN KEY (`property_rules_property_rules_id`)
    REFERENCES `airbnb`.`property_rules` (`property_rules_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`booking` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `start` DATE NULL DEFAULT NULL,
  `end` DATE NULL DEFAULT NULL,
  `number_guests` INT NULL DEFAULT NULL,
  `guests_guest_id` INT NOT NULL,
  `properties_property_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_booking_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_booking_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_booking_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`costs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`costs` (
  `costs_id` INT NOT NULL AUTO_INCREMENT,
  `price_per_night` DECIMAL(6,2) NULL DEFAULT NULL,
  `service_fee` DECIMAL(5,2) NULL DEFAULT NULL,
  `cleaning_costs` DECIMAL(5,2) NULL DEFAULT NULL,
  `properties_property_id` INT NOT NULL,
  PRIMARY KEY (`costs_id`),
  INDEX `fk_costs_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_costs_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`e_mail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`e_mail` (
  `e_mail_id` INT NOT NULL AUTO_INCREMENT,
  `e_mail` VARCHAR(100) NULL DEFAULT NULL,
  `guests_guest_id` INT NULL DEFAULT NULL,
  `administrators_administrator_id` INT NULL DEFAULT NULL,
  `hosts_host_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`e_mail_id`),
  INDEX `fk_e_mail_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_e_mail_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `fk_e_mail_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_e_mail_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `airbnb`.`administrators` (`administrator_id`),
  CONSTRAINT `fk_e_mail_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_e_mail_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 70
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`guest_adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`guest_adress` (
  `guest_adress_id` INT NOT NULL AUTO_INCREMENT,
  `country_country_id` INT NULL DEFAULT NULL,
  `city_city_id` INT NULL DEFAULT NULL,
  `zip` INT NULL DEFAULT NULL,
  `street` VARCHAR(80) NULL DEFAULT NULL,
  `number` VARCHAR(12) NULL DEFAULT NULL,
  `guests_guest_id` INT NOT NULL,
  PRIMARY KEY (`guest_adress_id`),
  INDEX `fk_guest_adress_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_guest_adress_country1_idx` (`country_country_id` ASC) VISIBLE,
  INDEX `fk_guest_adress_city1_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_guest_adress_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `airbnb`.`city` (`city_id`),
  CONSTRAINT `fk_guest_adress_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `airbnb`.`country` (`country_id`),
  CONSTRAINT `fk_guest_adress_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`guest_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`guest_review` (
  `guest_review_id` INT NOT NULL AUTO_INCREMENT,
  `review` TEXT NULL DEFAULT NULL,
  `star_review` TINYINT NULL DEFAULT NULL,
  `guests_guest_id` INT NOT NULL,
  `hosts_host_id` INT NOT NULL,
  PRIMARY KEY (`guest_review_id`),
  INDEX `fk_guest_review_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_guest_review_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_guest_review_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_guest_review_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`guests_has_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`guests_has_languages` (
  `guests_guest_id` INT NOT NULL,
  `languages_languages_id` INT NOT NULL,
  `level` VARCHAR(80) NULL DEFAULT NULL,
  INDEX `guests_guest_id` (`guests_guest_id` ASC) VISIBLE,
  INDEX `languages_languages_id` (`languages_languages_id` ASC) VISIBLE,
  CONSTRAINT `guests_has_languages_ibfk_1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `guests_has_languages_ibfk_2`
    FOREIGN KEY (`languages_languages_id`)
    REFERENCES `airbnb`.`languages` (`languages_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`hosts_has_languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`hosts_has_languages` (
  `hosts_host_id` INT NOT NULL,
  `languages_languages_id` INT NOT NULL,
  `level` VARCHAR(80) NULL DEFAULT NULL,
  INDEX `hosts_host_id` (`hosts_host_id` ASC) VISIBLE,
  INDEX `languages_languages_id` (`languages_languages_id` ASC) VISIBLE,
  CONSTRAINT `hosts_has_languages_ibfk_1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`),
  CONSTRAINT `hosts_has_languages_ibfk_2`
    FOREIGN KEY (`languages_languages_id`)
    REFERENCES `airbnb`.`languages` (`languages_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`payment_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`payment_information` (
  `payment_information_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `payment_details` VARCHAR(200) NULL DEFAULT NULL,
  `hosts_host_id` INT NULL DEFAULT NULL,
  `guests_guest_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`payment_information_id`),
  INDEX `fk_payment_information_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  INDEX `fk_payment_information_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_information_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_payment_information_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 47
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `currency` VARCHAR(45) NULL DEFAULT NULL,
  `amount` DECIMAL(7,2) NULL DEFAULT NULL,
  `payment_date` DATETIME NULL DEFAULT NULL,
  `payment_status` VARCHAR(45) NULL DEFAULT NULL,
  `properties_property_id` INT NOT NULL,
  `hosts_host_id` INT NOT NULL,
  `guests_guest_id` INT NOT NULL,
  `booking_booking_id` INT NOT NULL,
  `administrators_administrator_id` INT NOT NULL,
  `payment_information_payment_information_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  INDEX `fk_payment_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  INDEX `fk_payment_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_payment_booking1_idx` (`booking_booking_id` ASC) VISIBLE,
  INDEX `fk_payment_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `fk_payment_payment_information1_idx` (`payment_information_payment_information_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `airbnb`.`administrators` (`administrator_id`),
  CONSTRAINT `fk_payment_booking1`
    FOREIGN KEY (`booking_booking_id`)
    REFERENCES `airbnb`.`booking` (`booking_id`),
  CONSTRAINT `fk_payment_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_payment_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`),
  CONSTRAINT `fk_payment_payment_information1`
    FOREIGN KEY (`payment_information_payment_information_id`)
    REFERENCES `airbnb`.`payment_information` (`payment_information_id`),
  CONSTRAINT `fk_payment_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`properties_has_beds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`properties_has_beds` (
  `properties_property_id` INT NOT NULL,
  `beds_bed_id` INT NOT NULL,
  `number` INT NULL DEFAULT NULL,
  INDEX `properties_property_id` (`properties_property_id` ASC) VISIBLE,
  INDEX `beds_bed_id` (`beds_bed_id` ASC) VISIBLE,
  CONSTRAINT `properties_has_beds_ibfk_1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`),
  CONSTRAINT `properties_has_beds_ibfk_2`
    FOREIGN KEY (`beds_bed_id`)
    REFERENCES `airbnb`.`beds` (`bed_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`property_availability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property_availability` (
  `properties_property_id` INT NOT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `available` TINYINT(1) NULL DEFAULT NULL,
  INDEX `fk_property_availability_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_availability_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`property_has_amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property_has_amenities` (
  `properties_property_id` INT NOT NULL,
  `amenities_amenities_id` INT NOT NULL,
  PRIMARY KEY (`properties_property_id`, `amenities_amenities_id`),
  INDEX `fk_properties_has_amenities_amenities1_idx` (`amenities_amenities_id` ASC) VISIBLE,
  INDEX `fk_properties_has_amenities_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_properties_has_amenities_amenities1`
    FOREIGN KEY (`amenities_amenities_id`)
    REFERENCES `airbnb`.`amenities` (`amenities_id`),
  CONSTRAINT `fk_properties_has_amenities_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`property_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property_images` (
  `image` TEXT NULL DEFAULT NULL,
  `properties_property_id` INT NOT NULL,
  INDEX `fk_property_images_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_images_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`property_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property_review` (
  `property_review_id` INT NOT NULL AUTO_INCREMENT,
  `review` TEXT NULL DEFAULT NULL,
  `star_review` TINYINT NULL DEFAULT NULL,
  `properties_property_id` INT NOT NULL,
  `guests_guest_id` INT NOT NULL,
  PRIMARY KEY (`property_review_id`),
  INDEX `fk_property_review_properties1_idx` (`properties_property_id` ASC) VISIBLE,
  INDEX `fk_property_review_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_review_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_property_review_properties1`
    FOREIGN KEY (`properties_property_id`)
    REFERENCES `airbnb`.`properties` (`property_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `airbnb`.`telephone_numbers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`telephone_numbers` (
  `telephone_numbers_id` INT NOT NULL AUTO_INCREMENT,
  `telephone_number` VARCHAR(80) NULL DEFAULT NULL,
  `administrators_administrator_id` INT NULL DEFAULT NULL,
  `guests_guest_id` INT NULL DEFAULT NULL,
  `hosts_host_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`telephone_numbers_id`),
  INDEX `fk_telephone_numbers_administrators1_idx` (`administrators_administrator_id` ASC) VISIBLE,
  INDEX `fk_telephone_numbers_guests1_idx` (`guests_guest_id` ASC) VISIBLE,
  INDEX `fk_telephone_numbers_hosts1_idx` (`hosts_host_id` ASC) VISIBLE,
  CONSTRAINT `fk_telephone_numbers_administrators1`
    FOREIGN KEY (`administrators_administrator_id`)
    REFERENCES `airbnb`.`administrators` (`administrator_id`),
  CONSTRAINT `fk_telephone_numbers_guests1`
    FOREIGN KEY (`guests_guest_id`)
    REFERENCES `airbnb`.`guests` (`guest_id`),
  CONSTRAINT `fk_telephone_numbers_hosts1`
    FOREIGN KEY (`hosts_host_id`)
    REFERENCES `airbnb`.`hosts` (`host_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 73
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `guests` VALUES (1,'Alexander','Ulbin','https://drive.google.com/file/d/1ARjdORqx5aTn2byu59sPR4N4Yw3cdUiR/view?usp=share_link','1983-05-18'),
(2,'Marija','Jovanovic','https://drive.google.com/file/d/1BYKTE5kGbsbgT3dMDwf9jtMqF4nGP6pr/view?usp=share_link','1990-06-18'),
(3,'Stefan','Klaus','https://drive.google.com/file/d/1xYHFDFarASwEvRsU8UlxZm786qDwHL_o/view?usp=share_link','1995-06-01'),
(4,'Florian','Potter','https://drive.google.com/file/d/157SBHW00uXgU_QBhYFia8KMutulsNYHH/view?usp=share_link','1994-02-06'),
(5,'Drazen','Suljanovic','https://drive.google.com/file/d/1NVvqklvB6-XqtNJJ36LV-7jUBg9vlFu5/view?usp=share_link','1994-07-04'),
(6,'Sebastian','Rosenmayr','https://drive.google.com/file/d/1NB7ZTzvV4fb8WVOJYXwofXevDisO61N2/view?usp=share_link','1999-01-30'),
(7,'Anna','Theresia','https://drive.google.com/file/d/1ZSe2b4qYkOHkeCHre-_OHrWnN1RtCgNT/view?usp=share_link','1998-02-07'),
(8,'Jürgen','Jochen','https://drive.google.com/file/d/1DeTA5Ev1HXA8O-nS0AuA1Pfp4T2An6Tr/view?usp=share_link','1964-05-16'),
(9,'Theresia','Stranger','https://drive.google.com/file/d/1T1_5plP9QGyx1XA99oe4vgW8qpBypGek/view?usp=share_link','1951-02-09'),
(10,'Alois','Schuhmacher','https://drive.google.com/file/d/1DeTA5Ev1HXA8O-nS0AuA1Pfp4T2An6Tr/view?usp=share_link','1964-12-12'),
(11,'Emilia','Ackermann','https://drive.google.com/file/d/1pqrrqJJ9t-FbuaQg4XO2Uf60jefZOCzL/view?usp=share_link','2001-04-25'),
(12,'Patricia','Riese','https://drive.google.com/file/d/1TlVMrJMXu4tgSbkqWZ60lowk2OTVDLtt/view?usp=share_link','2002-04-01'),
(13,'Elisabeth','Jencio','https://drive.google.com/file/d/1kjE1tOmSn4dUCEjrravgtatGALnlGub4/view?usp=share_link','1997-06-04'),
(14,'Karner','Gerald','https://drive.google.com/file/d/1p4eh8psIyBOkfMqgEqXmHBiiMjAzN9Kb/view?usp=share_link','1990-04-18'),
(15,'Herbert','Triest','https://drive.google.com/file/d/1NVvqklvB6-XqtNJJ36LV-7jUBg9vlFu5/view?usp=share_link','1992-07-08'),
(16,'Sibila','Wirr','https://drive.google.com/file/d/1ufOAg8VwXs6qus0PNQdA29Sg7JBGOMFh/view?usp=share_link','1987-01-25'),
(17,'Anton','Ratte','https://drive.google.com/file/d/1oMscjY8adMYqowy-fqW59eruWLj77OZG/view?usp=share_link','2001-11-07'),
(18,'Emilio','Trigbert','https://drive.google.com/file/d/1zzBWLwJ6U7K43_xI0KTE3xX-E1b3OLMP/view?usp=share_link','1977-04-06'),
(19,'Reiner','Winkler','https://drive.google.com/file/d/1Kk-JGfjc36tNBvV0_AorAhJ6FU5eFjin/view?usp=share_link','1974-05-06'),
(20,'Anton','Becker','https://drive.google.com/file/d/1_vuK41NJExTKbCtxNrynSd3DdEI4uNvk/view?usp=share_link','1991-11-24'),
(21,'Arthur','Hubert','https://drive.google.com/file/d/1cLjsfYJSY2DsraqIsAwvX77Z-3r3fAXE/view?usp=share_link','1968-12-12'),
(22,'Anna','Gammler','https://drive.google.com/file/d/1ufOAg8VwXs6qus0PNQdA29Sg7JBGOMFh/view?usp=share_link','1997-02-17'),
(23,'Jaqueline','Witter','https://drive.google.com/file/d/1ZqdaG-lvP8Zyjfuegt8lFWffSs08dGre/view?usp=share_link','1984-09-26');

INSERT INTO `hosts` VALUES (1,'Mirko','Witter','https://drive.google.com/file/d/1Q7xbCvyGfGPXzU30B0M_x5jhpQWPFWM1/view?usp=share_link','1998-12-24','Hello my name is Mirko! Feel free to contact me with any qeustions regarding your stay.'),
(2,'Anna','Cramling','https://drive.google.com/file/d/1Ex8Gm3L6cbR7VvzkRftZmihyTkqX-Mi3/view?usp=share_link','1997-11-04','Hope you enjoy your stay in my humble home!'),
(3,'Eric','Rosen','https://drive.google.com/file/d/1y5XgDGeajJtnW3ptZMvRwUDXPpTMSsRA/view?usp=share_link','1992-04-09',NULL),
(4,'Hikaru','Nakamura','https://drive.google.com/file/d/1llqVGBSqVvMBQIToZQTscNa8OUiOL37J/view?usp=share_link','1984-05-08','I am Chess Grandmaster Hikaru Nakamura offering you an exceptional experience staying in this apartment!'),
(5,'Claudia','Socke','https://drive.google.com/file/d/1a6TcoF9qki9aXA05mS1NDjIf2l7LvLAh/view?usp=share_link','1997-11-04','Thank you for the interest in this house. Feel free to contact me via e-mail if you have any questions!'),
(6,'Abdula','Yusuf','https://drive.google.com/file/d/1llqVGBSqVvMBQIToZQTscNa8OUiOL37J/view?usp=share_link','1974-07-24','Greetings!'),
(7,'Ahmed','Aman','https://drive.google.com/file/d/11YB57byiKhsr9qWSQW3Lq55ZhTmYxnOC/view?usp=share_link','1967-08-30','I will be happy to assist you during your stay'),
(8,'Jürgen','Becker','https://drive.google.com/file/d/1fyX5A3UDYdj1-k_QGKeTVkLXBxOPESQR/view?usp=share_link','1974-03-18','Thank you for your interest in this apartment'),
(9,'Bettina','Deustch','https://drive.google.com/file/d/1m3E7gTr4HUB4IzqGbM8sofJDzjaKjS9v/view?usp=share_link','1966-12-14','Hello :)'),
(10,'Clarice','Singer','https://drive.google.com/file/d/1h4bBNmCY1zzXechlv4h9cvGrz0DdJRWZ/view?usp=share_link','1988-07-04','Welcome to my lovely home'),
(11,'Dieter','Schwarz','https://drive.google.com/file/d/1llocqRAcXIjQcxCWsrz0-oY80oOct_FB/view?usp=share_link','1985-02-02','Only available via e-mail'),
(12,'Anna','Kaplan','https://drive.google.com/file/d/1pKgCDU6EAp1CROfhfOOlorepw64XoCug/view?usp=share_link','1968-07-30','I will be happy to assist you during your stay'),
(13,'Heino','Gutmann','https://drive.google.com/file/d/1KJ0qjq4wzCK9-nQ5qpnUn_b9Kj58_4ZG/view?usp=share_link','1987-07-07','Good day! Guten Tag!'),
(14,'Albert','Schweiz','https://drive.google.com/file/d/1Oxwt7BSa_FDVhl3cIDei2pD9lZiWX5X4/view?usp=share_link','1958-12-29',NULL),
(15,'Maurice','Clarice','https://drive.google.com/file/d/1Kb3F7cWy1C9T3vfrJ1OByWtBF5dhmSZ0/view?usp=share_link','1977-04-01',NULL),
(16,'Herman','Keller','https://drive.google.com/file/d/1ObPmh21uoy_3rp4JUuJxNWWqltp_wAV0/view?usp=share_link','1974-01-01','A warm welcome!'),
(17,'Beatrice','Copper','https://drive.google.com/file/d/1cHNTgIf6OC3PdfILlY3J5CsW93ppnR5q/view?usp=share_link','1965-06-09','Thank you for your interest in this apartment!, during your stay i will gladly provide any assistance you need!'),
(18,'Clarice','Waterfall','https://drive.google.com/file/d/1-nCiUlMidshDkzy8i7UFEPtxf_w-0uWW/view?usp=share_link','1987-07-26','The apartment speeks for itself'),
(19,'Maurice','Jupiter','https://drive.google.com/file/d/1hETESP4IiPCFeG96NEPat3vyUmK6DJfH/view?usp=share_link','1994-07-05','Please leave a recommendation!'),
(20,'Hercules','Strongman','https://drive.google.com/file/d/16ailt46sMoWuyXFT7hj0hNYolHzNrCkA/view?usp=share_link','1988-12-01','Hello!');

INSERT INTO `city` VALUES (17,'Vienna'),(18,'Zagreb'),(19,'Berlin'),(20,'Budapest'),(21,'Paris'),(22,'Rome'),(23,'Madrid'),(24,'Warsaw'),(25,'Hamburg'),(26,'Bucharest'),(27,'Barcelona'),(28,'Munich'),(29,'Milan'),(30,'Sofia'),(31,'Prague'),(32,'Cologne'),(33,'Stockholm'),(34,'Amsterdam'),(35,'Napels'),(36,'Marseille'),(37,'Turin'),(38,'Krakow'),(39,'Valencia'),(40,'Frankfurt am Main'),(41,'Seville'),(42,'Zatagoza'),(43,'Rotterdam'),(44,'Helsinki'),(45,'Copenhagen'),(46,'Athens'),(47,'Palermo'),(48,'Stuttgart'),(49,'Düsseldorf'),(50,'Riga'),(51,'Dublin'),(52,'Gothenburg'),(53,'Dortmund'),(54,'Vilnius'),(55,'Geona'),(56,'Lisbon'),(57,'Antwerp'),(58,'Lyon'),(59,'Hannover'),(60,'Tallinn'),(61,'Brno'),(62,'Aarhus'),(63,'Malmö'),(64,'Varna');

INSERT INTO `country` VALUES (1,'Austria'),(2,'Germany'),(3,'Spain'),(4,'Italy'),(5,'France'),(6,'Poland'),(7,'Romania'),(8,'Hungary'),(9,'Bulgaria'),(10,'Czech Republic'),(11,'Sweden'),(12,'Netherlands'),(13,'Croatia'),(14,'Finnland'),(15,'Greece'),(16,'Denmark'),(17,'Latvia'),(18,'Ireland'),(19,'Lithuania'),(20,'Portugal'),(21,'Belgium'),(22,'Slovakia'),(23,'Estonia');

INSERT INTO `property_adress` VALUES (1,1,17,1070,'Stiftgasse','3'),(2,2,19,10435,'Schönhauser Allee','19'),(3,9,30,10435,'Blvd James Bourchier','100'),(4,3,23,28012,'Rda. de Atocha','3'),(5,20,56,1050,'Av. António Augusto de Aguiar','66 5E'),(6,5,21,75008,'Bd Haussmann','158'),(7,5,21,94000,'Av. du Général de Gaulle','61'),(8,2,40,60327,'Europa-Allee','6'),(9,2,40,60386,'Hanauer Landstraße','517-543'),(10,1,17,1010,'Judengasse','11'),(11,1,17,1110,'Thürnlhofstraße','30'),(12,11,63,21143,'Triangeln','2'),(13,2,59,30163,'Lister Pl.','1'),(14,2,53,44141,'Märkische Straße','73'),(15,15,46,11474,'Evelpidon','4'),(16,4,47,90139,'Via Enrico Albanese','34'),(17,4,22,184,'Via della Madonna dei Monti','108'),(18,8,20,1148,'Ifjúság útja','1'),(19,6,24,312,'Dobra','55/56'),(20,6,38,30302,'Bulwar Wołyński','4');

INSERT INTO `property_rules` VALUES (1,'15:00:00','11:00:00',4),(2,'15:00:00','11:00:00',4),(3,'16:00:00','12:00:00',2),(4,'18:00:00','14:00:00',5),(5,'15:00:00','12:00:00',6),(6,'15:00:00','11:00:00',6),(7,'16:00:00','11:30:00',5),(8,'17:30:00','12:00:00',4),(9,'16:00:00','11:00:00',4),(10,'15:00:00','10:30:00',2),(11,'14:30:00','10:00:00',2),(12,'15:00:00','11:00:00',4),(13,'16:00:00','12:00:00',7),(14,'18:00:00','09:30:00',5),(15,'15:00:00','12:00:00',6),(16,'15:45:00','11:00:00',9),(17,'16:00:00','10:30:00',5),(18,'17:30:00','10:45:00',4),(19,'14:00:00','11:00:00',4),(20,'12:00:00','12:00:00',3);

INSERT INTO `properties` VALUES (1,'Apartment in Neubau','Apartment','This studio is furnished and equipped with a modern kitchenette. The apartment includes other amenities such as two queen size bed, closet and a table with chair where you can work or enjoy your meal.',1,3,1,1,1),(2,'Private room at Penzlauer Berg','Room','This small but nice private room has enough space for two people and is in the center of penzlauer berg ',1,1,2,3,2),(3,'Apartment in Sofia','Apartment','This is the dream getaway place. Close to the ideal centre but away from the noisiness and traffic madness of the capital. This loft is amazing ',1,2,3,20,3),(4,'Nice Place to Stay','Apartment','Hola. Beautiful apartment in one of the most exclusive neighborhoods of Madrid.  ',2,3,4,19,4),(5,'Apartment with private parking','Apartment','Our charming Apartment is within walking distance of all major points of interests in Lisbon  ',1,2,5,18,5),(6,'Loft in Paris near Eifel Tower','Apartment','Gorgeous Loft entirely renovated and fully equipped in the heart of the embassies area. The flat is calm and very safe in 16th district of Paris with security guard 24/7.',1,2,6,7,6),(7,'Big House in Paris','House','Garden, barbecue, ping pong table, bicycles, outdoor games for children available.\nFree parking at the entrance of the property and then in a covered and secure box, desk with fiber connection, TV, DVD player and NETFLIX',2,5,7,13,7),(8,'Apartment am Main','Apartment','Nice Apartment with Balcony next to the Main',1,2,8,2,8),(9,'Double-Bed Room','Hotel','Facilities at the property include a restaurant, a 24-hour front desk and room service, as well as free WiFi throughout the property.',1,2,9,12,9),(10,'Condo in Vienna Center','Apartment','There is also a multy-storey car park, which costs €5 per day. In the area we also have a supermarket, a restaurant and a gym.',1,2,10,4,10),(11,'Cozy Home','Apartment','There is also a multy-storey car park, which costs €5 per day. In the area we also have a supermarket, a restaurant and a gym.',1,1,11,10,11),(12,'Townhouse','House','Experience the local feeling with high standard and great location!',2,4,12,5,12),(13,'Cozy old building apartment','Apartment','We rent our cozy old apartment in the heart of Hanover.',1,3,13,6,13),(14,'Apartment in Dortmund','Apartment','In the apartment there are four beds, a small kitchen, dining table and chairs of course also and a TV with Netflix account.',1,3,14,15,14),(15,'Condo in Athens','Apartment','It is an ideal overnight stay between flights or a short stay. ',1,2,15,11,15),(16,'Nice Cabin','House','Recently renovated, immersed in greenery and surrounded by a beautiful natural landscape.',2,3,16,14,16),(17,'Big House in Rome','House','This House offers a enough space for up to 9 people.',2,5,17,16,17),(18,'Cozy Apartment','Apartment','Cozy Apartment for a holiday trip!',1,2,18,9,18),(19,'Nice Apartment in Center of Warsaw','Apartment',NULL,1,2,19,17,19),(20,'Apartment in Krakow','Apartment',NULL,1,2,20,8,20);

INSERT INTO `property_review` VALUES (1,'Great stay! Clean and comfortable space, easy check-in process, and friendly hosts.',5,1,1),(2,'Wonderful Airbnb experience! Beautiful location, cozy space, and excellent communication with the hosts.',5,1,5),(3,'Highly recommend this Airbnb! Fantastic location, stylish decor, and amazing amenities.',5,1,18),(4,'Had a fantastic stay at this Airbnb! The hosts were incredibly helpful, and the space was clean, comfortable, and had everything I needed.',4,2,2),(5,'Perfect Airbnb experience! Great location, friendly hosts, and a lovely space that felt like home.',4,2,16),(6,'I had a wonderful experience at this Airbnb! The hosts were incredibly friendly and accommodating, and the space was clean, comfortable, and had everything I needed. The location was perfect, with easy access to public transportation and plenty of attractions within walking distance. Overall, I would highly recommend this Airbnb to anyone looking for a great place to stay.',5,2,10),(7,'This Airbnb exceeded my expectations! The space was immaculate, stylish, and had all the amenities I could ask for. The hosts were incredibly helpful and went above and beyond to make my stay comfortable and enjoyable. The location was also fantastic, with plenty of restaurants, bars, and shops nearby. I would absolutely recommend this Airbnb to anyone looking for a luxurious and relaxing stay.',5,2,11),(8,'Had an amazing time at this Airbnb! The hosts were incredibly welcoming and the space was beautiful, clean, and had all the amenities I needed. The location was also great, with easy access to public transportation and plenty of restaurants and shops nearby.',5,2,13),(9,'Loved my stay at this Airbnb! The hosts were friendly and accommodating, and the space was clean, cozy, and well-appointed. The location was also fantastic, with plenty of things to do and see nearby.',5,4,4),(10,'Highly recommend this Airbnb! The space was stylish and comfortable, the hosts were welcoming and helpful, and the location was perfect for exploring the city.',4,4,13),(11,'Had a wonderful stay at this Airbnb! The space was clean, comfortable, and had all the amenities I needed. The hosts were also very responsive and accommodating. Would definitely stay here again!',5,4,16),(12,'This Airbnb was perfect for my needs! The space was clean and comfortable, the hosts were friendly and helpful, and the location was convenient and easy to navigate. Would highly recommend!',5,4,17),(13,'My stay was excellent! The hosts were very friendly and accommodating, and the space was clean, comfortable, and had everything I needed. The location was also great, with easy access to public transportation and plenty of restaurants and shops nearby.',5,5,11),(14,'I had a fantastic time! The space was beautiful and well-maintained, the hosts were friendly and helpful, and the location was perfect for exploring the city. Would definitely stay here again!',5,6,11),(15,'This Airbnb was everything I hoped for and more! The space was beautiful and well-appointed, the hosts were welcoming and friendly, and the location was perfect for exploring the city. Would highly recommend to anyone looking for a great place to stay.',5,7,1),(16,'My stay at this Airbnb was decent overall, but the space was a bit smaller and less well-maintained than I expected. The hosts were friendly, but not as responsive as I would have liked. However, the location was great and there were plenty of things to do and see nearby.',3,7,14),(17,'While the location of this Airbnb was fantastic, the space itself was a bit disappointing. It was not as clean as I would have liked, and some of the amenities were not functioning properly. The hosts were friendly, but not very helpful in addressing these issues.',2,8,3),(18,'Although the hosts of this Airbnb were very welcoming and accommodating, the space itself was not as comfortable as I had hoped. The bed was quite hard and the air conditioning was not very effective, making for a less than ideal sleeping environment.',3,8,4),(19,'Had a great stay at this Airbnb! The space was cozy and inviting, the hosts were accommodating and helpful, and the location was convenient and easy to get around. Would definitely stay here again!',5,8,9),(20,'While the location of this Airbnb was convenient, the space was quite noisy and not as private as I would have liked. The hosts were friendly, but there were some communication issues that made check-in and check-out more challenging than necessary.',2,16,9),(21,'Although the space of this Airbnb was well-decorated and comfortable, the hosts were not very responsive to my requests for additional amenities. Additionally, the location was not as convenient as I had hoped, and it was difficult to find parking nearby.',2,11,9),(22,'My stay at this Airbnb was disappointing overall. The space was not as clean as I would have liked, and there were some maintenance issues that the hosts did not address during my stay. Additionally, the location was not as convenient as I had hoped, with limited access to public transportation.',2,16,8),(23,'Although the hosts of this Airbnb were friendly, the space itself was not very comfortable. The bed was quite hard, and there was not enough lighting in the room to read or work comfortably. Additionally, the location was a bit noisy, making it difficult to get a good night\'s sleep.',1,20,20),(24,'While the space of this Airbnb was cozy and inviting, the hosts were not very accommodating. They were inflexible with check-in and check-out times, and did not provide sufficient information about the amenities and features of the space. Additionally, the location was a bit out of the way, making it difficult to get around.',1,15,15),(25,'My stay at this Airbnb was marred by several issues. The space was not as clean as I would have liked, and there were some maintenance issues that the hosts did not address promptly. Additionally, the location was quite noisy, making it difficult to relax and enjoy my stay.',1,7,16),(26,'Although the hosts of this Airbnb were friendly and helpful, the space itself was a bit disappointing. It was smaller than I expected, and some of the amenities were not functioning properly. Additionally, the location was a bit out of the way, making it difficult to get around and explore the city.',2,17,1),(27,'I had a wonderful stay at this Airbnb! The space was clean, comfortable, and well-appointed, with plenty of amenities to make me feel at home. The hosts were also incredibly welcoming and helpful, making sure I had everything I needed. The location was also great, with plenty of restaurants and shops nearby.',5,16,1),(28,'This Airbnb was fantastic! The space was beautifully decorated and immaculately clean, with all the amenities I needed for a comfortable stay. The hosts were also friendly and responsive, making sure I had everything I needed. The location was also fantastic, with easy access to public transportation and plenty of things to do and see nearby.',5,13,11),(29,'Highly recommend this Airbnb! The space was cozy and inviting, with all the amenities I needed for a comfortable stay. The hosts were also incredibly welcoming and helpful, going out of their way to make sure I had a great experience. The location was also great, with plenty of restaurants and shops within walking distance.',5,10,11),(30,'I had a wonderful stay at this Airbnb! The space was spacious, clean, and comfortable, with all the amenities I needed for a great stay. The hosts were also fantastic, providing plenty of information about the area and making sure I had everything I needed. The location was also ideal, with plenty of things to do and see nearby.',4,7,7),(31,'This Airbnb was everything I could have hoped for and more! The space was stylish and well-appointed, with all the amenities I needed for a comfortable stay. The hosts were also friendly and welcoming, making me feel at home from the moment I arrived. The location was also fantastic, with easy access to public transportation and plenty of great restaurants and shops nearby.',5,20,7),(32,'My stay at this Airbnb was amazing! The space was beautifully decorated and had all the amenities I needed for a comfortable and relaxing stay. The hosts were also incredibly kind and responsive, making sure I had everything I needed. The location was also great, with plenty of things to do and see nearby.',5,14,5),(33,'I couldn\'t have asked for a better stay at this Airbnb! The space was spotless, cozy, and had all the amenities I needed for a great stay. The hosts were also fantastic, going above and beyond to make sure I had a great experience. The location was also perfect, with easy access to public transportation and plenty of restaurants and shops nearby.',5,19,15),(34,'Highly recommend this Airbnb! The space was spacious, modern, and well-equipped, with all the amenities I needed for a comfortable and enjoyable stay. The hosts were also incredibly welcoming and helpful, providing great recommendations for things to do and see in the area. The location was also fantastic, with easy access to public transportation and plenty of great restaurants and bars nearby.',5,15,5),(35,'My stay at this Airbnb was fantastic! The space was clean, comfortable, and had all the amenities I needed for a great stay. The hosts were also incredibly friendly and helpful, providing plenty of information about the area and making sure I had everything I needed. The location was also ideal, with plenty of great restaurants and shops within walking distance.',5,5,5),(36,'This Airbnb was a true gem! The space was beautifully decorated and had all the amenities I needed for a comfortable stay. The hosts were also fantastic, making sure I had everything I needed and providing great recommendations for things to do and see in the area. The location was also great, with easy access to public transportation and plenty of great restaurants and bars nearby.',5,12,7);

INSERT INTO `property_images` VALUES ('https://drive.google.com/file/d/11r_SV56ibqqIcEVQe8rjqmXEsPjebX4h/view?usp=share_link',1),('https://drive.google.com/file/d/1AmqWWnL7GUFtMxsHKyUwjCUZb99MIvhg/view?usp=share_link',1),('https://drive.google.com/file/d/1XLJCZyv4XmfiY_pFNESbxFPCGCsJwU9t/view?usp=share_link',2),('https://drive.google.com/file/d/1cVpVm_eegRdPdP0b3ySofY7ngGW4gxdr/view?usp=share_link',2),('https://drive.google.com/file/d/1YkCHq-Bg5oRgd28RB2vp9xIfHBYWFIPZ/view?usp=share_link',3),('https://drive.google.com/file/d/1aDu54tA3CSLK3nlx57DegKcHX54-1PA3/view?usp=share_link',3),('https://drive.google.com/file/d/1-0EL7y_CNEGc5N-GLZ2fWg2WkTg_aD-k/view?usp=share_link',3),('https://drive.google.com/file/d/1wT8sEeZynRj_HY1V8Esn_Cy2PEFG47Du/view?usp=share_link',3),('https://drive.google.com/file/d/1FMMkC8hIYqQcr6miL8hillC-eLEDbRO1/view?usp=share_link',4),('https://drive.google.com/file/d/1KoKna8qMBF37m39W0VKUFVW5YORc9kl1/view?usp=share_link',4),('https://drive.google.com/file/d/1NFsn_L___11019yYUAqXlTfVPEv7pgIg/view?usp=share_link',4),('https://drive.google.com/file/d/1gMatcL4lGSEtlj5tkkJXf-6mTUx9M8J_/view?usp=share_link',5),('https://drive.google.com/file/d/1sr6rOhIu5NMG94nTu7pjOY2d89xs2Xpg/view?usp=share_link',5),('https://drive.google.com/file/d/183NkvOEzPzlU15D3S-Id3DRMLk-mhZxQ/view?usp=share_link',6),('https://drive.google.com/file/d/1eLu7lToo_XAugIK2o4G-KHT0U7rAun3s/view?usp=share_link',6),('https://drive.google.com/file/d/1PmqWNNvKb19lnwBjHC7TPj6R9AlKds0P/view?usp=share_link',6),('https://drive.google.com/file/d/1nV2UXrVCS75Kmn4Rmztuy2oRCJsn3z5A/view?usp=share_link',6),('https://drive.google.com/file/d/1csCZEOn2SrZwyKAffR9sVfi5EWRoNe2F/view?usp=share_link',6),('https://drive.google.com/file/d/1jkV0kQOmtjDLSrqdWm5pStgMhXvjxdLg/view?usp=share_link',6),('https://drive.google.com/file/d/1ErH0G_YU2-ZOk6yR5eEZMk7ituq3HI2b/view?usp=share_link',6),('https://drive.google.com/file/d/1lljG_lCbuhnyIIDXu1VO_MpbxApf_po8/view?usp=share_link',7),('https://drive.google.com/file/d/1f0lQsYXKqsJAUBPpFKRkkJMgWMhpnGB5/view?usp=share_link',9),('https://drive.google.com/file/d/1hmcN7ESsf_xMzQ70LMOlQOw_nBdIyW-F/view?usp=share_link',9),('https://drive.google.com/file/d/1m3En7kYjzuDWFU3mYE1GPBPzx1lB_FGu/view?usp=share_link',10),('https://drive.google.com/file/d/1chtbT1Om77hfDVxqcVRG4bkgkgqv6_Rk/view?usp=share_link',10),('https://drive.google.com/file/d/13OIqkuNAoSUmFD_UBdk_MgrxSsOk2RLN/view?usp=share_link',11),('https://drive.google.com/file/d/10LY7B3iY1M_A0zw6tF3z3oD6TgwjhXEV/view?usp=share_link',12),('https://drive.google.com/file/d/1tQ48KpzLqd-BKVFa_APoCcHvx-NSfrOt/view?usp=share_link',12),('https://drive.google.com/file/d/1ufvJzmep08K1HdyuCBwyiBcVTWE_cFLk/view?usp=share_link',12),('https://drive.google.com/file/d/1TDf-KNbt4-ij-yfN9Hyl4QvuATJTyifH/view?usp=share_link',12),('https://drive.google.com/file/d/1oDohm7LzF361Ts1IbjPgf8xUYFgITX2i/view?usp=share_link',12),('https://drive.google.com/file/d/1sWMml6himTYmOIw-XldtcSJMORvp4MlH/view?usp=share_link',13),('https://drive.google.com/file/d/1sUZT4Ao69eW0irgkMHV1gZ4cWs9C3IvZ/view?usp=share_link',14),('https://drive.google.com/file/d/1jepnaiLJS5tAdUzVTmvS4R4yk-GLbPsS/view?usp=share_link',14),('https://drive.google.com/file/d/1dCCjyZWDJmmSNIN2Sp9I0XidKt_9QPKl/view?usp=share_link',14),('https://drive.google.com/file/d/1PeYm6zwdNhzcNFzNXlCw2A1UK8Mo6ck-/view?usp=share_link',15),('https://drive.google.com/file/d/1rn6ydypBWJNl3IEZzVvfbqL9miLNILsS/view?usp=share_link',15),('https://drive.google.com/file/d/1mCZ44oiEvrYihfj0gpKp3lFO3Hl13yDB/view?usp=share_link',15),('https://drive.google.com/file/d/1nKbxmxsR1Ytq9obzdamRcqlt0jxvOT_2/view?usp=share_link',16),('https://drive.google.com/file/d/13PElz-ruqvEgcvKr1_ziELdiww5vwuC7/view?usp=share_link',16),('https://drive.google.com/file/d/1Go-EOPLDXOddc1jBTzyX_tns-FqjLdzx/view?usp=share_link',17),('https://drive.google.com/file/d/1k_tEh1vzWRH6DTKhJ9UdRwI18TcuMn9F/view?usp=share_link',17),('https://drive.google.com/file/d/1tDCjHm2zkNyf5SFAjbRXC9zHOHFklIcu/view?usp=share_link',17),('https://drive.google.com/file/d/1bTeT3sysTE-pJ6djDDQSq97bMe6f9QaL/view?usp=share_link',18),('https://drive.google.com/file/d/1xKmi5tx7zD7wxhHNfYHwPCZo1GIxDBck/view?usp=share_link',18),('https://drive.google.com/file/d/1pT8eqhv-9lejeDnefTiU6x4fTq95WHTQ/view?usp=share_link',19),('https://drive.google.com/file/d/1d93MnIgmQeEL0ekPV0OknYrp3su7rT1Y/view?usp=share_link',19),('https://drive.google.com/file/d/1xkNvM8JbRR48YVGheDvMYk3Es4RN1FNI/view?usp=share_link',19),('https://drive.google.com/file/d/1XkVur5dJpuxxldITZocGwEm2V-WK29Nm/view?usp=share_link',19),('https://drive.google.com/file/d/1xNmAAUHn8JKasuzHPgPfhqXDdgBZFScf/view?usp=share_link',20),('https://drive.google.com/file/d/19e0tW5r0mKo5L62SPSXRj9-nn4EdSaqI/view?usp=share_link',20),('https://drive.google.com/file/d/1JqcyOfMs-8BTJDFBPYm5XBK6uiJdITOF/view?usp=share_link',20),('https://drive.google.com/file/d/1Bw0QwSMRs00qSJQAJ_KG-vSKZTUYmJtG/view?usp=share_link',20),('https://drive.google.com/file/d/1Pshb1sC15wvv0pjyR4UVKLcTXZmHwldq/view?usp=share_link',20);

INSERT INTO `guest_review` VALUES (1,'It was a pleasure hosting Alexander! They were friendly, respectful of the space, and left the rental in great condition. I would welcome them back anytime.',5,1,1),(2,'I had a great experience hosting Alexander. They were communicative and easy to work with, and left the rental in impeccable condition. I would highly recommend them to any other hosts.',5,1,7),(3,'Thank you, Alexander, for choosing to stay in my rental! They were a great guest, leaving the space in excellent condition and showing a lot of respect for the property. I would be happy to host them again in the future.',5,1,17),(4,'I had a wonderful experience hosting Marija. They were communicative, respectful, and left the rental in great condition. I would definitely recommend them to other hosts and would welcome them back anytime.',5,2,2),(5,'It was a pleasure hosting [guest\'s name]. They were friendly, easy to communicate with, and left the rental in pristine condition. I would absolutely recommend them to any other hosts and would love to host them again in the future.',5,3,8),(6,'Hosting Florian was a breeze! They were a great communicator and left the rental in fantastic shape. I would highly recommend them to other hosts.',5,4,8),(7,'I had a great experience hosting Drazen. They were respectful of the space, followed all house rules, and left the rental in perfect condition. I would welcome them back anytime!',5,5,5),(8,'Thank you, Drazen, for being such a wonderful guest! They were friendly, tidy, and showed a lot of care for the rental. I would highly recommend them to other hosts.',5,5,15),(9,'I thoroughly enjoyed hosting Drazen. They were easy to communicate with, left the rental in great condition, and showed a lot of respect for the property. I would definitely recommend them to other hosts.',5,5,14),(10,'Hosting Jürgen was a great experience! They were a pleasure to communicate with, left the rental in pristine condition, and were overall fantastic guests. I would absolutely host them again.',5,12,12),(11,'While Jürgen was a decent guest overall, they did leave a few things in disarray and didn\'t follow all of the house rules. I would recommend more communication and care for the property in the future.',3,7,7),(12,'Hosting Jürgen was a bit of a challenge. While they were respectful of the space, they didn\'t communicate well and left a bit of a mess behind. I would recommend more attention to detail and better communication in the future.',2,7,20),(13,'Unfortunately, Jürgen was not the best guest. They didn\'t follow all of the house rules, were a bit messy, and didn\'t communicate well. I would recommend better care for the property and more consideration for the host in the future.',2,8,16),(14,'While Theresia was generally respectful of the space, they left a few things in disarray and didn\'t follow all of the house rules. I would recommend more attention to detail and better communication in the future.',2,9,8),(15,'Hosting [guest\'s name] was a bit disappointing. They didn\'t show much care for the property, left a mess behind, and didn\'t communicate well. I would recommend more consideration for the host and better care for the rental in the future.',1,9,16),(16,'Hosting Emilia was a wonderful experience! They were friendly, respectful, and left the rental in great condition. I would highly recommend them to any other hosts.',5,11,5),(17,'Thank you, Emilia, for being such a great guest! They were communicative, followed all house rules, and left the rental in immaculate condition. I would welcome them back anytime!',5,11,6),(18,'I had a fantastic experience hosting [guest\'s name]. They were friendly, easy to communicate with, and showed a lot of care for the property. I would definitely recommend them to other hosts and would love to host them again.',5,11,2),(19,'It was a pleasure hosting [guest\'s name]. They were respectful, tidy, and left the rental in great shape. I would highly recommend them to other hosts.',5,11,10),(20,'It was a pleasure hosting Elisabeth. They were respectful, tidy, and left the rental in great shape. I would highly recommend them to other hosts.',5,13,4),(21,'I had a great experience hosting Elisabeth. They were friendly, respectful, and left the rental in perfect condition. I would highly recommend them to other hosts.',4,13,2),(22,'Hosting Karner was a pleasure! They were communicative, respectful, and left the rental in great condition. I would welcome them back anytime.',4,14,7),(23,'Thank you, Herbert, for being such a wonderful guest! They were tidy, respectful, and showed a lot of care for the property. I would definitely recommend them to other hosts.',4,15,19),(24,'I thoroughly enjoyed hosting [guest\'s name]. They were communicative, followed all house rules, and left the rental in immaculate condition. I would highly recommend them to any other hosts.',5,15,15),(25,'I thoroughly enjoyed hosting Anton. They were communicative, followed all house rules, and left the rental in immaculate condition. I would highly recommend them to any other hosts.',5,20,20);

INSERT INTO `booking` VALUES (1,'2021-05-10','2021-05-17',4,1,1),(2,'2022-12-10','2022-12-17',2,5,1),(3,'2022-01-01','2022-01-16',3,18,1),(4,'2022-06-06','2022-08-01',5,2,2),(5,'2022-06-01','2022-07-01',5,16,2),(6,'2021-06-01','2021-07-01',2,10,2),(7,'2021-12-01','2021-12-16',6,11,2),(8,'2022-11-01','2022-11-16',4,13,2),(9,'2022-04-01','2022-04-04',3,4,4),(10,'2022-04-06','2022-04-08',3,13,4),(11,'2021-04-06','2021-04-08',1,16,4),(12,'2021-06-12','2021-06-14',1,17,4),(13,'2021-06-12','2021-06-14',2,11,5),(14,'2022-01-12','2022-01-14',3,11,6),(15,'2022-02-06','2022-03-06',2,1,7),(16,'2022-02-06','2022-03-06',2,14,7),(17,'2022-03-06','2022-03-09',2,3,8),(18,'2022-06-06','2022-06-12',4,4,8),(19,'2022-04-06','2022-04-12',3,9,8),(20,'2022-09-06','2022-09-12',1,9,16),(21,'2023-01-06','2023-01-12',1,9,11),(22,'2023-02-06','2023-02-12',2,8,16),(23,'2023-02-06','2023-02-20',3,20,20),(24,'2023-03-06','2023-03-20',3,15,15),(25,'2021-03-06','2021-03-20',3,16,7),(26,'2022-06-06','2022-06-20',2,1,17),(27,'2022-08-12','2022-08-20',4,1,16),(28,'2022-09-12','2022-09-20',4,11,13),(29,'2022-08-28','2022-09-24',5,7,7),(30,'2022-09-28','2022-10-05',5,7,20),(31,'2022-12-28','2023-01-05',2,14,5),(32,'2022-11-28','2022-11-30',2,15,19),(33,'2022-06-28','2022-06-30',1,15,5),(34,'2022-08-28','2022-09-06',2,5,5),(35,'2022-05-01','2022-05-06',2,7,12);

INSERT INTO `administrators` VALUES (1,'Benjamin','Button'),(2,'Heidi','Hütte'),(3,'Dagobert','Ente'),(4,'Igor','Mattaschitz'),(5,'Sebastian','Seppl'),(6,'Florian','Nürnmann'),(7,'Adelheid','Dorfner'),(8,'Siegmund','Freud'),(9,'Karl','Marx'),(10,'Olivia','Adams'),(11,'Jacob','Martinez'),(12,'Samantha','Taylor'),(13,'Alexander','White'),(14,'Emily','Wilson'),(15,'Ethan','Thompson'),(16,'Madison','Hiöö'),(17,'Ava','Flores'),(18,'Abigail','Cooper'),(19,'Grace','Parker'),(20,'Daniel','Reyes'),(21,'Gabriel','Forster');

INSERT INTO `payment_information` VALUES (1,'credit card','4700676839101872',NULL,1),(2,'credit card','5540137240169256',NULL,2),(3,'credit card','378552119460677',NULL,3),(4,'credit card','349254455069412',NULL,4),(5,'credit card','6011364994834517',NULL,5),(6,'credit card','4539366047546590',NULL,6),(7,'credit card','5271691481333117',NULL,7),(8,'credit card','6011661208654221',NULL,8),(9,'debit card','372667485491100',NULL,9),(10,'credit card','377614491457993',NULL,10),(11,'debit card','5311726238819851',NULL,11),(12,'credit card','4539579116538187',NULL,12),(13,'credit card','4539360993673573',NULL,13),(14,'credit card','4716433766693998',NULL,14),(15,'debit card','6011364994834517',NULL,15),(16,'bank transfer','AT16 4879 4512 6655',NULL,16),(17,'credit card','4532491010193126',NULL,17),(18,'credit card','6011242029128768',NULL,18),(19,'credit card','6011821278718492',NULL,19),(20,'bank transfer','GB89 7844 4566 0000',NULL,20),(21,'credit card','341685837175864',NULL,21),(22,'credit card','346368842479614',NULL,22),(23,'credit card','370862345192087',NULL,23),(24,'credit card','4716567305357910',1,NULL),(25,'credit card','5140476134232398',2,NULL),(26,'debit card','4467002169977950',2,NULL),(27,'credit card','6011532843592581',3,NULL),(28,'debit card','378817005412383',4,NULL),(29,'credit card','374281095320416',5,NULL),(30,'debit card','6011210039055925',5,NULL),(31,'debit card','371793606889815',6,NULL),(32,'credit card','374913846073379',7,NULL),(33,'credit card','6011350023326294',8,NULL),(34,'credit card','5207851121853812',9,NULL),(35,'debit card','4024007199373456',10,NULL),(36,'bank transfer','DE16 7888 8789 9879',11,NULL),(37,'credit card','4929815237926507',12,NULL),(38,'debit card','343434009848794',12,NULL),(39,'credit card','4647211928093248',13,NULL),(40,'credit card','4556438172118046',14,NULL),(41,'bank transfer','AT 5558 4551 1664',15,NULL),(42,'credit card','4556818690922237',16,NULL),(43,'credit card','5474389292668517',17,NULL),(44,'credit card','6011915121384963',18,NULL),(45,'credit card','377459757085694',19,NULL),(46,'credit card','343349348056331',20,NULL);

INSERT INTO `payment` VALUES (1,'Euro',560.56,'2021-01-02 00:00:00','Completed',1,1,1,1,1,1),(2,'Euro',610.32,'2022-11-09 00:00:00','Completed',1,1,5,2,1,5),(3,'Euro',256.32,'2022-01-01 00:00:00','Completed',1,1,18,3,1,18),(4,'Euro',458.65,'2022-03-03 00:00:00','Completed',2,2,2,4,6,2),(5,'Euro',741.13,'2022-04-03 00:00:00','Completed',2,2,16,5,4,16),(6,'Euro',741.13,'2022-04-03 00:00:00','Completed',2,2,10,6,6,10),(7,'Euro',548.44,'2021-01-03 00:00:00','Completed',2,2,11,7,12,11),(8,'Euro',114.12,'2022-08-03 00:00:00','Completed',2,2,13,8,12,13),(9,'Euro',114.12,'2022-08-03 00:00:00','Completed',3,3,4,9,20,4),(10,'Euro',687.65,'2022-08-03 00:00:00','Completed',4,4,13,10,17,13),(11,'Euro',987.45,'2021-03-03 00:00:00','Completed',4,4,16,11,2,16),(12,'Euro',147.66,'2021-01-03 00:00:00','Completed',4,4,17,12,12,17),(13,'Euro',666.56,'2021-01-03 00:00:00','Completed',5,5,11,13,7,11),(14,'Euro',666.56,'2021-11-03 00:00:00','Completed',6,6,11,14,17,11),(15,'Euro',313.15,'2022-11-03 00:00:00','Completed',7,7,1,15,7,1),(16,'Euro',114.54,'2022-06-03 00:00:00','Completed',7,7,14,16,7,14),(17,'Euro',984.45,'2022-02-13 00:00:00','Completed',8,8,3,17,9,3),(18,'Euro',789.45,'2022-06-11 00:00:00','Completed',8,8,4,18,7,4),(19,'Euro',644.13,'2022-04-01 00:00:00','Completed',8,8,9,19,3,19),(20,'Euro',162.13,'2022-09-05 00:00:00','Completed',16,16,9,20,6,9),(21,'Euro',145.33,'2023-01-01 00:00:00','Completed',11,11,9,21,9,9),(22,'Euro',1004.65,'2023-01-13 00:00:00','Completed',16,16,8,22,18,8),(23,'Euro',547.45,'2023-01-18 00:00:00','Completed',20,20,20,22,14,20),(24,'Euro',644.44,'2023-02-06 00:00:00','Completed',15,15,15,24,15,15),(25,'Euro',444.44,'2021-02-05 00:00:00','Completed',7,7,16,25,14,16),(26,'Euro',644.87,'2022-06-05 00:00:00','Completed',17,17,1,26,14,1),(27,'Euro',774.15,'2022-07-05 00:00:00','Completed',16,16,1,27,4,1),(28,'Euro',247.87,'2022-07-16 00:00:00','Completed',13,13,11,28,6,11),(29,'Euro',798.45,'2022-08-26 00:00:00','Completed',7,7,7,29,6,7),(30,'Euro',988.45,'2022-08-26 00:00:00','Completed',20,20,7,30,17,7),(31,'Euro',664.44,'2022-11-11 00:00:00','Completed',5,5,14,31,9,14),(32,'Euro',474.66,'2022-11-11 00:00:00','Completed',19,19,15,32,4,15),(33,'Euro',678.99,'2022-05-12 00:00:00','Completed',5,5,15,33,4,15),(34,'Euro',365.65,'2022-08-12 00:00:00','Completed',5,5,5,34,9,5),(35,'Euro',NULL,'2022-03-10 00:00:00','Completed',12,12,7,35,9,7);

INSERT INTO `amenities` VALUES (1,'Hair dryer',NULL),(2,'Washer',NULL),(3,'Dryer',NULL),(4,'Hangers',NULL),(5,'Iron',NULL),(6,'TV',NULL),(7,'Central air conditioning',NULL),(8,'Heating',NULL),(9,'WIFI',NULL),(10,'Free parking on premises',NULL),(11,'Shampoo',NULL),(12,'Essentials','Towels, bed sheets, soap, toilet paper'),(13,'Kitchen','Space where guests can cook their own meals'),(14,'Private entrance','Seperate street or building entrance'),(15,'Shared outdoor pool - available seasonally','Available from Jun to Sep'),(16,'Bathtub',NULL),(17,'Hot Water',NULL),(18,'Bed Linens',NULL),(19,'Extra Pillow and blankets',NULL),(20,'Room-darkening shades',NULL),(21,'indoor fireplace',NULL),(22,'fire extinguisher',NULL),(23,'Refrigerator',NULL),(24,'Microwave',NULL),(25,'Coffee Maker',NULL);

INSERT INTO `guest_adress` VALUES (1,1,17,1170,'Jörgerstraße','27/14',1),(2,1,17,1010,'Opernring','2/13',2),(3,2,19,10969,'Alexandrinenstraße ','118-121',3),(4,2,19,10969,'Kopenhagenerstraße ','72',4),(5,13,18,10000,'Ul. Ivana Kukuljevića ','5',5),(6,4,29,10000,'Piazza Castello','5',6),(7,2,28,80638,'Schloß Nymphenburg','1',7),(8,2,40,60323,'Wiesenau','1',8),(9,6,38,31535,'Gęsia ','22',9),(10,3,41,41006,'Calle Cortegana ','66',10),(11,8,20,1108,'Kozma','8-10',11),(12,12,34,1071,'Museumplein','6',12),(13,5,21,75007,'Av. Anatole France','5',13),(14,11,33,11825,'Kajplats','13',14),(15,3,27,8029,'Avinguda Diagonal','56',15),(16,18,51,8243,'S Circular Rd','77',16),(17,5,36,13006,'Rue Fort du Sanctuaire','1-9',17),(18,9,64,9000,'Knyaz Boris I','152',18),(19,2,48,70173,'Lautenschlagerstraße','12',19),(20,2,48,70173,'Lautenschlagerstraße','12',20);

INSERT INTO `property_availability` VALUES (1,'2023-04-08','2023-12-31',1),(2,'2023-04-08','2023-04-24',0),(2,'2023-04-24','2023-05-01',1),(2,'2023-05-02','2023-05-14',0),(2,'2023-05-15','2023-12-31',1),(3,'2023-04-08','2023-12-31',1),(4,'2023-04-08','2023-12-31',1),(5,'2023-04-08','2023-12-31',1),(6,'2023-04-08','2023-04-20',0),(6,'2023-04-20','2023-05-03',1),(6,'2023-05-04','2023-05-16',0),(6,'2023-05-17','2023-12-31',1),(7,'2023-04-08','2023-12-31',1),(8,'2023-04-08','2023-12-31',0),(9,'2023-04-08','2023-05-12',0),(9,'2023-05-12','2023-05-30',1),(9,'2023-05-31','2023-06-12',0),(9,'2023-06-13','2023-12-31',1),(11,'2023-04-08','2023-12-31',1),(12,'2023-04-08','2023-12-31',1),(10,'2023-04-08','2023-12-31',1),(13,'2023-04-08','2023-05-08',0),(13,'2023-05-09','2023-12-31',1),(14,'2023-04-08','2023-04-12',0),(14,'2023-04-13','2023-05-01',1),(14,'2023-05-02','2023-05-16',0),(14,'2023-05-17','2023-12-31',1),(15,'2023-04-08','2023-04-12',1),(15,'2023-04-13','2023-04-21',0),(15,'2023-04-22','2023-08-21',1),(15,'2023-08-22','2023-08-25',0),(15,'2023-08-26','2023-12-31',1),(16,'2023-04-08','2023-12-31',0),(17,'2023-04-08','2023-12-31',1),(18,'2023-04-08','2023-04-19',1),(18,'2023-04-20','2023-05-19',0),(18,'2023-05-20','2023-11-19',1),(18,'2023-11-20','2023-11-29',0),(18,'2023-11-30','2023-12-31',1),(20,'2023-04-08','2023-12-31',1);

INSERT INTO `languages` VALUES (1,'German'),(2,'French'),(3,'Spanish'),(4,'Italien'),(5,'French'),(6,'Polish'),(7,'Romanian'),(8,'Russian'),(9,'Hungarien'),(10,'Bulgarian'),(11,'Czech'),(12,'Swedish'),(13,'Dutch'),(14,'Croatien'),(15,'Finnish'),(16,'Greek'),(17,'Danish'),(18,'Latvian'),(19,'Lithuanien'),(20,'Portugeese'),(21,'Slovak'),(22,'English');

INSERT INTO `telephone_numbers` VALUES (1,'+43 650 421707927',NULL,1,NULL),(2,'+43 650 421707927',NULL,2,NULL),(3,'+43 672 041572',NULL,3,NULL),(4,'+43 651 54923',NULL,4,NULL),(5,'+43 687 388521',NULL,5,NULL),(6,'+49 15054 852214',NULL,6,NULL),(7,'+49 15006 140423',NULL,7,NULL),(8,'+36 162 42224207',NULL,8,NULL),(9,'+36 160 5436329',NULL,9,NULL),(10,'+55 1598 8031322',NULL,10,NULL),(11,'+55 1598 8031322',NULL,10,NULL),(12,'+76 170 33575835',NULL,11,NULL),(13,'+87 1519 4214800',NULL,12,NULL),(14,'+565 163 3274296',NULL,13,NULL),(15,'+420 1524 0765387',NULL,14,NULL),(16,'+420 170 64925737',NULL,15,NULL),(17,'+386 15505 366496',NULL,16,NULL),(18,'+386 176 43104692',NULL,16,NULL),(19,'+387 160 5195096',NULL,17,NULL),(20,'+66 1595 0895909',NULL,18,NULL),(21,'+77 178 82173030',NULL,19,NULL),(22,'+22 179 6869630',NULL,19,NULL),(23,'+01 15847 753801',NULL,20,NULL),(24,'+01 177 81800498',NULL,20,NULL),(25,'+43 650 434507927',NULL,NULL,1),(26,'+43 650 434407927',NULL,NULL,2),(27,'+43 672 041456572',NULL,NULL,3),(28,'+43 651 57653',NULL,NULL,4),(29,'+43 687 385671',NULL,NULL,5),(30,'+49 15054 856756714',NULL,NULL,6),(31,'+49 15006 1567553',NULL,NULL,7),(32,'+36 162 44246207',NULL,NULL,8),(33,'+36 160 3463429',NULL,NULL,9),(34,'+55 1598 83464322',NULL,NULL,10),(35,'+55 1598 346622',NULL,NULL,10),(36,'+76 170 3345635',NULL,NULL,11),(37,'+87 1519 43465300',NULL,NULL,12),(38,'+565 16363396',NULL,NULL,13),(39,'+420 1524 07345687',NULL,NULL,14),(40,'+420 170 64347537',NULL,NULL,15),(41,'+386 15505 385676',NULL,NULL,16),(42,'+386 176 856792',NULL,NULL,16),(43,'+387 160 5856796',NULL,NULL,17),(44,'+66 1595 0654909',NULL,NULL,18),(45,'+77 178 8246530',NULL,NULL,19),(46,'+22 179 687892',NULL,NULL,19),(47,'+01 15847 753454',NULL,NULL,20),(48,'+01 177 4564598',NULL,NULL,20),(49,'+43 650 456456',1,NULL,NULL),(50,'+43 650 5234254',2,NULL,NULL),(51,'+43 672 2453555',3,NULL,NULL),(52,'+43 651 253453',4,NULL,NULL),(53,'+43 687 6463456',5,NULL,NULL),(54,'+49 15054 4564356',6,NULL,NULL),(55,'+49 15006 45677456',7,NULL,NULL),(56,'+36 162 7456756',8,NULL,NULL),(57,'+36 160 14232314',9,NULL,NULL),(58,'+55 1598 75475676',10,NULL,NULL),(59,'+55 1598 744567',10,NULL,NULL),(60,'+76 170 25342354',11,NULL,NULL),(61,'+87 1519 75674576',12,NULL,NULL),(62,'+565 3452253',13,NULL,NULL),(63,'+420 1524 5234545',14,NULL,NULL),(64,'+420 170 23454523',15,NULL,NULL),(65,'+386 15505 646656',16,NULL,NULL),(66,'+386 176 745676',16,NULL,NULL),(67,'+387 160 433412',17,NULL,NULL),(68,'+66 1595 3456456',18,NULL,NULL),(69,'+77 178 43564536',19,NULL,NULL),(70,'+22 179 544567892',19,NULL,NULL),(71,'+01 15847 4535454',20,NULL,NULL),(72,'+01 177 45232435',20,NULL,NULL);

INSERT INTO `e_mail` VALUES (1,'jklöjk@dummy.de',1,NULL,NULL),(2,'dfgs@dummy.de',2,NULL,NULL),(3,'fdghk@dummy.de',3,NULL,NULL),(4,'hdfg@dummy.de',4,NULL,NULL),(5,'dfghhhk@dummy.de',5,NULL,NULL),(6,'dfghghfgd@dummy.de',6,NULL,NULL),(7,'asdafsdfd@dummy.de',6,NULL,NULL),(8,'gfjhg@dummy.de',7,NULL,NULL),(9,'jfhgghj@dummy.de',7,NULL,NULL),(10,'fjghghjs@dummy.de',8,NULL,NULL),(11,'gdfsgdfsg@dummy.de',9,NULL,NULL),(12,'hfgdhfg@dummy.de',10,NULL,NULL),(13,'jfhghj@dummy.de',11,NULL,NULL),(14,'fghjjh@dummy.de',12,NULL,NULL),(15,'fghjghjf@dummy.de',13,NULL,NULL),(16,'twrewert@dummy.de',14,NULL,NULL),(17,'itzui@dummy.de',15,NULL,NULL),(18,'jhfgghj@dummy.de',16,NULL,NULL),(19,'xvxcbbv@dummy.de',17,NULL,NULL),(20,'kjfghj@dummy.de',18,NULL,NULL),(21,'ghjfkk@dummy.de',19,NULL,NULL),(22,'dfghdfgh@dummy.de',20,NULL,NULL),(23,'dfghdfgh@dummy.de',20,NULL,NULL),(24,'dfghfgh@dummy.de',NULL,NULL,1),(25,'dfhgfghd@dummy.de',NULL,NULL,2),(26,'erwztrtzert@dummy.de',NULL,NULL,3),(27,'erzteh@dummy.de',NULL,NULL,4),(28,'dfghhjdf@dummy.de',NULL,NULL,5),(29,'ghjkghjk@dummy.de',NULL,NULL,6),(30,'cvbbnv@dummy.de',NULL,NULL,6),(31,'bdfgh@dummy.de',NULL,NULL,7),(32,'nzreur@dummy.de',NULL,NULL,7),(33,'dffgh@dummy.de',NULL,NULL,8),(34,'hjkgkghj@dummy.de',NULL,NULL,9),(35,'bvncvbn@dummy.de',NULL,NULL,10),(36,'lklghl@dummy.de',NULL,NULL,11),(37,'wsertgesg@dummy.de',NULL,NULL,12),(38,'hfgjjkfh@dummy.de',NULL,NULL,13),(39,'öklöhjk@dummy.de',NULL,NULL,14),(40,'rtzurtzu@dummy.de',NULL,NULL,15),(41,'rtuzifghj@dummy.de',NULL,NULL,16),(42,'fjghjfgh@dummy.de',NULL,NULL,17),(43,'sdfghgsd@dummy.de',NULL,NULL,18),(44,'xcvbxcvvb@dummy.de',NULL,NULL,19),(45,'sfdgshdfgfgdh@dummy.de',NULL,NULL,20),(46,'fjghfghj@dummy.de',NULL,NULL,20),(47,'jkfghj@dummy.de',NULL,1,NULL),(48,'dfhgxfjzztedfghd@dummy.de',NULL,2,NULL),(49,'khjk@dummy.de',NULL,3,NULL),(50,'asddfs@dummy.de',NULL,4,NULL),(51,'g445gdf@dummy.de',NULL,5,NULL),(52,'dfh66@dummy.de',NULL,6,NULL),(53,'hgdfh3@dummy.de',NULL,6,NULL),(54,'ghjdll@dummy.de',NULL,7,NULL),(55,'lljhl@dummy.de',NULL,7,NULL),(56,'gscbcvcvb@dummy.de',NULL,8,NULL),(57,'vbm@dummy.de',NULL,9,NULL),(58,'hdghfdfgh@dummy.de',NULL,10,NULL),(59,'j545nn@dummy.de',NULL,11,NULL),(60,'dyfgf3@dummy.de',NULL,12,NULL),(61,'xcvbj56@dummy.de',NULL,13,NULL),(62,'hfgdhd@dummy.de',NULL,14,NULL),(63,'hdfghf@dummy.de',NULL,15,NULL),(64,'hh55h5h@dummy.de',NULL,16,NULL),(65,'dfghdfgh@dummy.de',NULL,17,NULL),(66,'ncvbncvb@dummy.de',NULL,18,NULL),(67,'zdfgh56@dummy.de',NULL,19,NULL),(68,'kghjkg@dummy.de',NULL,20,NULL),(69,'lhjfssss@dummy.de',NULL,20,NULL);

INSERT INTO `costs` VALUES (1,110.10,12.00,60.00,1),(2,105.16,13.00,80.00,2),(3,130.50,18.00,70.00,3),(4,160.64,22.00,60.00,4),(5,90.00,10.00,80.00,5),(6,150.45,16.00,40.00,6),(7,189.19,19.00,40.00,7),(8,216.12,33.00,40.00,8),(9,60.50,8.00,55.00,9),(10,140.98,16.00,60.00,10),(11,105.56,11.00,70.00,11),(12,312.55,28.00,60.00,12),(13,156.45,16.00,80.00,13),(14,150.44,12.00,60.00,14),(15,112.12,11.00,40.00,15),(16,89.89,9.00,55.00,16),(17,205.65,26.00,50.00,17),(18,119.10,12.00,60.00,18),(19,189.65,18.00,50.00,19),(20,135.42,15.00,60.00,20);

INSERT INTO `property_has_amenities` VALUES (1,1),(3,1),(7,1),(12,1),(19,1),(20,1),(1,2),(5,3),(6,3),(7,3),(8,3),(11,3),(16,3),(18,3),(19,3),(20,3),(3,4),(9,4),(10,4),(11,4),(15,4),(2,5),(2,6),(5,6),(8,6),(11,6),(12,6),(16,6),(17,6),(9,7),(1,8),(10,8),(15,8),(7,9),(16,9),(17,9),(18,9),(20,9),(16,10),(17,10),(5,11),(4,12),(5,12),(6,12),(9,13),(16,13),(17,13),(20,14),(5,15),(10,15),(11,15),(2,16),(4,16),(7,16),(13,16),(8,18),(14,18),(1,19),(5,19),(6,19),(9,19),(11,19),(13,19),(15,19),(20,19),(14,20),(10,21),(19,21),(14,22),(18,22),(20,23),(3,24),(11,24),(2,25),(12,25),(14,25);

INSERT INTO `hosts_has_languages` VALUES (2,2,'Mother Tongue'),(3,6,'Mother Tongue'),(4,18,'Mother Tongue'),(5,20,'Mother Tongue'),(6,16,'Mother Tongue'),(7,4,'Mother Tongue'),(8,5,'Mother Tongue'),(9,9,'Mother Tongue'),(10,19,'Mother Tongue'),(11,20,'Mother Tongue'),(12,18,'Mother Tongue'),(13,2,'Mother Tongue'),(14,17,'Mother Tongue'),(15,11,'Mother Tongue'),(16,16,'Mother Tongue'),(17,4,'Mother Tongue'),(18,4,'Mother Tongue'),(19,1,'Mother Tongue'),(20,1,'Mother Tongue'),(1,1,'Mother Tongue');

INSERT INTO `guests_has_languages` VALUES (1,1,'Mother tounge'),(1,22,'Advanced'),(2,2,'Mother Tongue'),(3,6,'Mother Tongue'),(4,18,'Mother Tongue'),(5,20,'Mother Tongue'),(6,16,'Mother Tongue'),(7,4,'Mother Tongue'),(8,5,'Mother Tongue'),(9,9,'Mother Tongue'),(10,19,'Mother Tongue'),(11,20,'Mother Tongue'),(12,18,'Mother Tongue'),(13,2,'Mother Tongue'),(14,17,'Mother Tongue'),(15,11,'Mother Tongue'),(16,16,'Mother Tongue'),(17,4,'Mother Tongue'),(18,4,'Mother Tongue'),(19,1,'Mother Tongue'),(20,1,'Mother Tongue'),(2,5,'Advanced'),(3,7,'Advanced'),(4,8,'Advanced'),(5,2,'Advanced'),(6,6,'Advanced'),(7,14,'Advanced'),(8,15,'Advanced'),(9,19,'Advanced'),(10,9,'Advanced'),(11,2,'Advanced'),(12,8,'Advanced'),(13,12,'Advanced'),(14,7,'Advanced'),(15,1,'Advanced'),(16,6,'Beginner'),(17,14,'Beginner'),(18,14,'Beginner'),(19,11,'Beginner'),(20,11,'Beginner'),(21,17,'Beginner'),(1,11,'Beginner');

INSERT INTO `administrators_has_languages` VALUES (2,2,'Mother Tongue'),(3,6,'Mother Tongue'),(4,18,'Mother Tongue'),(5,20,'Mother Tongue'),(6,16,'Mother Tongue'),(7,4,'Mother Tongue'),(8,5,'Mother Tongue'),(9,9,'Mother Tongue'),(10,19,'Mother Tongue'),(11,20,'Mother Tongue'),(12,18,'Mother Tongue'),(13,2,'Mother Tongue'),(14,17,'Mother Tongue'),(15,11,'Mother Tongue'),(16,16,'Mother Tongue'),(17,4,'Mother Tongue'),(18,4,'Mother Tongue'),(19,1,'Mother Tongue'),(20,1,'Mother Tongue'),(21,7,'Mother Tongue'),(1,1,'Mother Tongue'),(2,5,'Advanced'),(3,7,'Advanced'),(4,8,'Advanced'),(5,2,'Advanced'),(6,6,'Advanced'),(7,14,'Advanced'),(8,15,'Advanced'),(9,19,'Advanced'),(10,9,'Advanced'),(11,2,'Advanced'),(12,8,'Advanced'),(13,12,'Advanced'),(14,7,'Advanced'),(15,1,'Advanced'),(16,6,'Beginner'),(17,14,'Beginner'),(18,14,'Beginner'),(19,11,'Beginner'),(20,11,'Beginner'),(21,17,'Beginner'),(1,11,'Beginner');

INSERT INTO `beds` VALUES (1,'Single Bed'),(2,'Double Bed'),(3,'King Size Bed'),(4,'Queen Size Bed'),(5,'Sofa Bed');

INSERT INTO `properties_has_beds` VALUES (1,1,1),(1,2,1),(2,1,2),(2,2,1),(3,1,1),(4,3,2),(4,4,1),(4,1,1),(5,5,2),(5,4,1),(6,1,1),(7,2,3),(7,3,2),(7,4,1),(8,5,1),(8,3,2),(9,4,1),(10,1,1),(11,2,2),(11,1,1),(12,3,2),(11,3,2),(13,1,1),(13,2,1),(14,3,1),(15,1,1),(15,2,3),(15,3,1),(16,1,1),(17,5,1),(18,3,3),(19,1,1),(20,1,2),(20,2,1),(20,5,1);

