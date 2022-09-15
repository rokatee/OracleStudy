SELECT USER
FROM DUAL;
-- NO1

-- ���� �޽��� ���
/*
�� ������ �ߺ� (20001~20100)

-- -20001, '�̹� ��ϵ� �������Դϴ�.'
-- -20002, '�̹� ��ϵ� ������Դϴ�.'
-- -20003, '�̹� ��ϵ� ������Դϴ�.'
-- -20004, '�̹� ��ϵ� �������Դϴ�.'
-- -20005, '�̹� ��ϵ� �������Դϴ�.'
-- -20006, '�̹� ��ϵ� ���ǽǸ��Դϴ�.'
-- -20007, '�̹� ��ϵ� ������Դϴ�.'
-- -20008, '�̹� ��ϵ� ���̵� �Ǵ� �ֹε�Ϲ�ȣ�Դϴ�.'
-- -20009, '�̹� ��ϵ� Ż�������Դϴ�.'
-- -20010, '�̹� ����� �����Դϴ�.'
-- -20011, '�̹� ��ϵ� �����Դϴ�.'
-- -20012, '�̹� ������ �ο��� �����Դϴ�.'
-- -20013, '�̹� ������ �Էµ� �������Դϴ�.'

�� ���� ������ (20101~20200)

-- -20101, '��ϵ��� ���� �������ڵ��Դϴ�.'
-- -20102, '��ϵ��� ���� ���̵��Դϴ�.'
-- -20103, '��ϵ��� ���� ������Դϴ�.'
-- -20104, '��ϵ��� ���� �����/�������Դϴ�.'
-- -20105, '��ϵ��� ���� ���ǰ��ɿ����ڵ��Դϴ�.'
-- -20106, '��ϵ��� ���� �����ڵ��Դϴ�.'
-- -20107, '��ϵ��� ���� ���ǽ��ڵ��Դϴ�.'
-- -20108, '��ϵ��� ���� ���������ڵ��Դϴ�.'
-- -20109, '��ϵ��� ���� �����ڵ��Դϴ�.'
-- -20110, '��ϵ��� ���� Ż�������ڵ��Դϴ�.'
-- -20111, '��ϵ��� ���� ������û�ڵ��Դϴ�.'
-- -20112, '��ϵ��� ���� �ߵ�Ż���ڵ��Դϴ�.'
-- -20113, '��ϵ��� ���� ���������ڵ��Դϴ�.'
-- -20114, '��ϵ��� ���� �����ڵ��Դϴ�.'

�� ��� ���� (20201~20300)

-- -20201, '���ǰ��ɿ��ο��� ��� ���� �������Դϴ�.'
-- -20202, '�������񿡼� ��� ���� �������Դϴ�.'
-- -20203, '������ �ο��� ������ ������ �� �����ϴ�.'
-- -20204, '��� ���� ���ǽ��Դϴ�.'
-- -20205, '��� ���� �����Դϴ�.'
-- -20206, '�ش� �Ⱓ�� ������ ������ �����Դϴ�. �ٸ� ������ �������ּ���.'
-- -20207, '������ �ο��� ������ ������ �� �����ϴ�.'
-- -20208, '�̹� ������û�� �� �л��Դϴ�.'
-- -20209, '�̹� �̿� ���� Ż�������ڵ��Դϴ�.'
-- -20210, '������ �ο��� ������û������ ������ �� �����ϴ�.'

�� �Ⱓ ���� (20301~20400)

-- -20301, '�������� ������ �����Դϴ�.'
-- -20302, '�̹� ���� ��¥�Դϴ�.'
-- -20303, '������ ������ ����Ⱓ�� �Ѿ�� ������ �� �����ϴ�.'
-- -20304, '�߸��� ��¥�� �Է��߽��ϴ�.'
-- -20305, '������û �Ⱓ�� �ƴմϴ�.'
-- -20306, 'Ż�����ڰ� ���� �Ⱓ�� ������ϴ�.'
-- -20307, '�����Է±Ⱓ�� �ƴմϴ�.'

�� ��Ÿ (20401~20500)
-- -20401, '��ȿ���� ���� �����Դϴ�.'
-- -20402, '�� ������ 100�� �Ǿ�� �մϴ�.'
-- -20403, '��ȿ���� ���� �����Դϴ�.'
-- -20308, '���� �������� ���� �����Դϴ�.'

*/


-- TBL_ADMIN(������) ���̺� ----------------------------------------------------

-- ���ν��� ����(INSERT)
CREATE OR REPLACE PROCEDURE PRC_ADMIN_INSERT
( V_ADMIN_ID        IN TBL_ADMIN.ADMIN_ID%TYPE
, V_ADMIN_PW        IN TBL_ADMIN.ADMIN_PW%TYPE
, V_ADMIN_NAME      IN TBL_ADMIN.ADMIN_NAME%TYPE
)
IS
BEGIN
    INSERT INTO TBL_ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NAME)
    VALUES(V_ADMIN_ID, V_ADMIN_PW, V_ADMIN_NAME);
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20001, '�̹� ��ϵ� �������Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;

-- ���ν��� ����(UPDATE)
CREATE OR REPLACE PROCEDURE PRC_ADMIN_UPDATE
( V_ADMIN_ID        IN TBL_ADMIN.ADMIN_ID%TYPE
, V_ADMIN_PW        IN TBL_ADMIN.ADMIN_PW%TYPE
, V_ADMIN_NAME      IN TBL_ADMIN.ADMIN_NAME%TYPE
)
IS
    V_CHECK     TBL_ADMIN.ADMIN_ID%TYPE;

BEGIN
    -- �̹� �ִ� ADMIN_ID���� Ȯ�� (���� �� ���� �߻�)
    SELECT ADMIN_ID INTO V_CHECK
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    UPDATE TBL_ADMIN
    SET ADMIN_PW = V_ADMIN_PW
      , ADMIN_NAME = V_ADMIN_NAME
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20101, '��ϵ��� ���� �������ڵ��Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;

END;

-- ���ν��� ����(DELETE)
CREATE OR REPLACE PROCEDURE PRC_ADMIN_DELETE
( V_ADMIN_ID        IN TBL_ADMIN.ADMIN_ID%TYPE
)
IS
    V_CHECK     TBL_ADMIN.ADMIN_ID%TYPE;
BEGIN
    -- �̹� ��ϵ� ADMIN_ID���� Ȯ�� (���� �� ���� �߻�)
    SELECT ADMIN_ID INTO V_CHECK
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    DELETE
    FROM TBL_ADMIN
    WHERE ADMIN_ID = V_ADMIN_ID;
    
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20101, '��ϵ��� ���� �������ڵ��Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_PROFESSOR(����) ���̺� --------------------------------------------------

-- ���ν��� ����(INSERT) : PRO_PHONE�̶� PRO_EMAIL�� �ΰ� ����ε� ���⼭�� �� ������ ���ν��� �۵��� �� ��
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_INSERT
( V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
, V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_PRO_SSN     IN TBL_PROFESSOR.PRO_SSN%TYPE
, V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
, V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_PRO_PW    TBL_PROFESSOR.PRO_PW%TYPE;
    
BEGIN
    -- �ߺ� Ȯ���� PRO_SSN �÷��� UNIQUE ���� �߰��ϸ� �ذ�� ��? (���� �Ϸ�)

    -- ��й�ȣ �⺻��(�ֹι�ȣ ���ڸ�) ����
    V_PRO_PW := SUBSTR(V_PRO_SSN, 8);
    
    -- ������ INSERT
    INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
    VALUES(V_PRO_ID, V_PRO_NAME, V_PRO_PW, V_PRO_SSN, V_PRO_EMAIL, V_PRO_PHONE);
    
    -- ���� ó��
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20002, '�̹� ��ϵ� ������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- ���ν��� ����(UPDATE) : ������ ������ �������� ������ ������ ���� �ʿ� (�Ϸ�)
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
( V_PRO_ID      IN TBL_PROFESSOR.PRO_ID%TYPE
, V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_PRO_PW      IN TBL_PROFESSOR.PRO_PW%TYPE
, V_PRO_EMAIL   IN TBL_PROFESSOR.PRO_EMAIL%TYPE
, V_PRO_PHONE   IN TBL_PROFESSOR.PRO_PHONE%TYPE
)
IS
    V_CHECK_ID      TBL_PROFESSOR.PRO_ID%TYPE;
    
BEGIN
    -- ��ϵǾ� �ִ� �������� �˻� (���� �� ���� �߻�)
    SELECT PRO_ID INTO V_CHECK_ID
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    -- ������ UPDATE : ������ SSN���� �ϴ� �� ��������? ID�� ������ �� �ְ�... (���� �Ϸ�: ID ���� X)
    UPDATE TBL_PROFESSOR
    SET PRO_NAME = V_PRO_NAME
      , PRO_PW = V_PRO_PW
      , PRO_EMAIL = V_PRO_EMAIL
      , PRO_PHONE = V_PRO_PHONE
    WHERE PRO_ID = V_PRO_ID;
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '��ϵ��� ���� ���̵��Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- ���ν��� ����(DELETE) �� TRIGGER(TBL_ABLE)
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
( V_PRO_ID  IN TBL_PROFESSOR.PRO_ID%TYPE
)
IS
    V_CHECK_ID    TBL_PROFESSOR.PRO_ID%TYPE;
    V_COUNT       NUMBER := 0;
    
    ALREADY_USE   EXCEPTION;
    
BEGIN
    -- ABLE_ID �����ϴ��� ��ȿ�� �˻� (���� �� ���� �߻�)
    SELECT PRO_ID INTO V_CHECK_ID
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    SELECT COUNT(ABLE_CODE) INTO V_COUNT
    FROM TBL_ABLE
    WHERE PRO_ID = V_PRO_ID;
    
    IF (V_COUNT > 0)
        THEN RAISE ALREADY_USE;
    END IF;

    -- ������ DELETE
    DELETE
    FROM TBL_PROFESSOR
    WHERE PRO_ID = V_PRO_ID;
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '��ϵ��� ���� ���̵��Դϴ�.');
                 ROLLBACK;
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR( -20201, '���ǰ��ɿ��ο��� ��� ���� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_CLASS(����) ���̺� ------------------------------------------------------

-- ���ν��� ����(INSERT)
CREATE OR REPLACE PROCEDURE PRC_CLASS_INSERT
( V_CLASS_NAME      IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CLASS_CODE        TBL_CLASS.CLASS_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- �̹� ��ϵ� ��������� Ȯ�� : �̰� �׳� UNIQUE ���� �߰��ؼ� �ذ��ϸ� ���� �ʳ�? (�̴�� ���� ������)

    -- ������ INSERT
    INSERT INTO TBL_CLASS(CLASS_CODE, CLASS_NAME)
    VALUES(TBL_CLASS_SEQ.NEXTVAL, V_CLASS_NAME);
    
    -- ���� ó��
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20003, '�̹� ��ϵ� ������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- ���ν��� ����(UPDATE) �� TRIGGER(TBL_ABLE) 
--                          : ����� �ٲ�� �Ŵϱ� ���� ���� ���� ���� ���̺��� ������ �ʿ䰡 ����? �ͱ⵵ �� (���� �Ϸ�)
CREATE OR REPLACE PROCEDURE PRC_CLASS_UPDATE
( V_CLASS_CODE  IN TBL_CLASS.CLASS_CODE%TYPE
, V_CLASS_NAME  IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
BEGIN
    -- �̹� ��ϵ� �����ڵ����� Ȯ��  (���� �� ���� �߻�)
    SELECT CLASS_CODE INTO V_CHECK_CODE
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    -- ������ UPDATE
    UPDATE TBL_CLASS
    SET CLASS_NAME = V_CLASS_NAME
    WHERE CLASS_CODE = V_CLASS_CODE;
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20103, '��ϵ��� ���� ������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;


-- ���ν��� ����(DELETE) �� TRIGGER(TBL_ABLE)
CREATE OR REPLACE PROCEDURE PRC_CLASS_DELETE
( V_CLASS_NAME  IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    V_COUNT         NUMBER;
    
    ALREADY_USE   EXCEPTION;
    
BEGIN
    -- CLASS_NAME�� �����ϴ� CLASS_CODE ã��
    SELECT CLASS_CODE INTO V_CHECK_CODE
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;

    -- �����Ϸ��� �ڵ带 �̿� ���� �ڽ� ���̺��� �ִ��� �˻�
    SELECT COUNT(ABLE_CODE) INTO V_COUNT
    FROM TBL_ABLE
    WHERE CLASS_CODE = V_CHECK_CODE;
    
    -- �ִٸ� ���� �߻�
    IF (V_COUNT != 0)
        THEN RAISE ALREADY_USE;
    END IF;
    
    -- ������ DELETE
    DELETE
    FROM TBL_CLASS
    WHERE CLASS_CODE = V_CHECK_CODE;
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20103, '��ϵ��� ���� ������Դϴ�.');
                 ROLLBACK;
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR( -20201, '���ǰ��ɿ��ο��� ��� ���� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_ABLE(���� ���� ����) ���̺� ---------------------------------------------

-- ���ν��� ����(INSERT)
CREATE OR REPLACE PROCEDURE PRC_ABLE_INSERT
( V_PRO_NAME        IN TBL_PROFESSOR.PRO_NAME%TYPE
, V_CLASS_NAME      IN TBL_CLASS.CLASS_NAME%TYPE
)
IS
    V_PRO_ID        TBL_PROFESSOR.PRO_ID%TYPE;
    V_CLASS_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    
    V_CHECK_CODE    TBL_ABLE.ABLE_CODE%TYPE;
    
BEGIN
    -- ����ڿ��� �Է� ���� ������ �ش��ϴ� ���� ���̵� �������� ����
    SELECT PRO_ID INTO V_PRO_ID
    FROM TBL_PROFESSOR
    WHERE PRO_NAME = V_PRO_NAME;
    
    -- ����ڿ��� �Է� ���� ����� �ش��ϴ� ���� ���̵� �������� ����
    SELECT CLASS_CODE INTO V_CLASS_CODE
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;
    
    -- �̹� ��ϵ� ���������� Ȯ�� : �̰͵� �ΰ� ��� UNIQUE ���� �ʿ� (���� �Ϸ�)

    -- ������ INSERT
    INSERT INTO TBL_ABLE(ABLE_CODE, PRO_ID, CLASS_CODE)
    VALUES(TBL_ABLE_SEQ.NEXTVAL, V_PRO_ID, V_CLASS_CODE);
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20104, '��ϵ��� ���� �����/�������Դϴ�.');
                 ROLLBACK;
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20004, '�̹� ��ϵ� �������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- ���ν��� ����(UPDATE) �� TRIGGER(TBL_OCLASS)
--                           : �̰͵� ������ ���� ���� ���� �ڵ� ������ ���� �Ŵϱ� �ʿ� ��������?
CREATE OR REPLACE PROCEDURE PRC_ABLE_UPDATE
( V_ABLE_CODE   IN TBL_ABLE.ABLE_CODE%TYPE
, V_CLASS_NAME  IN TBL_CLASS.CLASS_NAME%TYPE
, V_PRO_NAME    IN TBL_PROFESSOR.PRO_NAME%TYPE
)
IS
    V_PRO_ID        TBL_PROFESSOR.PRO_ID%TYPE;
    V_CLASS_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    
BEGIN
    -- ����ڿ��� �Է� ���� ������ �ش��ϴ� ���� ���̵� �������� ����
    SELECT PRO_ID INTO V_PRO_ID
    FROM TBL_PROFESSOR
    WHERE PRO_NAME = V_PRO_NAME;
    
    -- ����ڿ��� �Է� ���� ����� �ش��ϴ� ���� ���̵� �������� ����
    SELECT CLASS_CODE INTO V_CLASS_CODE
    FROM TBL_CLASS
    WHERE CLASS_NAME = V_CLASS_NAME;
    
    -- �̹� ��ϵ� ���� ���� ���� �ڵ����� Ȯ�� (���� �� ���� �߻�)
    SELECT ABLE_CODE INTO V_CHECK_CODE
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- ������ UPDATE
    UPDATE TBL_ABLE
    SET CLASS_CODE = V_CLASS_CODE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    UPDATE TBL_ABLE
    SET PRO_ID = V_PRO_ID
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20104, '��ϵ��� ���� �����/�������Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    ROLLBACK;
            
    COMMIT;
    
END;

-- ���ν��� ����(DELETE) �� TRIGGER(TBL_OCLASS)
CREATE OR REPLACE PROCEDURE PRC_ABLE_DELETE
( V_ABLE_CODE  IN TBL_ABLE.ABLE_CODE%TYPE
)
IS
    V_CHECK_CODE    TBL_CLASS.CLASS_CODE%TYPE;
    V_COUNT         NUMBER := 0;
    
    ALREADY_USE     EXCEPTION;
    
BEGIN
    -- ABLE_ID �����ϴ��� ��ȿ�� �˻� (���� �� ���� �߻�)
    SELECT ABLE_CODE INTO V_CHECK_CODE
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- �����Ϸ��� �ڵ带 �̿� ���� �ڽ� ���̺��� �ִ��� �˻�
    SELECT COUNT(OCLASS_CODE) INTO V_COUNT
    FROM TBL_OCLASS
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- �̹� �ִٸ� ���� �߻�
    IF (V_COUNT > 0)
        THEN RAISE ALREADY_USE;
    END IF;

    -- ������ DELETE
    DELETE
    FROM TBL_ABLE
    WHERE ABLE_CODE = V_ABLE_CODE;
    
    -- ���� ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20105, '��ϵ��� ���� ���ǰ��ɿ����ڵ��Դϴ�.');
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR(-20202, '�������񿡼� ��� ���� �������Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
        ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_COURSE(����) ���̺� -----------------------------------------------------

--���� ���� ��� PRC_COURSE_INSERT(������) ����--

CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
(
    -- ����ڿ��� �Է¹��� ����
  V_COURSE_NAME IN TBL_COURSE.COURSE_NAME%TYPE
)
IS
    -- ���� ����
    CHECK_COURSE_NAME   TBL_COURSE.COURSE_NAME%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- �����ϴ� �����ڵ����� Ȯ��
    SELECT NVL( (SELECT COURSE_CODE
                 FROM TBL_COURSE
                 WHERE COURSE_CODE = V_COURSE_CODE), '0') INTO CHECK_COURSE_CODE
    FROM DUAL;
    
    -- 0�̸� �����ڵ尡 NULL�� ���� �� �������� �ʴ� ����(����ó��)
    IF (CHECK_COURSE_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ���� �̸� �ִ��� Ȯ��
    SELECT NVL( (SELECT COURSE_NAME
                 FROM TBL_COURSE
                 WHERE COURSE_NAME = V_COURSE_NAME), '0') INTO CHECK_COURSE_NAME
    FROM DUAL;   
    
    -- ���� �̸��� ������ �̹� ��ϵ� ���� ����ó���ϱ� ����
    IF (CHECK_COURSE_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT ������ ����
    INSERT INTO TBL_COURSE(COURSE_CODE, COURSE_NAME)
    VALUES(TBL_COURSE_SEQ.NEXTVAL, V_COURSE_NAME);
    
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '�̹� ��ϵ� �������Դϴ�.');        -- �̹� ��ϵ� �����Դϴ�.
        ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--���� ���� ���� PRC_COURSE_UPDATE(�����ڵ�, ������) ����--

CREATE OR REPLACE PROCEDURE PRC_COURSE_UPDATE
( 
  V_COURSE_CODE     IN TBL_COURSE.COURSE_CODE%TYPE
, V_COURSE_NAME     IN TBL_COURSE.COURSE_NAME%TYPE
)
IS

    CHECK_COURSE_NAME   TBL_COURSE.COURSE_NAME%TYPE;
    CHECK_COURSE_CODE   TBL_COURSE.COURSE_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    
    -- ���� �����ڵ�� ���� ó��
    SELECT COURSE_CODE INTO CHECK_COURSE_CODE
    FROM TBL_COURSE
    WHERE COURSE_CODE = V_COURSE_CODE;
    
    -- ������ Ȯ��
    SELECT NVL( (SELECT COURSE_NAME
                 FROM TBL_COURSE
                 WHERE COURSE_NAME = V_COURSE_NAME), '0') INTO CHECK_COURSE_NAME
    FROM DUAL;
    
    -- �ִ� �������̸� ���� ó��
    IF (CHECK_COURSE_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ���� �̸� ����
    UPDATE TBL_COURSE
    SET COURSE_NAME = V_COURSE_NAME
    WHERE COURSE_CODE = V_COURSE_CODE;
    
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '�̹� ��ϵ� �������Դϴ�.');        -- �̹� ��ϵ� �����Դϴ�.
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20106, '��ϵ��� ���� �����ڵ��Դϴ�.');
        ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--���� ���� ���� PRC_COURSE_DELETE(������) ����--

CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
(
    V_COURSE_NAME   IN TBL_COURSE.COURSE_NAME%TYPE
)
IS
    CHECK_COURSE_CODE   TBL_COURSE.COURSE_CODE%TYPE;
    CHECK_GRADE_CODE    TBL_GRADE.GRADE_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
BEGIN
    
    -- �����ϴ� �����ڵ����� Ȯ��
    SELECT NVL( (SELECT COURSE_CODE
                 FROM TBL_COURSE
                 WHERE COURSE_NAME = V_COURSE_NAME), 0) INTO CHECK_COURSE_CODE
    FROM DUAL;
    
    -- ���� ������ ���, ���� �߻�
    IF (CHECK_COURSE_CODE = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
     -- ������ �����ϴ� �����ڵ����� Ȯ��
    SELECT NVL( (SELECT MAX(TG.GRADE_CODE)
                  FROM TBL_GRADE TG
                       JOIN (SELECT OCLASS_CODE
                             FROM TBL_OCLASS TS JOIN TBL_OCOURSE TE
                              ON TS.OCOURSE_CODE = TE.OCOURSE_CODE
                             WHERE TE.COURSE_CODE = CHECK_COURSE_CODE) OC
                             ON TG.OCLASS_CODE = OC.OCLASS_CODE) , 0) INTO CHECK_GRADE_CODE
    FROM DUAL;
    
    -- ������ �Էµ� ���������� ���� ���� �߻�
    IF (CHECK_GRADE_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;

    DELETE
    FROM TBL_COURSE
    WHERE COURSE_CODE = CHECK_COURSE_CODE;
    
    -- Ŀ��
    COMMIT;

    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20106, '��ϵ��� ���� �����ڵ��Դϴ�.');
        ROLLBACK; 
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20203, '������ �ο��� ������ ������ �� �����ϴ�.'); 
        ROLLBACK;
            
END;

    
--------------------------------------------------------------------------------
--���� ���� ����2 PRC_COURSE_DELETE_1 (Ʈ����) ����--
-- ���� ���� Ʈ����
-- �������� DELETE�� ������� �� �������� ���̺����� ������ �����Ѵ�.

CREATE OR REPLACE TRIGGER TRG_COURSE_DELETE
    BEFORE
    DELETE ON TBL_COURSE
    FOR EACH ROW
    
BEGIN
    DELETE
    FROM TBL_OCOURSE
    WHERE COURSE_CODE = :OLD.COURSE_CODE;    -- :OLD�� �������� ���� TBL_COURSE ��
    
END;


-- TBL_CLASSROOM(���ǽ�) ���̺� ------------------------------------------------

--���� ���ǽ� ��� PRC_CLASSROOM_INSERT(���ǽǸ�, ���ǽǼ����ο�) ����--

CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_INSERT
( 
  V_ROOM_NAME   IN TBL_CLASSROOM.ROOM_NAME%TYPE
, V_ROOM_INWON  IN TBL_CLASSROOM.ROOM_INWON%TYPE
)
IS
    -- ���� ����
    CHECK_ROOM_NAME     TBL_CLASSROOM.ROOM_NAME%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    
    SELECT NVL( (SELECT ROOM_NAME
                 FROM TBL_CLASSROOM
                 WHERE ROOM_NAME = V_ROOM_NAME), '0') INTO CHECK_ROOM_NAME
    FROM DUAL;
    
    -- 0�� �ƴ϶�� �� ���ǽǸ��� �̹� �����Ѵٴ� ��� �� ���� ó�� (UNIQUE�� ���� ���� ����)
    IF (CHECK_ROOM_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- INSERT ������ ����
    INSERT INTO TBL_CLASSROOM(ROOM_CODE, ROOM_NAME, ROOM_INWON)
    VALUES(TBL_CLASSROOM_SEQ.NEXTVAL, V_ROOM_NAME, V_ROOM_INWON);
    
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20006, '�̹� ��ϵ� ���ǽǸ��Դϴ�.');
        ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--���� ���ǽ� ���� PRC_CLASSROOM_UPDATE(���ǽ��ڵ�, ���ǽǸ�, ���ǽǼ����ο�) ����--

CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_UPDATE
( 
  V_ROOM_CODE   IN TBL_CLASSROOM.ROOM_CODE%TYPE
, V_ROOM_NAME   IN TBL_CLASSROOM.ROOM_NAME%TYPE
, V_ROOM_INWON  IN TBL_CLASSROOM.ROOM_INWON%TYPE
)
IS
    -- �����
    CHECK_ROOM_CODE    TBL_CLASSROOM.ROOM_CODE%TYPE;
    CHECK_ROOM_NAME    TBL_CLASSROOM.ROOM_NAME%TYPE;
    USER_DEFINE_ERROR  EXCEPTION;
    USER_DEFINE_ERROR2 EXCEPTION;
    
BEGIN
    
    -- �����ϴ� ���ǽ��ڵ����� Ȯ��
    SELECT NVL( (SELECT ROOM_CODE
                 FROM TBL_CLASSROOM
                 WHERE ROOM_CODE = V_ROOM_CODE), '0') INTO CHECK_ROOM_CODE
    FROM DUAL;
    
    -- 0�̸� ���ǽ��ڵ尡 NULL�� ���� �� �������� �ʴ� ���ǽ�(����ó��)
    IF (CHECK_ROOM_CODE = '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- �̹� �������(��ϵ�) ���ǽǸ����� Ȯ��
    SELECT NVL( (SELECT ROOM_NAME
                 FROM TBL_CLASSROOM
                 WHERE ROOM_NAME = V_ROOM_NAME), '0') INTO CHECK_ROOM_NAME
    FROM DUAL;
    
    -- ���ǽ� ������̸� ����ó��
    IF (CHECK_ROOM_NAME != '0')
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- INSERT ������ ����
    UPDATE TBL_CLASSROOM
    SET ROOM_NAME = V_ROOM_NAME
      , ROOM_INWON = V_ROOM_INWON
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20017, '�������� �ʴ� ���ǽ��ڵ��Դϴ�.');
            
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20107, '��ϵ��� ���� ���ǽ��ڵ��Դϴ�.');     -- �̹� ��ϵ� ���ǽǸ��Դϴ�.
            
        ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--���� ���ǽ� ���� PRC_CLASSROOM_DELETE(���ǽǸ�) ����--

CREATE OR REPLACE PROCEDURE PRC_CLASSROOM_DELETE
(
  V_ROOM_NAME    IN TBL_CLASSROOM.ROOM_NAME%TYPE
)
IS
    -- �����
    CHECK_ROOM_CODE              TBL_CLASSROOM.ROOM_CODE%TYPE;
    CHECK_OCOURSE_ROOM_CODE      TBL_CLASSROOM.ROOM_CODE%TYPE;
    USER_DEFINE_ERROR            EXCEPTION;
    USER_DEFINE_ERROR2           EXCEPTION;
    
BEGIN
    
    -- �����ϴ� ���ǽ��ڵ����� Ȯ��
    SELECT NVL( (SELECT ROOM_CODE
                 FROM TBL_CLASSROOM
                 WHERE ROOM_NAME = V_ROOM_NAME), 0) INTO CHECK_ROOM_CODE
    FROM DUAL;
    
    -- ���� ���ǽ��� ���, ���� �߻�
    IF (CHECK_ROOM_CODE = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- �̹� ������� ���������� �ִ��� Ȯ��
    SELECT NVL( (SELECT ROOM_CODE
                 FROM TBL_OCOURSE
                 WHERE ROOM_CODE = CHECK_ROOM_CODE), 0) INTO CHECK_OCOURSE_ROOM_CODE
    FROM DUAL;
    
    -- ������ �������� ���ǽ��̶�� ���� ó��
    IF (CHECK_OCOURSE_ROOM_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- DELETE ������ ����
    DELETE
    FROM TBL_CLASSROOM
    WHERE ROOM_CODE = CHECK_ROOM_CODE;
    
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20107, '��ϵ��� ���� ���ǽ��ڵ��Դϴ�.');
            
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20204, '��� ���� ���ǽ��Դϴ�.');
            
        ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;


-- TBL_OCOURSE(���� ����) ���̺� -----------------------------------------------

--���� �������� ��� PRC_OCOURSE_INSERT(����������, ����������, �����ڵ�, ���ǽ��ڵ�) ����--

CREATE OR REPLACE PROCEDURE PRC_OCOURSE_INSERT
(
  V_ST_DATE         IN TBL_OCOURSE.START_DATE%TYPE
, V_END_DATE        IN TBL_OCOURSE.END_DATE%TYPE
, V_COURSE_CODE     IN TBL_OCOURSE.COURSE_CODE%TYPE
, V_ROOM_CODE       IN TBL_OCOURSE.ROOM_CODE%TYPE
)
IS
    -- �����
    V_OLD_ST_DATE       TBL_OCOURSE.START_DATE%TYPE;
    V_OLD_END_DATE      TBL_OCOURSE.END_DATE%TYPE;
    V_OLD_COURSE_CODE   TBL_OCOURSE.COURSE_CODE%TYPE;
    V_OLD_ROOM_CODE     TBL_OCOURSE.ROOM_CODE%TYPE;    
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;      -- �������� > ���������� ���, �߻�
    USER_DEFINE_ERROR3  EXCEPTION;      -- ����������, ������������ SYSDATE ���Ŀ�����
    
    
    -- Ŀ������ ���� �� Ŀ�� ����
    CURSOR CUR_OCOURSE_SELECT 
    IS 
    SELECT START_DATE, END_DATE, COURSE_CODE, ROOM_CODE
    FROM TBL_OCOURSE;   
    
BEGIN

    -- �������� �����Ϻ��� ���� ���
    IF (V_END_DATE - V_ST_DATE < 0) 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF; 
    
    -- ������������ �����Ϻ��� �����̰ų� ������������ ���������Ϻ��� ������ ���, ���� �߻�
    IF (V_ST_DATE < TO_DATE(SYSDATE, 'YYYY-MM-DD') OR V_END_DATE < V_ST_DATE)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    
    
    OPEN CUR_OCOURSE_SELECT;
    
    
    LOOP 
        -- �� �پ� ó��
        FETCH CUR_OCOURSE_SELECT INTO V_OLD_ST_DATE, V_OLD_END_DATE, V_OLD_COURSE_CODE, V_OLD_ROOM_CODE;
        
        EXIT WHEN CUR_OCOURSE_SELECT%NOTFOUND;
  
        -- (���ǽ� ����)������������ �����ϴ� ���������Ϻ��� ������ ������������ �����ϴ� ���������Ϻ��� �� �ʴ� ���
        IF (V_ST_DATE <= V_OLD_ST_DATE AND V_END_DATE >= V_OLD_ST_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        -- ������������ �����ϴ� ���������Ϻ��� �� �ʴµ� ������������ �����ϴ� ���������Ϻ��� �� �̸� ���
        ELSIF (V_ST_DATE <= V_OLD_END_DATE AND V_END_DATE >= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        -- ������������ �����ϴ� ���������Ϻ��� �ʴµ� ������������ �����ϴ� ���������Ϻ��� �� �̸� ���   
        ELSIF (V_ST_DATE >= V_OLD_ST_DATE AND V_END_DATE <= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))  
            THEN RAISE USER_DEFINE_ERROR;
            
        END IF;
       
  
    END LOOP;
    
    CLOSE CUR_OCOURSE_SELECT;
    
    
    INSERT INTO TBL_OCOURSE(OCOURSE_CODE, START_DATE, END_DATE, COURSE_CODE, ROOM_CODE)
    VALUES (TBL_OCOURSE_SEQ.NEXTVAL, V_ST_DATE, V_END_DATE, V_COURSE_CODE, V_ROOM_CODE);  
    
    COMMIT;   

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20204, '��� ���� ���ǽ��Դϴ�.');
        ROLLBACK; 
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20301, '�������� ������ �����Դϴ�.'); 
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20302, '�̹� ���� ��¥�Դϴ�.');
        ROLLBACK;
    
END;


--------------------------------------------------------------------------------
--���� �������� ���� PRC_OCOURSE_UPDATE(���������ڵ�, ����������, ����������, �����ڵ�, ���ǽ��ڵ�) ����--

CREATE OR REPLACE PROCEDURE PRC_OCOURSE_UPDATE
( 
  V_OCOURSE_CODE  IN TBL_OCOURSE.OCOURSE_CODE%TYPE
, V_ST_DATE       IN TBL_OCOURSE.START_DATE%TYPE
, V_END_DATE      IN TBL_OCOURSE.END_DATE%TYPE
, V_COURSE_CODE   IN TBL_COURSE.COURSE_CODE%TYPE
, V_ROOM_CODE     IN TBL_CLASSROOM.ROOM_CODE%TYPE
)
IS
    
    V_OLD_OCOURSE_CODE  TBL_OCOURSE.OCOURSE_CODE%TYPE;
    V_OLD_ST_DATE       TBL_OCOURSE.START_DATE%TYPE;
    V_OLD_END_DATE      TBL_OCOURSE.END_DATE%TYPE;
    V_OLD_COURSE_CODE   TBL_COURSE.COURSE_CODE%TYPE;
    V_OLD_ROOM_CODE     TBL_CLASSROOM.ROOM_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    USER_DEFINE_ERROR3  EXCEPTION;
    
    CURSOR CUR_OCOURSE_SELECT 
    IS 
    SELECT OCOURSE_CODE, START_DATE, END_DATE, COURSE_CODE, ROOM_CODE
    FROM TBL_OCOURSE;   
    
BEGIN

    IF (V_END_DATE - V_ST_DATE < 0) 
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;  
    
    -- ������������ �����Ϻ��� �����̰ų� ������������ ���������Ϻ��� ������ ���, ���� �߻�
    IF (V_ST_DATE < TO_DATE(SYSDATE, 'YYYY-MM-DD') OR V_END_DATE < V_ST_DATE) 
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    

    OPEN CUR_OCOURSE_SELECT;
    
    LOOP 
        FETCH CUR_OCOURSE_SELECT INTO V_OLD_OCOURSE_CODE, V_OLD_ST_DATE, V_OLD_END_DATE, V_OLD_COURSE_CODE, V_OLD_ROOM_CODE;
        
        EXIT WHEN CUR_OCOURSE_SELECT%NOTFOUND;
  
        IF (V_ST_DATE <= V_OLD_ST_DATE AND V_END_DATE >= V_OLD_ST_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        ELSIF (V_ST_DATE <= V_OLD_END_DATE AND V_END_DATE >= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))
            THEN RAISE USER_DEFINE_ERROR;
            
        ELSIF (V_ST_DATE >= V_OLD_ST_DATE AND V_END_DATE <= V_OLD_END_DATE AND (V_OLD_COURSE_CODE = V_COURSE_CODE OR V_OLD_ROOM_CODE = V_ROOM_CODE))  
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
       
  
    END LOOP;
    
    CLOSE CUR_OCOURSE_SELECT;
    
    
    UPDATE TBL_OCOURSE
    SET START_DATE = V_ST_DATE, END_DATE = V_END_DATE, COURSE_CODE = V_COURSE_CODE, ROOM_CODE = V_ROOM_CODE  
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    
    -- Ŀ��
    COMMIT;   


    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20204, '��� ���� ���ǽ��Դϴ�.');
        ROLLBACK; 
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20301, '�������� ������ �����Դϴ�.'); 
        ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20302, '�̹� ���� ��¥�Դϴ�.');
        ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
END;


--------------------------------------------------------------------------------
--���� �������� ���� PRC_OCOURSE_DELETE(���������ڵ�) ����--

CREATE OR REPLACE PROCEDURE PRC_OCOURSE_DELETE
(
  V_OCOURSE_CODE    IN TBL_OCOURSE.OCOURSE_CODE%TYPE
)
IS
    -- �����
    CHECK_OCOURSE_CODE      TBL_OCOURSE.OCOURSE_CODE%TYPE;
    CHECK_GRADE_CODE        TBL_GRADE.GRADE_CODE%TYPE;
    USER_DEFINE_ERROR       EXCEPTION;
    USER_DEFINE_ERROR2      EXCEPTION;
    
BEGIN
    
    -- �����ϴ� ���������ڵ����� Ȯ��
    SELECT NVL( (SELECT OCOURSE_CODE
                 FROM TBL_OCOURSE
                 WHERE OCOURSE_CODE = V_OCOURSE_CODE), 0) INTO CHECK_OCOURSE_CODE
    FROM DUAL;
    
    -- ���� ���������ڵ��� ���, ���� �߻�
    IF (CHECK_OCOURSE_CODE = 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ������ �����ϴ� ���������ڵ����� Ȯ��
    SELECT NVL( (SELECT MAX(TG.GRADE_CODE)
                  FROM TBL_GRADE TG
                       JOIN (SELECT OCLASS_CODE
                             FROM TBL_OCLASS
                             WHERE OCOURSE_CODE = V_OCOURSE_CODE) OC
                             ON TG.OCLASS_CODE = OC.OCLASS_CODE) , 0) INTO CHECK_GRADE_CODE
    FROM DUAL;
    
    -- ������ �Էµ� ���������� ���� ���� �߻�
    IF (CHECK_GRADE_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;


    -- DELETE ������ ����
    DELETE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20108, '��ϵ��� ���� �������� �ڵ��Դϴ�.');
        ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN  RAISE_APPLICATION_ERROR(-20203, '������ �ο��� ������ ������ �� �����ϴ�.'); 
        ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;


--------------------------------------------------------------------------------
--���� �������� ����2 PRC_OCOURSE_DELETE_1 (Ʈ����) ����--
-- �������� ���� Ʈ����
-- ������������ DELETE�� ������� �� 
-- �������� ���̺����� ���������� �����Ѵ�.

CREATE OR REPLACE TRIGGER TRG_OCOURSE_DELETE
    BEFORE
    DELETE ON TBL_OCOURSE
    FOR EACH ROW
    
BEGIN
    DELETE
    FROM TBL_OCLASS
    WHERE OCOURSE_CODE = :OLD.OCOURSE_CODE;    -- :OLD�� �������� ���� TBL_OCOURSE�� ��
    
    DELETE
    FROM TBL_SIGN
    WHERE OCOURSE_CODE = :OLD.OCOURSE_CODE;
    
END; 


-- TBL_TEXTBOOK(����) ���̺� ---------------------------------------------------

----------------------
-- PRC_TEXTBOOK_INSERT
--EXEC PRC_TEXTBOOK_INSERT(BOOK_NAME, BOOK_PUB);

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
            THEN RAISE_APPLICATION_ERROR(-20007, '�̹� ��ϵ� ������Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;


----------------------
-- PRC_TEXTBOOK_UPDATE
--EXEC PRC_TEXTBOOK_UPDATE(BOOK_CODE, BOOK_NAME, BOOK_PUB);

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
            THEN RAISE_APPLICATION_ERROR(-20109, '��ϵ��� ���� ���� �ڵ��Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


----------------------
--PRC_TEXTBOOK_DELETE
--EXEC PRC_TEXTBOOK_DELETE(BOOK_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20109, '��ϵ��� ���� ���� �ڵ��Դϴ�.');
        WHEN USING_IN_OCLASS
            THEN RAISE_APPLICATION_ERROR( -20205, '��� ���� �����Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


-- TBL_OCLASS(���� ����) ���̺� ------------------------------------------------

--��������[��������(���ǽ�, ����), ���ǰ���(����, ����)]
---------------------
-- PRC_OCLASS_INSERT
--EXEC PRC_OCLASS_INSERT(V_START_DATE, V_END_DATE, V_ABLE_CODE, V_OCOURSE_CODE, V_BOOK_CODE);

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
    IF (TO_DATE(SYSDATE, 'YYYY-MM-DD') > V_START_DATE OR V_START_DATE > V_END_DATE)
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
            THEN RAISE_APPLICATION_ERROR(-20109, '��ϵ��� ���� ���� �ڵ��Դϴ�.');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20013, '��ϵ��� ���� ���ǰ��ɿ��� �ڵ��Դϴ�.');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20206, '�ش� �Ⱓ�� ������ ������ �����Դϴ�. �ٸ� ������ �������ּ���.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20303, '������ ������ ����Ⱓ�� �Ѿ�� ������ �� �����ϴ�.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20304, '�߸��� ��¥�� �Է��߽��ϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;

END;


---------------------
-- PRC_OCLASS_UPDATE
--EXEC PRC_OCLASS_UPDATE(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)

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
            THEN RAISE_APPLICATION_ERROR(-20108, '��ϵ��� ���� �������� �ڵ��Դϴ�.');
        WHEN NO_BOOK_FOUND
            THEN RAISE_APPLICATION_ERROR(-20109, '��ϵ��� ���� ���� �ڵ��Դϴ�.');
        WHEN NO_PRO_FOUND
            THEN RAISE_APPLICATION_ERROR(-20105, '��ϵ��� ���� ���ǰ��ɿ��� �ڵ��Դϴ�.');
        WHEN OPENED_CLASS
            THEN RAISE_APPLICATION_ERROR(-20206, '�ش� �Ⱓ�� ������ ������ �����Դϴ�. �ٸ� ������ �������ּ���.'); 
        WHEN WRONG_DATE1
            THEN RAISE_APPLICATION_ERROR(-20303, '������ ������ ����Ⱓ�� �Ѿ�� ������ �� �����ϴ�.');
        WHEN WRONG_DATE
            THEN RAISE_APPLICATION_ERROR(-20304, '�߸��� ��¥�� �Է��߽��ϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
    
END;


---------------------
-- PRC_OCLASS_DELETE
--EXEC PRC_OCLASS_DELETE(OCLASS_CODE)

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
            THEN RAISE_APPLICATION_ERROR(-20108, '��ϵ��� ���� �������� �ڵ��Դϴ�.');
         WHEN GRADE_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20207, '������ �ο��� ������ ������ �� �����ϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
    
END;

---------------------
-- Ʈ����
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


-- TBL_STUDENT(�л�) ���̺� ----------------------------------------------------

--�л� ���(INSERT)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_STU_ID      IN TBL_STUDENT.STU_ID%TYPE                 
, V_STU_NAME    IN TBL_STUDENT.STU_NAME%TYPE               
, V_STU_SSN     IN TBL_STUDENT.STU_SSN%TYPE
, V_STU_EMAIL   IN TBL_STUDENT.STU_EMAIL%TYPE
, V_STU_PHONE   IN TBL_STUDENT.STU_PHONE%TYPE
)
IS  
    V_STU_PW    TBL_STUDENT.STU_PW%TYPE;
    
BEGIN
    -- �л� ��й�ȣ �ֹι�ȣ ���ڸ� ����
    V_STU_PW := SUBSTR(V_STU_SSN, 8);
    
     -- ������ INSERT
    INSERT INTO TBL_STUDENT(STU_ID, STU_NAME, STU_PW, STU_SSN, STU_EMAIL, STU_PHONE) 
    VALUES(V_STU_ID, V_STU_NAME, V_STU_PW, V_STU_SSN, V_STU_EMAIL, V_STU_PHONE);
     
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
            THEN RAISE_APPLICATION_ERROR(-20008, '�̹� ��ϵ� ���̵� �Ǵ� �ֹε�Ϲ�ȣ�Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
        
    COMMIT;
    
END;

-- �л� ���� PRC_STUDENT_UPDATE
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_STU_ID            IN TBL_STUDENT.STU_ID%TYPE
, V_STU_PW            IN TBL_STUDENT.STU_PW%TYPE
, V_STU_NAME          IN TBL_STUDENT.STU_NAME%TYPE
, V_STU_SSN           IN TBL_STUDENT.STU_SSN%TYPE
, V_STU_EMAIL         IN TBL_STUDENT.STU_EMAIL%TYPE
, V_STU_PHONE         IN TBL_STUDENT.STU_PHONE%TYPE
)
IS
    V_CHECK_ID      TBL_STUDENT.STU_ID%TYPE;
 
BEGIN
    -- ��ϵǾ� �ִ� �������� �˻�(������ ���� �߻�)
    SELECT STU_ID INTO V_CHECK_ID
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    UPDATE TBL_STUDENT
    SET STU_NAME = V_STU_NAME
       ,STU_PW = V_STU_PW
       ,STU_EMAIL = V_STU_EMAIL
       ,STU_PHONE = V_STU_PHONE
    WHERE STU_ID = V_STU_ID;
       
    
   -- ����ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '��ϵ��� ���� ���̵��Դϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;


-- �л� ���� PRC_STUDENT_DELETE
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
(
    V_STU_ID    IN TBL_STUDENT.STU_ID%TYPE
)
IS
    V_CHECK     TBL_STUDENT.STU_ID%TYPE;
    V_COUNT     NUMBER;
    
    ALREADY_USE EXCEPTION;

BEGIN
    SELECT STU_ID INTO V_CHECK
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID;
    
    SELECT COUNT(SIGN_CODE) INTO V_COUNT
    FROM TBL_SIGN
    WHERE STU_ID = V_STU_ID;
    
    IF (V_COUNT != 0)
        THEN RAISE ALREADY_USE;
    END IF;
    
    DELETE
    FROM TBL_STUDENT
    WHERE STU_ID = V_STU_ID; 
    
    -- ����ó��
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20102, '��ϵ��� ���� ���̵��Դϴ�.');
        WHEN ALREADY_USE
            THEN RAISE_APPLICATION_ERROR(-20208, '�̹� ������û�� �� �л��Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
            
        COMMIT;
END;


-- �л� ����2 PRC_STUDENT_DELETE_1 (Ʈ����) 
-- �л� ���� Ʈ����
--> �л����� DELETE�� ������� �� 
--> ������û ���̺����� �л� ����
CREATE OR REPLACE TRIGGER TRG_STUDENT_DELETE
    BEFORE
    DELETE ON TBL_STUDENT
    FOR EACH ROW
BEGIN
    DELETE
    FROM TBL_SIGN
    WHERE STU_ID = :OLD.STU_ID;
END;


-- TBL_REASON(Ż������) ���̺� -------------------------------------------------

--������ INSERT
CREATE OR REPLACE PROCEDURE PRC_REASON_INSERT
( 
    V_REASON_MEMO IN TBL_REASON.REASON_MEMO%TYPE
)
IS
    CHECK_REASON_MEMO   TBL_REASON.REASON_MEMO%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- �̹� ��ϵ� Ż�� �������� Ȯ��
    SELECT NVL(
                ( SELECT REASON_MEMO 
                  FROM TBL_REASON
                  WHERE REASON_MEMO = V_REASON_MEMO) , '0') INTO CHECK_REASON_MEMO  
    FROM DUAL;
    
    IF (CHECK_REASON_MEMO != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    INSERT INTO TBL_REASON(REASON_CODE, REASON_MEMO)
    VALUES(TBL_REASON_SEQ.NEXTVAL, V_REASON_MEMO);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009, '�̹� ��ϵ� Ż�������Դϴ�.');                 -- �̹� ��ϵ� Ż�� ������� ������ �ߺ� ����
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;

END;


-- UPDATE
CREATE OR REPLACE PROCEDURE PRC_REASON_UPDATE
(
     V_REASON_CODE   IN TBL_REASON.REASON_CODE%TYPE
,    V_REASON_MEMO   IN TBL_REASON.REASON_MEMO%TYPE
)
IS
    CHECK_REASON_MEMO   TBL_REASON.REASON_MEMO%TYPE;
    CHECK_REASON_CODE   TBL_REASON.REASON_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_ERROR       EXCEPTION;
    
BEGIN
    -- TBL_REASON ���̺��� ����ڿ��� �Է¹��� V_REASON_MEMO �� ���� ���� �ִٸ�
    -- CHECK_REASON_MEMO ������ ��ƶ�
    SELECT NVL (
                (  SELECT REASON_MEMO 
                    FROM TBL_REASON
                    WHERE REASON_MEMO = V_REASON_MEMO  ), '0') INTO CHECK_REASON_MEMO
    FROM DUAL;
    
    -- TBL_REASON ���̺��� ����ڰ� �Է��� Ż������ �ڵ�� ���� ���� CHECK_REASON_CODE ������ ��ƶ�
    SELECT NVL(
                 (  SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE  ), '0') INTO CHECK_REASON_CODE
    FROM DUAL;
    
    -- CHECK_REASON_MEMO ���� ��� ���� NULL �� �ƴ϶�� ������ �ߺ� ����
    IF(CHECK_REASON_MEMO != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- TBL_REASON ���̺� ����ڰ� �Է��� Ż�������ڵ尡 ���ٸ�
    -- �Է��� ���� �������� �ʴ´ٴ� ����('������ ����')
    IF(CHECK_REASON_CODE = '0')
        THEN RAISE NO_DATA_ERROR;
    END IF;

    UPDATE TBL_REASON 
    SET REASON_MEMO = V_REASON_MEMO
    WHERE REASON_CODE = V_REASON_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20009, '�̹� ��ϵ� Ż�������Դϴ�.');                  -- �Է��� Ż�� ������ �̹� �����ϸ� ������ �ߺ� ����
                ROLLBACK;
        WHEN NO_DATA_ERROR                      
            THEN RAISE_APPLICATION_ERROR(-20110, '��ϵ��� ���� Ż�������ڵ��Դϴ�.');             -- �Է��� Ż�������ڵ尡 �������� �ʴ� ��� ����('������ ����')
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
        
        COMMIT;
END;


-- DELETE
CREATE OR REPLACE PROCEDURE PRC_REASON_DELETE
(
    V_REASON_CODE   IN TBL_REASON.REASON_CODE%TYPE
)
IS
    CHECK_REASON_CODE   TBL_REASON.REASON_CODE%TYPE;
    CHECK_FAIL_CODE     TBL_FAIL.FAIL_CODE%TYPE;
    
    USE_DATA_ERROR   EXCEPTION;
    NO_DATA_ERROR   EXCEPTION;
BEGIN
    
    SELECT NVL(
                (   SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE           ), '0') INTO CHECK_REASON_CODE
    FROM DUAL;
    
    -- TBL_REASON ���̺� ����ڰ� �Է��� Ż�������ڵ尡 ���� ��(NULL ��)
    -- ������ ���� ����
    IF(CHECK_REASON_CODE = '0')
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    -- ����ڰ� �Է��� Ż�������ڵ� ���� �ߵ�Ż�����̺� �ִ� ��� CHECK_FAIL_CODE ������ �� ���
    SELECT NVL(
                 (  SELECT FAIL_CODE 
                    FROM TBL_FAIL
                    WHERE FAIL_CODE = V_REASON_CODE     ), '0') INTO CHECK_FAIL_CODE
    FROM DUAL;
    
    -- CHECK_FAIL_CODE �������� NULL �� �ƴ� ��� 
    -- �ߵ�Ż�����̺� ���� �����Ƿ� Ż���������̺��� ���� �Ұ� ����(������� ������)
    IF(CHECK_FAIL_CODE != '0')
        THEN RAISE USE_DATA_ERROR;
    END IF;
    
    DELETE
    FROM TBL_REASON
    WHERE REASON_CODE = V_REASON_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20110, '��ϵ��� ���� Ż�������ڵ��Դϴ�.');   --����ڰ� �Է��� Ż�������ڵ尡 ���� �� ����
                ROLLBACK;
        WHEN USE_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20209, '�̹� �̿� ���� Ż�������ڵ��Դϴ�.');                           -- �ߵ�Ż�����̺� ���� �����Ƿ� Ż���������̺��� ���� �Ұ� ����(������� ������)
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_SIGN(������û) ���̺� ---------------------------------------------------

-- INSERT ���ν��� ����
CREATE OR REPLACE PROCEDURE PRC_SIGN_INSERT
( 
    V_STU_ID         IN TBL_SIGN.STU_ID%TYPE
,   V_OCOURSE_CODE   IN TBL_SIGN.OCOURSE_CODE%TYPE
)
IS
    -- �л����̺�, �����������̺� ������ ����ڰ� �Է��� ������ ���� ���� Ȯ�� ����
    CHECK_STU_ID            TBL_STUDENT.STU_ID%TYPE;
    CHECK_OCOUSE_CODE       TBL_OCOURSE.OCOURSE_CODE%TYPE;   
    
    -- ������û ���̺� ������ ������ �ߺ� Ȯ�� ����
    CK_SIGN_STU_ID          TBL_SIGN.STU_ID%TYPE;
    
    -- ����ڰ� �Է��� ���������ڵ��� �������� ���� ����
    CK_OCOURSE_START_DATE    TBL_OCOURSE.START_DATE%TYPE;

    USER_DEFINE_ERROR    EXCEPTION;   -- ������ �ߺ� ����
    NO_DATA_ERROR1       EXCEPTION;   -- ������ ���� ����(�л����̵�)
    NO_DATA_ERROR2       EXCEPTION;   -- ������ ���� ����(���������ڵ�)
    TIME_OVER_ERROR      EXCEPTION;   -- ���� ���� ����
BEGIN
    
    -- �Է��� �л��� �ִ��� Ȯ��
    SELECT NVL(
                (   SELECT STU_ID 
                    FROM TBL_STUDENT
                    WHERE STU_ID = V_STU_ID            ), '0') INTO CHECK_STU_ID
    FROM DUAL;
    
    -- �Է��� ���������� �ִ��� Ȯ��
    SELECT NVL(
                 (  SELECT OCOURSE_CODE 
                    FROM TBL_OCOURSE
                    WHERE OCOURSE_CODE = V_OCOURSE_CODE ), '0') INTO CHECK_OCOUSE_CODE
    FROM DUAL;
    
    -- �Է��� �л����̵� �������� �ʴ� �������� ��� ����(������ ����) 
    IF(CHECK_STU_ID = '0')
        THEN RAISE NO_DATA_ERROR1;
    END IF;
    
    -- �Է��� ���������ڵ尡 �������� �ʴ� �������� ��� ����(������ ����) 
    IF(CHECK_OCOUSE_CODE = '0')
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- ����ڰ� �Է��� ������ �������� CK_OCOURSE_START_DATE ������ ��´�
    SELECT START_DATE INTO CK_OCOURSE_START_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    -- ������û �������� Ȯ��(SYSDATE �� ���������� ���� ���� �������� Ȯ��)
    -- SYSDATE < �����������̺��� ���������� �̾�� ������û ����
    -- SYSDATE > �����������̺��� ���������� �̸� ������û �Ұ� ����
    IF(TO_DATE(SYSDATE, 'YYYY-MM-DD') > CK_OCOURSE_START_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    -- ����ڰ� �Է��� ���������ڵ�� ������û�� �����ִ��� ��ȸ
    -- ��ȸ �� ���� �� ����ڰ� �Է��� �Ͱ� ���� �л� ���̵� �ִٸ� ������ �ߺ� ����
    SELECT NVL(
                 (  SELECT SIGN_CODE
                    FROM TBL_SIGN
                    WHERE OCOURSE_CODE = V_OCOURSE_CODE
                      AND STU_ID = V_STU_ID), '0') INTO CK_SIGN_STU_ID
    FROM DUAL;
    
    -- �Է��� (�л����̵�, ���������ڵ�) �� �̹� �����ϴ� �������� ��� ������ �ߺ� ����
    IF(CK_SIGN_STU_ID != '0')
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
   
    INSERT INTO TBL_SIGN(SIGN_CODE, STU_ID, OCOURSE_CODE)
    VALUES(TBL_SIGN_SEQ.NEXTVAL, V_STU_ID, V_OCOURSE_CODE);
    
    EXCEPTION
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20102, '��ϵ��� ���� ���̵��Դϴ�.');       -- �Է��� �л����̵� �������� �ʴ� �������� ��� ����(������ ����)
                ROLLBACK;
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20106, '��ϵ��� ���� �����ڵ��Դϴ�.');         -- �Է��� ���������ڵ尡 �������� �ʴ� �������� ��� ����(������ ����)
                ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20305, '������û �Ⱓ�� �ƴմϴ�.');
                ROLLBACK;
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20010, '�̹� ����� �����Դϴ�.');                 -- �Է��� (�л����̵�, ���������ڵ�) �� �̹� �����ϴ� �������� ��� ������ �ߺ� ����
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
END;


-- UPDATE
CREATE OR REPLACE PROCEDURE PRC_SIGN_UPDATE
(
    V_SIGN_CODE     IN  TBL_SIGN.SIGN_CODE%TYPE
,   V_STU_ID        IN  TBL_SIGN.STU_ID%TYPE
,   V_OCOURSE_CODE  IN  TBL_SIGN.OCOURSE_CODE%TYPE
)
IS
    -- ����ڰ� �Է��� ������û �ڵ尡 �����ϴ��� Ȯ�κ���
    CHECK_SIGN_CODE         TBL_SIGN.SIGN_CODE%TYPE;
    
    -- ����ڰ� �Է��� �л� ���̵� �����ϴ��� Ȯ�κ���
    CHECK_STU_ID            TBL_SIGN.STU_ID%TYPE;
    
    -- ����ڰ� �Է��� ���������ڵ尡 �����ϴ��� Ȯ�κ���
    CHECK_OCOURSE_CODE      TBL_OCOURSE.OCOURSE_CODE%TYPE;
    
    -- ����ڰ� �Է��� ������ �������� ��û���� �Ⱓ���� Ȯ�κ���
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    
    -- ����ڰ� �Է��� ������ ���� �л� ���̵� �����ϴ��� Ȯ�κ���
    CK_STU_OCOURSE           TBL_OCOURSE.OCOURSE_CODE%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    NO_DATA_ERROR1       EXCEPTION;         -- ������û�ڵ� ����
    NO_DATA_ERROR2       EXCEPTION;         -- �л����̵� ����
    NO_DATA_ERROR3       EXCEPTION;         -- ���������ڵ� ����
    TIME_OVER_ERROR     EXCEPTION;
BEGIN
    SELECT NVL(
                 (  SELECT SIGN_CODE 
                    FROM TBL_SIGN
                    WHERE SIGN_CODE = V_SIGN_CODE               ), 0) INTO CHECK_SIGN_CODE
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT STU_ID
                    FROM TBL_STUDENT
                    WHERE STU_ID = V_STU_ID                     ), '0') INTO CHECK_STU_ID
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT OCOURSE_CODE 
                    FROM TBL_OCOURSE
                    WHERE OCOURSE_CODE = V_OCOURSE_CODE         ), 0) INTO CHECK_OCOURSE_CODE
    FROM DUAL;
    
    -- �Է��� ������û �ڵ� ���� �� ������ ���� ����
    IF(CHECK_SIGN_CODE = 0)         
        THEN RAISE NO_DATA_ERROR1;
    END IF;
    
    -- �Է��� �л� ���̵� ���� �� ������ ���� ����
    IF(CHECK_STU_ID = '0')
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- �Է��� �������� �ڵ� ���� �� ������ ���� ����
    IF(CHECK_OCOURSE_CODE = 0)
        THEN RAISE NO_DATA_ERROR3;
    END IF;
    
    SELECT START_DATE INTO CK_OCOURSE_START_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = V_OCOURSE_CODE;
    
    -- �Է��� �������� �ڵ��� �������� �̹� ���۵� ��� ��û�Ⱓ�����ٴ� ����
    IF(SYSDATE > CK_OCOURSE_START_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    SELECT COUNT(*) INTO CK_STU_OCOURSE
    FROM TBL_SIGN
    WHERE STU_ID = V_STU_ID AND OCOURSE_CODE = V_OCOURSE_CODE;
    
    -- ���� ���ϴ� �������� �̹� ������û�� ������ ���� ��� ������ �ߺ� ����
    IF(CK_STU_OCOURSE > 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE TBL_SIGN
    SET OCOURSE_CODE = V_OCOURSE_CODE, STU_ID = V_STU_ID
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20010, '�̹� ����� �����Դϴ�.');                           -- ���� ���ϴ� �������� �̹� ������û�� ������ ���� ��� ������ �ߺ� ����      
                ROLLBACK;
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20111, '��ϵ��� ���� ������û�ڵ��Դϴ�.');             -- �Է��� ������û �ڵ� ���� �� ������ ���� ����
                ROLLBACK;  
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20102, '��ϵ��� ���� ���̵��Դϴ�.');               -- �Է��� �л� ���̵� ���� �� ������ ���� ����
                ROLLBACK;
        WHEN NO_DATA_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20106, '��ϵ��� ���� �����ڵ��Դϴ�.');                 -- �Է��� �������� �ڵ� ���� �� ������ ���� ����
                ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20305, '������û �Ⱓ�� �ƴմϴ�.');
                ROLLBACK;        
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT; 

END;


-- DELETE
CREATE OR REPLACE PROCEDURE PRC_SIGN_DELETE
(
    V_SIGN_CODE IN TBL_SIGN.SIGN_CODE%TYPE
)
IS
    CHECK_SIGN_CODE         TBL_SIGN.SIGN_CODE%TYPE;
    CHECK_OCOURSE_CODE      TBL_SIGN.OCOURSE_CODE%TYPE;
    CHECK_GRADE_CODE        TBL_GRADE.GRADE_CODE%TYPE;
    
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    
    NO_DATA_ERROR           EXCEPTION;
    USER_DEFINE_ERROR       EXCEPTION;
    TIME_OVER_ERROR         EXCEPTION;
BEGIN
    SELECT NVL(
                (   SELECT SIGN_CODE 
                    FROM TBL_SIGN
                    WHERE SIGN_CODE = V_SIGN_CODE),         0) INTO CHECK_SIGN_CODE
    FROM DUAL;

    -- ����ڰ� �Է��� ������û �ڵ尡 ���� �� ������ ���� ����
    IF(CHECK_SIGN_CODE = 0)
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    -- ������ �����ϴ� ������û�ڵ����� Ȯ��
    SELECT NVL( (SELECT MAX(TG.GRADE_CODE)
                  FROM TBL_GRADE TG
                       JOIN (SELECT SIGN_CODE
                             FROM TBL_SIGN
                             WHERE SIGN_CODE = V_SIGN_CODE) OC
                             ON TG.SIGN_CODE = OC.SIGN_CODE) , 0) INTO CHECK_GRADE_CODE
    FROM DUAL;
    
    -- ������ �Էµ� ������û�ڵ��� ���� ���� �߻�
    IF (CHECK_GRADE_CODE != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    -- ����ڰ� �Է��� ������û�ڵ忡 �ش��ϴ� ���������ڵ� ���� CHECK_OCOURSE_CODE �� ��´�
    SELECT OCOURSE_CODE INTO CHECK_OCOURSE_CODE
    FROM TBL_SIGN
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    SELECT START_DATE INTO CK_OCOURSE_START_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = CHECK_OCOURSE_CODE;
    
    -- ������ �̹� ������ ��� ���� �Ұ� ����(������ �̹� �����߽��ϴ�)
    IF(SYSDATE > CK_OCOURSE_START_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    DELETE 
    FROM TBL_SIGN
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20111, '��ϵ��� ���� ������û�ڵ��Դϴ�.');    
                ROLLBACK;
         WHEN USER_DEFINE_ERROR
            THEN  RAISE_APPLICATION_ERROR(-20210, '������ �ο��� ������û������ ������ �� �����ϴ�.'); 
        ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20305, '������û �Ⱓ�� �ƴմϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;

-- TBL_SIGN(������û) ���� Ʈ���� 
--=> �������̺� ������ ���°�� �ߵ�Ż�����̺� �Բ� ����
CREATE OR REPLACE TRIGGER TRG_TBL_SIGN
    BEFORE
    DELETE ON TBL_SIGN
    FOR EACH ROW
BEGIN
    
    DELETE
    FROM TBL_FAIL
    WHERE SIGN_CODE = :OLD.SIGN_CODE;
    
END;


-- TBL_FAIL(�ߵ�Ż��) ���̺� ---------------------------------------------------

-- INSERT
CREATE OR REPLACE PROCEDURE PRC_FAIL_INSERT
(   
    V_FAIL_DATE       IN TBL_FAIL.FAIL_DATE%TYPE
,   V_SIGN_CODE       IN TBL_FAIL.SIGN_CODE%TYPE
,   V_REASON_CODE     IN TBL_FAIL.REASON_CODE%TYPE
)
IS
    -- ������ �ߺ� ���� üũ�ϱ� ���� Ȯ�κ���(Ż������, ������û�ڵ�, Ż������ �ڵ�)
    CHECK_FAIL_DATE    TBL_FAIL.FAIL_DATE%TYPE;
    CHECK_SIGN_CODE    TBL_SIGN.SIGN_CODE%TYPE;
    CHECK_REASON_CODE  TBL_REASON.REASON_CODE%TYPE;
    
    CK_SIGN_REASON     TBL_SIGN.SIGN_CODE%TYPE;
    
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    CK_OCOURSE_END_DATE     TBL_OCOURSE.END_DATE%TYPE;
    
    NO_DATA_ERROR1       EXCEPTION;
    NO_DATA_ERROR2       EXCEPTION;
    USER_DEFINE_ERROR   EXCEPTION;
    TIME_OVER_ERROR     EXCEPTION;
BEGIN
     SELECT NVL(
                (    SELECT SIGN_CODE 
                     FROM TBL_SIGN
                     WHERE SIGN_CODE = V_SIGN_CODE      ), 0) INTO CHECK_SIGN_CODE
     FROM DUAL;

    -- �Է��� ������û�ڵ尡 ���� �ڵ��� ��� ����
    IF(CHECK_SIGN_CODE = 0)
        THEN RAISE NO_DATA_ERROR1;
    END IF;

    SELECT NVL(
                 (  SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE    ), 0) INTO CHECK_REASON_CODE
    FROM DUAL;

    -- �Է��� Ż�������ڵ尡 ���� �ڵ��� ��� ����
    IF(CHECK_REASON_CODE = 0)
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- ����ڰ� �Է��� ������û�ڵ�� ��ϵ� Ż�������ڵ尡 �����ϸ� ����(������ �ߺ�) 
    SELECT COUNT(FAIL_CODE) INTO CK_SIGN_REASON
    FROM TBL_FAIL
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    IF(CK_SIGN_REASON > 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �Է��� ������û�ڵ忡 �ش�Ǵ� ������ �����ϰ� �������� ������ ���
    SELECT START_DATE, END_DATE INTO CK_OCOURSE_START_DATE, CK_OCOURSE_END_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = (
                            SELECT OCOURSE_CODE
                            FROM TBL_SIGN
                            WHERE SIGN_CODE = V_SIGN_CODE
                         );
    
    -- �Է��� Ż�����ڰ� ���� �Ⱓ �ȿ� ������ ����
    -- �Է��� Ż������ < ���� ������ ����(���� ���� ��)
    -- �Է��� Ż������E > ���� ������ ����(���� ���� ��)
    -- BETWEEN A AND B
    IF(V_FAIL_DATE NOT BETWEEN CK_OCOURSE_START_DATE AND CK_OCOURSE_END_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;

    INSERT INTO TBL_FAIL(FAIL_CODE, FAIL_DATE, SIGN_CODE, REASON_CODE)
    VALUES(TBL_FAIL_SEQ.NEXTVAL, TO_DATE(V_FAIL_DATE, 'YYYY-MM-DD'), V_SIGN_CODE, V_REASON_CODE);

    EXCEPTION
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20111, '��ϵ��� ���� ������û�ڵ��Դϴ�.');                 -- �Է��� ������û�ڵ� ���� �ڵ��� ��� ����
                ROLLBACK;
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20110, '��ϵ��� ���� Ż�������ڵ��Դϴ�.');                 -- �Է��� Ż�������ڵ尡 ���� �ڵ��� ��� ����
                ROLLBACK;
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20011, '�̹� ��ϵ� �����Դϴ�.');                            -- ������û�ڵ�, Ż������ �ڵ� �ߺ�����
                ROLLBACK;        
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20306, 'Ż�����ڰ� ���� �Ⱓ�� ������ϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- UPDATE
CREATE OR REPLACE PROCEDURE PRC_FAIL_UPDATE
(
    V_FAIL_CODE     IN TBL_FAIL.FAIL_CODE%TYPE
,   V_FAIL_DATE     IN TBL_FAIL.FAIL_DATE%TYPE
,   V_SIGN_CODE     IN TBL_SIGN.SIGN_CODE%TYPE
,   V_REASON_CODE   IN TBL_REASON.REASON_CODE%TYPE
)
IS
    CHECK_FAIL_CODE         TBL_FAIL.FAIL_CODE%TYPE;
    CHECK_SIGN_CODE         TBL_SIGN.SIGN_CODE%TYPE;
    CHECK_REASON_CODE       TBL_REASON.REASON_CODE%TYPE;
    CK_FAIL_SIGN_REASON     TBL_SIGN.SIGN_CODE%TYPE;
    
    CK_OCOURSE_START_DATE   TBL_OCOURSE.START_DATE%TYPE;
    CK_OCOURSE_END_DATE     TBL_OCOURSE.END_DATE%TYPE;
    
    NO_DATA_ERROR1       EXCEPTION;
    NO_DATA_ERROR2       EXCEPTION;
    NO_DATA_ERROR3       EXCEPTION;
    USER_DEFINE_ERROR   EXCEPTION;
    TIME_OVER_ERROR     EXCEPTION;
BEGIN
    SELECT NVL(
                 (  SELECT FAIL_CODE 
                    FROM TBL_FAIL
                    WHERE FAIL_CODE = V_FAIL_CODE           ), 0) INTO CHECK_FAIL_CODE
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT SIGN_CODE 
                    FROM TBL_SIGN
                    WHERE SIGN_CODE = V_SIGN_CODE           ), 0) INTO CHECK_SIGN_CODE
    FROM DUAL;
    
    SELECT NVL(
                 (  SELECT REASON_CODE 
                    FROM TBL_REASON
                    WHERE REASON_CODE = V_REASON_CODE       ), 0) INTO CHECK_REASON_CODE
    FROM DUAL;
    
    -- �Է��� �ߵ�Ż���ڵ尡 ���� ��� ������ ���� ����
    IF(CHECK_FAIL_CODE = 0)
        THEN RAISE NO_DATA_ERROR1;
    END IF;
    
    -- �Է��� ������û�ڵ尡 ���� ��� ������ ���� ����
    IF(CHECK_SIGN_CODE = 0)
        THEN RAISE NO_DATA_ERROR2;
    END IF;
    
    -- �Է��� Ż�������ڵ� �� ���� ��� ������ ���� ����
    IF(CHECK_REASON_CODE = 0)
        THEN RAISE NO_DATA_ERROR3;
    END IF;
    
    
    -- ����ڰ� �Է��� ������û�ڵ忡 �ش��ϴ� Ż�������ڵ� ������ ��� ���� �߻�(������ �ߺ�����)
    SELECT COUNT(FAIL_CODE) INTO CK_FAIL_SIGN_REASON
    FROM TBL_FAIL
    WHERE SIGN_CODE = V_SIGN_CODE;

    IF(CK_FAIL_SIGN_REASON > 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    SELECT START_DATE, END_DATE INTO CK_OCOURSE_START_DATE, CK_OCOURSE_END_DATE
    FROM TBL_OCOURSE
    WHERE OCOURSE_CODE = (
                            SELECT OCOURSE_CODE
                            FROM TBL_SIGN
                            WHERE SIGN_CODE = V_SIGN_CODE
                         );
    
    -- �Է��� Ż�����ڰ� �ش� �����Ⱓ �ȿ� ����� ��� ����
    IF(V_FAIL_DATE NOT BETWEEN CK_OCOURSE_START_DATE AND CK_OCOURSE_END_DATE)
        THEN RAISE TIME_OVER_ERROR;
    END IF;
    
    UPDATE TBL_FAIL
    SET FAIL_DATE = V_FAIL_DATE, SIGN_CODE = V_SIGN_CODE, REASON_CODE = V_REASON_CODE
    WHERE FAIL_CODE = V_FAIL_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR1
            THEN RAISE_APPLICATION_ERROR( -20112, '��ϵ��� ���� �ߵ�Ż���ڵ��Դϴ�.');                 -- �Է��� �ߵ�Ż���ڵ尡 ���� ��� ������ ���� ����
                ROLLBACK;
        WHEN NO_DATA_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20111, '��ϵ��� ���� ������û�ڵ��Դϴ�.');                 -- �Է��� ������û�ڵ尡 ���� ��� ������ ���� ����
                ROLLBACK;
        WHEN NO_DATA_ERROR3
            THEN RAISE_APPLICATION_ERROR( -20110, '��ϵ��� ���� Ż�������ڵ��Դϴ�.');                 -- �Է��� Ż�������ڵ� �� ���� ��� ������ ���� ����
                ROLLBACK;        
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR( -20011, '�̹� ��ϵ� �����Դϴ�.');
                ROLLBACK;
        WHEN TIME_OVER_ERROR
            THEN RAISE_APPLICATION_ERROR(-20306, 'Ż�����ڰ� ���� �Ⱓ�� ������ϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- DELETE
CREATE OR REPLACE PROCEDURE PRC_FAIL_DELETE
(
    V_FAIL_CODE IN TBL_FAIL.FAIL_CODE%TYPE
)
IS
    CHECK_FAIL_CODE TBL_FAIL.FAIL_CODE%TYPE;
    
    NO_DATA_ERROR  EXCEPTION;
BEGIN
    SELECT NVL(
                 (  SELECT FAIL_CODE 
                    FROM TBL_FAIL
                    WHERE FAIL_CODE = V_FAIL_CODE       ), 0) INTO CHECK_FAIL_CODE
    FROM DUAL;
    
    -- �Է��� �ߵ�Ż�� �ڵ� ���� ��� ������ ���� ����
    IF(CHECK_FAIL_CODE = 0)
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    DELETE
    FROM TBL_FAIL
    WHERE FAIL_CODE = V_FAIL_CODE;
    
    EXCEPTION
        WHEN NO_DATA_ERROR
            THEN RAISE_APPLICATION_ERROR(-20112, '��ϵ��� ���� �ߵ�Ż���ڵ��Դϴ�.');                 -- �Է��� �ߵ�Ż�� �ڵ� ���� ��� ������ ���� ����
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    COMMIT;
    
END;


-- TBL_POINT(����) ���̺� ------------------------------------------------------

--����{��������[��������(���ǽ�, ����), ���ǰ���(����, ����)]}
----------------------
--PRC_POINT_INSERT 
--EXEC PRC_POINT_INSERT(V_POINT_ATTEND, V_POINT_PRACTICE, V_POINT_WRITE, V_OCLASS_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20401, '��ȿ���� ���� �����Դϴ�.');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20402, '�� ������ 100�� �Ǿ�� �մϴ�.');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20113, '��ϵ��� ���� ���������ڵ��Դϴ�.');
        WHEN POINT_AWARDED
            THEN RAISE_APPLICATION_ERROR(-20012, '�̹� ������ �ο��� �����Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
    
END;


----------------------
--PRC_POINT_UPDATE
--EXEC PRC_POINT_UPDATE(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE)

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
    IF (V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 0 AND
        V_POINT_ATTEND + V_POINT_PRACTICE + V_POINT_WRITE != 100)
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
            THEN RAISE_APPLICATION_ERROR(-20401, '��ȿ���� ���� �����Դϴ�.');
        WHEN NEEDS_TO_BE_100
            THEN RAISE_APPLICATION_ERROR(-20402, '�� ������ 100�� �Ǿ�� �մϴ�.');
        WHEN NO_DATA_FOUND
            THEN RAISE_APPLICATION_ERROR(-20113, '��ϵ��� ���� ���������ڵ��Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


-------------------
--PRC_POINT_DELETE  
--EXEC PRC_POINT_DELETE(POINT_CODE);

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
            THEN RAISE_APPLICATION_ERROR(-20113, '��ϵ��� ���� ���������ڵ��Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
    COMMIT;
END;


-- TBL_GRADE(����) ���̺� ------------------------------------------------------

-- ���� �Է�(INSERT)
CREATE OR REPLACE PROCEDURE PRC_GRADE_INSERT
(
    V_GRADE_ATTEND      IN TBL_GRADE.GRADE_ATTEND%TYPE      -- ��Ἲ��
   ,V_GRADE_WRITE       IN TBL_GRADE.GRADE_WRITE%TYPE       -- �ʱ⼺��
   ,V_GRADE_PRACTICE    IN TBL_GRADE.GRADE_PRACTICE%TYPE    -- �Ǳ⼺��
   ,V_OCLASS_CODE       IN TBL_GRADE.OCLASS_CODE%TYPE       -- ���������ڵ� 
   ,V_SIGN_CODE         IN TBL_GRADE.SIGN_CODE%TYPE         -- ������û�ڵ�
)
IS
    V_CHECK1        TBL_OCLASS.OCLASS_CODE%TYPE;    
    V_CHECK2        NUMBER;
    V_END_DATE      TBL_OCLASS.END_DATE%TYPE;
    V_START_DATE    TBL_OCLASS.START_DATE%TYPE;
    V_CHECK_GRADE   NUMBER;
    
    V_FAIL_DATE     TBL_FAIL.FAIL_DATE%TYPE;
    
    GRADE_DATE_ERROR    EXCEPTION;          -- �������� �����߿� �����Է�X ����
    NO_DATA_ERROR       EXCEPTION;          -- ������ ���� ���� 
    ALREADY_DATA_ERROR  EXCEPTION;          -- �̹� ���� �ο��� �Ϸ�� ���� ����
    UNDER_ZERO_ERROR    EXCEPTION;          -- ���, �Ǳ�, �ʱ� ������ �Է��Ҷ� ������ ����
    NOT_END_ERROR       EXCEPTION;          -- �������� �ʾ��� ��� ����

BEGIN
    -- �̹� ������ ���� �ڵ����� Ȯ��
    SELECT OCLASS_CODE INTO V_CHECK1
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    
    -- ������û �ڵ尡 ��ȿ����..
    SELECT COUNT(SIGN_CODE) INTO V_CHECK2
    FROM TBL_SIGN
    WHERE SIGN_CODE = V_SIGN_CODE;
    
    IF (V_CHECK2 = 0)
        THEN RAISE NO_DATA_ERROR;
    END IF;
    
    -- ���� ���� �߰��� ���� �Է� �Ұ� 
    SELECT START_DATE, END_DATE INTO V_START_DATE, V_END_DATE 
    FROM TBL_OCLASS
    WHERE OCLASS_CODE =  V_OCLASS_CODE;
    
    IF (SYSDATE BETWEEN V_END_DATE AND V_START_DATE)
        THEN RAISE GRADE_DATE_ERROR;
    END IF;
   
   -- �̹� ���� �ο��� �Ϸ�� �����Դϴ�
    SELECT COUNT(GRADE_CODE) INTO V_CHECK_GRADE
    FROM TBL_GRADE
    WHERE SIGN_CODE = V_SIGN_CODE AND OCLASS_CODE = V_OCLASS_CODE;
    
    IF(V_CHECK_GRADE != 0)
        THEN RAISE ALREADY_DATA_ERROR;
    END IF;
    
    -- ���, �Ǳ�, �ʱ� ������ �Է��Ҷ� ������ ���� �߻� 
    IF(V_GRADE_ATTEND < 0 OR V_GRADE_PRACTICE < 0 OR V_GRADE_WRITE < 0) 
        THEN RAISE UNDER_ZERO_ERROR; 
    END IF;
    
    -- �ߵ�Ż�� ���̺� �ִ� ������û �ڵ��� ���, ���� �������� Ż���Ϻ��� �ڿ� ���� ��� ���� �Է� �Ұ�
    -- �Է¹��� ���������ڵ带 �������� ������ �˻�
    SELECT END_DATE INTO V_END_DATE
    FROM TBL_OCLASS
    WHERE OCLASS_CODE = V_OCLASS_CODE;
    
    -- �Է¹��� ������û�ڵ带 �������� Ż���� �˻�
    SELECT NVL( ( SELECT FAIL_DATE
                  FROM TBL_FAIL
                  WHERE SIGN_CODE = V_SIGN_CODE ), TO_DATE('0001-01-01', 'YYYY-MM-DD') ) INTO V_FAIL_DATE
    FROM DUAL;

    -- Ż���ϰ� ������ ���Ͽ� ���ǿ� ������ ���� �߻�
    IF (V_FAIL_DATE != TO_DATE('0001-01-01', 'YYYY-MM-DD'))
        THEN IF (V_FAIL_DATE < V_END_DATE)
                THEN RAISE NOT_END_ERROR;
             END IF;
    END IF;
    
    INSERT INTO TBL_GRADE(GRADE_CODE, GRADE_ATTEND, GRADE_PRACTICE, GRADE_WRITE, OCLASS_CODE, SIGN_CODE)
    VALUES(TBL_GRADE_SEQ.NEXTVAL, V_GRADE_ATTEND, V_GRADE_PRACTICE, V_GRADE_WRITE, V_OCLASS_CODE, V_SIGN_CODE);
    
    -- ����� ������ 50�� �̸��̸� �ߵ�Ż�� ���̺� ������ �߰�
    IF (V_GRADE_ATTEND<50 OR V_GRADE_WRITE<50 OR V_GRADE_PRACTICE<50)
        THEN INSERT INTO TBL_FAIL(FAIL_CODE, FAIL_DATE, SIGN_CODE, REASON_CODE)
             VALUES(TBL_FAIL_SEQ.NEXTVAL, TO_DATE(SYSDATE, 'YYYY-MM-DD'), V_SIGN_CODE, 6);
    END IF;
    
    -- ���� ó��
    EXCEPTION 
    
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20113, '��ϵ��� ���� ���������ڵ��Դϴ�.');    
        WHEN NO_DATA_ERROR       
            THEN RAISE_APPLICATION_ERROR(-20111, '��ϵ��� ���� ������û�ڵ��Դϴ�.');       
        WHEN GRADE_DATE_ERROR   
            THEN RAISE_APPLICATION_ERROR(-20307, '�����Է±Ⱓ�� �ƴմϴ�.');        
        WHEN ALREADY_DATA_ERROR   
            THEN RAISE_APPLICATION_ERROR(-20013, '�̹� ������ �Էµ� �������Դϴ�.');            
        WHEN UNDER_ZERO_ERROR
            THEN RAISE_APPLICATION_ERROR(-20403, '��ȿ���� ���� �����Դϴ�.');
       WHEN NOT_END_ERROR
            THEN RAISE_APPLICATION_ERROR(-20308, '���� �������� ���� �����Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
            
                      
END;


-- PRC_GRADE_UPDATE
CREATE OR REPLACE PROCEDURE PRC_GRADE_UPDATE
(
    V_GRADE_CODE        IN TBL_GRADE.SIGN_CODE%TYPE         -- �����ڵ�
   ,V_GRADE_ATTEND      IN TBL_GRADE.GRADE_ATTEND%TYPE      -- ��Ἲ��
   ,V_GRADE_WRITE       IN TBL_GRADE.GRADE_WRITE%TYPE       -- �ʱ⼺��
   ,V_GRADE_PRACTICE    IN TBL_GRADE.GRADE_PRACTICE%TYPE    -- �Ǳ⼺��

)
IS
    V_CHECK     TBL_GRADE.GRADE_CODE%TYPE;

BEGIN
    
    SELECT GRADE_CODE INTO V_CHECK
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;

    -- ���, �ʱ�, �Ǳ� ������Ʈ
    UPDATE TBL_GRADE
    SET GRADE_ATTEND = V_GRADE_ATTEND, GRADE_WRITE = V_GRADE_WRITE, GRADE_PRACTICE = V_GRADE_PRACTICE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    EXCEPTION
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20114, '��ϵ��� ���� �����ڵ��Դϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
            
        
END;


-- PRC_GRADE_DELETE       
CREATE OR REPLACE PROCEDURE PRC_GRADE_DELETE
(
    V_GRADE_CODE IN TBL_GRADE.GRADE_CODE%TYPE
)
IS
    V_CHECK     TBL_GRADE.GRADE_CODE%TYPE;
    
BEGIN
    -- ���� �ڵ� ���� ���� Ȯ��
    SELECT GRADE_CODE INTO V_CHECK
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
    
    DELETE
    FROM TBL_GRADE
    WHERE GRADE_CODE = V_GRADE_CODE;
     
    EXCEPTION 
        WHEN no_data_found
            THEN RAISE_APPLICATION_ERROR(-20114, '��ϵ��� ���� �����ڵ��Դϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
             
    COMMIT;
    
END;
















