---PRC_출고_DELETE()------------------------------------------------------------
SET SERVEROUTPUT ON;

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
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_출고수량        TBL_출고.출고수량%TYPE;
    V_출고번호확인    NUMBER := 1;
    
    --⑥ 예외처리
    NO_DATA_FOUND       EXCEPTION;    
BEGIN

    --⑦ 예외처리를 위한 출고번호 존재여부 파악
    SELECT COUNT(*) INTO V_출고번호확인
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    --⑧ 출고번호가 존재하는지 여부 체크, 없다면 예외 발생
    IF (V_출고번호확인 = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
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
    
    --⑩ 출고번호가 삭제되면 비워진 출고번호 자리를 뒷자리 숫자들이 채워주기 위함
    --   삭제된 출고번호보다 큰 숫자의 출고번호가 있다면 1씩 감소
    --   EX. 출고번호 1,2,3,4 가 있을 때,
    --       2번이 삭제되면 1,3,4가 남으므로,
    --       3,4번을 1씩 감소시켜 번호를 앞으로 당겨준다
    UPDATE TBL_출고
    SET 출고번호 = 출고번호 - 1
    WHERE 출고번호 > V_출고번호;
        
    --⑨ 예외처리
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '데이터를 찾을 수 없습니다');
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.