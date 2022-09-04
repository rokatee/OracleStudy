---CURSOR(Ŀ��) �۵����� �׽�Ʈ-------------------------------------------------
SELECT *
FROM TBL_�԰�
ORDER BY �԰��ȣ;

EXEC PRC_�԰�_UPDATE(3, 49); 
EXEC PRC_�԰�_UPDATE(5, 10);
/*
�԰��ȣ 3,5 = ��ũ���� -> ���� 50���� �� 100�� �԰�Ǿ���, ��� ���� ��Ȳ
���� : 50���� ��� ��� �Ǿ��⿡ 50�� ������ ���ڷ� �԰���� ���� �Ұ�

���ν��� ȣ���� ����������
IF�� ���ǿ� ���� RETURN �Ǹ鼭
���ǿ� �´� �����͸� CURSOR(Ŀ��)�� ����ش�


����ȣ   |   ��ǰ�ڵ�   |   �������   |   ������
   1             H001        2022-09-02        100
�� ���� ���� �Ұ�

PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

---PRC_�԰�_UPDATE() WITH CURSOR(Ŀ��)------------------------------------------
/*
���� ��)
EXEC PRC_�԰�_UPDATE(�԰��ȣ, �԰����);

EXEC PRC_�԰�_UPDATE(1, 10);
*/
DESC TBL_�԰�;
DESC TBL_��ǰ;
DESC TBL_���;

CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
(
  V_�԰��ȣ            IN TBL_�԰�.�԰��ȣ%TYPE
, V_�������԰����      IN TBL_�԰�.�԰����%TYPE
)
IS
    V_�����԰����    TBL_�԰�.�԰����%TYPE;        -- ���� �� �����԰����
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_����������    TBL_��ǰ.������%TYPE;        
    V_�԰�����        TBL_�԰�.�԰�����%TYPE;
    
    V_�԰��ȣȮ��    NUMBER := 1;
    NO_DATA_FOUND       EXCEPTION;
    LOWER_THAN_ZERO     EXCEPTION;
--    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO V_�԰��ȣȮ��
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    IF (V_�԰��ȣȮ�� = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    IF (V_�������԰���� < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    SELECT ��ǰ�ڵ�, �԰����, �԰����� INTO V_��ǰ�ڵ�, V_�����԰����, V_�԰�����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    SELECT ������ INTO V_����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    IF ( (V_���������� - V_�����԰����) + V_�������԰���� < 0)
        THEN
            DECLARE 
                -- �ֿ� ���� ����
                V_����ȣ	TBL_���.����ȣ%TYPE;
                V_�������	TBL_���.�������%TYPE;
                V_������  TBL_���.������%TYPE;
            
                -- Ŀ�� �̿��� ���� Ŀ������ ����(Ŀ������)
                CURSOR CUR_���_SELECT
                IS
                SELECT ����ȣ, ��ǰ�ڵ�, �������, ������
                FROM TBL_���
                WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�
                  AND ������� >= V_�԰�����;
                  
            BEGIN
                DBMS_OUTPUT.PUT_LINE('����ȣ   |   ��ǰ�ڵ�   |   �������   |   ������');
                
                OPEN CUR_���_SELECT;
                
                LOOP
                    -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� fetch
                    FETCH CUR_���_SELECT INTO V_����ȣ, V_��ǰ�ڵ�, V_�������, V_������;
            
                    -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����
                    -- ��, Ŀ�� ���ο��� �� �̻��� �����͸� ã�� �� ���� ����
                    -- �� �׸�~!! �ݺ��� ����������
                    EXIT WHEN CUR_���_SELECT%NOTFOUND;
                    --���
                    DBMS_OUTPUT.PUT_LINE('   '||V_����ȣ||'             '||V_��ǰ�ڵ�||
                                         '        '||V_�������||'        '||V_������);
                END LOOP;
                
                DBMS_OUTPUT.PUT_LINE('�� ���� ���� �Ұ�');
                
                --Ŀ�� Ŭ����
                CLOSE CUR_���_SELECT;
                RETURN;
            END;
    END IF;
--    IF ( (V_���������� - V_�����԰����) + V_�������԰���� < 0)
--        THEN RAISE USER_DEFINE_ERROR;
--    END IF;
    
    UPDATE TBL_�԰�
    SET �԰���� = V_�������԰����
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    UPDATE TBL_��ǰ   
    SET ������ = (V_���������� - V_�����԰����) + V_�������԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '�����͸� ã�� �� �����ϴ�');
        WHEN LOWER_THAN_ZERO
             THEN RAISE_APPLICATION_ERROR(-20003, '���� �Է� �Ұ�');
--        WHEN USER_DEFINE_ERROR
--            THEN RAISE_APPLICATION_ERROR (-20002, '������ ����');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
END;
--==>> Procedure PRC_�԰�_UPDATE��(��) �����ϵǾ����ϴ�.