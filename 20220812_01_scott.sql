--○ EMP 테이블에서 직종이 CLERK 인 사원들의 데이터를 모두 조회한다

SELECT *
FROM EMP
WHERE 직종이 CLERK인 사원들의 데이터;

SELECT *
FROM EMP
WHERE JOB이 'CLERK';

SELECT *
FROM EMP
WHERE JOB = CLERK;
--==>> 에러발생

SELECT *
FROM EMP
WHERE JOB = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		    20
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		    30
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10
*/


--※ 오라클에서 입력된 데이터의 값 만큼은
--   반드시 대소문자 구분을 한다


--○ EMP 테이블에서 직종이 CLERK 인 사원들 중
--   20번 부서에 근무하는 사원들의
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다


SELECT EMPNO "사원번호", ENAME "사원명", JOB "직종명", SAL "급여", DEPTNO "부서번호"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/


-- 1. 칼럼명 확인
DESCRIBE emp;

-- 2. 칼럼명 넣어서 테이블 만들어야 하지만
--    다른 테이블에 있는 데이터를 그대로 넣어 만든 테이블을 만들수도 있다
--    AS 를 사용하여...
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

-- 3. 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7788	SCOTT	ANALYST	    7566	87/07/13	3000		    20
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7876	ADAMS	CLERK	    7788	87/07/13	1100		    20
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
*/

--○ DEPT 테이블을 복사하여 위와 같이 TBL_DEPT 테이블을 생성한다
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT이(가) 생성되었습니다.

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/


SELECT *
FROM USER_TAB_COMMENTS;
--현재 코멘트는 전부 NULL


--○테이블 레벨의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원 정보';


--○ TBL_DEPT 테이블을 대상으로 테이블 레벨의 커멘트 데이터 입력
--   → 부서 번호
COMMENT ON TABLE TBL_DEPT IS '부서 번호';


--○ 커멘트 데이터 입력 후 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EXAMPLE2	TABLE	
TBL_DEPT	    TABLE	부서 번호
TBL_EMP	        TABLE	사원 정보
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--○ 컬럼(COLUMN) 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
EMP	            DEPTNO	
TBL_EXAMPLE2	NAME	
SALGRADE	    HISAL	
BONUS	        JOB	
TBL_DEPT	    LOC	
DEPT	        DNAME	
TBL_EMP	        SAL	
TBL_EMP	        COMM	
TBL_EMP	        JOB	
TBL_EMP	        MGR	
BONUS	        COMM	
TBL_EXAMPLE1	NAME	
SALGRADE	    GRADE	
SALGRADE	    LOSAL	
BONUS	        ENAME	
EMP	            HIREDATE	
EMP	            JOB	
TBL_EXAMPLE1	ADDR	
EMP	            COMM	
EMP	            EMPNO	
TBL_EXAMPLE2	ADDR	
DEPT	        LOC	
EMP	            ENAME	
EMP	            MGR	
TBL_EMP	        HIREDATE	
EMP	            SAL	
TBL_EXAMPLE2	NO	
TBL_DEPT	    DNAME	
DEPT	        DEPTNO	
TBL_EXAMPLE1	NO	
TBL_EMP	        DEPTNO	
TBL_EMP	        EMPNO	
TBL_EMP	        ENAME	
BONUS	        SAL	
TBL_DEPT	    DEPTNO		
*/


--○ 컬럼(COLUMN) 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/


-- COMMENT ON TABLE 테이블명 IS '커멘트';

--○ 테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 입력(설정)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서 번호';

COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서 이름';

COMMENT ON COLUMN TBL_DEPT.LOC IS '부서 위치';

--○ 커멘트 데이터가 입력된 테이블의
--   컬럼 레벨 커멘트 데이터 확인(TBL_DEPT 테이블 소속의 컬럼들만 조회)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';


--○ TBL_EMP 테이블을 대상으로
--   테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 입력(설정)
DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
*/

COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원 번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원명';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자 사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서 번호';

--○ 커멘트 데이터가 입력된 테이블의
--   컬럼 레벨 커멘트 데이터 확인(TBL_EMP 테이블 소속의 컬럼들만 조회)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    사원 번호
TBL_EMP	ENAME	    사원명
TBL_EMP	JOB	        직종
TBL_EMP	MGR	        관리자 사원번호
TBL_EMP	HIREDATE	입사일
TBL_EMP	SAL	        급여
TBL_EMP	COMM	    수당
TBL_EMP	DEPTNO	    부서 번호
*/


--■■■ 컬럼 구조의 추가 및 제거 ■■■--

SELECT *
FROM TBL_EMP;

--○ TBL_EMP 테이블에 주민번호 데이터를 담을 수 있는 컬럼 추가
--   구조적 변경이기에 ALTER 사용
--   테이블에 추가할 수 있는 건 제약조건이나 컬럼이다
ALTER TABLE TBL_EMP
ADD SSN 데이터타입;

ALTER TABLE TBL_EMP
ADD SSN CHAR(13);   -- 주민번호(13자리)처럼 길이가 고정된 데이터는 VARCHAR 보단 CHAR
--==>> Table TBL_EMP이(가) 변경되었습니다.

SELECT '01012345678'
FROM DUAL;
--==>> 01012345678

SELECT 01012345678
FROM DUAL;
--==>> 1012345678
-- 숫자 타입이라 맨앞의 0이 없어짐

--○ SSN 컬럼 추가 확인
SELECT *
FROM TBL_EMP;
--> SSN(주민 번호) 컬럼이 정상적으로 추가되었음을 확인

DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
SSN         CHAR(13) 

--> SSN(주민번호) 컬럼이 정상적으로 포함(추가)된 사항을 확인
*/

--※ 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음
SELECT ENAME, SSN, EMPNO
FROM TBL_EMP;
-- 이렇게 원하는 대로 뽑을 수 있기 때문


--○ TBL_EMP 테이블에 추가한 SSN(주민번호) 컬럼 제거
--   컬럼에 입장에선 DROP(제거) 이지만, 테이블의 입장에선 ALTER(구조적 변경) 이다
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP이(가) 변경되었습니다.

--○ SSN 컬럼 제거 확인
DESC TBL_EMP;
--> SSN(주민 번호) 컬럼이 정상적으로 삭제되었음을 확인


SELECT *
FROM TBL_EMP;

DELETE TBL_EMP;
--==>> 14개 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--> 테이블의 구조(뼈대, 틀)는 그대로 남아있는 상태에서
--  데이터만 모두 소실(삭제)된 상황임을 확인
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 에러 발생
--     ORA-00942: table or view does not exist
--> 테이블 자체가 구조적으로 제거된 상황



--○ 테이블 다시 복사(생성)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.


--○ NULL 의 처리
SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	12	8	20	5

SELECT NULL
FROM DUAL;
--==>> (null)

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2
FROM DUAL;
--==>> (null)   (null)  (null)  (null)  (null)

--※ 관찰의 결과
--   NULL 은 상태의 값을 의미하며... 실제 존재하지 않는 값이기 때문에
--   이 NULL 이 연산에 포함될 경우
--   그 결과는 무조건 NULL 이다


--○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 인 직원의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다
SELECT *
FROM TBL_EMP;

SELECT 사원명, 직종명, 급여, 커미션
FROM TBL_EMP
WHERE 커미션(COMM, 수당)이 NULL 인 직원

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM이 NULL;

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> 에러발생

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = NULL;
--==>> 조회 결과 없음

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
7369	CLERK	     800	
7566	MANAGER	    2975	
7698	MANAGER	    2850	
7782	MANAGER	    2450	
7788	ANALYST	    3000	
7839	PRESIDENT	5000	
7876	CLERK	    1100	
7900	CLERK	     950	
7902	ANALYST	    3000	
7934	CLERK	    1300	
*/


--※ NULL 은 실제 존재하는 값이 아니기 때문에
--   일반적인 연산자를 활용하여 비교할 수 없다
--   NULL 을 대상으로 사용할 수 없는 연산자들
--   >=, <=, =, >, <, !=, <>, ^=


--○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 직원들의
--   사원명, 직종명, 부서번호 항목 조회
DESC TBL_EMP;

SELECT *
FROM TBL_EMP;

SELECT 사원명, 직종명, 부서번호
FORM TBL_EMP
WHERE 20번 부서에 근무하지 않는 직원들

SELECT ENAME, JOB, DEPTNO
FROM TBL_EMP
WHERE DEPTNO가 20이 아닌;

SELECT ENAME, JOB, DEPTNO
FROM TBL_EMP
WHERE DEPTNO != 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	    30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/


--○ TBL_EMP 테이블에서 커미션이 NULL 이 아닌 직원들의
--   사원명, 직종명, 급여, 커미션 항목을 조회

SELECT *
FROM TBL_EMP;

SELECT 사원명, 직종명, 급여, 커미션
FROM TBL_EMP
WHERE 커미션이 NULL 이 아닌 직원들;

SELECT 사원명, 직종명, 급여, 커미션
FROM TBL_EMP
WHERE COMM이 NULL 이 아닌 직원들;

SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE COMM IS NOT NULL;

SELECT ENAME "사원명", JOB "직종명", SAL "급여", COMM "커미션"
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

--○ TBL_EMP 테이블에서 모든 사원들의
--   사원번호, 사원명, 급여, 커미션, 연봉 항목 조회
--   단, 급여(SAL)는 매월 지급한다
--   또한, 수당(COMM)은 연 1회 지급하며, 연봉 내역에 포함된다

SELECT *
FROM TBL_EMP;

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "수당", (SAL * 12) + COMM "연봉" 
FROM TBL_EMP;
--==>> 커미션이 없는 경우 연봉도 같이 NULL 이 나옴

SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "수당", (SAL * 12) "연봉" 
FROM TBL_EMP;
--==>> 커미션을 빼면 연봉에 커미션이 더해지지 않는 값만 나옴


--○ NVL() - 오라클의 널을 처리해줄 수 있는 함수
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) "COL3"
FROM DUAL;
--==>> (null)  10   5
-- 첫 번째 파라미터 값이 NULL 이면, 두 번째 파라미터 값을 반환한다.
-- 첫 번째 파라미터 값이 NULL 이 아니면, 그 값을 그대로 반환한다.

SELECT ENAME "사원명", NVL(COMM, 0) "수당"
FROM TBL_EMP;

-- A
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", NVL(COMM, 0) "커미션", (SAL * 12) "연봉" 
FROM TBL_EMP;
--==>>
/*
20	SMITH	800	    0	    9600
30	ALLEN	1600	300	    19200
30	WARD	1250	500	    15000
20	JONES	2975	0	    35700
30	MARTIN	1250	1400	15000
30	BLAKE	2850	0	    34200
10	CLARK	2450	0	    29400
20	SCOTT	3000	0	    36000
10	KING	5000	0	    60000
30	TURNER	1500	0	    18000
20	ADAMS	1100	0	    13200
30	JAMES	950	    0	    11400
20	FORD	3000	0	    36000
10	MILLER	1300	0	    15600
*/

-- B
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", (SAL * 12) + NVL(COMM, 0) "연봉" 
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600
*/

--○ NVL2()
-- 첫 번째 파라미터 값이 NULL 이 아닌 경우, 두 번째 파라미터 값을 반환한다.
-- 첫 번째 파라미터 값이 NULL 인 경우, 세 번째 파라미터 값을 반환한다.
SELECT ENAME '사원명', NVL2(COMM, '청기올려', '백기올려') "수당확인"
FROM TBL_EMP;

-- C
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", NVL2(COMM, SAL * 12 + COMM, SAL * 12) "연봉"
FROM TBL_EMP;

-- D
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", SAL * 12 + NVL2(COMM, COMM, 0) "연봉"
FROM TBL_EMP;


--○ COALESCE()
--> 매개변수 제한이 없는 형태로 인지하고 활용한다
--  맨 앞에 있는 매개변수부터 차레로 NULL 인지 아닌지 확인하여
--  NULL 인 경우에는 그 다음 매개변수의 값을 반환한다
--  NVL() 이나 NVL2() 와 비교하여
--  모든 경우의 수를 고려할 수 있다는 특징을 갖는다

SELECT NULL "COL1"
     , COALESCE(NULL, NULL, NULL, 40) "COL2"
     , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "COL3"
     , COALESCE(NULL, NULL, 30, NULL, 60) "COL4"
     , COALESCE(10, NULL, NULL, NULL, 60) "COL5"
FROM DUAL;
--==>> (null) 40 100 30 10


--○ 실습을 위한 데이터 추가 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '영주니', 'SALESMAN', 7369, SYSDATE, 10);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8001, '나유니', 'SALESMAN', 7369, SYSDATE, 10, 10);
--==> 1 행 이(가) 삽입되었습니다.

COMMIT;
--==> 커밋 완료.

-- 데이터 추가 확인
SELECT *
FROM TBL_EMP;



--○ 급여만 NULL인 사원과 급여, 수당 둘 다 NULL 인 사원이 추가 되었을 때
--   COALESCE() 를 활용하여 연봉을 조회한다
--   TIP. 널이 뜰 확률이 높은 연산 순서대로 COALESCE 파라미터에 순서대로 넣어봤다
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "수당" 
    , COALESCE(SAL * 12 + COMM, SAL * 12, COMM, 0) "연봉"
FROM TBL_EMP;

SELECT EMPNO "사원번호", ENAME "사원명", NVL(SAL, 0) "급여", NVL(COMM, 0) "커미션"
    , COALESCE(SAL * 12 + COMM, SAL * 12, COMM, 0) "연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600
8000	영주니			        0
8001	나유니		    10	    10
*/


--○ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 컬럼과 컬럼의 연결(결합)
SELECT 1, 2
FROM DUAL;

SELECT 1 + 2
FROM DUAL;

SELECT '영과니', '보영이'
FROM DUAL;
--==>> 영과니	보영이
-- 두 개의 컬럼에 나눠 나옴

SELECT '영과니' + '보영이'
FROM DUAL;
--==>> 에러 발생
--     ORA-01722: invalid number


SELECT '영과니' || '보영이'
FROM DUAL;
--==>> 영과니보영이
-- 한 개의 컬럼에 나옴
-- 문자열과 문자열을 한 번에 나오게 하기 위해선 ||(파이프)를 사용하라

SELECT ENAME, JOB
FROM TBL_EMP;

SELECT ENAME || JOB
FROM TBL_EMP;
--==>>
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
영주니SALEMAN
나유니SALEMAN
*/

SELECT '동현이는', SYSDATE, '에 연봉', 500, '억을 원한다.'
FROM DUAL;
--==>> 동현이는	2022-08-12 04:03:14	에 연봉	      500	  억을 원한다.
--     -------- ------------------- -------       ---     ------------
--     문자타입      날짜타입       문자타입   숫자타입   문자타입

--○ 현재 날짜 및 시간을 반환하는 함수
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==>> 2022-08-12 04:05:19	 2022-08-12 04:05:19	  22/08/12 16:05:19.000000000


SELECT '동현이는' || SYSDATE || '에 연봉' || 500 || '억을 원한다.'
FROM DUAL;
--==>> 동현이는2022-08-12 04:06:16에 연봉500억을 원한다.
-- 한 컬럼에 한 번에 나온다

--※ 오라클에서는 문자 타입의 형태로 형 변환하는 별도의 과정 없이
--   || 만 삽입해 주면 간단히 컬럼과 컬럼(서로 다른 종류의 데이터)을
--   결합하는 것이 가능하다
--   cf) MSSQL 에서는 모든 데이터를 문자열로 CONVERT 해야 한다


--○ TBL_EMP 테이블의 데이터를 활용하여
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다
--   SMITH의 현재 연봉은 9600인데 희망 연봉은 19200 이다
--   ALLEN의 현재 연봉은 19500인데 희망 연봉은 39000 이다
--                  :
--                  :
--   나유니의 현재 연봉은 10인데 희망 연봉은 20이다
--   단, 레코드마다 위와 같은 내용이 한 컬럼에 모두 조회될 수 있도록 처리

-- 팁. 희망 연봉이 현재 연봉의 2배
SELECT ENAME || '의 현재 연봉은 ' 
    || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) 
    || ' 인데 희망 연봉은 ' 
    || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) * 2 
    || ' 이다'
FROM TBL_EMP;
--==>>
/*
SMITH의  현재 연봉은  9600 인데 희망 연봉은  19200 이다
ALLEN의  현재 연봉은 19500 인데 희망 연봉은  39000 이다
WARD의   현재 연봉은 15500 인데 희망 연봉은  31000 이다
JONES의  현재 연봉은 35700 인데 희망 연봉은  71400 이다
MARTIN의 현재 연봉은 16400 인데 희망 연봉은  32800 이다
BLAKE의  현재 연봉은 34200 인데 희망 연봉은  68400 이다
CLARK의  현재 연봉은 29400 인데 희망 연봉은  58800 이다
SCOTT의  현재 연봉은 36000 인데 희망 연봉은  72000 이다
KING의   현재 연봉은 60000 인데 희망 연봉은 120000 이다
TURNER의 현재 연봉은 18000 인데 희망 연봉은  36000 이다
ADAMS의  현재 연봉은 13200 인데 희망 연봉은  26400 이다
JAMES의  현재 연봉은 11400 인데 희망 연봉은  22800 이다
FORD의   현재 연봉은 36000 인데 희망 연봉은  72000 이다
MILLER의 현재 연봉은 15600 인데 희망 연봉은  31200 이다
영주니의 현재 연봉은     0 인데 희망 연봉은      0 이다
나유니의 현재 연봉은    10 인데 희망 연봉은     20 이다
*/




--○ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--=>> Session이(가) 변경되었습니다.

--○ TBL_EMP 테이블의 데이터를 활용하여
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다
--   SMITH'S 입사일은 1980-12-17 이다. 그리고 급여는 800 이다.
--   ALLEN'S 입사일은 1981-02-20 이다. 그리고 급여는 1600 이다.
--                  :
--                  :
--   나유니'S 입사일은 2022-08-12 이다. 그리고 급여는 0 이다.
--   단, 레코드마다 위와 같은 내용이 한 컬럼에 모두 조회될 수 있도록 처리

/*
SELECT ENAME || ''s 입사일은 ' 
    || HIREDATE 
    || ' 이다. 그리고 급여는 ' 
    || NVL(SAL, 0)
    || ' 이다.'
FROM TBL_EMP;
--==>> 에러 발생
--     ORA-00923: FROM keyword not found where expected
--     '(어퍼스트로피)를 표현하려 하니 문자열 홑따옴표로 인식해서 에러가 발생
*/

--※ 문자열을 나타내는 홑따옴표 사이에서(시작과 끝)
--   홑따옴표 두 개가 홑따옴표 하나(어퍼스트로피)를 의미한다
--   홑따옴표 ' 하나는 문자열의 시작을 나타내고
--   홑따옴표 '' 두 개는 문자열 영역 안에서 어퍼스트로피를 나타내며
--   다시 등장하는 홑따옴표 ' 하나가
--   문자열 영역의 종료를 의미하게 되는 것이다
SELECT ENAME || '''s 입사일은 ' 
    || HIREDATE 
    || ' 이다. 그리고 급여는 ' 
    || NVL(SAL, 0)
    || ' 이다.'
FROM TBL_EMP;
--==>>
/*
SMITH's  입사일은 1980-12-17 이다. 그리고 급여는  800 이다.
ALLEN's  입사일은 1981-02-20 이다. 그리고 급여는 1600 이다.
WARD's   입사일은 1981-02-22 이다. 그리고 급여는 1250 이다.
JONES's  입사일은 1981-04-02 이다. 그리고 급여는 2975 이다.
MARTIN's 입사일은 1981-09-28 이다. 그리고 급여는 1250 이다.
BLAKE's  입사일은 1981-05-01 이다. 그리고 급여는 2850 이다.
CLARK's  입사일은 1981-06-09 이다. 그리고 급여는 2450 이다.
SCOTT's  입사일은 1987-07-13 이다. 그리고 급여는 3000 이다.
KING's   입사일은 1981-11-17 이다. 그리고 급여는 5000 이다.
TURNER's 입사일은 1981-09-08 이다. 그리고 급여는 1500 이다.
ADAMS's  입사일은 1987-07-13 이다. 그리고 급여는 1100 이다.
JAMES's  입사일은 1981-12-03 이다. 그리고 급여는  950 이다.
FORD's   입사일은 1981-12-03 이다. 그리고 급여는 3000 이다.
MILLER's 입사일은 1982-01-23 이다. 그리고 급여는 1300 이다.
영주니's 입사일은 2022-08-12 이다. 그리고 급여는    0 이다.
나유니's 입사일은 2022-08-12 이다. 그리고 급여는    0 이다.
*/

SELECT *
FROM TBL_EMP
WHERE JOB = 'SALESMAN';

SELECT *
FROM TBL_EMP
WHERE JOB = 'salesman';

--○ UPPER(), LOWER(), INITCAP()
SELECT 'oRaCLe' "COL1"
    , UPPER('oRaCLe') "COL2"
    , LOWER('oRaCLe') "COL3"
    , INITCAP('oRaCLe') "COL4"
FROM DUAL;
--==>> oRaCLe	ORACLE	oracle	Oracle
-- UPPER() 는 모두 대문자로 반환
-- LOWER() 는 모두 소문자로 반환
-- INITCAP() 은 첫 글자만 대문자로 하고 나머지는 모두 소문자로 변환하여 반환


--※ 실습을 위한 추가 데이터 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8002, '태미니', 'salesman', 7369, SYSDATE, 20, 100);
--==>> 1 행 이(가) 삽입되었습니다.

COMMIT;
--==>> 커밋 완료.

--○ TBL_EMP 테이블을 대상으로 검색값이 'sALeSmAN' 인 조건으로
--   영업사원(세일즈맨)의 사원번호, 사원명, 직종명을 조회
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB = UPPER('sALeSmAN');
-- 이 경우 위에서 추가한 '태미니'가 나오지 않는다

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALeSmAN');
-- JOB의 데이터를 모두 대문자로 바꾸고
-- 찾고자하는 검색 키워드를 대문자로 바꾸면
-- 직종이 대문자든 소문자든 뒤죽박죽이든 찾을 수 있다

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE LOWER(JOB) = LOWER('sALeSmAN');

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE INITCAP(JOB) = INITCAP('sALeSmAN');
--==>>
/*
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	영주니	SALESMAN
8001	나유니	SALESMAN
8002	태미니	salesman
*/


--○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 입사한 직원의
--   사원명, 직종명, 입사일 항목을 조회
SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 9월 28일 입사한 직원;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = 1981년 9월 28일;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
--==>> MARTIN	SALESMAN	1981-09-28
-- 엄밀히 말하면 틀린 구문
-- 우연찮게 찾아준 것 뿐임
-- 오라클은 형변환을 매번 해주지 않음

--○ TO_DATE()
--   (문자타입을 날짜 타입으로 바꿔줌)
-->  TO ~ () 함수는 무언갈 변환 해주겠다는 의미를 담고있음

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--               TO_DATE()를 통해 첫 번째 파라미터의 형태를 두 번째 파라미터 처럼 바꿔주겠다
--==>> MARTIN	SALESMAN	1981-09-28


--○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 이후(해당일 포함)
--   입사한 직원의 사원번호, 사원명, 입사일 항목을 조회한다.

SELECT 사원번호, 사원명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 9월 28일 이후로 입사한 직원;

SELECT EMPNO "사원번호", ENAME "사원명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD') 이후 입사한 직원;

SELECT EMPNO "사원번호", ENAME "사원명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
7654	MARTIN	1981-09-28
7788	SCOTT	1987-07-13
7839	KING	1981-11-17
7876	ADAMS	1987-07-13
7900	JAMES	1981-12-03
7902	FORD	1981-12-03
7934	MILLER	1982-01-23
8000	영주니	2022-08-12
8001	나유니	2022-08-12
8002	태미니	2022-08-12
*/


--※ 오라클에서는 날짜 데이터의 크기 비교가 가능하다
--   오라클에서는 날짜 데이터에 대한 크기 비교 시
--   과거보다 미래를 더 큰 값으로 간주한다

--○ TBL_EMP 테이블에서 입사일이 1981년 4월 2일 부터 
--   1981년 9월 28일 사이에 입사한 직원들의
--   사원명, 직종명, 입사일 항목을 조회한다. (해당일 포함)

SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 4월 2일 부터 
      1981년 9월 28일 사이에 입사한 직원들;
      
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = ('1981-04-02', 'YYYY-MM-DD') 부터 
                 ('1981-09-28', 'YYYY-MM-DD') 사이에 입사한 직원들;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') 
               <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> 에러 발생

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02' <= '1981-09-28', 'YYYY-MM-DD');
--==>> 에러 발생

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE TO_DATE('1981-04-02', 'YYYY-MM-DD') <= HIREDATE
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> 이렇게 해도 에러는 나지 않음

--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') 
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/



