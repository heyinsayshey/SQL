/*
	<면접 단골 질문>
 	DDL : Data Definition Language(데이터 정의 언어.)
 			객체(table, view, user, index...)를 생성(create), 삭제(drop), 수정(alter)할 수 있는 언어
 			truncate 명령어 : 테이블에서 데이터를 제거하기. 
 	 	   => delete 도 데이터를 제거함. 
 	 		
 	 		truncate						delete
 	 		DDL언어	 					 DML언어
 	 		데이터가 복구안됨  		rollback 가능함
 	 		rollback 안됨
 	 		모든데이터가 제거		조건에 맞는 데이터 제거
 	 		성능이 좋다. 				
 	mariaDB : database => 객체들을 저장할 수 있는 저장공간. 
 	oracle : tablespace 개념과 비슷함.
*/


/*
	create 명령어 => 객체를 생성할 수 있는 기능

	create 객체종류 객체이름(
		컬럼이름1 	자료형	제약조건
		....
	)
*/


-- test1 테이블을 생성하기.
create table test1 (
	no int primary key auto_increment,
	name varchar(20),
	birth datetime
)

/*
	기본키 : primary key. 대표컬럼. 값 중복불가.
	자동 증가 기능 :  auto_increment (기본키이면서 숫자컬럼에서만 사용가능)(오라클에 없는 기능 : 시퀀스 기능 이용해야 함)
	
	
*/
insert into test1 (name,birth) values('홍길동',now())
insert into test1 (name,birth) values('홍길동',now())
desc test1
select * from test1

/*
	기본키가 두개 컬럼인 경우
	
*/

create table test2(
	num int,
	seq int,
	title varchar(100),
	content varchar(1000),
	primary key(num,seq)
)

insert into test2 (num,seq,title,content) values (1,1,'1-1 게시글','1-1 내용');
insert into test2 (num,seq,title,content) values (1,2,'1-2 게시글','1-2 내용');
insert into test2 (num,seq,title,content) values (2,1,'2-1 게시글','2-1 내용');
insert into test2 (num,seq,title,content) values (2,2,'2-2 게시글','2-2 내용');

select * from test2

/*
	테이블 생성시 기본값 설정하기
*/

create table test3(
	no int primary key,
	name varchar(20) default '홍길동' -- 아무런 값이 들어오지 않으면 홍길동으로 설정해라.
)

insert into test3 (no) values (1)
insert into test3 (no,name) values (2,'이몽룡')
insert into test3 (no) values (3)
select * from test3


/*
	기존테이블을 이용하여 테이블 생성하기
*/

-- dept 테이블과 똑같은 테이블 dept2 를 생성하기.
-- 구조와 데이터도 동일하게 생성하기.

select * from dept

create table dept2
as select * from dept

select * from dept2


-- dept 테이블과 똑같은 테이블 dept3 를 생성하기.
-- 구조는 동일하지만 데이터 저장하지 않도록 생성하기.

create table dept3
as select * from dept where 1=2 -- 조건을 거짓으로 만든다.

select * from dept3

-- dept 테이블과 똑같은 테이블 dept4 를 생성하기.
-- 구조는 동일하지만 데이터는 서울지역인 레코드만 저장하기.
create table dept4
as select * from dept where loc='서울'

select * from dept4

-- dept 테이블과 똑같은 테이블 dept5 를 생성하기.
-- dept 테이블에서 deptno, dname 컬럼으로만 이루어진 테이블로 생성하기.
create table dept5
as select deptno, dname from dept

select * from dept5

-- 문제 1 : 테이블 test4 를 생성하기. 컬럼은 정수형인 no가 기본키로 , name 문자형 20자리, tel 문자형 20자리, loc 문자형 20자리, addr 문자형 100자리로
-- 기본값을 서울시 금천구로 설정하기
create table test4(
	no int primary key,
	name varchar(20),
	tel varchar(20),
	loc varchar(20),
	addr varchar(100) default '서울시 금천구'
)

select * from test4
-- 문제 2 : 교수 테이블로부터 101 학과 교수들의 번호, 이름, 학과코드, 급여, 보너스, 직급만을 컬럼으로 가지는 professor_101 테이블을 생성하기.
create table professor_101
as select no, name, deptno, salary, bonus, position from professor where deptno='101'

select * from professor_101



/*
	기존 객체 제거하기 : drop
	drop 객체종류 객체이름
*/

-- test3 제거하기

drop table test3
select * from test3

-- test4 제거하기
drop table test4
select * from test4



-- truncate 명령어 : 테이블 구조만 남고 레코드가 다 날아감. 
select * from dept2

truncate table dept2

select * from dept2


/*
	alter : 객체(table)의 구조 변경하기
*/

create table major2 as select * from major

select * from major2

-- major2 테이블에 loc 컬럼을 추가하기
desc major2

alter table major2 add (loc varchar(100))

select * from major2

-- major2 테이블에 loc 컬럼 크기를 50으로 변경하기.
alter table major2 modify loc varchar(50)

-- major2 테이블에 loc 컬럼의 이름을 area 로 변경하기.
alter table major2 change loc area varchar(50)

-- major2 테이블에서 area 컬럼을 제거하기.
alter table major2 drop area

desc major2

-- pointitem 테이블에 no 컬럼을 기본키로 설정하기
select * from pointitem
-- 기본키로 설정하려면 값이 유일해야 함. 
alter table pointitem add constraint primary key(no)

-- constraint : 제약조건
--						기본키, 외래키 ....

-- emp 테이블의 deptno 컬럼의 값은 반드시 dept 테이블의 deptno 컬럼의 값에 있는 값만 사용이 가능함. 
-- emp 테이블의 deptno 컬럼을 외래키로 지정하기.
alter table emp add constraint foreign key(deptno)
		references dept(deptno)
		
select * from dept

select DISTINCT deptno from emp

insert into emp (empno,ename,job,salary,deptno)
values (9000,'홍길동','임시직',100,50)

select * from emp

-- 문제 1 :  dept2 테이블을 제거하기.
drop table dept2
-- 문제 2 : dept2 테이블을 dept 테이블의 deptno, dname의 컬럼만 가지도록 하고, 데이터는 loc 값이 서울이 아닌 레코드만 선택하여 저장하기.
-- dept2 테이블에 area 컬럼을 문자형 50 크기로 설정하기
-- deptno 컬럼을 dept 테이블의 deptno 컬럼의 외래키로 지정하기
select * from dept2 

create table dept2 
as select deptno, dname from dept where loc != '서울'

alter table dept2 add (area varchar(50))

alter table dept2 add constraint foreign key(deptno)
references dept(deptno)

-- 문제 3 : student 테이블로부터 각 학년에 해당하는 student1~student4 테이블을 각각의 데이터를 구분하여 저장하기.
select * from student4

create table student1
as select * from student where grade = 1
create table student2
as select * from student where grade = 2
create table student3
as select * from student where grade = 3
create table student4
as select * from student where grade = 4

-- 문제 4 : student1~student4 테이블의 major1 과 major2 컬럼은 major 테이블의 code 컬럼을 외래키로 설정하기.
-- 또한, score 컬럼을 int 형으로 추가하기.
alter table student1 add constraint foreign key(major1) references major(code)
alter table student1 add constraint foreign key(major2) references major(code)

alter table student2 add constraint foreign key(major1) references major(code)
alter table student2 add constraint foreign key(major2) references major(code)

alter table student3 add constraint foreign key(major1) references major(code)
alter table student3 add constraint foreign key(major2) references major(code)

alter table student4 add constraint foreign key(major1) references major(code)
alter table student4 add constraint foreign key(major2) references major(code)

select * from student4

alter table student1 add (score int)
alter table student2 add (score int)
alter table student3 add (score int)
alter table student4 add (score int)


-- cafeExam_0327
-- 1. 사원 테이블에서 부서별 평균연봉 중 가장 작은 평균 연봉보다 적게 받는 직원의
--  직원명,부서명, 연봉 출력하기. 
--  연봉은 급여*12+bonus. 보너스가 없는 경우는 0으로 처리한다.
--방법 1
select ename, d.dname, salary*12+ifnull(bonus,0)
from emp e, dept d
where e.deptno=d.deptno
and (salary*12+ifnull(bonus,0)) < all
(select avg(salary*12+ifnull(bonus,0)) from emp group by deptno)

--방법2
select ename, d.dname, salary*12+ifnull(bonus,0)
from emp e, dept d
where e.deptno=d.deptno
and (salary*12+ifnull(bonus,0)) < 
 (select min(avg) from 
 (select avg(salary*12+ifnull(bonus,0)) avg from emp group by deptno) a)

-- 2. 이상미 교수와 같은 입사일에 입사한 교수 중 이영택교수 보다 
--    월급을 적게받는 교수의 이름, 급여, 입사일 출력하기
select name, salary, hiredate
from professor
where salary < (select salary from professor where name = '이영택')
and hiredate in (select hiredate from professor where name='이상미')


-- 3. 101번 학과 학생들의 평균 몸무게 보다  
--   몸무게가 적은 학생의 학번과,이름과, 학과번호, 몸무게를 출력하기
select studno, name, major1, weight
from student
where weight < (select avg(weight) from student where major1=101 group by major1 )

-- 4.자신의 학과 학생들의 평균 몸무게 보다 몸무게가 적은 
--   학생의 학번과,이름과, 학과번호, 몸무게를 출력하기
select s1.studno, s1.name, s1.major1, s1.weight
from student s1
where s1.weight < (select avg(weight) from student s2 where s2.major1=s1.major1)
order by major1

-- 5. 학번이 960212학생과 학년이 같고 키는 950115학생보다  큰 학생의 이름, 학년, 키를 출력하기
select name, grade, height
from student
where grade in (select grade from student where studno=960212)
and height > (select height from student where studno=950115)

-- 6. 컴퓨터정보학부에 소속된 모든 학생의 학번,이름, 학과번호, 학과명 출력하기
select s.studno, s.name, s.major1, m.name
from student s, major m
where s.major1=m.code 
and m.part = (select code from major where name=;

-- 7. 학생 중에서 생년월일이 가장 빠른 학생의 학번, 이름, 생년월일을 출력하기
select studno, name, birthday
from student
where birthday = (select min(birthday) from student)

-- 8. 학년별로 평균체중이 가장 적은 학년의 학년과 평균 몸무게를 출력
-- 방법1
select * from (select grade, avg(weight) avg from student group by grade) a
group by grade
having avg<= all (select avg(weight) from student group by grade)

-- 방법2
select grade, avg(weight)
from student 
group by grade
having avg(weight) = (select min(avg) from
(select avg(weight) avg from student group by grade) a)

-- 9. 교수 테이블에서 평균 연봉보다 많이 받는 
--    교수들의 교수번호 이름, 연봉, 학과명을 연봉이 높은 순으로 정렬하여 출력하기. 
--    보너스가 없으면 0으로 계산함.  단 연봉은 (급여+보너스) *12 한 값이다.
select p.name, ((p.salary+ifnull(bonus,0))*12), m.name
from professor p , major m
where p.deptno=m.code
and (p.salary+ifnull(bonus,0))*12 >(select avg(p.salary+ifnull(bonus,0))*12 from professor )
order by 2 desc


-- ************************************************190328 정리****************************************************************

subquery : 상호연관 서브쿼리 => 외부쿼리의 값이 내부쿼리에 영향
	- 스칼라 서브쿼리 : 컬럼부분에 사용되는 서브쿼리(조인 대신 사용하고자 할 때) 
	- inline view : from 절에서 사용되는 서브쿼리, 반드시 alias를 주어야 한다.
	- having 절 서브쿼리
	- where 절 서브쿼리
	
	
DDL : Data Definition Language (데이터 정의어)
		=> 객체(table, view, index, user, ...)의 생성(create), 수정(alter), 객체 삭제(drop), 내용삭제(truncate)
		- create : 객체를 생성
		- alter : 객체의 구조를 변경 
		- drop : 객체를 제거
		- truncate : 객체는 그대로, 안의 내용을 제거함.  
	
	=> commit과 rollback 의 대상이 아님.
	
	
--  *****************************************************************************************************


/*
	DML : Data Manipulation Language(데이터 조작어)
			CRUD 
			- C : 데이터 생성 => insert
			- R : 데이터 읽기 => select
			- U : 데이터 변경 => update
			- D : 데이터 삭제 => delete
		=> commit(정상 , 그대로 실행) 과 rollback( 오류발생, 모든 것 취소) 이 가능하다.(transaction 트랜잭션)				
		- transaction : all of nothing
*/	

/*

-- insert : 데이터 추가
		insert into 테이블명 [(컬럼명1, 컬럼명2,....)] values (값1, 값2.....)
*/	

select * from dept

-- deptno : 90, dname : '특판팀', loc : '부산' 값을 집어넣기.
insert into dept (deptno, dname, loc) values (90, '특판팀', '부산')

-- deptno : 91 dname : '특판1팀' loc : '대구' 값을 집어넣기. 
-- 앞에 컬럼명 안쓰려면 반드시 모든 컬럼 수와 순서에 맞는 values 값을 집어넣어야 한다. 
insert into dept values (91, '특판1팀', '대구')

-- deptno : 92, dname : '특판2팀' 값을 집어넣기.
insert into dept (deptno, dname) values (92, '특판2팀')
insert into dept values (93, '특판3팀', ' ')

/*
	컬럼부분을 기술하지 않고 insert 구문 사용하기
		1. 모든 컬럼을 테이블의 구조대로 값을 입력해야 한다.
		2. 모든 컬럼의 순서대로 값이 설정되어야 한다.
	
	컬럼부분을 기술하고 insert 구문 사용하기 => 권장사항
		1. 모든 컬럼에 값을 넣지 않을 때.
		2. 컬럼의 순서를 모를 때
		3. DB의 구조변경이 빈번할 때 
*/

-- 문제 :  교수테이블에 교수번호 : 6001, 이름 :  홍길동, id : hongkd, 급여 : 300, 입사일 : 2019-02-01, 직책 : 초빙교수 레코드를 추가하기.
insert into professor (no, name, id, salary, hiredate, position) values (6001, '홍길동', 'hongkd', 300, 20190101, '초빙교수')

select * from professor

-- 기존 테이블을 이용하여 데이터 추가하기
create table major3 as select * from major where 1=2
-- major 테이블에서 code가 30 이상인 데이터만 major3 테이블에 데이터 추가하기.
insert into major3 select * from major where code>=200
select * from major10
drop table major10

-- 문제1: major10 테이블을 major 테이블과 같은 구조로 생성하기.데이터는 추가하지 않도록 하기.
-- major10 테이블에 공과대학에 속한 학과 정보만 데이터 추가하기.
create table major10 
as select * from major where 1=2

insert into major10 
select * from major where part in (select code from major where part in (select code from major where name='공과대학'))

-- 문제 2 : student1 테이블의 모든 내용을 제거한 후, 1학년 학생 중 평균키 이상인 학생의 정보만 저장하기.
truncate table student1

-- 방법1 : 앞에 컬럼 쓰지 않고 넣기 
insert into student1 
select *,0 from student  -- 컬럼값 추가하기
where grade=1
and height >= (select avg(height) from student)

select * from student1
desc student
desc student1

-- 방법2 : 앞에 컬럼 써주는 방법
insert into student1 (studno,name,id,grade,jumin,major1)
select studno,name,id,grade,jumin,major1 from student  
where grade=1
and height >= (select avg(height) from student)


-- 교수테이블에서 홍길동 교수와 같은 조건으로 오늘 입사한 이몽룡 교수를 추가하기. 
-- 교수번호 : 6002, 이름 :이몽룡, 입사일 : 오늘, id : monglee
select * from professor

insert into professor (no, name, hiredate, id, position, salary) 
select 6002, '이몽룡', current_date(), 'monglee' ,position, salary from professor 
where name='홍길동'


/*
	update : 컬럼의 값을 수정하기.
	
	update 테이블명 set 컬럼1=값1, 컬럼2=값2.....
	[where 조건문] => 없으면 모든 레코드가 수정.
						=> 있으면 조건문의 결과가 참인 경우만 수정
						
*/

-- 사원 중 직급이 사원인 경우 보너스를 10만원 인상하기. 보너스가 없는 경우 0으로 처리하기.
select ename, job, bonus, ifnull(bonus,0)+10 예상보너스   from emp where job='사원'

update emp set bonus= ifnull(bonus,0)+10
where job='사원'

-- 이상미교수와 같은 직급의 교수중 급여가 350 미만인 교수의 급여를 10% 인상하기.
select * from professor where position=(select position from professor where name='이상미')

update professor set salary=salary*1.1
where position=(select position from professor where name='이상미')
and salary < 350


-- 문제 1 : 교수 테이블에서 보너스가 없는 시간강사의 보너스 값을 조교수의 평균보너스의 50% 로 변경하기.
select * from professor where position='시간강사'

update professor set bonus =  (select avg*0.5 from (select avg(bonus) avg from professor where position='조교수') a)
where position='시간강사'

-- 문제 2 : 지도교수가 없는 학생의 지도교수를 이용학생의 지도교수로 변경하기
select * from student 

update student set profno=(select profno from student where name = '이용')
where profno is null

-- 문제 3 : 교수 중 홍길동과 같은 직급의 교수의 급여를 101 학과의 평균급여로 변경하기. 단, 소수점이하는 반올림하기.
select * from professor where position = (select position from professor where name = '홍길동')

update professor set salary=(select avg(salary) from professor where deptno=101)
where position = (select position from professor where name='홍길동')


set autocommit = 0
rollback



/*
	delete :  레코드 삭제
	
	delete from 테이블명
	[where 조건절] => 없으면 모든 레코드 삭제
						=> 있으면 조건에 맞는 레코드 삭제
						
*/

select * from dept 

-- dept 테이블에서 90번이상의 부서를 삭제하기
delete from dept 
where deptno>=90


set autocommit=0 -- 수동 commit 으로 설정하기.
rollback -- 버퍼의 내용을 지우고 원래 저장공간에 있던 변경하기 전의 내용을 가져온다.
commit -- transation 의 종료. 물리적인 저장공간에 최종적으로 저장한다. 

select * from dept
insert into dept values(90,'특판팀','') => 아직 cmd 창에 안나옴. 저장공간이 변경되지 않았음.


/*
	transation => all or nothing 
	시작과 끝 : commit 부터 다음 commit까지 
	rollback은 모든 거래를 취소한다. 
					(insert, update, delete 가 취소됨)
	
	DDL :  DDL 문장이 실행되면 자동 commit 되는 것임. 되돌릴 수 없다. => 오라클
			 DDL 구문은 취소가 되지 않는다. (create, drop, alter)
*/

select * from dept

insert into dept values(90,'특판팀','')

drop table test1
commit

/*
	<SQL의 종류>
	
	DDL : Data Definition Language (데이터 정의 언어)
		create, alter, drop, truncate
		
	DML : Data Manipulation Language (데이터 조작 언어)
		select, insert, update, delete
		
	TCL : Transation Control Language (트랜젝션 제어 언어)
		commit, rollback
		
	DCL : Data Control Language (데이터 제어 언어)
		grant(승인하다.) :  권한 추가, revoke(철회하다) : 권한 뺏기
	
*/



/*
	view : 가상테이블.
			물리적으로 메모리 할당이 없음.
			테이블인 것처럼 사용됨. => 제약은 있음
			
*/

select * from student where grade = 2

-- 2학년 학생의 학번, 이름, id, height, weight 뷰를 생성하기.
create or replace view v_stu2 -- 뷰를 만들거나 혹시 있으면 수정해라. 
as select studno, name, id, height, weight from student
where grade = 2

select * from v_stu2 -- 해당 테이블에서 필요한 정보만 뽑아서 보여주는 것. 물리적인 저장 공간을 갖지 않는다.
-- 2학년 학생 중에 유진성 학생의 키를 172 로 수정하기. 
update student set height=172 where name='유진성' and grade=2 -- 업데이트 하는 즉시 뷰에 반영됨. 

-- 문제 1 : 2학년 학생의 학생이름, 지도교수번호, 지도교수이름을 가지는 뷰를 v_stu_prof 로 생성하기.
create or replace view v_stu_prof
as select name, profno, (select name from professor p where s.profno=p.no) 
from student s
where grade=2

create or replace view v_stu_prof
as select s.name 학생이름, s.profno 지도교수번호, p.name 지도교수이름
from student s,professor p 
where grade=2

select * from v_stu_prof

-- 3학년 학생으로 이루어진 v_stu3 뷰를 생성하기.
create or replace view v_stu3
as select * from student where grade=3

select * from v_stu3

-- 3학년 학생의 학번, 이름, 학과명을 출력하기. 
select studno 학번, s.name 이름, m.name 학과명
from v_stu3 s, major m
where s.major1 = m.code


-- view 에 insert 가 된다. => 원래 테이블도 같이 수정됨.

insert into v_stu3 (studno, name, id, grade, jumin) values (5001,'홍길동','hongkdd',3,'9001011023456')

select * from student where grade=3

delete from v_stu3 where studno=5001

/*
   view : 원래 테이블의 내용을 가상의 테이블로 생성.
   		view 의 CRUD  실행하면, 원래테이블로부터 실행된다.  
				=> 모든 뷰가 가능한 것은 아님.
			단순뷰 : 한 개의 테이블로 이루어진 뷰
				=> CRD 가능하다. 
   		복합뷰 : 여러개의 테이블로 이루어진 뷰
   		   => CRD 가 안될 수 있다. 
*/




-- cafeExam_0328
-- 1. 교수 테이블에서 홍길동교수와 같은 직급의 교수를 퇴직시키기
select * from professor where position=(select position from professor where name='홍길동')
select * from professor

delete from professor 
where position=(select position from professor where name='홍길동')

-- 2. 교수 테이블에서 교수번호,이름, 이메일, url 컬럼만을 가지는 v_prof
--        view 를 생성하기.
create or replace view v_prof
as select no, name, email, url
from professor

select * from v_prof

-- 3. 학생테이블 중 1학년 학생의 키정보를 저장하는 v_height1 뷰를 생성하기. 
--    단 컬럼은 학번, 학년, 키 로 구성된다.
select * from student where grade=1

create or replace view v_height1
as select studno, grade, height
from student 
where grade=1

select * from v_height1

-- 4. 학생테이블 중 1학년 학생의 몸무게정보를 저장하는 v_weight1 뷰를 생성하기. 
--    단 컬럼은 학번, 학년, 몸무게 으로 구성된다.
select * from student where grade=1

create or replace view v_weight1
as select studno, grade, weight 
from student 
where grade=1

select * from v_weight1

-- 5. 학생의 전공별 최대키,최대몸무게를 저장하는 v_stu_max 뷰를 생성하기
create or replace view v_stu_max
as select major1, max(height), max(weight)
from student
group by major1

select * from v_stu_max


/*
	view 에는 인덱스를 설정할 수 없다.
*/

-- ***********************************************190329 정리**********************************************************

/*
 	inline view : 이름이 없고, 일회성으로 사용되는 뷰
 						select 구문에 from 절에 사용되는 subquery 를 말한다.
 						반드시 별명을 설정해야 한다.
*/


-- 학생의 학번, 이름, 학년, 키, 몸무게, 학년의 최대키, 최대 몸무게 출력하기.
select s.studno, s.name, s.grade, s.height, s.weight, a.xheight, a.xweight 
from student s, (select grade, max(height) xheight, max(weight) xweight from student group by grade) a
where s.grade=a.grade
order by grade

-- 문제 : 교수번호, 이름, 부서코드, 부서명, 자기부서의 평균 급여, 자기 부서의 평균 보너스 출력하기. 보너스 없으면 0
select p.no, p.name, p.deptno,m.name, round(a.avg_s,2), round(a.avg_b,2)
from professor p, major m, (select deptno, avg(salary) avg_s, avg(ifnull(bonus,0)) avg_b from professor group by deptno) a
where p.deptno=a.deptno and p.deptno=m.code
order by p.deptno



