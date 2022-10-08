--[����1]
--�޿��� 2000 �̻� 3000 ������ ����� �̸��� �����ȣ, �Ի���, �޿��� ����ϵ� �̸��� �������� �����ϼ���.
CREATE TABLE EMPLOYEE
(
ENO 	         NUMBER(4,0), 
ENAME 	         VARCHAR2(10 BYTE), 
JOB 	         VARCHAR2(9 BYTE), 
MANAGER        NUMBER(4,0), 
HIREDATE         DATE, 
SALARY 	         NUMBER(7,2), 
COMMISSION    NUMBER(7,2), 
DNO 	         NUMBER(2,0)
);

SELECT ename, eno, hirdate, sal
FROM employee
WHERE salary between 2000 and 3000
ORDER BY ename asc;


--[����2]
--Ŀ�̼��� NULL �� ����̸���, �Ի��� �μ���ȣ�� ����ϵ� �μ���ȣ�� �������� �����ϵ� �μ���ȣ�� ���� �׸��� ���� ��� �̸��� ������������ �����ϼ���.
SELECT 	  ename, hiredate, dno, commission
From 	  employee
where 	  commission is null
ORDER BY dno, ename asc;

--[����3]
-- Ŀ�̼��� 300 �̰ų� 500 �̰ų� 1400�� ����� �����ȣ�� �̸�, ����, Ŀ�̼��� ��� �ϵ� Ŀ�̼��� �������� �����ϼ���.
-- IN �����ڸ� ����ؼ� ��� �ϼ���.
SELECT 	  eno, ename, sal, commission
FROM 	  employee
WHERE 	  commission IN (300, 500, 1400)
ORDER BY commission desc;

--[����4]
--�̸��� ù ���ڰ� ��S���� �����ϴ� ����� �̸��� ����ϼ���.
SELECT 	  ename
FROM 	  employee
WHERE	  ename like 'S%';

--[����5]
--LIKE �����ڿ� ���ϵ� ī�带 ����ؼ� '81'�⵵�� �Ի����� ���� ����� �̸��� �Ի����� ����ϼ���.
SELECT  	  ename, hiredate
FROM 	  employee
WHERE 	  hiredate not like '81%';

--[����6]
--�μ� ��ȣ�� �ߺ� ������ ������������ �����ؼ� ����ϼ���.
SELECT     distinct dno
FROM 	  employee
ORDER BY dno asc;

--[����7]
--�̸��� ��A��  �� ��E�� �� ��� �����ϴ� ����� �̸��� ����ϼ���.
SELECT      ename
FROM       employee
WHERE 	  ename like '%A%' AND ename like '%E%';

--[����8]
--substr �Լ��� ����ؼ� 12�� �޿� �Ի��� ����� �����ȣ, �̸�, �Ի����� ����ϼ���.
SELECT     eno, ename, hiredate
FROM 	  employee
WHERE 	  substr(hiredate,4,2) = '12'; 

--[����9] 
--NVL �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.
SELECT     ename �̸�, salary ����, nvl(commission, 0) ���ʽ�, nvl(salary, 0)*12 ����  
FROM 	  employee
ORDER BY nvl(salary, 0)*12 desc;

--[����10]
--NVL2 �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.
SELECT     ename �̸�, salary ����, nvl(commission, 0) ���ʽ�, nvl2(salary,salary, 0)*12 ����  
FROM 	  employee
ORDER BY nvl2(salary,salary, 0)*12 desc;

--[����11]
--������� �޿� �Ѿ� , ��վ�, �ְ��, �ּҾ��� ��� �ϼ���. �� �÷��� 
--���޿��Ѿס�, ����վ�, ���ְ�ס�, ���ּҾס����� ��Ī�̸����� ����ϼ���.
SELECT 	 sum(salary) �޿��Ѿ�, round(avg(salary),0) ��վ�, min(salary) �ּҾ�, max(salary) �ְ��
FROM	 employee;

--[����12]
--���� ������ ������ ��� �ϼ���.  ����÷��� ������ ������ �������� ��Ī�̸����� ��� �ϼ���.
SELECT 	 count(distinct job) ����_������_����
FROM	 employee;

--[����13]
--�� �μ��� ��� ������ ���ؼ� �μ���ȣ�� ��� ������ ��� �ϵ�  ���� ���μ���ȣ��, ����տ��ޡ� ���� ��Ī�̸����� ����ϼ���.
SELECT      dno �μ���ȣ, round(avg(salary),0) ��տ���
FROM       employee
GROUP BY dno;

--[����14]
--��� ������ ������ ����� ���� ���Ͻÿ�. (���� , count �Լ� ���)
SELECT       job, count(*)
FROM        employee
GROUP BY  job;

--[����15]
--���޺� ����� ���� �޿��� ����Ͻÿ�, �����ڸ� �˼� ���� ��� �� ���� �޿��� 2000 �̸��� �׷��� ���� ��Ű��
--����� �޿��� ���� ������������ �����Ͽ� ��� �ϼ���.
SELECT      job, min(sal)
FROM       employee
WHERE     manager is not null
GROUP BY job   
HAVING    min(sal) > 2000 
ORDER BY min(sal) desc;

--[����16]
--���� ������ ����ؼ� �����ȣ�� 7788�� ����� �������� ���� ����� ��� �Ͻÿ�  <����̸�, ������> ��� �Ͻÿ�
SELECT job FROM employee WHERE eno = 7788;

SELECT    ename ����̸�, job ������
FROM      employee
WHERE    job like (SELECT job FROM employee WHERE eno = 7788);

--[����17]
--���� ������ ����ؼ� �������� 7499 �� ������� �޿��� ���� ����� ��� �Ͻÿ�. <����̸�, ������> ��� �Ͻÿ�.
SELECT salary FROM employee WHERE eno = 7499;

SELECT    ename ����̸�, job ������
FROM      employee
WHERE    salary > (SELECT salary FROM employee WHERE eno = 7499);

--[����18]
--���� ������ ����ؼ� �� �μ��� �ּ� �޿��� �޴� ����� �̸� , �޿�, �μ���ȣ�� ����Ͻÿ�.
SELECT min(salary) FROM employee GROUP BY dno;

SELECT    ename �̸�, salary �޿�, dno �μ���ȣ
FROM      employee
WHERE    salary IN (SELECT min(salary) FROM employee GROUP BY dno);

--[����19]
--���� ������ ����ؼ� �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ������������ �����Ͻÿ�.
SELECT round(avg(salary),0) AVG FROM employee ;

SELECT     eno �����ȣ, ename ����̸�
FROM       employee
WHERE     salary > (SELECT round(avg(salary),0) AVG FROM employee)
ORDER BY salary asc;

--[����20]
--���� ������ ����ؼ� DEPT ���̺� �ִ� �μ��� DNAME �÷�����  ��RESEARCH�� �μ��� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�.
SELECT	 d.deptno, e.ename, e.job
FROM      employee e, dept d
WHERE    e.dno = d.deptno
AND       d.dname = 'RESEARCH';