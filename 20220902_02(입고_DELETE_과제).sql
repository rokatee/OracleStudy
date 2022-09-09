---PRC_입고_DELETE()------------------------------------------------------------
SET SERVEROUTPUT ON;

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
    V_삭제할입고수량  TBL_입고.입고수량%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_입고번호확인    NUMBER := 1;
    
    --⑥ 예외처리
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_FOUND       EXCEPTION;
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
    
    -- 선언한 변수에 값 담아내기
    --④ 입고수량과 상품코드 파악
    SELECT 입고수량, 상품코드 INTO V_삭제할입고수량, V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    -- 재고수량 파악
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    --⑨ IF문 예외처리
    -- 삭제할 입고수량이 재고수량보다 크면 재고수량이 음수가 되므로 예외처리
--    IF (입고100개 → 재고100개, 이때 출고50개 
--         → 재고100-50=50개, 이때 입고 -100개 하면 
--         → 이미 재고50 이므로 50개가 부족해 입고 삭제 X)
--            THEN 에러발생;
--    END IF;
    IF (V_재고수량 - V_삭제할입고수량 < 0)    -- 음수일 경우는 출고가 된 상태
            THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --② 수행될 쿼리문 체크(DELETE → TBL_입고)
    DELETE
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    --⑤ 수행될 쿼리문 체크(UPDATE → TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_삭제할입고수량
    WHERE 상품코드 = V_상품코드;
    
    --⑪ 입고번호가 삭제되면 비워진 입고번호 자리를 뒷자리 숫자들이 채워주기 위함
    --   삭제된 입고번호보다 큰 숫자의 입고번호가 있다면 1씩 감소
    --   EX. 입고번호 1,2,3,4 가 있을 때,
    --       2번이 삭제되면 1,3,4가 남으므로,
    --       3,4번을 1씩 감소시켜 번호를 앞으로 당겨준다
    UPDATE TBL_입고
    SET 입고번호 = 입고번호 - 1
    WHERE 입고번호 > V_입고번호;
    
    --⑩ 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '데이터를 찾을 수 없습니다');
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR (-20002, '재고수량 부족');
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.