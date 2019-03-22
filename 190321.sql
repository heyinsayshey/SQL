/*
	함수
		단일행함수 : 하나의 레코드만 영향
		그룹함수  :	여러에 관련된 기능 조회		 
*/


-- **********************************문자 관련 함수***************************************************
--	문자 함수 : 문자열에 사용되는 함수
--	대소문자 변환
--	upper, lower

-- 학과번호가 101 학과의 학생의 이름,id,대문자id,소문자 id 출력하기
select name,id,upper(id),lower(id) from student
where major1 = 101


-- 문제 1: 교수테이블에서 교수번호,이름,id,대문자id 출력하기
-- 단 id가 있는 교수만 출력하기
select no,name,id,upper(id) from professor

-- 문자열의 길이 : 
-- 	length 	: 글자 바이트수 => 한글 한자는 3바이트 계산
--		char_length : 글자 수
-- 학생의 이름, 아이디, 이름글자수, 이름의바이트수 출력
select name,id,char_length(name), length(name) from student

-- 문자열 연결함수
-- concat => 컬럼을 연결하기
-- 교수의 이름과 직급을 연결하기
select name, position from professor
select concat(name,"=",position) from professor
  
  -- 문제 : 학생의 이름 학년을 연결하여 출력하기. 연결컬럼과 키 몸무게를 출력하기
  --	 예)	홍길동 1학년 150 cm 50 kg
  
  select concat(name,grade,"학년",height,"cm",weight,"kg") from student
  
  
-- 부분 문자열
-- substr(컬럼명,시작인덱스,글자수)
-- left(컬럼명,길이) : 왼쪽부터 길이만큼 부분 문자열을
-- right(컬럼명,길이 : 오른쪽부터 길이만큼 부분 문자열

-- 학생의 이름만 조회하기
select right(name,2) from student

-- 학생의 이름과, 주민번호 기준 생일 부분만 조회하기
select name, left(jumin,6) from student
select name, substr(jumin,1,6) from student

-- 학생 중 생일이 3월인 학생의 이름과 생일출력하기. 단 생일은 주민번호 기준
select name, left(jumin,6) from student
where substr(jumin,3,2) = '03'  -- 03은 3월의미.


-- 문제
-- 1. 학생의 id의 길이가 7개이상 10이하인 id를 가진
--		학생의 학번,이름,id,id의 글자수를 출력하기
select studno,name,id, char_length(id) from student
where char_length(id) between 7 and 10
--	2. 교수 중 교수의 성이 ㅈ이 포함된 교수의 이름을 출력하기
select name from professor
where left(name,1) between '자' and '찧'
-- 3. 학생의 생년월일은 98년3월20일의 형식으로 이름, 생년월일,학년을 출력하기
--		단 생년월일은 주민번호 기준으로 하고,
--		생년월일의 월로 정렬하여 출력하기

select name,concat(left(jumin,2),"월 ", substr(jumin,3,2),"일 ", substr(jumin,5,2),"일"),grade from student
order by substr(jumin,3,2)  

-- 문자열의 위치 : instr
-- instr(컬럼, 문자)
-- 55페이지 1번
select name, tel, instr(tel,')') from student
-- 문제
-- 문제1 : 55페이지 밑에 1번
select name, tel, left(tel,3) 지역번호  from student
where instr(tel,')')=3
union
select name, tel, left(tel,4) 지역번호 from student
where instr(tel,')')=4

select name, tel, left(tel,instr(tel,')')) 지역번호 from student

-- 문제2 : 56페이지 2번
select name, url, substr(url,8) homepage, char_length(substr(url,8)) homepage길이  from professor
where url is not null


-- 문자 추가함수 : lpad, rpad
-- lpad : 왼쪽에 문자를 채움, lpad(컬럼명, 전체자리수, 채울 문자)
-- rpad : 오른쪽에 문자를 채움, rpad(컬럼명, 전체자리수, 채울 문자)
-- 57페이지 1번 예제
select name, id, lpad(id,15,'$'), rpad(id,15,'*') from student 
-- 2번 예제
select rpad(studno, 10, '*'), name from student
-- 58페이지 1번 문제
select name, rpad(position,12,'*') from professor


-- 문자 제거 함수 : trim, rtrim, ltrim
-- 000120000056700000 문자의 양쪽 0을 제거하기
select trim(both '0' from '000120000056700000')   -- 양쪽
select trim(trailing '0' from '000120000056700000') -- 오른쪽 
select trim(leading '0' from '000120000056700000')   -- 왼쪽
-- 60페이지 문제 4
select name, trim(leading 'http://' from url) homepage from professor 


-- 왼쪽 공백 제거
select ltrim('   왼쪽 공백 제거       ')  ltrim

-- 오른쪽 공백 제거
select rtrim('       오른쪽 공백 제거     ') rtrim

-- 양쪽 공백 제거
select trim('     양쪽 공백 제거      ') trim
select ltrim(rtrim('     양쪽 공백 제거      ')) trim
select trim(both ' ' from '           양쪽 공백 제거      ') trim


-- 문자 치환 함수 : replace
-- replace(컬럼명, '문자1', '문자2') : 컬럼에서 문자1을 문자 2로 변경한다.
-- 62페이지 1번 예제
select replace(name, left(name,1), '#')  from student
-- 문제 1
select name, replace(jumin, right(jumin,6),'******') from student 
where major1=101

select name, concat(left(jumin,7), '******') from student 
where major1=101



-- 그룹 문자열의 위치 검색 : find_in_set
select find_in_set('y','x,y,z')
select find_in_set('홍길동','홍길동,김삿갓,이몽룡')
select find_in_set('이몽룡','홍길동,김삿갓,이몽룡')
select find_in_set('임꺽정','홍길동,김삿갓,이몽룡') -- 없으면 0 넘겨줌


-- 문제 
-- 학생 중 이름이 2자인 학생의 이름과 학년, 전공코드 조회하기
select name, grade, major1 from student
where char_length(name)=2





-- ***********************************************숫자 관련 함수********************************************

-- 반올림 함수
-- round(숫자) : 소수점 이하 첫째 자리에서 반올림.
-- round(숫자, 숫자2) : 소수점 이하 숫자2 + 1 자리에서 반올림
select round(12.3456,-1) r1, 
		 round(12.3456) r2,
		 round(12.3456,1) r3,
		 round(12.3456,2) r4,
		 round(12.3456,3) r5
		 
		 
-- 버림 함수
-- truncate(숫자, 숫자) : 소수점 이하 숫자자리까지 버림

select truncate(12.3456,-1) r1, 
		 truncate(12.3456,0) r2,
		 truncate(12.3456,1) r3,
		 truncate(12.3456,2) r4,
		 truncate(12.3456,3) r5
		 
		 
-- 문제
-- 64페이지 예제 1
select name, salary, round(salary*1.15),truncate(salary*1.15,0) from professor
-- #2 : score 테이블에서 학생의 학번, 국어점수, 영어점수, 수학점수, 총점, 평균을 출력하기
-- 단, 평균은 소수점이하 2자리까지만 출력하기.
-- 총점 내림차순으로 정렬
select studno, kor, eng, math, (kor+eng+math) 총점, round((kor+eng+math)/3, 2) 평균 from score
order by 5 desc


-- 근사 정수
-- ceil : 큰 근사 정수
-- floor :  작은 근사 정수

select ceil(12.3456), floor(12.3456)


-- 나머지 함수 : mod
select mod(21,8)


-- 제곱 함수 : power
select power(3,3)


-- *************************************날짜 관련 함수***********************************************************

-- 현재 날짜 : now(), curdate(), current_date, current_date()
-- 오라클 : sysdate 예약어 = now()

select now(), curdate(), current_date, current_date()

-- 날짜 사이의 일자 수 알기
-- datediff
select now(),'2019-01-01', datediff(now(), '2019-01-01') -- 1월 1일 기준으로 79일째이다.
select datediff('2019-03-22','2019-03-23')


-- 문제 : 2018년 1월 1일부터 현재까지의 날짜를 출력하기
select datediff(now(), '2018-01-01')
select datediff(curdate(), '2018-01-01')
select datediff(current_date(), '2018-01-01')
select datediff(current_date, '2018-01-01')\


-- 문제 : 학생의 이름과 생일, 학생의 생일부터 현재까지의 일수를 출력하기
select name, birthday, datediff(now(), birthday) from student
select datediff(now(), '1993-05-28')

-- 문제 67 페이지 문제1
select name, birthday, round(datediff(now(), birthday)/30) 개월수, round(datediff(now(), birthday)/365) 나이  from student
-- 문제 2 : 교수의 이름과, position, hiredate, 입사개원수, 입사년수를 출력하기
-- 입사개월수는 일수/30 나누어 계산, 입사년수는 일수/365 나누어 계산
-- 입사 개월수, 입사년수는 절삭하여 정수로 출력하기
select name, position, hiredate, truncate(datediff(now(), hiredate)/30,0) 입사개월수, truncate(datediff(now(), hiredate)/365,0) 입사년수 
from professor

/*
year : 년도
month : 월
day : 일
weekday : 요일, 0 : 월요일, 1: 화요일... 6: 일요일
dayofweek : 요일, 1 : 일요일 2 : 월요일 ... 7 : 토요일
week : 일년 중 몇번째 주
last_day : 해당 월의 마지막 일자

*/
select year(now()), month(now()), day(now()), weekday(now()), dayofweek(now()), week(now()), last_day(now())

-- 문제 :  교수이름, 입사일, 올해의 휴가보상일 출력하기
-- 휴가보상일 :  입사월의 마지막 일자 
select name, hiredate, last_day(concat(year(now()),'-',month(hiredate),'-01')) 휴가보상일  from professor

 
-- CafeExam_0321
-- #1
select studno,name,grade,id from student
where instr(lower(id),'kim')!=0

select studno,name,grade,id from student
where lower(id) like '%kim%' => 함수를 이용하여 소문자로 변경

--#2
select no,name,salary,salary*1.1 예상인상급여 from professor
where bonus is null
union
select no,name, salary,salary 예상인상급여 from professor
where bonus is not null
order by 예상인상급여 desc
 
--#3
select studno, name, major1 from student
where right(name, 1) = '훈'

--#4
select studno, name, id, concat(upper(left(id,1)), substr(id,2)) from student

--#5
select name,url,trim(leading 'http://' from url)  homepage, char_length(trim(leading 'http://' from url)) "homepage 길이"  from professor
where url is not null

--#6
select name,hiredate,salary,round(salary*1.15), truncate(salary*1.15,0) from professor
where month(hiredate) between 1 and 3

--#7
select name, hiredate, truncate(datediff(now(),hiredate)/30,0) from professor
order by truncate(datediff(now(),hiredate)/30,0)

--#8
select name,id from student
where char_length(id)>=7

--#9
select name, substr(email, instr(email, '@')+1) from professor

--#10
select name, rpad(id,20,'$') from professor
where deptno in (101,201,301)
union
select name, lpad(id,20,'#') from student
where major1 in (101,201,301)


-- ***********************190321 정리******************************

집합연산자 => 합집합
union : 중복 제거
union all : 두개의 결과를 붙여서 출력
=> 두개 결과의 컬럼의 수가 동일해야 함.

함수 : 1. 단일행 함수 2. 그룹함수

1. 단일행 함수
- 문자열  관련 함수
	*대소문자 변경 : upper(), lower()
	*연결 함수 : concat(컬럼1, 컬럼2, ..)
	*문자열 길이 : char_length() : 문자열의 개수
					 	length() : 글자 바이트수
	*부분 문자열 : substr(컬럼명, 시작 인덱스, [개수])
						left(컬럼명, 개수)
						right(컬럼명, 개수)
	*문자의 위치 : instr(컬럼명, '문자') 없으면 0 나옴
	*문자 추가 :  lpad(컬럼명, 전체 자리수, '문자')
					  rpad(컬럼명, 전체 자리수, '문자')
	*문자 제거 : trim(both|leading|trailing '문자열' from 컬럼명)
					 trim(컬럼) : 양쪽 공백 제거
					 rtrim(컬럼) : 오른쪽 공백제거
					 ltrim(컬럼) : 왼쪽 공백제거
	*문자 치환 : replace(컬럼명, '문자1', '문자2')
	*그룹 선택 : find_in_set('문자', '문자열 그룹')
						'문자열 그룹'은 ,로 이루어진 문자열이다.


- 숫자관련 함수
	*반올림 : round(컬럼명, 소수점이하 자리수)
	*버림 : truncate(컬럼명, 소수점이하 자리수)
	*나머지 : mod(나눠지는 수, 나누는 수)
	*제곱 :  power(숫자1, 숫자2)
	
	
- 날짜 관련 함수
	*현재 날짜 : now(), curdate(), current_date(), current_date
	*일자 수 계산 : datediff(날짜, 기준날짜) : 날짜 - 기준날짜
	*일자 구분 : year()
					 month()
					 day()
					 weekday() : 0-월요일 1-화요일
					 dayofweek() : 1-일요일 ...7-토요일
					 week() : 몇번째 주
					 last_day(날짜)



-- *****************************날짜 함수************************************

-- 현재 시점 기준 이전 이후
-- date_add : 기준일 이후 시점
-- date_sub : 기준일 이전 시점

-- 현재 시간 기준 1일 이후 : 
select now(), date_add(now(), interval 1 day)
-- 현재 시간 기준 1일 이전 : 
select now(), date_sub(now(), interval 1 day)

-- 현재 시간 기준 1시간 이후 : 
select now(), date_add(now(), interval 1 hour)
-- 현재 시간 기준 1시간 이전 : 
select now(), date_sub(now(), interval 1 hour)

-- 현재 시간 기준 1분 이후 : 
select now(), date_add(now(), interval 1 minute)
-- 1초 후
select now(), date_add(now(), interval 1 second)
-- 1달 후
select now(), date_add(now(), interval 1 month)
-- 1년 후
select now(), date_add(now(), interval 1 year)


-- 현재 시간 이후 10일 이후 날짜의 마지막 일자
select now(), last_day(date_add(now(), interval 10 day))

-- 문제 1 :교수의 정식 입사일은 입사일의 3개월 이후이다.
-- 교수의 번호, 이름, 입사일, 정식입사일 출력하기
select no, name, hiredate 입사일, date_add(hiredate, interval 3 month) 정식입사일  from professor

-- 문제 2 : 사원의 정식 입사일은 입사일의 2개월 이후 다음달 1일로 한다.
-- 사원의 사원번호, 이름, 입사일, 정식 입사일  출력하기
select empno, ename, hiredate 입사일, date_add(last_day(date_add(hiredate, interval 2 month)), interval 1 day) 정식입사일
from emp




-- 날짜를 문자열 변환 : date_format (오라클 : to_char)
-- 문자를 날짜로 변환 : str_to_date (오라클 : to_date)
/*
형식 지정 문자

%Y : 4자리 년도
%m : 2자리 월
%d : 2자리 일
%H : 0~23 시
%h : 1~12 시
%i : 0~59 분
%s : 0~59 초
%a : 요일(Fri)
%W : 요일(Friday)
%p : AM PM

*/
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초'), 
			date_format(now(),  '%Y년 %m월 %d일 %H시 %i분 %s초 %p'),
			date_format(now(),  '%Y년 %m월 %d일 %H시 %i분 %s초 %a'),
			date_format(now(),  '%Y년 %m월 %d일 %H시 %i분 %s초 %W')

select str_to_date('20190101','%Y%m%d'),
		 date_format(str_to_date('20190101','%Y%m%d'), '%Y년 %m월 %d일')
		 
		 
-- 기타 함수 : 
-- ifnull(컬럼값, 기본값) : 컬럼의 값이 null 인 경우 기본값으로 변환

-- 교수의 이름과 직책, 급여, 보너스를 출력하기   단, 보너스가 없는 경우 0으로 출력하기
select name, position, salary, ifnull(bonus, 0) from professor
select name, position, salary, ifnull(bonus, '보너스없음') from professor

-- 교수의 이름, 직책, 연봉을 출력하기
-- 연봉은 급여*12+bonus 로한다. 단 보너스가 없는 경우는 긊여*12로 한다. 
select name, position, ifnull((salary*12)+bonus, salary*12) from professor

select name, position, salary*12+ ifnull(bonus,0) from professor


-- 문제 1 : 학생의 이름과 지도교수번호를 출력하기. 단, 지도교수가 없는 경우 '9999'로 출력함
select name, ifnull(profno, '9999')  from student
-- 문제 2 : major 테이블에서, 코드, 전공명, build 출력하기. 단 build 의 값이 null 인 경우 '단독 건물 없음'으로 출력하기
select code, name, ifnull(build, '단독 건물 없음')  from major




/*
조건함수
if : if(조건문, '참', '거짓')

*/

-- 교수의 이름, 학과번호, 학과명 출력하기. 단, 학과명은 101학과인 경우 '컴퓨터공학'  나머지는 '공란'출력하기
select name, deptno, if(deptno=101, '컴퓨터공학', '') from professor

select name, deptno, if(deptno=101, '컴퓨터공학', '그 외 학과') from professor

-- 교수의 이름, 학과번호, 학과명 출력하기. 단, 학과명은 101학과인 경우 '컴퓨터공학'  
-- 102번 학과 '멀티미디어공학', 201번학과 '기계공학', 나머지는 공란으로 출력학
select name, deptno, if(deptno=101, '컴퓨터공학', if(deptno=102, '멀티미디어공학', if(deptno=201, '기계공학',''))) from professor


-- 문제1 : 학생의 주민번호 7번째 자리가 1,3인 경우 남자, 2,4인 경우는 여자로 1,2,3,4 가 아닌 경우 '주민번호오류'로 성별 출력하기.
select name, jumin, if(substr(jumin,7,1) in (1,3), '남자', if(substr(jumin,7,1) in(2,4) , '여자', '주민번호오류')) from student

-- 문제 2 : 학생의 이름, 전화번호, 지역명을 출력하기. 지역명은 전화번호의 지역번호가 02 : 서울, 051 :부산, 052 : 울산, 그외는 기타로 출력하기
select name, tel, if(left(tel,instr(tel,')')-1)=02, '서울', if(left(tel,instr(tel,')')-1)=051, '부산', if(left(tel,instr(tel,')')-1)=052, '울산','기타')))
from student





/*
	조건문 : case 구문
1.	case 값 when 값 then 문자
	...
	else 문자 end
	
	
2. case when 조건문 then 문자 
	...
	else 문자 end
	
	=> or을 쓰는 경우 2번으로 사용하여 전체 조건으로 써준다.
	
*/

-- 학과명이 101학과인 경우 '컴퓨터공학' 그 외 공란으로 출력하기 
-- 교수의 이름, 학과코드, 학과명 출력하기
select name, deptno, case deptno when 101 then '컴퓨터공학'
							else ' ' end 학과명
from professor

select name, deptno, case deptno when 101 then '컴퓨터공학'
							else '기타학과' end 학과명
from professor


-- 교수의 이름, 학과번호, 학과명 출력하기. 단, 학과명은 101학과인 경우 '컴퓨터공학'  
-- 102번 학과 '멀티미디어공학', 201번학과 '기계공학', 나머지는 공란으로 출력학
select name, deptno, case deptno when 101 then '컴퓨터공학'
											when 102 then '멀티미디어공학'
											when 201 then '기계공학'
											else ' ' end 학과명
from professor


-- 문제1 : 학생의 주민번호 7번째 자리가 1,3인 경우 남자, 2,4인 경우는 여자로 1,2,3,4 가 아닌 경우 '주민번호오류'로 성별 출력하기.
select name, jumin, case substr(jumin,7,1) when 1  then '남자'
														 when 2 then '여자'
														 when 3 then '남자'	
														 when 4 then '여자'
														 else '주민번호오류' end 성별
from student


-- case 2
select name, jumin, case  when substr(jumin,7,1) in(1,3) then '남자'
								  when substr(jumin,7,1) in(2,4) then '여자'												
								  else '주민번호오류' end 성별
from student

-- 문제 2 : 학생의 이름, 전화번호, 지역명을 출력하기. 지역명은 전화번호의 지역번호가 02 : 서울, 051 :부산, 052 : 울산, 그외는 기타로 출력하기
select name, tel, case left(tel, instr(tel,')')-1) when 02 then '서울'
																	when 051 then '부산'
																	when 052 then '울산'
																	else '기타' end  지역명
from student


-- 문제1  : 학생의 생일이 1~3월이면 1분기, 4~6월 이면 2분기, 7~9월 이면 3분기, 10~12월 이면 4분기로 출력하기. 
-- 학생의 이름, 주민번호, 출생분기를 출력하기. 단, 출생분기는 주민번호 기준으로한다. 
select name, jumin, case when substr(jumin,3,2) between 1 and 3 then '1분기'
								 when substr(jumin,3,2) between 4 and 6 then '2분기'
								 when substr(jumin,3,2) between 7 and 9 then '3분기'
								 when substr(jumin,3,2) between 10 and 12 then '4분기'
								 end 출생분기
from student

select name, jumin, case when substr(birthday,6,2) between 1 and 3 then '1분기'
								 when substr(birthday,6,2) between 4 and 6 then '2분기'
								 when substr(birthday,6,2) between 7 and 9 then '3분기'
								 when substr(birthday,6,2) between 10 and 12 then '4분기'
								 end 출생분기
from student




-- ***********************************************그룹함수****************************************************************

/*
 그룹함수 : 여러행을 그룹화하여 결과를 리턴
*/

-- count 함수 : 레코드의 건수 리턴. 해당 값이 null 인 경우 개수에서 제외된다.

-- 교수의 전체 인원수와 교수중 보너스를 받는 교수의 인원수를 출력하기
select count(*) 전체인원수, count(bonus) 보너스인원수 -- * : 모든 컬럼
from professor


-- 학생의 전체인원수와 지도교수가 있는 학생의 인원 수를 출력하기.
select count(*) 전체인원수, count(profno) '지도교수가 배정된 인원수'  from student

-- 1학년 학생의 전체인원수와 지도교수가 있는 학생의 인원수 출력하기
select count(*) '1학년 인원수', count(profno) from student
where grade=1

select count(*) '1학년 인원수', count(profno) from student
where grade=2

-- 학생의 학년별 인원수를 출력하기.
select grade 학년 , count(*) '학년별 인원수' from student
group by grade

-- 학생의 전공별 인원수를 출력하기.
select major1 전공번호, count(*) '전공별 인원수'  from student
group by major1

-- 문제 1 : 교수 중 직책별 교수의 인원 수와 보너스를 받고 있는 인원 수를 출력하기.
select position, count(position), count(bonus) from professor
group by position

-- 문제 2 : 사원 중 부서별 사원의 인원수와 보너스는 받고있는 인원수를 출력하기.
select deptno, count(*), count(bonus) from emp
group by deptno


/*
-- 합계 : sum
-- 평균 : avg, null 값은 제외됨.
*/


-- 교수의 급여합계와, 보너스 합계를 조회하기
select sum(salary), sum(bonus) from professor

-- 교수의 급여평균과, 보너스 평균을 조회하기
select avg(salary), avg(bonus) from professor

-- null값의 문제가 발생하는 예제
select   sum(salary), sum(bonus), 
			avg(salary), avg(bonus), 
			sum(bonus)/count(*)  
from professor

select   sum(salary), sum(bonus), 
			avg(salary), avg(ifnull(bonus,0)), 
			sum(bonus)/count(*)  
from professor

-- null 인 값도 허용해주기 위해서는 ifnull을 사용하여 0 값으로 바꿔준다.
select count(*), count(ifnull(bonus,0)) from professor

-- 교수 테이블에서 부서별 인원수, 총급여합계, 총보너스합계, 급여평균, 보너스평균 출력하기. 단, 보너스가 null인경우 평균에 계산되도록 하기.
select deptno, count(*), sum(salary), sum(bonus), round(avg(salary)), truncate(avg(ifnull(bonus,0)),0) from professor
group by deptno

--- 교수 테이블에서 직급별 인원수, 총급여합계, 총보너스합계, 급여평균, 보너스평균 출력하기. 단, 보너스가 null인경우 평균에 계산되도록 하기
select position, count(*), sum(salary), sum(bonus), round(avg(salary)), truncate(avg(ifnull(bonus,0)),0) from professor
group by position


-- 문제1 : 부서별 교수의 급여합계, 보너스합계, 연봉합계, 급여평균, 보너스평균, 연봉평균 출력하기. 단, 연봉은 급여*12+보너스로 한다.
-- 보너스가 없는 경우는 0으로 처리한다. 평균 출력시 소수점 2자리로 반올림하여 출력하기.
select deptno, sum(salary) 급여합계, sum(bonus) 보너스합계, sum(salary*12+ifnull(bonus,0)) 연봉합계, 
       round(avg(salary),2) 급여평균 , round(avg(ifnull(bonus,0)),2) 보너스평균 , round(avg(salary*12+ifnull(bonus,0)),2) 연봉평균  
from professor
group by deptno

-- 문제2 : 학생의 학년별 키와 몸무게 평균을 구하기. 학년별로 정렬하고, 평균은 소수점 2자리로 반올림하여 출력하기
select grade 학년, round(avg(height),2) '평균 키', round(avg(weight),2) '평균 몸무게'  from student
group by grade
order by grade desc

-- 문제 3 : score 테이블에서 국어점수 합계, 국어평균, 영어점수합계, 영어평균, 수학점수합계, 수학평균, 전체 총점, 전체 평균을 출력하기.
select sum(kor), avg(kor), sum(eng), avg(eng), sum(math), avg(math), sum(kor+eng+math), avg((kor+eng+math)/3) 
from score


-- having : 그룹함수의 조건문
-- 학생의 학년별 키와 몸무게 평균을 구하고, 평균이 몸무게가 70이상인 학년을 출력하기

select grade, avg(height), avg(weight) from student
group by grade
having avg(weight) >= 70 -- 해당되는 그룹만 나오게 하는 조건문  (where은 단일함수만 해당된다.)

/*
	<select 구문 형식>
	
	select 컬럼들|*
	from 테이블명|뷰명
	where 조건문
	group by 그룹의 기준이 되는 컬럼명
	having 그룹을 선택하는 조건문
	order by 정렬기준
	
*/


-- CafeExam_0322
1. 사원의 입사 10주년이 되는 년도의 생일의 달 1일부터 한달을  안식월으로 하고자 한다.
   사원의 사원번호, 사원이름, 직급, 부서코드, 안식시작일, 안식종료일을 출력하기
select empno, ename, job, deptno, str_to_date(concat(year(date_add(hiredate, interval 10 year)),'-',month(birthday),'-01'),'%Y-%m-%d') 안식시작일, 
											 last_day(concat(year(date_add(hiredate, interval 10 year)),'-',month(birthday),'-01'))  안식종료일
from emp
 
2. score 테이블에서 학번, 국어,영어,수학, 학점, 인정여부 을 출력하기
   학점은 세과목 평균이 95이상이면 A+,90 이상 A0
                       85이상이면 B+,80 이상 B0
                       75이상이면 C+,70 이상 C0
                       65이상이면 D+,60 이상 D0
    인정여부는 평균이 60이상이면 PASS로 미만이면 FAIL로 출력한다.                   
   으로 출력한다.

select studno, kor, eng, math, if(avg((kor+eng+math)/3)>=95, 'A+',
										 if(avg((kor+eng+math)/3)>=90, 'A0',
										 if(avg((kor+eng+math)/3)>=85, 'B+',
										 if(avg((kor+eng+math)/3)>=80, 'B0',
										 if(avg((kor+eng+math)/3)>=75, 'C+',
										 if(avg((kor+eng+math)/3)>=70, 'C0',		
										 if(avg((kor+eng+math)/3)>=65, 'D+',	
										 if(avg((kor+eng+math)/3)>=60, 'D0',	'')))))))
										) 학점,
										 
										 if(avg(kor+eng+math)>=60, 'PASS', 'FAIL') 인정여부 
from score
group by studno


3. 학생을 3개 팀으로 분류하기 위해 학번을 3으로 나누어  나머지가 0이면 'A팀', 1이면 'B팀', 2이면 'C팀'으로 
    분류하여 학생 번호, 이름, 학과 번호, 팀 이름을 출력하여라

select studno, name, major1, case mod(major1,3) when 0 then 'A팀'
																when 1 then 'B팀'
																when 2 then 'C팀'
																end 팀이름
from student

4. 학생 테이블에서 이름, 키, 키의 범위에 따라 A, B, C ,D등급을 출력하기
     160 미만 : A등급
     160 ~ 169까지 : B등급
     170 ~ 179까지 : C등급
     180이상       : D등급

select name, height, if(height>=180, 'D등급',
							if(height>=170, 'C등급',
							if(height>=160, 'B등급', 'A등급'))) 등급
from student	
						
5. 교수테이블에서 교수의 급여액수를 기준으로 200미만은 4급, 201~300 : 3급, 301~400:2급
    401 이상은 1급으로 표시한다. 교수의 이름, 급여, 등급을 출력하기
    단 등급의 오름차순으로 정렬하기
    
select name, salary, if(salary<200, '4급',
							if(salary<=300, '3급',
							if(salary<=400, '2급', '1급'))) 등급 
from professor
order by 등급
   
6. 학생의 전공별 평균 몸무게와 학생 수를 출력하기  전공학과순으로 정렬하기

select major1, avg(weight), count(*)
from student
group by major1
order by major1

7. 사원의 직급(job)별로 평균 급여를 출력하고, 
    평균 급여가 1000이상이면 '우수', 작거나 같으면 '보통'을 출력하여라

select job, round(avg(salary),2) '평균 급여', if(avg(salary)>=1000, '우수','보통')	구분
from emp
group by job

8. 학생의 주민번호를 기준으로 남학생, 여학생의 평균키와 평균 몸무게를 출력하기

select if(substr(jumin,7,1)=1,'남자','여자') 성별, round(avg(height),2) 평균키, round(avg(weight),2) 평균몸무게
from student
group by  성별

