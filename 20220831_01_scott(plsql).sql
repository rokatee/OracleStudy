SELECT USER
FROM DUAL;
--==>> SCOTT;

    
-- ● 기본 반복문
-- LOOP ~ END LOOP;  (루프 시작했다 루프 끝났다)

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문           사이에 실행문 오게 된다. 반복을 해야되는 구문이다. 
    EXIT WHEN 조건;   -- 조건이 참인 경우 반복문을 빠져나간다. 
END LOOP;
*/

--○ 1부터 10까지의 수 출력(LOOP 문 활용)

DECLARE
    NUM NUMBER;
BEGIN
    NUM := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
    EXIT WHEN NUM >= 10;
    NUM := NUM + 1;
    END LOOP;
END;


--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 문장을 사용한다.
--    조건은 반복이 시작될 때 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP       -- 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;
*/

--○ 1부터 10까지의 수 출력(WHILE LOOP 문 활용)
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N <= 10 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『 시작 수』 에서 1씩 증가하여
--    『끝나는 수』 가 될 때 까지 반복 수행한다.
    
-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] LOOP 시작수 .. 끝냄수 LOOP
        -- 실행문;
END LOOP;
*/

--○ 1부터 10까지의 수 출력(FOR LOOP 문 활용)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;



--<구구단 3가지 반복문으로 출력하기>
-- ● 사용자로부터 임의의 단(구구단)을 입력받아
-- 해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
-- LOOP, WHILE LOOP, FOR LOOP 를 통해 해결한다.

/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2*1=2
2*2=4
:
:
2*9=18

*/

-- 1. LOOP 문
/*
LOOP
    -- 실행문           사이에 실행문 오게 된다. 반복을 해야되는 구문이다. 
    EXIT WHEN 조건;   -- 조건이 참인 경우 반복문을 빠져나간다. 
END LOOP;
*/

ACCEPT VAR PROMPT '단을 입력하세요';

DECLARE
    -- 주요 변수 선언
    -- (DAN * N = DAN*N;)
    DAN NUMBER;     -- 곱셈 앞 부분
    N   NUMBER;     -- 곱셈 뒷 부분
BEGIN
    DAN := &VAR;
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
        N := N + 1;
        EXIT WHEN N >= 10;
    END LOOP;
END;


-- 2. WHILE LOOP 문
/*
WHILE 조건 LOOP       -- 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;
*/

ACCEPT VAR PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    DAN := &VAR;
    N := 1;
    WHILE N <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
        N := N + 1;
    END LOOP;
END;

-- 3. FOR LOOP 문
/*
FOR 카운터 IN [REVERSE] LOOP 시작수 .. 끝냄수 LOOP
        -- 실행문;
END LOOP;
*/

ACCEPT VAR PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    DAN := &VAR;
    
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;


--○ 구구단 전체(2~9단)를 출력하는  PL/SQL 구문을 출력한다
--   단, 이중 반복문(반복문의 중첩) 구문을 활용한다
/*
실행 예)

==[2단]==
2 * 1 = 2
2 * 2 = 4
    :
    
==[9단]==
9 * 1 = 9
9 * 2 = 18
    :
9 * 9 = 81    
*/

-- 1. LOOP 문
/*
LOOP
    -- 실행문           사이에 실행문 오게 된다. 반복을 해야되는 구문이다. 
    EXIT WHEN 조건;   -- 조건이 참인 경우 반복문을 빠져나간다. 
END LOOP;
*/
DECLARE
-- 숫자 1자리를 저장할 수 있는 NUMBER형 변수 DAN, N를 선언
    DAN NUMBER := 2;
    N   NUMBER := 1;
BEGIN
    -- 외부 루프
    LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || DAN || '단 ]==');
        N := 1;
        
        -- 내부 루프
        LOOP
            DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || N || ' = ' || DAN * N);
            N := N + 1;
            EXIT WHEN N >= 10;
        END LOOP;    -- 내부 루프 종료
            
        DAN := DAN + 1;
        EXIT WHEN DAN >= 10;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;  -- 외부 루프 종료
END;



-- 2. WHILE LOOP 문
/*
WHILE 조건 LOOP       -- 조건이 참인 경우 반복 수행
    -- 실행문;
END LOOP;
*/
DECLARE
    DAN NUMBER := 2;
    N   NUMBER := 1;
BEGIN
    -- 외부 루프
    WHILE DAN <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || DAN || '단 ]==');
        N := 1;
        
        -- 내부 루프
        WHILE N <= 9 LOOP
            DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || N || ' = ' || DAN * N);
            N := N + 1;
        END LOOP;    -- 내부 루프 종료
            
        DAN := DAN + 1;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;  -- 외부 루프 종료
END;


-- 3. FOR LOOP 문
/*
FOR 카운터 IN [REVERSE] LOOP 시작수 .. 끝냄수 LOOP
        -- 실행문;
END LOOP;
*/
DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    -- 외부 루프
    FOR DAN IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || DAN || '단 ]==');
        
        -- 내부 루프
        FOR N IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || N || ' = ' || DAN * N);
        END LOOP; -- 내부 루프 종료
        
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP; -- 외부 루프 종료
END;