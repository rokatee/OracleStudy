SELECT USER
FROM DUAL;
--==>> HR

-- ● %TYPE (퍼센트타입)

-- 1. 특정 테이블에 포함되어 있는 컬럼의 자료형(데이터 타입)을 참조하는 데이터타입

-- 2. 형식 및 구조
-- 변수명 데이터타입 → 원래는 이렇게 하지만
-- 변수명 테이블.컬럼명%TYPE [:=초기값];

-- 예를 들어 NAME EMPLOYEES.ENAME%TYPE(NAME 이라는 변수명의 타입을 EMPLOYEES
-- 테이블의 ENAME컬럼의 타입을 가져와서 쓰겠다는 의미)

SET SERVEROUTPUT ON;

--○ HR.EMPLOYEES 테이블의 특정 데이터를 변수에 저장
DESC EMPLOYEES;

SELECT *
FROM EMPLOYEES;

-- 이름(FIRST_NAME) 컬럼 확인 → VARCHAR2(20)

DECLARE
    -- V_NAME  VARCHAR(20);  
    --> 이러면 개발자가 직접 데이터타입을 알아봐야 하는 번거로움이 있음
    V_NAME EMPLOYEES.FIRST_NAME%TYPE;   
    --> EMPLOYEES에 있는 FIRST_NAME의 데이터타입을 오라클에게 확인시켜 쓰도록 하는 구문
BEGIN
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;

    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>>
/*
Alexander


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

--○ EMPLOYEES 테이블을 대상으로 108번 사원(NANCY)의
--   SALARY 를 변수에 담아 출력하는 PL/SQL 구문을 작성한다

DECLARE
    V_NAME      EMPLOYEES.FIRST_NAME%TYPE; 
    V_SALARY    EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME, SALARY INTO V_NAME ,V_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 108;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_SALARY);
END;
--==>>
/*
Nancy, 12008


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ EMPLOYEES 테이블의 특정 레코드 항목 여러 개를 변수에 저장
--   103번 사원의 FIRST_NAME, PHONE_NUMBER, EMAIL 항목을 변수에 저장하여 출력
DECLARE
    V_NAME   EMPLOYEES.FIRST_NAME%TYPE;
    V_PHONE  EMPLOYEES.PHONE_NUMBER%TYPE;
    V_EMAIL  EMPLOYEES.EMAIL%TYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL INTO V_NAME, V_PHONE, V_EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_PHONE ||', '|| V_EMAIL);
END;
--==>>
/*
Alexander, 590.423.4567, AHUNOLD


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ &ROWTYPE 

-- 1. 테이블의 레코드와 같은 구조의 구조체 변수를 선언(여러 개의 컬럼)

-- 2. 형식 및 구조
-- 변수명 테이블명%ROWTYPE;

DECLARE
    --V_NAME     VARCHAR(20);
    --V_PHONE    VARCHAR(20);
    --V_EMAIL    VARCHAR(25);
        
    --V_NAME   EMPLOYEES.FIRST_NAME%TYPE;
    --V_PHONE  EMPLOYEES.PHONE_NUMBER%TYPE;
    --V_EMAIL  EMPLOYEES.EMAIL%TYPE;
    
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
            INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
END;
--==>>
/*
Alexander, 590.423.4567, AHUNOLD


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ EMPLOYEES 테이블의 전체 레코드 항목 여러 개를 변수에 저장
--   모든 사원의 FIRST_NAME, PHONE_NUMBER, EMAIL 항목을 변수에 저장하여 출력

DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
            INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
END;
--==>> 에러발생
--      ORA-01422: exact fetch returns more than requested number of rows

--> 여러 개의 행(ROWS) 정보를 얻어와 담으려고 하여
-- 변수에 저장하는 것 자체가 불가능해진다.

--------------------------------------------------------------------------------
---나의 코드-------------------------------------------------------------------- 
-- 1. LOOP 문
/*
LOOP
    -- 실행문           사이에 실행문 오게 된다. 반복을 해야되는 구문이다. 
    EXIT WHEN 조건;   -- 조건이 참인 경우 반복문을 빠져나간다. 
END LOOP;
*/
DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
    V_NUM   EMPLOYEES.EMPLOYEE_ID%TYPE := 100;
BEGIN
    LOOP 
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
                INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM >= 206;
    END LOOP;
END;



-- 3. FOR LOOP 문
/*
FOR 카운터 IN [REVERSE] LOOP 시작수 .. 끝냄수 LOOP
        -- 실행문;
END LOOP;
*/
DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
    V_NUM   EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
    FOR V_NUM IN 100 .. 206 LOOP 
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
                INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
    END LOOP;
END;
--------------------------------------------------------------------------------
---동현이 코드------------------------------------------------------------------

DECLARE
    EMPNUM NUMBER;
    NUM NUMBER;
BEGIN
    SELECT COUNT(*) INTO EMPNUM
    FROM EMPLOYEES;
    
    FOR NUM IN 100..(99+EMPNUM) LOOP
        DECLARE
        EMP EMPLOYEES%ROWTYPE;
        
        BEGIN
            SELECT FIRST_NAME , PHONE_NUMBER, EMAIL
            INTO EMP.FIRST_NAME, EMP.PHONE_NUMBER, EMP.EMAIL
            FROM EMPLOYEES
            WHERE EMPLOYEE_ID = NUM;
        
            DBMS_OUTPUT.PUT_LINE(EMP.FIRST_NAME ||',   ' || EMP.PHONE_NUMBER|| ',     ' || EMP.EMAIL);
        END;
    END LOOP; 
END;
--------------------------------------------------------------------------------
---※ 위 문제에 대한 해답 코드는 20220831_03_scott(plsql).sql 에 있음-------------