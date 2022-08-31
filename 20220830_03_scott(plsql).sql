SELECT USER
FROM DUAL;
--==>> SCOTT


-- ���� PL/SQL ���� --

-- 1. PL/SQL (Procedual Language extension to SQL) ��
--    ���α׷��� ����� Ư���� ������ SQL �� Ȯ���̸�, 
--    ������ ���۰� ���� ������ PL/SQL �� ������ �ڵ� �ȿ� ���Եȴ�,
--    ����, PL/SQL �� ����Ϸ��� SQL�� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⿡�� '������' �̶�� �ܾ ������ �ǹ̴� 
--    � ���� � ������ ���� ��� �Ϸ�Ǵ��� 
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�

-- 2. PL/SQL �� ���������� ǥ���ϱ� ���� 
--    ������ ������ �� �ִ� ���,
--    ���� ������ ������ �� �ִ� ���,
--    ���� �帧�� ��Ʈ�� �� �� �ִ� ��� ���� �����Ѵ�,

-- 3. PL/SQL �� �� ������ �Ǿ�������
--    ���� ����/ ���� / ����ó�� �κ��� 
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����

-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(DECLATATIONS)
BEGIN
    -- ���๮(STATEMENT)
    [EXCEPTION]
    -- ���� ó����(EXCEPTION HANDLERS)
END;
*/

-- (������ ������ ����ó������ ���๮�� ���ԵǴ� ��)


-- 5. ���� ����

/*
DECLARE
    ������ �ڷ���;
    ������ �ڷ��� := �ʱⰪ; ( := �̰� ���Կ������̴� . ������ �ִ°� �������� )
    
BEGIN
    PL/SQL����;
END;

*/

--�� DBMS_OUTPUT.PUT_LINE() �� ����
--   ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����
SET SERVEROUTPUT ON;

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    D1  NUMBER := 10;
    D2  VARCHAR2(30) := 'HELLO';
    D3  VARCHAR2(20) := 'Oracle';
BEGIN
    -- �����
    --System.out.println(D1);
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
-- PL/SQL �� �����ݷ��� ���� �� �̹Ƿ� ���ϴ� ��ŭ ����� ���� ��Ƽ�(�巡��) ����(������)�ؾ� �Ѵ�


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    V1  NUMBER := 10;
    V2  VARCHAR2(30) := 'HELLO';
    V3  VARCHAR2(30) := 'ORACLE';
BEGIN
    -- �����
    -- (���� �� ó��)
    V1 := V1 * 10;             -- �ڹٿ��� V1 *= 10; �� ���� ����
    V2 := V2 || ' ���̰�';      -- �ڹٿ��� V2 += ' ���̰�'; 
    V3 := V3 || ' WORLD~!!!';   -- �ڹٿ��� V3 += ' WORLD~!!!';
    
    -- (��� ���)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
--==>>
/*
100
HELLO ���̰�
ORACLE WORLD~!!!


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� IF ��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    IF ���ǿ��� ó���� ����� TRUE �̸� THEN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF; ������ ������ �����ϰ� �ȴ�.

--2. ���� �� ����
/*
-- �� �ܵ� IF
IF ����
    THEN ó����;
END IF;


-- �� IF�� ELSE�� �����ִ� ���� 
IF ����
    THEN ó����;
ELSE 
    ó����;
END IF;


-- �� ��ø��
IF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSE
    ó����;
END IF;
*/

SET SERVEROUTPUT ON;

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>>
/*
EXCELLENT


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/



DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>>
/*
GOOD


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� CASE ��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮1;
    WHEN ��2 THEN ���๮2;
    ELSE ���๮3;
END CASE;
*/


--�� �ܺ� �Է� ó��

-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
--  '&�ܺκ�����' ���·� �����ϰ� �ȴ�

-- ex)
-- ����1 ����2 �Է��ϼ���
-- 1
-- �����Դϴ�.

-- ����1 ����2 �Է��ϼ���
-- 2
-- �����Դϴ�.

ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    -- ����� (�ֿ� ���� ����)
    SEL     NUMBER := &NUM;
    RESULT  VARCHAR2(10) := '����';
BEGIN
    -- �׽�Ʈ
--    DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
--    DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('���� �Դϴ�');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('���� �Դϴ�');
        ELSE
            DBMS_OUTPUT.PUT_LINE('���� Ȯ�� �Ұ�');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '����';
        WHEN 2
        THEN RESULT := '����';
        ELSE
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || ' �Դϴ�');
END;
--==>> 1�� 2 �̿��� ���� �Է� �� ���� �߻�
--     ORA-06502: PL/SQL: numeric or value error: character string buffer too small
--     ���� ���� �� ���� �ʹ� �۰� �־ ���� ����
--     ����Ŭ ĳ���ͼ¿� ���� �ѱ� �� ���ڿ� 3����Ʈ�� �ν� �Ǵ� ��찡 ����
--     ������ VARCHAR2(10)�� ����⿡ 'Ȯ�κҰ�'(12����Ʈ) ��� ���� ũ�Ⱑ ���� �ʴ� ����
--     VARCHAR(20)���� �ٲٸ� ���� �ذ�


-- �� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
-- �̵��� ���� ����� ����ϴ�  PL/SQL ������ �ۼ��Ѵ�.

ACCEPT N1 PROMPT 'ù ��° ���� �Է�';
ACCEPT N2 PROMPT '�� ��° ���� �Է�';

DECLARE
    -- ���� (�ֿ� ���� ����)
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
--    TOTAL   NUMBER;         -- �̷��� �ص� �Ǳ� ��(�ڵ��ʱ�ȭ?)
    TOTAL   NUMBER := 0;
BEGIN
    TOTAL := NUM1 + NUM2;
    
    -- �׽�Ʈ NUM1�� NUM2�� ����� ���������� ���� ����
    DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1);
    DBMS_OUTPUT.PUT_LINE('NUM2 : ' || NUM2);
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;


-- �� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ ����ϴ� ���α׷��� �ۼ��Ѵ�.
--    ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4

��Ʈ) TRUNC() �� MOD() ���

SELECT TRUNC(48.678, 2) "COL2"     -- 48.67    -- �� ��° �Ķ���� : �Ҽ��� ���� �� ° �ڸ����� ǥ��
FROM DUAL;

SELECT MOD(5, 2) "COL1"
FROM DUAL;  -- 5�� 2�� ���� ������
*/

ACCEPT WON PROMPT '�ݾ� �Է�';

DECLARE
    OHBACK  NUMBER := TRUNC(&WON/500);
    BACK    NUMBER := TRUNC(MOD(&WON, 500)/100);
    OHSIP   NUMBER := TRUNC(MOD(MOD(&WON, 500),100)/50);
    SIP     NUMBER := TRUNC(MOD(MOD(MOD(&WON, 500),100),50)/10);
    TOTAL   NUMBER := &WON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || TOTAL || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || OHBACK || ', ��� ' || BACK || ', ���ʿ� ' || OHSIP || ', �ʿ� ' || SIP);
END;
--==>> �ϰ��� ����ο� ����ó������ �� �ع��ȳ�...
/*
�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ���4, ���ʿ�1, �ʿ�4


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


-- �ش� Ǯ��
ACCEPT INPUT PROMPT '�ݾ� �Է�';

DECLARE
    --����� (�ֿ� ���� ����)
    MONEY   NUMBER := &INPUT;       -- ������ ���� �Է°��� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;       -- ��� ����� ���� �Է°��� ��Ƶ� ����
                                    -- (MONEY ������ ���� �������� ���� ���ϱ� ������)
    M500    NUMBER;                 -- 500�� ¥�� ������ ��Ƶ� ����
    M100    NUMBER;                 -- 100�� ¥�� ������ ��Ƶ� ����
    M50     NUMBER;                 -- 50�� ¥�� ������ ��Ƶ� ����
    M10     NUMBER;                 -- 10�� ¥�� ������ ��Ƶ� ����    
BEGIN
    -- ���� �� ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������ �� 500�� ����
    M500 := TRUNC(MONEY / 500);

    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������ �� 500�� ���� Ȯ�� �� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���
    MONEY := MOD(MONEY, 500);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������ �� 100�� ����
    M100 := TRUNC(MONEY / 100);

    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������ �� 100�� ���� Ȯ�� �� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���
    MONEY := MOD(MONEY, 100);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������ �� 50�� ����
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������ �� 50�� ���� Ȯ�� �� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���
    MONEY := MOD(MONEY, 50);
    
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������ �� 10�� ����
    M10 := TRUNC(MONEY / 10);
    
    -- ��� ���
    -- ���յ� ���(ȭ�� ������ ����)�� ���Ŀ� �°� ���� ����Ѵ�
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');     
    -- MONEY�� ������ ���� �ٿ��Ա⿡, �ѱݾ� ��¸��� ���� ���� MONEY2�� �Է��Ѵ�

    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� ' || M500 || ', ��� ' || M100 || ', ���ʿ� ' || M50 || ', �ʿ� ' || M10);
END;