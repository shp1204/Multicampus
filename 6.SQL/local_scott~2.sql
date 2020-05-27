conn scott/oracle
select table_name from user_tables; -- scott����(������)�� ���̺� ���
select table_name from all_tables; -- ���� + ������ ���� ���̺���
select count(table_name) from all_tables;
select count(table_name) from dba_tables; -- ���� ����� ����
conn / as sysdba
select count(table_name) from dba_tables; -- database�� ������ ��ü ���̺� ���� Ȯ��


conn scott/oracle
desc dept
select constraint_type, constraint_type
from user_constraints
where table_name = 'DEPT'; --���̺� ���ǵ� �������� Ȯ��

insert into dept (deptno, dname) values (60, 'IT'); -- ������ �÷������� �ڵ����� null������ �����
insert into dept values ( 70, 'IT', 'seoul');
select * from dept;
-- �޸𸮿��� ���ο� �����Ͱ� �߰���(��������� DB�� ������ �����(file)�� �����Ű�� ��ɾ ������Ѿ� �����
-- ������ ������ ����ǰų� DB ������ ����������Ǹ� �����ʹ� �ڵ����� rollback
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
where 1 = 2; -- ���� �� ����� false�̹Ƿ� �˻� data�� �����Ƿ� ���̺� ������ ������

desc dept
desc dept2
select*from dept;
select*from dept2;

insert into dept2
select*from dept
where deptno <=30; -- values�� ��� subquery�� ���
select*from dept2;

select sal from emp;
update emp set sal = 0; -- ��� ���ڵ��� sal �÷� ���� ���ϰ����� ����
select sal from emp;
rollback;
update emp set sal = sal * 1.1;
select sal from emp;
rollback;
update emp set sal = sal*1.1 where deptno = 20;

-- ���� : smith ����� �޿��� scott ����� �޿��� �����ϵ��� �����Ͻÿ�
update emp set sal = (select sal from emp where ename = 'SCOTT')
where ename = 'SMITH';
--update�� set��, where���� subquery ��� ����
select sal
from emp
where ename in ('SMITH', 'SCOTT');

--���ڵ� ������ ����
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




-- merge��
drop table tiny_emp purge;
create table tiny_emp
as select empno, ename, deptno, sal, job
    from emp
    where deptno = 10;

select * from tiny_emp;

-- ���� :  emp�� �����͸� tiny_emp�� �̰��ϼ���. tiny_emp ���̺� �̹� ���ڵ尡 �����ϸ� �޿��� 10% �λ��ϰ�,
-- �λ�� �޿��� 5000���� ũ�� �����ϰ�, tiny_emp���̺� emp���̺��� �����Ͱ� �������� ������ emp�� �����͸� insert�Ͻÿ�
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


