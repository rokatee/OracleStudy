SELECT USER
FROM DUAL;
--==>> SCOTT

--���� TRIGGER(Ʈ����) ����--

-- ������ �ǹ�  : ��Ƽ�, �˹߽�Ű��, �߱��ϴ�, �����ϴ�

-- 1. TRIGGER(Ʈ����)�� , DML �۾�, ��, INSERT, UPDATE, DELETE �� ���� �۾��� 
--    �Ͼ ��, �ڵ������� ����Ǵ�(���ߵǴ�, �˹ߵǴ�) ��ü��
--    �̿� ���� Ư¡�� �����Ͽ�(�ΰ�����) DML TRIGGER��� �θ��⵵ �Ѵ�.
--    TRIGGER �µ����� ������ �� �ƴ϶� ������ ���� �۾����� �θ� ���ȴ�.


-- �� �ڵ����� �Ļ��� �� �� ����
-- �� �߸��� Ʈ������ ����
-- �� ������ ���� ���� ���� ����
-- �� �л� �����ͺ��̽� ��� �󿡼� ���� ���Ἲ ���� ���� 
-- �� ������ ���� ��Ģ ���� ���� 
-- �� ������ �̺�Ʈ �α� ����  
-- �� ������ ���� ����  
-- �� ���� ���̺� ���� ��������  
-- �� ���̺� �׼��� ��� ����

-- 2. TRIGGER �������� COMMIT, ROLLBACK ���� ����� �� ����.

-- 3. Ư¡ �� ����              -- �տ��� ������ �Ұ��ΰ� �ڿ��� �� ���ΰ�
                                -- ���� ��� �ֽĻ���Ʈ �ٹ��ð��� ���Ƴ��� �� �̰Ŵ� ������ ó���ؾ� ��
                                -- ������ ó���� ������ �ƴϸ� ���Ŀ� ó���ؾ��ϴ��� 
                                -- STATEMENT�� �� �ٸ� �� ��, ROW�� ������ ���� ��� Ȯ���ؾ� �ϴ��� �ƴϳ� �� �����̴�
                                -- ���ڵ�鸶�� üũ�ؾ��ϳ� �ƴϸ� ���� �ϳ��� ó���ϸ�ǳ�
                                -- ����� ���� �� 4������ �ǰ���
-- BEFORE STATEMENT 
--       : SQL ������ ����Ǳ� ���� �� ���忡 ���� �� �� ����
-- BEFORE ROW
--       : SQL ������ ����Ǳ� ����(DML�۾��� �����ϱ� ����)
--         �� ��(ROW) �� ���� �� �� �� ����
-- AFTER STATEMENT
--       : SQL ������ ����� �� �� ���忡 ���� �� �� ����
-- AFTER ROW
--       : SQL ������ ����� �Ŀ�(DML�۾��� ������ �Ŀ�) 
--         �� ��(ROW)�� ���� �� �� �� ����

-- 4. ���� �� ����
/*
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE] | [AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��
    [FOR EACH ROW [WHEN TRIGGER ����]]                -- ROW TRIGGER������ ���, ���ٸ� STATEMENT �̴�
[DECLARE]
    -- ���� ����;
BEGIN
    -- ���� ����;
END;
*/



--���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ����--

-- �� DML �۾��� ���� �̺�Ʈ ���

--�� TRIGGER (Ʈ����) ����(TRG_EVENTOG)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
        AFTER 
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
--DECLARE -- ������ ���� ������ ���� ����
BEGIN
    -- �̺�Ʈ ���� ����(���ǹ��� ���� �б�)
    -- ���п� ���� Ű���� CHECK!!!!!
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
                VALUES ('INSERT �������� ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
                VALUES ('UPDATE �������� ����Ǿ����ϴ�.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
                VALUES ('DELETE �������� ����Ǿ����ϴ�. ');
    END IF;
    
    -- COMMIT; 
    --�� TRIGGER �� ������ COMMIT / ROLLBACK ���� ��� �Ұ�
END;
--==>>Trigger TRG_EVENTLOG��(��) �����ϵǾ����ϴ�.


--���� BEFORE STATEMENT TRIGGER ��Ȳ �ǽ� ����--
-- �� DML �۾� ���� ���� �۾� ���ɿ��� Ȯ��(���� ��å ���� / ���� ��Ģ ���� � ���̴� ��)

--�� TRIGGER �ۼ� ( TRG_TEST1_DML )
--CREATE OR REPLACE TRIGGER TRG_TEST1_DML
--        BEFORE
--        INSERT OR UPDATE OR DELETE ON TBL_TEST1
--BEGIN
--    IF (�۾��ð��� ���� 8�� �����̰ų�... ���� 6�� ���Ķ��....)
--        THEN (�۾��� ���� ���ϵ��� ó���ϰڴ�. �� ���ܹ߻���Ű�ڴ�.);
--    END IF;
--END;

CREATE OR REPLACE TRIGGER TRG_TEST1_DML
        BEFORE
        INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF (TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) < 8 
        OR TO_NUMBER(TO_CHAR(SYSDATE,'HH24')) >= 18 )
        THEN RAISE_APPLICATION_ERROR(-20003, '�۾��� 8:00 ~ 18:00 ������ �����մϴ�.');
        
    END IF;
END;
--==>>Trigger TRG_TEST1_DML��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------


-- ���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ����
-- �� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

-- �� TRIGGER (Ʈ����) �ۼ�(TRG_TEST2_DELETE)
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
        BEFORE
        DELETE ON TBL_TEST2
        FOR EACH ROW
DECLARE

BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;
END;
--==>> Trigger TRG_TEST2_DELETE��(��) �����ϵǾ����ϴ�.

--�� :OLD �ݷпõ�
    -- ���� �� ���� ��
    -- (INSERT : �Է��ϱ� ���� ������, DELETE : �����ϱ� ���� ������ ��,������ ������)
    
    -- ���,,,����Ŭ���� ������Ʈ��°� ����
    -- �׷��� ���ݱ��� �� �� ���� ����? ��� UPDATE = DELETE + INSERT �̴�
    -- ������ ������ �ٲٴ°� �ƴ϶� �����ϰ� ���ο� ���� �ִ� ���̴�. 
    
-- �� UPDATE �� DELETE �׸��� INSERT �� ���յ� ���� 
--    �� �������� UPDATE �ϱ� ������ �ڷ�� ��:OLD��
--    �� �������� UPDATE �� ���� �ڷ��     ��:NEW��

--------------------------------------------------------------------------------


-- ���� AFTER ROW TRIGGER ��Ȳ �ǽ� ����

-- �� ���� ���̺� ���� Ʈ����� ó��
-- TBL_��ǰ, TBL_�԰�, TBL_���

--�� TBL_�԰� ���̺��� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ��� ���� ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO

--CREATE OR REPLACE TRIGGER TRG_IBGO
--            AFTER
--            INSERT ON TBL_�԰�
--            FOR EACH ROW
--BEGIN
--    IF(INSERTING)
--        THEN UPDATE TBL_��ǰ
--             SET ������ = ������ + �����԰�Ǵ��԰����
--             WHERE ��ǰ�ڵ� = �����԰�ɻ�ǰ�ڵ�;
--    END IF;
--END;
CREATE OR REPLACE TRIGGER TRG_IBGO
            AFTER
            INSERT ON TBL_�԰�
            FOR EACH ROW
BEGIN
    IF(INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;
--===>>Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.
--> ��� IF�� �ʿ� ����, UPDATE�� �ϳ��ϱ�


--�� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO
CREATE OR REPLACE TRIGGER TRG_IBGO
            AFTER
            INSERT OR UPDATE OR DELETE ON TBL_�԰�
            FOR EACH ROW
BEGIN
    IF(INSERTING)   -- ��� ���� ��ǰ�� ���ο� �԰� �߰�
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF(UPDATING) -- ��� �ִ� ��ǰ�� ���ο� �԰� �߰�
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + (:NEW.�԰���� + :OLD.�԰����)
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF(DELETING) -- �̹� ���ſ� �԰� �̷����, ��� �ִ� ��ǰ�� �԰� ����
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰����
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_CHULGO
CREATE OR REPLACE TRIGGER TRG_CHULGO
            AFTER
            INSERT OR UPDATE OR DELETE ON TBL_���
            FOR EACH ROW
BEGIN
    IF(INSERTING)   -- ��� ���� ��ǰ�� ���ο� ���
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF(UPDATING)    -- ��� �ִ� ��ǰ�� ���ο� ���
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
--           (�� ���� �������� ���� ����� ���ؼ� �ٽ� ���ο� ����� ���� ������Ʈ�Ѵ�)
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF(DELETING)    -- ��� �ִ� ��ǰ�� ��� ����
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_CHULGO��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

--���� PACKAGE(��Ű��) ����--

/*
 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü, 
    ���� ���α׷�(PROCEDUER, FUNCTION)��
    �������� ������� ������
    ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� DBMS_OUTPUT �̴�


 2. ��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ���
    �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ�
    ��ü ���α׷��� ���ȭ �� �� �ִ� ������ �ִ�.


 3. ��Ű���� ����(PACKAGE SPECIFICATION) ��
    ��ü��(PACKAGE BODY)�� �����Ǿ� ������
    �� �κп��� TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPROGRAM �� ����ǰ�
    ��ü �κп��� �̵��� ���� ������ �����ϰ� �ȴ�.
    �׸��� ȣ���� ������ ����Ű����.���ν����� ������ ������ �̿��ؾ� �Ѵ�.


 4. ���� �� ����(����)

    CREATE [OR REPLACE] PACKAGE ��Ű����
    IS
        �������� ����;
        Ŀ�� ����;
        ���� ����;
        �Լ� ����;
        ���ν��� ����;
           :
           
    END ��Ű����;



 5. ���� �� ����(��ü��)

    CREATE [OR REPLACE] PACKAGE BODY ��Ű����
    IS
        FUNCTION �Լ��� [(�μ�, ...)]
        RETURN �ڷ���
        IS
            ���� ����;
        BEGIN
            �Լ� ��ü ���� �ڵ�;
            RETURN ��;
        END;
        
        PROCEDURE ���ν�����[(�μ�, ...)]
        IS
            ��������;
        BEGIN
            ���ν��� ��ü ���� �ڵ�;
        END;    
        
    END ��Ű����;
*/


-- ��Ű�� ��� �ǽ�
--�� ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK;
--==>> Package INSA_PACK��(��) �����ϵǾ����ϴ�.

--�� ��ü�� �ۼ�
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
            THEN V_RESULT := '����';
        ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := 'Ȯ�κҰ�';
        END IF;
        
        RETURN V_RESULT;
    END;
END INSA_PACK;
--==>> Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.




















