
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