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




