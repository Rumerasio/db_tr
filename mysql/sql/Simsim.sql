use china;

-- 공통코드 목록
SELECT
	a.seq,
    a.name,
    b.seq,
    b.name
FROM codeGroup a
left join code b on b.codeGroup_seq = a.seq
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
AND a.seq = 2
OR a.seq = 3
OR a.seq = 4
OR a.seq = 5
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
AND a.seq =5 -- 별자리 테스트(5)
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
inner join jsSurveyQuestion b on b.jsSurveyName_seq = a.seq
inner join jsQuestionChoice c on b.seq = c.jsSurveyQuestion_seq
;

-- 제출될 데이터 입력 쿼리
-- INSERT INTO 

-- 제출 (hidden)
SELECT
	a.seq
	,a.question
    ,a.choosed
FROM jsSurveySelected a
WHERE 1=1
AND a.jsSurveyRecord_seq = 2 -- 당시 생성된 jsSurveyRecord_seq 값
;

-- 결과 페이지
SELECT 
	a.seq
    ,(SELECT survey FROM jsSurveyName aa WHERE aa.seq = a.jsSurveyName_seq) as SurveyName
    ,b.nickname,
    a.totalScore,
    c.resultTitle,
    c.resultSmTitle,
    c.resultContent,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq AND a.seq = 2 -- 현재 수행하는 jsSurveyRecord_seq
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
;

-- 결과 페이지 ver.2 ing
SELECT 
	a.seq
    ,(SELECT survey FROM jsSurveyName aa WHERE aa.seq = a.jsSurveyName_seq) as SurveyName
    ,b.nickname
    ,sum(d.choosed) as total   
    ,c.resultTitle,
    c.resultSmTitle,
    c.resultContent,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq AND a.seq = 2 -- 현재 수행하는 jsSurveyRecord_seq
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
inner join jsSurveySelected d 
	group by d.jsSurveyRecord_seq
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
	a.seq,
    d.survey,
    b.nickname,
    c.resultTitle,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq AND b.seq = 2 -- 현재 사용자의 jsMember_seq 값
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
inner join jsSurveyName d on d.seq = a.jsSurveyName_seq
;

-- 즐겨찾기 페이지
SELECT 
	a.seq,
    b.nickname,
    c.survey
FROM jsFavorite a
inner join jsMember b on b.seq = a.jsMember_seq
inner join jsSurveyName c on c.seq = a.jsSurveyName_seq
;

-- 내 댓글 페이지
SELECT
	a.seq,
    c.survey,
    a.nickname,
    a.commentContent,
    a.datetime
FROM jsSurveyComment a
inner join jsMember b on b.seq = a.jsSurveyName_seq AND a.jsMember_seq =2
inner join jsSurveyName c on c.seq = a.jsSurveyName_seq
;

-- 
SELECT 
	d.seq -- 테스트 기록 seq 
    ,(SELECT nickname FROM jsMember aa WHERE aa.seq = d.jsMember_seq) as nickname
    ,a.survey,
    d.totalScore,
    e.question,
    e.choosed,
    c.choiceScore
    ,d.datetime
FROM jsSurveyName a
inner join jsSurveyQuestion b on b.jsSurveyName_seq = a.seq
inner join jsQuestionChoice c on c.jsSurveyQuestion_seq = b.seq
inner join jsSurveyRecord d on d.jsSurveyName_seq = a.seq
inner join jsSurveySelected e on e.jsSurveyRecord_seq = d.seq AND e.question = b.seq AND e.choosed =  c.choice
;

