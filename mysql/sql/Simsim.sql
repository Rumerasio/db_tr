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

-- 로그인


-- 테스트와 그 문제, 그리고 그 선택지, 그것의 배점을 총괄하여 보여주는 것
SELECT
	a.survey,
    b.question,
    b.questionContent,
    c.choice,
    c.choiceContent,
    c.choiceScore
FROM jsSurveyName a
-- left join jsSurveyQuestion b on b.jsSurveyName_seq = a.seq
inner join jsSurveyQuestion b on b.jsSurveyName_seq = a.seq
	inner join jsQuestionChoice c on b.seq = c.jsSurveyQuestion_seq
;
