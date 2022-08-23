SELECT USER
FROM DUAL;
--==>> SCOTT


-- �� TBL_EMP ���̺��� �޿��� ���� ���� �����
--    �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�

-- �޿��� ���� ���� �޴� ����� �޿�
SELECT MAX(SAL)
FROM TBL_EMP;
--==>> 5000

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE �޿��� ���� ���� ���;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = �޿��� ���� ���� ���;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
            FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000


-- "=ANY"

-- "=ALL"

SELECT SAL
FROM TBL_EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
1500
2000
1700
2500
1000
*/

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = ANY(800, 1600, 1250, 2975, 1250, 2850
                , 2450, 3000, 5000, 1500, 1100, 950
                , 3000, 1300, 1500, 2000, 1700, 2500, 1000);

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ANY(800, 1600, 1250, 2975, 1250, 2850
                , 2450, 3000, 5000, 1500, 1100, 950
                , 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> ANY �� ��� ���� �����̳� �Ʒ��� �Ȱ���
/*
7369	SMITH	800
7499	ALLEN	1600
7521	WARD	1250
7566	JONES	2975
7654	MARTIN	1250
7698	BLAKE	2850
7782	CLARK	2450
7788	SCOTT	3000
7839	KING	5000
7844	TURNER	1500
7876	ADAMS	1100
7900	JAMES	950
7902	FORD	3000
7934	MILLER	1300
8001	���¹�	1500
8002	������	2000
8003	�躸��	1700
8004	������	2500
8005	������	1000
*/

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(800, 1600, 1250, 2975, 1250, 2850
                , 2450, 3000, 5000, 1500, 1100, 950
                , 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> 7839	KING	5000


SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL
                 FROM TBL_EMP);
--==>> 7839	KING	5000


--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ��ϴ� ����� ��
--   �޿��� ���� ���� �����
--   �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� ����

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE 20�� �μ��� �ٹ��ϴ� ����� ��
  AND �޿��� ���� ���� ���;
  
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20
  AND SAL = �޿��� ���� ���� ���;

-- ��� 1
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM TBL_EMP
WHERE DEPTNO = 20
  AND SAL >= ALL(SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20);

-- ��� 2
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM TBL_EMP
WHERE DEPTNO = 20
GROUP BY EMPNO, ENAME, JOB, SAL, DEPTNO
HAVING SAL >= ALL(SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20);

-- ��� 3         
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM TBL_EMP 
WHERE DEPTNO = 20 
GROUP BY EMPNO, ENAME, JOB, SAL, DEPTNO
HAVING SAL = (SELECT MAX(SAL) 
                FROM TBL_EMP 
                WHERE DEPTNO = 20);
--==>>
/*
7902	FORD	ANALYST	3000	20
7788	SCOTT	ANALYST	3000	20
*/


--�� TBL_EMP ���̺��� ����(Ŀ�̼�, COMM)�� ���� ���� �����
--   �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼� �׸��� ��ȸ�Ѵ�
SELECT �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼�
FROM TBL_EMP
WHERE ����(Ŀ�̼�, COMM)�� ���� ���� ���;

SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM = ����(Ŀ�̼�, COMM)�� ���� ���� ���;

-- ��� 1
SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL(SELECT NVL(COMM, 0)
                  FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400
--     "=ALL" �� �� �� NULL���� ó�� ����� �Ѵ�

-- ��� 2
SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM)
              FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400
--     MAX() �� NULL���� �����ϰ� ������� �����

-- ��� 3
SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL(SELECT COMM
                  FROM TBL_EMP
                  WHERE COMM IS NOT NULL);
--==>> 7654	MARTIN	30	SALESMAN	1400


--�� DISTINCT() �ߺ� ��(���ڵ�)�� �����ϴ� �Լ�
SELECT JOB
FROM TBL_EMP;

SELECT DISTINCT(JOB)
FROM TBL_EMP;

-- TBL_EMP ���̺��� �����ڷ� ��ϵ� �����
-- �����ȣ, �����, �������� ��ȸ
SELECT *
FROM TBL_EMP;

SELECT �����ȣ, �����, ������
FROM TBL_EMP
WHERE �����ڷ� ��ϵ� ���;

SELECT �����ȣ, �����, ������
FROM TBL_EMP
WHERE �����ȣ = (������(MGR)�� ��ϵ� ���);

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (7902, 7698, 7698, 7839, 7698, 7839, 7839, 7566, null
                , 7698, 7788, 7698, 7566, 7782, 7566, 7566, 7698, 7698, 7698);

-- ��� 1                
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT MGR
                FROM TBL_EMP);

-- ��� 2
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR)
                FROM TBL_EMP);
--==>> ��� 1 ���� ���ҽ� �Ҹ� ����
/*
7839	KING	PRESIDENT
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7902	FORD	ANALYST
*/

-- ��� 3
SELECT T1.EMPNO, T1.ENAME, T1.JOB
FROM TBL_EMP T1, TBL_EMP T2
WHERE T1.EMPNO = T2.MGR
GROUP BY T1.EMPNO, T1.ENAME, T1.JOB;

-- ��� 4
SELECT DISTINCT T1.EMPNO, T1.ENAME, T1.JOB
FROM TBL_EMP T1, TBL_EMP T2
WHERE T1.EMPNO = T2.MGR;
--==>>
/*
7839	KING	PRESIDENT
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7902	FORD	ANALYST
*/

--------------------------------------------------------------------------------
SELECT *
FROM TBL_SAWON;

/*
--�� TBL_SAWON ���̺� ���(������ ����)
--   �� �� ���̺� ���� ���質 �������� ���� ������ ����
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> 
-- TBL_SAWON ���̺��� �����͵鸸 ����� ����
-- ��, �ٸ� �̸��� ���̺� ���·� ������ �� ��Ȳ

--�� ������ ����
UPDATE TBL_SAWON
SET SANAME = '�ʶ���'
WHERE SANO = 1005;
--==>> �Ǽ��� ��� ����� �̸��� �ʶ��̷� �ٲۻ���
--     �̷� �� ��� ���󺹱� ��ų��?

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO)
WHERE SANO = '�ʶ���';
-- ����� �����Ͱ� �ִٸ�, �̷��� ���󺹱� ����
*/


