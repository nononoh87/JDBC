-- 구조잡기
/*
    이름      name        varchar2(10)
    주민번호   jumin      char(15)
    전화번호   tel        varchar2(20)
    성별      gender      varchar2(10)
    나이      age         number(3)
    출신지     home        varchar2(20)
*/
--CREATE TABLE table_name ([column_name data_tyoe]);

CREATE TABLE info_tab
(
name       varchar2(10),
jumin      char(15),
tel        varchar2(20),
gender     varchar2(10),
age        number(3),
home       varchar2(20)
);
-- 테이블 구조 확인
DESC info_tab;

-- 데이타 확인
SELECT * FROM info_tab;

/*  테이블명 : student_score

학번      id          char(4)
학생명   name        varchar2(20)
국어      kor         number(3)
영어      eng         number(3)
총점      total       number
평균      avg         number(3,2) --앞자리는 전체자리수
*/

CREATE TABLE student_score
(
 id          char(4),
 name      varchar2(20),
 kor         number(3),
 eng         number(3),
 total       number,
 avg         number(5,2)
);

DROP TABLE student_score;

DESC student_score;

--수학 컬럼을 추가
--ALTER TABLE table_name ADD ( [ column_name data_type ] );

ALTER TABLE student_score
    ADD(math number(3));
    
-- 총점 컬럼을 삭제하기
DROP TABLE student_score DROP (total);

-- 평균 컬럼에서 소수점 1자로 변경
ALTER TABLE student_score 
MODIFY (avg number(4,1));

DESC student_score;

-- 데이타 입력
-- 문자 : ''
INSERT INTO student_score( id, name, kor, eng ) 
VALUES ( '0001','홍길동', 50,80 );

SELECT* FROM student_score;

-- 2000번 학번인 홍길자으 국어와 영어점수를 각각 60,90으로 저장(입력)
INSERT INTO student_score( id, name, kor, eng ) 
VALUES ( '2000','홍길자', 60,90 );

commit;
rollback;

--1000번 학생 홍길숙 정보를 저장
INSERT INTO student_score( id, name ) 
VALUES ( '1000','홍길숙' );
--이름이 홍길숙인 학생의 레코드를 삭제
--DELETE FROM table_name WHERE condition;
DELETE FROM student_score 
WHERE name='홍길숙';

SELECT* FROM student_score;

--0001번 학생의 국어점수를 100으로 수정하기
--UPDATE table_name SET column=value WHERE condition;
UPDATE student_score
SET kor=100
WHERE id = '0001';

commit;

-- 홍길자의 수학점수를 90 입력하기
UPDATE student_score
SET math = 90
WHERE id = '2000';

SELECT* FROM student_score;

-- 학생들의 평균구하기
UPDATE student_score
set avg = (kor + eng + math) / 3;
-- WHERE
SELECT* FROM student_score;

CREATE TABLE emp_copy
    AS SELECT * FROM emp;

DESC emp_copy;

SELECT * FROM emp_copy;

--1. 사원번호가 7788인 사원의 부서를 10번으로 변경
UPDATE emp_copy
SET deptno =10 
WHERE empno = 7788;
SELECT * FROM emp_copy;

--2. 사원번호가 7782인 사원의 이름을 홍길숙으로 변경하고 급여를 3500으로 변경
UPDATE emp_copy
SET sal = 3500, 
NAME = '홍길숙' 
WHERE empno = 7782;
SELECT * FROM emp_copy;

--3. 모든 부서원의 보너스를 300씩 인상 변경
UPDATE emp_copy 
SET comm = nvl(comm,0) +300;
SELECT * FROM emp_copy;

--4. 사원번호가 7499인 사원의 정보를 삭제
DELETE FROM emp_copy 
WHERE EMPNO = '7499';
SELECT * FROM emp_copy;

--5. 입사일자가 81년 6월 1일 이전인 사원의 정보를 삭제
DELETE FROM emp_copy
WHERE HIREDATE < '1981-06-01';
SELECT * FROM emp_copy;

delete from emp_copy;

select* from emp_copy;

rollback;

select* from emp_copy;

truncate table emp_copy;
select* from emp_copy;
rollback;
select* from emp_copy;

------------------------------------------------------------------------------------------------------------------------------------

-- 8000번 사원으로 <본인이름>과 급여 10000를 저장하세요
INSERT INTO emp( empno,ename,sal ) 
VALUES ( 8000, '노승환', 10000 );

select * from emp;

-- 7788번 사원으로 <본이이름>과 급여 10000을 지정하세요
INSERT INTO emp( empno,ename,sal )
VALUES ( 7788, '노승환', 10000 );

INSERT INTO emp( empno,ename,sal,deptno ) 
VALUES ( 8001, '홍길국', 10000,20 );

select *from emp;
--(#생성안됨 다른 테이블의 키)
INSERT INTO emp( empno,ename,sal,deptno ) 
VALUES ( 8002, '홍길국', 10000,20 );
------------------------------------------
-- 컬럼명은 반드시 써라.
INSERT INTO info_tab(tel,name,jumin,gender,age,home)
VALUES('032','홍자','870128','남자',36,'인천');

select *from info_tab;

INSERT INTO info_tab(tel,name) VALUES('1001', '홍길동');

INSERT INTO info_tab(tel,name) VALUES('1002', '김길동');

INSERT INTO info_tab(tel,name) VALUES('1002', '둘리');

INSERT INTO info_tab(name,jumin) VALUES('김길동','870128-1234567');

INSERT INTO info_tab(gender, age) VALUES('남자', 22);

INSERT INTO info_tab(tel,gender, age) VALUES(9999,'남자', 22);

DELETE FROM info_tab;
commit;

ALTER  TABLE   info_tab
ADD  CONSTRAINT  pk_info_tel  PRIMARY  KEY ( tel );

DROP TABLE info_tab;

CREATE TABLE info_tab
(
name       varchar2(10),
jumin      char(15),
tel        varchar2(20),
gender     varchar2(10),
age        number(3),
home       varchar2(20),
CONSTRAINT pk_info_tel PRIMARY KEY (tel)
);
ALTER TABLE info_tab
    MODIFY (name varchar2(10) not null);

ALTER TABLE info_tab
    ADD CONTRAINT up_info_jumin UNIQE (jumin);
    
INSERT INTO info_tab(tel,name ,jumin) VALUES('20001','홍실이','990101');
INSERT INTO info_tab(tel,name ,jumin) VALUES('20002','홍동이','990101');
INSERT INTO info_tab(tel,name) VALUES('20001','홍홍이');

ALTER TABLE info_tab
    ADD CONSTRAINT ck_info_gender CHECK (gender in('남성','여성'));
    
INSERT INTO info_tab(tel,name,gender) VALUES ('1001','홍돌이','남성');
INSERT INTO info_tab(tel,name,gender) VALUES ('2001','홍숙이','남자');    
INSERT INTO info_tab(tel,name,gender) VALUES ('3001','홍숙이','여성');    

ALTER TABLE info_tab
    MODIFY (gender varchar2(6) default '남성');
    
INSERT INTO info_tab(tel,name) VALUES('7777','홍이');

INSERT INTO info_tab( name, tel, jumin ) 
VALUES('갑순이', '02-777-4444', '990909-1234567');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('갑갑이','03-555-5555', '880808-1234567', '남자', 27,'경기');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('홍길동','03-031-0310', '900909-1234567', '남성', 27,'경기');

INSERT into info_tab( name, jumin) 
VALUES('홍길자', '550505-1234567');

INSERT INTO info_tab( tel, jumin ) 
VALUES('031-777-7777', '700707-1234567');

INSERT INTO info_tab( name, tel, jumin ) 
VALUES('갑동이', '031-000-0000', '700707-1234567');

CREATE TABLE info_tab
(
name       varchar2(10) NOT NULL,
jumin      char(15),
tel        varchar2(20),
gender     varchar2(10) default '남성',
age        number(3),
home       varchar2(20),
deptno      number(2),
CONSTRAINT pk_info_tel PRIMARY KEY (tel),
CONSTRAINT up_info_jumin UNIQUE (jumin),
CONSTRAINT ck_info_gender CHECK (gender IN ('남성','여성')),
CONSTRAINT fk_info_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno)
);
-- NOT NULL(주로 name에 많이 쓰임, null값을 허용하지 않음)
-- UNIQUE(주로 주민번호에 쓰임, 유일하게 식별하는 값만 허용 -> 중복허용안함)
-- PRIMARY KEY(주로 전화번호에 쓰임, null값 허용하지 않고 유일하게 식별)
-- CHECK(주로 성별구분에 쓰임, 제한적인 입력처리)
-- (*) DEFAULT(값을 지정 해주지 않았을때 기본값이 나오는것)
INSERT INTO info_tab( name, tel, deptno ) VALUES('7777','맹이','20');
INSERT INTO info_tab( name, tel, deptno ) VALUES('8888','꽁이','22');
INSERT INTO info_tab( name, tel ) VALUES('9999','짱이');

CREATE TABLE sawon
(
sabun            number(6),
sawon_name       varchar2(15),
ubmu             varchar2 (10),
weolgub          number(10,2),
buseo            varchar2(6),
CONSTRAINT pk_sawon PRIMARY KEY (sabun) --2번
);

--3
ALTER TABLE sawon
    add (jiyeok varchar2(30) not null);
--4
ALTER TABLE sawon
    MODIFY(weolgub number(7));
--5
ALTER TABLE sawon 
    add constraint ubmu_CHECK CHECK(ubmu IN ('개발', '유지', '관리'));
--6
ALTER TABLE sawon
    MODIFY( ubmu DEFAULT '개발');
--7
CREATE TABLE buseo
(
buseo_no        varchar2(9),
buseo_name      varchar2(30)
);
--8
alter table sawon
add constraint fk_buseo foreign key (buseo) references buseo(buseo_no);

--9
INSERT INTO buseo( buseo_no, buseo_name )
VALUES('101','소프트웨어유지보수부');

INSERT INTO buseo( buseo_no, buseo_name )
VALUES('202','관리부');

INSERT INTO buseo( buseo_no, buseo_name )
VALUES('202','인적자원부');

--10
INSERT INTO sawon( sabun,sawon_name,weolgub,buseo,	jiyeok) 
VALUES ('8001','홍길동이군','100000','101','부산');

INSERT INTO sawon( sabun,sawon_name,ubmu,weolgub,buseo,	jiyeok) 
VALUES ('8002','홍길자','사무','200000','202','인천');

INSERT INTO sawon( sabun,sawon_name,ubmu,buseo,jiyeok) 
VALUES ('8003','홍길순','개발','111','대전');

INSERT INTO sawon( sabun,sawon_name,weolgub,jiyeok) 
VALUES ('8004','홍길석','12345678','서울');

INSERT INTO sawon( sabun,sawon_name,ubmu,buseo,jiyeok) 
VALUES ('8005','홍길철','유지보수','303','판교');

--11
ALTER TABLE sawon DROP ( jiyeok );
select * from buseo;
--12
DELETE FROM buseo WHERE buseo_name='인적자원부';

--13
DROP TABLE sawon;

--14
CREATE TABLE sawon
(
sabun            number(6),
sawon_name       varchar2(15),
ubmu             varchar2 (30) default '개발',
weolgub          number(7),
buseo            varchar2(6),
jiyeok           varchar2(30) not null,
CONSTRAINT pk_sawon PRIMARY KEY (sabun),   
CONSTRAINT ubmu_check check(ubmu IN('개발','유지보수','관리')),
CONSTRAINT fk_buseo FOREIGN KEY(buseo) references buseo(buseo_no)
);
CREATE TABLE buseo
(
buseo_no        number(3),
buseo_no        varchar2(30),
constraint pk_buseo_no PRIMARY KEY(buseo_no)
);
select *from sawon;

------------------------------------------------------------------------------------------------------------------------------------

/*
    SELECT  검색할 항목들
    FROM    테이블명
    WHERE   조건;
*/

-- 모든 사원의 사원명과 급여, 급여와 보너스를 더한 합계 출력
SELECT ename, sal, sal+nvl(comm,0) AS total_sal -- 반드시 별칭 만드어야함(필수)
FROM emp;

--WHERE
SELECT ename||''||job AS staff -- 반드시 별칭 만드어야함(필수)
FROM emp;

SELECT distinct job FROM emp;

------------------------------------------------------------------------------------------------------------------------------------

[ 연습 ] SQL 기초

--1. sawon 테이블을 생성하세요.
--sabun은 6자리 숫자
--sawon_name은 최대 한글 5자리
--ubmu는 최대 한글 10자리
--weolgub는 정수형 8자리와 소수점 2자리
--buseo는 숫자 3자리
create table sawon
(
sabun number(6),
sawon_name varchar2(15),
ubmu varchar2(30),
weolgub number(10,2),
buseo number(3)
);

--2. 위의 테이블에서 sabun을 기본키로 설정
alter table sawon
add constraint pk_info_sabun primary key(sabun);

--3. 최대 한글 10자리의 jiyeok 컬럼을 추가하되 NULL 값이 입력되지 않도록 지정
alter table sawon
add (jiyeok varchar(30) not null);

--4. weolgub 컬럼은 정수형 7자리로 변경
alter table sawon
modify(weolgub number(7));

--5. ubmu컬럼은 ‘개발’, ‘유지보수’, ‘관리’ 만 데이터 값으로 입력되도록 지정
alter table sawon
add constraint ubmu_check check(ubmu in ('개발', '유지보수', '관리'));

--6. ubmu컬럼에 데이터가 입력이 안될 경우 디폴드값으로 ‘개발’을 설정
alter table sawon
modify(ubmu default '개발');

--7. buseo 테이블을 생성하세요
--buseo_no는 숫자 3자로 이루어진 번호로 기본키
--buseo_name은 최대 한글 10자리
create table buseo
(
buseo_no number(3),
buseo_name varchar2(30),
constraint pk_info_buseo_no primary key (buseo_no)
);

--8. sawon 테이블의 buseo 컬럼을 buseo 테이블의 buseo_no를 참조하는 외래키로 설정
alter table sawon
add constraint fk_info_buseo foreign key (buseo) references buseo(buseo_no);


--9. buseo 테이블에 데이터 입력
insert into buseo(buseo_no, buseo_name)
values (101, '소프트웨어유지보수부');
insert into buseo(buseo_no, buseo_name)
values (202, '관리부');
insert into buseo(buseo_no, buseo_name)
values (303, '인적자원부');

--10. sawon 테이블에 데이터 입력 (입력이 안될 경우도 있음)
insert into sawon (sabun, sawon_name, weolgub, buseo, jiyeok)
values(8001,'홍길동이군',100000, 101,'부산');
insert into sawon (sabun, sawon_name, ubmu, weolgub, buseo, jiyeok)
values(8002,'홍길자','사무',200000, 202,'인천'); --의무 종류 안됨
insert into sawon (sabun, sawon_name, ubmu, buseo, jiyeok)
values(8003,'홍길순','개발', 111,'대전'); --부서 부서에 없음
insert into sawon (sabun, sawon_name, weolgub, jiyeok)
values(8004,'홍길석',12345678,'서울'); --월급걸림
insert into sawon (sabun, sawon_name, ubmu, buseo, jiyeok)
values(8005,'홍길철','유지보수', 303,'판교');

--11. sawon 테이블에서 jiyeok 컬럼을 제거
alter table sawon
drop column jiyeok;

--12. buseo 테이블에서 buseo 명이 ‘인적자원부’인 행을 삭제
delete from buseo
where buseo_name = '인적자원부'; --다음주에 다시합니다.

--13. sawon 테이블이 모든 내용을 삭제하고 저장공간을 해제
drop table sawon; --답은 truncate을 사용
--truncate table sawon;

--14. 1~8 단계까지를 각각의 테이블을 각각 하나의 CREATE 문으로 작성
create table sawon --1
(
sabun number(6),
sawon_name varchar2(15),
ubmu varchar2(30) default '개발', --6
weolgub number(7), --4
buseo number(3),
jiyeok varchar(30) not null, --3
constraint pk_sabun primary key(sabun), --2
constraint ubmu_check check(ubmu in ('개발', '유지보수', '관리')), --5
constraint fk_info_buseo foreign key (buseo) references buseo(buseo_no) --8
);

create table buseo --7
(
buseo_no number(3),
buseo_name varchar2(30),
constraint pk_buseo_no primary key (buseo_no)
)
--drop table buseo;

------------------------------------------------------------------------------------------------------------------------------------

[ 연습 ] select 검색

-- 1- 20번 부서에서 근무하는 사원의 사원번호, 이름, 부서번호 출력
SELECT empno, ename, deptno
FROM   emp
WHERE  deptno=20;

-- 2- 입사일이 81/01/01에서 81/06/09인 사원의 사원번호, 이름, 입사일을 출력
SELECT empno, ename, deptno,hiredate 
FROM   emp
WHERE hiredate BETWEeN'1981/01/01'AND'1981/06/09';

-- 3- 담당업무가 salesman, clerk인 사원들의 이름과 업무를 출력
SELECT ename, job
FROM   emp
WHERE JOB='SALESMAN'or job = 'CLERK' ;

SELECT ename, job
FROM   emp
WHERE JOB IN('SALESMAN', 'CLERK') ;

SELECT ename, job
FROM   emp
WHERE JOB=upper('salesman')or job = upper('clerk') ;

-- 4- 업무가 president이고 급여가 1500이상이거나 업무가 salesman인 사원의 정보를 출력
SELECT*FROM emp
WHERE (job= 'PRESIDENT' and sal >=1500) or job= 'SALESMAN';

-- 5- 업무가 president 또는 salesman이고 급여가 1500이상인 사원의 정보를 출력
SELECT*FROM emp
WHERE (job= 'PRESIDENT' or job= 'SALESMAN') and sal >1500;

-- 6- 커미션(comm)이 없는 사원의 이름, 급여, 커미션을 출력
SELECT ENAME,SAL,COMM
FROM EMP
WHERE COMM IS NULL OR COMM =0;

-- 7- 사원명, 급여, 커미션, 총급여( 급여 + 커미션)을 출력
SELECT ENAME, SAL, COMM, SAL+NVL(COMM,0) AS TOTAL_SAL
FROM EMP;

-- 8- 이름 A로 시작하는 사원명 출력
SELECT ENAME
FROM EMP
WHERE ENAME LIKE 'A%';

-- 9- 이름이 두번째 문자가 L인 사원명 출력
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '_L%';

-- 10- 이름에 L이 두 번 이상 포함된 사원명 출력
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%L%L%';

-- 11- 커미션(COMM)이 NULL이 아닌 사원의 모든 정보를 출력
SELECT * FROM EMP
WHERE COMM IS NOT NULL;

-- 12- 보너스가 급여보다 10%이상 많은 모든 사원에 대해 이름, 급여, 보너스를 출력
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM >= SAL*1.1;

-- 13- 업무가 clerk이거나 analyst이고 급여가 1000, 3000, 5000이 아닌 모든 사원의 정보를 출력
SELECT * FROM EMP
WHERE (JOB='CLERK' OR JOB='ANALYST') AND SAL !=1000 AND SAL !=3000 AND SAL !=5000;

SELECT * FROM EMP
WHERE JOB IN ('CLERK','ANALYST') AND SAL !=1000 AND SAL !=3000 AND SAL !=5000;

SELECT * FROM EMP
WHERE JOB IN('CLERK','ANALYST') AND SAL not in(1000,3000,5000);

-- 14- 부서가 30이거나 또는 관리자가 7782인 사원의 모든 정보를 출력
SELECT * FROM EMP
where DEPTNO=30 OR MGR='7782';

select * from emp;

---------------------------------------------------------------
SELET v.vno , v.title e, c.name d, s.tel cc, r.bw_date + 3 b, '미납'a
FROM customer c join rental r on c.tel = r.tel
join video v on v.vno = r.vno
and r.status = 'N';


















