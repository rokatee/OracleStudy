SELECT USER
FROM DUAL;

--○ 세개 이상의 테이블 조인(JOIN)

-- 형식 1.(SQL 1992 CODE)
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
  AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;

-- 형식 2. (SQL 1999 CODE )
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명1
        JOIN 테이블명3
        ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
        
-- [형식 2(SQL 1999 CODE)]

--SELECT A.컬럼명, B.컬럼명, C.컬럼명
--FROM A JOIN B
--ON A.컬럼명1 = B.컬럼명1
 --   JOIN C
 --   ON B.컬럼명2 = C.컬럼명2;
  
--○ HR 계정 소유의 테이블 또는 뷰 목록 조회
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/


--○ HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS 테이블을 대상으로
--   직원들의 데이터를
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME 항목으로 조회
--   ----------  ---------- ---------- ----------------
--   EMPLOYEES   EMPLOYEES  JOBS       DEPARTMENTS

-- 해답 
-- 아래 3개 테이블을 통해 관계 컬럼을 찾는다
SELECT *
FROM EMPLOYEES;
-- DEPARTMENT_ID    -- 관계 컬럼

SELECT *
FROM JOBS;
-- JOB_ID           -- 관계 컬럼

SELECT *
FROM DEPARTMENTS;

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID;
-- 106

SELECT COUNT(*)
FROM EMPLOYEES;
-- 107
-- 위에서 Kimberely 가 누락 됨

SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.EMPLOYEE_ID;
-- 107

SELECT E.FIRST_NAME, E.LAST_NAME
     , J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
ORDER BY E.EMPLOYEE_ID;


-- 내가 푼 방법
-- 형식 1.(SQL 1992 CODE)
SELECT E.FIRST_NAME, E.LAST_NAME
     , J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D
WHERE E.JOB_ID = J.JOB_ID
  AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
--  AND E.MANAGER_ID = D.MANAGER_ID;
ORDER BY E.EMPLOYEE_ID;

-- 형식 2. (SQL 1999 CODE )
SELECT E.FIRST_NAME, E.LAST_NAME
     , J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
        LEFT JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
--        AND E.MANAGER_ID = D.MANAGER_ID;
ORDER BY E.EMPLOYEE_ID;


--○ EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS 테이블을 대상으로
--   직원들의 데이터를 다음과 같이 조회한다
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME,  CITY,       COUNTRY_NAME, REGION_NAME
--   ----------  ---------- ---------- ----------------  -----       ------------- ------------
--   EMPLOYEES   EMPLOYEES  JOBS       DEPARTMENTS      LOCATIONS    COUNTRIES    REGIONS 
SELECT *
FROM EMPLOYEES;
-- DEPARTMENT_ID        -- 관계 컬럼

SELECT *
FROM JOBS;
-- JOB_ID               -- 관계 컬럼

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM LOCATIONS;
-- LOCATION_ID          -- 관계 컬럼

SELECT *
FROM COUNTRIES;
-- COUNTRY_ID           -- 관계 컬럼

SELECT *
FROM REGIONS;
-- REGION_ID            -- 관계 컬럼

SELECT COUNT(*)
FROM EMPLOYEES;
-- 107

-- 형식 2
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE
     , D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
         JOIN JOBS J 
         ON E.JOB_ID = J.JOB_ID
                LEFT JOIN LOCATIONS L 
                ON D.LOCATION_ID = L.LOCATION_ID
                     LEFT JOIN COUNTRIES C
                     ON L.COUNTRY_ID = C.COUNTRY_ID
                            LEFT JOIN REGIONS R
                            ON C.REGION_ID = R.REGION_ID
ORDER BY E.EMPLOYEE_ID;

-- 형식 1
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME 
     , L.CITY, C.COUNTRY_NAME, R.REGION_NAME     
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
   , LOCATIONS L, COUNTRIES C, REGIONS R
WHERE J.JOB_ID = E.JOB_ID
  AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+)
ORDER BY E.EMPLOYEE_ID;

-- 서브 쿼리
SELECT T.성, T.이름, T.직업, T.부서명 , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM
(
SELECT E.FIRST_NAME "성", E.LAST_NAME "이름" , J.JOB_TITLE "직업", D.DEPARTMENT_NAME "부서명", D.LOCATION_ID
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
         JOIN JOBS J 
         ON E.JOB_ID = J.JOB_ID
         )T LEFT JOIN LOCATIONS L  ON T.LOCATION_ID = L.LOCATION_ID
            LEFT JOIN COUNTRIES C  ON L.COUNTRY_ID = C.COUNTRY_ID
            LEFT JOIN REGIONS R    ON C.REGION_ID = R.REGION_ID;