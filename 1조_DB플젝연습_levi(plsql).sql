SELECT USER
FROM DUAL;
--==>> LEVI

SET SERVEROUTPUT ON;

-- ���� �޽��� ���
/*
-20001, '������ �ߺ�'
-20002, '������ ����'
-20003, '��ȿ���� ���� ������'
-20004, '���� 100���� �Ǿ�� �մϴ�'
-20005, '���� ����'
-20006, '��� ���� ������' 
-20007, '������û �Ⱓ�� �������ϴ�'
-20008, '�̹� ������ �ο��� �����Դϴ�
*/

--DROP SEQUENCE TBL_CLASS_SEQ;
--
--CREATE SEQUENCE TBL_CLASS_SEQ
--NOCACHE;

--------------------------------------------------------------------------------
--����
-------------------
-- PRC_CLASS_INSERT
SELECT *
FROM TBL_CLASS;

--EXEC PRC_CLASS_INSERT(CLASS_NAME);
EXEC PRC_CLASS_INSERT('Java');   -- �ߺ� ������ �׽�Ʈ 
EXEC PRC_CLASS_INSERT('WOW');    -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_CLASS_INSERT
(
   V_CLASS_NAME    IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CLASS_CODE        TBL_CLASS.CLASS_CODE%TYPE;
    V_FLAT              NUMBER := 1;
    DUPLICATE_DATA      EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;
    
    IF (V_FLAT = 1)
        THEN RAISE DUPLICATE_DATA;
    END IF;

    INSERT INTO TBL_CLASS(CLASS_CODE, CLASS_NAME)
    VALUES(TBL_CLASS_SEQ.NEXTVAL, V_CLASS_NAME);
    
    EXCEPTION
        WHEN DUPLICATE_DATA
            THEN RAISE_APPLICATION_ERROR(-20001, '������ �ߺ�');

END;

--------------------
-- PRC_CLASS_UPDATE
SELECT *
FROM TBL_CLASS;

--EXEC PRC_CLASS_UPDATE(CLASS_CODE, CLASS_NAME);
EXEC PRC_CLASS_UPDATE(100, '���µ�����');   -- ���µ�����
EXEC PRC_CLASS_UPDATE(3, 'WWW');            -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_CLASS_UPDATE
(
    V_CLASS_CODE    IN TBL_CLASS.CLASS_CODE%TYPE
,   V_CLASS_NAME    IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_FLAT          NUMBER := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    UPDATE TBL_CLASS
    SET CLASS_NAME = V_CLASS_NAME
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');

END;

------------------
--PRC_CLASS_DELETE
SELECT *
FROM TBL_CLASS;

--EXEC PRC_CLASS_DELETE(CLASS_CODE);
EXEC PRC_CLASS_DELETE(100);   -- ���µ�����
EXEC PRC_CLASS_DELETE(3);     -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_CLASS_DELETE
(
    V_CLASS_CODE    IN TBL_CLASS.CLASS_CODE%TYPE
)
IS
    V_FLAT          NUMBER := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    DELETE 
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');

END;

--------------------------------------------------------------------------------
--����
-----------------
--PRC_PRO_INSERT        --> �ʱ� ����� �ֹι�ȣ ���ڸ���, ��ȣȭ��
SELECT *
FROM TBL_PROFESSOR;

--EXEC PRC_PRO_INSERT(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE, PRO_DATE);
EXEC PRC_PRO_INSERT('pro1', '����5', '5555555', '555555-5555555', 'pro5@gmail.com', '010-5555-5555'); --���� ���̵� �ߺ�
EXEC PRC_PRO_INSERT('pro5', '����1', '5555555', '555555-5555555', 'pro5@gmail.com', '010-5555-5555'); --������
EXEC PRC_PRO_INSERT('pro5', '����5', '5555555', '901010-1234567', 'pro5@gmail.com', '010-5555-5555'); --���� �ֹι�ȣ
EXEC PRC_PRO_INSERT('pro5', '����5', '5555555', '555555-5555555', 'pro1@gmail.com', '010-5555-5555'); --���� �̸���
EXEC PRC_PRO_INSERT('pro5', '����5', '5555555', '555555-5555555', 'pro5@gmail.com', '010-1234-5678'); --���� ����ȣ
--> �ߺ� ������ �׽�Ʈ 
EXEC PRC_PRO_INSERT('pro3', '����3', '3334567', '921010-3334567', 'pro3@gmail.com', '010-3334-5678');    
EXEC PRC_PRO_INSERT('pro4', '����4', '4444567', '931010-3334567', NULL, NULL);    
--> ������ ������

CREATE OR REPLACE PROCEDURE PRC_PRO_INSERT
(
   V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
,  V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
,  V_PRO_PW      IN TBL_PROFESSOR.PRO_PW%TYPE
,  V_PRO_SSN     IN TBL_PROFESSOR.PRO_SSN%TYPE
,  V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
,  V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_FLAT              NUMBER;-- := 1;
    DUPLICATE_DATA      EXCEPTION;
BEGIN
    
    -- �ߺ� ���� : ���� ���̵�, ������, ���� �ֹι�ȣ, ���� �̸���, ���� ����ȣ
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID
       OR PRO_NAME = V_PRO_NAME
       OR PRO_SSN = V_PRO_SSN
       OR PRO_EMAIL = V_PRO_EMAIL
       OR PRO_PHONE = V_PRO_PHONE;
    
    IF (V_FLAT = 1)
        THEN RAISE DUPLICATE_DATA;
    END IF;

    INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
    VALUES(V_PRO_ID, V_PRO_NAME, V_PRO_PW, V_PRO_SSN, V_PRO_EMAIL, V_PRO_PHONE);
    
    EXCEPTION
        WHEN DUPLICATE_DATA
            THEN RAISE_APPLICATION_ERROR(-20001, '������ �ߺ�');

END;

--------------------
-- PRC_PRO_UPDATE  --> ������ �����ð��� �����Ϳ��� ������ұ�?
                   --> ���ϴ� ���� �ٲٷ��� ���? EX. ����� �ٲٰų�, �̸��ϸ� �ٲٰų�
SELECT *
FROM TBL_PROFESSOR;

DESC TBL_PROFESSOR;

--EXEC PRC_PRO_UPDATE(PRO_ID, PRO_PW, PRO_EMAIL, PRO_PHONE);
EXEC PRC_PRO_UPDATE('pro100', '5555555', 'pro5@gmail.com', '010-5555-5555');   -- ���µ�����
EXEC PRC_PRO_UPDATE('pro3', '5555555', 'pro5@gmail.com', '010-5555-5555');     -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_PRO_UPDATE
(
   V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
,  V_PRO_PW      IN TBL_PROFESSOR.PRO_PW%TYPE
,  V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
,  V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_FLAT          NUMBER;-- := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    UPDATE TBL_PROFESSOR
    SET PRO_PW = V_PRO_PW
      , PRO_EMAIL = V_PRO_EMAIL
      , PRO_PHONE = V_PRO_PHONE
    WHERE PRO_ID = V_PRO_ID;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');

END;

------------------
--PRC_PRO_DELETE
SELECT *
FROM TBL_PROFESSOR;

--EXEC PRC_PRO_DELETE(PRO_ID);
EXEC PRC_PRO_DELETE('pro100');   -- ���µ�����
EXEC PRC_PRO_DELETE('pro3');     -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_PRO_DELETE
(
   V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
)
IS
    V_FLAT          NUMBER;-- := 1;
    NO_DATA_FOUND   EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAT
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    DELETE 
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;

    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');

END;

--------------------------------------------------------------------------------
--���ǽ�


--------------------------------------------------------------------------------
--����


--------------------------------------------------------------------------------
--����
----------------------
-- PRC_TEXTBOOK_INSERT
SELECT *
FROM TBL_TEXTBOOK;

--EXEC PRC_TEXTBOOK_INSERT(BOOK_NAME, BOOK_PUB);
EXEC PRC_TEXTBOOK_INSERT('Java', 'ȫ��');          -- �ߺ� ������ �׽�Ʈ
EXEC PRC_TEXTBOOK_INSERT('DB', '�ֿ�');            -- ������ ������
EXEC PRC_TEXTBOOK_INSERT('JS', NULL);              -- ������ ������
EXEC PRC_TEXTBOOK_INSERT('���� ����', NULL);       -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_INSERT
(
  V_BOOK_NAME   IN TBL_TEXTBOOK.BOOK_NAME%TYPE      -- �����
, V_BOOK_PUB    IN TBL_TEXTBOOK.BOOK_PUB%TYPE       -- ���ǻ�
)
IS
    V_BOOK_CODE         TBL_TEXTBOOK.BOOK_CODE%TYPE;    -- �����ڵ�(�������� �ڵ� �Է�)
    V_FLAT              NUMBER;                         -- ������ ���� �Ǵ� ����
    DUPLICATE_DATA      EXCEPTION;                      -- �ߺ� ������ �Է� �� �������� ������ִ� ����
BEGIN
    -- ���� �̸��� ������� �ִ� �����ڵ� ���� V_FLAT�� ���
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_NAME = V_BOOK_NAME;
    -- ������ '������ �ߺ�' �������� ���
    IF (V_FLAT != 0)   
        THEN RAISE DUPLICATE_DATA;
    END IF;
    
    -- �μ�Ʈ ����
    INSERT INTO TBL_TEXTBOOK(BOOK_CODE, BOOK_NAME, BOOK_PUB)
    VALUES(TBL_TEXTBOOK_SEQ.NEXTVAL, V_BOOK_NAME, V_BOOK_PUB);
    
    -- ����ó��
    EXCEPTION
        WHEN DUPLICATE_DATA
            THEN RAISE_APPLICATION_ERROR(-20001, '������ �ߺ�');
--        WHEN OTHERS
--            THEN ROLLBACK;
--            
--    COMMIT;
    
END;

----------------------
-- PRC_TEXTBOOK_UPDATE    --> ���ϴ� ���� �ٲٷ��� ���? EX. å�̸��� �ٲٰų�, ���ǻ縸 �ٲٰų� 
                          --  ���ǿϷ�(JSP���� ó���ϴ� ��� ä��)
                          --  ���� ���̻���Ʈ���� ���������� �� ��, �������� ��ư�� ������
                          --  ���� ���Խ� �����ߴ� ������ �̹� DB���� �ҷ��� ���� ������ �������� ��������
                          --  �ű⼭ �����ϰ����ϴ� ���� �����ϸ�
                          --  ��������� ��� ���� �����ϴ� ������� ���ν������� �����
                          --  (�����ϰ� ���� ���� ���� �̹� ���Ե� �� �״�� ���ν����� �Ѿ�� ������)
SELECT *
FROM TBL_TEXTBOOK;

--EXEC PRC_TEXTBOOK_UPDATE(BOOK_CODE, BOOK_NAME, BOOK_PUB);
EXEC PRC_TEXTBOOK_UPDATE(100, '���� ������', '���� ������');   -- ���� ������
EXEC PRC_TEXTBOOK_UPDATE(7, '�˰���', '�ֿ�');               -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_UPDATE
(
  V_BOOK_CODE   IN TBL_TEXTBOOK.BOOK_CODE%TYPE  -- �����ڵ�
, V_BOOK_NAME   IN TBL_TEXTBOOK.BOOK_NAME%TYPE  -- �����
, V_BOOK_PUB    IN TBL_TEXTBOOK.BOOK_PUB%TYPE   -- ���ǻ�
)
IS
    V_FLAT          NUMBER;         -- ������ ���� �Ǵ� ����
    NO_DATA_FOUND   EXCEPTION;      -- ������ ���� �� ���� ��������
BEGIN
    -- ���� �����ڵ� ��ȣ�� V_FLAT�� ���
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- �����ڵ尡 ������ '������ ����' �������� ���
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ������Ʈ ����
    UPDATE TBL_TEXTBOOK
    SET BOOK_NAME = V_BOOK_NAME
      , BOOK_PUB = V_BOOK_PUB
    WHERE BOOK_CODE = V_BOOK_CODE;
    
    -- ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;

----------------------
--PRC_TEXTBOOK_DELETE
SELECT *
FROM TBL_TEXTBOOK;

--EXEC PRC_TEXTBOOK_DELETE(BOOK_CODE);
EXEC PRC_TEXTBOOK_DELETE(100);   -- ���µ�����
EXEC PRC_TEXTBOOK_DELETE(2);     -- ��� ���� ������ ����
EXEC PRC_TEXTBOOK_DELETE(3);     -- ���� ������ ������ ����

CREATE OR REPLACE PROCEDURE PRC_TEXTBOOK_DELETE
(
  V_BOOK_CODE   IN TBL_TEXTBOOK.BOOK_CODE%TYPE  -- �����ڵ�
)
IS
    V_FLAT            NUMBER;       -- ������ ���� �Ǵ� ����
    NO_DATA_FOUND     EXCEPTION;    -- ������ ���� �� ���� ���� ����
    USING_IN_OCLASS   EXCEPTION;    -- ������������ ���� �ִ� ���簡 ���� �� ���� ���� ����
BEGIN
    -- ���� �����ڵ� ��ȣ�� V_FLAT�� ���
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- �����ڵ尡 ������ '������ ����' �������� ���
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ���������� �ִ� �����ڵ带 V_FLAT�� ���
    -- ����? �����ڵ尡 ��� ������ �Ǵ��ϱ� ����
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- ������ '������� ����' �������� ���
    IF (V_FLAT != 0)
        THEN RAISE USING_IN_OCLASS;
    END IF;
    
    -- ����Ʈ ����
    DELETE 
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    
    -- ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
        WHEN USING_IN_OCLASS
            THEN RAISE_APPLICATION_ERROR(-20009, '�̹� ���� ���񿡼� ��� ���� �����Դϴ�');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;

--------------------------------------------------------------------------------
--��������(���ǽ�, ����)
---------------------
-- PRC_OCOURSE_INSERT


---------------------
-- PRC_OCOURSE_UPDATE


---------------------
-- PRC_OCOURSE_DELETE


--------------------------------------------------------------------------------
--���ǰ���(����, ����)
-- PRC_ABLE_INSERT
SELECT *
FROM TBL_ABLE;

SELECT *
FROM TBL_PROFESSOR;

SELECT *
FROM TBL_CLASS;

-- EXEC PRC_ABLE_INSERT()
EXEC PRC_ABLE_INSERT(1, 'pro3');


CREATE OR REPLACE PROCEDURE PRC_ABLE_INSERT
( V_CLASS_CODE   IN TBL_ABLE.CLASS_CODE%TYPE 
, V_PRO_ID      IN  TBL_ABLE.PRO_ID%TYPE
)
IS
    V_ABLE_CODE     TBL_ABLE.ABLE_CODE%TYPE;
BEGIN

    INSERT INTO TBL_ABLE(ABLE_CODE, CLASS_CODE, PRO_ID)
    VALUES(TBL_ABLE_SEQ.NEXTVAL, V_CLASS_CODE, V_PRO_ID);
    
--    COMMIT;

END;
---------------------
-- PRC_ABLE_UPDATE


---------------------
-- PRC_ABLE_DELETE



--------------------------------------------------------------------------------
--��������[��������(���ǽ�, ����), ���ǰ���(����, ����)]
---------------------
-- PRC_OCLASS_INSERT --> Ư�� ��¥�� ��ϵ� ������ ���� �Ⱓ�� ��ϵ��� �ʰ�?
                     --> �����Ⱓ���� ����Ⱓ�� �� ������Ե� ���ϰ� �ؾ߰ڳ�

                      --> no data found �� �ڲ� �߳� ����? 
                      --  �������Է��̶� INSERT_DATE(������)�� ���µ�, 
                      --  �����ϰ� �������� INSERT_DATE(������)�� ���ؼ� �׷�����
                      --  ������ ����Ʈ���� SYSDATE�̹Ƿ� 
                      --  INSERT���ν������� �����ϰ� �������� SYSDATE�� ���ϸ� ��
                      
                      -- �̹� ������ ����(�ߺ��� ���� ���� ���� �ڵ�) --> 1�� ���Ǵ� ���Ÿ�, ����? --> V_FLAT�� 1�� �� �Է�
SELECT *
FROM TBL_OCLASS;
-- 1111, 2112, 3-1-

SELECT *
FROM TBL_ABLE;
--1~3

SELECT *
FROM TBL_OCOURSE;
--1
SELECT *
FROM TBL_TEXTBOOK;
--1~2

--EXEC PRC_OCLASS_INSERT(V_START_DATE, V_END_DATE, V_ABLE_CODE, V_OCOURSE_CODE, V_BOOK_CODE);
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> ������������ �� ū ������ �������� ��¥ ���� ��
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-08-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> �������ں��� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-08-01', 'YYYY-MM-DD'), 2, 1, 1);   
--> �������ں��� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-11-01', 'YYYY-MM-DD'), 2, 1, 1);   
--> �����Ϻ��� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 3, 1, 100);   
--> ���� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 100, 1, 1);   
--> ���� ������ �����Ͱ� ���� ���
220627, 230116
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD'), 3, 1, 5);   
--> ���������� �ִ� A������ �������� ��¥�� ���� ��¥�� �ֱ�
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2022-12-30', 'YYYY-MM-DD'), 3, 1, 5);   
--> ���������� �ִ� A������ �������� ��¥ ������ ��¥�� �ֱ�
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-20', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
--> ���������� �ִ� A������ �������� ��¥�� ���� �� ū ��¥�� �ֱ�
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 2);   
--> ������ ������

CREATE OR REPLACE PROCEDURE PRC_OCLASS_INSERT
(
    V_START_DATE    IN TBL_OCLASS.START_DATE%TYPE       -- ���� ������
,   V_END_DATE      IN TBL_OCLASS.END_DATE%TYPE         -- ���� ������
,   V_ABLE_CODE     IN TBL_OCLASS.ABLE_CODE%TYPE        -- ������ ������ ���� ���ǰ��ɿ��� ���̺� �ڵ��ȣ (FK : TBL_ABLE)
,   V_OCOURSE_CODE  IN TBL_OCLASS.OCOURSE_CODE%TYPE     -- �������� �ĺ��� ���� (FK : TBL_OCOURSE)
,   V_BOOK_CODE     IN TBL_OCLASS.BOOK_CODE%TYPE        -- ���� �ĺ��� ���� (FK : TBL_TEXTBOOK)
)
IS
    V_OCLASS_CODE    TBL_OCLASS.OCLASS_CODE%TYPE;   -- �������� �ĺ��� ���� (PK)
    V_START_DATE1    TBL_OCOURSE.START_DATE%TYPE;   -- ���������� ������ (�����Ⱓ���� ���� �Ⱓ�� ������� ���� ���ϵ���)
    V_END_DATE1      TBL_OCOURSE.END_DATE%TYPE;     -- ���������� ������ (�����Ⱓ���� ���� �Ⱓ�� ������� ���� ���ϵ���)
    V_FLAT           NUMBER;                        -- ������ ���� �Ǵ� ����
    WRONG_DATE1      EXCEPTION;                     -- ������������ ū ������ ��¥�� �Է��� �� ���� ���� ����
    WRONG_DATE       EXCEPTION;                     -- �������񿡼� ��¥�� �߸� �Է����� �� ���� ���� ����
                                                    -- (EX. �������� �����Ϻ��� ����)
    NO_PRO_FOUND     EXCEPTION;                     -- �����Ϸ��� �����ڵ� ��ȣ�� ���� �� ���� ����
    NO_BOOK_FOUND    EXCEPTION;                     -- �����Ϸ��� �����ڵ� ��ȣ�� ���� �� ���� ����
    OPENED_CLASS     EXCEPTION;                     -- ������ ��¥�� ������ ������ �ش� �Ⱓ ���� 
                                                    -- �ٸ� ������ �������� ���ϵ��� �ϴ� ���� ����
BEGIN
    -- �������� ���̺��� ������, ������ �� �ҷ�����
    --> �ҷ����� ����? �������� ����Ⱓ�� ������� ���ϵ��� ���ǹ��� ����� ����
    --> OCOURSE_CODE�� TBL_OCOURSE���� �ҷ����� NO DATA FOUND ���� ��, ���� �� �ҷ����� �� 
    --> �׷��� �� TBL_OCLASS�� OCOURSE_CODE�� �����
    SELECT START_DATE, END_DATE INTO V_START_DATE1, V_END_DATE1
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    -- ���� �Ⱓ���� ���� �Ⱓ�� ª������ �ʵ���
    IF( V_START_DATE < V_START_DATE1 OR V_END_DATE > V_END_DATE1 )
        THEN RAISE WRONG_DATE1;
    END IF;
    
    -- �������� �⺻���� SYSDATE�ε�, 
    -- �׺��� �������� ������ ���ϵ���, �����Ϻ��� �������� ������ ���ϵ��� 
    IF (SYSDATE > V_START_DATE OR V_START_DATE > V_END_DATE)
        THEN RAISE WRONG_DATE;
    END IF;
    
    -- ���� ��ȣ�� �����ڵ� ���� V_FLAT�� ���
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- ������ '���� ����' �������� ���
    IF (V_FLAT = 0)
        THEN RAISE NO_BOOK_FOUND;
    END IF;    
    
    -- ���ǰ��ɿ��� �ڵ��� ���� �Ǵ�  
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    -- ������ '������ ���� ����' �������� ���  
    IF (V_FLAT = 0)
        THEN RAISE NO_PRO_FOUND;
    END IF;
    
    -- ���ǰ��ɿ��� �ڵ� �� �ҷ�����
    --> �ҷ����� ����? ���ǰ��ɿ��� �ڵ尡 ��� ������ �Ǵ��ϱ� ����
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE ABLE_CODE = V_ABLE_CODE
      AND V_START_DATE BETWEEN START_DATE AND END_DATE          -- �������� ������¥ ���̿� ������
      AND V_END_DATE BETWEEN START_DATE AND END_DATE            -- �������� ������¥ ���̿� ������
       OR V_START_DATE < START_DATE AND V_END_DATE > END_DATE;  -- ��¥�� ������¥���� �� ū ��¥�� ���� ���ϰ�
    -- ������ '�߸��� �Ⱓ �Է�' �������� ���  
    IF (V_FLAT != 0)
        THEN RAISE OPENED_CLASS;
    END IF;
    
    -- �μ�Ʈ ����  
    INSERT INTO TBL_OCLASS(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
    VALUES(TBL_OCLASS_SEQ.NEXTVAL, V_START_DATE, V_END_DATE, V_ABLE_CODE, V_OCOURSE_CODE, V_BOOK_CODE);
    
    -- ����ó��        
    EXCEPTION
        WHEN NO_BOOK_FOUND
            THEN RAISE_APPLICATION_ERROR(-20012, '������ ���簡 ����');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20013, '������ ������ ����');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20014, '�̹� �ش� ������ �ش� �Ⱓ�� ������ ������ �ֽ��ϴ�, �ٸ� ������ �������ּ���.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20015, '������ �������� ���� ������ ������ ������ �� �����ϴ�.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20015, '�߸��� ��¥ �Է�.');
----        WHEN OTHERS
----            THEN ROLLBACK;
----    COMMIT;

END;

---------------------
-- PRC_OCLASS_UPDATE -->�����Ⱓ�� ���������� ��� �ȵǵ����ϴ� �׽�Ʈ����

SELECT *
FROM TBL_OCLASS;

SELECT *
FROM TBL_ABLE;

SELECT *
FROM TBL_TEXTBOOK;

SELECT *
FROM TBL_POINT;

SELECT * 
FROM TBL_OCOURSE;

--EXEC PRC_OCLASS_UPDATE(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
EXEC PRC_OCLASS_UPDATE(100, TO_DATE('2022-06-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1, 1, 1);   
--> ���� �������� ������
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2021-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2021-12-25', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> ������������ �� ū ������ �������� ��¥ ���� ��
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-08-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> �������ں��� ���� ������
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-08-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> �������ں��� ���� ������
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-11-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> �����Ϻ��� ���� ������
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1, 1, 1);   
--> ���� ���� ������
EXEC PRC_OCLASS_UPDATE(3, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1, 1, 1);   
--> ���� ������ �����Ͱ� ���� ���
  
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 1, 5);   
--> ���������� �ִ� A������ �������� ��¥�� ���� ��¥�� �ֱ�
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-27', 'YYYY-MM-DD'), TO_DATE('2022-12-30', 'YYYY-MM-DD'), 3, 1, 5);   
--> ���������� �ִ� A������ �������� ��¥ ������ ��¥�� �ֱ�
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2022-12-20', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 3, 1, 5);   
--> ���������� �ִ� A������ �������� ��¥�� ���� �� ū ��¥�� �ֱ�
EXEC PRC_OCLASS_UPDATE(17, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-11', 'YYYY-MM-DD'), 3, 1, 5);   
--> ������ ������

CREATE OR REPLACE PROCEDURE PRC_OCLASS_UPDATE
(
  V_OCLASS_CODE     IN TBL_OCLASS.OCLASS_CODE%TYPE      -- �������� �ĺ��� ���� (PK)
, V_START_DATE      IN TBL_OCLASS.START_DATE%TYPE       -- ���� ������
, V_END_DATE        IN TBL_OCLASS.END_DATE%TYPE         -- ���� ������
, V_ABLE_CODE       IN TBL_OCLASS.ABLE_CODE%TYPE        -- ������ ������ ���� ���ǰ��ɿ��� ���̺� �ڵ��ȣ (FK : TBL_ABLE)
, V_OCOURSE_CODE    IN TBL_OCLASS.OCOURSE_CODE%TYPE     -- �������� �ĺ��� ���� (FK : TBL_OCOURSE)
, V_BOOK_CODE       IN TBL_OCLASS.BOOK_CODE%TYPE        -- ���� �ĺ��� ���� (FK : TBL_TEXTBOOK)
)
IS
    V_START_DATE1    TBL_OCOURSE.START_DATE%TYPE;   -- ���������� ������ (�����Ⱓ���� ���� �Ⱓ�� ������� ���� ���ϵ���)
    V_END_DATE1      TBL_OCOURSE.END_DATE%TYPE;     -- ���������� ������ (�����Ⱓ���� ���� �Ⱓ�� ������� ���� ���ϵ���)
    V_INSERT_DATE    TBL_OCLASS.INSERT_DATE%TYPE;   -- ������ ����
    V_FLAT           NUMBER;                        -- ������ ���� �Ǵ� ����
    NO_DATA_FOUND    EXCEPTION;                     -- ������ ���� �� ���� ���� ����
    WRONG_DATE1      EXCEPTION;                     -- ������������ ū ������ ��¥�� �Է��� �� ���� ���� ����
    WRONG_DATE       EXCEPTION;                     -- �������񿡼� ��¥�� �߸� �Է����� �� ���� ���� ����
                                                    -- (EX. �������� �����Ϻ��� ����)
    NO_PRO_FOUND     EXCEPTION;                     -- �����Ϸ��� �����ڵ� ��ȣ�� ���� �� ���� ����
    NO_BOOK_FOUND    EXCEPTION;                     -- �����Ϸ��� �����ڵ� ��ȣ�� ���� �� ���� ����
    OPENED_CLASS     EXCEPTION;                     -- ������ ��¥�� ������ ������ �ش� �Ⱓ ���� 
                                                    -- �ٸ� ������ �������� ���ϵ��� �ϴ� ���� ����
BEGIN
    -- �������� �ڵ��� ���� �Ǵ�
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- ������ '������ ����' �������� ���
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- �������� ���̺��� ������, ������ �� �ҷ�����
    --> �ҷ����� ����? �������� ����Ⱓ�� ������� ���ϵ��� ���ǹ��� ����� ����
    --> OCOURSE_CODE�� TBL_OCOURSE���� �ҷ����� NO DATA FOUND ���� ��, ���� �� �ҷ����� �� 
    --> �׷��� �� TBL_OCLASS�� OCOURSE_CODE�� �����
    SELECT START_DATE, END_DATE INTO V_START_DATE1, V_END_DATE1
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    -- ���� �Ⱓ���� ���� �Ⱓ�� ª������ �ʵ���
    IF( V_START_DATE < V_START_DATE1 OR V_END_DATE > V_END_DATE1 )
        THEN RAISE WRONG_DATE1;
    END IF;
    
    -- ������ �� �ҷ�����
    SELECT INSERT_DATE INTO V_INSERT_DATE
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- �����Ϻ��� �������� ������ ���ϵ���, �����Ϻ��� �������� ������ ���ϵ���
    IF (V_INSERT_DATE > V_START_DATE OR V_START_DATE > V_END_DATE)
        THEN RAISE WRONG_DATE;
    END IF;

    -- ���� �ڵ��� ���� �Ǵ�
    SELECT COUNT(BOOK_CODE) INTO V_FLAT
    FROM TBL_TEXTBOOK
    WHERE BOOK_CODE = V_BOOK_CODE;
    -- ������ '���� ����' �������� ���
    IF (V_FLAT = 0)
        THEN RAISE NO_BOOK_FOUND;
    END IF;    

    -- ���ǰ��ɿ��� �ڵ��� ���� �Ǵ�    
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    -- ������ '������ ���� ����' �������� ���    
    IF (V_FLAT = 0)
        THEN RAISE NO_PRO_FOUND;
    END IF;
    
    -- ���ǰ��ɿ��� �ڵ� �� �ҷ�����
    --> �ҷ����� ����? ���ǰ��ɿ��� �ڵ尡 ��� ������ �Ǵ��ϱ� ����
    SELECT COUNT(ABLE_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE ABLE_CODE = V_ABLE_CODE
      AND V_START_DATE BETWEEN START_DATE AND END_DATE          -- �������� ������¥ ���̿� ������
      AND V_END_DATE BETWEEN START_DATE AND END_DATE            -- �������� ������¥ ���̿� ������
       OR V_START_DATE < START_DATE AND V_END_DATE > END_DATE;  -- ��¥�� ������¥���� �� ū ��¥�� ���� ���ϰ�
    -- ������ '�߸��� �Ⱓ �Է�' �������� ���
    IF (V_FLAT != 0)
        THEN RAISE OPENED_CLASS;
    END IF;
    
    -- ������Ʈ ����
    UPDATE TBL_OCLASS
    SET START_DATE = V_START_DATE
      , END_DATE = V_END_DATE
      , ABLE_CODE = V_ABLE_CODE
      , OCOURSE_CODE = V_OCOURSE_CODE
      , BOOK_CODE = V_BOOK_CODE
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
        WHEN NO_BOOK_FOUND
            THEN RAISE_APPLICATION_ERROR(-20012, '������ ���簡 ����');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20013, '������ ������ ����');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20014, '�̹� �ش� ������ ���� �Ⱓ�� ������ ������ �ֽ��ϴ�, �ٸ� ������ �������ּ���.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20015, '������ �������� ���� ������ ������ ������ �� �����ϴ�.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20015, '�߸��� ��¥ �Է�.');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
    
END;

---------------------
-- PRC_OCLASS_DELETE        --> A������ �����Ǹ� A���� ���� ���� �����͵� �����ǵ���??
                            --  OCLASS_CODE�� ���� POINT_CODE�� ����
                            --  BEFORE ROW Ʈ���Ÿ� ���� �ذ�Ϸ� (�ڽ� �����͸� ���� ���� �� �θ� ������ ����)
SELECT *
FROM TBL_OCLASS;

SELECT *
FROM TBL_POINT;

--EXEC PRC_OCLASS_DELETE(OCLASS_CODE)
EXEC PRC_OCLASS_DELETE(100);   -- ���µ�����
EXEC PRC_OCLASS_DELETE(2);     -- ������ �ο��� ������ ����
EXEC PRC_OCLASS_DELETE(3);     -- ������ �ο��� ������ ����
EXEC PRC_OCLASS_DELETE(18);    -- ������ �ο��� ��������
EXEC PRC_OCLASS_DELETE(19);    -- ���� ������ ������ ����

CREATE OR REPLACE PROCEDURE PRC_OCLASS_DELETE
(
    V_OCLASS_CODE    IN TBL_OCLASS.OCLASS_CODE%TYPE     -- �������� �ĺ��� ���� (PK)
)
IS
    V_FLAT          NUMBER;         -- ������ ���� �Ǵ� ����
    NO_DATA_FOUND   EXCEPTION;      -- ������ ���� �� ���� ���� ����
    GRADE_AWARDED   EXCEPTION;      -- �ο��� ������ ���� �Ǵ��� �� ���� ���� ����
BEGIN
    -- �������� �ڵ��� ���� �Ǵ�
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- ������ '������ ����' �������� ���
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ���� �ڵ��� ���� �Ǵ�
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_GRADE
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- ������ '�̹� ������ �ο��� ����' �������� ���
    IF (V_FLAT != 0)
        THEN RAISE GRADE_AWARDED;
    END IF;
    
    -- ����Ʈ ����
    DELETE 
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;  
    
    -- ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
         WHEN GRADE_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20010, '�̹� ������ �ο��� �����Դϴ�');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
    
END;

---------------------
-- TRG_OCLASS_DELETE
CREATE OR REPLACE TRIGGER TRG_OCLASS_DELETE
        BEFORE                  
        DELETE ON TBL_OCLASS    -- ���������� �����ϱ� ����
        FOR EACH ROW            
DECLARE

BEGIN
    DELETE                      -- ���� �����͸� ���� ����
    FROM TBL_POINT
    WHERE OCLASS_CODE = :OLD.OCLASS_CODE;
END;

--DROP TRIGGER TRG_OCLASS_DELETE;
--------------------------------------------------------------------------------
--����{��������[��������(���ǽ�, ����), ���ǰ���(����, ����)]}

----------------------
--PRC_POINT_INSERT   --> ���� ���� 0�� �ƴ϶���� ���� ����
                     --  ������ ���߿� �ο��ϱ� ���� ���� 0�� ��쵵 �����Ͱ� ������ 
                     --  �׷� ������Ʈ���� 0�� ��찡 ���� �ؾ��ϳ�?

SELECT *
FROM TBL_POINT;

SELECT *
FROM TBL_OCLASS;

--EXEC PRC_POINT_INSERT(V_POINT_ATTEND, V_POINT_PRACTICE, V_POINT_WRITE, V_OCLASS_CODE);
EXEC PRC_POINT_INSERT(100);   -- ���µ����� 
EXEC PRC_POINT_INSERT(20, 20, 60, 1);     -- �ߺ������� 
EXEC PRC_POINT_INSERT(-1, 60, 20, 2);     -- �⼮ ����
EXEC PRC_POINT_INSERT(20, -1, 60, 2);     -- �Ǳ� ���� 
EXEC PRC_POINT_INSERT(20, 60, -1, 2);     -- �ʱ� ���� 
EXEC PRC_POINT_INSERT(100, 100, 100, 3);  -- ���� 100 �̻� 
EXEC PRC_POINT_INSERT(1, 1, 1, 2);        -- ���� 100 ���� 
EXEC PRC_POINT_INSERT(20, 20, 60, 2);     -- ������ ������ 
EXEC PRC_POINT_INSERT(0, 0, 0, 18);        -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_POINT_INSERT
(
  V_POINT_ATTEND      IN TBL_POINT.POINT_ATTEND%TYPE        -- �⼮ ����
, V_POINT_PRACTICE    IN TBL_POINT.POINT_PRACTICE%TYPE      -- �Ǳ� ����
, V_POINT_WRITE       IN TBL_POINT.POINT_WRITE%TYPE         -- �ʱ� ����
, V_OCLASS_CODE       IN TBL_POINT.OCLASS_CODE%TYPE         -- �������� �ڵ� (FK : TBL_OCLASS)
)
IS
    V_POINT_CODE        TBL_POINT.POINT_CODE%TYPE;      -- ���� ���̺� �ĺ��� �ڵ� (PK)
    V_FLAT              NUMBER;                         -- ������ ���� �Ǵ� ����
    NEEDS_TO_BE_100     EXCEPTION;                      -- ������ ���� 100�� �ȵ� �� ����ϴ� ���� ����
    LOWER_THAN_ZERO     EXCEPTION;                      -- �⼮/�Ǳ�/�ʱ� �� �׸��� ������ ������ �� ����ϴ� ���� ����
    NO_DATA_FOUND       EXCEPTION;                      -- ������ ���� �� ���� ���� ����
    POINT_AWARDED       EXCEPTION;                      -- �̹� ������ �ο��� ������ �� ���� ���� ����
BEGIN
    -- �������� ���̺��� ���� ���������ڵ��� ���� �Ǵ� 
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- ������ '������ ����' �������� ���
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ���� ���̺� ��� ���� ���������ڵ� ���� �Ǵ�
    SELECT COUNT(OCLASS_CODE) INTO V_FLAT
    FROM TBL_POINT
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    -- ������ '������ �ο��� ����' ���� ���� ���
    IF (V_FLAT != 0)
        THEN RAISE POINT_AWARDED;
    END IF;
    
    -- �� �׸��� ������ ���
    IF (V_POINT_ATTEND < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_PRACTICE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_WRITE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    -- ������ ���� 100�� �ƴҰ��
        -- ������ ���߿� �ο��ϱ� ���� ���� 0�� ��쵵 �����Ͱ� ������ --> �׷� ������Ʈ���� 0�� ��찡 ���� �ؾ��ϳ�?
    IF (V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 0 AND
        V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 100)
        THEN RAISE NEEDS_TO_BE_100;
    END IF;
    
    -- �μ�Ʈ ����
    INSERT INTO TBL_POINT(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE, OCLASS_CODE)
    VALUES(TBL_POINT_SEQ.NEXTVAL, V_POINT_ATTEND, V_POINT_PRACTICE, V_POINT_WRITE, V_OCLASS_CODE);
    
    -- ����ó��
    EXCEPTION
        WHEN LOWER_THAN_ZERO
            THEN RAISE_APPLICATION_ERROR(-20003, '��ȿ���� ���� ������');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20004, '���� 100���� �Ǿ�� �մϴ�');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
        WHEN POINT_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20008, '�̹� ������ �ο��� �����Դϴ�');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
    
END;

----------------------
--PRC_POINT_UPDATE
SELECT *
FROM TBL_POINT;

--EXEC PRC_POINT_UPDATE(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE)
EXEC PRC_POINT_UPDATE(100, 20, 20, 60);   -- ���µ����� 
EXEC PRC_POINT_UPDATE(3, -1, 60, 20);     -- �⼮ ����
EXEC PRC_POINT_UPDATE(3, 20, -1, 60);     -- �Ǳ� ���� 
EXEC PRC_POINT_UPDATE(3, 20, 60, -1);     -- �ʱ� ���� 
EXEC PRC_POINT_UPDATE(3, 100, 100, 100);  -- ���� 100 �̻� 
EXEC PRC_POINT_UPDATE(3, 1, 1, 1);        -- ���� 100 ���� 
EXEC PRC_POINT_UPDATE(3, 10, 20, 70);     -- ������ ������

CREATE OR REPLACE PROCEDURE PRC_POINT_UPDATE
(
  V_POINT_CODE      IN TBL_POINT.POINT_CODE%TYPE        -- ���� ���̺� �ĺ��� �ڵ� (PK)
, V_POINT_ATTEND    IN TBL_POINT.POINT_ATTEND%TYPE      -- �⼮ ����
, V_POINT_PRACTICE  IN TBL_POINT.POINT_PRACTICE%TYPE    -- �Ǳ� ����
, V_POINT_WRITE     IN TBL_POINT.POINT_WRITE%TYPE       -- �ʱ� ����
)
IS
    V_FLAT              NUMBER;         -- ������ ���� �Ǵ� ����
    NEEDS_TO_BE_100     EXCEPTION;      -- ������ ���� 100�� �ȵ� �� ����ϴ� ���� ����
    LOWER_THAN_ZERO     EXCEPTION;      -- �⼮/�Ǳ�/�ʱ� �� �׸��� ������ ������ �� ����ϴ� ���� ����
    NO_DATA_FOUND       EXCEPTION;      -- ������ ���� �� ���� ���� ����
BEGIN
    -- ���� ���̺� ���������ڵ��� ���� �Ǵ� 
    SELECT COUNT(POINT_CODE) INTO V_FLAT
    FROM TBL_POINT
    WHERE POINT_CODE = V_POINT_CODE;
    -- ������ '������ ����' �������� ���
    IF (V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- �� �׸��� ������ ���
    IF (V_POINT_ATTEND < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_PRACTICE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    ELSIF (V_POINT_WRITE < 0)
        THEN RAISE LOWER_THAN_ZERO;
    END IF;
    
    -- ������ ���� 100�� �ƴҰ��
    IF (V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 100)
        THEN RAISE NEEDS_TO_BE_100;
    END IF;
    
    -- ������Ʈ ����
    UPDATE TBL_POINT
    SET POINT_ATTEND = V_POINT_ATTEND
      , POINT_PRACTICE = V_POINT_PRACTICE
      , POINT_WRITE = V_POINT_WRITE
    WHERE POINT_CODE = V_POINT_CODE;
    
    -- ����ó��
    EXCEPTION
        WHEN LOWER_THAN_ZERO
            THEN RAISE_APPLICATION_ERROR(-20003, '��ȿ���� ���� ������');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20004, '���� 100���� �Ǿ�� �մϴ�');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;

-------------------
--PRC_POINT_DELETE  

SELECT *
FROM TBL_POINT;

--EXEC PRC_POINT_DELETE(BOOK_CODE);
EXEC PRC_POINT_DELETE(100);   -- ���µ�����
EXEC PRC_POINT_DELETE(3);     -- ���� ������ ������ ����

CREATE OR REPLACE PROCEDURE PRC_POINT_DELETE
(
  V_POINT_CODE   IN TBL_POINT.POINT_CODE%TYPE   -- ���� ���̺� �ĺ��� �ڵ� (PK)
)
IS
    V_FLAT          NUMBER;         -- ������ ���� �Ǵ� ����
    NO_DATA_FOUND   EXCEPTION;      -- ������ ���� �� ���� ���� ����
BEGIN
    -- ���� ���̺� ���������ڵ��� ���� �Ǵ�
    SELECT COUNT(POINT_CODE) INTO V_FLAT
    FROM TBL_POINT
    WHERE POINT_CODE = V_POINT_CODE;
    -- ������ '������ ����' �������� ��� 
    IF(V_FLAT = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    
    -- ����Ʈ ����
    DELETE 
    FROM TBL_POINT
    WHERE POINT_CODE = V_POINT_CODE;

    -- ����ó��
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20002, '������ ����');
--        WHEN OTHERS
--            THEN ROLLBACK;
--    COMMIT;
END;





