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

-- 수정 화면 (ㄹㅇ 마스터 설정 주의)
SELECT 
	a.nickname,
    a.dob,
    b.name,
    a.email,
    c.name,
    a.id,
    d.name,
    a.phoneNum
FROM jsMember a
inner join code b on b.seq = a.gender
inner join code c on c.seq = a.emailDomain
inner join code d on d.seq = a.phoneAgency
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

-- 결과 페이지
SELECT 
	d.seq,
    f.nickname,
    a.survey,
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

