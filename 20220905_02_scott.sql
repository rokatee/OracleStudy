SELECT USER
FROM DUAL;
--==>> SCOTT

--���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ����--
-- �� DML �۾��� ���� �̺�Ʈ ���

--�� �ǽ� ���̺� ���� (TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.

--�� �ǽ����̺� ����(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

SELECT *
FROM TBL_EVENTLOG;
--==>> ��ȸ ��� ����


--�� ������ TRIGGER �۵����� Ȯ��
--   �� TBL_TEST1 ���̺��� ������� INSERT, UPDATE, DELETE ����
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '������', '010-1111-1111');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '�δ�����'
WHERE ID = 1;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '�ֳ���', '010-2222-2222');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '�ִ�����'
WHERE ID = 2;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '��������', '010-3333-3333');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '�������', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '��������', '010-5555-5555');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(6, '��������', '010-6666-6666');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(7, '�ڴ�����', '010-7777-7777');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;

DELETE
FROM TBL_TEST1;
--==>> 7�� �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� ����

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:08:03
UPDATE �������� ����Ǿ����ϴ�.	2022-09-05 10:09:38
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:11:08
UPDATE �������� ����Ǿ����ϴ�.	2022-09-05 10:11:11
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:11:57
UPDATE �������� ����Ǿ����ϴ�.	2022-09-05 10:11:59
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:14:12
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:14:12
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:14:12
INSERT �������� ����Ǿ����ϴ�.	2022-09-05 10:14:12
DELETE �������� ����Ǿ����ϴ�. 2022-09-05 10:14:47
*/


INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(8, '�躸��', '010-8888-8888');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_TEST1
SET NAME = '�������'
WHERE ID = 8;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

DELETE
FROM TBL_TEST1
WHERE ID = 8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� �ð��� ���� (�� ���� 7�� 40��) 
-- �� ����Ŭ������ �ִ� ��ǻ���� �ð��� �ٲ���Ѵ�
--    (������ �п��� ������ �̿��ϹǷ� �п����� �ð��� �ٲ����)
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(9, '����', '010-8888-8888');
--==>> ORA-20003: �۾��� 8:00 ~ 18:00 ������ �����մϴ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;



-- ���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ����
-- �� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

--�� �ǽ��� ���� ���̺� ����(TBL_TEST2)
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
,CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

--�� �ǽ��� ���� ���̺� ����(TBL_TEST3)
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
,CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
,CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
            REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���� ������ �Է�
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '�ڷ�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '��Ź��');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '������');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�ڷ�����
2	�����
3	��Ź��
4	������
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �ǽ� ���� ������ �Է�
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(13, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(14, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(15, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(16, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(17, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(18, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(19, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(20, 4, 20);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 20

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
2	2	20
3	3	30
4	4	20
5	1	30
6	2	20
7	3	30
8	4	20
9	1	30
10	2	20
11	3	30
12	4	20
13	1	30
14	2	20
15	3	30
16	4	20
17	1	30
18	2	20
19	3	30
20	4	20
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT *
FROM TBL_TEST2;
SELECT *
FROM TBL_TEST3;

--�� TBL_TEST2(�θ�) ���̺��� ������ ���� �õ�
DELETE
FROM TBL_TEST2
WHERE CODE = 4;
--> ������ ���� �õ�
--==>> ���� �߻�
--     ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found

--�� Ʈ���� ���� ���� TBL_TEST2(�θ�) ���̺��� ������ ���� �õ�
DELETE
FROM TBL_TEST2
WHERE CODE = 4;
--> ������ ���� �õ�
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�ڷ�����
2	�����
3	��Ź��
*/

SELECT *
FROM TBL_TEST3;
--==>> CODE 4���� �����ϴ� �����Ͱ� ��� ���� ��
/*
1	1	30
2	2	20
3	3	30
5	1	30
6	2	20
7	3	30
9	1	30
10	2	20
11	3	30
13	1	30
14	2	20
15	3	30
17	1	30
18	2	20
19	3	30
*/

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--> ��Ź�� ���� �õ�
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--> ����� ���� �õ�
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST3;
--==>> CODE 2, 3���� �����ϴ� �����Ͱ� ��� ���� ��
/*
1	1	30
5	1	30
9	1	30
13	1	30
17	1	30
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST2;
--==>> 1	�ڷ�����


SELECT * 
FROM TBL_��ǰ;
--==>>
/*
C001	������	    1500	30
C002	������	    1500	30
C003	�����	1300	0
C004	������	    1800	0
C005	������	    1900	0
H001	��ũ����	1000	0
H002	ĵ���	     300	100
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

SELECT *
FROM TBL_�԰�
ORDER BY �԰��ȣ;
--==>>
/*
1	C001	2022-09-02 00:00:00	30	1200
2	C002	2022-09-02 00:00:00	30	1200
3	H001	2022-09-02 00:00:00	50	800
4	H002	2022-09-02 00:00:00	50	200
5	H001	2022-09-02 00:00:00	50	800
6	H002	2022-09-02 00:00:00	50	200
*/

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
VALUES(7, 'C003', 70, 2000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. (�����)

SELECT * 
FROM TBL_��ǰ;
--==>> C003	�����	1300	70 (������ 70��)

SELECT *
FROM TBL_�԰�
ORDER BY �԰��ȣ;
--==>>
/*
1	C001	2022-09-02 00:00:00	30	1200
2	C002	2022-09-02 00:00:00	30	1200
3	H001	2022-09-02 00:00:00	50	800
4	H002	2022-09-02 00:00:00	50	200
5	H001	2022-09-02 00:00:00	50	800
6	H002	2022-09-02 00:00:00	50	200
7	C003	2022-09-05 11:45:58	70	2000
*/


--�� ��Ű�� Ȱ�� �ǽ�
-- ������ �Լ� ȣ�� �� ��Ű����.�Լ���()
SELECT INSA_PACK.FN_GENDER('751212-1234567') "�Լ�ȣ����"
FROM DUAL;
--==>> ����

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN) "�Լ�ȣ����"
FROM TBL_INSA;
--==>>
/*
������	970124-2234567	����
ȫ�浿	771212-1022432	����
�̼���	801007-1544236	����
�̼���	770922-2312547	����
������	790304-1788896	����
�Ѽ���	811112-1566789	����
�̱���	780505-2978541	����
����ö	780506-1625148	����
�迵��	821011-2362514	����
������	810810-1552147	����
������	751010-1122233	����
������	801010-2987897	����
���ѱ�	760909-1333333	����
���̼�	790102-2777777	����
Ȳ����	810707-2574812	����
������	800606-2954687	����
�̻���	781010-1666678	����
�����	820507-1452365	����
�̼���	801028-1849534	����
�ڹ���	780710-1985632	����
������	800304-2741258	����
ȫ�泲	801010-1111111	����
�̿���	800501-2312456	����
���μ�	731211-1214576	����
�踻��	830225-2633334	����
�����	801103-1654442	����
�����	810907-2015457	����
�迵��	801216-1898752	����
�̳���	810101-1010101	����
�踻��	800301-2020202	����
������	790210-2101010	����
����ȯ	771115-1687988	����
�ɽ���	810206-2222222	����
��̳�	780505-2999999	����
������	820505-1325468	����
������	831010-2153252	����
���翵	701126-2852147	����
�ּ���	770129-1456987	����
���μ�	791009-2321456	����
�����	800504-2000032	����
�ڼ���	790509-1635214	����
�����	721217-1951357	����
ä����	810709-2000054	����
��̿�	830504-2471523	����
����ȯ	820305-1475286	����
ȫ����	690906-1985214	����
����	760105-1458752	����
�긶��	780505-1234567	����
�̱��	790604-1415141	����
�̹̼�	830908-2456548	����
�̹���	810403-2828287	����
�ǿ���	790303-2155554	����
�ǿ���	820406-2000456	����
��̽�	800715-1313131	����
����ȣ	810705-1212141	����
���ѳ�	820506-2425153	����
������	800605-1456987	����
�̹̰�	780406-2003214	����
�����	800709-1321456	����
�Ӽ���	810809-2121244	����
��ž�	810809-2111111	����
*/



















