-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Epulet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Epulet` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nev` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Nev_UNIQUE` (`Nev` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terem` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nev` VARCHAR(45) NULL,
  `Ferohely` INT NULL,
  `Epulet_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  UNIQUE INDEX `Nev_UNIQUE` (`Nev` ASC),
  INDEX `fk_Terem_Epulet_idx` (`Epulet_ID` ASC),
  CONSTRAINT `fk_Terem_Epulet`
    FOREIGN KEY (`Epulet_ID`)
    REFERENCES `mydb`.`Epulet` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ------------------------------------------------ --
-- query
-- ------------------------------------------------ --
use mydb;

insert into epulet (nev) values ('I épület');								-- 1
insert into epulet (nev) values ('St épület');								-- 2
insert into epulet (nev) values ('Ch épület');								-- 3
select * from epulet;

insert into terem (nev, ferohely, epulet_ID) values ('IE007', 200, 1);		-- 1
insert into terem (nev, ferohely, epulet_ID) values ('IB028', 400, 1); 		-- 2
insert into terem (nev, ferohely, epulet_ID) values ('StNagy', 380, 2); 	-- 3
insert into terem (nev, ferohely, epulet_ID) values ('ChMax', 550, 3); 		-- 4
select * from terem;


select epulet.nev as 'Épület', count(terem.id) as 'Termek száma', sum(terem.ferohely) as 'Összes férőhely' from terem
	inner join epulet on terem.Epulet_ID = epulet.id
    group by epulet.nev
    having sum(terem.ferohely) > 500
    order by epulet.nev ASC;
