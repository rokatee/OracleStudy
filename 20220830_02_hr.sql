SELECT USER
FROM DUAL;
--==>> HR

--○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다
--   단, 부서명이 'IT' 인 직원들만 한정한다
--   (변경에 대한 결과 확인 후 ROLLBACK 수행한다)
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 부서번호 = 부서명이 'IT'인 부서의 부서번호;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 부서번호 = 60;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
Alexander	9000	60
Bruce	    6000	60
David	    4800	60
Valli	    4800	60
Diana	    4200	60
*/

UPDATE EMPLOYEES
SET SALARY = SALARY 를 10% 인상
WHERE 부서명이 'IT' 인 직원들;

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
/*
Alexander	9900	60
Bruce	    6600	60
David	    5280	60
Valli	    5280	60
Diana	    4620	60
*/

-- SALARY 10% 인상 확인 완료 했으니 롤백 수행
ROLLBACK;
--> 롤백 완료.


--○ EMPLOYEES 테이블에서 JOB_TITLE 이 Sales Manager 인 사원들의
--   SALARY 를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한해 적용할 수 있도록 처리한다
--   (변경에 대한 결과 확인 후 ROLLBACK 수행한다)
SELECT *
FROM EMPLOYEES;

SELECT *
FROM JOBS;

SELECT JOB_ID
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';

SELECT FIRST_NAME, JOB_ID, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--  AND HIRE_DATE < TO_DATE('2006', 'YYYY');
--==>>
/*
John	SA_MAN	14000	2004-10-01
Karen	SA_MAN	13500	2005-01-05
Alberto	SA_MAN	12000	2005-03-10

Gerald	SA_MAN	11000	2007-10-15
Eleni	SA_MAN	10500	2008-01-29
*/

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006; 
--  AND HIRE_DATE < TO_DATE('2006', 'YYYY');     
--==>> 3개 행 이(가) 업데이트되었습니다.

-- 확인
SELECT FIRST_NAME, JOB_ID, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--  AND HIRE_DATE < TO_DATE('2006', 'YYYY');
--==>>
/*
John	SA_MAN	20080	2004-10-01
Karen	SA_MAN	20080	2005-01-05
Alberto	SA_MAN	20080	2005-03-10
*/

-- 최고급여(MAX_SALARY)로 수정 확인 완료 했으니 롤백 수행
ROLLBACK;
--> 롤백 완료.


-- ○ EMPLOYEES 테이블에서 SALARY를
--    각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--    Finance → 10% 인상
--    Executive → 15% 인상
--    Accounting  → 20% 인상
--    (힌트. 다른 나머지 부서들 → SALARY)
--    변경에 대한 결과 확인 후 ROLLBACK
SELECT * 
FROM EMPLOYEES;

SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting');
--==>>
/*
90	Executive
100	Finance
110	Accounting
*/

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting') );
--==>>
/*
Steven	    24000	90
Neena	    17000	90
Lex	        17000	90
Nancy	    12008	100
Daniel	    9000	100
John	    8200	100
Ismael	    7700	100
Jose Manuel	7800	100
Luis	    6900	100
Shelley	    12008	110
William	    8300	110
*/

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finance'의 부서 아이디)
                                THEN (SALARY * 1.1)
                                WHEN ('Executive'의 부서 아이디)
                                THEN (SALARY * 1.15)
                                WHEN ('Accounting'의 부서 아이디)
                                THEN (SALARY * 1.2)
                                ELSE SALARY
             END;
             


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance')
                                THEN (SALARY * 1.1)
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Executive')
                                THEN (SALARY * 1.15)
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Accounting')
                                THEN (SALARY * 1.2)
                                ELSE SALARY
             END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting') );
--==>> 11개 행 이(가) 업데이트되었습니다.
-- 데이터 업데이트만을 위한다면 마지막 WHERE 절은 필요가 없다
-- 이미 CASE문에서 업데이트를 해줬기 때문
-- 다만 마지막 WHERE 절이 있으면 11개 구문만 확인해 업데이트 하지만
-- 없으면 107개를 모두 확인해 11개를 찾아 업데이트를 하기 때문에
-- 결과 처리 속도가 다르다.

-- 확인
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting') );
--==>>
/*
Steven	    27600	90
Neena	    19550	90
Lex	        19550	90
Nancy	    13208.8	100
Daniel	    9900	100
John	    9020	100
Ismael	    8470	100
Jose Manuel	8580	100
Luis	    7590	100
Shelley	    14409.6	110
William	    9960	110
*/

-- 각 부서의 이름별로 다른 인상률을 적용 확인 완료 했으니 롤백 수행
ROLLBACK;
--> 롤백 완료.


--------------------------------------------------------------------------------

--■■■ DELETE ■■■--
-- 1. 테이블에서 지정된 행(레코드)을 삭제하는 데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

-- 테이블 복사(데이터 위주)

CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES이(가) 생성되었습니다.

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;

DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.
-- 바로 삭제하는 것이 아니라, 
-- 삭제하고자 하는 데이터가 맞는지 먼저 확인 후 삭제할 것

ROLLBACK;


--○ TBL_EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다
--   단, 부서명이 'IT' 인 경우로 한정한다
--※ 실제로는 TBL_EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
--   다른 레코드에 의해 참조당하고 있는 경우(어딘가에 자식 테이블이 있는 경우)
--   삭제되지 않을 수 있다는 사실을 염두해야 하며
--   그에 대한 이유도 알아야 한다

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT' 부서의 부서 아이디);

-- ('IT' 부서의 부서 아이디)
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60	IT

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	Ernst	BERNST	590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	Austin	DAUSTIN	590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	Lorentz	DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
-- 참조관계로 엮여있어 삭제 불가능


--------------------------------------------------------------------------------

--■■■ 뷰(VIEW) ■■■--

-- 1. 뷰(VIEW) 란 이미 특정한 데이터베이스 내에 존재하는 
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

--    가상의 테이블이란.. 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이며
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
--    CREATE [OR REPLACE ] VIEW 뷰이름
--    [(ALIAS[, ALIAS, ....])]
--    AS
--    서브쿼리(SUBQUERY)
--    [WITH CHECK OPTION]
--    [WITH READ ONLY];

-- ● 뷰 (VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.


--○ 뷰(VIEW) 조회
SELECT * 
FROM VIEW_EMPLOYEES;
--==>> 뷰를 사용하면 이렇게 간단하게 쿼리문을 작성할 수 있다


--○ 뷰(VIEW)의 구조 조회
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


--○ 뷰(VIEW) 소스 확인 -- CHECK~!!!
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>>
/*
VIEW_EMPLOYEES	
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID"
*/