---PRC_입고_UPDATE()------------------------------------------------------------
SET SERVEROUTPUT ON;

/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
    입고된 수량 변경 (원래대로라면 입고번호 이후에 출고된 것들을 다 고려해야 함)
    입고수량 바뀌면 재고수량도 바뀐다.

실행 예)
EXEC PRC_입고_UPDATE(입고번호, 입고수량);

EXEC PRC_입고_UPDATE(1, 10);
*/
DESC TBL_입고;
DESC TBL_상품;

-- V_변경할입고수량 = V_입고수량
-- V_현재재고수량 = V_재고수량
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
(
  --① 매개변수 구성
  V_입고번호            IN TBL_입고.입고번호%TYPE
, V_변경할입고수량      IN TBL_입고.입고수량%TYPE    -- V_입고수량
)
IS
    --③ 필요한 변수 추가 선언
    V_현재재고수량    TBL_상품.재고수량%TYPE;        
    V_이전입고수량    TBL_입고.입고수량%TYPE;        -- 변경 전 현재입고수량
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_입고번호확인    NUMBER := 1;
    
    --⑥ 예외변수 추가
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_FOUND       EXCEPTION;
    LOWER_THAN_ZERO     EXCEPTION;
BEGIN
    --⑦ 예외처리를 위한 입고번호 존재여부 파악
    SELECT COUNT(*) INTO V_입고번호확인
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    --⑧ IF문 예외처리
    -- 입고번호가 존재하는지 여부 체크, 없다면 예외 발생
    IF (V_입고번호확인 = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    -- 입고번호에 음수 입력하면 예외 발생
    IF (V_변경할입고수량 < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    --④ 선언한 변수에 값 담아내기
    -- 상품코드와 현재입고수량 파악
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_이전입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    -- 위에서 얻어낸 상품코드를 활용하여 재고수량 파악
    SELECT 재고수량 INTO V_현재재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑨  IF문 예외처리
    --  출고가 이뤄진 시점에서 예외 발생
    --  이게 음수라면 출고가 이뤄진 것
    --  ----------------------------------
    IF ( (V_현재재고수량 - V_이전입고수량) + V_변경할입고수량 < 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --② 수행될 쿼리문 체크(UPDATE → TBL_입고)
    -- 입고수량을 변경하고자 하는 수로 덮기
    UPDATE TBL_입고
    SET 입고수량 = V_변경할입고수량
    WHERE 입고번호 = V_입고번호;
    
    --⑤ 수행될 쿼리문 체크(UPDATE → TBL_상품)
    UPDATE TBL_상품   
    SET 재고수량 = (V_현재재고수량 - V_이전입고수량) + V_변경할입고수량
    WHERE 상품코드 = V_상품코드;

    --⑩ 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '데이터를 찾을 수 없습니다');
        WHEN LOWER_THAN_ZERO
             THEN RAISE_APPLICATION_ERROR(-20003, '음수 입력 불가');
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR (-20002, '재고수량 부족');
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.