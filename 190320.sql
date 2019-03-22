-- 사원테이블(emp) table 에서 사원명, 직책(job), 급여(salary) 컬럼만 조회하기.
-- 모든 직원을 조회하기
select ename,job,salary from emp

-- 컬럼에 리터널을 사용하기
select empno,ename,'사원' from emp

select '사번',empno,'이름',ename from emp

-- ctrl F9 하면 선택한 줄만 실행할 수 있다.
select '교수번호',no,'교수이름',name from professor

-- 컬럼에 별명(alias) 주기
-- 1번째 방법
select no 교수번호,name 교수이름 from professor
-- 2번째 방법(공백을 쓰고자 할 때)
select no "교수 번호",name  "교수 이름" from professor
-- 3번째 방법
select no as 교수번호, name as 교수이름 from professor

-- 컬럼에 연산자 사용하기
-- 1. 산술연산자 : 사원의 급여를 10%씩 일괄로 인상하였을 때, 예상 인상급여 조회하기
select ename 이름, salary 급여, salary*1.1 인상예상급여 from emp

-- 문제 :  교수테이블에서 교수번호, 교수이름, 현재급여, 5%인상 예상급여 출력하기
select no 교수번호, name 교수이름,salary 현재급여, salary*1.05 인상예상급여 from professor
-- 문제 :  교수테이블에서 교수번호, 교수이름, 현재급여, 연봉 출력하기(급여*12)
select no 교수번호 , name 교수이름, salary 급여, salary*12  연봉 from professor

-- distinct : 조회된 컬럼의 중복 제거
--					// 2번 쓸 수 없고, select 바로 다음에 써야 한다.
--					// 조회되는 컬럼이 여러개여도 처음에 한번만 사용가능하다.
--
-- 교수가 속한 부서코드를 조회하기
select distinct deptno from professor
-- 교수가 속한 직급별 부서코드를 조회하기
-- select distinct deptno, distinct position from professor  안됨

-- where 조건문
-- 컬럼의 값을 이용하여 레코드 선택하기
-- where 조건문이 없는 경우는 모든 레코드를 선택함.

-- 학생테이블(student)에서 1학년 학생의 모든 컬럼을 조회하기
select * from student
where grade = 1

-- 책 문제 P.31 #1
select ename,salary,deptno from emp where deptno=10
-- #2
select ename,salary from emp where salary>800
-- #3
select name,deptno,position from professor where position="정교수"

-- p.32 
select ename,salary,salary*1.1 예상인상급여 from emp where salary*1.1<1000
-- p.33 #1
select ename,salary,salary*1.05 예상인상급여 ,deptno from emp where salary<=700
-- #2
-- 날짜표시는 "1998-06-30"으로 표기한다.
select name, major1,birthday,grade from student where birthday>"1998-06-30" and grade=1
-- #2 변형: 둘 중 하나의 조건인 경우 or로 쓴다.
select name, major1,birthday,grade from student where birthday>"1998-06-30" or grade=1


-- between 연산자 사용하기
-- where 컬럼명 between A and B => A값, B값이 모두 포함된다.
-- where 컬럼명 >= A and B>= 컬럼명

-- p.34 #1
select name, weight from student where weight between 70 and 80 and grade=1
-- p.35 #1
select name,weight,major1 from student where major1=101 and weight between 50 and 80
select name,weight,major1 from student where major1=101 and weight >= 50 and weight <= 80
-- #2 : 학생 중 2,3 학년 학생의 학번, 이름, 생일, 학년 출력하기
select studno,name,birthday,grade from student where grade between 2 and 3
select studno,name,birthday,grade from student where grade=2 or grade=3
select studno,name,birthday,grade from student where grade>=2 and grade<=3


-- in연산자
-- p.35 밑에 1번
select name,major1,grade from student where major1 in(101,201)
select name,major1,grade from student where major1=101 or major1=201
--p.36 #1
select studno,name,weight,height,major1 from student where major1 in(101,201) and height>=170
-- #2 : 교수 중 학과코드(deptno)가 101학과, 201학과에 속한 교수의 교수번호(no),이름,학과코드, 입사일(hiredate)를 조회하기
select no,name,deptno,hiredate from professor where deptno in (101,201)


-- like 연산자
-- % : 0개 이상의 임의의 문자
-- _ : 1개의 임의의 문자

-- p.37 #1
select name, major1 from student
where name like "김%"
-- p.38 #2
select name,grade,major1 from student where name like '%진%'
--#3 : 이름이 진자로 끝나는 이름을 가진 학생의 학번, 이름, 학과코드를 조회하기
select studno, name, major1 from student where name like'%진'
--p.38 #3
select name,grade,major1 from student where name like'__'
--38쪽 맨밑 #1
select studno,name,major1 from student where name like'%훈'
--#2 
select name,studno,tel from student where tel like '02%'
--#3 : 학생 중 id의 글자수가 8자인 학생의 학번, 이름, id, 학년 조회하기
select studno,name,id,grade from student where id like'________'


-- not like
-- 학생 중 성이 이씨가 아닌 학생의 학번, 이름, 학과코드 조회하기
select studno, name, major1 from student where name not like '이%'


-- is null, is not null 연산자
-- null : 값이 없다. -> 연산, 비교의 대상이 될 수 없음
-- 교수테이블 중 보너스가 없는 교수의 이름, 급여, 보너스 출력하기
select name,salary,bonus from professor where bonus is null

-- 교수테이블 중 보너스가 없는 교수들의 이름, 보너스, 연봉  출력하기
select name,bonus,(salary*12)+bonus 연봉  from professor where bonus is null
-- 위에거 안됨. null 자체가 연산이 되지 않기 때문에
select name,bonus,(salary*12)+ifnull(bonus,0) 연봉  from professor where bonus is null


-- 40페이지 #1 보너스가 있는 사원
select empno,ename,salary,bonus from emp where bonus is not null


-- binary 예약어 사용하기.=> 오라클과 관련 없음
-- 42페이지 #1
select name,id,position from professor where id like'%K%'
-- like 는 대소문자를 구분하지 못한다.
select name,id,position from professor where id like binary '%k%'
select name,id,position from professor where id like binary '%K%'
-- binary  예약어로 대소문자 구분을 함.


-- 정렬하기 : order by 구문
/*
 select *||컬럼1,컬럼2,... 
 [from 테이블명 || 뷰명]
 [where 조건문]
 [group by 컬럼명]
 [having 조건문]
 [order by 컬럼명(desc||asc(생략가능))] => select 구문의 마지막에 구현되어야 함.
 */
 
 -- p.44 : 1학년 학생의 이름과 키를 출력하기. 단 키순으로 출력하기
 select name, height from student 
 where grade=1 
 order by height

 -- p.44 : 1학년 학생의 이름과 키를 출력하기. 단 키역순으로 출력하기
select name, height from student 
 where grade=1 
 order by height desc
 
 -- 2번째 컬럼으로 정렬하기
 select name, height from student 
 where grade=1 
 order by 2
 
 -- 별명으로 정렬하기
select name 이름, height 키  from student 
 where grade=1 
 order by 이름
 
 -- 사원 테이블에서 10% 인상 예상급여를 출력하기. 사원이름, 현재급여, 인상예상급여 출력하기. 인상예상급여의 내림차순으로 정렬하기.
 select ename,salary,salary*1.1 from emp order by 3 desc
 
 -- p.45 #3 학년별 키가 큰 순
 select name,grade,height from student order by grade,height desc
 
 -- p.46 #1
 select no,name,deptno,salary,salary*1.1 from professor order by deptno, salary*1.1 desc
 --#2
 select studno,name,profno,major1 from student where profno is null order by major1
 --#3
 select name,height,weight from student where grade=1 order by 2 ,3 desc
 
 
 --cafeExam_0320
 --#1
 select empno 사원번호,ename 사원명,job 직급 from emp
 --#2
 select deptno "부서#",dname 부서명,loc 부서위치 from dept
 --#3
 select distinct profno from student where profno is not null
 --#4
 select distinct position from professor
 --#5
 select name 이름,birthday 생년월일,height "키(cm)",weight "몸무게(kg)" from student
 --#6
 select studno,name,birthday from student where birthday>"1996-12-31"
 --#7
 select name,weight,major1 from student where major1 in(101,201) and weight between 50 and 80
 --#8
 select name,jumin,birthday,height,weight from student where grade=1 order by birthday 
 -- 주민번호 기준 생일 
 select name,substr(jumin,1,6),height,weight from student where grade=1 order by substr(jumin,1,6)
 
 --#9
 select name,salary,bonus from professor (where salary>=300 and bonus is not null) or salary>=450
 --#10
 select studno,name,grade,tel from student where tel not like'02%' order by grade 
 
 /*
 1. 테이블의 구조 : desc 테이블명
 2. select 컬럼명||* from 테이블명 
 	 where 조건문 => 레코드의 선택 조건
 	 					where 조건문이 없는 경우, 모든 레코드 선택
 	 order by 컬럼명|컬럼 순서(1부터 시작)|별명
 3. 컬럼r 
 	리터널 문자를 컬럼으로 사용 가능함.
 	컬럼명의 별명을 부여 할 수 있음.
 	컬럼에 연산자 사용 가능함.
 	중복 제거=> distinct
 4. where
 		관계연산자(=,>,<,...and,or)
 		컬럼명 between A and B
 		in : 컬럼명 in(값1,값2....) => or 조건
 		like : % : 0개 이상의 임의의 문자, _ : 1개의 임의의 문자
 		is null, is not null : null 은 값이 없기 때문에 연산할 수 없다. 
 5. order by 
 	 정렬 설정
 	 asc : 오름차순, 기본정렬방식(생략 가능)
  	 desc : 내림차순, 생략 불가
  	 order by 컬럼1, 컬럼2 => 1차 정렬 컬럼1하고, 2차 정렬 컬럼2를 기준으로 함.
 */
 
 
 
-- 집합연산자 : union, union all => 합집합
-- union : 중복제거 합집합
-- union all : 두개의 조회 결과를 합하여 출력함.
-- 주의 : 두개 구문의 컬럼의 수가 같아야 함. 

-- p.48 #1 : 전공1, 전공2 학과 모두 출력하기 
select studno, name, major1 from student 
where major1=202 or major1=101

-- union을 이용한 방식
select studno, name, major1, major2 from student 
where major1=202 
union 
select studno, name, major1, major2 from student 
where major2=101

-- union all 을 이용한 방식
select studno, name, major1, major2 from student 
where major1=202 
union all
select studno, name, major1, major2 from student 
where major2=101

-- #2: 학생 중 전공1학과가 101번 학과 학생의 학번, 이름, 전공1코드와
-- 교수 중 101학과의 교수번호, 이름, 학과코드 출력하기
select studno, '학생' 구분,name, major1 from student
where major1=101
union
select no, '교수' 구분,name, deptno from professor
where deptno=101

-- 49페이지 #1
select no,name,salary,'5%인상'구분,salary*1.05 인상예정급여  from professor 
where salary >= 450
union 
select no,name,salary,'10%인상'구분 ,salary*1.1 인상예정급여  from professor
where salary<450
order by 인상예정급여 desc

--#2 : 교수 중 보너스가 있는 교수의 연봉은 급여*12+보너스 이고 
-- 보너스가 없는 교수의 연봉은 급여*12 로 한다.
-- 교수번호, 교수이름, 급여, 보너스, 연봉을 출력하기
-- 연봉순으로 정렬하기
select no,name,salary,bonus,salary*12+bonus 연봉 from professor
where bonus is not null
union
select no,name,salary,bonus,salary*12 연봉  from professor
where bonus is null
order by 연봉