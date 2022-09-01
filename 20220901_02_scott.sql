SELECT USER
FROM DUAL;
--==>> SCOTT

-- ���ν��� ���� �ǽ� ����

-- �ǽ� ���̺� ����
CREATE TABLE TBL_STUDENTS
( ID     VARCHAR2(10)
, NAME   VARCHAR2(40)
, TEL    VARCHAR2(20)
, ADDR   VARCHAR2(100)
);
--==>> Table TBL_STUDENTS��(��) �����Ǿ����ϴ�.

-- �ǽ� ���̺� ����(TBL_IDPW)
CREATE TABLE TBL_IDPW
( ID     VARCHAR2(10)
, PW     VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>>Table TBL_IDPW��(��) �����Ǿ����ϴ�.

-- �� ���̺� ������ �Է�
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '�ֵ���', '010-1111-1111', '���ֵ� ��������');
INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java002$');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

-- Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>> superman	�ֵ���	010-1111-1111	���ֵ� ��������

SELECT *
FROM TBL_IDPW;
--==>> superman	java002$

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- ���� ������ �����ϴ� ���ν���(INSERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
-- EXECUTE PRC_STUDENTS_INSERT('batman', 'java002$', '���¹�', '010-2222-2222', '���� ������');
-- EXEC PRC_STUDENTS_INSERT('batman', 'java002$', '���¹�', '010-2222-2222', '���� ������');    --EXECUTE�� EXEC�� �ٿ��� �ȴ�
-- �̿� ���� ���� �� �ٷ� ���� ���̺� ��� ����� �Է��� �� �ִ�.


--�� ���ν��� ���� ������
--   20220901_01_scott(plsql).sql ���� ����~!!!


--�� PRC_STUDENTS_INSERT ���ν��� ȣ���� ���� Ȯ��
EXEC PRC_STUDENTS_INSERT('batman', 'java002$', '���¹�', '010-2222-2222', '���� ������');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� PRC_STUDENTS_INSERT ���ν��� ȣ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	�ֵ���	010-1111-1111	���ֵ� ��������
batman	    ���¹�	010-2222-2222	���� ������
*/

SELECT *
FROM TBL_IDPW;
--==>>
/*
superman	java002$
batman	    java002$
*/


--�� �ǽ� ���̺� ����(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
(
  HAKBUN    NUMBER          -- ������ ��, �й��� NUMBER �ڷ����� ���� �ȵȴ�
, NAME      VARCHAR2(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK��(��) �����Ǿ����ϴ�.


--�� ������ ���̺� �÷� �߰�
--   (���� �� TOT, ��� �� AVG, ��� �� GRADE)
ALTER TABLE TBL_SUNGJUK
ADD (TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR);
--==>> Table TBL_SUNGJUK��(��) ����Ǿ����ϴ�.

-- �� ���⼭ �߰��� �÷��� ���� �׸���� ���ν��� �ǽ��� ���� �߰��ϴ� ���� ��
--    ���� ���̺� ������ �������� �ʴ�.
--    (��, ��, �� ������ ���, ���, ���� �� �� �� �ִ� ���̱� ������)
--    (EX. ��+��+�� = ����)


--�� ����� ���̺� ���� Ȯ��
DESC TBL_SUNGJUK;
--==>>
/*
�̸�     ��?       ����           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)  
*/


--�� PRC_SUNGJUK_INSERT ���ν��� ȣ�� �� ������ ��ȸ
SELECT *
FROM TBL_SUNGJUK;
--==>> ��ȸ ��� ����

--�� PRC_SUNGJUK_INSERT ���ν��� ȣ���� ���� Ȯ��
EXEC PRC_SUNGJUK_INSERT(1, '���ҿ�', 90, 80, 70);
EXEC PRC_SUNGJUK_INSERT(2, '���̰�', 80, 70, 60);
EXEC PRC_SUNGJUK_INSERT(3, '�ӽÿ�', 82, 71, 60);
EXEC PRC_SUNGJUK_INSERT(4, '������', 54, 63, 72);
EXEC PRC_SUNGJUK_INSERT(5, '������', 44, 33, 22);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� PRC_SUNGJUK_INSERT ���ν��� ȣ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_SUNGJUK;
--==>> 
/*
1	���ҿ�	90	80	70	240	80	C
2	���̰�	80	70	60	210	70	C
3	�ӽÿ�	82	71	60	213	71	C
4	������	54	63	72	189	63	D
5	������	44	33	22	99	33	F
*/


--�� PRC_SUNGJUK_UPDATE ���ν��� ȣ���� ���� Ȯ��
EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);
EXEC PRC_SUNGJUK_UPDATE(5, 100, 99, 98);

--�� PRC_SUNGJUK_UPDATE ���ν��� ȣ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	���ҿ�	50	50	50	150	50	F
2	���̰�	80	70	60	210	70	C
3	�ӽÿ�	82	71	60	213	71	C
4	������	54	63	72	189	63	D
5	������	100	99	98	297	99	A
*/




--�� PRC_STUDENTS_UPDATE ���ν��� ȣ�� �� ������ ��ȸ
SELECT *
FROM TBL_STUDENTS;
--==>> 
/*
superman	�ֵ���	010-1111-1111	���ֵ� ��������
batman	    ���¹�	010-2222-2222	���� ������
*/

--�� PRC_STUDENTS_UPDATE ���ν��� ȣ���� ���� Ȯ��
-- ����� �ٸ� ���
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '������ Ⱦ��');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--> ������ ����� �ٸ��Ƿ�, ������ ������ �̷����� �ʴ´�

-- ����� ���� ���
EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '������ Ⱦ��');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� PRC_STUDENTS_UPDATE ���ν��� ȣ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>> 
/*
superman	�ֵ���	010-9876-5432	������ Ⱦ��
batman	    ���¹�	010-2222-2222	���� ������
*/


SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 2;
--==>> ��ȸ ��� ����

SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 1;
--==>> ��ȸ ��� ����


SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
ON T1.ID = T2.ID;
--==>>
/*
superman	java002$	010-9876-5432	������ Ⱦ��
batman	    java002$	010-9876-5432	������ Ⱦ��
*/



--�� PRC_INSA_INSERT ���ν����� ����� ���� NUM �ִ밪 üũ
--   (�ִ밪 ���� ���ڸ� �ڵ����� �ο��� ������ �߰��ϱ� ����)
SELECT *
FROM TBL_INSA;
-- ��ȸ��� NUM �ִ밪 : 1060

--�� PRC_INSA_INSERT ���ν��� ȣ�� �� ������ ��ȸ
SELECT *
FROM TBL_INSA;
--==>> 
/*
���� ������ ����
*/

--�� PRC_INSA_INSERT ���ν��� ȣ���� ���� Ȯ��
EXEC PRC_INSA_INSERT('������', '970124-2234567', SYSDATE, '����', '010-7202-6306', '���ߺ�', '�븮', 2000000, 2000000);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� PRC_INSA_INSERT ���ν��� ȣ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_INSA;
--==>> 
/*
��1061	������	970124-2234567	2022-09-01	����	010-7202-6306	���ߺ�	�븮	2000000	2000000��
���� �ο��� ��� ��ȣ ������ ��ȣ�� �� ���� ��ȣ�� �� �����Ͱ� �߰��� ���� Ȯ���� �� ����
*/




--�� �ǽ� ���̺� ����(TBL_��ǰ)
CREATE TABLE TBL_��ǰ
( ��ǰ�ڵ�       VARCHAR2(20)
, ��ǰ��         VARCHAR2(100)
, �Һ��ڰ���     NUMBER
, ������       NUMBER DEFAULT 0
, CONSTRAINT ��ǰ_��ǰ�ڵ�_PK PRIMARY KEY(��ǰ�ڵ�)
);
--==>> Table TBL_��ǰ��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� ����(TBL_�԰�)
CREATE TABLE TBL_�԰�
( �԰��ȣ  NUMBER
, ��ǰ�ڵ�  VARCHAR2(20)
, �԰�����  DATE DEFAULT SYSDATE
, �԰����  NUMBER
, �԰�ܰ�  NUMBER
, CONSTRAINT �԰�_�԰��ȣ_PK PRIMARY KEY(�԰��ȣ)
, CONSTRAINT �԰�_��ǰ�ڵ�_FK FOREIGN KEY(��ǰ�ڵ�) 
                REFERENCES TBL_��ǰ(��ǰ�ڵ�)
);
--==>> Table TBL_�԰���(��) �����Ǿ����ϴ�.


--�� TBL_��ǰ ���̺� ��ǰ ������ �Է�
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C001', '������', 1500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C002', '������', 1500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C003', '�����', 1300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C004', '������', 1800);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C005', '������', 1900);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 5

INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H001', '��ũ����', 1000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H002', 'ĵ���', 300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H003', '�ֹֽ�', 500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H004', '������', 600);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H005', '�޷γ�', 500);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 5

INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E001', '�������̽�', 2500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E002', '�ؾ�θ���', 2000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E003', '���Ǿ�', 2300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E004', '�źϾ�', 2300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E005', '��Ű��', 2400);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E006', '��ȭ��', 2000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E007', '���Դ�', 3000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E008', '������Ʈ', 3000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E009', '������', 3000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 9

--�� Ȯ��
SELECT *
FROM TBL_��ǰ;
--==>>
/*
C001	������	    1500	0
C002	������	    1500	0
C003	�����	1300	0
C004	������	    1800	0
C005	������	    1900	0
H001	��ũ����	1000	0
H002	ĵ���	     300	0
H003	�ֹֽ�	     500	0
H004	������	     600	0
H005	�޷γ�	     500	0
E001	�������̽�	2500	0
E002	�ؾ�θ���	2000	0
E003	���Ǿ�	    2300	0
E004	�źϾ�	    2300	0
E005	��Ű��	    2400	0
E006	��ȭ��	    2000	0
E007	���Դ�	    3000	0
E008	������Ʈ	3000	0
E009	������	    3000	0
*/

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.
