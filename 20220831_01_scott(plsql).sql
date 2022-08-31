SELECT USER
FROM DUAL;
--==>> SCOTT;

    
-- �� �⺻ �ݺ���
-- LOOP ~ END LOOP;  (���� �����ߴ� ���� ������)

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮           ���̿� ���๮ ���� �ȴ�. �ݺ��� �ؾߵǴ� �����̴�. 
    EXIT WHEN ����;   -- ������ ���� ��� �ݺ����� ����������. 
END LOOP;
*/

--�� 1���� 10������ �� ���(LOOP �� Ȱ��)

DECLARE
    NUM NUMBER;
BEGIN
    NUM := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
    EXIT WHEN NUM >= 10;
    NUM := NUM + 1;
    END LOOP;
END;


--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵� �� üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP       -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/

--�� 1���� 10������ �� ���(WHILE LOOP �� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    N := 0;
    WHILE N <= 10 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;


--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. �� ���� ���� ���� 1�� �����Ͽ�
--    �������� ���� �� �� �� ���� �ݺ� �����Ѵ�.
    
-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] LOOP ���ۼ� .. ������ LOOP
        -- ���๮;
END LOOP;
*/

--�� 1���� 10������ �� ���(FOR LOOP �� Ȱ��)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;



--<������ 3���� �ݺ������� ����ϱ�>
-- �� ����ڷκ��� ������ ��(������)�� �Է¹޾�
-- �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
-- LOOP, WHILE LOOP, FOR LOOP �� ���� �ذ��Ѵ�.

/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2*1=2
2*2=4
:
:
2*9=18

*/

-- 1. LOOP ��
/*
LOOP
    -- ���๮           ���̿� ���๮ ���� �ȴ�. �ݺ��� �ؾߵǴ� �����̴�. 
    EXIT WHEN ����;   -- ������ ���� ��� �ݺ����� ����������. 
END LOOP;
*/

ACCEPT VAR PROMPT '���� �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ����
    -- (DAN * N = DAN*N;)
    DAN NUMBER;     -- ���� �� �κ�
    N   NUMBER;     -- ���� �� �κ�
BEGIN
    DAN := &VAR;
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
        N := N + 1;
        EXIT WHEN N >= 10;
    END LOOP;
END;


-- 2. WHILE LOOP ��
/*
WHILE ���� LOOP       -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/

ACCEPT VAR PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    DAN := &VAR;
    N := 1;
    WHILE N <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
        N := N + 1;
    END LOOP;
END;

-- 3. FOR LOOP ��
/*
FOR ī���� IN [REVERSE] LOOP ���ۼ� .. ������ LOOP
        -- ���๮;
END LOOP;
*/

ACCEPT VAR PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    DAN := &VAR;
    
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN*N);
    END LOOP;
END;


--�� ������ ��ü(2~9��)�� ����ϴ�  PL/SQL ������ ����Ѵ�
--   ��, ���� �ݺ���(�ݺ����� ��ø) ������ Ȱ���Ѵ�
/*
���� ��)

==[2��]==
2 * 1 = 2
2 * 2 = 4
    :
    
==[9��]==
9 * 1 = 9
9 * 2 = 18
    :
9 * 9 = 81    
*/

-- 1. LOOP ��
/*
LOOP
    -- ���๮           ���̿� ���๮ ���� �ȴ�. �ݺ��� �ؾߵǴ� �����̴�. 
    EXIT WHEN ����;   -- ������ ���� ��� �ݺ����� ����������. 
END LOOP;
*/
DECLARE
-- ���� 1�ڸ��� ������ �� �ִ� NUMBER�� ���� DAN, N�� ����
    DAN NUMBER := 2;
    N   NUMBER := 1;
BEGIN
    -- �ܺ� ����
    LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || DAN || '�� ]==');
        N := 1;
        
        -- ���� ����
        LOOP
            DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || N || ' = ' || DAN * N);
            N := N + 1;
            EXIT WHEN N >= 10;
        END LOOP;    -- ���� ���� ����
            
        DAN := DAN + 1;
        EXIT WHEN DAN >= 10;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;  -- �ܺ� ���� ����
END;



-- 2. WHILE LOOP ��
/*
WHILE ���� LOOP       -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/
DECLARE
    DAN NUMBER := 2;
    N   NUMBER := 1;
BEGIN
    -- �ܺ� ����
    WHILE DAN <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || DAN || '�� ]==');
        N := 1;
        
        -- ���� ����
        WHILE N <= 9 LOOP
            DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || N || ' = ' || DAN * N);
            N := N + 1;
        END LOOP;    -- ���� ���� ����
            
        DAN := DAN + 1;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;  -- �ܺ� ���� ����
END;


-- 3. FOR LOOP ��
/*
FOR ī���� IN [REVERSE] LOOP ���ۼ� .. ������ LOOP
        -- ���๮;
END LOOP;
*/
DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    -- �ܺ� ����
    FOR DAN IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || DAN || '�� ]==');
        
        -- ���� ����
        FOR N IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || N || ' = ' || DAN * N);
        END LOOP; -- ���� ���� ����
        
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP; -- �ܺ� ���� ����
END;