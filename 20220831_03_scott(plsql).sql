SELECT USER
FROM DUAL;
--==>> SCOTT

--�� TBL_INSA ���̺��� ���� ���� ������ ���� ���� ������ ����
--   (�ݺ��� Ȱ��)
---�ش� �ڵ�--------------------------------------------------------------------
SET SERVEROUTPUT ON;

DECLARE
    V_INSA  TBL_INSA%ROWTYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        --��ȸ
        SELECT NAME, TEL, BUSEO
                INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;      -- 1001
        
        --���
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' || V_INSA.TEL || ' - ' || V_INSA.BUSEO);
        
        --������
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 1060;
    END LOOP;
END;
--------------------------------------------------------------------------------


--���� FUNCTION(�Լ�) ����--

--1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--   �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ�ϴµ� ���ȴ�.
--   ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--   ���� ������ �Լ��� ���� �� �ִ�. (������ ���� �Լ�)
--   �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--   ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.


--2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[( 
    �Ű�������1 �ڷ���
  , �Ű������� 2 �ڷ���
)]
RETURN ������Ÿ��
IS
    --�ֿ� ���� ����(���� ����)
BEGIN
    --���๮;
    ...
    RETURN(��);
    
    [EXCEPTION]
        --���� ó�� ����;
END;
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������ Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION�� �ݵ�� ���� ���� ��ȯ�Ѵ�.

--�� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹι�ȣ) �� '771212-1022432' �� 'YYYYMMDD-NNNNNNN' 

DESC TBL_INSA;
--==>> SSN �� VARCHAR2(14)

--CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2(14) )
CREATE OR REPLACE FUNCTION FN_GENDER
( 
    V_SSN VARCHAR2              -- �Ű����� : �ڸ���(����) ���� ���� : VARCHAR2(14) �ƴ�
)
--RETURN VARCHAR2(24)
RETURN VARCHAR2                 -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����
IS
    -- �����(�ֿ� ���� ����)
    V_RESULT    VARCHAR2(24);
BEGIN
    -- �����(���� �� ó��)
    
    -- ����� ��ȯ CHECK~!!!
END;




CREATE OR REPLACE FUNCTION FN_GENDER
( 
    V_SSN VARCHAR2 
)
RETURN VARCHAR2
IS
    -- �����(�ֿ� ���� ����)
    V_RESULT    VARCHAR2(24);
BEGIN
    -- �����(���� �� ó��)
    IF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
        THEN V_RESULT := '����';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ����� ��ȯ CHECK~!!!
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.



--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� �� (A, B)
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�
-- �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/
CREATE OR REPLACE FUNCTION FN_POW
( 
    A NUMBER
  , B NUMBER 
)
RETURN NUMBER
IS
    -- �����(�ֿ� ���� ����)
    V_RESULT    NUMBER := 1;   -- �Լ��� ��ȯ�� �����
    V_NUM       NUMBER;        -- ���ѷ��� ����
BEGIN
    -- �����(���� �� ó��)
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A;
    END LOOP;
    
    RETURN V_RESULT;
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.

-- �׽�Ʈ
SELECT FN_POW(5, 3)
FROM DUAL;
--==>> 125

--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�
--   �޿��� (�⺻��*12)+���� ������� ������ �����Ѵ�
--   �Լ��� : FN_PAY(�⺻��, ����)
CREATE OR REPLACE FUNCTION FN_PAY
(
    V_BASICPAY NUMBER
  , V_SUDADNG  NUMBER
)
RETURN NUMBER
IS
    V_SALARY    NUMBER;
BEGIN
    V_SALARY := (NVL(V_BASICPAY, 0) * 12) + NVL(V_SUDADNG, 0);
    RETURN V_SALARY;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

-- �׽�Ʈ
SELECT NAME "�̸�", FN_PAY(BASICPAY, SUDANG) "�⺻��+����"
FROM TBL_INSA;
--==>>
/*
ȫ�浿	31520000
�̼���	16040000
    :
��ž�	10902000
*/


--�� TBL_INSA ���̺��� �Ի����� ��������
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�
--   �Լ��� : FN_WORKYEAR(�Ի���)
DESC TBL_INSA;

SELECT NAME, IBSADATE
FROM TBL_INSA;

-- ���� Ǭ ���
CREATE OR REPLACE FUNCTION FN_WORKYEAR
(
    V_IBSADATE  DATE
)
RETURN NUMBER
IS
    V_TEMP    NUMBER; -- �Ҽ����� �����ϱ� �� �ٹ������ ���� ����
    V_RESULT  NUMBER; -- ���� �ٹ������ ���� ����
BEGIN
    --�ٹ���� := ����⵵-�Ի�⵵
    --V_TEMP := SYSDATE - V_IBSADATE; -- �̷��� �ص� ��
    V_TEMP := TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) - TO_DATE(TO_CHAR(V_IBSADATE, 'YYYY-MM-DD'));
    V_RESULT := TRUNC((V_TEMP/365),1);
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

-- �ش� ���
--1
SELECT MONTHS_BETWEEN(SYSDATE, '2002-02-11')/12
FROM DUAL;

--2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '2002-02-11')/12) || '��' ||
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'), 12) ) || '����'
FROM DUAL;

--3
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE) "�ٹ��Ⱑ"
FROM TBL_INSA;

--4
CREATE OR REPLACE FUNCTION FN_WORKYEAR
( 
    V_IBSADATE  DATE
)
RETURN VARCHAR2
IS
    V_RESULT  VARCHAR2(20);
BEGIN
--    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, V_IBSADATE)/12) || '��' ||
--                TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, V_IBSADATE), 12) )  || '����';
    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, V_IBSADATE)/12, 1);                       
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

-- �׽�Ʈ
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
ȫ�浿	23.9
�̼���	21.7
�̼���	23.5
    :
��ž�	20.9
*/