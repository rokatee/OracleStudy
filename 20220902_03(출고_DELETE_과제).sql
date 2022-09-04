---PRC_���_DELETE()------------------------------------------------------------
SET SERVEROUTPUT ON;

/*
3. PRC_���_DELETE(����ȣ)
    ������ ��������ŭ �������� ����

���� ��)
EXEC PRC_���_DELETE(����ȣ);

EXEC PRC_���_DELETE(1);
*/
DESC TBL_���;
/*
����ȣ NOT NULL NUMBER       
��ǰ�ڵ�          VARCHAR2(20) 
�������          DATE         
������          NUMBER       
���ܰ�          NUMBER 
*/

CREATE OR REPLACE PROCEDURE PRC_���_DELETE
(
  --�� �Ű����� ����
  V_����ȣ    IN TBL_���.����ȣ%TYPE
)
IS
    --�� �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������        TBL_���.������%TYPE;
    V_����ȣȮ��    NUMBER := 1;
    
    --�� ����ó��
    NO_DATA_FOUND       EXCEPTION;    
BEGIN

    --�� ����ó���� ���� ����ȣ ���翩�� �ľ�
    SELECT COUNT(*) INTO V_����ȣȮ��
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    --�� ����ȣ�� �����ϴ��� ���� üũ, ���ٸ� ���� �߻�
    IF (V_����ȣȮ�� = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ������ ������ �� ��Ƴ���
    --�� �������� ��ǰ�ڵ� �ľ�
    SELECT ������, ��ǰ�ڵ� INTO V_������, V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    --�� ����� ������ üũ(DELETE �� TBL_���)
    -- �������� ������
    DELETE
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    --�� ����� ������ üũ(UPDATE �� TBL_��ǰ)
    -- ������ ��������ŭ �������� �־���
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� ����ȣ�� �����Ǹ� ����� ����ȣ �ڸ��� ���ڸ� ���ڵ��� ä���ֱ� ����
    --   ������ ����ȣ���� ū ������ ����ȣ�� �ִٸ� 1�� ����
    --   EX. ����ȣ 1,2,3,4 �� ���� ��,
    --       2���� �����Ǹ� 1,3,4�� �����Ƿ�,
    --       3,4���� 1�� ���ҽ��� ��ȣ�� ������ ����ش�
    UPDATE TBL_���
    SET ����ȣ = ����ȣ - 1
    WHERE ����ȣ > V_����ȣ;
        
    --�� ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '�����͸� ã�� �� �����ϴ�');
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.