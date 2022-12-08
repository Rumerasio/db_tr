SELECT * FROM china.jsSurveyRecord;

SHOW INDEX FROM jsSurveyRecord;

CREATE INDEX dxResult ON jsSurveyRecord (jsSurveyResult_srSeq, jsSurveyName_snSeq);

SET GLOBAL log_bin_trust_function_creators = 1; //ON

-- 함수
DELIMITER $$
CREATE FUNCTION getNickname (
seq int
) 
RETURNS varchar(45)
BEGIN
    declare rtNickname varchar(45);

	select
		nickname into rtNickname
	from
		jsMember c
	where 1=1
		and c.seq = seq
	;
	RETURN rtNickname;
END$$
DELIMITER ;

SELECT * FROM V_jsSurveyRecord;

ALTER TABLE jsSurveyQuestion AUTO_INCREMENT = 8;

SELECT
	srcSeq
	,getNickname(jsMember_seq) as nickname
	,(SELECT survey FROM jsSurveyName b WHERE b.snSeq = a.jsSurveyName_snSeq) as survey
	,totalScore
	,(SELECT resultTitle From jsSurveyResult d WHERE d.srSeq = a.jsSurveyResult_srSeq) as resultTitle
	,datetime
FROM jsSurveyRecord a   
WHERE 1=1 
	AND (SELECT nickname FROM jsMember c WHERE c.seq = a.jsMember_seq) LIKE CONCAT('%',"",'%')
;

CREATE VIEW V_jsSurveyRecord
as 
SELECT
	srcSeq
	,(SELECT nickname FROM jsMember c WHERE c.seq = a.jsMember_seq) as nickname
	,(SELECT id FROM jsMember c WHERE c.seq = a.jsMember_seq) as id
	,(SELECT survey FROM jsSurveyName b WHERE b.snSeq = a.jsSurveyName_snSeq) as survey
	,totalScore
	,(SELECT resultTitle From jsSurveyResult d WHERE d.srSeq = a.jsSurveyResult_srSeq) as resultTitle
	,datetime
FROM jsSurveyRecord a   
WHERE 1=1 
	AND (SELECT nickname FROM jsMember c WHERE c.seq = a.jsMember_seq) LIKE CONCAT('%',"익명이",'%')
;
DROP VIEW V_jsSurveyRecord;
CREATE VIEW V_score
as
SELECT 
	sum(a.choiceScore) 
FROM jsQuestionChoice a 
inner join jsSurveyRecord c on srcSeq = #{srcSeq}
inner join jsSurveySelected b on  c.srcSeq = b.jsSurveyRecord_srcSeq
inner join jsSurveyQuestion d on b.ssQuestion = d.question
WHERE 1=1 
AND c.jsSurveyName_snSeq = d.jsSurveyName_snSeq 
AND d.sqSeq = a.jsSurveyQuestion_sqSeq 
AND a.choice = b.ssChoosed 
;

SELECT 
	sum(a.choiceScore) 
FROM jsQuestionChoice a 
inner join jsSurveyRecord c on srcSeq =1
inner join jsSurveySelected b on  c.srcSeq = b.jsSurveyRecord_srcSeq
inner join jsSurveyQuestion d on b.ssQuestion = d.question
WHERE 1=1 
AND c.jsSurveyName_snSeq = d.jsSurveyName_snSeq 
AND d.sqSeq = a.jsSurveyQuestion_sqSeq 
AND a.choice = b.ssChoosed 
;

SELECT
	count(*)
FROM jsSurveyRecord a   
WHERE 1=1 
	AND (SELECT nickname FROM jsMember c WHERE c.seq = a.jsMember_seq) LIKE CONCAT('%',"익명이",'%')
;

SELECT 
	a.srcSeq
	,(SELECT survey FROM jsSurveyName d WHERE d.snSeq = a.jsSurveyName_snSeq) as survey
	,nickname
	,(SELECT srSeq FROM jsSurveyResult c inner join jsSurveyRecord a on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore WHERE 1=1 AND a.jsSurveyName_snSeq = c.jsSurveyName_snSeq AND srcSeq = ) as srSeq
	,a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq 
	AND b.seq = 2
;

UPDATE nation SET 
	capital="Kyoto"
WHERE 1 = 1 
AND name = "Japan";

UPDATE jsSurveyRecord SET
	totalScore = (SELECT sum(a.choiceScore) FROM jsQuestionChoice a inner join jsSurveyRecord c on c.srcSeq=19 inner join jsSurveyQuestion d inner join jsSurveySelected b on  c.srcSeq = b.jsSurveyRecord_srcSeq WHERE 1=1 AND c.jsSurveyName_snSeq = d.jsSurveyName_snSeq AND b.ssQuestion = d.question AND d.sqSeq = a.jsSurveyQuestion_sqSeq AND a.choice = b.ssChoosed)
WHERE 1=1
AND srcSeq=19
;

SELECT 
	resultTitle 
FROM jsSurveyResult c 
inner join jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq
WHERE 1=1 
	AND c.scoreRangeStart <= a.totalScore 
	AND c.scoreRangeEnd >= a.totalScore
    AND a.jsSurveyName_snSeq = c.jsSurveyName_snSeq
    AND b.seq = 2
;

INSERT INTO jsSurveyRecord(
	jsMember_seq
	,jsSurveyName_snSeq
	,totalScore
	,jsSurveyResult_srSeq
)
VALUES (
	7
	,1
	,0
	,0
)
;

UPDATE jsSurveyRecord
SET
	totalScore = (SELECT 
	sum(a.choiceScore) 
FROM jsQuestionChoice a 
inner join jsSurveyRecord c
inner join jsSurveySelected b on  c.srcSeq = b.jsSurveyRecord_srcSeq
inner join jsSurveyQuestion d on b.ssQuestion = d.question
WHERE 1=1 
AND c.jsSurveyName_snSeq = d.jsSurveyName_snSeq 
AND d.sqSeq = a.jsSurveyQuestion_sqSeq 
AND a.choice = b.ssChoosed)
WHERE 1=1
	AND srcSeq = 32
;

SELECT 
	srSeq
FROM jsSurveyResult c 
inner join jsSurveyRecord a on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
WHERE 1=1
AND a.jsSurveyName_snSeq = c.jsSurveyName_snSeq
AND srcSeq = 46
;
UPDATE jsSurveyRecord
SET
	jsSurveyResult_srSeq = 4
WHERE 1=1
	AND srcSeq = 37
;
