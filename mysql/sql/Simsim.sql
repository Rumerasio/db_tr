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
;


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
	a.seq,
    d.survey,
    b.nickname,
    a.totalScore,
    c.resultTitle,
    c.resultSmTitle,
    c.resultContent,
    a.datetime
FROM jsSurveyRecord a
inner join jsMember b on b.seq = a.jsMember_seq AND a.seq = 2 -- 현재 수행하는 jsSurveyRecord_seq
inner join jsSurveyResult c on c.scoreRangeStart <= a.totalScore AND c.scoreRangeEnd >= a.totalScore
inner join jsSurveyName d on d.seq = a.jsSurveyName_seq
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

-- (관리자) 테스트 기록 세부내역
SELECT 
	d.seq, -- 테스트 기록 seq 
    f.nickname,
    a.survey,
    d.totalScore,
    e.question,
    e.choosed,
    c.choiceScore,
    d.datetime
FROM jsSurveyName a
inner join jsSurveyQuestion b on b.jsSurveyName_seq = a.seq
inner join jsQuestionChoice c on c.jsSurveyQuestion_seq = b.seq
inner join jsSurveyRecord d on d.jsSurveyName_seq = a.seq
inner join jsSurveySelected e on e.jsSurveyRecord_seq = d.seq AND e.question = b.seq AND e.choosed =  c.choice

inner join jsMember f on f.seq = d.jsMember_seq
;

