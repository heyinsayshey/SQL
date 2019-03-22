 -- 사원 테이블 (emp) table에서 사원명(ename), 직책(job),급여(salary)  컬럼만 조회하기
 -- 모든 직원을 조회하기
 
 select ename,job,salary from emp
 
 -- 컴럼에 리터널을 사용하기
 select empno,ename, '사원' from emp
 
 -- 1. emp 테이블의 모든 레코드의 empno,ename 컴럼 출력하는 select 구문 작성하기
 
 select '사번',empno,'이름',ename  from emp
 
 -- 2.교수(professor) 테이블,모든 레코드의 교수이름(name),교수번호(no),컴럼 조회하기
 select '교수번호',no,'교수이름', name  from professor 
 
 -- 컴럼에 별명(alias) 주기
 -- 1
 select no 교수번호, name 교수이름 from professor
 -- 2
select no "교수번호", name "교수이름" from professor
-- 3
select no "교수번호", name as "교수이름" from professor

-- 컬럼에 연산자 사용하기
-- 사원의 급여를 10%씩 일괄로 인상하였을때 예상 인상급여를 조회하기

select ename 이름, salary 급여, salary * 1.1 인상예상급여 from emp

-- 문제 : 교수테이블에서 교수번호(no),교수이름(name),현재급여(salary),5%예상인상급여 출력하기

select no 교수번호,name 교수이름,salary 급여, salary*1.05 "5%인상급여" from professor

 -- 문제 : 교수테이블에서 교수번호(no),교수이름(name),현재급여(salary),
 --			연봉  출력하기
 -- 단 연봉은 급여*12 으로 출력한다
 select no 교수번호,name 교수이름,salary 급여,salary*12  연봉급여 from professor
 
 -- distinct : 조화된 컬럼의 중복 제거
 --				성능에 주의가 필요함.
 --				조회되는 컬럼이 여러개여도 처음에 한번만 사용이 가능하다.
 --				
 -- 교수가 속한 부서코드를 조회하기
 select distinct deptno from professor
 
  -- 교수가 속한 직급별  부서코드를 조회하기
select distinct position, deptno from professor  -- distinct는 딱 한번만 사용가능 젤앞에
  
-- where 조건문
-- 컬럼의 값을 이용하여 레코드 선택하기
-- where 조건문이 없는 경우는 모든 레코드를 선택함.

-- 학생 테이블(Student) 에서 1학년 학생의 모든 컬럼을 조회하기
select*from student
where grade = 1

-- 문제 1 : emp 테이블에서 부서코드가 10인 사원의 이름(name),급여(salary), 부서코드(deptno)를 조회하기

select ename,salary,deptno from emp
where deptno =10;

-- 문제 2 : emp 테이블에서 급여가 800보다 큰사람의 이름과 급여를 조회하기
select ename, salary from emp
where salary >800
-- 문제 3: professor 테이블에서 직급이 정교수인 교수의 이름과 부서코드,직급 출력하기

select name,deptno,position from professor
where position = "정교수"

-- emp 테이블에서 사원급여를 10%를 일괄 인상했을때 인상예상급여 1000만원  이상인
-- 사원의 이름, 현재급여, 예상인상, 부서코드를 조회하기

select ename 사원,salary 현재급여, salary*1.1 "10%인상예상급여", deptno 부서코드 from emp where salary*1.1>=1000

-- 문제 1 :사원의 급여가 700이상인인 사원들만 급여를 5%인상하기로 한다, 인상에 해당되는 
-- 사원의 이름, 현재급여, 예상인상급여, 부서코드를 출력하기
select ename 사원,salary 현재급여,salary*1.05 "인상예상급여",deptno 부서코드 from emp 
where salary>=700
-- 문제 2: 학생중 생일이 1998년6월30일 이후에 출생한 학생 중 1학년 학생만 출력하기
-- 단 이름,학과코드,생일,학년 컬럼만 조회한다.
-- 날짜 표시는 '1998-06-30'으로 한다

select name, major1, birthday,grade from student 
where birthday > '1998-06-30' and grade=1 

-- 문제 3: 학생중 생일이 1998년6월30일 이후에 출생한 학생 이거나  1학년 학생만 출력하기
-- 단 이름,학과코드,생일,학년 컬럼만 조회한다.
-- 날짜 표시는 '1998-06-30'으로 한다

select name, major1, birthday,grade from student 
where birthday > '1998-06-30' or grade=1 

-- between 연상자 사용하기
-- where 컬럼명 between A and B   -> A값, B값이 모두 포함된다.
-- where 컬럼명 >= A and B >= 컬럼명

-- 예제  : 1학년 학생중 몸무게가 70이상,80이하인 학생의 이름과 몸무게 출력하기
select name, weight from student where weight between 70 and 80 and grade =1
select name, weight from student where weight >= 70 and weight <=80 and grade =1

-- 문제 1: 전공1학과가 101번 학생중 몸무게가 50이상 80이하인 학생의 이름,몸무게,전공1학과를 출력하기
select name,weight,major1 from student where weight between 50 and 80 and major1 =101
select name,weight,major1 from student where weight >=50 and weight <=80 and major1=101

-- 문제 2 : 학생 중 2,3학년 학생의 학번, 이름, 생일, 학년 출력하기
select studno,name,birthday,grade from student where grade between 2 and 3
select studno,name,birthday,grade from student where grade =2 or grade =3
select studno,name,birthday,grade from student where grade >=2 and grade <=3

--in 연산자.

-- 학생 중 전공1이 101학과 이거나 201학과인 학생의 이름, 전공1학과코드, 학년 출력하기

select name, major1, grade from student where major1 =101 or major1=201

select name, major1, grade from student where major1 in(101,201)

-- 문제 1 :101,201 전공 학과 학생 중 키가 170이상인 학생의 학번,이름,몸무게,키,학과코드 조회하기
select studno,name,weight,height,major1 from student where major1 in(101,201) and height >=170
select studno,name,weight,height,major1 from student where major1=101 and height>=170 or major1=201 and height>=170

select studno,name,weight,height,major1 from student where (major1=101 or  major1=201) and height>=170
-- 문제 2: 교수중 학과코드(deptno)가 101학과, 201 학과에 속한 교수의 교수번호 (no),
-- 			이름(name), 학과코드(deptno), 입사일(hiredate)를 조회하기

select no,name,deptno,hiredate from professor where deptno in(101,201)
select no, name, deptno, hiredate from professor where deptno=101 or deptno=201

-- Like 연산자 
--		% : 0개 이상의 임으의 문자
--		_: 1개의 임의의 문자

--		성이 김씨의 학생의 학번,이름,학과코드를 조회하기
select studno,name,major1 from student
where name like '김%'

-- 학생 중 이름에 '진'자가 포함된 학생의 학번,이름,학과코드를 조회하기
select studno,name,major1 from student where name like '%진%'

-- -- 학생 중 이름에 '진'자가 끝나는 이름을 가진  학생의 학번,이름,학과코드를 조회하기
select studno,name,major1 from student where name like '%진'

-- 학생중 이름이 두자인 학생의 이름과 학년 부서코드를 출력하기
select studno,name,major1 from student where name like '__'

-- 문제 1: 학생 중 이름의 끝자가 '\'인 학생의 학번 이름 전공코드1 출력하기
select studno,name,major1 from student where name like '%훈'
-- 문제 2 : 학생중 전화번호(tel)가 서울지역(02)인 학생의 이름 학번 전화번호 출력하기
select name,studno,tel from student where tel like '02%'
-- 문제 3 : 학생 중 id의 글자수가 8자인 학생의 학번 이름 id 학년 조회하기
select studno,name,id,grade from student where id like '________'


-- not like
-- 학생 중 성이 이씨가 아닌 학생의 학번, 이름, 학과코드 조회하기
select studno,name,major1 from student
where name not like '이%'

-- is null. is not null 연산자
-- null의 의미는 값이 없다이다.
-- 연산 또는 비교의 대상이 아니다.

-- 교수 테이블 중 보너스가 없는 교수의 이름, 급여, 보너스 출력하기

select name, salary,bonus from professor
where bonus is null

-- 교수 테이블 중 보너스가 없는 교수들의 이름,보너스,연봉  출력하기
-- 연봉(급여*12)+보너스
select name,bonus,(salary*12)+bonus from professor
where bonus is null

-- 사원중 보너스가 있는 사원의 사원번호,이름,급여,보너스를 출력
select empno,ename,salary,bonus from emp
where bonus is not null
 
-- binary 예약어 사용하기 -> 오라클과 관련 없음
-- 교수 테이블에서 id 컬럼에 k가 존재하는 교수의 이름, id, 잭책을 출력하기
select name,id,position from professor
where id like '%K%'
-- -> binary 예약어로 대소문자 구분을 함.
select name,id,position from professor
where id like binary '%K%'
-- -> binary 예약어로 대소문자 구분을 함.

 -- order by : 정렬하기
 /*
 		select * ||컬럼1,컬럼2,...
 		[from 테이블 | 뷰명]
 		[where 조건문]
 		[group by 컬럼명]
 		[having 조건문]
 		[order by 컬럼명(desc|asc)] => select 구문의 마지막에 구현되어야 함.
 */
-- 1학년 학생의 이름과 키를 출력하기. 단 키순으로 출력하기
select name, height from student
where grade =1
order by height

select name, height from student
where grade =1
order by 2   -- 컬럼순 이름 키 순이라 2번 

select name 이름, height 키 from student
where grade =1
order by 키

-- 1학년 학생의 이름과 키를 출력하기. 단 키가 큰순으로 출력하기
select name, height from student
where grade =1
order by height desc

-- 사원 테이블에서 10% 인상 예상급여를 출력하기
-- 사원 이름, 현재 급여, 인상예상급여 출력
-- 단 인상예상 급여의 내림차순으로 정렬하기.
select  ename 사원, salary 현재급여, salary*1.1 "인상예상급여" from emp
order by 3 desc

-- 학생들의 이름, 학년,키를 학년순으로 키가 큰순으로 조회하기
select name 이름, grade 학년, height 키 from student
order by 학년,키 desc

-- 문제 1 : 교수테이블에서 교수번호,교수이름,학과코드,급여,예상급여(10%인상) 출력
-- 			단 학과코드 순으로 예상급여의 역순(내림차순)으로 조회하기
select no,name,deptno,salary,salary*1.1 "예상급여"  from professor
order by deptno,salary*1.1 desc

-- 문제 2: 학생테이블에서 지도교수(profno)가 배정되지 않은 학생의 학번, 이름, 지도교수번호, 전공1코드 출력하기
--				단 학과코드 순으로 정렬하기
select  studno,name,profno,major1 from student
where profno is null
order by major1
-- 문제 3: 1학년 학생의 이름,키,몸무게 출력하기 
--			단 키는 작은순으로 몸무게는 큰순으로 출력하기
select name,height,weight from student
where grade =1
order by height, weight desc
-- order by 2,3 desc


-- 과제 10문제 --

-- 1. emp 테이블에서 empno는 사원번호로, ename 사원명, job는 직급으로 별칭을 설정하여 출력하기
select empno 사원번호, ename 사원명, job 직급  from emp

--2. dept 테이블에서 deptno 부서#, dname 부서명, loc 부서위치로 별칭을 설정하여  출력하기
select deptno "부서#", dname 부서명, loc 부서위치 from dept

-- 3. 학생을 담당하는 지도교수번호를 출력하기 
select  distinct  profno from student

--  4. 현재 교수들에게 설정된 직급을 출력하기
select distinct position from professor 

-- 5. 학생테이블에서 name, birthday,height,weight 컬럼을 출력하기
-- 단 name은 이름, birthday는 생년월일 ,height 키(cm),weight 몸무게(kg) 으로 변경하여 출력하기
select name 이름,birthday 생년월일,height "키(cm)",weight "몸무게(kg)" from student

-- 6. 학생의 생일이 96년12월31일 이후인 학생의 학번 ,이름, 생일을 출력하기
select studno, name, birthday from student where birthday > '1996-12-31'

 -- 7. 전공1이 101번,201 학과의 학생 중 몸무게가 50이상 80이하인 학생의 
  --  이름(name), 몸무게(weight), 학과코드(major1)를 출력하기 
select name,weight,major1 from student 
where major1 in(101,201) and weight between 50 and 80

--  8.학생 테이블에 1학년 학생의 이름과 주민번호기준생일, 키와 몸무게를 출력하기.  
-- 단 생일이 빠른 순서대로 정렬
select name, jumin, birthday, height, weight from student 
where grade =1
order by jumin

select name, substr(jumin,1,6), height, weight from student 
where grade = 1
order by substr(jumin,1,6)

select name,jumin,birthday,height,weight from student 
where grade =1
order by 2


-- 9. 교수테이블(professor)급여가 300 이상이면서 보너스(bonus)을 받거나 (or)
 --   급여가 450 이상인 교수 이름, 급여, 보너스을 출력하여라.
select name,salary,bonus from professor
where (salary>=300 and bonus is not null) or (salary>=450)

-- 10. 학생 중 전화번호가 서울지역이 아닌 학생의 학번, 이름, 학년, 전화번호를 출력하기
 --   단 학년 순으로 정렬하기
select studno,name,grade,tel from student
where tel not like '02%'
order by grade

/*
	1. 테이블의 구조 : desc 테이블명
	2. select 컬럼 ||* from 테이블명
		where 조건문 => 레코드의 선택기준 
						 where ㅈ건문 구문이 없는 경우 모든 레코드 선택
		order by 컬럼명 ||컬럼의 순서 || 별명
	3. 컬럼
		리터널 문자를 컬럼으로 사용 가능함.
		컬럼명의 별명을 줄수 있다.
		컬럼에 연산자 사용 가능함,.
		중복 제거 -> distinct
	4. where
		관계연산자(=,>,<....,and,or)
		컬럼명 between A and B
		in : 컬럼명 in(값1,값2....) -> or 조건
		likc : % : 0개 이상의 임의의 문자
				 _ : 1개의 임의의 문자
		is null, is not null : null은 값이 없기 때문에 연산할 수 없다.	
	5. order by
		정렬 방식
		asc  : 오름차순 정렬  기본정렬방식, 생략
		desc : 내림차순 정렬 , 생략 불가.
		order by 컬럼1,컬럼2
			-> 1차 정렬 컬럼1하고, 2차 정렬 컬럼 2를 기준으로 함
*/

-- 집합 연산자  :  union, union all => 합집합
--		union 	 : 중복을 제거 합집합
--    union all : 두개의 조회 결과를 합하여 출력함.
--		주의 : 두개의 구문의 컬럼의 수가 같아야 함.

-- 전공1학과가 202 학과 이거나, 전공2학과가 101인 학생의 학번,이름,전공1,
--	전공 2 조회하기
select studno, name, major1, major2 from student
where major1=202 or major2 =101
-- union을 이용한 방식
select studno, name, major1, major2 from student
where major1=202
union
select studno, name, major1, major2 from student
where major2 =101

-- union all 이용한 방식
select studno, name, major1, major2 from student
where major1=202
union all
select studno, name, major1, major2 from student
where major2 =101

-- 학생 중 전공1학과가 101번학과 학생의 학번,이름,전공1코드와 
-- 교수 중101학과의 교수번호, 이름,학과코드를 출력하기
select '학생'구분,studno,name,major1 from student
where major1 =101
union
select '교수생'구분,no,name,deptno from professor
where deptno =101

-- 문제
-- 1. 교수중 급여가 450이상인 경우는 5% 인
select no, name,salary, salary*1.05 "인상예정급여" from professor
where salary >= 450
union 
select no, name,salary,salary*1.1 "인상예정급여"  from professor
where salary < 450
order by 4 desc

-- 2.교수중 보너스가 있는 교수의 연봉은 급여*12+보너스이고
--	보너스가 없는 교수의 연봉은 급여*12로 한다
--	교수번호,교수이름,급여,보너스,연봉을 출력하기
-- 연봉순으로 정렬하기

select no, name, salary,bonus, salary*12+bonus  from professor
where bonus is not null
union
select no, name, salary,bonus, salary*12  from professor
where bonus is null
order by salary*12  desc

/*
	함수
		단일행함수 : 하나의 레코드만 영향
		그룹함수  :	여러에 관련된 기능 조회		 
*/
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
where substr(name,
-- 3. 학생의 생년월일은 98년3월20일의 형식으로 이름, 생년월일,학년을 출력하기
--		단 생년월일은 주민번호 기준으로 하고,
--		생년월일의 월로 정렬하여 출력하기

select name, birthday,grade from student
where concat(substr(jumin,1,6))
order by substr(jumin,3,2)  
 -- 예를 들면 900501 주민이고 123456 이라서 3번째부터시작해서 2글자수 05월