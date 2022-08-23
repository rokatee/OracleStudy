SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�
/*
--------- -------------
   ����      �޿���
--------- -------------
   ��        XXXXXX
   ��        XXXXXX
�����     XXXXXX
--------- -------------
*/
SELECT *
FROM TBL_SAWON;

-- 1�ܰ�
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            ELSE '�����Ǻ��Ұ�'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON;
/*
����	3000
����	2000
����	4000
����	2000
����	1000
����	3000
����	4000
����	1500
����	1300
����	2600
����	1300
����	2400
����	2800
����	5200
����	5200
����	1500
*/

-- 2�ܰ�
SELECT T.���� "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            ELSE '�����Ǻ��Ұ�'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON
) T
GROUP BY T.����;
--==>>
/*
����	31800
����	11000
*/
SELECT T.���� "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
            ELSE '�����Ǻ��Ұ�'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
-- �̷����ϸ� ������ NULL�� ����� ���´�
/*
����	11000
����	31800
(null)	42800
*/

-- 3�ܰ� CASE WHEN THEN ELSE END ���
SELECT CASE GROUPING(T.����) WHEN 0 THEN T.���� 
                             ELSE '�����'
       END "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '�����Ǻ��Ұ�'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>> 
/*
����	    11000
����	    31800
�����	42800
*/

-- 3�ܰ� NVL ���
SELECT NVL(T.����, '�����') "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
            ELSE '�����Ǻ��Ұ�'
       END "����"
     , SAL "�޿�"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>> 
/*
����	    11000
����	    31800
�����	42800
*/


--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�
/*
-------- --------
 ���ɴ�   �ο���
-------- --------
  10         ?
  20         ?
  30         ?
  50         ?
 ��ü       16
 -------- --------
*/

SELECT *
FROM TBL_SAWON;

-- INLINE VIEW �� �� �� ��ø
-- 1�ܰ� ���糪�� ���ϱ�
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE 0
       END "���糪��"
FROM TBL_SAWON;

-- 2�ܰ� ������������ �̿��� �������� ǥ���ϱ�
SELECT CASE WHEN T.���糪�� >= 50 THEN 50
            WHEN T.���糪�� >= 40 THEN 40
            WHEN T.���糪�� >= 30 THEN 30
            WHEN T.���糪�� >= 20 THEN 20
            WHEN T.���糪�� >= 10 THEN 10
       ELSE 0
       END "����"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE 0
           END "���糪��"
    FROM TBL_SAWON
) T
ORDER BY 1;
--==>>
/*
10
10
20
20
20
20
20
20
20
20
30
30
50
50
50
50
*/

-- 3�ܰ� 2�� ������������ �̿��� ���ɴ� ���� ����
SELECT CASE WHEN T2.���� IS NULL THEN '��ü' 
            ELSE TO_CHAR(T2.����)
       END "���ɴ�"
    -- NVL(TO_CHAR(T2.����), '��ü') "���ɴ�" -- �ٷ� �� �ٰ� ���� �ǹ�
    
     , COUNT(T2.����) "�ο���"
FROM
(
    SELECT CASE WHEN T.���糪�� >= 50 THEN 50
                WHEN T.���糪�� >= 40 THEN 40
                WHEN T.���糪�� >= 30 THEN 30
                WHEN T.���糪�� >= 20 THEN 20
                WHEN T.���糪�� >= 10 THEN 10
           ELSE 0
           END "����"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                    ELSE 0
               END "���糪��"
        FROM TBL_SAWON
    ) T
) T2
GROUP BY ROLLUP(T2.����);
--==>>
/*
10	     2
20	     8
30	     2
50	     4
��ü	16
*/


-- INLINE VIEW �� �� �� ���
-- 1�ܰ� TRUNC() �� �̿��� ���糪�̿��� ù°�ڸ� ������ 0���� ǥ�������μ� �������� �ٲٱ�
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0
       END, -1) "����"
FROM TBL_SAWON
ORDER BY 1;
--==>>
/*
10
10
20
20
20
20
20
20
20
20
30
30
50
50
50
50
*/

-- 2�ܰ� ������������ �̿��� ���ɴ� ���ϱ�
SELECT 
     /*CASE WHEN T.���� IS NULL THEN '��ü' 
            ELSE TO_CHAR(T.����)*/
       CASE GROUPING(T.����) WHEN 0 THEN TO_CHAR(T.����)
            ELSE '��ü'
       END "T.����"
     , COUNT(*) "�ο���"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                      ELSE 0
                 END, -1) "����"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
10	     2
20	     8
30	     2
50	     4
��ü	16
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300   -- 10�� �μ� CLERK     ������ �޿���
10	    MANAGER	     2450   -- 10�� �μ� MANAGER   ������ �޿���
10	    PRESIDENT	 5000   -- 10�� �μ� PRESIDENT ������ �޿���
10	    (null)	     8750   -- 10�� �μ� ���      ������ �޿���
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875   -- 20�� �μ� ��� ������ �޿���
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400   -- 30�� �μ� ��� ������ �޿���
(null)  (null)      29025   -- ��� �μ� ��� ������ �޿���
*/


--�� CUBE() �� ROLLUP() ���� �� �ڼ��� ����� ��ȯ�޴´�.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)	     8750
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400
(null)	ANALYST	     6000   -- ��� �μ� ANALYST    ������ �޿���
(null)	CLERK	     4150   -- ��� �μ� CLERK      ������ �޿���
(null)	MANAGER	     8275   -- ��� �μ� MANAGER    ������ �޿���
(null)	PRESIDENT  	 5000   -- ��� �μ� PRESIDENT  ������ �޿���
(null)	SALESMAN	 5600   -- ��� �μ� SALESMAN   ������ �޿���
(null)	(null)	    29025   -- ��� �μ�     ���   ������ �޿���
*/


--�� ROLLUP() �� CUBE()��
--   �׷��� �����ִ� ����� �ٸ���.(����)

-- ex.

-- ROLLUP(A, B, C)
-- �� (A,B,C,) / (A,B) / (A) / ()


-- CUBE(A, B, C)
-- �� (A, B, C)/(A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ���� ������ (ROLLUP())���� ����� �ټ� ���ڶ� ���� �ְ�
--     �Ʒ� ������(CUBE()) ���� ����� �ټ� ����ĥ ���� �ֱ� ������
--     ������ ���� ����� ������ �� ���� ����ϰ� �ȴ�
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸
--     ��GROUPING SETS���� �̿��Ͽ� �����ִ� ����̴�.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        ��ü����	 8750

20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        ��ü����	10875

30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        ��ü����	 9400

����	    CLERK	     3500
����	    SALESMAN	 5200
����	    ��ü����	 8700

��ü�μ�	��ü����	37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        ��ü����	 8750

20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        ��ü����	10875

30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        ��ü����	 9400

����	    CLERK	     3500
����	    SALESMAN	 5200
����	    ��ü����	 8700

��ü�μ�	ANALYST	     6000
��ü�μ�	CLERK	     7650
��ü�μ�	MANAGER	     8275
��ü�μ�	PRESIDENT	 5000
��ü�μ�	SALESMAN	10800

��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
--==>> CUBE() �� ����� ����� ���� ��ȸ ��� ��ȯ

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())
ORDER BY 1, 2;
--==>> ROLLUP() �� ����� ����� ���� ��ȸ ��� ��ȯ


--------------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

--�� TBL_EMP ���̺��� �������
--   �Ի�⵵�� �ο����� ��ȸ�Ѵ�
/*
    �Ի�⵵    �ο���
------------------------
   1980          1
   1981          10
   1982          1
   1987          2
   2022          5
   ��ü          19
*/
-- 1�ܰ�
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(EXTRACT(YEAR FROM HIREDATE)) "�ο���"
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)), ())
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987 	 2
2022	 5
(null)	19
*/

-- 2�ܰ�
SELECT CASE WHEN EXTRACT(YEAR FROM HIREDATE) IS NULL THEN '��ü' 
            ELSE TO_CHAR(EXTRACT(YEAR FROM HIREDATE)) 
       END "�Ի�⵵"
     , COUNT(EXTRACT(YEAR FROM HIREDATE)) "�ο���"
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)), ())
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
��ü	19
*/


--�ش� Ǯ��
-- 1�ܰ�
SELECT ? "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY �Ի�⵵;

-- 2�ܰ�
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
    , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
--==>>

SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
    , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;



SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> �����߻�
--     ORA-00979: not a GROUP BY expression

SELECT  EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
    , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;
--==>> �����߻�
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE) 
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> �����߻�
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE) 
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> �����߻�
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY') 
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> �����߻�
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY') 
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> �����߻�
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY') 
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
��ü	19
*/

--------------------------------------------------------------------------------
--���� HAVING ����--

--�� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE �μ���ȣ�� 20, 30
GROUP BY �μ���ȣ;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
--==>>
/*
30	 9400
20	10875
*/

SELECT DEPTNO "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO
ORDER BY 1;
--==>> �����߻�
--     ORA-00934: group function is not allowed here
--     WHERE ���������� SUM()�� �� �� ����

-- ��
SELECT DEPTNO "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000     -- �׷��� HAVING���� ����
ORDER BY 1;
--==>> 30	9400

-- ��
SELECT DEPTNO "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
   AND DEPTNO IN (20, 30)
ORDER BY 1;
--==>> 30	9400
--     �̷��� �ᵵ �������� ������ ������
--     ���� ��� WHERE������ �����ؼ� �޸𸮿� �ø��Ƿ� �޸� ���� ������ ����,
--     ���� ��� WHERE���� ���� ��� �����͸� �޸𸮿� �ø��Ƿ�
--     �޸𸮿� �������� ���������� ����
--     �׷��Ƿ� �簡 �� ������ �ڵ��̴�

--     ��HAVING���� ���� WHERE������ ��밡������ ����غ��� �ڵ� �ۼ��� ��

--------------------------------------------------------------------------------
--���� ��ø �׷��Լ� / �м��Լ� ����--

-- �׷� �Լ��� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875



-- RANK() / DENSE_RANK()
--> ORACLE 9i ���� ����...MMSQL 2005 ���� ����

--> ���� ���������� RANK() �� DENSE_RANK() �� ����� �� ���� ������
--  ���� ���... �޿� ������ ���ϰ��� �Ѵٸ�..
--  �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
--  Ȯ���� ���ڿ� +1 �� �߰� �������ָ�
--  �� ���� �� �ش� ����� ����� �ȴ�

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1     -- SMITH ���� �޿��� ���� ����� 13���̹Ƿ�
FROM EMP                -- SMITH �� �޿� ����� +1�� ����� �Ѵ�
WHERE SAL > 800;        -- SMITH �� �޿�
--==>> 14               -- SMITH �� �޿� ���

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;       -- ALLEN �� �޿�
--==>> 7                -- ALLEN �� �޿� ���


--�� ���� ��� ����(��� ���� ����)
--   ���� ������ �ִ� ���̺��� �÷���
--   ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
--   �츮�� �� �������� ���� ��� ����(��� ���� ����) ��� �θ���

SELECT ENAME "�����", SAL "�޿�", 1 "�޿����"
FROM EMP;

SELECT ENAME "�����", SAL "�޿�", (1) "�޿����"
FROM EMP;

SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > 800) "�޿����"
FROM EMP;

SELECT E.ENAME "�����", E.SAL "�޿�"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "�޿����"
FROM EMP E
ORDER BY 3;
--==>>
/*
KING	5000	 1
FORD	3000	 2
SCOTT	3000	 2
JONES	2975	 4
BLAKE	2850	 5
CLARK	2450	 6
ALLEN	1600	 7
TURNER	1500	 8
MILLER	1300	 9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	 950	13
SMITH	 800	14
*/


--�� EMP ���̺��� �������
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸� ��ȸ
--   ��, RANK() �Լ��� ������� �ʰ� ������������ Ȱ���� �� �ֵ��� �Ѵ�

-- �����----------------------
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;

SELECT E.ENAME "�����", E.SAL "�޿�"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "�޿����"
FROM EMP E
ORDER BY 3;
-- �����----------------------

SELECT E.ENAME "�����", E.SAL "�޿�", E.DEPTNO "�μ���ȣ"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL) "��ü�޿����"
     ,(1) "�μ����޿����"
FROM EMP E
ORDER BY 4;

SELECT E.ENAME "�����", E.SAL "�޿�", E.DEPTNO "�μ���ȣ"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL) "��ü�޿����"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL 
         AND DEPTNO = E.DEPTNO) "�μ����޿����"
FROM EMP E
ORDER BY 3, 5;
--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	2	2
MILLER	1300	10	3	3
SCOTT	3000	20	1	1
FORD	3000	20	1	1
JONES	2975	20	3	3
ADAMS	1100	20	4	4
SMITH	 800	20	5	5
BLAKE	2850	30	1	1
ALLEN	1600	30	2	2
TURNER	1500	30	3	3
MARTIN	1250	30	4	4
WARD	1250	30	4	4
JAMES	 950	30	6	6
*/

-- �ش� Ǯ��
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800         -- SMITH �� �޿�
  AND DEPTNO = 20;      -- SMITH �� �μ���ȣ
--==>> 5                -- SMITH �� �μ��� �޿� ���

SELECT E.ENAME "�����", E.SAL "�޿�", E.DEPTNO "�μ���ȣ"
     ,(1) "�μ����޿����"
     ,(1) "��ü�޿����"
FROM EMP E;

SELECT E.ENAME "�����", E.SAL "�޿�", E.DEPTNO "�μ���ȣ"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL
         AND DEPTNO = E.DEPTNO) "�μ����޿����"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL
         AND DEPTNO = E.DEPTNO) "��ü�޿����"
FROM EMP E
ORDER BY 3, 5;
--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	2	2
MILLER	1300	10	3	3
SCOTT	3000	20	1	1
FORD	3000	20	1	1
JONES	2975	20	3	3
ADAMS	1100	20	4	4
SMITH	 800	20	5	5
BLAKE	2850	30	1	1
ALLEN	1600	30	2	2
TURNER	1500	30	3	3
MARTIN	1250	30	4	4
WARD	1250	30	4	4
JAMES	 950	30	6	6
*/



--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� ������ ����
/*
                                         - �� �μ� ������ �Ի����� ���� 
                                           ������ �޿��� ��
---------------------------------------------------------------------
 �����    �μ���ȣ    �Ի���         �޿�      �μ����Ի纰�޿�����
---------------------------------------------------------------------
 SMITH	      20	  1980-12-17	   800              800
 JONES	      20	  1981-04-02	  2975             3775
 FORD	      20	  1981-12-03	  3000             6775
 SCOTT	      20	  1987-07-13	  3000               :
 ADAMS	      20	  1987-07-13	  1100               :
                           :                             :
*/
-- 1�ܰ�
SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , (1) "�μ����Ի纰�޿�����"
FROM EMP
ORDER BY DEPTNO, HIREDATE;

-- �Ի�� ���� �޿� �� ���� (1)�� ������ �ȴ�
SELECT SUM(SAL)
FROM EMP
WHERE DEPTNO = E.DEPTNO 
  AND HIREDATE <= E.HIREDATE;

-- 2�ܰ�
SELECT E.ENAME "�����", E.DEPTNO "�μ���ȣ", E.HIREDATE "�Ի���", E.SAL "�޿�"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO) "�μ����Ի纰�޿�����"
FROM EMP E
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
CLARK	10	1981-06-09	2450	8750
KING	10	1981-11-17	5000	8750
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	 800	10875
JONES	20	1981-04-02	2975	10875
FORD	20	1981-12-03	3000	10875
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	9400
WARD	30	1981-02-22	1250	9400
BLAKE	30	1981-05-01	2850	9400
TURNER	30	1981-09-08	1500	9400
MARTIN	30	1981-09-28	1250	9400
JAMES	30	1981-12-03	 950	9400
*/

-- 3�ܰ�
SELECT E.ENAME "�����", E.DEPTNO "�μ���ȣ", E.HIREDATE "�Ի���", E.SAL "�޿�"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO
          AND HIREDATE <= E.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
CLARK	10	1981-06-09	2450	 2450
KING	10	1981-11-17	5000	 7450
MILLER	10	1982-01-23	1300	 8750

SMITH	20	1980-12-17	 800	  800
JONES	20	1981-04-02	2975	 3775
FORD	20	1981-12-03	3000	 6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875

ALLEN	30	1981-02-20	1600	 1600
WARD	30	1981-02-22	1250	 2850
BLAKE	30	1981-05-01	2850	 5700
TURNER	30	1981-09-08	1500	 7200
MARTIN	30	1981-09-28	1250	 8450
JAMES	30	1981-12-03	 950	 9400
*/


--�� EMP ���̺��� �������
--   �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� ����
/*
---------- -------------------
 �Ի���       �ο���
---------- -------------------
 1981-02          2
 1981-09          2
 1981-12          2
 1987-07          2
---------- -------------------
*/
-- �߸ŷ� �ϴ� �غ�
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = MAX(2)
ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (�Ի��� ���� �ִ� �ο�)
ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');

-- EMP���� �Ի��� ����� ���� ���� ���� ���� ��
SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');

-- �ϼ�
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'))
ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT T1.�Ի���, T1.�ο���
FROM
(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
         , COUNT(*) "�ο���"
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
) T1
WHERE T1.�ο��� = (SELECT MAX(T2.�ο���)
                   FROM
                   (
                        SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
                             , COUNT(*) "�ο���"
                        FROM EMP
                        GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
                   ) T2
                  )
ORDER BY 1;