-- MySQL Script generated by MySQL Workbench
-- 07/27/15 21:09:36
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`TEACHER_DASHBOARD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TEACHER_DASHBOARD` (
  `Teacher_Dashboard_seq` INT NOT NULL COMMENT '',
  `First name` VARCHAR(45) NOT NULL COMMENT '',
  `Last name` VARCHAR(45) NOT NULL COMMENT '',
  `Email` VARCHAR(45) NOT NULL COMMENT '',
  `Password` VARCHAR(45) NOT NULL COMMENT '',
  `Country` VARCHAR(45) NOT NULL COMMENT '',
  `Role` VARCHAR(45) NOT NULL COMMENT '',
  `PROCESS_Process_seq` INT NOT NULL COMMENT '',
  `PROCESS_STUDENT_SOLVED_QUIZ_Student_solved_quiz_seq` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Teacher_Dashboard_seq`, `PROCESS_Process_seq`, `PROCESS_STUDENT_SOLVED_QUIZ_Student_solved_quiz_seq`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`STUDENT_LOGIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`STUDENT_LOGIN` (
  `Student_seq` INT NOT NULL COMMENT '',
  `Teacher_Room_Number` INT NOT NULL COMMENT '',
  `TEACHER_DASHBOARD_Teacher_Dashboard_seq` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Student_seq`, `Teacher_Room_Number`, `TEACHER_DASHBOARD_Teacher_Dashboard_seq`)  COMMENT '',
  INDEX `fk_STUDENT_LOGIN_TEACHER_DASHBOARD_idx` (`TEACHER_DASHBOARD_Teacher_Dashboard_seq` ASC)  COMMENT '',
  CONSTRAINT `fk_STUDENT_LOGIN_TEACHER_DASHBOARD`
    FOREIGN KEY (`TEACHER_DASHBOARD_Teacher_Dashboard_seq`)
    REFERENCES `mydb`.`TEACHER_DASHBOARD` (`Teacher_Dashboard_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transaction` (
  `seq` INT NOT NULL COMMENT '',
  `transaction_teacher_se` INT NOT NULL COMMENT '',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  `is_favorite` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '',
  PRIMARY KEY (`seq`)  COMMENT '',
  INDEX `transaction_teacher_seq_fkey_idx` (`transaction_teacher_se` ASC)  COMMENT '',
  CONSTRAINT `transaction_teacher_seq_fkey`
    FOREIGN KEY (`transaction_teacher_se`)
    REFERENCES `mydb`.`TEACHER_DASHBOARD` (`Teacher_Dashboard_seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reports` (
  `Report_seq` INT NOT NULL COMMENT '',
  `Recent` TINYINT(1) NOT NULL COMMENT '',
  `All` TINYINT(1) NOT NULL COMMENT '',
  `Quizzes` TINYINT(1) NOT NULL COMMENT '',
  `Exit_Tickets` TINYINT(1) NOT NULL COMMENT '',
  `Short_Answers` TINYINT(1) NOT NULL COMMENT '',
  `Archived_Reports` TINYINT(1) NOT NULL COMMENT '',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `transaction_seq` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Report_seq`)  COMMENT '',
  INDEX `report_transaction_seq_fkey_idx` (`transaction_seq` ASC)  COMMENT '',
  CONSTRAINT `report_transaction_seq_fkey`
    FOREIGN KEY (`transaction_seq`)
    REFERENCES `mydb`.`transaction` (`seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `seq` INT NOT NULL COMMENT '',
  `first_answer` INT NOT NULL COMMENT '',
  `second_answer` INT NOT NULL COMMENT '',
  `thrid_answer` INT NOT NULL COMMENT '',
  `student_seq` INT NULL COMMENT '',
  PRIMARY KEY (`seq`, `first_answer`)  COMMENT '',
  INDEX `ticket_student_seq_fkey_idx` (`student_seq` ASC)  COMMENT '',
  CONSTRAINT `ticket_student_seq_fkey`
    FOREIGN KEY (`student_seq`)
    REFERENCES `mydb`.`STUDENT_LOGIN` (`Student_seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`quiz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`quiz` (
  `Quiz_seq` INT NOT NULL COMMENT '',
  `teacher_seq` INT NOT NULL COMMENT '',
  `type` VARCHAR(45) NULL COMMENT '',
  `type_seq` INT NULL COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  `quiz` VARCHAR(45) NULL COMMENT '',
  `hint` VARCHAR(45) NULL COMMENT '',
  `is_favorite` TINYINT(1) NULL COMMENT '',
  `quiz_true_false_answer` INT NULL COMMENT '',
  `multi_answer1` INT NULL COMMENT '',
  `multi_answer2` INT NULL COMMENT '',
  `multi_answer3` INT NULL COMMENT '',
  `multi_answer4` INT NULL COMMENT '',
  `multi_answer5` INT NULL COMMENT '',
  `quiz_final_answer` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`Quiz_seq`)  COMMENT '',
  INDEX `quiz_teacher_seq_idx` (`teacher_seq` ASC)  COMMENT '',
  CONSTRAINT `quiz_teacher_seq`
    FOREIGN KEY (`teacher_seq`)
    REFERENCES `mydb`.`TEACHER_DASHBOARD` (`Teacher_Dashboard_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student_solved_quiz_1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student_solved_quiz_1` (
  `seq` INT NOT NULL COMMENT '',
  `quiz_seq` INT NOT NULL COMMENT '',
  `student_seq` INT NOT NULL COMMENT '',
  `transaction_seq` INT NOT NULL COMMENT '',
  `student_answer1` VARCHAR(45) NULL COMMENT '',
  `student_answer2` INT NULL COMMENT '',
  PRIMARY KEY (`seq`)  COMMENT '',
  INDEX `student_solved_quiz_seq_idx` (`quiz_seq` ASC)  COMMENT '',
  INDEX `student_solved_quiz_student_seq_idx` (`student_seq` ASC)  COMMENT '',
  INDEX `student_solved_quiz_transaction_seq_idx` (`transaction_seq` ASC)  COMMENT '',
  CONSTRAINT `student_solved_quiz_seq`
    FOREIGN KEY (`quiz_seq`)
    REFERENCES `mydb`.`quiz` (`Quiz_seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `student_solved_quiz_student_seq`
    FOREIGN KEY (`student_seq`)
    REFERENCES `mydb`.`STUDENT_LOGIN` (`Student_seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `student_solved_quiz_transaction_seq`
    FOREIGN KEY (`transaction_seq`)
    REFERENCES `mydb`.`transaction` (`seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
