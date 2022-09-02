SELECT USER
FROM DUAL;
--==>> SCOTT

--�� TBL_�԰� ���̺� �԰� �̺�Ʈ �߻� ��
--   ���� ���̺� ����Ǿ�� �ϴ� ����

-- �� INSERT �� TBL_�԰�

-- �� UPDATE �� TBL_��ǰ

--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �Է� �̺�Ʈ �߻� ��)
--   TBL_�԰� ���̺��� ������ �Է� �� �ƴ϶�
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ��Ѵ�
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ� (������ ��� X)
--   TBL_�԰� ���̺� ���� �÷� - ����
--    : �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)
DESC TBL_��ǰ;

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
(
  --�� �ܰ�
  V_��ǰ�ڵ�    IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    --�� �ܰ�
    V_�԰��ȣ  TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    --�� �ܰ�
    -- �԰��ȣ �ִ밪 �ڵ� �Է�
    --SELECT MAX(NVL(�԰��ȣ, 0)) + 1 INTO V_�԰��ȣ      -- �̰� �� NULLó���� �ȵǴ°���?
                                                            -- 20220901_02_scott.sql����
                                                            -- "�Ʒ� �� ���� ���� ����" ���� ã�� ���� Ȯ��
    SELECT NVL(MAX(�԰��ȣ), 0) + 1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    -- INSERT�� UPDATE�� ���ÿ� �̷����� ���̱⿡
    -- ���� �ۼ��Ǿ�� �ϴ� ���� ����
    -- TBL_�԰� ������ �Է�
    --�� �ܰ�
--    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
--    VALUES(????, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    --�� �ܰ�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    -- TBL_��ǰ ������Ʈ
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� �ܰ�
    -- ����ó��
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;   -- �� �� �ϳ��� ó���ƴٸ� ROLLBACK �ض�
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

--���� ���ν��� �������� ���� ó�� ����--

--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν��� �ۼ�
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����', '���', '����' �� �Է��� �����ϵ��� �����Ѵ�
--   �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��ϰ��� �ϴ� ���
--   (��, �Է��� �õ��ϴ� ���)
--   ���ܿ� ���� ó���� �Ϸ��� �Ѵ�
--   ���ν��� �� : PRC_MEMBER_INSERT()
/*
���� ��)
EXEC PRC_MEMBER_INSERT('�ӽÿ�', '010-1111-1111', '����');
--==>> ������ �Է� O

EXEC PRC_MEMBER_INSERT('�躸��', '010-2222-2222', '�λ�');
--==>> ������ �Է� X
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
(
  --��
  V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    --��
    -- ���� ������ ������ ������ ���� �ʿ��� ���� �߰� ����
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    --��
    --����� ���� ���ܿ� ���� ���� ����
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --��
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    -- �ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� �ۼ�
--    IF(������ ���� ��� ��õ�� �ƴ϶��)
--        THEN ���ܸ� �߻���Ű�ڴ�.
--    END IF;
    --��
    IF(V_CITY NOT IN ('����', '���', '����') )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --��
    -- INSERT �������� �����ϱ⿡ �ռ�
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM), 0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    --��
    -- ������ �ۼ� �� INSERT 
--    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
--    VALUES(???, V_NAME, V_TEL, V_CITY);    
    --��
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(V_NUM, V_NAME, V_TEL, V_CITY);
    
    --��
    -- ���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����, ���, ������ �Է��� �����մϴ�');
            --                            �迡����ȣ         �迡���� ���� ���� ���
            --                            ��
            --                            �迡����ȣ�� ��� �Ź� ���� ��ȣ�� �ο��ص� ���������� ����������
            --                              ����ڿ��� �ȳ��� �ϱ� ���� �ٸ� �������� �ٸ� ��ȣ�� �ο������ �Ѵ�
            -- RAISE_APPLICATION_ERROR  --> �̰� ���� �Լ��� �̴�
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.



--------------------------------------------------------------------------------

--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ��� ������ �����Ǵ� ���ν����� �ۼ��Ѵ�
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ���� ó���Ѵ�
--   ����, ��� ������ ��� �������� ���� ���
--   ��� �׼� ó�� ��ü�� ����� �� �ֵ��� ó���Ѵ� (��� �̷������ �ʵ���...)
--   ���ν��� �� : PRC_���_INSERT()
/*
���� ��)
EXEC PRC_���_INSERT('H001', 50, 1000);
*/
DESC TBL_���;
DESC TBL_��ǰ;

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
(
  V_��ǰ�ڵ�    IN TBL_���.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS
    V_����ȣ          TBL_���.����ȣ%TYPE;
    
    V_������          TBL_��ǰ.������%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ������ ���� ������ ���� ���θ� Ȯ���ϴ� ��������
    -- ��� �ľ� �� ������ ��� Ȯ���ϴ� ������ ����Ǿ�� �Ѵ�
    -- �׷��� ��� ������ �񱳰� �����ϱ� ������
    SELECT ������ INTO V_������ 
    FROM TBL_��ǰ 
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� �������� �������� ���� ���� Ȯ��
    -- �������� ���������� ���ٸ� ���� �߻�
    IF
      --(V_������ > TBL_��ǰ.������) --> �̷��� �����ϴ� �������� �� �� ����
        (V_������ > V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ����ȣ �ڵ�ó��
    SELECT NVL(MAX(����ȣ), 0) + 1 INTO V_����ȣ
    FROM TBL_���;
    
    -- ������ �ۼ� �� INSERT(TBL_���)
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
    -- ������ �ۼ� �� UPDATE(TBL_��ǰ)    
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
                ROLLBACK;   -- �̹� IF������ ����ó���� �����μ�
                            -- INSERT�� UPDATE�� �۵����� �ʱ⿡
                            -- �ѹ� ���� ���� ��� ������ �ʾƵ� �ȴ�
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.




--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.

-- ���ν��� �� : PRC_���_UPDATE();

-- ���� ��� 10������ 5�� �ϸ� �������� 10����� 15���� �� ���̰� 
-- ���� ��� 10���� 30�� �Ϸ��µ� ��� 10���̴ϱ� �� �� ���̰�
-- ���� ��� 10���� 12�� �Ϸ��� ��� 10���� 8���� �� ���̴�.
/*
���� ��)
EXEC PRC_���_UPDATE(����ȣ, �����Ҽ���);

EXEC PRC_���_UPDATE(1, 10);
*/
DESC TBL_���;
DESC TBL_��ǰ;

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
(
  V_����ȣ        IN TBL_���.����ȣ%TYPE
, V_�����Ҽ���      IN TBL_��ǰ.������%TYPE  -- �������� �Է��ϴ� ���� �ٲ۴�
)
IS
    V_��ǰ�ڵ�          TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    V_����������      TBL_��ǰ.������%TYPE;
    
    V_����������      TBL_���.������%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    -- � ��ǰ�� ��������� �˾ƾ��Ѵ�
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- ���� �� �̹��ִ� ������ �˾Ƴ���
    SELECT ������ INTO V_����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� �� �̹� ������� ������ �˾Ƴ���
    SELECT ������ INTO V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- (���������)
    -- �����Ҽ��� = ����������+a
    -- �����Ҽ����� ������������ ��������� ���� ������ ũ�� �����߻�
    IF
       ( V_�����Ҽ��� > (V_���������� + V_����������) )
            THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    --������ �ۼ� �� UPDATE(TBL_���)
    UPDATE TBL_���
    SET ������ = V_�����Ҽ���
    WHERE ����ȣ = V_����ȣ;
    --������ �ۼ� �� UPDATE(TBL_���)
    UPDATE TBL_��ǰ
    SET ������ = ������ + (V_���������� - V_�����Ҽ���)
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.



-- �ش�Ǯ��
CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
(
    --�� �Ű����� ����
  V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_������    IN TBL_���.������%TYPE
)
IS
    --�� �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_����������    TBL_���.������%TYPE;
    V_����������    TBL_��ǰ.������%TYPE;
    
    --�� ���ܺ��� �߰�
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ������ ������ �� ��Ƴ���
    --�� ��ǰ�ڵ�� ���������� �ľ�
    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    --�� ������ �� ��ǰ�ڵ带 Ȱ���Ͽ� ������ �ľ�
    SELECT ������ INTO V_����������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� ��� ���� ���� ���� �Ǵ� �ʿ�
    --   ���� ������ ������ �� ������ ������ Ȯ��
--    IF (�ľ��� ���� �������� ������ �������� ��ģ ���� ������ ���������� ������)
--        ���� �߻�
--    END IF;
    IF ( (V_���������� + V_����������) < V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    --�� ����� ������ üũ(UPDATE �� TBL_��� / UPDATE �� TBL_��ǰ)
    UPDATE TBL_���
    SET ������ = V_������
    WHERE ����ȣ = V_����ȣ;
    
    --��
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_���������� - V_������
   --  ���� ������ = ���������� + ���������� - ������������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� ����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --�� Ŀ��
    COMMIT;

END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------
--����
/*
1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
    �԰�� ���� ���� (������ζ�� �԰��ȣ ���Ŀ� ���� �͵��� �� ����ؾ� ��)

���� ��)
EXEC PRC_�԰�_UPDATE(�԰��ȣ, �԰����);

EXEC PRC_�԰�_UPDATE(1, 10);
*/
CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
(
)
IS
BEGIN

    --Ŀ��
    --COMMIT;
END;



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
    V_�԰����  TBL_�԰�.�԰����%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    --�� ����ó��
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ������ ������ �� ��Ƴ���
    --�� �԰������ ��ǰ�ڵ� �ľ�
    SELECT �԰����, ��ǰ�ڵ� INTO V_�԰����, V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- ������ �ľ�
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� ���� �߻�
    -- ������ �԰������ ���������� ũ�� �������� ������ �ǹǷ� ����ó��
--    IF (�԰�100�� �� ���100��, �̶� ���50�� �� ���100-50=50��, �̶� �԰� -100�� �ϸ� �� �̹� ���50 �̹Ƿ� 50���� ������ �԰� ���� X)
--        (������ - �����Ϸ��� �԰� < 0)  --> �԰� ������ �Ǿ� ��� �׿� ������ �̰͵� Ʋ�����ε�;;
--            THEN �����߻�;
--    END IF;
    IF (V_������ - V_�԰���� < 0)
            THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    10 - 11
    
    --�� ����� ������ üũ(DELETE �� TBL_�԰�)
    DELETE
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    --�� ����� ������ üũ(UPDATE �� TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    --�� ����ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '�԰��� ���� �Ұ���');
        WHEN OTHERS
            THEN ROLLBACK;
    
    --�� Ŀ��
--    COMMIT;
END;
--==>> Procedure PRC_�԰�_DELETE��(��) �����ϵǾ����ϴ�.


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
    V_��ǰ�ڵ�  TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������  TBL_���.������%TYPE;
    V_������  TBL_��ǰ.������%TYPE;
    
BEGIN
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
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.



--------------------------------------------------------------------------------
--���� CURSOR(Ŀ��) ����--

-- 1. ����Ŭ������ �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������
--    �۾� �������� SQL ���� �����ϰ� �� �������� �߻��� �����͸�
--    �����ϱ� ���� Ŀ��(CURSOR)�� ����ϸ�,
--    Ŀ������ �Ͻ����� Ŀ���� ������� Ŀ���� �ִ�

-- 2. �Ͻ��� Ŀ���� ��� SQL ���� �����ϸ�
--    SQL �� ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�
--    �׷��� SQL ���� ������ �����(RESULT SET)��
--    ���� ��(ROW)���� ������ ���
--    Ŀ��(CURSOR)�� ��������� �����ؾ� ���� ��(ROW)�� �ٷ� �� �ִ�

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
SET SERVEROUTPUT ON;

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
       
END;
--==>> ȫ�浿 -- 011-2356-4528


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
       
END;
--==>> ���� �߻�
--> ORA-01422: exact fetch returns more than requested number of rows


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� �� - �ݺ��� Ȱ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1062;
    END LOOP;   
END;
--==>> 
/*
������ -- 010-7202-6306
ȫ�浿 -- 011-2356-4528
�̼��� -- 010-4758-6532
    :
�Ӽ��� -- 011-4151-4154
��ž� -- 011-4151-4444


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� Ŀ�� �̿� �� ��Ȳ
DECLARE
    -- �����
    -- �ֿ� ���� ����
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;

    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
BEGIN
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    -- Ŀ�� ���� �� ����� ������ �����͵� ó��
    LOOP
        -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� fetch
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        
        -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����
        -- ��, Ŀ�� ���ο��� �� �̻��� �����͸� ã�� �� ���� ����
        -- �� �׸�~!! �ݺ��� ����������
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
    END LOOP;
    
    --Ŀ�� Ŭ����
    CLOSE CUR_INSA_SELECT;
    
END;
--==>>
/*
������ -- 010-7202-6306
ȫ�浿 -- 011-2356-4528
�̼��� -- 010-4758-6532
    :
�Ӽ��� -- 011-4151-4154
��ž� -- 011-4151-4444


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
