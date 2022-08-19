--�� EMP ���̺��� ������ CLERK �� ������� �����͸� ��� ��ȸ�Ѵ�

SELECT *
FROM EMP
WHERE ������ CLERK�� ������� ������;

SELECT *
FROM EMP
WHERE JOB�� 'CLERK';

SELECT *
FROM EMP
WHERE JOB = CLERK;
--==>> �����߻�

SELECT *
FROM EMP
WHERE JOB = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		    20
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		    30
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10
*/


--�� ����Ŭ���� �Էµ� �������� �� ��ŭ��
--   �ݵ�� ��ҹ��� ������ �Ѵ�


--�� EMP ���̺��� ������ CLERK �� ����� ��
--   20�� �μ��� �ٹ��ϴ� �������
--   �����ȣ, �����, ������, �޿�, �μ���ȣ �׸��� ��ȸ�Ѵ�


SELECT EMPNO "�����ȣ", ENAME "�����", JOB "������", SAL "�޿�", DEPTNO "�μ���ȣ"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/


-- 1. Į���� Ȯ��
DESCRIBE emp;

-- 2. Į���� �־ ���̺� ������ ������
--    �ٸ� ���̺� �ִ� �����͸� �״�� �־� ���� ���̺��� ������� �ִ�
--    AS �� ����Ͽ�...
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

-- 3. Ȯ��
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7788	SCOTT	ANALYST	    7566	87/07/13	3000		    20
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7876	ADAMS	CLERK	    7788	87/07/13	1100		    20
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
*/

--�� DEPT ���̺��� �����Ͽ� ���� ���� TBL_DEPT ���̺��� �����Ѵ�
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/


SELECT *
FROM USER_TAB_COMMENTS;
--���� �ڸ�Ʈ�� ���� NULL


--�����̺� ������ Ŀ��Ʈ ���� �Է�
COMMENT ON TABLE TBL_EMP IS '��� ����';


--�� TBL_DEPT ���̺��� ������� ���̺� ������ Ŀ��Ʈ ������ �Է�
--   �� �μ� ��ȣ
COMMENT ON TABLE TBL_DEPT IS '�μ� ��ȣ';


--�� Ŀ��Ʈ ������ �Է� �� Ȯ��
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_EXAMPLE2	TABLE	
TBL_DEPT	    TABLE	�μ� ��ȣ
TBL_EMP	        TABLE	��� ����
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--�� �÷�(COLUMN) ������ Ŀ��Ʈ ������ Ȯ��
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
EMP	            DEPTNO	
TBL_EXAMPLE2	NAME	
SALGRADE	    HISAL	
BONUS	        JOB	
TBL_DEPT	    LOC	
DEPT	        DNAME	
TBL_EMP	        SAL	
TBL_EMP	        COMM	
TBL_EMP	        JOB	
TBL_EMP	        MGR	
BONUS	        COMM	
TBL_EXAMPLE1	NAME	
SALGRADE	    GRADE	
SALGRADE	    LOSAL	
BONUS	        ENAME	
EMP	            HIREDATE	
EMP	            JOB	
TBL_EXAMPLE1	ADDR	
EMP	            COMM	
EMP	            EMPNO	
TBL_EXAMPLE2	ADDR	
DEPT	        LOC	
EMP	            ENAME	
EMP	            MGR	
TBL_EMP	        HIREDATE	
EMP	            SAL	
TBL_EXAMPLE2	NO	
TBL_DEPT	    DNAME	
DEPT	        DEPTNO	
TBL_EXAMPLE1	NO	
TBL_EMP	        DEPTNO	
TBL_EMP	        EMPNO	
TBL_EMP	        ENAME	
BONUS	        SAL	
TBL_DEPT	    DEPTNO		
*/


--�� �÷�(COLUMN) ������ Ŀ��Ʈ ������ Ȯ��
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/


-- COMMENT ON TABLE ���̺�� IS 'Ŀ��Ʈ';

--�� ���̺� �Ҽӵ�(���Ե�) �÷��� ���� Ŀ��Ʈ ������ �Է�(����)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '�μ� ��ȣ';

COMMENT ON COLUMN TBL_DEPT.DNAME IS '�μ� �̸�';

COMMENT ON COLUMN TBL_DEPT.LOC IS '�μ� ��ġ';

--�� Ŀ��Ʈ �����Ͱ� �Էµ� ���̺���
--   �÷� ���� Ŀ��Ʈ ������ Ȯ��(TBL_DEPT ���̺� �Ҽ��� �÷��鸸 ��ȸ)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';


--�� TBL_EMP ���̺��� �������
--   ���̺� �Ҽӵ�(���Ե�) �÷��� ���� Ŀ��Ʈ ������ �Է�(����)
DESC TBL_EMP;
--==>>
/*
�̸�       ��? ����           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
*/

COMMENT ON COLUMN TBL_EMP.EMPNO IS '��� ��ȣ';
COMMENT ON COLUMN TBL_EMP.ENAME IS '�����';
COMMENT ON COLUMN TBL_EMP.JOB IS '����';
COMMENT ON COLUMN TBL_EMP.MGR IS '������ �����ȣ';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '�Ի���';
COMMENT ON COLUMN TBL_EMP.SAL IS '�޿�';
COMMENT ON COLUMN TBL_EMP.COMM IS '����';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '�μ� ��ȣ';

--�� Ŀ��Ʈ �����Ͱ� �Էµ� ���̺���
--   �÷� ���� Ŀ��Ʈ ������ Ȯ��(TBL_EMP ���̺� �Ҽ��� �÷��鸸 ��ȸ)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    ��� ��ȣ
TBL_EMP	ENAME	    �����
TBL_EMP	JOB	        ����
TBL_EMP	MGR	        ������ �����ȣ
TBL_EMP	HIREDATE	�Ի���
TBL_EMP	SAL	        �޿�
TBL_EMP	COMM	    ����
TBL_EMP	DEPTNO	    �μ� ��ȣ
*/


--���� �÷� ������ �߰� �� ���� ����--

SELECT *
FROM TBL_EMP;

--�� TBL_EMP ���̺� �ֹι�ȣ �����͸� ���� �� �ִ� �÷� �߰�
--   ������ �����̱⿡ ALTER ���
--   ���̺� �߰��� �� �ִ� �� ���������̳� �÷��̴�
ALTER TABLE TBL_EMP
ADD SSN ������Ÿ��;

ALTER TABLE TBL_EMP
ADD SSN CHAR(13);   -- �ֹι�ȣ(13�ڸ�)ó�� ���̰� ������ �����ʹ� VARCHAR ���� CHAR
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.

SELECT '01012345678'
FROM DUAL;
--==>> 01012345678

SELECT 01012345678
FROM DUAL;
--==>> 1012345678
-- ���� Ÿ���̶� �Ǿ��� 0�� ������

--�� SSN �÷� �߰� Ȯ��
SELECT *
FROM TBL_EMP;
--> SSN(�ֹ� ��ȣ) �÷��� ���������� �߰��Ǿ����� Ȯ��

DESC TBL_EMP;
--==>>
/*
�̸�       ��? ����           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
SSN         CHAR(13) 

--> SSN(�ֹι�ȣ) �÷��� ���������� ����(�߰�)�� ������ Ȯ��
*/

--�� ���̺� ������ �÷��� ������ ���������� �ǹ� ����
SELECT ENAME, SSN, EMPNO
FROM TBL_EMP;
-- �̷��� ���ϴ� ��� ���� �� �ֱ� ����


--�� TBL_EMP ���̺� �߰��� SSN(�ֹι�ȣ) �÷� ����
--   �÷��� ���忡�� DROP(����) ������, ���̺��� ���忡�� ALTER(������ ����) �̴�
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.

--�� SSN �÷� ���� Ȯ��
DESC TBL_EMP;
--> SSN(�ֹ� ��ȣ) �÷��� ���������� �����Ǿ����� Ȯ��


SELECT *
FROM TBL_EMP;

DELETE TBL_EMP;
--==>> 14�� �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--> ���̺��� ����(����, Ʋ)�� �״�� �����ִ� ���¿���
--  �����͸� ��� �ҽ�(����)�� ��Ȳ���� Ȯ��
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--==>> ���� �߻�
--     ORA-00942: table or view does not exist
--> ���̺� ��ü�� ���������� ���ŵ� ��Ȳ



--�� ���̺� �ٽ� ����(����)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� NULL �� ó��
SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	12	8	20	5

SELECT NULL
FROM DUAL;
--==>> (null)

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2
FROM DUAL;
--==>> (null)   (null)  (null)  (null)  (null)

--�� ������ ���
--   NULL �� ������ ���� �ǹ��ϸ�... ���� �������� �ʴ� ���̱� ������
--   �� NULL �� ���꿡 ���Ե� ���
--   �� ����� ������ NULL �̴�


--�� TBL_EMP ���̺��� Ŀ�̼�(COMM, ����)�� NULL �� ������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�
SELECT *
FROM TBL_EMP;

SELECT �����, ������, �޿�, Ŀ�̼�
FROM TBL_EMP
WHERE Ŀ�̼�(COMM, ����)�� NULL �� ����

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM�� NULL;

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> �����߻�

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = NULL;
--==>> ��ȸ ��� ����

SELECT EMPNO, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
7369	CLERK	     800	
7566	MANAGER	    2975	
7698	MANAGER	    2850	
7782	MANAGER	    2450	
7788	ANALYST	    3000	
7839	PRESIDENT	5000	
7876	CLERK	    1100	
7900	CLERK	     950	
7902	ANALYST	    3000	
7934	CLERK	    1300	
*/


--�� NULL �� ���� �����ϴ� ���� �ƴϱ� ������
--   �Ϲ����� �����ڸ� Ȱ���Ͽ� ���� �� ����
--   NULL �� ������� ����� �� ���� �����ڵ�
--   >=, <=, =, >, <, !=, <>, ^=


--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ����� �ʴ� ��������
--   �����, ������, �μ���ȣ �׸� ��ȸ
DESC TBL_EMP;

SELECT *
FROM TBL_EMP;

SELECT �����, ������, �μ���ȣ
FORM TBL_EMP
WHERE 20�� �μ��� �ٹ����� �ʴ� ������

SELECT ENAME, JOB, DEPTNO
FROM TBL_EMP
WHERE DEPTNO�� 20�� �ƴ�;

SELECT ENAME, JOB, DEPTNO
FROM TBL_EMP
WHERE DEPTNO != 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	    30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/


--�� TBL_EMP ���̺��� Ŀ�̼��� NULL �� �ƴ� ��������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ

SELECT *
FROM TBL_EMP;

SELECT �����, ������, �޿�, Ŀ�̼�
FROM TBL_EMP
WHERE Ŀ�̼��� NULL �� �ƴ� ������;

SELECT �����, ������, �޿�, Ŀ�̼�
FROM TBL_EMP
WHERE COMM�� NULL �� �ƴ� ������;

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM IS NOT NULL;

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

--�� TBL_EMP ���̺��� ��� �������
--   �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸� ��ȸ
--   ��, �޿�(SAL)�� �ſ� �����Ѵ�
--   ����, ����(COMM)�� �� 1ȸ �����ϸ�, ���� ������ ���Եȴ�

SELECT *
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", (SAL * 12) + COMM "����" 
FROM TBL_EMP;
--==>> Ŀ�̼��� ���� ��� ������ ���� NULL �� ����

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", (SAL * 12) "����" 
FROM TBL_EMP;
--==>> Ŀ�̼��� ���� ������ Ŀ�̼��� �������� �ʴ� ���� ����


--�� NVL() - ����Ŭ�� ���� ó������ �� �ִ� �Լ�
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) "COL3"
FROM DUAL;
--==>> (null)  10   5
-- ù ��° �Ķ���� ���� NULL �̸�, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
-- ù ��° �Ķ���� ���� NULL �� �ƴϸ�, �� ���� �״�� ��ȯ�Ѵ�.

SELECT ENAME "�����", NVL(COMM, 0) "����"
FROM TBL_EMP;

-- A
SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", NVL(COMM, 0) "Ŀ�̼�", (SAL * 12) "����" 
FROM TBL_EMP;
--==>>
/*
20	SMITH	800	    0	    9600
30	ALLEN	1600	300	    19200
30	WARD	1250	500	    15000
20	JONES	2975	0	    35700
30	MARTIN	1250	1400	15000
30	BLAKE	2850	0	    34200
10	CLARK	2450	0	    29400
20	SCOTT	3000	0	    36000
10	KING	5000	0	    60000
30	TURNER	1500	0	    18000
20	ADAMS	1100	0	    13200
30	JAMES	950	    0	    11400
20	FORD	3000	0	    36000
10	MILLER	1300	0	    15600
*/

-- B
SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", (SAL * 12) + NVL(COMM, 0) "����" 
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600
*/

--�� NVL2()
-- ù ��° �Ķ���� ���� NULL �� �ƴ� ���, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
-- ù ��° �Ķ���� ���� NULL �� ���, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
SELECT ENAME '�����', NVL2(COMM, 'û��÷�', '���÷�') "����Ȯ��"
FROM TBL_EMP;

-- C
SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", NVL2(COMM, SAL * 12 + COMM, SAL * 12) "����"
FROM TBL_EMP;

-- D
SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", SAL * 12 + NVL2(COMM, COMM, 0) "����"
FROM TBL_EMP;


--�� COALESCE()
--> �Ű����� ������ ���� ���·� �����ϰ� Ȱ���Ѵ�
--  �� �տ� �ִ� �Ű��������� ������ NULL ���� �ƴ��� Ȯ���Ͽ�
--  NULL �� ��쿡�� �� ���� �Ű������� ���� ��ȯ�Ѵ�
--  NVL() �̳� NVL2() �� ���Ͽ�
--  ��� ����� ���� ����� �� �ִٴ� Ư¡�� ���´�

SELECT NULL "COL1"
     , COALESCE(NULL, NULL, NULL, 40) "COL2"
     , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "COL3"
     , COALESCE(NULL, NULL, 30, NULL, 60) "COL4"
     , COALESCE(10, NULL, NULL, NULL, 60) "COL5"
FROM DUAL;
--==>> (null) 40 100 30 10


--�� �ǽ��� ���� ������ �߰� �Է�
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '���ִ�', 'SALESMAN', 7369, SYSDATE, 10);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8001, '������', 'SALESMAN', 7369, SYSDATE, 10, 10);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

COMMIT;
--==> Ŀ�� �Ϸ�.

-- ������ �߰� Ȯ��
SELECT *
FROM TBL_EMP;



--�� �޿��� NULL�� ����� �޿�, ���� �� �� NULL �� ����� �߰� �Ǿ��� ��
--   COALESCE() �� Ȱ���Ͽ� ������ ��ȸ�Ѵ�
--   TIP. ���� �� Ȯ���� ���� ���� ������� COALESCE �Ķ���Ϳ� ������� �־�ô�
SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����" 
    , COALESCE(SAL * 12 + COMM, SAL * 12, COMM, 0) "����"
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", NVL(SAL, 0) "�޿�", NVL(COMM, 0) "Ŀ�̼�"
    , COALESCE(SAL * 12 + COMM, SAL * 12, COMM, 0) "����"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975		    35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		    34200
7782	CLARK	2450		    29400
7788	SCOTT	3000		    36000
7839	KING	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	FORD	3000		    36000
7934	MILLER	1300		    15600
8000	���ִ�			        0
8001	������		    10	    10
*/


--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� �÷��� �÷��� ����(����)
SELECT 1, 2
FROM DUAL;

SELECT 1 + 2
FROM DUAL;

SELECT '������', '������'
FROM DUAL;
--==>> ������	������
-- �� ���� �÷��� ���� ����

SELECT '������' + '������'
FROM DUAL;
--==>> ���� �߻�
--     ORA-01722: invalid number


SELECT '������' || '������'
FROM DUAL;
--==>> �����Ϻ�����
-- �� ���� �÷��� ����
-- ���ڿ��� ���ڿ��� �� ���� ������ �ϱ� ���ؼ� ||(������)�� ����϶�

SELECT ENAME, JOB
FROM TBL_EMP;

SELECT ENAME || JOB
FROM TBL_EMP;
--==>>
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
���ִ�SALEMAN
������SALEMAN
*/

SELECT '�����̴�', SYSDATE, '�� ����', 500, '���� ���Ѵ�.'
FROM DUAL;
--==>> �����̴�	2022-08-12 04:03:14	�� ����	      500	  ���� ���Ѵ�.
--     -------- ------------------- -------       ---     ------------
--     ����Ÿ��      ��¥Ÿ��       ����Ÿ��   ����Ÿ��   ����Ÿ��

--�� ���� ��¥ �� �ð��� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==>> 2022-08-12 04:05:19	 2022-08-12 04:05:19	  22/08/12 16:05:19.000000000


SELECT '�����̴�' || SYSDATE || '�� ����' || 500 || '���� ���Ѵ�.'
FROM DUAL;
--==>> �����̴�2022-08-12 04:06:16�� ����500���� ���Ѵ�.
-- �� �÷��� �� ���� ���´�

--�� ����Ŭ������ ���� Ÿ���� ���·� �� ��ȯ�ϴ� ������ ���� ����
--   || �� ������ �ָ� ������ �÷��� �÷�(���� �ٸ� ������ ������)��
--   �����ϴ� ���� �����ϴ�
--   cf) MSSQL ������ ��� �����͸� ���ڿ��� CONVERT �ؾ� �Ѵ�


--�� TBL_EMP ���̺��� �����͸� Ȱ���Ͽ�
--   ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�
--   SMITH�� ���� ������ 9600�ε� ��� ������ 19200 �̴�
--   ALLEN�� ���� ������ 19500�ε� ��� ������ 39000 �̴�
--                  :
--                  :
--   �������� ���� ������ 10�ε� ��� ������ 20�̴�
--   ��, ���ڵ帶�� ���� ���� ������ �� �÷��� ��� ��ȸ�� �� �ֵ��� ó��

-- ��. ��� ������ ���� ������ 2��
SELECT ENAME || '�� ���� ������ ' 
    || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) 
    || ' �ε� ��� ������ ' 
    || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) * 2 
    || ' �̴�'
FROM TBL_EMP;
--==>>
/*
SMITH��  ���� ������  9600 �ε� ��� ������  19200 �̴�
ALLEN��  ���� ������ 19500 �ε� ��� ������  39000 �̴�
WARD��   ���� ������ 15500 �ε� ��� ������  31000 �̴�
JONES��  ���� ������ 35700 �ε� ��� ������  71400 �̴�
MARTIN�� ���� ������ 16400 �ε� ��� ������  32800 �̴�
BLAKE��  ���� ������ 34200 �ε� ��� ������  68400 �̴�
CLARK��  ���� ������ 29400 �ε� ��� ������  58800 �̴�
SCOTT��  ���� ������ 36000 �ε� ��� ������  72000 �̴�
KING��   ���� ������ 60000 �ε� ��� ������ 120000 �̴�
TURNER�� ���� ������ 18000 �ε� ��� ������  36000 �̴�
ADAMS��  ���� ������ 13200 �ε� ��� ������  26400 �̴�
JAMES��  ���� ������ 11400 �ε� ��� ������  22800 �̴�
FORD��   ���� ������ 36000 �ε� ��� ������  72000 �̴�
MILLER�� ���� ������ 15600 �ε� ��� ������  31200 �̴�
���ִ��� ���� ������     0 �ε� ��� ������      0 �̴�
�������� ���� ������    10 �ε� ��� ������     20 �̴�
*/




--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--=>> Session��(��) ����Ǿ����ϴ�.

--�� TBL_EMP ���̺��� �����͸� Ȱ���Ͽ�
--   ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�
--   SMITH'S �Ի����� 1980-12-17 �̴�. �׸��� �޿��� 800 �̴�.
--   ALLEN'S �Ի����� 1981-02-20 �̴�. �׸��� �޿��� 1600 �̴�.
--                  :
--                  :
--   ������'S �Ի����� 2022-08-12 �̴�. �׸��� �޿��� 0 �̴�.
--   ��, ���ڵ帶�� ���� ���� ������ �� �÷��� ��� ��ȸ�� �� �ֵ��� ó��

/*
SELECT ENAME || ''s �Ի����� ' 
    || HIREDATE 
    || ' �̴�. �׸��� �޿��� ' 
    || NVL(SAL, 0)
    || ' �̴�.'
FROM TBL_EMP;
--==>> ���� �߻�
--     ORA-00923: FROM keyword not found where expected
--     '(���۽�Ʈ����)�� ǥ���Ϸ� �ϴ� ���ڿ� Ȭ����ǥ�� �ν��ؼ� ������ �߻�
*/

--�� ���ڿ��� ��Ÿ���� Ȭ����ǥ ���̿���(���۰� ��)
--   Ȭ����ǥ �� ���� Ȭ����ǥ �ϳ�(���۽�Ʈ����)�� �ǹ��Ѵ�
--   Ȭ����ǥ ' �ϳ��� ���ڿ��� ������ ��Ÿ����
--   Ȭ����ǥ '' �� ���� ���ڿ� ���� �ȿ��� ���۽�Ʈ���Ǹ� ��Ÿ����
--   �ٽ� �����ϴ� Ȭ����ǥ ' �ϳ���
--   ���ڿ� ������ ���Ḧ �ǹ��ϰ� �Ǵ� ���̴�
SELECT ENAME || '''s �Ի����� ' 
    || HIREDATE 
    || ' �̴�. �׸��� �޿��� ' 
    || NVL(SAL, 0)
    || ' �̴�.'
FROM TBL_EMP;
--==>>
/*
SMITH's  �Ի����� 1980-12-17 �̴�. �׸��� �޿���  800 �̴�.
ALLEN's  �Ի����� 1981-02-20 �̴�. �׸��� �޿��� 1600 �̴�.
WARD's   �Ի����� 1981-02-22 �̴�. �׸��� �޿��� 1250 �̴�.
JONES's  �Ի����� 1981-04-02 �̴�. �׸��� �޿��� 2975 �̴�.
MARTIN's �Ի����� 1981-09-28 �̴�. �׸��� �޿��� 1250 �̴�.
BLAKE's  �Ի����� 1981-05-01 �̴�. �׸��� �޿��� 2850 �̴�.
CLARK's  �Ի����� 1981-06-09 �̴�. �׸��� �޿��� 2450 �̴�.
SCOTT's  �Ի����� 1987-07-13 �̴�. �׸��� �޿��� 3000 �̴�.
KING's   �Ի����� 1981-11-17 �̴�. �׸��� �޿��� 5000 �̴�.
TURNER's �Ի����� 1981-09-08 �̴�. �׸��� �޿��� 1500 �̴�.
ADAMS's  �Ի����� 1987-07-13 �̴�. �׸��� �޿��� 1100 �̴�.
JAMES's  �Ի����� 1981-12-03 �̴�. �׸��� �޿���  950 �̴�.
FORD's   �Ի����� 1981-12-03 �̴�. �׸��� �޿��� 3000 �̴�.
MILLER's �Ի����� 1982-01-23 �̴�. �׸��� �޿��� 1300 �̴�.
���ִ�'s �Ի����� 2022-08-12 �̴�. �׸��� �޿���    0 �̴�.
������'s �Ի����� 2022-08-12 �̴�. �׸��� �޿���    0 �̴�.
*/

SELECT *
FROM TBL_EMP
WHERE JOB = 'SALESMAN';

SELECT *
FROM TBL_EMP
WHERE JOB = 'salesman';

--�� UPPER(), LOWER(), INITCAP()
SELECT 'oRaCLe' "COL1"
    , UPPER('oRaCLe') "COL2"
    , LOWER('oRaCLe') "COL3"
    , INITCAP('oRaCLe') "COL4"
FROM DUAL;
--==>> oRaCLe	ORACLE	oracle	Oracle
-- UPPER() �� ��� �빮�ڷ� ��ȯ
-- LOWER() �� ��� �ҹ��ڷ� ��ȯ
-- INITCAP() �� ù ���ڸ� �빮�ڷ� �ϰ� �������� ��� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ


--�� �ǽ��� ���� �߰� ������ �Է�
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8002, '�¹̴�', 'salesman', 7369, SYSDATE, 20, 100);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� TBL_EMP ���̺��� ������� �˻����� 'sALeSmAN' �� ��������
--   �������(�������)�� �����ȣ, �����, �������� ��ȸ
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB = UPPER('sALeSmAN');
-- �� ��� ������ �߰��� '�¹̴�'�� ������ �ʴ´�

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALeSmAN');
-- JOB�� �����͸� ��� �빮�ڷ� �ٲٰ�
-- ã�����ϴ� �˻� Ű���带 �빮�ڷ� �ٲٸ�
-- ������ �빮�ڵ� �ҹ��ڵ� ���׹����̵� ã�� �� �ִ�

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE LOWER(JOB) = LOWER('sALeSmAN');

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE INITCAP(JOB) = INITCAP('sALeSmAN');
--==>>
/*
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	���ִ�	SALESMAN
8001	������	SALESMAN
8002	�¹̴�	salesman
*/


--�� TBL_EMP ���̺��� �Ի����� 1981�� 9�� 28�� �Ի��� ������
--   �����, ������, �Ի��� �׸��� ��ȸ
SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE �Ի����� 1981�� 9�� 28�� �Ի��� ����;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = 1981�� 9�� 28��;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
--==>> MARTIN	SALESMAN	1981-09-28
-- ������ ���ϸ� Ʋ�� ����
-- �쿬���� ã���� �� ����
-- ����Ŭ�� ����ȯ�� �Ź� ������ ����

--�� TO_DATE()
--   (����Ÿ���� ��¥ Ÿ������ �ٲ���)
-->  TO ~ () �Լ��� ���� ��ȯ ���ְڴٴ� �ǹ̸� �������

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--               TO_DATE()�� ���� ù ��° �Ķ������ ���¸� �� ��° �Ķ���� ó�� �ٲ��ְڴ�
--==>> MARTIN	SALESMAN	1981-09-28


--�� TBL_EMP ���̺��� �Ի����� 1981�� 9�� 28�� ����(�ش��� ����)
--   �Ի��� ������ �����ȣ, �����, �Ի��� �׸��� ��ȸ�Ѵ�.

SELECT �����ȣ, �����, �Ի���
FROM TBL_EMP
WHERE �Ի����� 1981�� 9�� 28�� ���ķ� �Ի��� ����;

SELECT EMPNO "�����ȣ", ENAME "�����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD') ���� �Ի��� ����;

SELECT EMPNO "�����ȣ", ENAME "�����", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
7654	MARTIN	1981-09-28
7788	SCOTT	1987-07-13
7839	KING	1981-11-17
7876	ADAMS	1987-07-13
7900	JAMES	1981-12-03
7902	FORD	1981-12-03
7934	MILLER	1982-01-23
8000	���ִ�	2022-08-12
8001	������	2022-08-12
8002	�¹̴�	2022-08-12
*/


--�� ����Ŭ������ ��¥ �������� ũ�� �񱳰� �����ϴ�
--   ����Ŭ������ ��¥ �����Ϳ� ���� ũ�� �� ��
--   ���ź��� �̷��� �� ū ������ �����Ѵ�

--�� TBL_EMP ���̺��� �Ի����� 1981�� 4�� 2�� ���� 
--   1981�� 9�� 28�� ���̿� �Ի��� ��������
--   �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�. (�ش��� ����)

SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE �Ի����� 1981�� 4�� 2�� ���� 
      1981�� 9�� 28�� ���̿� �Ի��� ������;
      
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = ('1981-04-02', 'YYYY-MM-DD') ���� 
                 ('1981-09-28', 'YYYY-MM-DD') ���̿� �Ի��� ������;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') 
               <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> ���� �߻�

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02' <= '1981-09-28', 'YYYY-MM-DD');
--==>> ���� �߻�

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE TO_DATE('1981-04-02', 'YYYY-MM-DD') <= HIREDATE
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> �̷��� �ص� ������ ���� ����

--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') 
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/



