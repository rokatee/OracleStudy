SELECT USER
FROM DUAL;
--==>> SCOTT

--※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Date Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- 실행하면 자동으로 COMMIT 된다

--3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다

--4. 커밋, 롤백
--==>> TCL(Transaction Control Language)

--------------------------------------------------------------------------------

--■■■  PROCEDURE(프로시저)  ■■■--

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
 , 매개변수 OUT 데이터타입
 , 매개변수 INOUT 데이터타입
)]
IS
    [주요 변수 선언;]
BEGIN
    -- 실행구문;
    ...
    [EXCEPTION
        -- 예외 처리 구문;]
END;
*/

-- ※ FUNCTION 과 비교했을 때, 
--    『RETURN 반환자료형』 부분이 존재하지 않으며,
--    『RETURN』 문 자체도 존재하지 않으며,
--    프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--    IN, OUT, INOUT 으로 구분된다.


--3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2)]

*/


-- 프로시저 관련 실습 진행을 위해
-- 20220901_02_scott.sql 파일에
-- 테이블 생성 및 데이터 입력 수행

--○ 프로시저 생성 
-- 프로시저 명: PRC_STUDENTS_INSERT(아이디, 패스워드, 이름, 전화, 주소)
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
(
    아이디, 패스워드, 이름, 전화, 주소
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
(   V_ID    IN TBL_STUDENTS.ID%TYPE
,   V_PW    IN TBL_IDPW.PW%TYPE
,   V_NAME  IN TBL_STUDENTS.NAME%TYPE
,   V_TEL   IN TBL_STUDENTS.TEL%TYPE
,   V_ADDR  IN TBL_STUDENTS.ADDR%TYPE

)
IS
    -- 선언부(주요 변수 선언)
BEGIN
    -- 실행부(연산 및 처리)
    -- TBL_IDPW 테이블에 데이터 입력
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID,V_PW);
    -- TBL_STUDENTS 테이블에 데이터 입력
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
    VALUES(V_ID,V_NAME,V_TEL,V_ADDR);
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUNGJUK 테이블에 데이터 입력 시
--   특정 항목의 데이터만 입력하면 
--   ------------------
--   (학번, 이름, 국, 영, 수학점수)
--   내부적으로 총점, 평균, 등급 항목에 대한 처리가 함께 이루어질 수 있도록 하는
--   프로시저를 작성한다(생성한다)
--   프로시저 명 : PRC_SUNGJUK_INSERT()
/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '엄소연', 90, 80, 70);

→ 프로시저 호출로 처리된 경과
학번  이름  국어점수  영어점수  수학점수  총점  평균  등급
 1   엄소연    90        80        70      240   80     B
*/

-- 코드 작성 순서 보기!! ① ~ ⑤
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( --① 변수 쓰기
  V_HAKBUN    IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME      IN TBL_SUNGJUK.NAME%TYPE
, V_KOR       IN TBL_SUNGJUK.KOR%TYPE
, V_ENG       IN TBL_SUNGJUK.ENG%TYPE
, V_MAT       IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- 선언부(주요 변수 선언)
    --③ INSERT 쿼리문 수행을 하기 위해 필요한 변수 선언
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부(연산 및 처리)
    --④ INSERT 쿼리문을 수행하기 전에
    --   선언부에서 선언한 주요 변수들에 값을 담아내야 한다
    --   총점, 평균, 등급 구하기
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    --V_GRADE := DECODE(TRUNC(V_AVG, -1), 90, 'A', 80, 'B', 70, 'C', 60, 'D', 'F');
    -- ( DECODE 는 PL/SQL에서 작동하지 않음 → IF문과 CASE문이 이미 있기 때문)
    
--    V_GRADE := CASE TRUNC(V_AVG, -1) WHEN 100 THEN 'A'
--                                     WHEN 90 THEN 'B'
--                                     WHEN 80 THEN 'C'
--                                     WHEN 70 THEN 'D'
--                                     ELSE 'F' 
--                END;

    --※ IF문 조건식에 괄호 붙이는 습관을 들일 것
    --   있어서 문제는 없지만, 없을 때 문제 생기는 경우가 있다
    IF (V_AVG >= 90) THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
    
    --② 선언부의 변수를 제외한 INSERT 쿼리문 수행 
    --   TBL_SUNGJUK 테이블에 데이터 입력
--    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
--    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, ????, ????, ????);
    
    --⑤ 최종 INSERT 쿼리문 수행 
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);

    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


--○ TBL_SUNGJUK 테이블에 특정 학생의 점수 데이터 수정 시
--   특정 항목의 데이터만 입력하면 
--   ------------------
--   (국, 영, 수학점수)
--   내부적으로 총점, 평균, 등급 항목에 대한 처리가 함께 이루어질 수 있도록 하는
--   프로시저를 작성한다(생성한다)
--   프로시저 명 : PRC_SUNGJUK_UPDATE()
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);

→ 프로시저 호출로 처리된 경과
학번  이름  국어점수  영어점수  수학점수  총점  평균  등급
 1   엄소연    50        50        50      150   50     F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
(
    --① 단계
  V_HAKBUN    IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR       IN TBL_SUNGJUK.KOR%TYPE
, V_ENG       IN TBL_SUNGJUK.ENG%TYPE
, V_MAT       IN TBL_SUNGJUK.MAT%TYPE
)
IS
    --③ 단계
    -- 선언부
    -- 업데이트 쿼리문 수행을 위해 필요한 주요 변수 선언
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- ④ 단계
    -- 업데이트 쿼리문 수행에 앞서 추가로 선언한 주요 변수들에 값 담아내기
    -- 새로운 총점, 평균, 등급 구하기
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
 
    --※ IF문 조건식에 괄호 붙이는 습관을 들일 것
    --   있어서 문제는 없지만, 없을 때 문제 생기는 경우가 있다                    
    IF (V_AVG >= 90) THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
    
    --② 단계
    -- 수정될 총점, 평균, 등급을 제외한 업데이트 쿼리문 수행
--    UPDATE TBL_SUNGJUK
--    SET KOR = V_KOR
--      , ENG = V_ENG
--      , MAT = V_MAT
--      , TOT = ????
--      , AVG = ????
--      , GRADE = ????
--    WHERE HAKBUN = V_HAKBUN;
    
    --⑤ 단계
    -- 최종 업데이트 쿼리문 수행    
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR
      , ENG = V_ENG
      , MAT = V_MAT
      , TOT = V_TOT
      , AVG = V_AVG
      , GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
        
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.


--○ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 변경하는(수정하는)
--   프로시저를 작성한다
--   단, ID와 PW가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다
--   프로시저 명 : PRC_STUDENTS_UPDATE()
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '강원도 횡성');
--> 패스워드 불일치 --==>> 데이터 수정 X

EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '강원도 횡성');
--> 패스워드 일치 --==>> 데이터 수정 O
*/

DESC TBL_STUDENTS;
/*
이름   널? 유형            
---- -- ------------- 
ID      VARCHAR2(10)  
NAME    VARCHAR2(40)  
TEL     VARCHAR2(20)  
ADDR    VARCHAR2(100) 
*/
DESC TBL_IDPW;
/*
이름 널?       유형           
-- -------- ------------ 
ID NOT NULL VARCHAR2(10) 
PW          VARCHAR2(20)
*/

SELECT *
FROM TBL_STUDENTS;
/*
superman	최동현	010-1111-1111	제주도 서귀포시
batman	    김태민	010-2222-2222	서울 마포구
*/

SELECT *
FROM TBL_IDPW;
/*
superman	java002$
batman	    java002$
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
    --① 단계
    V_ID    IN TBL_STUDENTS.ID%TYPE
,   V_PW    IN TBL_IDPW.PW%TYPE
,   V_TEL   IN TBL_STUDENTS.TEL%TYPE
,   V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
    --③ 단계
    -- 선언부
    V_PW2   TBL_IDPW.PW%TYPE;   -- 기존 비번과 비교할 비번 변수
    V_FLAG  NUMBER := 0;        -- 참,거짓을 가려낼 변수
BEGIN 
    
    --④ 단계
    -- 업데이트 쿼리문 수행에 앞서 추가로 선언한 주요 변수들에 값 담아내기
    -- 패스워드가 맞는지 확인
    -- (사용자가 입력한 V_PW 가 기존 패스워드와 동일한지 확인)
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE V_FLAG := 2;
    END IF;

    --② 단계
    -- 비번 일치하는지 확인하는 구문을 제외한 업데이트 쿼리문 수행    
--    UPDATE TBL_STUDENTS
--    SET TEL = V_TEL
--      , ADDR = V_ADDR
--    WHERE ID = V_ID
--      AND ????;

    --⑤ 단계
    -- 최종 업데이트 쿼리문 수행    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL
      , ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_FLAG = 1;
        
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.


CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
-- 매개변수로 받을 것 : 아이디 비밀번호 전화번호 주소
  V_ID IN TBL_IDPW.ID%TYPE
, V_PW IN TBL_IDPW.PW%TYPE
, V_TEL IN TBL_STUDENTS.TEL%TYPE
, V_ADDR IN TBL_STUDENTS.TEL%TYPE
)
IS
-- 변수 선언 : 따로 할 것이 ,,, 없다!
BEGIN
-- 실행 연산 : "아이디 비밀번호가 TBL_IDPW 와 일치한다면" TBL_STUDENTS를 업데이트 한후 COMMIT 한다.
    
    -- 방법1
--    UPDATE TBL_STUDENTS
--    SET TEL = V_TEL
--      , ADDR=V_ADDR
--    WHERE ID = V_ID 
--      AND (SELECT PW
--           FROM TBL_IDPW
--           WHERE ID=V_ID) = V_PW;
           
    -- 방법2
--    UPDATE TBL_STUDENTS
--    SET TEL = V_TEL
--      , ADDR=V_ADDR
--    WHERE ID = (SELECT P.ID
--                FROM TBL_STUDENTS S JOIN TBL_IDPW P
--                ON S.ID = SA.ID
--                WHERE P.PW = V_PW 
--                  AND P.ID = V_ID);
    -- 방법3
    UPDATE(SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
           FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
           ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL
      , T.ADDR = V_ADDR
    WHERE T.ID = V_ID
      AND T.PW = V_PW;
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.



--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   으로 구성된 컬럼 중
--   NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   의 데이터 입력 시
--   NUM 컬럼(사원번호)의 값은
--   기존 부여된 사원 번호의 마지막 번호 그 다음 번호를 자동으로 입력 처리할 수 있는
--   프로시저로 구성한다
--   프로시저 명 : PRC_INSA_INSERT()
/*
실행 예)
INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
VALUES(1061, );

EXEC PRC_INSA_INSERT('조현하', '970124-2234567', SYSDATE, '서울', '010-7202-6306', '개발부', '대리', 2000000, 2000000);

→ 프로시저 호출로 처리된 결과
1061 조현하 970124-2234567 2022-09-01 서울 010-7202-6306 개발부 대리 2000000 2000000
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
(
  V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM   TBL_INSA.NUM%TYPE;
BEGIN
    
--    V_NUM := SELECT MAX(NUM)
--            FROM TBL_INSA;
    --> 에러발생
    --> PLS-00103: Encountered the symbol "SELECT" when expecting one of the following:
    
--    SELECT MAX(NUM) INTO V_NUM
--    FROM TBL_INSA;
    --> 이럴경우 TBL_INSA 테이블에 데이터가 없을 경우 NUM에 NULL값이 들어간다
    --> NVL()로 NULL 처리를 해줘야 한다
    
--    SELECT MAX(NVL(NUM, 0) ) INTO V_NUM
--    FROM TBL_INSA;
--    
--    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--    VALUES(V_NUM+1, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    -- MAX 구문에 미리 +1을 해주면 인서트문에 +1을 할 필요 없다
    SELECT MAX(NVL(NUM, 0) ) + 1 INTO V_NUM
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.
















