---PRC_�԰�_DELETE()------------------------------------------------------------
SET SERVEROUTPUT ON;

/*
2. PRC_�԰�_DELETE(�԰��ȣ)
    �԰��ȣ�� �԰������ ������ ��ŭ ��ǰ���� ����, ��� ��� ������ ���·� ���ư�

���� ��)
EXEC PRC_�԰�_DELETE(�԰��ȣ);

EXEC PRC_�԰�_DELETE(1);
*/
DESC TBL_�԰�;
/*
�԰��ȣ NOT NULL NUMBER       
��ǰ�ڵ�          VARCHAR2(20) 
�԰�����          DATE         
�԰����          NUMBER       
�԰�ܰ�          NUMBER     
*/

CREATE OR REPLACE PROCEDURE PRC_�԰�_DELETE
(
  --�� �Ű����� ����
  V_�԰��ȣ    IN TBL_�԰�.�԰��ȣ%TYPE
)
IS
    --�� �ʿ��� ���� �߰� ����
    V_�������԰����  TBL_�԰�.�԰����%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�԰��ȣȮ��    NUMBER := 1;
    
    --�� ����ó��
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_FOUND       EXCEPTION;
BEGIN
    --�� ����ó���� ���� �԰��ȣ ���翩�� �ľ�
    SELECT COUNT(*) INTO V_�԰��ȣȮ��
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    --�� IF�� ����ó��
    -- �԰��ȣ�� �����ϴ��� ���� üũ, ���ٸ� ���� �߻�
    IF (V_�԰��ȣȮ�� = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ������ ������ �� ��Ƴ���
    --�� �԰������ ��ǰ�ڵ� �ľ�
    SELECT �԰����, ��ǰ�ڵ� INTO V_�������԰����, V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    -- ������ �ľ�
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� IF�� ����ó��
    -- ������ �԰������ ���������� ũ�� �������� ������ �ǹǷ� ����ó��
--    IF (�԰�100�� �� ���100��, �̶� ���50�� 
--         �� ���100-50=50��, �̶� �԰� -100�� �ϸ� 
--         �� �̹� ���50 �̹Ƿ� 50���� ������ �԰� ���� X)
--            THEN �����߻�;
--    END IF;
    IF (V_������ - V_�������԰���� < 0)    -- ������ ���� ��� �� ����
            THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�� ����� ������ üũ(DELETE �� TBL_�԰�)
    DELETE
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    --�� ����� ������ üũ(UPDATE �� TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_�������԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� �԰��ȣ�� �����Ǹ� ����� �԰��ȣ �ڸ��� ���ڸ� ���ڵ��� ä���ֱ� ����
    --   ������ �԰��ȣ���� ū ������ �԰��ȣ�� �ִٸ� 1�� ����
    --   EX. �԰��ȣ 1,2,3,4 �� ���� ��,
    --       2���� �����Ǹ� 1,3,4�� �����Ƿ�,
    --       3,4���� 1�� ���ҽ��� ��ȣ�� ������ ����ش�
    UPDATE TBL_�԰�
    SET �԰��ȣ = �԰��ȣ - 1
    WHERE �԰��ȣ > V_�԰��ȣ;
    
    --�� ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '�����͸� ã�� �� �����ϴ�');
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR (-20002, '������ ����');
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_DELETE��(��) �����ϵǾ����ϴ�.