SELECT USER
FROM DUAL;
--==>> HR

--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�
--   ��, �μ����� 'IT' �� �����鸸 �����Ѵ�
--   (���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�)
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE �μ���ȣ = �μ����� 'IT'�� �μ��� �μ���ȣ;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE �μ���ȣ = 60;

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
Alexander	9000	60
Bruce	    6000	60
David	    4800	60
Valli	    4800	60
Diana	    4200	60
*/

UPDATE EMPLOYEES
SET SALARY = SALARY �� 10% �λ�
WHERE �μ����� 'IT' �� ������;

UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
/*
Alexander	9900	60
Bruce	    6600	60
David	    5280	60
Valli	    5280	60
Diana	    4620	60
*/

-- SALARY 10% �λ� Ȯ�� �Ϸ� ������ �ѹ� ����
ROLLBACK;
--> �ѹ� �Ϸ�.


--�� EMPLOYEES ���̺��� JOB_TITLE �� Sales Manager �� �������
--   SALARY �� �ش� ����(����)�� �ְ�޿�(MAX_SALARY)�� �����Ѵ�
--   ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���� ������ �� �ֵ��� ó���Ѵ�
--   (���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�)
SELECT *
FROM EMPLOYEES;

SELECT *
FROM JOBS;

SELECT JOB_ID
FROM JOBS
WHERE JOB_TITLE = 'Sales Manager';

SELECT FIRST_NAME, JOB_ID, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--  AND HIRE_DATE < TO_DATE('2006', 'YYYY');
--==>>
/*
John	SA_MAN	14000	2004-10-01
Karen	SA_MAN	13500	2005-01-05
Alberto	SA_MAN	12000	2005-03-10

Gerald	SA_MAN	11000	2007-10-15
Eleni	SA_MAN	10500	2008-01-29
*/

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006; 
--  AND HIRE_DATE < TO_DATE('2006', 'YYYY');     
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT FIRST_NAME, JOB_ID, SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND TO_NUMBER(TO_CHAR(HIRE_DATE, 'YYYY')) < 2006;
--  AND HIRE_DATE < TO_DATE('2006', 'YYYY');
--==>>
/*
John	SA_MAN	20080	2004-10-01
Karen	SA_MAN	20080	2005-01-05
Alberto	SA_MAN	20080	2005-03-10
*/

-- �ְ�޿�(MAX_SALARY)�� ���� Ȯ�� �Ϸ� ������ �ѹ� ����
ROLLBACK;
--> �ѹ� �Ϸ�.


-- �� EMPLOYEES ���̺��� SALARY��
--    �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--    Finance �� 10% �λ�
--    Executive �� 15% �λ�
--    Accounting  �� 20% �λ�
--    (��Ʈ. �ٸ� ������ �μ��� �� SALARY)
--    ���濡 ���� ��� Ȯ�� �� ROLLBACK
SELECT * 
FROM EMPLOYEES;

SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting');
--==>>
/*
90	Executive
100	Finance
110	Accounting
*/

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting') );
--==>>
/*
Steven	    24000	90
Neena	    17000	90
Lex	        17000	90
Nancy	    12008	100
Daniel	    9000	100
John	    8200	100
Ismael	    7700	100
Jose Manuel	7800	100
Luis	    6900	100
Shelley	    12008	110
William	    8300	110
*/

UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN ('Finance'�� �μ� ���̵�)
                                THEN (SALARY * 1.1)
                                WHEN ('Executive'�� �μ� ���̵�)
                                THEN (SALARY * 1.15)
                                WHEN ('Accounting'�� �μ� ���̵�)
                                THEN (SALARY * 1.2)
                                ELSE SALARY
             END;
             


UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Finance')
                                THEN (SALARY * 1.1)
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Executive')
                                THEN (SALARY * 1.15)
                                WHEN (SELECT DEPARTMENT_ID
                                      FROM DEPARTMENTS
                                      WHERE DEPARTMENT_NAME = 'Accounting')
                                THEN (SALARY * 1.2)
                                ELSE SALARY
             END
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting') );
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
-- ������ ������Ʈ���� ���Ѵٸ� ������ WHERE ���� �ʿ䰡 ����
-- �̹� CASE������ ������Ʈ�� ����� ����
-- �ٸ� ������ WHERE ���� ������ 11�� ������ Ȯ���� ������Ʈ ������
-- ������ 107���� ��� Ȯ���� 11���� ã�� ������Ʈ�� �ϱ� ������
-- ��� ó�� �ӵ��� �ٸ���.

-- Ȯ��
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting') );
--==>>
/*
Steven	    27600	90
Neena	    19550	90
Lex	        19550	90
Nancy	    13208.8	100
Daniel	    9900	100
John	    9020	100
Ismael	    8470	100
Jose Manuel	8580	100
Luis	    7590	100
Shelley	    14409.6	110
William	    9960	110
*/

-- �� �μ��� �̸����� �ٸ� �λ���� ���� Ȯ�� �Ϸ� ������ �ѹ� ����
ROLLBACK;
--> �ѹ� �Ϸ�.


--------------------------------------------------------------------------------

--���� DELETE ����--
-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴ� �� ����ϴ� ����

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];

-- ���̺� ����(������ ����)

CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;

DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
-- �ٷ� �����ϴ� ���� �ƴ϶�, 
-- �����ϰ��� �ϴ� �����Ͱ� �´��� ���� Ȯ�� �� ������ ��

ROLLBACK;


--�� TBL_EMPLOYEES ���̺��� �������� �����͸� �����Ѵ�
--   ��, �μ����� 'IT' �� ���� �����Ѵ�
--�� �����δ� TBL_EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ��� ������)
--   �ٸ� ���ڵ忡 ���� �������ϰ� �ִ� ���(��򰡿� �ڽ� ���̺��� �ִ� ���)
--   �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�
--   �׿� ���� ������ �˾ƾ� �Ѵ�

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ('IT' �μ��� �μ� ���̵�);

-- ('IT' �μ��� �μ� ���̵�)
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60	IT

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	Ernst	BERNST	590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	Austin	DAUSTIN	590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	Lorentz	DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
-- ��������� �����־� ���� �Ұ���


--------------------------------------------------------------------------------

--���� ��(VIEW) ����--

-- 1. ��(VIEW) �� �̹� Ư���� �����ͺ��̽� ���� �����ϴ� 
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
--    ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸 ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

--    ������ ���̺��̶�.. �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--    �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̸�
--    �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- 2. ���� �� ����
--    CREATE [OR REPLACE ] VIEW ���̸�
--    [(ALIAS[, ALIAS, ....])]
--    AS
--    ��������(SUBQUERY)
--    [WITH CHECK OPTION]
--    [WITH READ ONLY];

-- �� �� (VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.


--�� ��(VIEW) ��ȸ
SELECT * 
FROM VIEW_EMPLOYEES;
--==>> �並 ����ϸ� �̷��� �����ϰ� �������� �ۼ��� �� �ִ�


--�� ��(VIEW)�� ���� ��ȸ
DESC VIEW_EMPLOYEES;
--==>>
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


--�� ��(VIEW) �ҽ� Ȯ�� -- CHECK~!!!
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>>
/*
VIEW_EMPLOYEES	
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID"
*/