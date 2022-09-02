SELECT USER
FROM DUAL;
--==>> SCOTT

--※ TBL_입고 테이블에 입고 이벤트 발생 시
--   관련 테이블에 수행되어야 하는 내용

-- ① INSERT → TBL_입고

-- ① UPDATE → TBL_상품

--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입력 이벤트 발생 시)
--   TBL_입고 테이블의 데이터 입력 뿐 아니라
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다
--   단, 이 과정에서 입고번호는 자동 증가 처리한다 (시퀀스 사용 X)
--   TBL_입고 테이블 구성 컬럼 - 구조
--    : 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)
DESC TBL_상품;

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
(
  --① 단계
  V_상품코드    IN TBL_입고.상품코드%TYPE
, V_입고수량    IN TBL_입고.입고수량%TYPE
, V_입고단가    IN TBL_입고.입고단가%TYPE
)
IS
    --③ 단계
    V_입고번호  TBL_입고.입고번호%TYPE;
BEGIN
    --④ 단계
    -- 입고번호 최대값 자동 입력
    --SELECT MAX(NVL(입고번호, 0)) + 1 INTO V_입고번호      -- 이건 왜 NULL처리가 안되는거지?
                                                            -- 20220901_02_scott.sql에서
                                                            -- "아래 두 개의 차이 유의" 문구 찾아 이유 확인
    SELECT NVL(MAX(입고번호), 0) + 1 INTO V_입고번호
    FROM TBL_입고;
    
    -- INSERT와 UPDATE는 동시에 이뤄지는 것이기에
    -- 먼저 작성되어야 하는 것은 없다
    -- TBL_입고 데이터 입력
    --② 단계
--    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
--    VALUES(????, V_상품코드, V_입고수량, V_입고단가);
    --⑤ 단계
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES(V_입고번호, V_상품코드, V_입고수량, V_입고단가);
    -- TBL_상품 업데이트
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑥ 단계
    -- 예외처리
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;   -- 둘 중 하나만 처리됐다면 ROLLBACK 해라
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


--------------------------------------------------------------------------------

--■■■ 프로시저 내에서의 예외 처리 ■■■--

--○ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저 작성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목 '서울', '경기', '대전' 만 입력이 가능하도록 구성한다
--   이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
--   (즉, 입력을 시도하는 경우)
--   예외에 대한 처리를 하려고 한다
--   프로시저 명 : PRC_MEMBER_INSERT()
/*
실행 예)
EXEC PRC_MEMBER_INSERT('임시연', '010-1111-1111', '서울');
--==>> 데이터 입력 O

EXEC PRC_MEMBER_INSERT('김보경', '010-2222-2222', '부산');
--==>> 데이터 입력 X
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
(
  --①
  V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    --③
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 추가 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    --⑦
    --사용자 정의 예외에 대한 변수 선언
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --⑥
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지
    -- 아닌지의 여부를 가장 먼저 확인할 수 있도록 코드 작성
--    IF(지역이 서울 경기 인천이 아니라면)
--        THEN 예외를 발생시키겠다.
--    END IF;
    --⑧
    IF(V_CITY NOT IN ('서울', '경기', '대전') )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --⑤
    -- INSERT 쿼리문을 수행하기에 앞서
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM), 0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    --②
    -- 쿼리문 작성 → INSERT 
--    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
--    VALUES(???, V_NAME, V_TEL, V_CITY);    
    --④
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(V_NUM, V_NAME, V_TEL, V_CITY);
    
    --⑨
    -- 예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울, 경기, 대전만 입력이 가능합니다');
            --                            ↑에러번호         ↑에러에 대한 내용 명시
            --                            ↑
            --                            ↑에러번호의 경우 매번 같은 번호를 부여해도 문법적으론 문제없지만
            --                              사용자에게 안내를 하기 위해 다른 에러마다 다른 번호를 부여해줘야 한다
            -- RAISE_APPLICATION_ERROR  --> 이건 고유 함수명 이다
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.



--------------------------------------------------------------------------------

--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고 수량이 변동되는 프로시저를 작성한다
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가 처리한다
--   또한, 출고 수량이 재고 수량보다 많은 경우
--   출고 액션 처리 자체를 취소할 수 있도록 처리한다 (출고가 이루어지지 않도록...)
--   프로시저 명 : PRC_출고_INSERT()
/*
실행 예)
EXEC PRC_출고_INSERT('H001', 50, 1000);
*/
DESC TBL_출고;
DESC TBL_상품;

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
(
  V_상품코드    IN TBL_출고.상품코드%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
, V_출고단가    IN TBL_출고.출고단가%TYPE
)
IS
    V_출고번호          TBL_출고.출고번호%TYPE;
    
    V_재고수량          TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 쿼리문 수행 이전에 수행 여부를 확인하는 과정에서
    -- 재고 파악 → 기존의 재고를 확인하는 과정이 선행되어야 한다
    -- 그래야 출고 수량과 비교가 가능하기 때문에
    SELECT 재고수량 INTO V_재고수량 
    FROM TBL_상품 
    WHERE 상품코드 = V_상품코드;
    
    -- 출고를 정상적으로 진행해줄 것인지에 대한 여부 확인
    -- 출고수량이 재고수량보다 많다면 예외 발생
    IF
      --(V_출고수량 > TBL_상품.재고수량) --> 이렇게 참조하는 형식으론 할 수 없다
        (V_출고수량 > V_재고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 출고번호 자동처리
    SELECT NVL(MAX(출고번호), 0) + 1 INTO V_출고번호
    FROM TBL_출고;
    
    -- 쿼리문 작성 → INSERT(TBL_출고)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES(V_출고번호, V_상품코드, V_출고수량, V_출고단가);
    -- 쿼리문 작성 → UPDATE(TBL_상품)    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고수량 부족');
                ROLLBACK;   -- 이미 IF문에서 예외처리를 함으로서
                            -- INSERT와 UPDATE이 작동되지 않기에
                            -- 롤백 해줄 일이 없어서 써주지 않아도 된다
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.




--● TBL_출고 테이블에서 출고 수량을 변경(수정)하는 프로시저를 작성한다.

-- 프로시저 명 : PRC_출고_UPDATE();

-- 만약 출고를 10개에서 5로 하면 재고수량이 10개라면 15개가 될 것이고 
-- 만약 출고를 10에서 30로 하려는데 재고가 10개이니까 안 될 것이고
-- 만약 출고를 10에서 12로 하려면 재고가 10에서 8개가 될 것이다.
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);

EXEC PRC_출고_UPDATE(1, 10);
*/
DESC TBL_출고;
DESC TBL_상품;

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
  V_출고번호        IN TBL_출고.출고번호%TYPE
, V_변경할수량      IN TBL_상품.재고수량%TYPE  -- 출고수량을 입력하는 수로 바꾼다
)
IS
    V_상품코드          TBL_상품.상품코드%TYPE;
    
    V_기존재고수량      TBL_상품.재고수량%TYPE;
    
    V_기존출고수량      TBL_출고.출고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    -- 어떤 상품을 내어놓을지 알아야한다
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- 변경 전 이미있는 재고수량 알아내기
    SELECT 재고수량 INTO V_기존재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 변경 전 이미 내어놓은 출고수량 알아내기
    SELECT 출고수량 INTO V_기존출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- (변경할출고량)
    -- 변경할수량 = 기존출고수량+a
    -- 변경할수량이 기존출고수량과 기조재고량을 합한 값보다 크면 에러발생
    IF
       ( V_변경할수량 > (V_기존출고수량 + V_기존재고수량) )
            THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --쿼리문 작성 → UPDATE(TBL_출고)
    UPDATE TBL_출고
    SET 출고수량 = V_변경할수량
    WHERE 출고번호 = V_출고번호;
    --쿼리문 작성 → UPDATE(TBL_출고)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + (V_기존출고수량 - V_변경할수량)
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고수량 부족');
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.



-- 해답풀이
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
    --① 매개변수 구성
  V_출고번호    IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    --③ 필요한 변수 추가 선언
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_이전출고수량    TBL_출고.출고수량%TYPE;
    V_현재재고수량    TBL_상품.재고수량%TYPE;
    
    --⑦ 예외변수 추가
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 선언한 변수에 값 담아내기
    --④ 상품코드와 이전출고수량 파악
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --⑤ 위에서 얻어낸 상품코드를 활용하여 재고수량 파악
    SELECT 재고수량 INTO V_현재재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑥ 출고 정상 수행 여부 판단 필요
    --   변경 이전의 출고수량 및 현재의 재고수량 확인
--    IF (파악한 현재 재고수량과 이전의 출고수량을 합친 값이 현재의 출고수량보다 적으면)
--        예외 발생
--    END IF;
    IF ( (V_현재재고수량 + V_이전출고수량) < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    --② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    --⑧
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
   --  현재 재고수량 = 현재재고수량 + 기존출고수량 - 변경할출고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑩ 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고수량 부족');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --⑨ 커밋
    COMMIT;

END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------
--과제
/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
    입고된 수량 변경 (원래대로라면 입고번호 이후에 출고된 것들을 다 고려해야 함)

실행 예)
EXEC PRC_입고_UPDATE(입고번호, 입고수량);

EXEC PRC_입고_UPDATE(1, 10);
*/
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
(
)
IS
BEGIN

    --커밋
    --COMMIT;
END;



/*
2. PRC_입고_DELETE(입고번호)
    입고번호의 입고수량이 지워진 만큼 상품에서 감소, 재고가 출고 이전의 상태로 돌아감

실행 예)
EXEC PRC_입고_DELETE(입고번호);

EXEC PRC_입고_DELETE(1);
*/
DESC TBL_입고;
/*
입고번호 NOT NULL NUMBER       
상품코드          VARCHAR2(20) 
입고일자          DATE         
입고수량          NUMBER       
입고단가          NUMBER     
*/
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(
  --① 매개변수 구성
  V_입고번호    IN TBL_입고.입고번호%TYPE
)
IS
    --③ 필요한 변수 추가 선언
    V_입고수량  TBL_입고.입고수량%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_상품코드  TBL_상품.상품코드%TYPE;
    
    --⑤ 예외처리
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 선언한 변수에 값 담아내기
    --④ 입고수량과 상품코드 파악
    SELECT 입고수량, 상품코드 INTO V_입고수량, V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- 재고수량 파악
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑥ 에러 발생
    -- 삭제할 입고수량이 재고수량보다 크면 재고수량이 음수가 되므로 예외처리
--    IF (입고100개 → 재고100개, 이때 출고50개 → 재고100-50=50개, 이때 입고 -100개 하면 → 이미 재고50 이므로 50개가 부족해 입고 삭제 X)
--        (재고수량 - 삭제하려는 입고량 < 0)  --> 입고가 여러번 되어 재고가 쌓여 있으면 이것도 틀린식인듯;;
--            THEN 에러발생;
--    END IF;
    IF (V_재고수량 - V_입고수량 < 0)
            THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    10 - 11
    
    --② 수행될 쿼리문 체크(DELETE → TBL_입고)
    DELETE
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    --④ 수행될 쿼리문 체크(UPDATE → TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑧ 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '입고내역 삭제 불가능');
        WHEN OTHERS
            THEN ROLLBACK;
    
    --⑦ 커밋
--    COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.


/*
3. PRC_출고_DELETE(출고번호)
    삭제된 출고수량만큼 재고수량에 대입

실행 예)
EXEC PRC_출고_DELETE(출고번호);

EXEC PRC_출고_DELETE(1);
*/
DESC TBL_출고;
/*
출고번호 NOT NULL NUMBER       
상품코드          VARCHAR2(20) 
출고일자          DATE         
출고수량          NUMBER       
출고단가          NUMBER 
*/
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(
  --① 매개변수 구성
  V_출고번호    IN TBL_출고.출고번호%TYPE
)
IS
    --③ 필요한 변수 추가 선언
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_출고수량  TBL_출고.출고수량%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    
BEGIN
    -- 선언한 변수에 값 담아내기
    --④ 출고수량과 상품코드 파악
    SELECT 출고수량, 상품코드 INTO V_출고수량, V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --② 수행될 쿼리문 체크(DELETE → TBL_출고)
    -- 출고수량을 지워줌
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --⑤ 수행될 쿼리문 체크(UPDATE → TBL_상품)
    -- 지워진 출고수량만큼 재고수량에 넣어줌
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.



--------------------------------------------------------------------------------
--■■■ CURSOR(커서) ■■■--

-- 1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 데이터를
--    저장하기 위해 커서(CURSOR)를 사용하며,
--    커서에는 암시적인 커서와 명시적인 커서가 있다

-- 2. 암시적 커서는 모든 SQL 문에 존재하며
--    SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다

--○ 커서 이용 전 상황(단일 행 접근 시)
SET SERVEROUTPUT ON;

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
       
END;
--==>> 홍길동 -- 011-2356-4528


--○ 커서 이용 전 상황(다중 행 접근 시)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
       
END;
--==>> 에러 발생
--> ORA-01422: exact fetch returns more than requested number of rows


--○ 커서 이용 전 상황(다중 행 접근 시 - 반복문 활용)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1062;
    END LOOP;   
END;
--==>> 
/*
조현하 -- 010-7202-6306
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
    :
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 커서 이용 후 상황
DECLARE
    -- 선언부
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;

    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
BEGIN
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 오픈 시 쏟아져 나오는 데이터들 처리
    LOOP
        -- 한 행 한 행 받아다가 처리하는 행위 → fetch
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태
        -- 즉, 커서 내부에서 더 이상의 데이터를 찾을 수 없는 상태
        -- → 그만~!! 반복문 빠져나가기
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
        -- 출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
    END LOOP;
    
    --커서 클로즈
    CLOSE CUR_INSA_SELECT;
    
END;
--==>>
/*
조현하 -- 010-7202-6306
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
    :
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
