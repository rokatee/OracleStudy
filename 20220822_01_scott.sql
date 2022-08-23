SELECT USER
FROM DUAL;
--==>> SCOTT

--���� ROW_NUMBER ����--

SELECT ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;
--==>>
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
12	ADAMS	1100	1987-07-13
7	ALLEN	1600	1981-02-20
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
4	JONES	2975	1981-04-02
1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
9	MILLER	1300	1982-01-23
3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	1987-07-13
2	ALLEN	1600	1981-02-20
3	BLAKE	2850	1981-05-01
4	CLARK	2450	1981-06-09
5	FORD	3000	1981-12-03
6	JAMES	 950	1981-12-03
7	JONES	2975	1981-04-02
8	KING	5000	1981-11-17
9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	1987-07-13
2	FORD	3000	1981-12-03
3	JONES	2975	1981-04-02
4	SCOTT	3000	1987-07-13
5	SMITH	 800	1980-12-17
*/


--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���.... ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�
--   �̴� ���ȼ� �����̳�, �̰��� �ٶ������� ���� ������ �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ �Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� �ٶ����� �� �ִ�

--�� SEQUENCE(������: �ֹ���ȣ)
--   �� �������� �ǹ� : 1. (�Ϸ���) �������� ��ǵ�
--                      2. (���, �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD   -- �⺻���� ������ ���� ���� (�ش� �� �ٸ� �־ ������)
START WITH 1                -- ���۰� : 1���� ����
INCREMENT BY 1              -- ������ : 1�� ����
NOMAXVALUE                  -- �ִ밪 : �������� ����
NOCACHE;                    -- ĳ�� ��� �� ��(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.

-- ĳ�ÿ� ���� �ο� ����
-- ������ ���� ������ �� �̸� ������ ������ ���� ������ ����
-- ������, DB�� ������Ű�ų� ������ off �Ǵ� ���� ����
-- �̸� ������ ������ ������ �� ������ �������� 
-- ������ ������ ���� �̸� ������ �� ���� ���� ���ȴٴ� ��
-- (1~20���� ĳ������ �� 1�� ���� �� DB SHUTDOWN �Ǹ�
--  ���� ĳ�� ��ȣ�� 2���̾�� ������ 21���� ������ �ȴ�) 
-- https://doughman.tistory.com/11
-- http://www.gisdeveloper.co.kr/?p=9239

--�� �ǽ� ���̺� ����
CREATE TABLE TBL_BOARD              -- TBL_BOARD ���̺� ���� ���� �� �Խ��� ���̺�
( NO        NUMBER                  -- �Խù� ��ȣ
, TITLE     VARCHAR2(50)            -- �Խù� ����
, CONTENTS  VARCHAR2(1000)          -- �Խù� ����
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���
, PW        VARCHAR2(20)            -- �Խù� �н�����
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��� �׼�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~ �ڰ�ʹ�', '10�и� �ڰ� �ò���', '������', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~ ����', '������ ���� ����־��', '���ҿ�', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����ʹ�', '�����̰� �ʹ� ����;��', '������', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����Ŀ�', '��ħ�ε� ����Ŀ�', '������', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ʹ��־��', '������ ���������� �ʹ� �־��', '���¹�', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ڶ��', '���� ���� ���ڶ��', '������', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ο�', '���� ���� ���� ���ڶ��', '������', 'java002$', DEFAULT);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��´��', '���ù���� ��´��', '�ڿ���', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 8


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	��~ �ڰ�ʹ�	10�и� �ڰ� �ò���	            ������	java002$	2022-08-22
2	��~ ����	    ������ ���� ����־��	        ���ҿ�	java002$	2022-08-22
3	����ʹ�	    �����̰� �ʹ� ����;��	    ������	java002$	2022-08-22
4	����Ŀ�	    ��ħ�ε� ����Ŀ�	            ������	java002$	2022-08-22
5	�ʹ��־��	    ������ ���������� �ʹ� �־��	���¹�	java002$	2022-08-22
6	���ڶ��	    ���� ���� ���ڶ��	            ������	java002$	2022-08-22
7	���ο�	        ���� ���� ���� ���ڶ��	        ������	java002$	2022-08-22
8	��´��	    ���ù���� ��´��	            �ڿ���	java002$	2022-08-22
*/

/*
-- ���̺� �ۼ� �Ǽ� ���� ��, ���̺� �� ������ ����
DROP TABLE TBL_BOARD PURGE;
--==>>Table TBL_BOARD��(��) �����Ǿ����ϴ�.

DROP SEQUENCE SEQ_BOARD;
--==>>Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.
*/

--�� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� �Խù� ����

DELETE
FROM TBL_BOARD
WHERE NO = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
2	��~ ����	������ ���� ����־��	        ���ҿ�	java002$	2022-08-22 10:18:51
3	����ʹ�	�����̰� �ʹ� ����;��	    ������	java002$	2022-08-22 10:18:54
4	����Ŀ�	��ħ�ε� ����Ŀ�	            ������	java002$	2022-08-22 10:19:37
5	�ʹ��־��	������ ���������� �ʹ� �־��	���¹�	java002$	2022-08-22 10:19:38
7	���ο�	    ���� ���� ���� ���ڶ��	        ������	java002$	2022-08-22 10:19:41
*/

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����սô�', '�� ���� ������ �ʾƿ�', '������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO = 7;

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
2	��~ ����	������ ���� ����־��	        ���ҿ�	java002$	2022-08-22 10:18:51
3	����ʹ�	�����̰� �ʹ� ����;��	    ������	java002$	2022-08-22 10:18:54
4	����Ŀ�	��ħ�ε� ����Ŀ�	            ������	java002$	2022-08-22 10:19:37
5	�ʹ��־��	������ ���������� �ʹ� �־��	���¹�	java002$	2022-08-22 10:19:38
9	�����սô�	�� ���� ������ �ʾƿ�	        ������	java002$	2022-08-22 10:35:22
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խ����� �Խù� ����Ʈ ��ȸ
SELECT NO "�۹�ȣ", TITLE "����", NAME "�̸�", CREATED "�ۼ���"
FROM TBL_BOARD;
--==>>
/*
2	��~ ����	���ҿ�	2022-08-22 10:18:51
3	����ʹ�	������	2022-08-22 10:18:54
4	����Ŀ�	������	2022-08-22 10:19:37
5	�ʹ��־��	���¹�	2022-08-22 10:19:38
9	�����սô�	������	2022-08-22 10:35:22
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�̸�", CREATED "�ۼ���"
FROM TBL_BOARD;
--==>>
/*
1	��~ ����	���ҿ�	2022-08-22 10:18:51
2	����ʹ�	������	2022-08-22 10:18:54
3	����Ŀ�	������	2022-08-22 10:19:37
4	�ʹ��־��	���¹�	2022-08-22 10:19:38
5	�����սô�	������	2022-08-22 10:35:22
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�̸�", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	�����սô�	������	2022-08-22 10:35:22
4	�ʹ��־��	���¹�	2022-08-22 10:19:38
3	����Ŀ�	������	2022-08-22 10:19:37
2	����ʹ�	������	2022-08-22 10:18:54
1	��~ ����	���ҿ�	2022-08-22 10:18:51
*/


--------------------------------------------------------------------------------
--���� JOIN(����) ����--

-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP, DEPT;
-- ������ 56��
--> ���п��� ���ϴ� ��ī��Ʈ ��(CATERSIAN PRODUCT)
--  �� ���̺��� ������ ��� ����� ��
--  (�� ���� ���̺� ������ ���� ������ 14 * 4)

SELECT *
FROM EMP;
-- ������ 14��

SELECT *
FROM DEPT;
-- ������ 4��


--EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


-- NON EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ű�� ���� ���
SELECT *
FROM SALGRADE;

SELECT * 
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- EQUI JOIN �� (+) �� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14 ���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5) ��� ����
--  ����, �Ҽ� ����� ���� ���� �μ�(1) ��� ����

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  �Ҽ� ����� ���� ���� �μ�(1) ����-----------(+)
--  �μ���ȣ�� ���� ���� �����(5) ��� ��ȸ

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 15���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  �μ���ȣ�� ���� ���� �����(5) ����-----------(+)
--  �Ҽ� ����� ���� ���� �μ�(1) ��ȸ

--�� (+) �� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��             -- ����
--   (+) �� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·� -- �߰�(÷��)
--   JOIN �� �̷������

--   �̿� ���� ������....
SELECT *
FROM TBL_EMP E, TNL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- �̷� ������ JOIN�� �������� �ʴ´�


-- 2. SQL 1999 CODE     �� JOIN Ű���� ���� �� JOIN(����)�� ���� ���
--                      �� ON Ű���� ����   �� ���� ������ WHERE ��� ON                        

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN
SELECT*
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN ���� INNER �� ���� ����

-- OUTER JOIN
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO(+);

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- OUTER JOIN ���� OUTER �� ���� ����
SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO(+);

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

--------------------------------------------------------------------------------
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';
--> �̿� ���� ������� �������� �����ص�
--  ��ȸ ����� ��� ������ ������ ����

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';
--> ������ �̿� ���� �����Ͽ�
--  ��ȸ�ϴ� �� �����Ѵ�
--------------------------------------------------------------------------------
--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸� ��ȸ
SELECT *
FROM EMP;

SELECT *
FROM DEPT;
--==>> �� �� �����Ϳ��� �÷� �Ȱ��� �� ã��
-- �μ���ȣ, �μ���, �����, ������, �޿�
-- DEPTNO    DNAME   ENAME   JOB     SAL
-- E, D      D       E       E       E

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �߻�
--     ORA-00918: column ambiguously defined
--     �� ���̺� �� �ߺ��Ǵ� �÷��� ����
--     �Ҽ� ���̺��� �������(��������) �Ѵ�

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--�� �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� ������ �� �ֵ��� ó���ؾ� �Ѵ�
SELECT *
FROM EMP;       -- �ڽ� ���̺�

SELECT *
FROM DEPT;      -- �θ� ���̺�

SELECT D.DEPTNO "�μ���ȣ", D.DNAME "�μ���", E.ENAME "�����", E.JOB "������", E.SAL "�޿�"
FROM EMP E, DEPT D 
WHERE E.DEPTNO = D.DEPTNO;
-- �� ���̺� ��� ���ԵǾ� �ִ� �ߺ��� �÷��� �ƴϴ���
-- �÷��� �Ҽ� ���̺��� ����� �� �� �ֵ��� �����Ѵ�

SELECT D.DEPTNO "�μ���ȣ", D.DNAME "�μ���", E.ENAME "�����", E.JOB "������", E.SAL "�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'MANAGER' OR E.JOB = 'CLERK';


--------------------------------------------------------------------------------
--�� SELF JOIN(�ڱ� ����)

--EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�
--------------------------------------------------------------------------------
-- �����ȣ  �����  ������  �����ڹ�ȣ  �����ڸ�  ������������
--------------------------------------------------------------------------------
--  7369     SMITH   CLERK      7902      FORD       ANALYST
SELECT *
FROM EMP;

-- ��� 1
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E1.MGR "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO
ORDER BY E1.EMPNO;
--==>> �̷��� �����ڰ� ���� PRESIDENT �� ������

-- ��� 2
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E1.MGR "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO
ORDER BY E1.EMPNO;
--==>> �̷��� �����ڰ� ���� PRESIDENT �� ������


-- ��� 3
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E1.MGR "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;

-- ��� 4
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E1.MGR "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO
ORDER BY E1.EMPNO;
--==>> E1.MGR "�����ڹ�ȣ" = E2.EMPNO "�����ڹ�ȣ" �� �ص� ��
/*
7369	SMITH	CLERK	    7902	FORD	ANALYST
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7902	FORD	ANALYST	    7566	JONES	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
*/