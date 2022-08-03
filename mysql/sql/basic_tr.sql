
-- china database를 사용하겠다.
use china;

-- *************** 테이블 수정 전에 항상 꼭! 반드시!! EER 먼저 수정할것 *******************

-- 전체 column 조회  하지만 이 쿼리창 과정에선 쓰지않는다. 전체 데이터를 불러와 프로세스 시간이 길어지기 때문
SELECT * FROM nation;

-- column 추가
ALTER TABLE nation ADD COLUMN color varchar(45);

-- column 추가 위치 
ALTER TABLE nation ADD COLUMN nameKor varchar(45) AFTER name;

-- column 데이터 타입 변경 
ALTER TABLE nation MODIFY COLUMN nameKor varchar(100);

-- column 이름 변경 
ALTER TABLE nation CHANGE color flower varchar(45);

-- column 삭제 
ALTER TABLE nation DROP COLUMN flower;

-- row 삭제
DELETE FROM nation WHERE seq=3;

-- 데이터 갱신/ 고치기
UPDATE nation SET 
	capital="Kyoto"
WHERE 1 = 1 
AND name = "Japan";

-- 데이터 검색 방법
SELECT * FROM nation
WHERE 1=1
-- AND name like "U%"; -- 문자
-- AND name like "%a";
-- AND name like "%n%";
-- AND people > 100000000; --숫자
-- AND people between 50000000 and 70000000;
-- AND nameKor is not null; --none data
AND capital like "";


-- 테이블 추가
CREATE TABLE IF NOT EXISTS `china`.`jsQuestionChoice` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `jsSurveyQuestion_seq` INT NOT NULL,
  `choice` INT NULL,
  `choiceContent` VARCHAR(45) NULL,
  `choiceScore` INT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_jsQuestionChoice_jsSurveyQuestion1_idx` (`jsSurveyQuestion_seq` ASC) VISIBLE,
  CONSTRAINT `fk_jsQuestionChoice_jsSurveyQuestion1`
    FOREIGN KEY (`jsSurveyQuestion_seq`)
    REFERENCES `chinajsSurveySelected`.`jsSurveyQuestion` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;

-- 테이블 내 데이터 삽입
INSERT INTO nation(
    name,
    capital,
    nameKor,
    people
)
VALUES (
	"Germany",
    "Berlin"
    "독일",
    83883587
)
;

-- 선택한 테이블의 선택한 column 값들 목록 표기
SELECT 
	seq,
    name,
    capital,
    nameKor
FROM nation
;