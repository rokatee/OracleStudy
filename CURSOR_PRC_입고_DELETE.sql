---CURSOR(커서) 작동여부 테스트-------------------------------------------------
SELECT *
FROM TBL_입고
ORDER BY 입고번호;

EXEC PRC_입고_DELETE(3);
--==>> 
/*
실패 : 입고수량 모두 출고상태로 변경되어 있어, 재고수량이 0이므로 입고정보 삭제 불가능

프로시저 호출은 가능하지만
IF문 조건에 의해 RETURN 되면서
조건에 맞는 데이터를 CURSOR(커서)로 띄워준다


출고번호   |   상품코드   |   출고일자   |   출고수량
   1             H001        2022-09-02        100
에 의해 삭제 불가

PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

---PRC_입고_DELETE() WITH CURSOR(커서)------------------------------------------
/*
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
  V_입고번호    IN TBL_입고.입고번호%TYPE
)
IS
    V_삭제할입고수량  TBL_입고.입고수량%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_입고일자        TBL_입고.입고일자%TYPE;
 
    V_입고번호확인    NUMBER := 1;
--    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_FOUND       EXCEPTION;
    
BEGIN
    
    SELECT COUNT(*) INTO V_입고번호확인
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    IF (V_입고번호확인 = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    SELECT 입고수량, 상품코드, 입고일자 INTO V_삭제할입고수량, V_상품코드, V_입고일자
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    -- 재고수량 파악
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF ( V_재고수량 - V_삭제할입고수량 < 0 )
        THEN
            DECLARE 
                -- 주요 변수 선언
                V_출고번호	TBL_출고.출고번호%TYPE;
                V_출고일자	TBL_출고.출고일자%TYPE;
                V_출고수량  TBL_출고.출고수량%TYPE;
            
                -- 커서 이용을 위한 커서변수 선언(커서정의)
                CURSOR CUR_출고_SELECT
                IS
                SELECT 출고번호, 상품코드, 출고일자, 출고수량
                FROM TBL_출고
                WHERE 상품코드 = V_상품코드
                  AND 출고일자 >= V_입고일자;
                  
            BEGIN
                DBMS_OUTPUT.PUT_LINE('출고번호   |   상품코드   |   출고일자   |   출고수량');
                
                OPEN CUR_출고_SELECT;
                
                LOOP
                    -- 한 행 한 행 받아다가 처리하는 행위 → fetch
                    FETCH CUR_출고_SELECT INTO V_출고번호, V_상품코드, V_출고일자, V_출고수량;
            
                    -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태
                    -- 즉, 커서 내부에서 더 이상의 데이터를 찾을 수 없는 상태
                    -- → 그만~!! 반복문 빠져나가기
                    EXIT WHEN CUR_출고_SELECT%NOTFOUND;
                    --출력
                    DBMS_OUTPUT.PUT_LINE('   '||V_출고번호||'             '||V_상품코드||
                                         '        '||V_출고일자||'        '||V_출고수량);
                END LOOP;
                
                DBMS_OUTPUT.PUT_LINE('에 의해 삭제 불가');
                
                --커서 클로즈
                CLOSE CUR_출고_SELECT;
                RETURN;
            END;
    END IF;
    
--    IF (V_재고수량 - V_삭제할입고수량 < 0)    -- 음수일 경우는 출고가 된 상태
--            THEN RAISE USER_DEFINE_ERROR;
--    END IF;
    
    DELETE
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;

    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_삭제할입고수량
    WHERE 상품코드 = V_상품코드;
    
    UPDATE TBL_입고
    SET 입고번호 = 입고번호 - 1
    WHERE 입고번호 > V_입고번호;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '데이터를 찾을 수 없습니다');
--        WHEN USER_DEFINE_ERROR
--            THEN RAISE_APPLICATION_ERROR (-20002, '재고수량 부족');
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.