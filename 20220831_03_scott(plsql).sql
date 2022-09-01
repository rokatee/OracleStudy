SELECT USER
FROM DUAL;
--==>> SCOTT

--○ TBL_INSA 테이블의 여러 명의 데이터 여러 개를 변수에 저장
--   (반복문 활용)
---해답 코드--------------------------------------------------------------------
SET SERVEROUTPUT ON;

DECLARE
    V_INSA  TBL_INSA%ROWTYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        --조회
        SELECT NAME, TEL, BUSEO
                INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;      -- 1001
        
        --출력
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' || V_INSA.TEL || ' - ' || V_INSA.BUSEO);
        
        --증감식
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 1060;
    END LOOP;
END;
--------------------------------------------------------------------------------


--■■■ FUNCTION(함수) ■■■--

--1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--   코드를 다시 사용할 수 있도록 캡슐화하는데 사용된다.
--   오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--   직접 스토어드 함수를 만들 수 있다. (→사용자 정의 함수)
--   이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--   저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.


--2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명
[( 
    매개변수명1 자료형
  , 매개변수명 2 자료형
)]
RETURN 데이터타입
IS
    --주요 변수 선언(지역 변수)
BEGIN
    --실행문;
    ...
    RETURN(값);
    
    [EXCEPTION]
        --예외 처리 구문;
END;
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터 타입을 RETURN 문에 선언해야 하고,
--   FUNCTION은 반드시 단일 값만 반환한다.

--○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민번호) → '771212-1022432' → 'YYYYMMDD-NNNNNNN' 

DESC TBL_INSA;
--==>> SSN → VARCHAR2(14)

--CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2(14) )
CREATE OR REPLACE FUNCTION FN_GENDER
( 
    V_SSN VARCHAR2              -- 매개변수 : 자릿수(길이) 지정 안함 : VARCHAR2(14) 아님
)
--RETURN VARCHAR2(24)
RETURN VARCHAR2                 -- 반환자료형 : 자릿수(길이) 지정 안함
IS
    -- 선언부(주요 변수 선언)
    V_RESULT    VARCHAR2(24);
BEGIN
    -- 실행부(연산 및 처리)
    
    -- 결과값 반환 CHECK~!!!
END;




CREATE OR REPLACE FUNCTION FN_GENDER
( 
    V_SSN VARCHAR2 
)
RETURN VARCHAR2
IS
    -- 선언부(주요 변수 선언)
    V_RESULT    VARCHAR2(24);
BEGIN
    -- 실행부(연산 및 처리)
    IF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
        THEN V_RESULT := '여자';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
        THEN V_RESULT := '남자';
    ELSE
        V_RESULT := '성별확인불가';
    END IF;
    
    -- 결과값 반환 CHECK~!!!
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.



--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 → (A, B)
--   A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다
-- 함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/
CREATE OR REPLACE FUNCTION FN_POW
( 
    A NUMBER
  , B NUMBER 
)
RETURN NUMBER
IS
    -- 선언부(주요 변수 선언)
    V_RESULT    NUMBER := 1;   -- 함수가 반환할 결과값
    V_NUM       NUMBER;        -- 무한루프 숫자
BEGIN
    -- 실행부(연산 및 처리)
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    RETURN V_RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.

-- 테스트
SELECT FN_POW(5, 3)
FROM DUAL;
--==>> 125

--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다
--   급여는 (기본급*12)+수당 기반으로 연산을 수행한다
--   함수명 : FN_PAY(기본급, 수당)
CREATE OR REPLACE FUNCTION FN_PAY
(
    V_BASICPAY NUMBER
  , V_SUDADNG  NUMBER
)
RETURN NUMBER
IS
    V_SALARY    NUMBER;
BEGIN
    V_SALARY := (NVL(V_BASICPAY, 0) * 12) + NVL(V_SUDADNG, 0);
    RETURN V_SALARY;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.

-- 테스트
SELECT NAME "이름", FN_PAY(BASICPAY, SUDANG) "기본급+수당"
FROM TBL_INSA;
--==>>
/*
홍길동	31520000
이순신	16040000
    :
김신애	10902000
*/


--○ TBL_INSA 테이블에서 입사일을 기준으로
--   현재까지의 근무년수를 반환하는 함수를 정의한다
--   단, 근무년수는 소수점 이하 한자리까지 계산한다
--   함수명 : FN_WORKYEAR(입사일)
DESC TBL_INSA;

SELECT NAME, IBSADATE
FROM TBL_INSA;

-- 내가 푼 방법
CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
    V_IBSADATE  DATE
)
RETURN NUMBER
IS
    V_TEMP    NUMBER; -- 소수점을 정리하기 전 근무년수를 담을 변수
    V_RESULT  NUMBER; -- 최종 근무년수를 담을 변수
BEGIN
    --근무년수 := 현재년도-입사년도
    --V_TEMP := SYSDATE - V_IBSADATE; -- 이렇게 해도 됨
    V_TEMP := TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) - TO_DATE(TO_CHAR(V_IBSADATE, 'YYYY-MM-DD'));
    V_RESULT := TRUNC((V_TEMP/365),1);
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

-- 해답 방법
--1
SELECT MONTHS_BETWEEN(SYSDATE, '2002-02-11')/12
FROM DUAL;

--2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '2002-02-11')/12) || '년' ||
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'), 12) ) || '개월'
FROM DUAL;

--3
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE) "근무기가"
FROM TBL_INSA;

--4
CREATE OR REPLACE FUNCTION FN_WORKYEAR
( 
    V_IBSADATE  DATE
)
RETURN VARCHAR2
IS
    V_RESULT  VARCHAR2(20);
BEGIN
--    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, V_IBSADATE)/12) || '년' ||
--                TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, V_IBSADATE), 12) )  || '개월';
    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, V_IBSADATE)/12, 1);                       
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.

-- 테스트
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
홍길동	23.9
이순신	21.7
이순애	23.5
    :
김신애	20.9
*/