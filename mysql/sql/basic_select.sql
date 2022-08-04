use china;

select * from jsMember;
select count(*) from jsMember;

select
	a.seq,
    a.nickname,
    b.jsSurveyName_seq,
    b.jsSurveyResult_seq,
    b.datetime
from jsMember a 
-- left join jsSurveyRecord b on b.jsMember_seq = a.seq
inner join jsSurveyRecord b on b.jsMember_seq =a.seq
;

select
	b.emailDomain,
	b.nickname,
    b.email,
    a.name
from code a 
-- left join jsSurveyRecord b on b.jsMember_seq = a.seq
inner join jsMember b on b.emailDomain = a.seq
and a.seq=301
;
