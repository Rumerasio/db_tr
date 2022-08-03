CREATE TABLE IF NOT EXISTS `china`.`codeGroup` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`seq`))
ENGINE = InnoDB
;

CREATE TABLE IF NOT EXISTS `china`.`code` (
  `seq` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `codeGroup_seq` INT NOT NULL,
  INDEX `fk_code_codeGroup1_idx` (`codeGroup_seq` ASC) VISIBLE,
  CONSTRAINT `fk_code_codeGroup1`
    FOREIGN KEY (`codeGroup_seq`)
    REFERENCES `china`.`codeGroup` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;

INSERT INTO code(
	seq,
	name,
    codeGroup_seq
)
VALUES(
	5,
	"직접입력",
    3
)
;

UPDATE code SET 
	seq=305
WHERE 1 = 1 
AND name = "직접입력"

