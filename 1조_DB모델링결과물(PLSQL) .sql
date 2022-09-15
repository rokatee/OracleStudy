SELECT USER
FROM DUAL;
-- NO1

-- 오류 메시지 목록
/*
■ 데이터 중복 (20001~20100)

-- -20001, '이미 등록된 관리자입니다.'
-- -20002, '이미 등록된 사용자입니다.'
-- -20003, '이미 등록된 과목명입니다.'
-- -20004, '이미 등록된 데이터입니다.'
-- -20005, '이미 등록된 과정명입니다.'
-- -20006, '이미 등록된 강의실명입니다.'
-- -20007, '이미 등록된 교재명입니다.'
-- -20008, '이미 등록된 아이디 또는 주민등록번호입니다.'
-- -20009, '이미 등록된 탈락사유입니다.'
-- -20010, '이미 등록한 과정입니다.'
-- -20011, '이미 등록된 내용입니다.'
-- -20012, '이미 배점이 부여된 과목입니다.'
-- -20013, '이미 성적이 입력된 데이터입니다.'

■ 없는 데이터 (20101~20200)

-- -20101, '등록되지 않은 관리자코드입니다.'
-- -20102, '등록되지 않은 아이디입니다.'
-- -20103, '등록되지 않은 과목명입니다.'
-- -20104, '등록되지 않은 과목명/교수명입니다.'
-- -20105, '등록되지 않은 강의가능여부코드입니다.'
-- -20106, '등록되지 않은 과정코드입니다.'
-- -20107, '등록되지 않은 강의실코드입니다.'
-- -20108, '등록되지 않은 개설과정코드입니다.'
-- -20109, '등록되지 않은 교재코드입니다.'
-- -20110, '등록되지 않은 탈락사유코드입니다.'
-- -20111, '등록되지 않은 수강신청코드입니다.'
-- -20112, '등록되지 않은 중도탈락코드입니다.'
-- -20113, '등록되지 않은 개설과목코드입니다.'
-- -20114, '등록되지 않은 성적코드입니다.'

■ 사용 여부 (20201~20300)

-- -20201, '강의가능여부에서 사용 중인 데이터입니다.'
-- -20202, '개설과목에서 사용 중인 데이터입니다.'
-- -20203, '성적이 부여된 과정은 삭제할 수 없습니다.'
-- -20204, '사용 중인 강의실입니다.'
-- -20205, '사용 중인 교재입니다.'
-- -20206, '해당 기간에 과목이 배정된 교수입니다. 다른 교수를 배정해주세요.'
-- -20207, '성적이 부여된 과목은 삭제할 수 없습니다.'
-- -20208, '이미 수강신청을 한 학생입니다.'
-- -20209, '이미 이용 중인 탈락사유코드입니다.'
-- -20210, '성적이 부여된 수강신청내역은 삭제할 수 없습니다.'

■ 기간 오류 (20301~20400)

-- -20301, '시작일이 종료일 이후입니다.'
-- -20302, '이미 지난 날짜입니다.'
-- -20303, '과목은 과정의 진행기간을 넘어서서 진행할 수 없습니다.'
-- -20304, '잘못된 날짜를 입력했습니다.'
-- -20305, '수강신청 기간이 아닙니다.'
-- -20306, '탈락일자가 과정 기간을 벗어났습니다.'
-- -20307, '성적입력기간이 아닙니다.'

■ 기타 (20401~20500)
-- -20401, '유효하지 않은 배점입니다.'
-- -20402, '총 배점은 100이 되어야 합니다.'
-- -20403, '유효하지 않은 점수입니다.'
-- -20308, '아직 수료하지 않은 과목입니다.'

*/


-- TBL_ADMIN(관리자) 테이블 ----------------------------------------------------

-- 프로시저 생성(INSERT)
CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
( V_ADMIN_ID        IN TBL_ADMIN.ADMIN_ID%TYPE
, V_ADMIN_PW        IN TBL_ADMIN.ADMIN_PW%TYPE
, V_ADMIN_NAME      IN TBL_ADMIN.ADMIN_NAME%TYPE
)
IS
BEGIN
    INSERT INTO TBL_ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NAME)
    VALUES(V_ADMIN_ID, V_ADMIN_PW, V_ADMIN_NAME);
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20001, '이미 등록된 관리자입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;

-- 프로시저 생성(UPDATE)
CREATE OR REPLACE PROCEDURE PRC_ADMIN_UPDATE
( V_ADMIN_ID        IN TBL_ADMIN.ADMIN_ID%TYPE
, V_ADMIN_PW        IN TBL_ADMIN.ADMIN_PW%TYPE
, V_ADMIN_NAME      IN TBL_ADMIN.ADMIN_NAME%TYPE
)
IS
    V_CHECK     TBL_ADMIN.ADMIN_ID%TYPE;

BEGIN
    -- 이미 있는 ADMIN_ID인지 확인 (없을 시 오류 발생)
    SELECT ADMIN_ID INTO V_CHECK
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    UPDATE TBL_ADMIN
    SET ADMIN_PW = V_ADMIN_PW
      , ADMIN_NAME = V_ADMIN_NAME
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20101, '등록되지 않은 관리자코드입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;

END;

-- 프로시저 생성(DELETE)
CREATE OR REPLACE PROCEDURE PRC_ADMIN_DELETE
( V_ADMIN_ID        IN TBL_ADMIN.ADMIN_ID%TYPE
)
IS
    V_CHECK     TBL_ADMIN.ADMIN_ID%TYPE;
BEGIN
    -- 이미 등록된 ADMIN_ID인지 확인 (없을 시 오류 발생)
    SELECT ADMIN_ID INTO V_CHECK
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    DELETE
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20101, '등록되지 않은 관리자코드입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_PROFESSOR(교수) 테이블 --------------------------------------------------

-- 프로시저 생성(INSERT) : PRO_PHONE이랑 PRO_EMAIL은 널값 허용인데 여기서는 안 넣으면 프로시저 작동이 안 됨
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_INSERT
( V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
, V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_PRO_SSN     IN TBL_PROFESSOR.PRO_SSN%TYPE
, V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
, V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_PRO_PW    TBL_PROFESSOR.PRO_PW%TYPE;
    
BEGIN
    -- 중복 확인은 PRO_SSN 컬럼에 UNIQUE 조건 추가하면 해결될 듯? (논의 완료)

    -- 비밀번호 기본값(주민번호 뒷자리) 지정
    V_PRO_PW := SUBSTR(V_PRO_SSN, 8);
    
    -- 데이터 INSERT
    INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
    VALUES(V_PRO_ID, V_PRO_NAME, V_PRO_PW, V_PRO_SSN, V_PRO_EMAIL, V_PRO_PHONE);
    
    -- 예외 처리
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20002, '이미 등록된 사용자입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- 프로시저 생성(UPDATE) : 수정이 가능한 정보에는 무엇이 있을지 논의 필요 (완료)
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
( V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
, V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_PRO_PW      IN TBL_PROFESSOR.PRO_PW%TYPE
, V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
, V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_CHECK_ID      TBL_PROFESSOR.PRO_ID%TYPE;
    
BEGIN
    -- 등록되어 있는 정보인지 검색 (없을 시 오류 발생)
    SELECT PRO_ID INTO V_CHECK_ID
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    -- 데이터 UPDATE : 기준을 SSN으로 하는 게 나을지도? ID도 변경할 수 있게... (논의 완료: ID 변경 X)
    UPDATE TBL_PROFESSOR
    SET PRO_NAME = V_PRO_NAME
      , PRO_PW = V_PRO_PW
      , PRO_EMAIL = V_PRO_EMAIL
      , PRO_PHONE = V_PRO_PHONE
    WHERE PRO_ID = V_PRO_ID;
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '등록되지 않은 아이디입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- 프로시저 생성(DELETE) ▶ TRIGGER(TBL_ABLE)
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
( V_PRO_ID  IN TBL_PROFESSOR.PRO_ID%TYPE
)
IS
    V_CHECK_ID    TBL_PROFESSOR.PRO_ID%TYPE;
    V_COUNT       NUMBER := 0;
    
    ALREADY_USE   EXCEPTION;
    
BEGIN
    -- ABLE_ID 존재하는지 유효성 검사 (없을 시 오류 발생)
    SELECT PRO_ID INTO V_CHECK_ID
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    SELECT COUNT(ABLE_CODE) INTO V_COUNT
    FROM TBL_ABLE
    WHERE PRO_ID = V_PRO_ID;
    
    IF (V_COUNT > 0)
        THEN RAISE ALREADY_USE;
    END IF;

    -- 데이터 DELETE
    DELETE
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '등록되지 않은 아이디입니다.');
                 ROLLBACK;
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR( -20201, '강의가능여부에서 사용 중인 데이터입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_CLASS(과목) 테이블 ------------------------------------------------------

-- 프로시저 생성(INSERT)
CREATE OR REPLACE PROCEDURE PRC_CLASS_INSERT
( V_CLASS_NAME      IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CLASS_CODE        TBL_CLASS.CLASS_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- 이미 등록된 과목명인지 확인 : 이거 그냥 UNIQUE 조건 추가해서 해결하면 되지 않나? (이대로 쓰면 오류남)

    -- 데이터 INSERT
    INSERT INTO TBL_CLASS(CLASS_CODE, CLASS_NAME)
    VALUES(TBL_CLASS_SEQ.NEXTVAL, V_CLASS_NAME);
    
    -- 예외 처리
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20003, '이미 등록된 과목명입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- 프로시저 생성(UPDATE) ▶ TRIGGER(TBL_ABLE) 
--                          : 과목명만 바뀌는 거니까 굳이 강의 가능 여부 테이블에서 수정할 필요가 없나? 싶기도 함 (논의 완료)
CREATE OR REPLACE PROCEDURE PRC_CLASS_UPDATE
( V_CLASS_CODE  IN TBL_CLASS.CLASS_CODE%TYPE
, V_CLASS_NAME  IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
BEGIN
    -- 이미 등록된 과목코드인지 확인  (없을 시 오류 발생)
    SELECT CLASS_CODE INTO V_CHECK_CODE
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    -- 데이터 UPDATE
    UPDATE TBL_CLASS
    SET CLASS_NAME = V_CLASS_NAME
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20103, '등록되지 않은 과목명입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;


-- 프로시저 생성(DELETE) ▶ TRIGGER(TBL_ABLE)
CREATE OR REPLACE PROCEDURE PRC_CLASS_DELETE
( V_CLASS_NAME  IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    V_COUNT         NUMBER;
    
    ALREADY_USE   EXCEPTION;
    
BEGIN
    -- CLASS_NAME에 대응하는 CLASS_CODE 찾기
    SELECT CLASS_CODE INTO V_CHECK_CODE
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;

    -- 삭제하려는 코드를 이용 중인 자식 테이블이 있는지 검사
    SELECT COUNT(ABLE_CODE) INTO V_COUNT
    FROM TBL_ABLE
    WHERE CLASS_CODE = V_CHECK_CODE;
    
    -- 있다면 에러 발생
    IF (V_COUNT != 0)
        THEN RAISE ALREADY_USE;
    END IF;
    
    -- 데이터 DELETE
    DELETE
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CHECK_CODE;
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20103, '등록되지 않은 과목명입니다.');
                 ROLLBACK;
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR( -20201, '강의가능여부에서 사용 중인 데이터입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_ABLE(강의 가능 여부) 테이블 ---------------------------------------------

-- 프로시저 생성(INSERT)
CREATE OR REPLACE PROCEDURE PRC_ABLE_INSERT
( V_PRO_NAME        IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_CLASS_NAME      IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_PRO_ID        TBL_PROFESSOR.PRO_ID%TYPE;
    V_CLASS_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    
    V_CHECK_CODE    TBL_ABLE.ABLE_CODE%TYPE;
    
BEGIN
    -- 사용자에게 입력 받은 교수명에 해당하는 교수 아이디를 변수값에 지정
    SELECT PRO_ID INTO V_PRO_ID
    FROM TBL_PROFESSOR
    WHERE PRO_NAME = V_PRO_NAME;
    
    -- 사용자에게 입력 받은 과목명에 해당하는 과목 아이디를 변수값에 지정
    SELECT CLASS_CODE INTO V_CLASS_CODE
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;
    
    -- 이미 등록된 데이터인지 확인 : 이것도 두개 묶어서 UNIQUE 지정 필요 (논의 완료)

    -- 데이터 INSERT
    INSERT INTO TBL_ABLE(ABLE_CODE, PRO_ID, CLASS_CODE)
    VALUES(TBL_ABLE_SEQ.NEXTVAL, V_PRO_ID, V_CLASS_CODE);
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20104, '등록되지 않은 과목명/교수명입니다.');
                 ROLLBACK;
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20004, '이미 등록된 데이터입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- 프로시저 생성(UPDATE) ▶ TRIGGER(TBL_OCLASS)
--                           : 이것도 어차피 강의 가능 여부 코드 가져다 쓰는 거니까 필요 없을지도?
CREATE OR REPLACE PROCEDURE PRC_ABLE_UPDATE
( V_ABLE_CODE   IN TBL_ABLE.ABLE_CODE%TYPE
, V_CLASS_NAME  IN TBL_CLASS.CLASS_NAME%TYPE
, V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
)
IS
    V_PRO_ID        TBL_PROFESSOR.PRO_ID%TYPE;
    V_CLASS_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    
BEGIN
    -- 사용자에게 입력 받은 교수명에 해당하는 교수 아이디를 변수값에 지정
    SELECT PRO_ID INTO V_PRO_ID
    FROM TBL_PROFESSOR
    WHERE PRO_NAME = V_PRO_NAME;
    
    -- 사용자에게 입력 받은 과목명에 해당하는 과목 아이디를 변수값에 지정
    SELECT CLASS_CODE INTO V_CLASS_CODE
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;
    
    -- 이미 등록된 강의 가능 여부 코드인지 확인 (없을 시 오류 발생)
    SELECT ABLE_CODE INTO V_CHECK_CODE
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- 데이터 UPDATE
    UPDATE TBL_ABLE
    SET CLASS_CODE = V_CLASS_CODE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    UPDATE TBL_ABLE
    SET PRO_ID = V_PRO_ID
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20104, '등록되지 않은 과목명/교수명입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    ROLLBACK;
            
    COMMIT;
    
END;

-- 프로시저 생성(DELETE) ▶ TRIGGER(TBL_OCLASS)
CREATE OR REPLACE PROCEDURE PRC_ABLE_DELETE
( V_ABLE_CODE  IN TBL_ABLE.ABLE_CODE%TYPE
)
IS
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    V_COUNT         NUMBER := 0;
    
    ALREADY_USE     EXCEPTION;
    
BEGIN
    -- ABLE_ID 존재하는지 유효성 검사 (없을 시 오류 발생)
    SELECT ABLE_CODE INTO V_CHECK_CODE
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- 삭제하려는 코드를 이용 중인 자식 테이블이 있는지 검사
    SELECT COUNT(OCLASS_CODE) INTO V_COUNT
    FROM TBL_OCLASS
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- 이미 있다면 에러 발생
    IF (V_COUNT > 0)
        THEN RAISE ALREADY_USE;
    END IF;

    -- 데이터 DELETE
    DELETE
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- 예외 처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20105, '등록되지 않은 강의가능여부코드입니다.');
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR(-20202, '개설과목에서 사용 중인 데이터입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
        ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_COURSE(과정) 테이블 -----------------------------------------------------

--■■■ 과정 등록 PRC_COURSE_INSERT(과정명) ■■■--

CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
(
    -- 사용자에게 입력받을 변수
  V_COURSE_NAME IN TBL_COURSE.COURSE_NAME%TYPE
)
IS
    -- 변수 선언
    CHECK_COURSE_NAME   TBL_COURSE.COURSE_NAME%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- 존재하는 과정코드인지 확인
    SELECT NVL( (SELECT COURSE_CODE
                 FROM TBL_COURSE
                 WHERE COURSE_CODE = V_COURSE_CODE), '0') INTO CHECK_COURSE_CODE
    FROM DUAL;
    
    -- 0이면 과정코드가 NULL인 상태 → 존재하지 않는 과정(예외처리)
    IF (CHECK_COURSE_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 과정 이름 있는지 확인
    SELECT NVL( (SELECT COURSE_NAME
                 FROM TBL_COURSE
                 WHERE COURSE_NAME = V_COURSE_NAME), '0') INTO CHECK_COURSE_NAME
    FROM DUAL;   
    
    -- 과정 이름이 있으면 이미 등록된 과정 예외처리하기 위해
    IF (CHECK_COURSE_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT 쿼리문 수행
    INSERT INTO TBL_COURSE(COURSE_CODE, COURSE_NAME)
    VALUES(TBL_COURSE_SEQ.NEXTVAL, V_COURSE_NAME);
    
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '이미 등록된 과정명입니다.');        -- 이미 등록된 과정입니다.
        ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--■■■ 과정 수정 PRC_COURSE_UPDATE(과정코드, 과정명) ■■■--

CREATE OR REPLACE PROCEDURE PRC_COURSE_UPDATE
( 
  V_COURSE_CODE     IN TBL_COURSE.COURSE_CODE%TYPE
, V_COURSE_NAME     IN TBL_COURSE.COURSE_NAME%TYPE
)
IS

    CHECK_COURSE_NAME   TBL_COURSE.COURSE_NAME%TYPE;
    CHECK_COURSE_CODE   TBL_COURSE.COURSE_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    
    -- 없는 과정코드면 예외 처리
    SELECT COURSE_CODE INTO CHECK_COURSE_CODE
    FROM TBL_COURSE
    WHERE COURSE_CODE = V_COURSE_CODE;
    
    -- 과정명 확인
    SELECT NVL( (SELECT COURSE_NAME
                 FROM TBL_COURSE
                 WHERE COURSE_NAME = V_COURSE_NAME), '0') INTO CHECK_COURSE_NAME
    FROM DUAL;
    
    -- 있는 과정명이면 예외 처리
    IF (CHECK_COURSE_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 과정 이름 변경
    UPDATE TBL_COURSE
    SET COURSE_NAME = V_COURSE_NAME
    WHERE COURSE_CODE = V_COURSE_CODE;
    
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '이미 등록된 과정명입니다.');        -- 이미 등록된 과정입니다.
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20106, '등록되지 않은 과정코드입니다.');
        ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--■■■ 과정 삭제 PRC_COURSE_DELETE(과정명) ■■■--

CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
(
    V_COURSE_NAME   IN TBL_COURSE.COURSE_NAME%TYPE
)
IS
    CHECK_COURSE_CODE   TBL_COURSE.COURSE_CODE%TYPE;
    CHECK_GRADE_CODE    TBL_GRADE.GRADE_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    
    -- 존재하는 과정코드인지 확인
    SELECT NVL( (SELECT COURSE_CODE
                 FROM TBL_COURSE
                 WHERE COURSE_NAME = V_COURSE_NAME), 0) INTO CHECK_COURSE_CODE
    FROM DUAL;
    
    -- 없는 과정일 경우, 예외 발생
    IF (CHECK_COURSE_CODE = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
     -- 성적이 존재하는 과정코드인지 확인
    SELECT NVL( (SELECT MAX(TG.GRADE_CODE)
                  FROM TBL_GRADE TG
                       JOIN (SELECT OCLASS_CODE
                             FROM TBL_OCLASS TS JOIN TBL_OCOURSE TE
                              ON TS.OCOURSE_CODE = TE.OCOURSE_CODE
                             WHERE TE.COURSE_CODE = CHECK_COURSE_CODE) OC
                             ON TG.OCLASS_CODE = OC.OCLASS_CODE) , 0) INTO CHECK_GRADE_CODE
    FROM DUAL;
    
    -- 성적이 입력된 개설과정의 경우는 예외 발생
    IF (CHECK_GRADE_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    DELETE
    FROM TBL_COURSE
    WHERE COURSE_CODE = CHECK_COURSE_CODE;
    
    -- 커밋
    COMMIT;

    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20106, '등록되지 않은 과정코드입니다.');
        ROLLBACK; 
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20203, '성적이 부여된 과정은 삭제할 수 없습니다.'); 
        ROLLBACK;
            
END;

    
--------------------------------------------------------------------------------
--■■■ 과정 삭제2 PRC_COURSE_DELETE_1 (트리거) ■■■--
-- 과정 삭제 트리거
-- 과정에서 DELETE가 실행됐을 때 개설과정 테이블에서도 과정을 삭제한다.

CREATE OR REPLACE TRIGGER TRG_COURSE_DELETE
    BEFORE
    DELETE ON TBL_COURSE
    FOR EACH ROW
    
BEGIN
    DELETE
    FROM TBL_OCOURSE
    WHERE COURSE_CODE = :OLD.COURSE_CODE;    -- :OLD는 지워지기 전의 TBL_COURSE 값
    
END;


-- TBL_CLASSROOM(강의실) 테이블 ------------------------------------------------

--■■■ 강의실 등록 PRC_CLASSROOM_INSERT(강의실명, 강의실수용인원) ■■■--

CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_INSERT
( 
  V_ROOM_NAME   IN TBL_CLASSROOM.ROOM_NAME%TYPE
, V_ROOM_INWON  IN TBL_CLASSROOM.ROOM_INWON%TYPE
)
IS
    -- 변수 선언
    CHECK_ROOM_NAME     TBL_CLASSROOM.ROOM_NAME%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    
    SELECT NVL( (SELECT ROOM_NAME
                 FROM TBL_CLASSROOM
                 WHERE ROOM_NAME = V_ROOM_NAME), '0') INTO CHECK_ROOM_NAME
    FROM DUAL;
    
    -- 0이 아니라는 건 강의실명이 이미 존재한다는 얘기 → 예외 처리 (UNIQUE와 같은 역할 구문)
    IF (CHECK_ROOM_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT 쿼리문 수행
    INSERT INTO TBL_CLASSROOM(ROOM_CODE, ROOM_NAME, ROOM_INWON)
    VALUES(TBL_CLASSROOM_SEQ.NEXTVAL, V_ROOM_NAME, V_ROOM_INWON);
    
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20006, '이미 등록된 강의실명입니다.');
        ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--■■■ 강의실 수정 PRC_CLASSROOM_UPDATE(강의실코드, 강의실명, 강의실수용인원) ■■■--

CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_UPDATE
( 
  V_ROOM_CODE   IN TBL_CLASSROOM.ROOM_CODE%TYPE
, V_ROOM_NAME   IN TBL_CLASSROOM.ROOM_NAME%TYPE
, V_ROOM_INWON  IN TBL_CLASSROOM.ROOM_INWON%TYPE
)
IS
    -- 선언부
    CHECK_ROOM_CODE    TBL_CLASSROOM.ROOM_CODE%TYPE;
    CHECK_ROOM_NAME    TBL_CLASSROOM.ROOM_NAME%TYPE;
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- 존재하는 강의실코드인지 확인
    SELECT NVL( (SELECT ROOM_CODE
                 FROM TBL_CLASSROOM
                 WHERE ROOM_CODE = V_ROOM_CODE), '0') INTO CHECK_ROOM_CODE
    FROM DUAL;
    
    -- 0이면 강의실코드가 NULL인 상태 → 존재하지 않는 강의실(예외처리)
    IF (CHECK_ROOM_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 이미 사용중인(등록된) 강의실명인지 확인
    SELECT NVL( (SELECT ROOM_NAME
                 FROM TBL_CLASSROOM
                 WHERE ROOM_NAME = V_ROOM_NAME), '0') INTO CHECK_ROOM_NAME
    FROM DUAL;
    
    -- 강의실 사용중이면 예외처리
    IF (CHECK_ROOM_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- INSERT 쿼리문 수행
    UPDATE TBL_CLASSROOM
    SET ROOM_NAME = V_ROOM_NAME
      , ROOM_INWON = V_ROOM_INWON
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20017, '존재하지 않는 강의실코드입니다.');
            
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20107, '등록되지 않은 강의실코드입니다.');     -- 이미 등록된 강의실명입니다.
            
        ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--■■■ 강의실 삭제 PRC_CLASSROOM_DELETE(강의실명) ■■■--

CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_DELETE
(
  V_ROOM_NAME    IN TBL_CLASSROOM.ROOM_NAME%TYPE
)
IS
    -- 선언부
    CHECK_ROOM_CODE              TBL_CLASSROOM.ROOM_CODE%TYPE;
    CHECK_OCOURSE_ROOM_CODE      TBL_CLASSROOM.ROOM_CODE%TYPE;
    USER_DEFINE_ERROR            EXCEPTION;
    USER_DEFINE_ERROR2           EXCEPTION;
    
BEGIN
    
    -- 존재하는 강의실코드인지 확인
    SELECT NVL( (SELECT ROOM_CODE
                 FROM TBL_CLASSROOM
                 WHERE ROOM_NAME = V_ROOM_NAME), 0) INTO CHECK_ROOM_CODE
    FROM DUAL;
    
    -- 없는 강의실일 경우, 예외 발생
    IF (CHECK_ROOM_CODE = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 이미 사용중인 개설과정이 있는지 확인
    SELECT NVL( (SELECT ROOM_CODE
                 FROM TBL_OCOURSE
                 WHERE ROOM_CODE = CHECK_ROOM_CODE), 0) INTO CHECK_OCOURSE_ROOM_CODE
    FROM DUAL;
    
    -- 과정이 진행중인 강의실이라면 예외 처리
    IF (CHECK_OCOURSE_ROOM_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- DELETE 쿼리문 수행
    DELETE
    FROM TBL_CLASSROOM
    WHERE ROOM_CODE = CHECK_ROOM_CODE;
    
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20107, '등록되지 않은 강의실코드입니다.');
            
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20204, '사용 중인 강의실입니다.');
            
        ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;


-- TBL_OCOURSE(개설 과정) 테이블 -----------------------------------------------

--■■■ 개설과정 등록 PRC_OCOURSE_INSERT(과정시작일, 과정종료일, 과정코드, 강의실코드) ■■■--

CREATE OR REPLACE PROCEDURE PRC_OCOURSE_INSERT
(
  V_ST_DATE         IN TBL_OCOURSE.START_DATE%TYPE
, V_END_DATE        IN TBL_OCOURSE.END_DATE%TYPE
, V_COURSE_CODE     IN TBL_OCOURSE.COURSE_CODE%TYPE
, V_ROOM_CODE       IN TBL_OCOURSE.ROOM_CODE%TYPE
)
IS
    -- 선언부
    V_OLD_ST_DATE       TBL_OCOURSE.START_DATE%TYPE;
    V_OLD_END_DATE      TBL_OCOURSE.END_DATE%TYPE;
    V_OLD_COURSE_CODE   TBL_OCOURSE.COURSE_CODE%TYPE;
    V_OLD_ROOM_CODE     TBL_OCOURSE.ROOM_CODE%TYPE;    
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;      -- 시작일자 > 종료일자일 경우, 발생
    USER_DEFINE_ERROR3  EXCEPTION;      -- 과정시작일, 과정종료일이 SYSDATE 이후여야함
    
    
    -- 커서변수 선언 및 커서 정의
    CURSOR CUR_OCOURSE_SELECT 
    IS 
    SELECT START_DATE, END_DATE, COURSE_CODE, ROOM_CODE
    FROM TBL_OCOURSE;   
    
BEGIN

    -- 시작일이 종료일보다 늦을 경우
    IF (V_END_DATE - V_ST_DATE < 0) 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF; 
    
    -- 과정시작일이 현재일보다 이전이거나 과정종료일이 과정시작일보다 이전인 경우, 예외 발생
    IF (V_ST_DATE < TO_DATE(SYSDATE, 'YYYY-MM-DD') OR V_END_DATE < V_ST_DATE)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    
    
    OPEN CUR_OCOURSE_SELECT;
    
    
    LOOP 
        -- 한 줄씩 처리
        FETCH CUR_OCOURSE_SELECT INTO V_OLD_ST_DATE, V_OLD_END_DATE, V_OLD_COURSE_CODE, V_OLD_ROOM_CODE;
        
        EXIT WHEN CUR_OCOURSE_SELECT%NOTFOUND;
  
        -- (강의실 기준)과정시작일은 존재하는 과정시작일보다 빠른데 과정종료일이 존재하는 과정종료일보다 더 늦는 경우
        IF (V_ST_DATE <= V_OLD_ST_DATE AND V_END_DATE >= V_OLD_ST_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        -- 과정종료일은 존재하는 과정종료일보다 더 늦는데 과정시작일이 존재하는 과정시작일보다 더 이른 경우
        ELSIF (V_ST_DATE <= V_OLD_END_DATE AND V_END_DATE >= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        -- 과정시작일은 존재하는 과정시작일보다 늦는데 과정종료일이 존재하는 과정종료일보다 더 이른 경우   
        ELSIF (V_ST_DATE >= V_OLD_ST_DATE AND V_END_DATE <= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))  
            THEN RAISE USER_DEFINE_ERROR;
            
        END IF;
       
  
    END LOOP;
    
    CLOSE CUR_OCOURSE_SELECT;
    
    
    INSERT INTO TBL_OCOURSE(OCOURSE_CODE, START_DATE, END_DATE, COURSE_CODE, ROOM_CODE)
    VALUES (TBL_OCOURSE_SEQ.NEXTVAL, V_ST_DATE, V_END_DATE, V_COURSE_CODE, V_ROOM_CODE);  
    
    COMMIT;   

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20204, '사용 중인 강의실입니다.');
        ROLLBACK; 
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20301, '시작일이 종료일 이후입니다.'); 
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20302, '이미 지난 날짜입니다.');
        ROLLBACK;
    
END;


--------------------------------------------------------------------------------
--■■■ 개설과정 수정 PRC_OCOURSE_UPDATE(개설과정코드, 과정시작일, 과정종료일, 과정코드, 강의실코드) ■■■--

CREATE OR REPLACE PROCEDURE PRC_OCOURSE_UPDATE
( 
  V_OCOURSE_CODE  IN TBL_OCOURSE.OCOURSE_CODE%TYPE
, V_ST_DATE       IN TBL_OCOURSE.START_DATE%TYPE
, V_END_DATE      IN TBL_OCOURSE.END_DATE%TYPE
, V_COURSE_CODE   IN TBL_COURSE.COURSE_CODE%TYPE
, V_ROOM_CODE     IN TBL_CLASSROOM.ROOM_CODE%TYPE
)
IS
    
    V_OLD_OCOURSE_CODE  TBL_OCOURSE.OCOURSE_CODE%TYPE;
    V_OLD_ST_DATE       TBL_OCOURSE.START_DATE%TYPE;
    V_OLD_END_DATE      TBL_OCOURSE.END_DATE%TYPE;
    V_OLD_COURSE_CODE   TBL_COURSE.COURSE_CODE%TYPE;
    V_OLD_ROOM_CODE     TBL_CLASSROOM.ROOM_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    USER_DEFINE_ERROR3  EXCEPTION;
    
    CURSOR CUR_OCOURSE_SELECT 
    IS 
    SELECT OCOURSE_CODE, START_DATE, END_DATE, COURSE_CODE, ROOM_CODE
    FROM TBL_OCOURSE;   
    
BEGIN

    IF (V_END_DATE - V_ST_DATE < 0) 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;  
    
    -- 과정시작일이 현재일보다 이전이거나 과정종료일이 과정시작일보다 이전인 경우, 예외 발생
    IF (V_ST_DATE < TO_DATE(SYSDATE, 'YYYY-MM-DD') OR V_END_DATE < V_ST_DATE) 
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    

    OPEN CUR_OCOURSE_SELECT;
    
    LOOP 
        FETCH CUR_OCOURSE_SELECT INTO V_OLD_OCOURSE_CODE, V_OLD_ST_DATE, V_OLD_END_DATE, V_OLD_COURSE_CODE, V_OLD_ROOM_CODE;
        
        EXIT WHEN CUR_OCOURSE_SELECT%NOTFOUND;
  
        IF (V_ST_DATE <= V_OLD_ST_DATE AND V_END_DATE >= V_OLD_ST_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        ELSIF (V_ST_DATE <= V_OLD_END_DATE AND V_END_DATE >= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        ELSIF (V_ST_DATE >= V_OLD_ST_DATE AND V_END_DATE <= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))  
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
       
  
    END LOOP;
    
    CLOSE CUR_OCOURSE_SELECT;
    
    
    UPDATE TBL_OCOURSE
    SET START_DATE = V_ST_DATE, END_DATE = V_END_DATE, COURSE_CODE = V_COURSE_CODE, ROOM_CODE = V_ROOM_CODE  
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    
    -- 커밋
    COMMIT;   


    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20204, '사용 중인 강의실입니다.');
        ROLLBACK; 
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20301, '시작일이 종료일 이후입니다.'); 
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20302, '이미 지난 날짜입니다.');
        ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;


--------------------------------------------------------------------------------
--■■■ 개설과정 삭제 PRC_OCOURSE_DELETE(개설과정코드) ■■■--

CREATE OR REPLACE PROCEDURE PRC_OCOURSE_DELETE
(
  V_OCOURSE_CODE    IN TBL_OCOURSE.OCOURSE_CODE%TYPE
)
IS
    -- 선언부
    CHECK_OCOURSE_CODE      TBL_OCOURSE.OCOURSE_CODE%TYPE;
    CHECK_GRADE_CODE        TBL_GRADE.GRADE_CODE%TYPE;
    USER_DEFINE_ERROR       EXCEPTION;
    USER_DEFINE_ERROR2      EXCEPTION;
    
BEGIN
    
    -- 존재하는 개설과정코드인지 확인
    SELECT NVL( (SELECT OCOURSE_CODE
                 FROM TBL_OCOURSE
                 WHERE OCOURSE_CODE = V_OCOURSE_CODE), 0) INTO CHECK_OCOURSE_CODE
    FROM DUAL;
    
    -- 없는 개설과정코드일 경우, 예외 발생
    IF (CHECK_OCOURSE_CODE = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- 성적이 존재하는 개설과정코드인지 확인
    SELECT NVL( (SELECT MAX(TG.GRADE_CODE)
                  FROM TBL_GRADE TG
                       JOIN (SELECT OCLASS_CODE
                             FROM TBL_OCLASS
                             WHERE OCOURSE_CODE = V_OCOURSE_CODE) OC
                             ON TG.OCLASS_CODE = OC.OCLASS_CODE) , 0) INTO CHECK_GRADE_CODE
    FROM DUAL;
    
    -- 성적이 입력된 개설과정의 경우는 예외 발생
    IF (CHECK_GRADE_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- DELETE 쿼리문 수행
    DELETE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20108, '등록되지 않은 개설과정 코드입니다.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20203, '성적이 부여된 과정은 삭제할 수 없습니다.'); 
        ROLLBACK;
    
    -- 커밋
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--■■■ 개설과정 삭제2 PRC_OCOURSE_DELETE_1 (트리거) ■■■--
-- 개설과정 삭제 트리거
-- 개설과정에서 DELETE가 실행됐을 때 
-- 개설과목 테이블에서도 개설과정을 삭제한다.

CREATE OR REPLACE TRIGGER TRG_OCOURSE_DELETE
    BEFORE
    DELETE ON TBL_OCOURSE
    FOR EACH ROW
    
BEGIN
    DELETE
    FROM TBL_OCLASS
    WHERE OCOURSE_CODE = :OLD.OCOURSE_CODE;    -- :OLD는 지워지기 전의 TBL_OCOURSE의 값
    
    DELETE
    FROM TBL_SIGN
    WHERE OCOURSE_CODE = :OLD.OCOURSE_CODE;
    
END; 


-- TBL_TEXTBOOK(교재) 테이블 ---------------------------------------------------

----------------------
-- PRC_TEXTBOOK_INSERT
--EXEC PRC_TEXTBOOK_INSERT(BOOK_NAME, BOOK_PUB);

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
            THEN RAISE_APPLICATION_ERROR(-20007, '이미 등록된 교재명입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;


----------------------
-- PRC_TEXTBOOK_UPDATE
--EXEC PRC_TEXTBOOK_UPDATE(BOOK_CODE, BOOK_NAME, BOOK_PUB);

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
            THEN RAISE_APPLICATION_ERROR(-20109, '등록되지 않은 교재 코드입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


----------------------
--PRC_TEXTBOOK_DELETE
--EXEC PRC_TEXTBOOK_DELETE(BOOK_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20109, '등록되지 않은 교재 코드입니다.');
        WHEN USING_IN_OCLASS
            THEN RAISE_APPLICATION_ERROR( -20205, '사용 중인 교재입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


-- TBL_OCLASS(개설 과목) 테이블 ------------------------------------------------

--개설과목[개설과정(강의실, 과정), 강의가능(과목, 교수)]
---------------------
-- PRC_OCLASS_INSERT
--EXEC PRC_OCLASS_INSERT(V_START_DATE, V_END_DATE, V_ABLE_CODE, V_OCOURSE_CODE, V_BOOK_CODE);

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
    IF (TO_DATE(SYSDATE, 'YYYY-MM-DD') > V_START_DATE OR V_START_DATE > V_END_DATE)
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
            THEN RAISE_APPLICATION_ERROR(-20109, '등록되지 않은 교재 코드입니다.');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20013, '등록되지 않은 강의가능여부 코드입니다.');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20206, '해당 기간에 과목이 배정된 교수입니다. 다른 교수를 배정해주세요.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20303, '과목은 과정의 진행기간을 넘어서서 진행할 수 없습니다.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20304, '잘못된 날짜를 입력했습니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;

END;


---------------------
-- PRC_OCLASS_UPDATE
--EXEC PRC_OCLASS_UPDATE(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)

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
            THEN RAISE_APPLICATION_ERROR(-20108, '등록되지 않은 개설과정 코드입니다.');
        WHEN NO_BOOK_FOUND
            THEN RAISE_APPLICATION_ERROR(-20109, '등록되지 않은 교재 코드입니다.');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20105, '등록되지 않은 강의가능여부 코드입니다.');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20206, '해당 기간에 과목이 배정된 교수입니다. 다른 교수를 배정해주세요.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20303, '과목은 과정의 진행기간을 넘어서서 진행할 수 없습니다.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20304, '잘못된 날짜를 입력했습니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
    
END;


---------------------
-- PRC_OCLASS_DELETE
--EXEC PRC_OCLASS_DELETE(OCLASS_CODE)

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
            THEN RAISE_APPLICATION_ERROR(-20108, '등록되지 않은 개설과정 코드입니다.');
         WHEN GRADE_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20207, '성적이 부여된 과목은 삭제할 수 없습니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
    
END;

---------------------
-- 트리거
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


-- TBL_STUDENT(학생) 테이블 ----------------------------------------------------

--학생 등록(INSERT)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_STU_ID      IN TBL_STUDENT.STU_ID%TYPE                 
, V_STU_NAME    IN TBL_STUDENT.STU_NAME%TYPE               
, V_STU_SSN     IN TBL_STUDENT.STU_SSN%TYPE
, V_STU_EMAIL   IN TBL_STUDENT.STU_EMAIL%TYPE
, V_STU_PHONE   IN TBL_STUDENT.STU_PHONE%TYPE
)
IS  
    V_STU_PW    TBL_STUDENT.STU_PW%TYPE;
    
BEGIN
    -- 학생 비밀번호 주민번호 뒷자리 설정
    V_STU_PW := SUBSTR(V_STU_SSN, 8);
    
     -- 데이터 INSERT
    INSERT INTO TBL_STUDENT(STU_ID, STU_NAME, STU_PW, STU_SSN, STU_EMAIL, STU_PHONE) 
    VALUES(V_STU_ID, V_STU_NAME, V_STU_PW, V_STU_SSN, V_STU_EMAIL, V_STU_PHONE);
     
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20008, '이미 등록된 아이디 또는 주민등록번호입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
        
    COMMIT;
    
END;

-- 학생 수정 PRC_STUDENT_UPDATE
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_STU_ID            IN TBL_STUDENT.STU_ID%TYPE
, V_STU_PW            IN TBL_STUDENT.STU_PW%TYPE
, V_STU_NAME          IN TBL_STUDENT.STU_NAME%TYPE
, V_STU_SSN           IN TBL_STUDENT.STU_SSN%TYPE
, V_STU_EMAIL         IN TBL_STUDENT.STU_EMAIL%TYPE
, V_STU_PHONE         IN TBL_STUDENT.STU_PHONE%TYPE
)
IS
    V_CHECK_ID      TBL_STUDENT.STU_ID%TYPE;
 
BEGIN
    -- 등록되어 있는 정보인지 검색(없을시 오류 발생)
    SELECT STU_ID INTO V_CHECK_ID
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    UPDATE TBL_STUDENT
    SET STU_NAME = V_STU_NAME
       ,STU_PW = V_STU_PW
       ,STU_EMAIL = V_STU_EMAIL
       ,STU_PHONE = V_STU_PHONE
    WHERE STU_ID = V_STU_ID;
       
    
   -- 예외처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '등록되지 않은 아이디입니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;


-- 학생 삭제 PRC_STUDENT_DELETE
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
(
    V_STU_ID    IN TBL_STUDENT.STU_ID%TYPE
)
IS
    V_CHECK     TBL_STUDENT.STU_ID%TYPE;
    V_COUNT     NUMBER;
    
    ALREADY_USE EXCEPTION;

BEGIN
    SELECT STU_ID INTO V_CHECK
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    SELECT COUNT(SIGN_CODE) INTO V_COUNT
    FROM TBL_SIGN
    WHERE STU_ID = V_STU_ID;
    
    IF (V_COUNT != 0)
        THEN RAISE ALREADY_USE;
    END IF;
    
    DELETE
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID; 
    
    -- 예외처리
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '등록되지 않은 아이디입니다.');
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR(-20208, '이미 수강신청을 한 학생입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
            
        COMMIT;
END;


-- 학생 삭제2 PRC_STUDENT_DELETE_1 (트리거) 
-- 학생 삭제 트리거
--> 학생에서 DELETE가 실행됐을 때 
--> 수강신청 테이블에서도 학생 삭제
CREATE OR REPLACE TRIGGER TRG_STUDENT_DELETE
    BEFORE
    DELETE ON TBL_STUDENT
    FOR EACH ROW
BEGIN
    DELETE
    FROM TBL_SIGN
    WHERE STU_ID = :OLD.STU_ID;
END;


-- TBL_REASON(탈락사유) 테이블 -------------------------------------------------

--데이터 INSERT
CREATE OR REPLACE PROCEDURE PRC_REASON_INSERT
( 
    V_REASON_MEMO IN TBL_REASON.REASON_MEMO%TYPE
)
IS
    CHECK_REASON_MEMO   TBL_REASON.REASON_MEMO%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 이미 등록된 탈락 사유인지 확인
    SELECT NVL(
                ( SELECT REASON_MEMO 
                  FROM TBL_REASON
                  WHERE REASON_MEMO = V_REASON_MEMO) , '0') INTO CHECK_REASON_MEMO  
    FROM DUAL;
    
    IF (CHECK_REASON_MEMO != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    INSERT INTO TBL_REASON(REASON_CODE, REASON_MEMO)
    VALUES(TBL_REASON_SEQ.NEXTVAL, V_REASON_MEMO);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009, '이미 등록된 탈락사유입니다.');                 -- 이미 등록된 탈락 사유라면 데이터 중복 에러
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- UPDATE
CREATE OR REPLACE PROCEDURE PRC_REASON_UPDATE
(
     V_REASON_CODE   IN TBL_REASON.REASON_CODE%TYPE
,    V_REASON_MEMO   IN TBL_REASON.REASON_MEMO%TYPE
)
IS
    CHECK_REASON_MEMO   TBL_REASON.REASON_MEMO%TYPE;
    CHECK_REASON_CODE   TBL_REASON.REASON_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_ERROR       EXCEPTION;
    
BEGIN
    -- TBL_REASON 테이블에서 사용자에게 입력받은 V_REASON_MEMO 와 값은 값이 있다면
    -- CHECK_REASON_MEMO 변수에 담아라
    SELECT NVL (
                (  SELECT REASON_MEMO 
                    FROM TBL_REASON
                    WHERE REASON_MEMO = V_REASON_MEMO  ), '0') INTO CHECK_REASON_MEMO
    FROM DUAL;
    
    -- TBL_REASON 테이블에서 사용자가 입력한 탈락사유 코드와 같은 값을 CHECK_REASON_CODE 변수에 담아라
    SELECT NVL(
                 (  SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE  ), '0') INTO CHECK_REASON_CODE
    FROM DUAL;
    
    -- CHECK_REASON_MEMO 값에 담긴 값이 NULL 이 아니라면 데이터 중복 에러
    IF(CHECK_REASON_MEMO != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- TBL_REASON 테이블에 사용자가 입력한 탈락사유코드가 없다면
    -- 입력한 값이 존재하지 않는다는 에러('데이터 없음')
    IF(CHECK_REASON_CODE = '0')
        THEN RAISE NO_DATA_ERROR;
    END IF;

    UPDATE TBL_REASON 
    SET REASON_MEMO = V_REASON_MEMO
    WHERE REASON_CODE = V_REASON_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009, '이미 등록된 탈락사유입니다.');                  -- 입력한 탈락 사유가 이미 존재하면 데이터 중복 에러
                ROLLBACK;
        WHEN NO_DATA_ERROR                      
            THEN RAISE_APPLICATION_ERROR(-20110, '등록되지 않은 탈락사유코드입니다.');             -- 입력한 탈락사유코드가 존재하지 않는 경우 에러('데이터 없음')
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
        
        COMMIT;
END;


-- DELETE
CREATE OR REPLACE PROCEDURE PRC_REASON_DELETE
(
    V_REASON_CODE   IN TBL_REASON.REASON_CODE%TYPE
)
IS
    CHECK_REASON_CODE   TBL_REASON.REASON_CODE%TYPE;
    CHECK_FAIL_CODE     TBL_FAIL.FAIL_CODE%TYPE;
    
    USE_DATA_ERROR   EXCEPTION;
    NO_DATA_ERROR   EXCEPTION;
BEGIN
    
    SELECT NVL(
                (   SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE           ), '0') INTO CHECK_REASON_CODE
    FROM DUAL;
    
    -- TBL_REASON 테이블에 사용자가 입력한 탈락사유코드가 없을 때(NULL 값)
    -- 데이터 없음 에러
    IF(CHECK_REASON_CODE = '0')
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    -- 사용자가 입력한 탈락사유코드 값이 중도탈락테이블에 있는 경우 CHECK_FAIL_CODE 변수에 값 담기
    SELECT NVL(
                 (  SELECT FAIL_CODE 
                    FROM TBL_FAIL
                    WHERE FAIL_CODE = V_REASON_CODE     ), '0') INTO CHECK_FAIL_CODE
    FROM DUAL;
    
    -- CHECK_FAIL_CODE 변수값이 NULL 이 아닌 경우 
    -- 중도탈락테이블에 값이 있으므로 탈락사유테이블에서 삭제 불가 에러(사용중인 데이터)
    IF(CHECK_FAIL_CODE != '0')
        THEN RAISE USE_DATA_ERROR;
    END IF;
    
    DELETE
    FROM TBL_REASON
    WHERE REASON_CODE = V_REASON_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20110, '등록되지 않은 탈락사유코드입니다.');   --사용자가 입력한 탈락사유코드가 없을 때 에러
                ROLLBACK;
        WHEN USE_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20209, '이미 이용 중인 탈락사유코드입니다.');                           -- 중도탈락테이블에 값이 있으므로 탈락사유테이블에서 삭제 불가 에러(사용중인 데이터)
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_SIGN(수강신청) 테이블 ---------------------------------------------------

-- INSERT 프로시저 생성
CREATE OR REPLACE PROCEDURE PRC_SIGN_INSERT
( 
    V_STU_ID         IN TBL_SIGN.STU_ID%TYPE
,   V_OCOURSE_CODE   IN TBL_SIGN.OCOURSE_CODE%TYPE
)
IS
    -- 학생테이블, 개설과목테이블 내에서 사용자가 입력한 데이터 존재 여부 확인 변수
    CHECK_STU_ID            TBL_STUDENT.STU_ID%TYPE;
    CHECK_OCOUSE_CODE       TBL_OCOURSE.OCOURSE_CODE%TYPE;   
    
    -- 수강신청 테이블 내에서 데이터 중복 확인 변수
    CK_SIGN_STU_ID          TBL_SIGN.STU_ID%TYPE;
    
    -- 사용자가 입력한 개설과정코드의 시작일을 담을 변수
    CK_OCOURSE_START_DATE    TBL_OCOURSE.START_DATE%TYPE;

    USER_DEFINE_ERROR    EXCEPTION;   -- 데이터 중복 에러
    NO_DATA_ERROR1       EXCEPTION;   -- 데이터 없음 에러(학생아이디)
    NO_DATA_ERROR2       EXCEPTION;   -- 데이터 없음 에러(개설과정코드)
    TIME_OVER_ERROR      EXCEPTION;   -- 기한 종료 에러
BEGIN
    
    -- 입력한 학생이 있는지 확인
    SELECT NVL(
                (   SELECT STU_ID 
                    FROM TBL_STUDENT
                    WHERE STU_ID = V_STU_ID            ), '0') INTO CHECK_STU_ID
    FROM DUAL;
    
    -- 입력한 개설과목이 있는지 확인
    SELECT NVL(
                 (  SELECT OCOURSE_CODE 
                    FROM TBL_OCOURSE
                    WHERE OCOURSE_CODE = V_OCOURSE_CODE ), '0') INTO CHECK_OCOUSE_CODE
    FROM DUAL;
    
    -- 입력한 학생아이디가 존재하지 않는 데이터일 경우 에러(데이터 없음) 
    IF(CHECK_STU_ID = '0')
        THEN RAISE NO_DATA_ERROR1;
    END IF;
    
    -- 입력한 개설과정코드가 존재하지 않는 데이터일 경우 에러(데이터 없음) 
    IF(CHECK_OCOUSE_CODE = '0')
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- 사용자가 입력한 과정의 시작일을 CK_OCOURSE_START_DATE 변수에 담는다
    SELECT START_DATE INTO CK_OCOURSE_START_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    -- 수강신청 가능한지 확인(SYSDATE 가 개설과정의 시작 보다 이전인지 확인)
    -- SYSDATE < 개설과정테이블의 과정시작일 이어야 수강신청 가능
    -- SYSDATE > 개설과정테이블의 과정시작일 이면 수강신청 불가 에러
    IF(TO_DATE(SYSDATE, 'YYYY-MM-DD') > CK_OCOURSE_START_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    -- 사용자가 입력한 개설과정코드로 수강신청된 내역있는지 조회
    -- 조회 된 내역 중 사용자가 입력한 것과 같은 학생 아이디가 있다면 데이터 중복 에러
    SELECT NVL(
                 (  SELECT SIGN_CODE
                    FROM TBL_SIGN
                    WHERE OCOURSE_CODE = V_OCOURSE_CODE
                      AND STU_ID = V_STU_ID), '0') INTO CK_SIGN_STU_ID
    FROM DUAL;
    
    -- 입력한 (학생아이디, 개설과정코드) 가 이미 존재하는 데이터일 경우 데이터 중복 에러
    IF(CK_SIGN_STU_ID != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
   
    INSERT INTO TBL_SIGN(SIGN_CODE, STU_ID, OCOURSE_CODE)
    VALUES(TBL_SIGN_SEQ.NEXTVAL, V_STU_ID, V_OCOURSE_CODE);
    
    EXCEPTION
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20102, '등록되지 않은 아이디입니다.');       -- 입력한 학생아이디가 존재하지 않는 데이터일 경우 에러(데이터 없음)
                ROLLBACK;
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20106, '등록되지 않은 과정코드입니다.');         -- 입력한 개설과정코드가 존재하지 않는 데이터일 경우 에러(데이터 없음)
                ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20305, '수강신청 기간이 아닙니다.');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20010, '이미 등록한 과정입니다.');                 -- 입력한 (학생아이디, 개설과정코드) 가 이미 존재하는 데이터일 경우 데이터 중복 에러
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;


-- UPDATE
CREATE OR REPLACE PROCEDURE PRC_SIGN_UPDATE
(
    V_SIGN_CODE     IN  TBL_SIGN.SIGN_CODE%TYPE
,   V_STU_ID        IN  TBL_SIGN.STU_ID%TYPE
,   V_OCOURSE_CODE  IN  TBL_SIGN.OCOURSE_CODE%TYPE
)
IS
    -- 사용자가 입력한 수강신청 코드가 존재하는지 확인변수
    CHECK_SIGN_CODE         TBL_SIGN.SIGN_CODE%TYPE;
    
    -- 사용자가 입력한 학생 아이디가 존재하는지 확인변수
    CHECK_STU_ID            TBL_SIGN.STU_ID%TYPE;
    
    -- 사용자가 입력한 개설과정코드가 존재하는지 확인변수
    CHECK_OCOURSE_CODE      TBL_OCOURSE.OCOURSE_CODE%TYPE;
    
    -- 사용자가 입력한 과정의 시작일이 신청가능 기간인지 확인변수
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    
    -- 사용자가 입력한 과정과 묶인 학생 아이디가 존재하는지 확인변수
    CK_STU_OCOURSE           TBL_OCOURSE.OCOURSE_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_ERROR1       EXCEPTION;         -- 수강신청코드 없음
    NO_DATA_ERROR2       EXCEPTION;         -- 학생아이디 없음
    NO_DATA_ERROR3       EXCEPTION;         -- 개설과정코드 없음
    TIME_OVER_ERROR     EXCEPTION;
BEGIN
    SELECT NVL(
                 (  SELECT SIGN_CODE 
                    FROM TBL_SIGN
                    WHERE SIGN_CODE = V_SIGN_CODE               ), 0) INTO CHECK_SIGN_CODE
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT STU_ID
                    FROM TBL_STUDENT
                    WHERE STU_ID = V_STU_ID                     ), '0') INTO CHECK_STU_ID
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT OCOURSE_CODE 
                    FROM TBL_OCOURSE
                    WHERE OCOURSE_CODE = V_OCOURSE_CODE         ), 0) INTO CHECK_OCOURSE_CODE
    FROM DUAL;
    
    -- 입력한 수강신청 코드 없을 시 데이터 없음 에러
    IF(CHECK_SIGN_CODE = 0)         
        THEN RAISE NO_DATA_ERROR1;
    END IF;
    
    -- 입력한 학생 아이디 없을 시 데이터 없음 에러
    IF(CHECK_STU_ID = '0')
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- 입력한 개설과정 코드 없을 시 데이터 없음 에러
    IF(CHECK_OCOURSE_CODE = 0)
        THEN RAISE NO_DATA_ERROR3;
    END IF;
    
    SELECT START_DATE INTO CK_OCOURSE_START_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    -- 입력한 개설과정 코드의 시작일이 이미 시작된 경우 신청기간지났다는 에러
    IF(SYSDATE > CK_OCOURSE_START_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    SELECT COUNT(*) INTO CK_STU_OCOURSE
    FROM TBL_SIGN
    WHERE STU_ID = V_STU_ID AND OCOURSE_CODE = V_OCOURSE_CODE;
    
    -- 변경 원하는 과정으로 이미 수강신청한 내역이 있을 경우 데이터 중복 에러
    IF(CK_STU_OCOURSE > 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_SIGN
    SET OCOURSE_CODE = V_OCOURSE_CODE, STU_ID = V_STU_ID
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20010, '이미 등록한 과정입니다.');                           -- 변경 원하는 과정으로 이미 수강신청한 내역이 있을 경우 데이터 중복 에러      
                ROLLBACK;
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20111, '등록되지 않은 수강신청코드입니다.');             -- 입력한 수강신청 코드 없을 시 데이터 없음 에러
                ROLLBACK;  
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20102, '등록되지 않은 아이디입니다.');               -- 입력한 학생 아이디 없을 시 데이터 없음 에러
                ROLLBACK;
        WHEN NO_DATA_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20106, '등록되지 않은 과정코드입니다.');                 -- 입력한 개설과정 코드 없을 시 데이터 없음 에러
                ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20305, '수강신청 기간이 아닙니다.');
                ROLLBACK;        
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT; 

END;


-- DELETE
CREATE OR REPLACE PROCEDURE PRC_SIGN_DELETE
(
    V_SIGN_CODE IN TBL_SIGN.SIGN_CODE%TYPE
)
IS
    CHECK_SIGN_CODE         TBL_SIGN.SIGN_CODE%TYPE;
    CHECK_OCOURSE_CODE      TBL_SIGN.OCOURSE_CODE%TYPE;
    CHECK_GRADE_CODE        TBL_GRADE.GRADE_CODE%TYPE;
    
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    
    NO_DATA_ERROR           EXCEPTION;
    USER_DEFINE_ERROR       EXCEPTION;
    TIME_OVER_ERROR         EXCEPTION;
BEGIN
    SELECT NVL(
                (   SELECT SIGN_CODE 
                    FROM TBL_SIGN
                    WHERE SIGN_CODE = V_SIGN_CODE),         0) INTO CHECK_SIGN_CODE
    FROM DUAL;

    -- 사용자가 입력한 수강신청 코드가 없을 때 데이터 없음 에러
    IF(CHECK_SIGN_CODE = 0)
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    -- 성적이 존재하는 수강신청코드인지 확인
    SELECT NVL( (SELECT MAX(TG.GRADE_CODE)
                  FROM TBL_GRADE TG
                       JOIN (SELECT SIGN_CODE
                             FROM TBL_SIGN
                             WHERE SIGN_CODE = V_SIGN_CODE) OC
                             ON TG.SIGN_CODE = OC.SIGN_CODE) , 0) INTO CHECK_GRADE_CODE
    FROM DUAL;
    
    -- 성적이 입력된 수강신청코드의 경우는 예외 발생
    IF (CHECK_GRADE_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    -- 사용자가 입력한 수강신청코드에 해당하는 개설과정코드 값을 CHECK_OCOURSE_CODE 에 담는다
    SELECT OCOURSE_CODE INTO CHECK_OCOURSE_CODE
    FROM TBL_SIGN
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    SELECT START_DATE INTO CK_OCOURSE_START_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = CHECK_OCOURSE_CODE;
    
    -- 과정이 이미 시작한 경우 삭제 불가 에러(과정이 이미 시작했습니다)
    IF(SYSDATE > CK_OCOURSE_START_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    DELETE 
    FROM TBL_SIGN
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20111, '등록되지 않은 수강신청코드입니다.');    
                ROLLBACK;
         WHEN USER_DEFINE_ERROR
            THEN  RAISE_APPLICATION_ERROR(-20210, '성적이 부여된 수강신청내역은 삭제할 수 없습니다.'); 
        ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20305, '수강신청 기간이 아닙니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;

-- TBL_SIGN(수강신청) 삭제 트리거 
--=> 성적테이블에 데이터 없는경우 중도탈락테이블 함께 삭제
CREATE OR REPLACE TRIGGER TRG_TBL_SIGN
    BEFORE
    DELETE ON TBL_SIGN
    FOR EACH ROW
BEGIN
    
    DELETE
    FROM TBL_FAIL
    WHERE SIGN_CODE = :OLD.SIGN_CODE;
    
END;


-- TBL_FAIL(중도탈락) 테이블 ---------------------------------------------------

-- INSERT
CREATE OR REPLACE PROCEDURE PRC_FAIL_INSERT
(   
    V_FAIL_DATE       IN TBL_FAIL.FAIL_DATE%TYPE
,   V_SIGN_CODE       IN TBL_FAIL.SIGN_CODE%TYPE
,   V_REASON_CODE     IN TBL_FAIL.REASON_CODE%TYPE
)
IS
    -- 데이터 중복 여부 체크하기 위한 확인변수(탈락일자, 수강신청코드, 탈락사유 코드)
    CHECK_FAIL_DATE    TBL_FAIL.FAIL_DATE%TYPE;
    CHECK_SIGN_CODE    TBL_SIGN.SIGN_CODE%TYPE;
    CHECK_REASON_CODE  TBL_REASON.REASON_CODE%TYPE;
    
    CK_SIGN_REASON     TBL_SIGN.SIGN_CODE%TYPE;
    
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    CK_OCOURSE_END_DATE     TBL_OCOURSE.END_DATE%TYPE;
    
    NO_DATA_ERROR1       EXCEPTION;
    NO_DATA_ERROR2       EXCEPTION;
    USER_DEFINE_ERROR   EXCEPTION;
    TIME_OVER_ERROR     EXCEPTION;
BEGIN
     SELECT NVL(
                (    SELECT SIGN_CODE 
                     FROM TBL_SIGN
                     WHERE SIGN_CODE = V_SIGN_CODE      ), 0) INTO CHECK_SIGN_CODE
     FROM DUAL;

    -- 입력한 수강신청코드가 없는 코드인 경우 에러
    IF(CHECK_SIGN_CODE = 0)
        THEN RAISE NO_DATA_ERROR1;
    END IF;

    SELECT NVL(
                 (  SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE    ), 0) INTO CHECK_REASON_CODE
    FROM DUAL;

    -- 입력한 탈락사유코드가 없는 코드인 경우 에러
    IF(CHECK_REASON_CODE = 0)
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- 사용자가 입력한 수강신청코드로 등록된 탈락사유코드가 존재하면 에러(데이터 중복) 
    SELECT COUNT(FAIL_CODE) INTO CK_SIGN_REASON
    FROM TBL_FAIL
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    IF(CK_SIGN_REASON > 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 입력한 수강신청코드에 해당되는 과정의 시작일과 종료일을 변수에 담기
    SELECT START_DATE, END_DATE INTO CK_OCOURSE_START_DATE, CK_OCOURSE_END_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = (
                            SELECT OCOURSE_CODE
                            FROM TBL_SIGN
                            WHERE SIGN_CODE = V_SIGN_CODE
                         );
    
    -- 입력한 탈락일자가 과정 기간 안에 없으면 에러
    -- 입력한 탈락일자 < 과정 시작일 에러(과정 시작 전)
    -- 입력한 탈락일자E > 과정 종료일 에러(과정 종료 후)
    -- BETWEEN A AND B
    IF(V_FAIL_DATE NOT BETWEEN CK_OCOURSE_START_DATE AND CK_OCOURSE_END_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;

    INSERT INTO TBL_FAIL(FAIL_CODE, FAIL_DATE, SIGN_CODE, REASON_CODE)
    VALUES(TBL_FAIL_SEQ.NEXTVAL, TO_DATE(V_FAIL_DATE, 'YYYY-MM-DD'), V_SIGN_CODE, V_REASON_CODE);

    EXCEPTION
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20111, '등록되지 않은 수강신청코드입니다.');                 -- 입력한 수강신청코드 없는 코드인 경우 에러
                ROLLBACK;
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20110, '등록되지 않은 탈락사유코드입니다.');                 -- 입력한 탈락사유코드가 없는 코드인 경우 에러
                ROLLBACK;
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20011, '이미 등록된 내용입니다.');                            -- 수강신청코드, 탈락사유 코드 중복에러
                ROLLBACK;        
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20306, '탈락일자가 과정 기간을 벗어났습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- UPDATE
CREATE OR REPLACE PROCEDURE PRC_FAIL_UPDATE
(
    V_FAIL_CODE     IN TBL_FAIL.FAIL_CODE%TYPE
,   V_FAIL_DATE     IN TBL_FAIL.FAIL_DATE%TYPE
,   V_SIGN_CODE     IN TBL_SIGN.SIGN_CODE%TYPE
,   V_REASON_CODE   IN TBL_REASON.REASON_CODE%TYPE
)
IS
    CHECK_FAIL_CODE         TBL_FAIL.FAIL_CODE%TYPE;
    CHECK_SIGN_CODE         TBL_SIGN.SIGN_CODE%TYPE;
    CHECK_REASON_CODE       TBL_REASON.REASON_CODE%TYPE;
    CK_FAIL_SIGN_REASON     TBL_SIGN.SIGN_CODE%TYPE;
    
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    CK_OCOURSE_END_DATE     TBL_OCOURSE.END_DATE%TYPE;
    
    NO_DATA_ERROR1       EXCEPTION;
    NO_DATA_ERROR2       EXCEPTION;
    NO_DATA_ERROR3       EXCEPTION;
    USER_DEFINE_ERROR   EXCEPTION;
    TIME_OVER_ERROR     EXCEPTION;
BEGIN
    SELECT NVL(
                 (  SELECT FAIL_CODE 
                    FROM TBL_FAIL
                    WHERE FAIL_CODE = V_FAIL_CODE           ), 0) INTO CHECK_FAIL_CODE
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT SIGN_CODE 
                    FROM TBL_SIGN
                    WHERE SIGN_CODE = V_SIGN_CODE           ), 0) INTO CHECK_SIGN_CODE
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE       ), 0) INTO CHECK_REASON_CODE
    FROM DUAL;
    
    -- 입력한 중도탈락코드가 없는 경우 데이터 없음 에러
    IF(CHECK_FAIL_CODE = 0)
        THEN RAISE NO_DATA_ERROR1;
    END IF;
    
    -- 입력한 수강신청코드가 없는 경우 데이터 없음 에러
    IF(CHECK_SIGN_CODE = 0)
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- 입력한 탈락사유코드 가 없는 경우 데이터 없음 에러
    IF(CHECK_REASON_CODE = 0)
        THEN RAISE NO_DATA_ERROR3;
    END IF;
    
    
    -- 사용자가 입력한 수강신청코드에 해당하는 탈락사유코드 존재할 경우 에러 발생(데이터 중복에러)
    SELECT COUNT(FAIL_CODE) INTO CK_FAIL_SIGN_REASON
    FROM TBL_FAIL
    WHERE SIGN_CODE = V_SIGN_CODE;

    IF(CK_FAIL_SIGN_REASON > 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    SELECT START_DATE, END_DATE INTO CK_OCOURSE_START_DATE, CK_OCOURSE_END_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = (
                            SELECT OCOURSE_CODE
                            FROM TBL_SIGN
                            WHERE SIGN_CODE = V_SIGN_CODE
                         );
    
    -- 입력한 탈락일자가 해당 과정기간 안에 벗어나는 경우 에러
    IF(V_FAIL_DATE NOT BETWEEN CK_OCOURSE_START_DATE AND CK_OCOURSE_END_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    UPDATE TBL_FAIL
    SET FAIL_DATE = V_FAIL_DATE, SIGN_CODE = V_SIGN_CODE, REASON_CODE = V_REASON_CODE
    WHERE FAIL_CODE = V_FAIL_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR( -20112, '등록되지 않은 중도탈락코드입니다.');                 -- 입력한 중도탈락코드가 없는 경우 데이터 없음 에러
                ROLLBACK;
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20111, '등록되지 않은 수강신청코드입니다.');                 -- 입력한 수강신청코드가 없는 경우 데이터 없음 에러
                ROLLBACK;
        WHEN NO_DATA_ERROR3
            THEN RAISE_APPLICATION_ERROR( -20110, '등록되지 않은 탈락사유코드입니다.');                 -- 입력한 탈락사유코드 가 없는 경우 데이터 없음 에러
                ROLLBACK;        
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR( -20011, '이미 등록된 내용입니다.');
                ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20306, '탈락일자가 과정 기간을 벗어났습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- DELETE
CREATE OR REPLACE PROCEDURE PRC_FAIL_DELETE
(
    V_FAIL_CODE IN TBL_FAIL.FAIL_CODE%TYPE
)
IS
    CHECK_FAIL_CODE TBL_FAIL.FAIL_CODE%TYPE;
    
    NO_DATA_ERROR  EXCEPTION;
BEGIN
    SELECT NVL(
                 (  SELECT FAIL_CODE 
                    FROM TBL_FAIL
                    WHERE FAIL_CODE = V_FAIL_CODE       ), 0) INTO CHECK_FAIL_CODE
    FROM DUAL;
    
    -- 입력한 중도탈락 코드 없는 경우 데이터 없음 에러
    IF(CHECK_FAIL_CODE = 0)
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    DELETE
    FROM TBL_FAIL
    WHERE FAIL_CODE = V_FAIL_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20112, '등록되지 않은 중도탈락코드입니다.');                 -- 입력한 중도탈락 코드 없는 경우 데이터 없음 에러
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_POINT(배점) 테이블 ------------------------------------------------------

--배점{개설과목[개설과정(강의실, 과정), 강의가능(과목, 교수)]}
----------------------
--PRC_POINT_INSERT 
--EXEC PRC_POINT_INSERT(V_POINT_ATTEND, V_POINT_PRACTICE, V_POINT_WRITE, V_OCLASS_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20401, '유효하지 않은 배점입니다.');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20402, '총 배점은 100이 되어야 합니다.');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20113, '등록되지 않은 개설과목코드입니다.');
        WHEN POINT_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20012, '이미 배점이 부여된 과목입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
    
END;


----------------------
--PRC_POINT_UPDATE
--EXEC PRC_POINT_UPDATE(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE)

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
    IF (V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 0 AND
        V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 100)
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
            THEN RAISE_APPLICATION_ERROR(-20401, '유효하지 않은 배점입니다.');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20402, '총 배점은 100이 되어야 합니다.');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20113, '등록되지 않은 개설과목코드입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


-------------------
--PRC_POINT_DELETE  
--EXEC PRC_POINT_DELETE(POINT_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20113, '등록되지 않은 개설과목코드입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


-- TBL_GRADE(성적) 테이블 ------------------------------------------------------

-- 성적 입력(INSERT)
CREATE OR REPLACE PROCEDURE PRC_GRADE_INSERT
(
    V_GRADE_ATTEND      IN TBL_GRADE.GRADE_ATTEND%TYPE      -- 출결성적
   ,V_GRADE_WRITE       IN TBL_GRADE.GRADE_WRITE%TYPE       -- 필기성적
   ,V_GRADE_PRACTICE    IN TBL_GRADE.GRADE_PRACTICE%TYPE    -- 실기성적
   ,V_OCLASS_CODE       IN TBL_GRADE.OCLASS_CODE%TYPE       -- 개설과목코드 
   ,V_SIGN_CODE         IN TBL_GRADE.SIGN_CODE%TYPE         -- 수강신청코드
)
IS
    V_CHECK1        TBL_OCLASS.OCLASS_CODE%TYPE;    
    V_CHECK2        NUMBER;
    V_END_DATE      TBL_OCLASS.END_DATE%TYPE;
    V_START_DATE    TBL_OCLASS.START_DATE%TYPE;
    V_CHECK_GRADE   NUMBER;
    
    V_FAIL_DATE     TBL_FAIL.FAIL_DATE%TYPE;
    
    GRADE_DATE_ERROR    EXCEPTION;          -- 개설과목 진행중에 성적입력X 에러
    NO_DATA_ERROR       EXCEPTION;          -- 데이터 없음 에러 
    ALREADY_DATA_ERROR  EXCEPTION;          -- 이미 성적 부여가 완료된 과목 에러
    UNDER_ZERO_ERROR    EXCEPTION;          -- 출결, 실기, 필기 점수를 입력할때 음수면 에러
    NOT_END_ERROR       EXCEPTION;          -- 수료하지 않았을 경우 에러

BEGIN
    -- 이미 개설된 과목 코드인지 확인
    SELECT OCLASS_CODE INTO V_CHECK1
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    
    -- 수강신청 코드가 유효한지..
    SELECT COUNT(SIGN_CODE) INTO V_CHECK2
    FROM TBL_SIGN
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    IF (V_CHECK2 = 0)
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    -- 과목 진행 중간에 성적 입력 불가 
    SELECT START_DATE, END_DATE INTO V_START_DATE, V_END_DATE 
    FROM TBL_OCLASS
    WHERE OCLASS_CODE =  V_OCLASS_CODE;
    
    IF (SYSDATE BETWEEN V_END_DATE AND V_START_DATE)
        THEN RAISE GRADE_DATE_ERROR;
    END IF;
   
   -- 이미 성적 부여가 완료된 과목입니다
    SELECT COUNT(GRADE_CODE) INTO V_CHECK_GRADE
    FROM TBL_GRADE
    WHERE SIGN_CODE = V_SIGN_CODE AND OCLASS_CODE = V_OCLASS_CODE;
    
    IF(V_CHECK_GRADE != 0)
        THEN RAISE ALREADY_DATA_ERROR;
    END IF;
    
    -- 출결, 실기, 필기 점수를 입력할때 음수면 에러 발생 
    IF(V_GRADE_ATTEND < 0 OR V_GRADE_PRACTICE < 0 OR V_GRADE_WRITE < 0) 
        THEN RAISE UNDER_ZERO_ERROR; 
    END IF;
    
    -- 중도탈락 테이블에 있는 수강신청 코드의 경우, 과목 종료일이 탈락일보다 뒤에 있을 경우 성적 입력 불가
    -- 입력받은 개설과목코드를 기준으로 종료일 검색
    SELECT END_DATE INTO V_END_DATE
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    
    -- 입력받은 수강신청코드를 기준으로 탈락일 검색
    SELECT NVL( ( SELECT FAIL_DATE
                  FROM TBL_FAIL
                  WHERE SIGN_CODE = V_SIGN_CODE ), TO_DATE('0001-01-01', 'YYYY-MM-DD') ) INTO V_FAIL_DATE
    FROM DUAL;

    -- 탈락일과 종료일 비교하여 조건에 맞으면 에러 발생
    IF (V_FAIL_DATE != TO_DATE('0001-01-01', 'YYYY-MM-DD'))
        THEN IF (V_FAIL_DATE < V_END_DATE)
                THEN RAISE NOT_END_ERROR;
             END IF;
    END IF;
    
    INSERT INTO TBL_GRADE(GRADE_CODE, GRADE_ATTEND, GRADE_PRACTICE, GRADE_WRITE, OCLASS_CODE, SIGN_CODE)
    VALUES(TBL_GRADE_SEQ.NEXTVAL, V_GRADE_ATTEND, V_GRADE_PRACTICE, V_GRADE_WRITE, V_OCLASS_CODE, V_SIGN_CODE);
    
    -- 출실필 점수가 50점 미만이면 중도탈락 테이블에 데이터 추가
    IF (V_GRADE_ATTEND<50 OR V_GRADE_WRITE<50 OR V_GRADE_PRACTICE<50)
        THEN INSERT INTO TBL_FAIL(FAIL_CODE, FAIL_DATE, SIGN_CODE, REASON_CODE)
             VALUES(TBL_FAIL_SEQ.NEXTVAL, TO_DATE(SYSDATE, 'YYYY-MM-DD'), V_SIGN_CODE, 6);
    END IF;
    
    -- 예외 처리
    EXCEPTION 
    
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20113, '등록되지 않은 개설과목코드입니다.');    
        WHEN NO_DATA_ERROR       
            THEN RAISE_APPLICATION_ERROR(-20111, '등록되지 않은 수강신청코드입니다.');       
        WHEN GRADE_DATE_ERROR   
            THEN RAISE_APPLICATION_ERROR(-20307, '성적입력기간이 아닙니다.');        
        WHEN ALREADY_DATA_ERROR   
            THEN RAISE_APPLICATION_ERROR(-20013, '이미 성적이 입력된 데이터입니다.');            
        WHEN UNDER_ZERO_ERROR
            THEN RAISE_APPLICATION_ERROR(-20403, '유효하지 않은 점수입니다.');
       WHEN NOT_END_ERROR
            THEN RAISE_APPLICATION_ERROR(-20308, '아직 수료하지 않은 과목입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
            
                      
END;


-- PRC_GRADE_UPDATE
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
(
    V_GRADE_CODE        IN TBL_GRADE.SIGN_CODE%TYPE         -- 성적코드
   ,V_GRADE_ATTEND      IN TBL_GRADE.GRADE_ATTEND%TYPE      -- 출결성적
   ,V_GRADE_WRITE       IN TBL_GRADE.GRADE_WRITE%TYPE       -- 필기성적
   ,V_GRADE_PRACTICE    IN TBL_GRADE.GRADE_PRACTICE%TYPE    -- 실기성적

)
IS
    V_CHECK     TBL_GRADE.GRADE_CODE%TYPE;

BEGIN
    
    SELECT GRADE_CODE INTO V_CHECK
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;

    -- 출결, 필기, 실기 업데이트
    UPDATE TBL_GRADE
    SET GRADE_ATTEND = V_GRADE_ATTEND, GRADE_WRITE = V_GRADE_WRITE, GRADE_PRACTICE = V_GRADE_PRACTICE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20114, '등록되지 않은 성적코드입니다.');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
            
        
END;


-- PRC_GRADE_DELETE       
CREATE OR REPLACE PROCEDURE PRC_GRADE_DELETE
(
    V_GRADE_CODE IN TBL_GRADE.GRADE_CODE%TYPE
)
IS
    V_CHECK     TBL_GRADE.GRADE_CODE%TYPE;
    
BEGIN
    -- 성적 코드 존재 여부 확인
    SELECT GRADE_CODE INTO V_CHECK
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    DELETE
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
     
    EXCEPTION 
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20114, '등록되지 않은 성적코드입니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
             
    COMMIT;
    
END;
















