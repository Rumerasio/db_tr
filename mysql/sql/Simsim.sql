use china;

CREATE TABLE IF NOT EXISTS `china`.`Upload` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `pseq` INT NULL COMMENT '연결된 parent seq',
  `type` INT NULL,
  `defaultNy` TINYINT NULL,
  `sort` INT NULL,
  `path` VARCHAR(500) NULL,
  `originalName` VARCHAR(45) NULL,
  `uuidName` VARCHAR(100) NULL,
  `ext` VARCHAR(45) NULL,
  `regIp` VARCHAR(45) NULL,
  `regSeq` INT NULL,
  `regDeviceCd` INT(11) NULL,
  `regDateTime` DATETIME NULL,
  `regDateTimeSvr` DATETIME NULL,
  PRIMARY KEY (`seq`))
;
-- 테이블 추가

-- 공통코드그룹 목록
SELECT
	a.seq,
	a.codeGroupCode,
    a.codeGroupNameKor
    ,(SELECT count(b.codeGroup_seq) FROM code b WHERE b.codeGroup_seq = a.seq) as codeNum  -- 서브쿼리 remember
FROM codeGroup a
;
-- SELECT
-- 	a.seq,
-- 	a.codeGroupCode,
--     a.codeGroupNameKor
--     ,count(b.codeGroup_seq) as codeNum
-- FROM codeGroup a
-- inner join code b on b.codeGroup_seq=a.seq
-- 	group by b.codeGroup_seq
-- ;
-- 코드그룹 입력
INSERT INTO codeGroup(
    codeGroupCode,
    codeGroupCodeAnother,
    codeGroupNameKor
    ,codeGroupNameEng
    ,useNy
    ,turn
    ,content
    ,delNy
    ,varcharType1
    ,varcharType2
    ,varcharType3
    ,intType1
    ,intType2
    ,intType3
    ,registerDateTime
    ,modifyDateTime
)
VALUES (
	
)
;
-- 코드목록
SELECT
	b.seq
	,a.seq as codeGroup_seq
	,a.codeGroupCode,
	a.codeGroupNameKor,
	a.codeGroupNameEng,
	b.codeAnother,
	b.codeNameKor
	,b.codeNameEng
	,b.useNy
	,b.turn
FROM codeGroup a
inner join code b on b.codeGroup_seq = a.seq
WHERE 1=1
;

-- 로그인 화면 
SELECT
	a.id,
    a.nickname    
FROM jsMember a
WHERE a.id = "escaida15" AND a.password ="fhwpvktmxk" -- ""입력받은 값 
;

-- 회원가입 입력
INSERT INTO jsMember(
	nickname
    ,dob
    ,gender			-- 실제 입력은 숫자입력이 아닌 select 선택
    ,phoneAgency	-- 실제 입력은 숫자입력이 아닌 select 선택
    ,phoneNum
	,emailInsert	-- 실제 이메일 id(앞부분) 입력 받는 것
    ,emailDomain	-- 실제 입력은 숫자입력이 아닌 select선택
    ,id
    ,password
    ,datetime		-- 사용자 입력이 아닌 누른 순간의 기록
)
VALUES (
	"제미니"
    ,"1996-03-09"
    ,101
    ,202
    ,"01039395000"
    ,"woaalsl0309"
    ,301
    ,"woaalsdl0309"
    ,"1q2w3e4r!"
    ,"2020-06-07"
)
;

-- 메인 페이지.상단배너
SELECT
	a.survey,
    a.surveyPhrase -- +사진
FROM jsSurveyName a
WHERE 1=1
-- AND a.seq = 2
-- OR a.seq = 3
-- OR a.seq = 4
-- OR a.seq = 5
;

-- 메인 페이지.하단(다른 컨텐츠)
SELECT
	a.survey -- + 사진
FROM jsSurveyName a
WHERE 1=1
;


-- 테스트 메인 페이지 
SELECT
	a.survey,
    a.surveyPhrase,
    a.surveyExplain -- 사진
    ,a.likeNum
FROM jsSurveyName a
WHERE 1=1
AND a.snSeq =5 -- 별자리 테스트(5)
;

-- 테스트 메인.댓글
SELECT
	a.nickname,
    a.commentContent,
    a.datetime
FROM jsSurveyComment a
WHERE 1=1
AND a.jsSurveyName_seq = 5 -- 별자리 테스트(5) 코멘트 불러오기
order by
	datetime desc
;

-- 테스트 메인.댓글 입력
INSERT INTO jsSurveyComment (
	jsMember_seq
    ,jsSurveyName_seq
	,nickname
    ,commentContent
    ,datetime
)
VALUES (
	1 -- 회원 id seq
    ,5 -- 등록하는 테스트 id seq
    ,"ㅁㄴㅇㄹ" -- nickname, 비회원의 경우 자유로이 설정
    ,"대체 이게 별자리랑 무슨 상관임 ㅋㅋ"
    ,"2022-07-05 11:26:37" -- 직접 입력하는 것이 아닌 등록을 누르는 순간 시간 기록
)
;

-- 테스트 시작시 생성되는 jsSurveyRecord

-- 테스트와 그 문제, 그리고 그 선택지
SELECT
	a.survey,
    b.question,
    b.questionContent,
    c.choice,
    c.choiceContent
FROM jsSurveyName a
-- left join jsSurveyQuestion b on b.jsSurveyName_seq = a.seq
inner join jsSurveyQuestion b on b.jsSurveyName_snSeq = a.snSeq
inner join jsQuestionChoice c on b.sqSeq = c.jsSurveyQuestion_sqSeq
AND snSeq=1
;

-- 제출될 데이터 입력 쿼리
-- INSERT INTO 

-- 제출 (hidden)
SELECT
	a.ssSeq
	,a.ssQuestion
    ,a.ssChoosed
FROM jsSurveySelected a
WHERE 1=1
AND a.jsSurveyRecord_srcSeq = 2 -- 당시 생성된 jsSurveyRecord_seq 값
;

-- 결과 페이지
SELECT 
	a.srcSeq
    ,(SELECT survey FROM jsSurveyName aa WHERE aa.snSeq = a.jsSurveyName_snSeq) as SurveyName
    ,b.nickname,
    a.totalScore,
    c.resultTitle,
    c.resultSmTitle,
    c.resultContent,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq AND a.srcSeq = 2 -- 현재 수행하는 jsSurveyRecord_seq
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
;

-- 결과 페이지 ver.2 ing
SELECT 
	a.srcSeq
    ,(SELECT survey FROM jsSurveyName aa WHERE aa.snSeq = a.jsSurveyName_snSeq) as SurveyName
    ,b.nickname
    ,(SELECT sum(a.choiceScore) FROM jsQuestionChoice a inner join jsSurveyRecord c on c.srcSeq=19 inner join jsSurveyQuestion d inner join jsSurveySelected b on  c.srcSeq = b.jsSurveyRecord_srcSeq WHERE 1=1 AND c.jsSurveyName_snSeq = d.jsSurveyName_snSeq AND b.ssQuestion = d.question AND d.sqSeq = a.jsSurveyQuestion_sqSeq AND a.choice = b.ssChoosed) as total
    ,c.resultTitle,
    c.resultSmTitle,
    c.resultContent,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq AND a.srcSeq = 2 -- 현재 수행하는 jsSurveyRecord_seq
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
inner join jsSurveySelected d 
	group by d.jsSurveyRecord_srcSeq
;

-- 수정 화면
SELECT  -- 공통코드에서 가져와 숫자를 글로 표시하게 되는 것은 
	a.nickname,
    a.dob,
	a.gender,
    a.email
    ,a.emailDomain   
    ,a.id
	,a.phoneAgency
    ,a.phoneNum
FROM jsMember a
WHERE 1=1
AND a.seq=2
;

-- 참여 테스트 기록
SELECT 
	a.srcSeq,
    d.survey,
    b.nickname,
    c.resultTitle,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq 
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
inner join jsSurveyName d on d.snSeq = a.jsSurveyName_snSeq
	AND b.seq = 2 -- 현재 사용자의 jsMember_seq 값
;
-- 참여 테스트 기록 ver.2
SELECT 
	a.srcSeq
    ,(SELECT survey FROM jsSurveyName d WHERE d.snSeq = a.jsSurveyName_snSeq) as survey
    ,nickname
    ,(SELECT resultTitle FROM jsSurveyResult c WHERE c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore) as resultTitle
    ,a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq 
	AND b.seq = 2 -- 현재 사용자의 jsMember_seq 값
;
-- ,(SELECT survey FROM jsSurveyName aa WHERE aa.seq = a.jsSurveyName_seq) as SurveyName
-- 즐겨찾기 페이지
SELECT 
	a.seq
    ,b.nickname
    ,c.survey
FROM jsFavorite a
inner join jsSurveyName c on c.snSeq = a.jsSurveyName_snSeq
inner join jsMember b  on b.seq = a.jsMember_seq
WHERE b.seq =3
;

-- 내 댓글 페이지
SELECT
	a.scSeq,
    c.survey,
    a.nickname,
    a.commentContent,
    a.datetime
FROM jsSurveyComment a
inner join jsMember b on b.seq = a.jsSurveyName_snSeq
inner join jsSurveyName c on c.snSeq = a.jsSurveyName_snSeq
WHERE 1=1
	AND a.jsMember_seq =2
;

-- 
SELECT 
	d.srcSeq -- 테스트 기록 seq 
    ,(SELECT nickname FROM jsMember aa WHERE aa.seq = d.jsMember_seq) as nickname
    ,a.survey,
    d.totalScore,
    e.question,
    e.choosed,
    c.choiceScore
    ,d.datetime
FROM jsSurveyName a
inner join jsSurveyQuestion b on b.jsSurveyName_snSeq = a.snSeq
inner join jsQuestionChoice c on c.jsSurveyQuestion_sqSeq = b.sqSeq
inner join jsSurveyRecord d on d.jsSurveyName_snSeq = a.snSeq
inner join jsSurveySelected e on e.jsSurveyRecord_srcSeq = d.srcSeq AND e.question = b.sqSeq AND e.choosed =  c.choice
;

-- 관리자 멤버목록
SELECT
	a.seq
	,a.nickname
	,a.dob
	,b.codeNameKor
	,a.phoneAgency
	,a.phoneNum
	,a.email
	,a.emailInsert
	,a.emailDomain
	,a.id
	,a.password
	,a.datetime
	,a.delNy
FROM jsMember a 
inner join code b on b.codeAnother = a.gender
WHERE 1=1
order by
	a.seq asc
;
