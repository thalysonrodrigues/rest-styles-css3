-- MySQL Script generated by MySQL Workbench
-- dom 22 jul 2018 19:43:49 -04
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema rest_styles_css3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rest_styles_css3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rest_styles_css3` DEFAULT CHARACTER SET utf8 ;
USE `rest_styles_css3` ;

-- -----------------------------------------------------
-- Table `rest_styles_css3`.`USERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`USERS` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `admin` TINYINT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`CATEGORIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`CATEGORIES` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`TAGS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`TAGS` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `element` VARCHAR(25) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `id_category` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_TAGS_CATEGORY1_idx` (`id_category` ASC),
  UNIQUE INDEX `element_UNIQUE` (`element` ASC),
  CONSTRAINT `fk_TAGS_CATEGORY1`
    FOREIGN KEY (`id_category`)
    REFERENCES `rest_styles_css3`.`CATEGORIES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`CSS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`CSS` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `style` LONGTEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` TINYINT NOT NULL DEFAULT 0,
  `author` INT UNSIGNED NOT NULL,
  `tag` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_CSS_USERS_idx` (`author` ASC),
  INDEX `fk_CSS_CATEGORY1_idx` (`tag` ASC),
  CONSTRAINT `fk_CSS_USERS`
    FOREIGN KEY (`author`)
    REFERENCES `rest_styles_css3`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CSS_CATEGORY1`
    FOREIGN KEY (`tag`)
    REFERENCES `rest_styles_css3`.`TAGS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`LOGS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`LOGS` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_user` INT UNSIGNED NOT NULL,
  `signin_dt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `signout_dt` TIMESTAMP NULL,
  `status` TINYINT NOT NULL DEFAULT 0,
  `timeout` TINYINT NOT NULL DEFAULT 0,
  `ip` VARCHAR(45) NOT NULL,
  `browser` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_LOGS_USERS1_idx` (`id_user` ASC),
  CONSTRAINT `fk_LOGS_USERS1`
    FOREIGN KEY (`id_user`)
    REFERENCES `rest_styles_css3`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`CSS_HISTORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`CSS_HISTORY` (
  `status` TINYINT NOT NULL,
  `date_time` TIMESTAMP NOT NULL,
  `id_user` INT UNSIGNED NOT NULL,
  `id_css` INT UNSIGNED NOT NULL,
  INDEX `fk_CSS_HISTORY_USERS1_idx` (`id_user` ASC),
  INDEX `fk_CSS_HISTORY_CSS1_idx` (`id_css` ASC),
  CONSTRAINT `fk_CSS_HISTORY_USERS1`
    FOREIGN KEY (`id_user`)
    REFERENCES `rest_styles_css3`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CSS_HISTORY_CSS1`
    FOREIGN KEY (`id_css`)
    REFERENCES `rest_styles_css3`.`CSS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`PASSWORD_RECOVERY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`PASSWORD_RECOVERY` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `jti` VARCHAR(255) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  `latest` TIMESTAMP NOT NULL,
  `id_user` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PASSWORD_RECOVERY_USERS1_idx` (`id_user` ASC),
  UNIQUE INDEX `jti_UNIQUE` (`jti` ASC),
  CONSTRAINT `fk_PASSWORD_RECOVERY_USERS1`
    FOREIGN KEY (`id_user`)
    REFERENCES `rest_styles_css3`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rest_styles_css3`.`BLACKLIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rest_styles_css3`.`BLACKLIST` (
  `jti` VARCHAR(255) NOT NULL,
  UNIQUE INDEX `jti_UNIQUE` (`jti` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
