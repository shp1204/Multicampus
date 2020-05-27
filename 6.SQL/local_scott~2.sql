conn scott/oracle
select table_name from user_tables; -- scott소유(생성한)의 테이블 목록
select table_name from all_tables; -- 소유 + 권한을 받을 테이블목록
select count(table_name) from all_tables;
select count(table_name) from dba_tables; -- 권한 불충분 오류
conn / as sysdba
select count(table_name) from dba_tables; -- database의 생성된 전체 테이블 정보 확인


conn scott/oracle
desc dept
select constraint_type, constraint_type
from user_constraints
where table_name = 'DEPT'; --테이블에 정의된 제약조건 확인

insert into dept (deptno, dname) values (60, 'IT'); -- 생략된 컬럼값으로 자동으로 null값으로 저장됨
insert into dept values ( 70, 'IT', 'seoul');
select * from dept;
-- 메모리에만 새로운 데이터가 추가됨(명시적으로 DB의 물리적 저장소(file)에 저장시키는 명령어를 실행시켜야 저장됨
-- 세션이 비정상 종료되거나 DB 서버가 비정상종료되면 데이터는 자동으로 rollback
rollback;
select * from dept;
insert into dept(dname, loc) values ('web', 'inchon');






drop table EMP purge;

select constraint_type, constraint_type
from user_constraints
where table_name = 'EMP';

insert into emp (empno, ename, deptno, hiredate) values(9001, 'kim', 80, sysdate);
insert into emp (empno, ename, deptno, hiredate) values(10001, 'kim', 50, sysdate);
insert into emp (empno, ename, deptno, hiredate) values(1239, 'kim', 50, sysdate);
insert into emp (empno, ename, deptno, hiredate) values(1000, 'lee', 50, sysdate);






drop table student purge;
create table student(
grade number(1),
class number(2),
name varchar2(15),
exam number(3) default 50);

describe student
desc student

insert into student values(1,1,'Hong',null);
insert into student values(1,2,'Hong');
insert into student values(1,2,'Hong',default);
insert into student values(grade,class,name) values (1,3,'Hong');
select*from student;

drop table dept2 purge;

create table dept2
as select*from dept
where 1 = 2; -- 조건 평가 결과는 false이므로 검색 data가 없으므로 테이블 구조만 복제됨

desc dept
desc dept2
select*from dept;
select*from dept2;

insert into dept2
select*from dept
where deptno <=30; -- values절 대신 subquery를 사용
select*from dept2;

select sal from emp;
update emp set sal = 0; -- 모든 레코드의 sal 컬럼 값이 단일값으로 변경
select sal from emp;
rollback;
update emp set sal = sal * 1.1;
select sal from emp;
rollback;
update emp set sal = sal*1.1 where deptno = 20;

-- 문제 : smith 사원의 급여를 scott 사원의 급여와 동일하도록 변경하시오
update emp set sal = (select sal from emp where ename = 'SCOTT')
where ename = 'SMITH';
--update의 set절, where절에 subquery 사용 가능
select sal
from emp
where ename in ('SMITH', 'SCOTT');

--레코드 단위로 삭제
select count(*) from emp;

delete from emp;
select count(*) from emp;

rollback;

delete count(*) from emp;
delete from emp where deptno = 20;
select count(*) from emp;
select deptno from emp;
rollback;

delete from emp where job = (select job from emp where ename='SMITH');
select count(*) from emp;




-- merge문
drop table tiny_emp purge;
create table tiny_emp
as select empno, ename, deptno, sal, job
    from emp
    where deptno = 10;

select * from tiny_emp;

-- 문제 :  emp의 데이터를 tiny_emp로 이관하세요. tiny_emp 테이블에 이미 레코드가 존재하면 급여를 10% 인상하고,
-- 인상된 급여가 5000보다 크면 삭제하고, tiny_emp테이블에 emp테이블의 데이터가 존재하지 않으면 emp의 데이터를 insert하시오
merge into tiny_emp t
using emp s
on (t.empno = s.empno)
when matched then
    update set t.ename = s.ename, t.deptno=s.deptno, t.sal=s.sal*1.1, t.job=s.job
    delete where t.sal > 5000
when not matched then
insert(t.empno, t.ename, t.deptno, t.sal, t.job)
values(s.empno, s.ename, s.deptno, s.sal, s.job);
select * from tiny_emp;

rollback;


