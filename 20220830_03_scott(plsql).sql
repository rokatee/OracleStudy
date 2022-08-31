SELECT USER
FROM DUAL;
--==>> SCOTT


-- ■■■ PL/SQL ■■■ --

-- 1. PL/SQL (Procedual Language extension to SQL) 은
--    프로그래밍 언어의 특성을 가지는 SQL 의 확장이며, 
--    데이터 조작과 질의 문장은 PL/SQL 의 절차적 코드 안에 포함된다,
--    또한, PL/SQL 을 사용하려면 SQL로 할 수 없는 절차적 작업이 가능하다.
--    여기에서 '절차적' 이라는 단어가 가지는 의미는 
--    어떤 것이 어떤 과정을 거쳐 어떻게 완료되는지 
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다

-- 2. PL/SQL 은 절차적으로 표현하기 위해 
--    변수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤 할 수 있는 기능 등을 제공한다,

-- 3. PL/SQL 은 블럭 구조로 되어있으며
--    블럭은 선언/ 실행 / 예외처리 부분의 
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다

-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(DECLATATIONS)
BEGIN
    -- 실행문(STATEMENT)
    [EXCEPTION]
    -- 예외 처리문(EXCEPTION HANDLERS)
END;
*/

-- (엄밀히 따지면 예외처리문은 실행문에 포함되는 것)


-- 5. 변수 선언

/*
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값; ( := 이게 대입연산자이다 . 우측에 있는걸 좌측으로 )
    
BEGIN
    PL/SQL구문;
END;

*/

--※ DBMS_OUTPUT.PUT_LINE() 를 통해
--   화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON;

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    D1  NUMBER := 10;
    D2  VARCHAR2(30) := 'HELLO';
    D3  VARCHAR2(20) := 'Oracle';
BEGIN
    -- 실행부
    --System.out.println(D1);
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
-- PL/SQL 는 세미콜론이 여러 개 이므로 원하는 만큼 블록을 직접 잡아서(드래그) 실행(컴파일)해야 한다


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    V1  NUMBER := 10;
    V2  VARCHAR2(30) := 'HELLO';
    V3  VARCHAR2(30) := 'ORACLE';
BEGIN
    -- 실행부
    -- (연산 및 처리)
    V1 := V1 * 10;             -- 자바에서 V1 *= 10; 와 같은 구문
    V2 := V2 || ' 정미경';      -- 자바에서 V2 += ' 정미경'; 
    V3 := V3 || ' WORLD~!!!';   -- 자바에서 V3 += ' WORLD~!!!';
    
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>>
/*
100
HELLO 정미경
ORACLE WORLD~!!!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ IF 문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언언의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    IF 조건에서 처리한 결과가 TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사이의 문장을 수행하게 된다.

--2. 형식 및 구조
/*
-- ① 단독 IF
IF 조건
    THEN 처리문;
END IF;


-- ② IF와 ELSE가 엮여있는 상태 
IF 조건
    THEN 처리문;
ELSE 
    처리문;
END IF;


-- ③ 중첩문
IF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSE
    처리문;
END IF;
*/

SET SERVEROUTPUT ON;

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>>
/*
EXCELLENT


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/



DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>>
/*
GOOD


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문1;
    WHEN 값2 THEN 실행문2;
    ELSE 실행문3;
END CASE;
*/


--○ 외부 입력 처리

-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
--  '&외부변수명' 형태로 접근하게 된다

-- ex)
-- 남자1 여자2 입력하세요
-- 1
-- 남자입니다.

-- 남자1 여자2 입력하세요
-- 2
-- 여자입니다.

ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    -- 선언부 (주요 변수 선언)
    SEL     NUMBER := &NUM;
    RESULT  VARCHAR2(10) := '남자';
BEGIN
    -- 테스트
--    DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
--    DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자 입니다');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자 입니다');
        ELSE
            DBMS_OUTPUT.PUT_LINE('성별 확인 불가');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || ' 입니다');
END;
--==>> 1과 2 이외의 숫자 입력 시 에러 발생
--     ORA-06502: PL/SQL: numeric or value error: character string buffer too small
--     변수 선언 시 값을 너무 작게 넣어서 나온 에러
--     오라클 캐릭터셋에 따라 한글 한 글자에 3바이트로 인식 되는 경우가 있음
--     위에서 VARCHAR2(10)을 해줬기에 '확인불가'(12바이트) 라는 글자 크기가 맞지 않는 것임
--     VARCHAR(20)으로 바꾸면 에러 해결


-- ● 정수 2개를 외부로부터(사용자로부터) 입력받아
-- 이들의 덧셈 결과를 출력하는  PL/SQL 구문을 작성한다.

ACCEPT N1 PROMPT '첫 번째 정수 입력';
ACCEPT N2 PROMPT '두 번째 정수 입력';

DECLARE
    -- 선언문 (주요 변수 선언)
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
--    TOTAL   NUMBER;         -- 이렇게 해도 되긴 함(자동초기화?)
    TOTAL   NUMBER := 0;
BEGIN
    TOTAL := NUM1 + NUM2;
    
    -- 테스트 NUM1과 NUM2를 제대로 가져오는지 보기 위함
    DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1);
    DBMS_OUTPUT.PUT_LINE('NUM2 : ' || NUM2);
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;


-- ● 사용자로부터 입력받은 금액을 화폐 단위로 출력하는 프로그램을 작성한다.
--    단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4

힌트) TRUNC() 와 MOD() 사용

SELECT TRUNC(48.678, 2) "COL2"     -- 48.67    -- 두 번째 파라미터 : 소수점 이하 둘 째 자리까지 표현
FROM DUAL;

SELECT MOD(5, 2) "COL1"
FROM DUAL;  -- 5를 2로 나눈 나머지
*/

ACCEPT WON PROMPT '금액 입력';

DECLARE
    OHBACK  NUMBER := TRUNC(&WON/500);
    BACK    NUMBER := TRUNC(MOD(&WON, 500)/100);
    OHSIP   NUMBER := TRUNC(MOD(MOD(&WON, 500),100)/50);
    SIP     NUMBER := TRUNC(MOD(MOD(MOD(&WON, 500),100),50)/10);
    TOTAL   NUMBER := &WON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || TOTAL || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || OHBACK || ', 백원 ' || BACK || ', 오십원 ' || OHSIP || ', 십원 ' || SIP);
END;
--==>> 하고보니 선언부에 연산처리까지 다 해버렸네...
/*
입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원4, 오십원1, 십원4


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- 해답 풀이
ACCEPT INPUT PROMPT '금액 입력';

DECLARE
    --선언부 (주요 변수 선언)
    MONEY   NUMBER := &INPUT;       -- 연산을 위해 입력값을 담아둘 변수
    MONEY2  NUMBER := &INPUT;       -- 결과 출력을 위해 입력값을 담아둘 변수
                                    -- (MONEY 변수가 연산 과정에서 값이 변하기 때문에)
    M500    NUMBER;                 -- 500원 짜리 개수를 담아둘 변수
    M100    NUMBER;                 -- 100원 짜리 개수를 담아둘 변수
    M50     NUMBER;                 -- 50원 짜리 개수를 담아둘 변수
    M10     NUMBER;                 -- 10원 짜리 개수를 담아둘 변수    
BEGIN
    -- 연산 및 처리
    -- MONEY 를 500으로 나누어 몫을 취하고 나머지는 버린다 → 500원 개수
    M500 := TRUNC(MONEY / 500);

    -- MONEY 를 500으로 나누어 몫을 취하고 나머지는 버린다 → 500원 개수 확인 후 남은 금액
    -- 이 결과를 다시 MONEY 에 담아낸다
    MONEY := MOD(MONEY, 500);
    
    -- MONEY 를 100으로 나누어 몫을 취하고 나머지는 버린다 → 100원 개수
    M100 := TRUNC(MONEY / 100);

    -- MONEY 를 100으로 나누어 몫을 취하고 나머지는 버린다 → 100원 개수 확인 후 남은 금액
    -- 이 결과를 다시 MONEY 에 담아낸다
    MONEY := MOD(MONEY, 100);
    
    -- MONEY 를 100으로 나누어 몫을 취하고 나머지는 버린다 → 50원 개수
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY 를 50으로 나누어 몫을 취하고 나머지는 버린다 → 50원 개수 확인 후 남은 금액
    -- 이 결과를 다시 MONEY 에 담아낸다
    MONEY := MOD(MONEY, 50);
    
    -- MONEY 를 500으로 나누어 몫을 취하고 나머지는 버린다 → 10원 개수
    M10 := TRUNC(MONEY / 10);
    
    -- 결과 출력
    -- 취합된 결과(화폐 단위별 개수)를 형식에 맞게 최종 출력한다
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY2 || '원');     
    -- MONEY는 연산을 통해 줄여왔기에, 총금액 출력만을 위한 변수 MONEY2를 입력한다

    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || M500 || ', 백원 ' || M100 || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;