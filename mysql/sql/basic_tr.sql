
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


-- 테이블 추가
CREATE TABLE IF NOT EXISTS `china`.`nation` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `capital` VARCHAR(45) NULL,
  `people` INT NULL,
  PRIMARY KEY (`seq`))
ENGINE = InnoDB
;

-- 테이블 내 데이터 삽입
INSERT INTO nation(
    name,
    capital,
    people
)
VALUES (
	"China",
    "Beijing",
    1300000000
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