use china;

SELECT * FROM jsMember;
SELECT * FROM jsSurveyName;

INSERT INTO jsMemberName(
    nickname,
    dob,
    gender,
    email,
    id,
    datetime
)
VALUES(
	"백설공주",
    "20020222",
    2,
    "jiwon0222@naver.com",
    "jiwon0222",
    "20200803"
)
;

SELECT * FROM jsSurveyQuestion;
INSERT INTO jsSurveyQuestion(
	jsSurveyName_seq,
    question,
    questionContent
)
VALUES(
	1,
    4,
    ""
)
;

SELECT * FROM jsQuestionChoice;
INSERT INTO jsQuestionChoice(
	jsSurveyQuestion_seq,
    choice,
    choiceContent,
    choiceScore
)
VALUES(
	3,
    4,
    "섬에 아직 무엇이 있을지 모른다. 안식처 문제부터 해결한다.",
    5
)
;
CREATE TABLE IF NOT EXISTS `china`.`jsSurveySelected` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `jsMember_seq` INT NOT NULL,
  `jsSurveyName_seq` INT NOT NULL,
  `question` INT NULL,
  `choosed` INT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_jsSurveySelected_jsMember1_idx` (`jsMember_seq` ASC) VISIBLE,
  INDEX `fk_jsSurveySelected_jsSurveyName1_idx` (`jsSurveyName_seq` ASC) VISIBLE,
  CONSTRAINT `fk_jsSurveySelected_jsMember1`
    FOREIGN KEY (`jsMember_seq`)
    REFERENCES `china`.`jsMember` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jsSurveySelected_jsSurveyName1`
    FOREIGN KEY (`jsSurveyName_seq`)
    REFERENCES `china`.`jsSurveyName` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
;
SELECT * FROM jsSurveySelected;
INSERT INTO jsSurveySelected(
	jsMember_seq,
    jsSurveyName_seq,
    question,
    choosed   
)
VALUES(
	2,
    1,
    3,
    2
)
;

SELECT * FROM jsSurveyResult;
INSERT INTO jsSurveyResult(
	jsSurveyName_seq,
    resultNum,
    resultTitle,
    resultContent,
    scoreRangeStart,
    scoreRangeEnd
)
VALUES(
	1,
    4,
	"사막? 껌이지",
    "어디에 낙오되도 살아남을 수 있는 당신! 준비없이 사막 건너기 챌린지를 해보세요! 아무것도 없어보이는 사막에서도 당신은 생존가능성을 찾을 수 있을 인재입니다!",
    24,
    30
)
;

SELECT * FROM jsSurveyRecord;
INSERT INTO jsSurveyRecord(
	jsMember_seq,
    jsSurveyName_seq,
    totalScore,
    jsSurveyResult_seq,
    datetime
)
VALUES(
	2,
    1,
    12,
    1,
    "2022-06-07 12:25:23"    
)
;