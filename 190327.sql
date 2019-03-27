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
where m.name = '컴퓨터정보학부'

-- 7. 학생 중에서 생년월일이 가장 빠른 학생의 학번, 이름, 생년월일을 출력하기
select studno, name, birthday
from student
where birthday = (select min(birthday) from student)

-- 8. 학년별로 평균체중이 가장 적은 학년의 학년과 평균 몸무게를 출력

select * from (select grade, avg(weight) avg from student group by grade) a
group by grade
having avg<= all (select avg(weight) from student group by grade)

-- 9. 교수 테이블에서 평균 연봉보다 많이 받는 
--    교수들의 교수번호 이름, 연봉, 학과명을 연봉이 높은 순으로 정렬하여 출력하기. 
--    보너스가 없으면 0으로 계산함.  단 연봉은 (급여+보너스) *12 한 값이다.
select p.name, (p.salary*12+ifnull(p.bonus,0)), m.name
from professor p , major m
where p.deptno=m.code
and (salary*12+ifnull(bonus,0))>(select avg(salary*12+ifnull(bonus,0)) from professor )
