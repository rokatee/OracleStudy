---PRC_�԰�_UPDATE()------------------------------------------------------------
SET SERVEROUTPUT ON;

/*
1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
    �԰�� ���� ���� (������ζ�� �԰��ȣ ���Ŀ� ���� �͵��� �� ����ؾ� ��)
    �԰���� �ٲ�� �������� �ٲ��.

���� ��)
EXEC PRC_�԰�_UPDATE(�԰��ȣ, �԰����);

EXEC PRC_�԰�_UPDATE(1, 10);
*/
DESC TBL_�԰�;
DESC TBL_��ǰ;

-- V_�������԰���� = V_�԰����
-- V_���������� = V_������
CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
(
  --�� �Ű����� ����
  V_�԰��ȣ            IN TBL_�԰�.�԰��ȣ%TYPE
, V_�������԰����      IN TBL_�԰�.�԰����%TYPE    -- V_�԰����
)
IS
    --�� �ʿ��� ���� �߰� ����
    V_����������    TBL_��ǰ.������%TYPE;        
    V_�����԰����    TBL_�԰�.�԰����%TYPE;        -- ���� �� �����԰����
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�԰��ȣȮ��    NUMBER := 1;
    
    --�� ���ܺ��� �߰�
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_FOUND       EXCEPTION;
    LOWER_THAN_ZERO     EXCEPTION;
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
    -- �԰��ȣ�� ���� �Է��ϸ� ���� �߻�
    IF (V_�������԰���� < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    --�� ������ ������ �� ��Ƴ���
    -- ��ǰ�ڵ�� �����԰���� �ľ�
    SELECT ��ǰ�ڵ�, �԰���� INTO V_��ǰ�ڵ�, V_�����԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    -- ������ �� ��ǰ�ڵ带 Ȱ���Ͽ� ������ �ľ�
    SELECT ������ INTO V_����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --��  IF�� ����ó��
    --  ��� �̷��� �������� ���� �߻�
    --  �̰� ������� ��� �̷��� ��
    --  ----------------------------------
    IF ( (V_���������� - V_�����԰����) + V_�������԰���� < 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --�� ����� ������ üũ(UPDATE �� TBL_�԰�)
    -- �԰������ �����ϰ��� �ϴ� ���� ����
    UPDATE TBL_�԰�
    SET �԰���� = V_�������԰����
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    --�� ����� ������ üũ(UPDATE �� TBL_��ǰ)
    UPDATE TBL_��ǰ   
    SET ������ = (V_���������� - V_�����԰����) + V_�������԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    --�� ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
             THEN RAISE_APPLICATION_ERROR(-20004, '�����͸� ã�� �� �����ϴ�');
        WHEN LOWER_THAN_ZERO
             THEN RAISE_APPLICATION_ERROR(-20003, '���� �Է� �Ұ�');
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR (-20002, '������ ����');
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_UPDATE��(��) �����ϵǾ����ϴ�.