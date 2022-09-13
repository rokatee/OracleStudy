SELECT USER
FROM DUAL;
--==>> LEVI

SET SERVEROUTPUT ON;

-- 오류 메시지 목록
/*
-20001, '데이터 중복'
-20002, '데이터 없음'
-20003, '유효하지 않은 데이터'
-20004, '총합 100점이 되어야 합니다'
-20005, '권한 없음'
-20006, '사용 중인 데이터' 
-20007, '수강신청 기간이 지났습니다'
-20008, '이미 배점이 부여된 과목입니다
*/

--DROP SEQUENCE TBL_CLASS_SEQ;
--
--CREATE SEQUENCE TBL_CLASS_SEQ
--NOCACHE;

--------------------------------------------------------------------------------
--과목
-------------------
-- PRC_CLASS_INSERT
SELECT *
FROM TBL_CLASS;

--EXEC PRC_CLASS_INSERT(CLASS_NAME);
EXEC PRC_CLASS_INSERT('Java');   -- 중복 데이터 테스트 
EXEC PRC_CLASS_INSERT('WOW');    -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_CLASS_INSERT
(
   V_CLASS_NAME    IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CLASS_CODE        TBL_CLASS.CLASS_CODE%TYPE;
    V_FLAT              NUMBER := 1;
    DUPLICATE_DATA      EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;
    
    IF (V_FLAT = 1)
        THEN RAISE DUPLICATE_DATA;
    END IF;

    INSERT INTO TBL_CLASS(CLASS_CODE, CLASS_NAME)
    VALUES(TBL_CLASS_SEQ.NEXTVAL, V_CLASS_NAME);
    
    EXCEPTION
        WHEN DUPLICATE_DATA
            THEN RAISE_APPLICATION_ERROR(-20001, '데이터 중복');

END;

--------------------
-- PRC_CLASS_UPDATE
SELECT *
FROM TBL_CLASS;

--EXEC PRC_CLASS_UPDATE(CLASS_CODE, CLASS_NAME);
EXEC PRC_CLASS_UPDATE(100, '없는데이터');   -- 없는데이터
EXEC PRC_CLASS_UPDATE(3, 'WWW');            -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_CLASS_UPDATE
(
    V_CLASS_CODE    IN TBL_CLASS.CLASS_CODE%TYPE
,   V_CLASS_NAME    IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_FLAT          NUMBER := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    UPDATE TBL_CLASS
    SET CLASS_NAME = V_CLASS_NAME
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');

END;

------------------
--PRC_CLASS_DELETE
SELECT *
FROM TBL_CLASS;

--EXEC PRC_CLASS_DELETE(CLASS_CODE);
EXEC PRC_CLASS_DELETE(100);   -- 없는데이터
EXEC PRC_CLASS_DELETE(3);     -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_CLASS_DELETE
(
    V_CLASS_CODE    IN TBL_CLASS.CLASS_CODE%TYPE
)
IS
    V_FLAT          NUMBER := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    DELETE 
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');

END;

--------------------------------------------------------------------------------
--교수
-----------------
--PRC_PRO_INSERT        --> 초기 비번을 주민번호 뒷자리로, 암호화도
SELECT *
FROM TBL_PROFESSOR;

--EXEC PRC_PRO_INSERT(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE, PRO_DATE);
EXEC PRC_PRO_INSERT('pro1', '교수5', '5555555', '555555-5555555', 'pro5@gmail.com', '010-5555-5555'); --교수 아이디 중복
EXEC PRC_PRO_INSERT('pro5', '교수1', '5555555', '555555-5555555', 'pro5@gmail.com', '010-5555-5555'); --교수명
EXEC PRC_PRO_INSERT('pro5', '교수5', '5555555', '901010-1234567', 'pro5@gmail.com', '010-5555-5555'); --교수 주민번호
EXEC PRC_PRO_INSERT('pro5', '교수5', '5555555', '555555-5555555', 'pro1@gmail.com', '010-5555-5555'); --교수 이메일
EXEC PRC_PRO_INSERT('pro5', '교수5', '5555555', '555555-5555555', 'pro5@gmail.com', '010-1234-5678'); --교수 폰번호
--> 중복 데이터 테스트 
EXEC PRC_PRO_INSERT('pro3', '교수3', '3334567', '921010-3334567', 'pro3@gmail.com', '010-3334-5678');    
EXEC PRC_PRO_INSERT('pro4', '교수4', '4444567', '931010-3334567', NULL, NULL);    
--> 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_PRO_INSERT
(
   V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
,  V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
,  V_PRO_PW      IN TBL_PROFESSOR.PRO_PW%TYPE
,  V_PRO_SSN     IN TBL_PROFESSOR.PRO_SSN%TYPE
,  V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
,  V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_FLAT              NUMBER;-- := 1;
    DUPLICATE_DATA      EXCEPTION;
BEGIN
    
    -- 중복 불허 : 교수 아이디, 교수명, 교수 주민번호, 교수 이메일, 교수 폰번호
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID
       OR PRO_NAME = V_PRO_NAME
       OR PRO_SSN = V_PRO_SSN
       OR PRO_EMAIL = V_PRO_EMAIL
       OR PRO_PHONE = V_PRO_PHONE;
    
    IF (V_FLAT = 1)
        THEN RAISE DUPLICATE_DATA;
    END IF;

    INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
    VALUES(V_PRO_ID, V_PRO_NAME, V_PRO_PW, V_PRO_SSN, V_PRO_EMAIL, V_PRO_PHONE);
    
    EXCEPTION
        WHEN DUPLICATE_DATA
            THEN RAISE_APPLICATION_ERROR(-20001, '데이터 중복');

END;

--------------------
-- PRC_PRO_UPDATE  --> 수정시 수정시간도 데이터에서 띄워야할까?
                   --> 원하는 값만 바꾸려면 어떻게? EX. 비번만 바꾸거나, 이메일만 바꾸거나
SELECT *
FROM TBL_PROFESSOR;

DESC TBL_PROFESSOR;

--EXEC PRC_PRO_UPDATE(PRO_ID, PRO_PW, PRO_EMAIL, PRO_PHONE);
EXEC PRC_PRO_UPDATE('pro100', '5555555', 'pro5@gmail.com', '010-5555-5555');   -- 없는데이터
EXEC PRC_PRO_UPDATE('pro3', '5555555', 'pro5@gmail.com', '010-5555-5555');     -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_PRO_UPDATE
(
   V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
,  V_PRO_PW      IN TBL_PROFESSOR.PRO_PW%TYPE
,  V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
,  V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_FLAT          NUMBER;-- := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    UPDATE TBL_PROFESSOR
    SET PRO_PW = V_PRO_PW
      , PRO_EMAIL = V_PRO_EMAIL
      , PRO_PHONE = V_PRO_PHONE
    WHERE PRO_ID = V_PRO_ID;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');

END;

------------------
--PRC_PRO_DELETE
SELECT *
FROM TBL_PROFESSOR;

--EXEC PRC_PRO_DELETE(PRO_ID);
EXEC PRC_PRO_DELETE('pro100');   -- 없는데이터
EXEC PRC_PRO_DELETE('pro3');     -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_PRO_DELETE
(
   V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
)
IS
    V_FLAT          NUMBER;-- := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    DELETE 
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;

    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');

END;

--------------------------------------------------------------------------------
--강의실


--------------------------------------------------------------------------------
--과정


--------------------------------------------------------------------------------
--교재
----------------------
-- PRC_TEXTBOOK_INSERT
SELECT *
FROM TBL_TEXTBOOK;

--EXEC PRC_TEXTBOOK_INSERT(BOOK_NAME, BOOK_PUB);
EXEC PRC_TEXTBOOK_INSERT('Java', '홍대');          -- 중복 데이터 테스트
EXEC PRC_TEXTBOOK_INSERT('DB', '쌍용');            -- 멀쩡한 데이터
EXEC PRC_TEXTBOOK_INSERT('JS', NULL);              -- 멀쩡한 데이터
EXEC PRC_TEXTBOOK_INSERT('교재 없음', NULL);       -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_INSERT
(
  V_BOOK_NAME   IN TBL_TEXTBOOK.BOOK_NAME%TYPE      -- 교재명
, V_BOOK_PUB    IN TBL_TEXTBOOK.BOOK_PUB%TYPE       -- 출판사
)
IS
    V_BOOK_CODE         TBL_TEXTBOOK.BOOK_CODE%TYPE;    -- 교재코드(시퀀스로 자동 입력)
    V_FLAT              NUMBER;                         -- 데이터 유무 판단 변수
    DUPLICATE_DATA      EXCEPTION;                      -- 중복 데이터 입력 시 오류문구 출력해주는 변수
BEGIN
    -- 같은 이름의 교재명이 있는 교재코드 값을 V_FLAT에 담기
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_NAME = V_BOOK_NAME;
    -- 있으면 '데이터 중복' 오류문구 출력
    IF (V_FLAT != 0)   
        THEN RAISE DUPLICATE_DATA;
    END IF;
    
    -- 인서트 구문
    INSERT INTO TBL_TEXTBOOK(BOOK_CODE, BOOK_NAME, BOOK_PUB)
    VALUES(TBL_TEXTBOOK_SEQ.NEXTVAL, V_BOOK_NAME, V_BOOK_PUB);
    
    -- 예외처리
    EXCEPTION
        WHEN DUPLICATE_DATA
            THEN RAISE_APPLICATION_ERROR(-20001, '데이터 중복');
--        WHEN OTHERS
--            THEN ROLLBACK;
--            
--    COMMIT;
    
END;

----------------------
-- PRC_TEXTBOOK_UPDATE    --> 원하는 값만 바꾸려면 어떻게? EX. 책이름만 바꾸거나, 출판사만 바꾸거나 
                          --  논의완료(JSP에서 처리하는 방식 채택)
                          --  보통 웹이사이트에서 정보수정을 할 때, 정보수정 버튼을 누르면
                          --  내가 가입시 기입했던 정보가 이미 DB에서 불려와 변경 가능한 정보란에 적혀있음
                          --  거기서 변경하고자하는 값만 수정하면
                          --  통상적으로 모든 값을 변경하는 방식으로 프로시저에서 변경됨
                          --  (변경하고 싶지 않은 값은 이미 기입된 값 그대로 프로시저로 넘어가기 때문에)
SELECT *
FROM TBL_TEXTBOOK;

--EXEC PRC_TEXTBOOK_UPDATE(BOOK_CODE, BOOK_NAME, BOOK_PUB);
EXEC PRC_TEXTBOOK_UPDATE(100, '없는 데이터', '없는 데이터');   -- 없는 데이터
EXEC PRC_TEXTBOOK_UPDATE(7, '알고리즘', '쌍용');               -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_UPDATE
(
  V_BOOK_CODE   IN TBL_TEXTBOOK.BOOK_CODE%TYPE  -- 교재코드
, V_BOOK_NAME   IN TBL_TEXTBOOK.BOOK_NAME%TYPE  -- 교재명
, V_BOOK_PUB    IN TBL_TEXTBOOK.BOOK_PUB%TYPE   -- 출판사
)
IS
    V_FLAT          NUMBER;         -- 데이터 유무 판단 변수
    NO_DATA_FOUND   EXCEPTION;      -- 데이터 없을 때 쓰는 오류변수
BEGIN
    -- 같은 교재코드 번호를 V_FLAT에 담기
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- 교재코드가 없으면 '데이터 없음' 오류문구 출력
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 업데이트 구문
    UPDATE TBL_TEXTBOOK
    SET BOOK_NAME = V_BOOK_NAME
      , BOOK_PUB = V_BOOK_PUB
    WHERE BOOK_CODE = V_BOOK_CODE;
    
    -- 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;

----------------------
--PRC_TEXTBOOK_DELETE
SELECT *
FROM TBL_TEXTBOOK;

--EXEC PRC_TEXTBOOK_DELETE(BOOK_CODE);
EXEC PRC_TEXTBOOK_DELETE(100);   -- 없는데이터
EXEC PRC_TEXTBOOK_DELETE(2);     -- 사용 중인 데이터 삭제
EXEC PRC_TEXTBOOK_DELETE(3);     -- 삭제 가능한 데이터 삭제

CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_DELETE
(
  V_BOOK_CODE   IN TBL_TEXTBOOK.BOOK_CODE%TYPE  -- 교재코드
)
IS
    V_FLAT            NUMBER;       -- 데이터 유무 판단 변수
    NO_DATA_FOUND     EXCEPTION;    -- 데이터 없을 때 쓰는 오류 변수
    USING_IN_OCLASS   EXCEPTION;    -- 개설과정에서 쓰고 있는 교재가 있을 때 쓰는 오류 변수
BEGIN
    -- 같은 교재코드 번호를 V_FLAT에 담기
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- 교재코드가 없으면 '데이터 없음' 오류문구 출력
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 개설과정에 있는 교재코드를 V_FLAT에 담기
    -- 이유? 교재코드가 사용 중인지 판단하기 위함
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- 있으면 '사용중인 교재' 오류문구 출력
    IF (V_FLAT != 0)
        THEN RAISE USING_IN_OCLASS;
    END IF;
    
    -- 딜리트 구문
    DELETE 
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    
    -- 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
        WHEN USING_IN_OCLASS
            THEN RAISE_APPLICATION_ERROR(-20009, '이미 개설 과목에서 사용 중인 교재입니다');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;

--------------------------------------------------------------------------------
--개설과정(강의실, 과정)
---------------------
-- PRC_OCOURSE_INSERT


---------------------
-- PRC_OCOURSE_UPDATE


---------------------
-- PRC_OCOURSE_DELETE


--------------------------------------------------------------------------------
--강의가능(과목, 교수)
-- PRC_ABLE_INSERT
SELECT *
FROM TBL_ABLE;

SELECT *
FROM TBL_PROFESSOR;

SELECT *
FROM TBL_CLASS;

-- EXEC PRC_ABLE_INSERT()
EXEC PRC_ABLE_INSERT(1, 'pro3');


CREATE OR REPLACE PROCEDURE PRC_ABLE_INSERT
( V_CLASS_CODE   IN TBL_ABLE.CLASS_CODE%TYPE 
, V_PRO_ID      IN  TBL_ABLE.PRO_ID%TYPE
)
IS
    V_ABLE_CODE     TBL_ABLE.ABLE_CODE%TYPE;
BEGIN

    INSERT INTO TBL_ABLE(ABLE_CODE, CLASS_CODE, PRO_ID)
    VALUES(TBL_ABLE_SEQ.NEXTVAL, V_CLASS_CODE, V_PRO_ID);
    
--    COMMIT;

END;
---------------------
-- PRC_ABLE_UPDATE


---------------------
-- PRC_ABLE_DELETE



--------------------------------------------------------------------------------
--개설과목[개설과정(강의실, 과정), 강의가능(과목, 교수)]
---------------------
-- PRC_OCLASS_INSERT --> 특정 날짜에 등록된 교수가 같은 기간에 등록되지 않게?
                     --> 과정기간보다 과목기간이 더 길어지게도 못하게 해야겠네

                      --> no data found 가 자꾸 뜨네 왜지? 
                      --  데이터입력이라 INSERT_DATE(개설일)가 없는데, 
                      --  시작일과 종료일을 INSERT_DATE(개설일)와 비교해서 그런거임
                      --  개설일 디폴트값이 SYSDATE이므로 
                      --  INSERT프로시저에선 시작일과 종료일을 SYSDATE와 비교하면 됨
                      
                      -- 이미 개설된 과목(중복된 강의 가능 여부 코드) --> 1번 강의는 못거름, 왜지? --> V_FLAT이 1일 때 입력
SELECT *
FROM TBL_OCLASS;
-- 1111, 2112, 3-1-

SELECT *
FROM TBL_ABLE;
--1~3

SELECT *
FROM TBL_OCOURSE;
--1
SELECT *
FROM TBL_TEXTBOOK;
--1~2

--EXEC PRC_OCLASS_INSERT(V_START_DATE, V_END_DATE, V_ABLE_CODE, V_OCOURSE_CODE, V_BOOK_CODE);
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> 개설과정보다 더 큰 범위의 개설과목 날짜 넣을 때
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-08-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> 개설일자보다 빠른 시작일
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-08-01', 'YYYY-MM-DD'), 2, 1, 1);   
--> 개설일자보다 빠른 종료일
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-11-01', 'YYYY-MM-DD'), 2, 1, 1);   
--> 시작일보다 빠른 종료일
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 3, 1, 100);   
--> 없는 교재 데이터
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 100, 1, 1);   
--> 강의 가능한 데이터가 없는 경우
220627, 230116
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD'), 3, 1, 5);   
--> 개설과목이 있는 A교수를 배정받은 날짜와 같은 날짜로 넣기
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2022-12-30', 'YYYY-MM-DD'), 3, 1, 5);   
--> 개설과목이 있는 A교수를 배정받은 날짜 사이의 날짜로 넣기
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-20', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
--> 개설과목이 있는 A교수를 배정받은 날짜를 덮는 더 큰 날짜로 넣기
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 2);   
--> 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_OCLASS_INSERT
(
    V_START_DATE    IN TBL_OCLASS.START_DATE%TYPE       -- 과목 시작일
,   V_END_DATE      IN TBL_OCLASS.END_DATE%TYPE         -- 과목 종료일
,   V_ABLE_CODE     IN TBL_OCLASS.ABLE_CODE%TYPE        -- 과목명과 교수를 엮은 강의가능여부 테이블 코드번호 (FK : TBL_ABLE)
,   V_OCOURSE_CODE  IN TBL_OCLASS.OCOURSE_CODE%TYPE     -- 개설과정 식별자 변수 (FK : TBL_OCOURSE)
,   V_BOOK_CODE     IN TBL_OCLASS.BOOK_CODE%TYPE        -- 교재 식별자 변수 (FK : TBL_TEXTBOOK)
)
IS
    V_OCLASS_CODE    TBL_OCLASS.OCLASS_CODE%TYPE;   -- 개설과목 식별자 변수 (PK)
    V_START_DATE1    TBL_OCOURSE.START_DATE%TYPE;   -- 개설과정의 개설일 (과정기간보다 과목 기간이 길어지게 하지 못하도록)
    V_END_DATE1      TBL_OCOURSE.END_DATE%TYPE;     -- 개설과정의 종료일 (과정기간보다 과목 기간이 길어지게 하지 못하도록)
    V_FLAT           NUMBER;                        -- 데이터 유무 판단 변수
    WRONG_DATE1      EXCEPTION;                     -- 개설과정보다 큰 범위의 날짜를 입력할 때 쓰는 오류 변수
    WRONG_DATE       EXCEPTION;                     -- 개설과목에서 날짜를 잘못 입력했을 때 쓰는 오류 변수
                                                    -- (EX. 시작일이 종료일보다 빠른)
    NO_PRO_FOUND     EXCEPTION;                     -- 배정하려는 교수코드 번호가 없을 때 쓰는 변수
    NO_BOOK_FOUND    EXCEPTION;                     -- 배정하려는 교재코드 번호가 없을 때 쓰는 변수
    OPENED_CLASS     EXCEPTION;                     -- 수강할 날짜가 지정된 교수가 해당 기간 동안 
                                                    -- 다른 과목을 수강하지 못하도록 하는 오류 변수
BEGIN
    -- 개설과정 테이블의 시작일, 종료일 값 불러오기
    --> 불러오는 이유? 과정보다 과목기간이 길어지게 못하도록 조건문을 만들기 위해
    --> OCOURSE_CODE를 TBL_OCOURSE에서 불러오니 NO DATA FOUND 오류 뜸, 값을 못 불러오는 듯 
    --> 그래서 걍 TBL_OCLASS의 OCOURSE_CODE를 사용함
    SELECT START_DATE, END_DATE INTO V_START_DATE1, V_END_DATE1
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    -- 과정 기간보다 과목 기간이 짧아지지 않도록
    IF( V_START_DATE < V_START_DATE1 OR V_END_DATE > V_END_DATE1 )
        THEN RAISE WRONG_DATE1;
    END IF;
    
    -- 개설일의 기본값이 SYSDATE인데, 
    -- 그보다 시작일이 빠르지 못하도록, 시작일보다 종료일이 빠르지 못하도록 
    IF (SYSDATE > V_START_DATE OR V_START_DATE > V_END_DATE)
        THEN RAISE WRONG_DATE;
    END IF;
    
    -- 같은 번호의 교재코드 값을 V_FLAT에 담기
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- 없으면 '교재 없음' 오류문구 출력
    IF (V_FLAT = 0)
        THEN RAISE NO_BOOK_FOUND;
    END IF;    
    
    -- 강의가능여부 코드의 유무 판단  
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    -- 없으면 '배정할 교수 없음' 오류문구 출력  
    IF (V_FLAT = 0)
        THEN RAISE NO_PRO_FOUND;
    END IF;
    
    -- 강의가능여부 코드 값 불러오기
    --> 불러오는 이유? 강의가능여부 코드가 사용 중인지 판단하기 위해
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE ABLE_CODE = V_ABLE_CODE
      AND V_START_DATE BETWEEN START_DATE AND END_DATE          -- 시작일이 기존날짜 사이에 못들어가게
      AND V_END_DATE BETWEEN START_DATE AND END_DATE            -- 종료일이 기존날짜 사이에 못들어가게
       OR V_START_DATE < START_DATE AND V_END_DATE > END_DATE;  -- 날짜가 기존날짜보다 더 큰 날짜로 덮지 못하게
    -- 있으면 '잘못된 기간 입력' 오류문구 출력  
    IF (V_FLAT != 0)
        THEN RAISE OPENED_CLASS;
    END IF;
    
    -- 인서트 구문  
    INSERT INTO TBL_OCLASS(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
    VALUES(TBL_OCLASS_SEQ.NEXTVAL, V_START_DATE, V_END_DATE, V_ABLE_CODE, V_OCOURSE_CODE, V_BOOK_CODE);
    
    -- 예외처리        
    EXCEPTION
        WHEN NO_BOOK_FOUND
            THEN RAISE_APPLICATION_ERROR(-20012, '배정할 교재가 없음');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20013, '배정할 교수가 없음');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20014, '이미 해당 교수가 해당 기간에 배정된 과목이 있습니다, 다른 교수를 배정해주세요.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20015, '개설된 과정보다 넓은 범위의 과목을 개설할 수 없습니다.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20015, '잘못된 날짜 입력.');
----        WHEN OTHERS
----            THEN ROLLBACK;
----    COMMIT;

END;

---------------------
-- PRC_OCLASS_UPDATE -->같은기간에 같은교수가 등록 안되도록하는 테스트구문

SELECT *
FROM TBL_OCLASS;

SELECT *
FROM TBL_ABLE;

SELECT *
FROM TBL_TEXTBOOK;

SELECT *
FROM TBL_POINT;

SELECT * 
FROM TBL_OCOURSE;

--EXEC PRC_OCLASS_UPDATE(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
EXEC PRC_OCLASS_UPDATE(100, TO_DATE('2022-06-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1, 1, 1);   
--> 없는 개설과목 데이터
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2021-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2021-12-25', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> 개설과정보다 더 큰 범위의 개설과목 날짜 넣을 때
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-08-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> 개설일자보다 빠른 시작일
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-08-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> 개설일자보다 빠른 종료일
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-11-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> 시작일보다 빠른 종료일
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1, 1, 1);   
--> 없는 교재 데이터
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1, 1, 1);   
--> 강의 가능한 데이터가 없는 경우
  
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
--> 개설과목이 있는 A교수를 배정받은 날짜와 같은 날짜로 넣기
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2022-12-30', 'YYYY-MM-DD'), 3, 1, 5);   
--> 개설과목이 있는 A교수를 배정받은 날짜 사이의 날짜로 넣기
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-20', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 3, 1, 5);   
--> 개설과목이 있는 A교수를 배정받은 날짜를 덮는 더 큰 날짜로 넣기
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-11', 'YYYY-MM-DD'), 3, 1, 5);   
--> 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_OCLASS_UPDATE
(
  V_OCLASS_CODE     IN TBL_OCLASS.OCLASS_CODE%TYPE      -- 개설과목 식별자 변수 (PK)
, V_START_DATE      IN TBL_OCLASS.START_DATE%TYPE       -- 과목 시작일
, V_END_DATE        IN TBL_OCLASS.END_DATE%TYPE         -- 과목 종료일
, V_ABLE_CODE       IN TBL_OCLASS.ABLE_CODE%TYPE        -- 과목명과 교수를 엮은 강의가능여부 테이블 코드번호 (FK : TBL_ABLE)
, V_OCOURSE_CODE    IN TBL_OCLASS.OCOURSE_CODE%TYPE     -- 개설과정 식별자 변수 (FK : TBL_OCOURSE)
, V_BOOK_CODE       IN TBL_OCLASS.BOOK_CODE%TYPE        -- 교재 식별자 변수 (FK : TBL_TEXTBOOK)
)
IS
    V_START_DATE1    TBL_OCOURSE.START_DATE%TYPE;   -- 개설과정의 개설일 (과정기간보다 과목 기간이 길어지게 하지 못하도록)
    V_END_DATE1      TBL_OCOURSE.END_DATE%TYPE;     -- 개설과정의 종료일 (과정기간보다 과목 기간이 길어지게 하지 못하도록)
    V_INSERT_DATE    TBL_OCLASS.INSERT_DATE%TYPE;   -- 개설일 변수
    V_FLAT           NUMBER;                        -- 데이터 유무 판단 변수
    NO_DATA_FOUND    EXCEPTION;                     -- 데이터 없을 때 쓰는 오류 변수
    WRONG_DATE1      EXCEPTION;                     -- 개설과정보다 큰 범위의 날짜를 입력할 때 쓰는 오류 변수
    WRONG_DATE       EXCEPTION;                     -- 개설과목에서 날짜를 잘못 입력했을 때 쓰는 오류 변수
                                                    -- (EX. 시작일이 종료일보다 빠른)
    NO_PRO_FOUND     EXCEPTION;                     -- 배정하려는 교수코드 번호가 없을 때 쓰는 변수
    NO_BOOK_FOUND    EXCEPTION;                     -- 배정하려는 교재코드 번호가 없을 때 쓰는 변수
    OPENED_CLASS     EXCEPTION;                     -- 수강할 날짜가 지정된 교수가 해당 기간 동안 
                                                    -- 다른 과목을 수강하지 못하도록 하는 오류 변수
BEGIN
    -- 개설과목 코드의 유무 판단
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- 없으면 '데이터 없음' 오류문구 출력
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 개설과정 테이블의 시작일, 종료일 값 불러오기
    --> 불러오는 이유? 과정보다 과목기간이 길어지게 못하도록 조건문을 만들기 위해
    --> OCOURSE_CODE를 TBL_OCOURSE에서 불러오니 NO DATA FOUND 오류 뜸, 값을 못 불러오는 듯 
    --> 그래서 걍 TBL_OCLASS의 OCOURSE_CODE를 사용함
    SELECT START_DATE, END_DATE INTO V_START_DATE1, V_END_DATE1
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    -- 과정 기간보다 과목 기간이 짧아지지 않도록
    IF( V_START_DATE < V_START_DATE1 OR V_END_DATE > V_END_DATE1 )
        THEN RAISE WRONG_DATE1;
    END IF;
    
    -- 개설일 값 불러오기
    SELECT INSERT_DATE INTO V_INSERT_DATE
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- 개설일보다 시작일이 빠르지 못하도록, 시작일보다 종료일이 빠르지 못하도록
    IF (V_INSERT_DATE > V_START_DATE OR V_START_DATE > V_END_DATE)
        THEN RAISE WRONG_DATE;
    END IF;

    -- 교재 코드의 유무 판단
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- 없으면 '교재 없음' 오류문구 출력
    IF (V_FLAT = 0)
        THEN RAISE NO_BOOK_FOUND;
    END IF;    

    -- 강의가능여부 코드의 유무 판단    
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    -- 없으면 '배정할 교수 없음' 오류문구 출력    
    IF (V_FLAT = 0)
        THEN RAISE NO_PRO_FOUND;
    END IF;
    
    -- 강의가능여부 코드 값 불러오기
    --> 불러오는 이유? 강의가능여부 코드가 사용 중인지 판단하기 위해
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE ABLE_CODE = V_ABLE_CODE
      AND V_START_DATE BETWEEN START_DATE AND END_DATE          -- 시작일이 기존날짜 사이에 못들어가게
      AND V_END_DATE BETWEEN START_DATE AND END_DATE            -- 종료일이 기존날짜 사이에 못들어가게
       OR V_START_DATE < START_DATE AND V_END_DATE > END_DATE;  -- 날짜가 기존날짜보다 더 큰 날짜로 덮지 못하게
    -- 있으면 '잘못된 기간 입력' 오류문구 출력
    IF (V_FLAT != 0)
        THEN RAISE OPENED_CLASS;
    END IF;
    
    -- 업데이트 구문
    UPDATE TBL_OCLASS
    SET START_DATE = V_START_DATE
      , END_DATE = V_END_DATE
      , ABLE_CODE = V_ABLE_CODE
      , OCOURSE_CODE = V_OCOURSE_CODE
      , BOOK_CODE = V_BOOK_CODE
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
        WHEN NO_BOOK_FOUND
            THEN RAISE_APPLICATION_ERROR(-20012, '배정할 교재가 없음');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20013, '배정할 교수가 없음');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20014, '이미 해당 교수가 같은 기간에 배정된 과목이 있습니다, 다른 교수를 배정해주세요.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20015, '개설된 과정보다 넓은 범위의 과목을 개설할 수 없습니다.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20015, '잘못된 날짜 입력.');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
    
END;

---------------------
-- PRC_OCLASS_DELETE        --> A과목이 삭제되면 A과목에 대한 배점 데이터도 삭제되도록??
                            --  OCLASS_CODE가 없는 POINT_CODE를 삭제
                            --  BEFORE ROW 트리거를 통해 해결완료 (자식 데이터를 먼저 삭제 후 부모 데이터 삭제)
SELECT *
FROM TBL_OCLASS;

SELECT *
FROM TBL_POINT;

--EXEC PRC_OCLASS_DELETE(OCLASS_CODE)
EXEC PRC_OCLASS_DELETE(100);   -- 없는데이터
EXEC PRC_OCLASS_DELETE(2);     -- 배점이 부여된 데이터 삭제
EXEC PRC_OCLASS_DELETE(3);     -- 성적이 부여된 데이터 삭제
EXEC PRC_OCLASS_DELETE(18);    -- 배점이 부여된 개설과목
EXEC PRC_OCLASS_DELETE(19);    -- 삭제 가능한 데이터 삭제

CREATE OR REPLACE PROCEDURE PRC_OCLASS_DELETE
(
    V_OCLASS_CODE    IN TBL_OCLASS.OCLASS_CODE%TYPE     -- 개설과목 식별자 변수 (PK)
)
IS
    V_FLAT          NUMBER;         -- 데이터 유무 판단 변수
    NO_DATA_FOUND   EXCEPTION;      -- 데이터 없을 때 쓰는 오류 변수
    GRADE_AWARDED   EXCEPTION;      -- 부여된 성적의 유무 판단할 때 쓰는 오류 변수
BEGIN
    -- 개설과목 코드의 유무 판단
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- 없으면 '데이터 없음' 오류문구 출력
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 성적 코드의 유무 판단
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_GRADE
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- 있으면 '이미 성적이 부여된 과목' 오류문구 출력
    IF (V_FLAT != 0)
        THEN RAISE GRADE_AWARDED;
    END IF;
    
    -- 딜리트 구문
    DELETE 
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;  
    
    -- 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
         WHEN GRADE_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20010, '이미 성적이 부여된 과목입니다');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
    
END;

---------------------
-- TRG_OCLASS_DELETE
CREATE OR REPLACE TRIGGER TRG_OCLASS_DELETE
        BEFORE                  
        DELETE ON TBL_OCLASS    -- 개설과목을 삭제하기 전에
        FOR EACH ROW            
DECLARE

BEGIN
    DELETE                      -- 배점 데이터를 먼저 삭제
    FROM TBL_POINT
    WHERE OCLASS_CODE = :OLD.OCLASS_CODE;
END;

--DROP TRIGGER TRG_OCLASS_DELETE;
--------------------------------------------------------------------------------
--배점{개설과목[개설과정(강의실, 과정), 강의가능(과목, 교수)]}

----------------------
--PRC_POINT_INSERT   --> 배점 합이 0이 아니라면을 넣은 이유
                     --  배점을 나중에 부여하기 위해 합이 0인 경우도 데이터가 들어가도록 
                     --  그럼 업데이트에도 0인 경우가 들어가게 해야하나?

SELECT *
FROM TBL_POINT;

SELECT *
FROM TBL_OCLASS;

--EXEC PRC_POINT_INSERT(V_POINT_ATTEND, V_POINT_PRACTICE, V_POINT_WRITE, V_OCLASS_CODE);
EXEC PRC_POINT_INSERT(100);   -- 없는데이터 
EXEC PRC_POINT_INSERT(20, 20, 60, 1);     -- 중복데이터 
EXEC PRC_POINT_INSERT(-1, 60, 20, 2);     -- 출석 음수
EXEC PRC_POINT_INSERT(20, -1, 60, 2);     -- 실기 음수 
EXEC PRC_POINT_INSERT(20, 60, -1, 2);     -- 필기 음수 
EXEC PRC_POINT_INSERT(100, 100, 100, 3);  -- 총합 100 이상 
EXEC PRC_POINT_INSERT(1, 1, 1, 2);        -- 총합 100 이하 
EXEC PRC_POINT_INSERT(20, 20, 60, 2);     -- 멀쩡한 데이터 
EXEC PRC_POINT_INSERT(0, 0, 0, 18);        -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_POINT_INSERT
(
  V_POINT_ATTEND      IN TBL_POINT.POINT_ATTEND%TYPE        -- 출석 점수
, V_POINT_PRACTICE    IN TBL_POINT.POINT_PRACTICE%TYPE      -- 실기 점수
, V_POINT_WRITE       IN TBL_POINT.POINT_WRITE%TYPE         -- 필기 점수
, V_OCLASS_CODE       IN TBL_POINT.OCLASS_CODE%TYPE         -- 개설과목 코드 (FK : TBL_OCLASS)
)
IS
    V_POINT_CODE        TBL_POINT.POINT_CODE%TYPE;      -- 배점 테이블 식별자 코드 (PK)
    V_FLAT              NUMBER;                         -- 데이터 유무 판단 변수
    NEEDS_TO_BE_100     EXCEPTION;                      -- 배점의 합이 100이 안될 때 사용하는 오류 변수
    LOWER_THAN_ZERO     EXCEPTION;                      -- 출석/실기/필기 각 항목의 배점이 음수일 때 사용하는 오류 변수
    NO_DATA_FOUND       EXCEPTION;                      -- 데이터 없을 때 쓰는 오류 변수
    POINT_AWARDED       EXCEPTION;                      -- 이미 배점이 부여된 과목일 때 쓰는 오류 변수
BEGIN
    -- 개설과목 테이블을 통해 개설과목코드의 유무 판단 
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- 없으면 '데이터 없음' 오류문구 출력
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 배점 테이블에 사용 중인 개설과목코드 유무 판단
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_POINT
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- 있으면 '배점이 부여된 과목' 오류 문구 출력
    IF (V_FLAT != 0)
        THEN RAISE POINT_AWARDED;
    END IF;
    
    -- 각 항목이 음수일 경우
    IF (V_POINT_ATTEND < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_PRACTICE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_WRITE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    -- 배점의 합이 100이 아닐경우
        -- 배점을 나중에 부여하기 위해 합이 0인 경우도 데이터가 들어가도록 --> 그럼 업데이트에도 0인 경우가 들어가게 해야하나?
    IF (V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 0 AND
        V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 100)
        THEN RAISE NEEDS_TO_BE_100;
    END IF;
    
    -- 인서트 구문
    INSERT INTO TBL_POINT(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE, OCLASS_CODE)
    VALUES(TBL_POINT_SEQ.NEXTVAL, V_POINT_ATTEND, V_POINT_PRACTICE, V_POINT_WRITE, V_OCLASS_CODE);
    
    -- 예외처리
    EXCEPTION
        WHEN LOWER_THAN_ZERO
            THEN RAISE_APPLICATION_ERROR(-20003, '유효하지 않은 데이터');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20004, '총합 100점이 되어야 합니다');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
        WHEN POINT_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20008, '이미 배점이 부여된 과목입니다');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
    
END;

----------------------
--PRC_POINT_UPDATE
SELECT *
FROM TBL_POINT;

--EXEC PRC_POINT_UPDATE(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE)
EXEC PRC_POINT_UPDATE(100, 20, 20, 60);   -- 없는데이터 
EXEC PRC_POINT_UPDATE(3, -1, 60, 20);     -- 출석 음수
EXEC PRC_POINT_UPDATE(3, 20, -1, 60);     -- 실기 음수 
EXEC PRC_POINT_UPDATE(3, 20, 60, -1);     -- 필기 음수 
EXEC PRC_POINT_UPDATE(3, 100, 100, 100);  -- 총합 100 이상 
EXEC PRC_POINT_UPDATE(3, 1, 1, 1);        -- 총합 100 이하 
EXEC PRC_POINT_UPDATE(3, 10, 20, 70);     -- 멀쩡한 데이터

CREATE OR REPLACE PROCEDURE PRC_POINT_UPDATE
(
  V_POINT_CODE      IN TBL_POINT.POINT_CODE%TYPE        -- 배점 테이블 식별자 코드 (PK)
, V_POINT_ATTEND    IN TBL_POINT.POINT_ATTEND%TYPE      -- 출석 점수
, V_POINT_PRACTICE  IN TBL_POINT.POINT_PRACTICE%TYPE    -- 실기 점수
, V_POINT_WRITE     IN TBL_POINT.POINT_WRITE%TYPE       -- 필기 점수
)
IS
    V_FLAT              NUMBER;         -- 데이터 유무 판단 변수
    NEEDS_TO_BE_100     EXCEPTION;      -- 배점의 합이 100이 안될 때 사용하는 오류 변수
    LOWER_THAN_ZERO     EXCEPTION;      -- 출석/실기/필기 각 항목의 배점이 음수일 때 사용하는 오류 변수
    NO_DATA_FOUND       EXCEPTION;      -- 데이터 없을 때 쓰는 오류 변수
BEGIN
    -- 배점 테이블에 개설과목코드의 유무 판단 
    SELECT COUNT(POINT_CODE) INTO V_FLAT
    FROM TBL_POINT
    WHERE POINT_CODE = V_POINT_CODE;
    -- 없으면 '데이터 없음' 오류문구 출력
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 각 항목이 음수일 경우
    IF (V_POINT_ATTEND < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_PRACTICE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_WRITE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    -- 배점의 합이 100이 아닐경우
    IF (V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 100)
        THEN RAISE NEEDS_TO_BE_100;
    END IF;
    
    -- 업데이트 구문
    UPDATE TBL_POINT
    SET POINT_ATTEND = V_POINT_ATTEND
      , POINT_PRACTICE = V_POINT_PRACTICE
      , POINT_WRITE = V_POINT_WRITE
    WHERE POINT_CODE = V_POINT_CODE;
    
    -- 예외처리
    EXCEPTION
        WHEN LOWER_THAN_ZERO
            THEN RAISE_APPLICATION_ERROR(-20003, '유효하지 않은 데이터');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20004, '총합 100점이 되어야 합니다');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;

-------------------
--PRC_POINT_DELETE  

SELECT *
FROM TBL_POINT;

--EXEC PRC_POINT_DELETE(BOOK_CODE);
EXEC PRC_POINT_DELETE(100);   -- 없는데이터
EXEC PRC_POINT_DELETE(3);     -- 삭제 가능한 데이터 삭제

CREATE OR REPLACE PROCEDURE PRC_POINT_DELETE
(
  V_POINT_CODE   IN TBL_POINT.POINT_CODE%TYPE   -- 배점 테이블 식별자 코드 (PK)
)
IS
    V_FLAT          NUMBER;         -- 데이터 유무 판단 변수
    NO_DATA_FOUND   EXCEPTION;      -- 데이터 없을 때 쓰는 오류 변수
BEGIN
    -- 배점 테이블에 개설과목코드의 유무 판단
    SELECT COUNT(POINT_CODE) INTO V_FLAT
    FROM TBL_POINT
    WHERE POINT_CODE = V_POINT_CODE;
    -- 없으면 '데이터 없음' 오류문구 출력 
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- 딜리트 구문
    DELETE 
    FROM TBL_POINT
    WHERE POINT_CODE = V_POINT_CODE;

    -- 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '데이터 없음');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;





