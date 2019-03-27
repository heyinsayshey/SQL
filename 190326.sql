
/*
	outer join : inner 조인은 조건이 맞는 경우만 조회가 가능하지만, 
					 outer 조인은 조건이 맞지 않아도 조회를 할 수 있다.
	
	1. left outer join : 왼쪽 테이블의 모든 레코드를 조회할 수 있다. 
	2. right outer join : 오른쪽 테이블의 모든 레코드를 조회할 수 있다.
	3. full outer join :  양쪽 테이블의 모든 레코드를 조회할 수 있다. 
								union 을 사용해야 함. 
								
*/

-- left outer join

-- 학생의 이름과 지도교수 이름 조회하기
-- 마리아디비
select s.name 학생이름, p.name 담당교수이름 
from student s left join professor p
on s.profno = p.no
-- ANSI
select s.name 학생이름, p.name 담당교수이름 
from student s left outer join professor p
on s.profno = p.no
-- 오라클 방식=> 여기서는 실행 안 됨.
select s.name 학생이름, p.name 담당교수이름 
from student s left outer join professor p
on s.profno = p.no(+)


-- right outer 조인

-- -- 학생의 이름과 지도교수 이름 조회하기
-- 지도학생이 없는 교수도 조회하기
select s.name 학생이름, p.name 지도교수이름
from student s right join professor p
on s.profno=p.no


-- full outer join

-- 학생의 이름과 지도교수 이름 조회하기, 지도학생이 없는 교수도 조회하고, 지도교수가 없는 학생도 조회하기.
select s.name 학생이름, p.name 지도교수이름
from student s right join professor p
on s.profno=p.no
union
select s.name 학생이름, p.name 담당교수이름 
from student s left join professor p
on s.profno = p.no


-- 문제1 : 학생의 이름과 지도교수 이름 조회하기, 지도학생이 없는 교수도 조회하고, 지도교수가 없는 학생도 조회하기.
-- 단, 지도교수가 없는 학생의 지도교수는 '0000'으로 출력하고, 지도 학생이 없는 교수의 지도학생은 '****'로 출력하자.
select ifnull(s.name,'****') 학생이름, ifnull(p.name,'0000') 지도교수이름
from student s right join professor p
on s.profno=p.no
union
select ifnull(s.name,'****') 학생이름, ifnull(p.name,'0000') 담당교수이름 
from student s left join professor p
on s.profno = p.no

-- 문제 2 : 지도교수가 지도하는 학생의 인원수를 출력하기. 단, 지도학생이 없는 교수의 인원수 0 으로 출력하기.
-- 지도교수번호, 지도교수이름, 지도학생인원수를 출력하기
select p.no, p.name, count(s.name) '지도학생 인원 수'
from professor p left join student s
on p.no = s.profno
group by p.name

-- 문제3 : emp 테이블과 p_grade 테이블을 조인하여 사원의 이름, 직급, 현재연봉, 해당직급의 연봉하한, 연봉상한 출력하기.
-- 단 모든 사원이 출력되도록 하기.
select e.ename, e.job, (e.salary+ifnull(e.bonus,0))*10000 현재연봉, p.s_pay 연봉하한, p.e_pay 연봉상한
from emp e left join p_grade p
on e.job=p.position


-- 문제 4 : major 테이블에서 학과코드와 학과명, 상위학과코드, 상위학과명 출력하기. 단, 상위학과가 없는 학과도 같이 조회하기.
select m1.code 학과코드, m1.name 학과명, m2.code 상위학과코드 , m2.name 상위학과명
from major m1 left join major m2
on m1.part = m2.code

-- 문제 5 : emp 테이블에서 사원번호, 사원명, 직책job, 상사이름, 상사직급 출력하기
-- 단, 모든 사원이 출력되기
select e1.empno 사원번호, e1.ename 사원명, e1.job 사원직급, ifnull(e2.ename,'상사없음') 상사이름, ifnull(e2.job,'상사없음') 상사직급
from emp e1 left join emp e2
on e1.mgr = e2.empno


/*
	subquery : 
		좁은의미 : select 내부의 where 조건절에 존재하는 select 구문
		넓은의미 : select 내부에 존재하는 select 구문
				스칼라 : select 내부의, 컬럼절이 존재하는 select 구문
			   inline view : select 내부에 from이 존재하는 select 구문
			   
	단일행 subquery : subquery 의 결과가 한개인 경우( 한개의 행 결과)
			사용가능 연산자 : 관계연산자 사용가능.
	복수행 subquery : subquery 의 결과가 여러개인 경우(여러개의 행을 결과값으로 갖는 경우)
			사용가능 연산자 : in, any, all
			   
*/

-- 사원 중 이혜라 사원보다 많은 급여를 받는 직원의 사원번호, 사원명, 급여, 직급 출력하기.
select salary from emp where ename='이혜라'

select empno,ename,salary, job from emp where salary>600

select empno,ename,salary,job from emp
where salary>(select salary from emp where ename = '이혜라')


-- 문제1 : 김종연 학생보다 윗학년 학생의 이름, 학년, 전공1 코드, 전공학과명을 출력하기.
select s.name, s.grade, s.major1, m.name
from student s, major m
where s.major1=m.code and s.grade > (select grade from student  where name = '김종연') 

-- 문제 2 : 김종연 학생과 같은 학년의 이름, 학년, 전공1코드, 전공학과명을 출력하기.
select s.name, s.grade, s.major1, m.name
from student s, major m
where s.major1=m.code and s.grade=(select grade from student where name = '김종연') 

-- 문제 3 : 사원테이블에서 사원의 평균급여 미만의 급여를 받는 사원의 사원번호, 이름, 직급, 급여 출력하기.
select empno,ename,job,salary 
from emp
where salary < (select avg(salary) from emp)


-- 복수행 subquery
-- 사원테이블과 부서테이블에서 근무지역이 서울인 사원의 사번, 이름, 부서번호, 부서명을 출력하기.
select * from dept

select deptno from dept where loc = '서울'

select e.empno, e.ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno
and e.deptno in (select deptno from dept where loc = '서울')

-- 문제 : 1학년 학생과 같은 키를 가지고 있는 2학년 학생의 이름, 키, 학년을 출력하기.
select name, height, grade
from student s
where grade = 2  and height in (select height from student where grade=1)


-- CafeExam_0326
-- 1.emp, p_grade 테이블을 조회하여 입사년(hiredate)을 기준으로 예상 직급을 조회하기
--   사원들의 이름,입사일,근속년도,현재 직급, 예상직급을 출력하기
--   근속년도는 오늘을 기준으로하고 일자를 365로 나눈 후 소숫점 이하는 버린다. 
-- mariaDB
select ename 이름, hiredate 입사일, truncate(datediff(now(),hiredate)/365,0) 근속년도, e.job 현재직급, p.position 예상직급
from emp e, p_grade p
where truncate(datediff(now(),hiredate)/365,0) between p.s_year and p.e_year
-- ANSI
select ename 이름, hiredate 입사일, truncate(datediff(now(),hiredate)/365,0) 근속년도, e.job 현재직급, p.position 예상직급
from emp e join p_grade p
on truncate(datediff(now(),hiredate)/365,0) between p.s_year and p.e_year

-- 2.emp, p_grade 테이블을 조회하여 나이를 기준으로 예상직급을 조회하기
--  사원들의 이름,나이,현재 직급, 예상직급을 출력하기
--  나이는 오늘을 기준으로하고 일자를 365로 나눈 후 소숫점 이하는 버린다. 
-- mariaDB
select ename 이름, truncate(datediff(now(),birthday)/365,0) 나이, e.job 현재직급, p.position 예상직급
from emp e, p_grade p
where truncate(datediff(now(),birthday)/365,0) between p.s_age and p.e_age
-- ANSI
select ename 이름, truncate(datediff(now(),birthday)/365,0) 나이, e.job 현재직급, p.position 예상직급
from emp e join p_grade p
on truncate(datediff(now(),birthday)/365,0) between p.s_age and p.e_age

-- 3. 교수테이블에서 교수번호, 이름, 입사일과 자신보다 입사일이 빠른 
--    사람의 인원수를 출력하기. 단 입사일이 빠른 순으로 정렬하기.

select p1.no, p1.name, p1.hiredate, count(p2.name) '입사일이 빠른 직원 수'
from professor p1 left join professor p2
on p1.hiredate>p2.hiredate
group by p1.name
order by hiredate


-- 4. 교수 테이블에서 송승환교수보다 나중에 입사한 교수의 
--   이름, 입사일,학과명을 출력하기 
-- mariaDB
select p.name, p.hiredate, m.name
from professor p, major m
where m.code=p.deptno and p.hiredate>(select hiredate from professor where name = '송승환')
-- ANSI
select p.name, p.hiredate, m.name
from professor p join major m
on m.code=p.deptno and p.hiredate>(select hiredate from professor where name = '송승환')



-- ***********************************************************190327 정리******************************************************************
/*
	subquery  : where 조건문에 사용되는 내부 select 구문
		단일행subquery : 서브쿼리의 결과가 한개의 레코드인 경우
			사용가능 연산자 : 관계연산자 사용 가능
		복수행subquery : 서브쿼리의 결과가 여러개의 행인 경우
			사용가능 연산자 :  in, any, all(any,all은 안쓰는게 나음)
									in : or 연산자 동일.
									any : 서브쿼리의 결과중 한개라도 조건을 만족하는 경우
									all : 서브쿼리의 모든 결과가 조건을 만족하는 경우
	
*/


-- 사원테이블에서 사원직급의 최대급여보다 급여가 많은 사람의 이름, 직급, 급여 출력하기.
select ename, job, salary
from emp
where salary > ALL(select salary from emp where job='사원') 
-- 위에보다 아래 쓰는게 더 나음
select ename, job, salary
from emp
where salary >(select max(salary) from emp where job='사원') 


-- 사원테이블에서 사원직급의 최소급여보다 급여가 많은 사람의 이름, 직급, 급여 출력하기.
select ename, job, salary
from emp
where salary > ANY(select salary from emp where job='사원') 
-- 위에보다 아래 쓰는게 더 나음
select ename, job, salary
from emp
where salary >(select min(salary) from emp where job='사원') 



-- 문제 1 : 4학년 학생의 체중보다 작은 학생의 이름, 몸무게, 학년을 출력하기.
select name, weight, grade
from student
where weight<(select min(weight) from student where grade=4)

select name, weight, grade
from student
where weight<all(select weight from student where grade=4)
-- 문제 2 : 4학년 학생들 중 키가 작은 학생보다 키가 큰 학생의 이름, 키, 학년을 출력하기.
select name, height, grade
from student
where height>(select min(height) from student where grade=4)

select name, height, grade
from student
where height>any(select height from student where grade=4)


/*
	다중 컬럼 subquery : 비교 대상이 되는 컬럼이 두개 이상
								any, all 연산자 사용 불가함.
								in 만 사용할 수 있다.
*/	

-- 학년 별로 최대키를 가진 학생들의 학년과 이름, 키를 출력하기
select grade, name, height
from student
where height in (select max(height) from student group by grade)


-- 1학년의 최대키를 가진 학생의 학년, 이름, 키를 출력하기.
select grade, name, height
from student 
where height in (select max(height) from student where grade=1) and grade=1


-- 학년별 최대키 구하기.
select grade, max(height) 
from student
group by grade

-- 학년 별로 최대키를 가진 학생들의 학년과 이름, 키를 출력하기
select grade, name, height
from student
where (grade,height) in (select grade, max(height) from student group by grade)
order by grade


-- 문제 1 : 학과별로 입사일이 가장 오래된 교수의 교수번호, 이름, 학과명 출력하기.
select p.no, p.name, m.name
from professor p, major m
where p.deptno=m.code
and (deptno,hiredate) in(select deptno, min(hiredate) from professor group by deptno)

-- 문제 2 : 직급별로 해당 직급의 최대급여를 받는 직원의 이름, 직급, 급여 출력하기.
select ename, job, salary
from emp e
where (e.job,e.salary) in (select job, max(salary) from emp group by job)
order by salary desc


/*
	상호 연관 subquery : 외부 query가 내부 query에 영향을 주는 subquery
								성능이 안좋다.
*/

-- 자신의 직급의 평균급여 이상을 받는 직원의 이름, 직급, 현재 급여를 출력하기.
select ename, job, salary
from emp e1
where salary >= (select avg(salary) from emp e2 where e2.job= e1.job) 


-- 문제 : 교수 자신의 직급의 평균급여보다 적은 급여를 받는 교수의 이름, 직급, 급여, 학과명 출력하기.
select p.name 이름, p.position 직급, p.salary 급여, m.name 학과명
from professor p, major m
where p.deptno=m.code
and p.salary < (select avg(salary) from professor p2 where p2.position=p.position)


/*
	스칼라 subquery : 컬럼절에 사용되어지는 subquery
*/

-- 사원의 사원번호, 이름, 부서명 출력하기
select e.empno, e.ename, d.dname 
from emp e, dept d
where e.deptno=d.deptno

select empno, ename, (select dname from dept d where d.deptno=e.deptno)
from emp e 



/*
	having 절에서 사용되는 subquery
*/

-- 201번 학과의 교수의 인원수보다 큰 인원수를 가지고 있는 부서의 부서코드, 부서명, 인원수를 출력하기.
-- having 절 서브쿼리
select p.deptno, m.name, count(*)
from professor p, major m
where p.deptno=m.code
group by deptno
having count(*) > (select count(*) from professor  where deptno=201)

-- 스칼라 방식
select p.deptno, (select name from major m where m.code=p.deptno), count(*)
from professor p
group by deptno
having count(*) >  (select count(*) from professor  where deptno=201)


/*
	서브쿼리 사용 위치
	- where 조건문
	- 컬럼 부분
	- having 조건문
	- from 구문 => inline view
	
*/


-- 학년의 평균 몸무게가 70보다 큰 학년과 평균 몸무게 출력하기.
select grade, avg(weight) from student
group by grade
having avg(weight) > 70 
-- inline view
select * from 
(select grade, avg(weight) avg from student group by grade) a
where avg > 70

-- 문제 1 : 전공테이블에서 공과대학에 속한 (학부아니고 학과)학과코드와 학과이름을 출력하기.
select m.code, m.name
from major m, major m2
where m.part=m2.code and m2.part=10

-- subquery
select code, name from major
where part in (select code from major where part=10)

-- 문제 2 : 학생테이블에서 학생 중 전공1학과가 101 학과의 평균 몸무게보다 몸무게가 많은 학생의 학번, 이름, 몸무게, 학과명 출력하기.
select avg(weight) from student where major1=101

select s.studno, s.name, s.weight, m.name
from student s, major m
where s.major1=m.code 
and s.weight > (select avg(weight) from student where major1=101)

select s.studno, s.name, s.weight, (select m.name from major m where m.code = s.major1)
from student s
where s.weight > (select avg(weight) from student where major1=101)

