SELECT USER
FROM DUAL;
--==>> HR

-- �� %TYPE (�ۼ�ƮŸ��)

-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� �ڷ���(������ Ÿ��)�� �����ϴ� ������Ÿ��

-- 2. ���� �� ����
-- ������ ������Ÿ�� �� ������ �̷��� ������
-- ������ ���̺�.�÷���%TYPE [:=�ʱⰪ];

-- ���� ��� NAME EMPLOYEES.ENAME%TYPE(NAME �̶�� �������� Ÿ���� EMPLOYEES
-- ���̺��� ENAME�÷��� Ÿ���� �����ͼ� ���ڴٴ� �ǹ�)

SET SERVEROUTPUT ON;

--�� HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
DESC EMPLOYEES;

SELECT *
FROM EMPLOYEES;

-- �̸�(FIRST_NAME) �÷� Ȯ�� �� VARCHAR2(20)

DECLARE
    -- V_NAME  VARCHAR(20);  
    --> �̷��� �����ڰ� ���� ������Ÿ���� �˾ƺ��� �ϴ� ���ŷο��� ����
    V_NAME EMPLOYEES.FIRST_NAME%TYPE;   
    --> EMPLOYEES�� �ִ� FIRST_NAME�� ������Ÿ���� ����Ŭ���� Ȯ�ν��� ������ �ϴ� ����
BEGIN
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;

    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>>
/*
Alexander


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

--�� EMPLOYEES ���̺��� ������� 108�� ���(NANCY)��
--   SALARY �� ������ ��� ����ϴ� PL/SQL ������ �ۼ��Ѵ�

DECLARE
    V_NAME      EMPLOYEES.FIRST_NAME%TYPE; 
    V_SALARY    EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME, SALARY INTO V_NAME ,V_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 108;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_SALARY);
END;
--==>>
/*
Nancy, 12008


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� EMPLOYEES ���̺��� Ư�� ���ڵ� �׸� ���� ���� ������ ����
--   103�� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���
DECLARE
    V_NAME   EMPLOYEES.FIRST_NAME%TYPE;
    V_PHONE  EMPLOYEES.PHONE_NUMBER%TYPE;
    V_EMAIL  EMPLOYEES.EMAIL%TYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL INTO V_NAME, V_PHONE, V_EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ', ' || V_PHONE ||', '|| V_EMAIL);
END;
--==>>
/*
Alexander, 590.423.4567, AHUNOLD


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� &ROWTYPE 

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)

-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE;

DECLARE
    --V_NAME     VARCHAR(20);
    --V_PHONE    VARCHAR(20);
    --V_EMAIL    VARCHAR(25);
        
    --V_NAME   EMPLOYEES.FIRST_NAME%TYPE;
    --V_PHONE  EMPLOYEES.PHONE_NUMBER%TYPE;
    --V_EMAIL  EMPLOYEES.EMAIL%TYPE;
    
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
            INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
END;
--==>>
/*
Alexander, 590.423.4567, AHUNOLD


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� EMPLOYEES ���̺��� ��ü ���ڵ� �׸� ���� ���� ������ ����
--   ��� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���

DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
            INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
END;
--==>> �����߻�
--      ORA-01422: exact fetch returns more than requested number of rows

--> ���� ���� ��(ROWS) ������ ���� �������� �Ͽ�
-- ������ �����ϴ� �� ��ü�� �Ұ���������.

--------------------------------------------------------------------------------
---���� �ڵ�-------------------------------------------------------------------- 
-- 1. LOOP ��
/*
LOOP
    -- ���๮           ���̿� ���๮ ���� �ȴ�. �ݺ��� �ؾߵǴ� �����̴�. 
    EXIT WHEN ����;   -- ������ ���� ��� �ݺ����� ����������. 
END LOOP;
*/
DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
    V_NUM   EMPLOYEES.EMPLOYEE_ID%TYPE := 100;
BEGIN
    LOOP 
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
                INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM >= 206;
    END LOOP;
END;



-- 3. FOR LOOP ��
/*
FOR ī���� IN [REVERSE] LOOP ���ۼ� .. ������ LOOP
        -- ���๮;
END LOOP;
*/
DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
    V_NUM   EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
    FOR V_NUM IN 100 .. 206 LOOP 
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
                INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' || V_EMP.PHONE_NUMBER ||', '|| V_EMP.EMAIL);
    END LOOP;
END;
--------------------------------------------------------------------------------
---������ �ڵ�------------------------------------------------------------------

DECLARE
    EMPNUM NUMBER;
    NUM NUMBER;
BEGIN
    SELECT COUNT(*) INTO EMPNUM
    FROM EMPLOYEES;
    
    FOR NUM IN 100..(99+EMPNUM) LOOP
        DECLARE
        EMP EMPLOYEES%ROWTYPE;
        
        BEGIN
            SELECT FIRST_NAME , PHONE_NUMBER, EMAIL
            INTO EMP.FIRST_NAME, EMP.PHONE_NUMBER, EMP.EMAIL
            FROM EMPLOYEES
            WHERE EMPLOYEE_ID = NUM;
        
            DBMS_OUTPUT.PUT_LINE(EMP.FIRST_NAME ||',   ' || EMP.PHONE_NUMBER|| ',     ' || EMP.EMAIL);
        END;
    END LOOP; 
END;
--------------------------------------------------------------------------------
---�� �� ������ ���� �ش� �ڵ�� 20220831_03_scott(plsql).sql �� ����-------------