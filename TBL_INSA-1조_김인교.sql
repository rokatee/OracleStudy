SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ���� ���̺� ����
--DROP TABLE TBL_INSA;


--�� �ٽ� ���̺� ���� (SCOTT.TBL_INSA)
CREATE TABLE TBL_INSA
( NUM      NUMBER(5)    NOT NULL
, NAME     VARCHAR2(20) NOT NULL
, SSN      VARCHAR2(14) NOT NULL
, IBSADATE DATE         NOT NULL
, CITY     VARCHAR2(10)
, TEL      VARCHAR2(15)
, BUSEO    VARCHAR2(15) NOT NULL
, JIKWI    VARCHAR2(15) NOT NULL
, BASICPAY NUMBER(10)   NOT NULL
, SUDANG   NUMBER(10)   NOT NULL
, CONSTRAINT TBL_INSA_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_INSA��(��) �����Ǿ����ϴ�.


--�� ���� �⺻�� ����
ALTER SESSION SET NLS_DATE_FORMAT ='YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ������ �Է�
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1001, 'ȫ�浿', '771212-1022432', '1998-10-11', '����', '011-2356-4528', '��ȹ��', '����', 2610000, 200000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1002, '�̼���', '801007-1544236', '2000-11-29', '���', '010-4758-6532', '�ѹ���', '���', 1320000, 200000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1003, '�̼���', '770922-2312547', '1999-02-25', '��õ', '010-4231-1236', '���ߺ�', '����', 2550000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1004, '������', '790304-1788896', '2000-10-01', '����', '019-5236-4221', '������', '�븮', 1954200, 170000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1005, '�Ѽ���', '811112-1566789', '2004-08-13', '����', '018-5211-3542', '�ѹ���', '���', 1420000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1006, '�̱���', '780505-2978541', '2002-02-11', '��õ', '010-3214-5357', '���ߺ�', '����', 2265000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1007, '����ö', '780506-1625148', '1998-03-16', '����', '011-2345-2525', '���ߺ�', '�븮', 1250000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1008, '�迵��', '821011-2362514', '2002-04-30', '����', '016-2222-4444', 'ȫ����', '���', 950000 , 145000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1009, '������', '810810-1552147', '2003-10-10', '���', '019-1111-2222', '�λ��', '���', 840000 , 220400);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1010, '������', '751010-1122233', '1997-08-08', '�λ�', '011-3214-5555', '������', '����', 2540000, 130000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1011, '������', '801010-2987897', '2000-07-07', '����', '010-8888-4422', '������', '���', 1020000, 140000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1012, '���ѱ�', '760909-1333333', '1999-10-16', '����', '018-2222-4242', 'ȫ����', '���', 880000 , 114000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1013, '���̼�', '790102-2777777', '1998-06-07', '���', '019-6666-4444', 'ȫ����', '�븮', 1601000, 103000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1014, 'Ȳ����', '810707-2574812', '2002-02-15', '��õ', '010-3214-5467', '���ߺ�', '���', 1100000, 130000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1015, '������', '800606-2954687', '1999-07-26', '���', '016-2548-3365', '�ѹ���', '���', 1050000, 104000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1016, '�̻���', '781010-1666678', '2001-11-29', '���', '010-4526-1234', '���ߺ�', '����', 2350000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1017, '�����', '820507-1452365', '2000-08-28', '��õ', '010-3254-2542', '���ߺ�', '���', 950000 , 210000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1018, '�̼���', '801028-1849534', '2004-08-08', '����', '018-1333-3333', '���ߺ�', '���', 880000 , 123000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1019, '�ڹ���', '780710-1985632', '1999-12-10', '����', '017-4747-4848', '�λ��', '����', 2300000, 165000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1020, '������', '800304-2741258', '2003-10-10', '����', '011-9595-8585', '�����', '���', 880000 , 140000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1021, 'ȫ�泲', '801010-1111111', '2001-09-07', '���', '011-9999-7575', '���ߺ�', '���', 875000 , 120000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1022, '�̿���', '800501-2312456', '2003-02-25', '����', '017-5214-5282', '��ȹ��', '�븮', 1960000, 180000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1023, '���μ�', '731211-1214576', '1995-02-23', '����', NULL           , '������', '����', 2500000, 170000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1024, '�踻��', '830225-2633334', '1999-08-28', '����', '011-5248-7789', '��ȹ��', '�븮', 1900000, 170000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1025, '�����', '801103-1654442', '2000-10-01', '����', '010-4563-2587', '������', '���', 1100000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1026, '�����', '810907-2015457', '2002-08-28', '���', '010-2112-5225', '������', '���', 1050000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1027, '�迵��', '801216-1898752', '2000-10-18', '����', '019-8523-1478', '�ѹ���', '����', 2340000, 170000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1028, '�̳���', '810101-1010101', '2001-09-07', '����', '016-1818-4848', '�λ��', '���', 892000 , 110000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1029, '�踻��', '800301-2020202', '2000-09-08', '����', '016-3535-3636', '�ѹ���', '���', 920000 , 124000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1030, '������', '790210-2101010', '1999-10-17', '�λ�', '019-6564-6752', '�ѹ���', '����', 2304000, 124000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1031, '����ȯ', '771115-1687988', '2001-01-21', '����', '019-5552-7511', '��ȹ��', '����', 2450000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1032, '�ɽ���', '810206-2222222', '2000-05-05', '����', '016-8888-7474', '�����', '���', 880000 , 108000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1033, '��̳�', '780505-2999999', '1998-06-07', '����', '011-2444-4444', '������', '���', 1020000, 104000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1034, '������', '820505-1325468', '2005-09-26', '���', '011-3697-7412', '��ȹ��', '���', 1100000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1035, '������', '831010-2153252', '2002-05-16', '��õ', NULL           , '���ߺ�', '���', 1050000, 140000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1036, '���翵', '701126-2852147', '2003-08-10', '����', '011-9999-9999', '�����', '���', 960400 , 190000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1037, '�ּ���', '770129-1456987', '1998-10-15', '��õ', '011-7777-7777', 'ȫ����', '����', 2350000, 187000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1038, '���μ�', '791009-2321456', '1999-11-15', '�λ�', '010-6542-7412', '������', '�븮', 2000000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1039, '�����', '800504-2000032', '2003-12-28', '���', '010-2587-7895', '������', '�븮', 2010000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1040, '�ڼ���', '790509-1635214', '2000-09-10', '���', '016-4444-7777', '�λ��', '�븮', 2100000, 130000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1041, '�����', '721217-1951357', '2001-12-10', '�泲', '016-4444-5555', '�����', '����', 2300000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1042, 'ä����', '810709-2000054', '2003-10-17', '���', '011-5125-5511', '���ߺ�', '���', 1020000, 200000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1043, '��̿�', '830504-2471523', '2003-09-24', '����', '016-8548-6547', '������', '���', 1100000, 210000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1044, '����ȯ', '820305-1475286', '2004-01-21', '����', '011-5555-7548', '������', '���', 1060000, 220000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1045, 'ȫ����', '690906-1985214', '2003-03-16', '����', '011-7777-7777', '������', '���', 960000 , 152000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1046, '����', '760105-1458752', '1999-05-04', '�泲', '017-3333-3333', '�ѹ���', '����', 2650000, 150000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1047, '�긶��', '780505-1234567', '2001-07-15', '����', '018-0505-0505', '������', '�븮', 2100000, 112000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1048, '�̱��', '790604-1415141', '2001-06-07', '����', NULL           , '���ߺ�', '�븮', 2050000, 106000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1049, '�̹̼�', '830908-2456548', '2000-04-07', '��õ', '010-6654-8854', '���ߺ�', '���', 1300000, 130000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1050, '�̹���', '810403-2828287', '2003-06-07', '���', '011-8585-5252', 'ȫ����', '�븮', 1950000, 103000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1051, '�ǿ���', '790303-2155554', '2000-06-04', '����', '011-5555-7548', '������', '����', 2260000, 104000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1052, '�ǿ���', '820406-2000456', '2000-10-10', '���', '010-3644-5577', '��ȹ��', '���', 1020000, 105000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1053, '��̽�', '800715-1313131', '1999-12-12', '����', '011-7585-7474', '�����', '���', 960000 , 108000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1054, '����ȣ', '810705-1212141', '1999-10-16', '����', '016-1919-4242', 'ȫ����', '���', 980000 , 114000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1055, '���ѳ�', '820506-2425153', '2004-06-07', '����', '016-2424-4242', '������', '���', 1000000, 104000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1056, '������', '800605-1456987', '2004-08-13', '��õ', '010-7549-8654', '������', '�븮', 1950000, 200000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1057, '�̹̰�', '780406-2003214', '1998-02-11', '���', '016-6542-7546', '�����', '����', 2520000, 160000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1058, '�����', '800709-1321456', '2003-08-08', '��õ', '010-2415-5444', '��ȹ��', '�븮', 1950000, 180000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1059, '�Ӽ���', '810809-2121244', '2001-10-10', '����', '011-4151-4154', '���ߺ�', '���', 890000 , 102000);
--INSERT INTO TBL_INSA (NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--VALUES (1060, '��ž�', '810809-2111111', '2001-10-10', '����', '011-4151-4444', '���ߺ�', '���', 900000 , 102000);
--==>> 60 �� ��(��) ���ԵǾ����ϴ�.

--�� Ŀ��
--COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT *
FROM TBL_INSA;
 

------------------------------------------------------------------------------------------------------------
--1��_���α�

--01. TBL_INSA ���̺� ��ü�ڷ� ��ȸ
SELECT *
FROM TBL_INSA;

--02. SCOTT ����� ���� ���̺� ��� Ȯ��(2���� ���� Ȱ��)
SELECT *
FROM TAB;

SELECT * 
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES
WHERE OWNER = 'SCOTT';

--03. TBL_INSA ���̺� ���� Ȯ��
DESC TBL_INSA;

--04. TBL_INSA ���̺��� �̸�(NAME), �⺻��(BASICPAY) ��ȸ
SELECT NAME "�̸�", BASICPAY "�⺻��"
FROM TBL_INSA;

--05. TBL_INSA ���̺��� �̸�(NAME), �⺻��(BASICPAY), ����(SUDANG), �⺻��+���� ��ȸ
SELECT NAME "�̸�", BASICPAY "�⺻��", SUDANG "����"
     , BASICPAY + SUDANG "�⺻��+����"
FROM TBL_INSA;

--06. TBL_INSA ���̺��� �̸�(NAME), ��ŵ�(CITY), �μ���(BUSEO) ��ȸ. ��Ī(ALIAS) ���.
SELECT NAME "�̸�", CITY "��ŵ�", BUSEO "�μ���"
FROM TBL_INSA;

--07. ���� ����� �̸�(NAME), ��ŵ�(CITY), �μ���(BUSEO), ����(JIKWI) ��ȸ
SELECT NAME "�̸�", CITY "��ŵ�", BUSEO "�μ���", JIKWI "����"
FROM TBL_INSA
WHERE CITY = '����';

--08. ��ŵ��� ���� ����̸鼭       --> WHERE ����
--    �⺻���� 150���� �̻��� ���   --> WHERE ����
--    ��ȸ (NAME, CITY, BASICPAY, SSN)
SELECT NAME "�̸�", CITY "��ŵ�", BASICPAY "�⺻��", SSN "�ֹι�ȣ"
FROM TBL_INSA
WHERE CITY = '����'
  AND BASICPAY >= 1500000;

--09. ��ŵ��� '��õ' �̸鼭, �⺻���� 100�����̻� ~ 200���� �̸��� ��츸 ������� ��ȸ.
SELECT *
FROM TBL_INSA
WHERE CITY = '��õ'
  AND BASICPAY >= 1000000
  AND BASICPAY <= 2000000;
  
--10. ��ŵ��� ���� ����̰ų� �μ��� ���ߺ��� �ڷ� ��ȸ (NAME, CITY, BUSEO)
SELECT NAME "�̸�", CITY "��ŵ�", BUSEO "�μ�"
FROM TBL_INSA
WHERE CITY = '����'
   OR BUSEO = '���ߺ�';
   
--11. ��ŵ��� ����, ����� ����� ��ȸ (NAME, CITY, BUSEO). IN ������ ���.
SELECT NAME "�̸�", CITY "��ŵ�", BUSEO "�μ�"
FROM TBL_INSA
WHERE CITY IN ('����', '���');

--12. �μ��� '���ߺ�' �̰ų� '������'�� ����� ������� ��ȸ. IN ������ ���.
SELECT *
FROM TBL_INSA
WHERE BUSEO IN ('���ߺ�', '������');
   
--13. �޿�(BASICPAY + SUDANG)�� 250���� �̻��� ��� ��ȸ. --> WHERE ����
--    ��, �ʵ���� �ѱ۷� ���. --> ��Ī(ALIAS)
--    (NAME, BASICPAY, SUDANG, BASICPAY+SUDANG)
SELECT NAME "�̸�", BASICPAY "�⺻��", SUDANG "����", BASICPAY+SUDANG "�޿�"
FROM TBL_INSA
WHERE BASICPAY+SUDANG >= 2500000;
  
--14. �ֹι�ȣ�� �������� ����(���� �ڸ����� 1, 3)�� ��ȸ. 
--    ( �̸�(NAME), �ֹι�ȣ(SSN) )
--    ��, SUBSTR() �Լ� �̿�.
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
FROM TBL_INSA
WHERE SUBSTR(SSN, 8, 1) IN ('1', '3');

--15. �ֹι�ȣ�� �������� 80��� �¾ ����� ��ȸ. 
--    ( �̸�(NAME), �ֹι�ȣ(SSN) )
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
FROM TBL_INSA
WHERE SUBSTR(SSN, 1, 1) = '8';

--16. ���� ��� �߿��� 70��� �¾ ����� ��ȸ.
SELECT NAME "�̸�", CITY "��ŵ�", SSN "�ֹι�ȣ"
FROM TBL_INSA
WHERE CITY = '����'
  AND SUBSTR(SSN, 1, 1) = '7';
  
--17. ���� ��� �߿��� 70��� �¾ ���ڸ� ��ȸ.
SELECT NAME "�̸�", CITY "��ŵ�", SSN "�ֹι�ȣ"
FROM TBL_INSA
WHERE CITY = '����'
  AND SUBSTR(SSN, 1, 1) = '7'
  AND SUBSTR(SSN, 8, 1) IN ('1', '3');
  
--18. ���� ����̸鼭 �达�� ��ȸ
--    ��, ������ �� ���ڶ�� ����. 
--    ( �̸�, ��ŵ� )
--    SUBSTR() �Լ� �̿�.
SELECT NAME "�̸�", CITY "��ŵ�"
FROM TBL_INSA
WHERE CITY = '����'
  AND SUBSTR(NAME, 1, 1) = '��';

--19. 2000�⵵�� �Ի��� ��� ��ȸ. (�̸�, ��ŵ�, �Ի���).
SELECT NAME "�̸�", CITY "��ŵ�", IBSADATE "�Ի���"
FROM TBL_INSA
WHERE TO_NUMBER(TO_CHAR(IBSADATE, 'YYYY')) = 2000;

--20. 2000�� 10���� �Ի��� ��� ��ȸ. (�̸�, ��ŵ�, �Ի���).
SELECT NAME "�̸�", CITY "��ŵ�", IBSADATE "�Ի���"
FROM TBL_INSA
WHERE IBSADATE = TO_DATE('2000-10', 'YYYY-MM');

--21. �ֹι�ȣ�� �������� ������ ���� ��ȸ.
--    ��, ��� ������ 1900��뿡 �¾�ٴ� ����. (�̸�, �ֹι�ȣ, ����)
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
     -- ���� ���� = ����⵵ - (�ֹι�ȣ �� ���ڸ� + 1899)     
     ,EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(SSN, 1, 2) + 1899) ) "����"
FROM TBL_INSA;

--22. �ֹι�ȣ �������� ���� ���̴밡 20���� ����� ��ȸ.
--    (�����Ϳ� 20�밡 ��� ���Ƿ� 50���� ����� ��ȸ �غ��ҽ��ϴ�)
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
     ,EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(SSN, 1, 2) + 1899) ) "����"
FROM TBL_INSA
WHERE EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(SSN, 1, 2) + 1899) )  >= 50
  AND EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(SSN, 1, 2) + 1899) )  <= 59;

--23. �ֹι�ȣ �������� 5�� ���� ��ȸ. 
--    ��, SUBSTR() �Լ� �̿�.
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
     , TO_NUMBER(SUBSTR(SSN, 3, 2) ) "������ ��"
FROM TBL_INSA
WHERE TO_NUMBER(SUBSTR(SSN, 3, 2) ) = 5;

--24. �ֹι�ȣ �������� 5�� ���� ��ȸ. 
--    ��, TO_CHAR() �Լ� �̿�.
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
     , TO_CHAR(SUBSTR(SSN, 3, 2) ) "������ ��"
FROM TBL_INSA
WHERE TO_CHAR(SUBSTR(SSN, 3, 2) ) = '05';

--25. ��ŵ� ������������ �����ϰ�, ��ŵ��� ������ �⺻�� �������� ���� ��ȸ
SELECT NAME "�̸�", CITY "��ŵ�", BASICPAY "�⺻��"
FROM TBL_INSA
ORDER BY CITY DESC, BASICPAY DESC;

--26. ���� ��� �߿��� �⺻��+����(��޿�) ������������ ����.
--    ( �̸�, ��ŵ�, �⺻��+���� )
SELECT NAME "�̸�", CITY "��ŵ�", BASICPAY+SUDANG "�޿�"
FROM TBL_INSA
WHERE CITY = '����'
ORDER BY �޿� DESC;

--27. ���� �� �μ� ������������ �����ϰ�, �μ��� ������ �⺻�� �������� ����. 
--    ( �̸�, �ֹι�ȣ, �μ�, �⺻�� )
SELECT NAME "�̸�", SSN "�ֹι�ȣ", BUSEO "�μ�", BASICPAY "�⺻��"
FROM TBL_INSA
WHERE ����
ORDER BY �μ�, �⺻�� DESC;

SELECT NAME "�̸�", SSN "�ֹι�ȣ", BUSEO "�μ�", BASICPAY "�⺻��"
FROM TBL_INSA
WHERE SUBSTR(SSN, 8, 1) IN ('2', '4')
ORDER BY �μ�, �⺻�� DESC;

--28. ���� �� ���̸� �������� �������� �����Ͽ� ��ȸ.
SELECT NAME "�̸�", 
     , 1 "����"
FROM TBL_INSA
WHERE ����
ORDER BY ����;

SELECT NAME "�̸�" 
     , EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(SSN, 1, 2) + 1899 ) "����"
FROM TBL_INSA
WHERE SUBSTR(SSN, 8, 1) IN ('1', '3')
ORDER BY ����;

--29. ���� ���� ����� �߿��� �Ի����� ���� ����� ���� �� �� �ֵ��� ��ȸ.
SELECT �̸�, ��ŵ�, �Ի���
FROM TBL_INSA
WHERE ���� ���
ORDER BY �Ի���;

SELECT NAME "�̸�", CITY "��ŵ�", IBSADATE "�Ի���"
FROM TBL_INSA
WHERE CITY = '����'
ORDER BY �Ի���, �̸�;

--30. ������ �达�� �ƴ� ��� ��ȸ. 
--    ��, ������ �� ���ڶ�� ����.
--    ( �̸�, ��ŵ�, �⺻�� ).
SELECT NAME "�̸�", CITY "��ŵ�", BASICPAY "�⺻��"
FROM TBL_INSA;
WHERE ������ �达�� �ƴ� ���;

SELECT NAME "�̸�", CITY "��ŵ�", BASICPAY "�⺻��"
FROM TBL_INSA
WHERE NAME NOT LIKE '��%';

--31. ��ŵ��� ����, �λ�, �뱸 �̸鼭
--    ��ȭ��ȣ�� 5 �Ǵ� 7�� ���Ե� �����͸� ��ȸ�ϵ�
--    �μ����� ������ �δ� ��µ��� �ʵ�����. (���ߺ� �� ����)
--    ( �̸�, ��ŵ�, �μ���, ��ȭ��ȣ )
SELECT NAME "�̸�", CITY "��ŵ�", BUSEO "�μ���", TEL "��ȭ��ȣ"
FROM TBL_INSA
WHERE ��ŵ��� ����, �λ�, �뱸 �̸鼭
      ��ȭ��ȣ�� 5 �Ǵ� 7�� ���Ե� �����͸� ��ȸ;

SELECT NAME "�̸�", CITY "��ŵ�", BUSEO "�μ���", TEL "��ȭ��ȣ"
FROM TBL_INSA
WHERE CITY IN ('����', '�λ�', '�뱸')
  AND TEL LIKE '%5%'
   OR TEL LIKE '%7%';

--32. ��ȭ��ȣ�� ������ '-'�� �����Ͽ� ��ȸ�ϰ�, 
--    ������ '��ȭ��ȣ����'���� ��ȸ.
SELECT NAME "�̸�"
     , ��ȭ��ȣ�� ������ '-'�� �����Ͽ� ��ȸ ������ '��ȭ��ȣ����'���� ��ȸ "��ȭ��ȣ"
FROM TBL_INSA;

SELECT NAME "�̸�"
     , NVL2(TEL, REPLACE(TEL, '-', ''), '��ȭ��ȣ����') "��ȭ��ȣ"
FROM TBL_INSA;
   


--�߰�����. (�⺻ ���� Ǯ�̰� ��� ���� �� �ۼ��Ѵ�.)
--          HR������ EMPLOYEES ���̺��� Ŀ�̼� �޴� ����� ����
--          �ȹ޴� ����� ���� ��ȸ�Ѵ�.
--          ������� ---------------
--              ����        �ο���
--          Ŀ�̼ǹ޴»��    XXX
--          Ŀ�̼Ǿ��»��    XXX
--          �����          XXX
--          (��Ʈ. COUNT(), NVL2(), GROUP BY ����)
SELECT *
FROM EMPLOYEES; 

SELECT NVL2(COMMISSION_PCT, '�޴� ����', '�ȹ޴� ����')
     , COUNT(*) AS "������"
FROM EMPLOYEES 
GROUP BY NVL2(COMMISSION_PCT, '�޴� ����', '�ȹ޴� ����');
--==>>
/*
�ȹ޴� ����	72
�޴� ����	35
*/

--33. TBL_INSA ���̺��� BASICPAY + SUDANG �� 
--    100���� �̸�, 100���� �̻�~200���� �̸�, 
--    200���� �̻��� �������� �� ��ȸ.
SELECT NAME "�̸�", BASICPAY + SUDANG "�޿�"
FROM TBL_INSA;

-- ������ �޿�����
SELECT CASE WHEN (BASICPAY+SUDANG) < 1000000 
                    THEN '100���� �̸�' 
                WHEN (BASICPAY+SUDANG) >= 1000000 
                 AND (BASICPAY+SUDANG) < 2000000 
                    THEN '100���� �̻�~200���� �̸�'
                WHEN (BASICPAY+SUDANG) >= 2000000
                    THEN '200���� �̻�'
                ELSE '�� �� ���� ��'
           END "�޿�����"
         , NAME "�̸�"
         , BASICPAY + SUDANG "�޿�" 
FROM TBL_INSA;

-- �޿����غ� ���� ��
SELECT T.�޿����� "�޿�����"
     , COUNT(*) "������"
FROM
(
    SELECT CASE WHEN (BASICPAY+SUDANG) < 1000000 
                    THEN '100���� �̸�' 
                WHEN (BASICPAY+SUDANG) >= 1000000 
                 AND (BASICPAY+SUDANG) < 2000000 
                    THEN '100���� �̻�~200���� �̸�'
                WHEN (BASICPAY+SUDANG) >= 2000000
                    THEN '200���� �̻�'
                ELSE '�� �� ���� ��'
           END "�޿�����"
         , NAME "�̸�"
         , BASICPAY + SUDANG "�޿�" 
    FROM TBL_INSA
) T
GROUP BY T.�޿�����;

--34. TBL_INSA ���̺��� �ֹι�ȣ�� ������ ��������� �⵵�� ������ ��ȸ.
-- ������ �̸��� �ֹι�ȣ �� �¾ �⵵
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
         , SUBSTR(SSN, 1, 2) "�¾�⵵"
FROM TBL_INSA;

-- �¾ �⵵�� ���� ��
SELECT T.�¾�⵵ "�¾�⵵"
     , COUNT(*) "������"
FROM
(
    SELECT NAME "�̸�", SSN "�ֹι�ȣ"
         , SUBSTR(SSN, 1, 2) "�¾�⵵"
    FROM TBL_INSA
) T   
GROUP BY T.�¾�⵵
ORDER BY T.�¾�⵵;


--35. �ֹι�ȣ�� �������� ���� ��������, ���� ������ �⵵ �������� ��ȸ.
--    (�̸�, �ֹι�ȣ)
SELECT NAME "�̸�", SSN "�ֹι�ȣ"
FROM TBL_INSA
ORDER BY SUBSTR(SSN, 3, 2) ASC
       , SUBSTR(SSN, 1, 2) DESC;
       
--36. �Ի����� ��������  ���� ��������, ���� ������ �⵵ �������� ��ȸ.
--    ��, ��� ���� ��ȸ.
--    (����. �Ի����� �ڷ����� DATE�̴�.)
DESC TBL_INSA;

SELECT NAME, IBSADATE
FROM TBL_INSA
ORDER BY SUBSTR(IBSADATE, 6, 2)
       , SUBSTR(IBSADATE, 1, 4) DESC;

SELECT NAME, IBSADATE
FROM TBL_INSA
ORDER BY TO_CHAR(IBSADATE,'MM') 
       , TO_CHAR(IBSADATE,'YYYY') DESC;       

--37. ��ü�ο���, �����ο���, �����ο����� ���� ��ȸ.
-- �̸�, �ֹ�, ���� ��ȸ
SELECT NAME, SSN
     , CASE WHEN SUBSTR(SSN, 8, 1) IN ('1', '3')
                THEN '����'
            WHEN SUBSTR(SSN, 8, 1) IN ('2', '4')
                THEN '����'
            ELSE '����Ȯ�κҰ�'
       END "����"
FROM TBL_INSA;

-- NVL �� ��ü�ο��� NULL ���ֱ�
SELECT NVL(T.����, '��ü�ο���') "����"
     , COUNT(*) "��� ��"
FROM
(
    SELECT NAME, SSN
         , CASE WHEN SUBSTR(SSN, 8, 1) IN ('1', '3')
                    THEN '����'
                WHEN SUBSTR(SSN, 8, 1) IN ('2', '4')
                    THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����"
    FROM TBL_INSA
) T
GROUP BY ROLLUP(T.����);

-- CASE�� ���� ��ü�ο��� NULL ���ֱ�
SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
                             ELSE '��ü�ο���'
       END "����"                      
     , COUNT(*) "��� ��"
FROM
(
    SELECT NAME, SSN
         , CASE WHEN SUBSTR(SSN, 8, 1) IN ('1', '3')
                    THEN '����'
                WHEN SUBSTR(SSN, 8, 1) IN ('2', '4')
                    THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����"
    FROM TBL_INSA
) T
GROUP BY ROLLUP(T.����);

-- �ζ��κ並 �� ����ϳ� ����غ��� �߰���
SELECT COUNT(*) "��ü�ο���"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1)) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1)) "���ڼ�"
FROM TBL_INSA;

--38. ���ߺ�, ������, �ѹ��� �ο��� ��ȸ. COUNT(), DECODE() �Լ� �̿�.
SELECT NAME, BUSEO
FROM TBL_INSA;

SELECT T.�μ� "�μ�"
     , COUNT(*) "������"
FROM
(
    SELECT NAME
         , DECODE(BUSEO, '���ߺ�', '���ߺ�', '������', '������', '�ѹ���', '�ѹ���', '��Ÿ') "�μ�"
    FROM TBL_INSA
    WHERE BUSEO IN ('���ߺ�', '������', '�ѹ���')
) T
GROUP BY T.�μ�;

--�ζ��κ� ���� Ǫ�� ��� ��� �غ�
-- ��� 1
SELECT BUSEO "�μ�"
     , DECODE(BUSEO, '���ߺ�', COUNT(*), '������', COUNT(*), '�ѹ���', COUNT(*)) "������"
FROM TBL_INSA
WHERE BUSEO IN ('���ߺ�', '������', '�ѹ���')
GROUP BY BUSEO;

-- ��� 2 
SELECT COUNT(DECODE(BUSEO, '���ߺ�', 1) ) "���ߺ� ��"
    ,  COUNT(DECODE(BUSEO, '������', 2) ) "������ ��"
    ,  COUNT(DECODE(BUSEO, '�ѹ���', 3) ) "�ѹ��� ��"
FROM TBL_INSA;

--39. ���� ����� ���� �ο��� ��ȸ.
-- ���� ��� ���� ��� ��ȸ
SELECT NAME, CITY, SSN
FROM TBL_INSA
WHERE CITY = '����'
  AND SUBSTR(SSN, 8, 1) IN ('1', '3');

-- ���� ���� �ο��� ��ȸ
SELECT T.����� "�����", COUNT(*) "�ο���", T.���� "����"
FROM
(
    SELECT NAME, CITY "�����"
         , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '�˼�����') "����"
    FROM TBL_INSA
    WHERE CITY = '����'
      AND SUBSTR(SSN, 8, 1) IN ('1', '3')
) T
GROUP BY T.�����, T.����;

-- �ζ��κ並 �� ����ϳ� ����غ��� �߰���
SELECT CITY "�����"
     , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '�˼�����') "����"
     , COUNT(*) "�ο���"
FROM TBL_INSA
WHERE CITY = '����'
  AND SUBSTR(SSN, 8, 1) IN ('1', '3')
GROUP BY CITY, DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '�˼�����');

  
--40. �μ��� �������̰�, ���� �ο���, ���� �ο��� ��ȸ.  COUNT(), DECODE() �Լ� �̿�.
SELECT T.���� "����", COUNT(*) "�ο���", T.�μ� "�μ�"
FROM
(
    SELECT DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '2', '����', '4', '����') "����"
         , NAME "�̸�"
         , BUSEO "�μ�"
    FROM TBL_INSA
    WHERE BUSEO = '������'
) T
GROUP BY T.����, T.�μ�;

-- �ζ��κ並 �� ����ϳ� ����غ��� �߰���
SELECT COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1)) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1)) "���ڼ�"
     , BUSEO "�μ�"
FROM TBL_INSA
WHERE BUSEO = '������'
GROUP BY BUSEO;

--41. ���ߺ�, ������, �ѹ��� �ο��� ��ȸ. ��, ������ '����'�� ����.
SELECT CITY "��ŵ�", BUSEO "�μ�", DECODE(BUSEO, '���ߺ�', COUNT(*), '������', COUNT(*), '�ѹ���', COUNT(*) ) "�ο���"
FROM TBL_INSA
WHERE CITY = '����'
  AND BUSEO IN ('���ߺ�', '������', '�ѹ���')
GROUP BY BUSEO, CITY;

--42. ���� ����� ���ڿ� ������ �⺻���� ��ȸ.
-- ��/�� ������ �⺻��
SELECT BASICPAY "�⺻��"
     , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '2', '����', '4', '����') "����"
FROM TBL_INSA
WHERE CITY = '����';

-- ��/�� �⺻����
SELECT T.���� "����", SUM(T.�⺻��) "�⺻����"
FROM
(
    SELECT BASICPAY "�⺻��"
         , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '2', '����', '4', '����') "����"
    FROM TBL_INSA
    WHERE CITY = '����'
) T
GROUP BY T.����;

--43. ���ڿ� ������ �⺻�� ��հ� ��ȸ. AVG(), DECODE() �Լ� �̿�.
SELECT T.���� "����", TRUNC(AVG(T.�⺻��),0) "��հ�"
FROM
(
    SELECT BASICPAY "�⺻��"
         , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '2', '����', '4', '����') "����"
    FROM TBL_INSA
) T
GROUP BY T.����;

--44. ���ߺ��� ����, ���� �⺻�� ��հ� ��ȸ.
SELECT T.���� "����", ROUND(AVG(T.�⺻��), 2) "��հ�"
FROM
(
    SELECT BASICPAY "�⺻��"
         , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '2', '����', '4', '����') "����"
    FROM TBL_INSA
    WHERE BUSEO = '���ߺ�'
) T
GROUP BY T.����;

--45. �μ��� ���ڿ� ���� �ο��� ���ϱ�
--SUM()�� ���� ���� ��� NULL�� ��
SELECT BUSEO "�μ�"
     , SUM(DECODE(SUBSTR(SSN, 8, 1), '1', 1, '3', 1, 0) ) "���ڼ�"
     , SUM(DECODE(SUBSTR(SSN, 8, 1), '2', 1, '4', 1, 0) ) "���ڼ�"
FROM TBL_INSA
GROUP BY BUSEO;

--COUNT()�� ���� ���� ��� 0�� ��
SELECT BUSEO "�μ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1) ) "���ڼ�"
FROM TBL_INSA
GROUP BY BUSEO;


--46. ������ ���ڿ� ���� �ο��� ���ϱ�
SELECT CITY "��ŵ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1) ) "���ڼ�" 
FROM TBL_INSA
GROUP BY CITY;

--47. �Ի�⵵�� ���ڿ� ���� �ο��� ���ϱ�
-- EXTRACT
SELECT EXTRACT(YEAR FROM IBSADATE) "�Ի�⵵"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1) ) "���ڼ�" 
FROM TBL_INSA
GROUP BY IBSADATE
ORDER BY IBSADATE;

--TO_CHAR
SELECT TO_CHAR(IBSADATE, 'YYYY') "�Ի�⵵"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1) ) "���ڼ�" 
FROM TBL_INSA
GROUP BY IBSADATE
ORDER BY IBSADATE;

--48. ������, �ѹ��� �ο����� ������ �Ի�⵵�� ���ڿ� ���� �ο��� ���ϱ�
SELECT BUSEO "�μ�"
     , TO_CHAR(IBSADATE, 'YYYY') "�Ի�⵵"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1) ) "���ڼ�"  
FROM TBL_INSA
WHERE BUSEO IN ('������', '�ѹ���')
GROUP BY BUSEO, IBSADATE
ORDER BY IBSADATE;

--49. ���� ����� �μ��� ���ڿ� �����ο���, ���ڿ� ���� �޿��� ��ȸ.
SELECT CITY "��ŵ�"
     , BUSEO "�μ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(ssn, 8, 1), '2', 1, '4', 1) ) "���ڼ�" 
     , SUM(BASICPAY + SUDANG) "�޿���"
FROM TBL_INSA
WHERE CITY = '����'
GROUP BY BUSEO, CITY;

-- ��� �´��� üũ�ϱ� ���� ��ü ��ȸ
--SELECT CITY, SSN, BUSEO, NVL(BASICPAY + SUDANG,0)
--FROM TBL_INSA
--WHERE CITY = '����'
--ORDER BY BUSEO;

--50. �μ��� �ο��� ���. �ο����� 10 �̻��� ��츸.
SELECT BUSEO "�μ�", COUNT(*) "�ο���"
FROM TBL_INSA
GROUP BY BUSEO
HAVING COUNT(BUSEO) >= 10;

--51. �μ��� ��,�� �ο��� ���. �����ο����� 5�� �̻��� �μ��� ��ȸ.
SELECT BUSEO "�μ�"
     , COUNT(DECODE(SUBSTR(SSN, 8, 1), '1', 1, '3', 1) ) "���ڼ�"
     , COUNT(DECODE(SUBSTR(SSN, 8, 1), '2', 1, '4', 1) ) "���ڼ�"
FROM TBL_INSA
GROUP BY BUSEO
HAVING COUNT(DECODE(SUBSTR(SSN, 8, 1), '2', 1, '4', 1) ) >= 5;

--52. �̸�, ����, ���� ��ȸ
--    ����: �ֹι�ȣ Ȱ�� 1,3 �� ����, 2,4 �� ���� (DECODE() ���)
--    ����: �ֹι�ȣ Ȱ��
SELECT NAME
     , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����', '2', '����', '4', '����') "����"
     , EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(SSN, 1, 2) + 1899 ) "����"
FROM TBL_INSA;

--53. ���� ��� �߿��� �⺻���� 200���� �̻��� ��� ��ȸ. 
--    ( �̸�, �⺻�� )
SELECT NAME, BASICPAY, CITY
FROM TBL_INSA
WHERE CITY = '����'
  AND BASICPAY >= 2000000;

--54. �Ի���� �ο��� ���ϱ�. (��, �ο���)   COUNT, GROUP BY, TO_CHAR ���
--    ������� ----------
--     ��  �ο���
--    1��    10��
--    2��    25��
SELECT TO_NUMBER(TO_CHAR(IBSADATE, 'MM') ) "�Ի��", COUNT(*) "�ο���"
FROM TBL_INSA
GROUP BY TO_NUMBER(TO_CHAR(IBSADATE, 'MM') )
ORDER BY TO_NUMBER(TO_CHAR(IBSADATE, 'MM') );

--55. �̸�, �������, �⺻��, ������ ��ȸ.
--    ��������� �ֹι�ȣ ���� (2000-10-10 �������� ���)
--    �⺻���� \1,000,000 �������� ���
-- ��Ʈ. 3�ڸ� �޸�
/*
--�� TO_CHAR() Ȱ�� �� ���� ���� ǥ�� ����� ��ȯ
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"  -- ȭ����� ǥ��
     , TO_CHAR(60000, '$99,999') "COL3" -- $ ǥ��
     , TO_CHAR(60000, 'L99,999') "COL4" -- �� ǥ�� �� ȭ�� ��ȣ�� ���󸶴� �ٸ��Ƿ� ���ʿ� ������ �ִ�
     , LTRIM(TO_CHAR(60000, 'L99,999')) "COL5" --  �� �׷��Ƿ� LTRIM()�� �̿��� ���� ������ ���� �� �ִ� 
FROM DUAL;
*/

SELECT NAME
     , TO_DATE(DECODE(SUBSTR(SSN, 8, 1), '1', 19 || SUBSTR(SSN, 1, 6)
               -------------------------------------------------------
                        -- 19771212
                                       , '2', 19 || SUBSTR(SSN, 1, 6)
                                       , '3', 20 || SUBSTR(SSN, 1, 6)
                                       , '4', 20 || SUBSTR(SSN, 1, 6) ), 'YYYY-MM-DD') "�������"
       -------------------------------------------------------------------------------
                        -- 1977-12-12
                                       
     , TO_CHAR(BASICPAY, 'L9,999,999') "�⺻��"
     , TO_CHAR(SUDANG, 'L9,999,999') "����"
FROM TBL_INSA;

--56. �̸�, ��ŵ�, �⺻���� ��ȸ�ϵ� ��ŵ� �������� ���(1�� ���� ����).
--    ��ŵ��� ������ �⺻�� �������� ���(2�� ���� ����).
SELECT NAME, CITY, BASICPAY
FROM TBL_INSA
ORDER BY CITY DESC, BASICPAY;

--57. ��ȭ��ȣ�� NULL�� �ƴѰ͸� ��ȸ. (�̸�, ��ȭ��ȣ)
SELECT NAME, TEL
FROM TBL_INSA
WHERE TEL IS NOT NULL;

--58. �ٹ������ 10�� �̻��� ��� ��ȸ. (�̸�, �Ի���)
SELECT NAME, IBSADATE
     , EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(TO_CHAR(IBSADATE, 'YYYY') ) "�ٹ����"
FROM TBL_INSA
WHERE EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(TO_CHAR(IBSADATE, 'YYYY') ) >= 10;
-- �ٹ���� = ����⵵ - �Ի�⵵

--59. �ֹι�ȣ�� �������� 75~82��� ��ȸ. (�̸�, �ֹι�ȣ, ��ŵ�).
--    SUBSTR() �Լ�, BEWTEEN AND ����, TO_NUMBER() �Լ� �̿�.
SELECT NAME, SSN, CITY
     , 19 || TO_NUMBER(SUBSTR(SSN, 1, 2) ) "�¾�⵵"  -- ��� 1900��� ��� ����
FROM TBL_INSA
WHERE TO_NUMBER(SUBSTR(SSN, 1, 2) ) BETWEEN 75 AND 82;

--60. �ٹ������ 5~10���� ��� ��ȸ. (�̸�, �Ի���)
-- �����Ϳ� �ٹ������ 5~10���� ����� ���
-- ���Ƿ� 24~27���� ������� �����߽��ϴ�
SELECT NAME, IBSADATE
     , EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(TO_CHAR(IBSADATE, 'YYYY') ) "�ٹ����"
FROM TBL_INSA
WHERE EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(TO_CHAR(IBSADATE, 'YYYY') ) BETWEEN 24 AND 27
ORDER BY �ٹ����;

--61. �达, �̾�, �ھ��� ��ȸ (�̸�, �μ�). SUBSTR() �Լ� �̿�.
SELECT NAME, BUSEO
FROM TBL_INSA
WHERE SUBSTR(NAME, 1, 1) IN ('��', '��', '��');

--62. �Ի����� "��-��-�� ����" �������� ���ڸ� ��ȸ (�̸�, �ֹι�ȣ, �Ի���)
SELECT NAME, SSN, TO_CHAR(IBSADATE, 'YYYY-MM-DD DAY')
FROM TBL_INSA
WHERE SUBSTR(SSN, 8, 1) IN ('1', '3');

--63. �μ��� ������ �޿��� ���ϱ�. (�μ�, ����, �޿���)
SELECT BUSEO, JIKWI
     , SUM(BASICPAY + SUDANG) "�޿���"
FROM TBL_INSA
GROUP BY BUSEO, JIKWI
ORDER BY BUSEO, �޿��� DESC;

--64. �μ��� ������ �ο���, �޿���, �޿���� ���ϱ�. (�μ�, ����, �޿���)
SELECT BUSEO, JIKWI, COUNT(*)
     , SUM(BASICPAY + SUDANG) "�޿���"
     , ROUND(AVG(BASICPAY + SUDANG),1) "�޿����"
FROM TBL_INSA
GROUP BY BUSEO, JIKWI
ORDER BY BUSEO;

--65. �μ��� ������ �ο����� ���ϵ� �ο����� 5�� �̻��� ��츸 ��ȸ.
SELECT BUSEO, JIKWI, COUNT(*)
FROM TBL_INSA
GROUP BY BUSEO, JIKWI
HAVING COUNT(*) >= 5
ORDER BY BUSEO;

--66. 2000�⿡ �Ի��� ����� ��ȸ. (�̸�, �ֹι�ȣ, �Ի���)
SELECT NAME, SSN, IBSADATE
FROM TBL_INSA
WHERE TO_CHAR(IBSADATE, 'YYYY') = 2000
  AND SUBSTR(SSN, 8, 1) IN ('2', '4');

--67. ������ �� ����(��, ��, �� ��)��� �����Ͽ� ������ �ο��� ��ȸ (����, �ο���)
SELECT SUBSTR(NAME, 1, 1) "����"
     , COUNT(*)
FROM TBL_INSA
GROUP BY SUBSTR(NAME, 1, 1);

--68. ��ŵ�(CITY)�� ���� �ο��� ��ȸ.
SELECT CITY
     , COUNT(DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����')) "���ڼ�"
     , COUNT(DECODE(SUBSTR(SSN, 8, 1), '2', '����', '4', '����')) "���ڼ�"
FROM TBL_INSA
GROUP BY CITY;

--69. �μ��� �����ο����� 5�� �̻��� �μ��� �����ο��� ��ȸ.
SELECT BUSEO
     , COUNT(DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����') ) "���ڼ�"
FROM TBL_INSA
GROUP BY BUSEO
HAVING COUNT(DECODE(SUBSTR(SSN, 8, 1), '1', '����', '3', '����') ) >= 5;


--70. �Ի�⵵�� �ο��� ��ȸ.
SELECT TO_CHAR(IBSADATE, 'YYYY') "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_INSA
GROUP BY TO_CHAR(IBSADATE, 'YYYY')
ORDER BY �Ի�⵵;

--71. ��ü�ο���, 2000��, 1999��, 1998�⵵�� �Ի��� �ο��� ������ �������� ��ȸ.
/*
���� ��)

��ü 2000 1999 1998
 60    x    x    x
*/
SELECT COUNT(*) "��ü"
     , COUNT(DECODE(TO_CHAR(IBSADATE, 'YYYY'), '2000', 1) ) "2000��"
     , COUNT(DECODE(TO_CHAR(IBSADATE, 'YYYY'), '1999', 1) ) "1999��"
     , COUNT(DECODE(TO_CHAR(IBSADATE, 'YYYY'), '1998', 1) ) "1998��"
FROM TBL_INSA;

--72. �Ʒ� �������� ������ �ο��� ��ȸ.
/*
���� ��)
��ü ����  ��õ  ���
 60    x     x     x
*/
SELECT COUNT(*) "��ü"
     , COUNT(DECODE(CITY, '����', 1) ) "����"
     , COUNT(DECODE(CITY, '��õ', 1) ) "��õ"
     , COUNT(DECODE(CITY, '���', 1) ) "���"
FROM TBL_INSA;

--73. �⺻��(BASICPAY)�� ��� ������ ��� ��ȸ. (�̸�, �⺻��). AVG() �Լ�. ��������.

--�⺻��(BASICPAY) ��� 
SELECT ROUND(AVG(BASICPAY),1) "�⺻�� ���"
FROM TBL_INSA;
--==>> 1563796.7

SELECT NAME, BASICPAY
FROM TBL_INSA
WHERE BASICPAY <= (SELECT ROUND(AVG(BASICPAY),1)
                   FROM TBL_INSA);

--74. �⺻�� ���� 10%�� ��ȸ. (�̸�, �⺻��)
-- �⺻�� ��������
SELECT *
FROM
(
    SELECT NAME,BASICPAY
         , RANK() OVER(ORDER BY BASICPAY DESC) "�⺻�޼���"
    FROM TBL_INSA
) T
WHERE T.�⺻�޼��� <= (SELECT COUNT(*)
                       FROM TBL_INSA) * 0.1;

--75. �⺻�� ������ 5���������� ��ȸ. (��� ����)
SELECT *
FROM 
(
    SELECT NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
         , RANK() OVER(ORDER BY BASICPAY DESC) "�⺻�޼���"
    FROM TBL_INSA
) T
WHERE T.�⺻�޼��� <= 5;

--76. �Ի����� ���� ������ 5���������� ��ȸ. (��� ����)
SELECT *
FROM
(
    SELECT NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
         , RANK() OVER(ORDER BY IBSADATE) "�Ի��ϼ�"
    FROM TBL_INSA
) T
WHERE T.�Ի��ϼ� <= 5;

--77. ��� �޿����� ���� �޿��� �޴� ���� ���� ��ȸ. (��� ����)
--������ ��� �޿�
SELECT ROUND(AVG(BASICPAY+SUDANG), -1) "�޿� ���"
FROM TBL_INSA;

SELECT *
FROM TBL_INSA
WHERE (BASICPAY+SUDANG) > (SELECT ROUND(AVG(BASICPAY+SUDANG), -1)
                           FROM TBL_INSA);

--78. '�̼���' ������ �޿����� �� ���� �޿��� �޴� ���� ��ȸ. (��� ����)
--    ��, �̼��� ������ �޿��� ���ϴ��� �ۼ��� �������� ��� ������ �����ϵ��� ��ȸ.
-- �̼��� ������ �޿�
SELECT NAME, BASICPAY+SUDANG "�޿�"
FROM TBL_INSA
WHERE NAME = '�̼���';

SELECT *
FROM TBL_INSA
WHERE (BASICPAY+SUDANG) > (SELECT BASICPAY+SUDANG
                           FROM TBL_INSA
                           WHERE NAME = '�̼���');

--79. �ѹ����� ��� �޿����� ���� �޿��� �޴� �������� �̸�, �μ��� ��ȸ.
-- �ѹ��� ��� �޿�
SELECT BUSEO, ROUND(AVG(BASICPAY+SUDANG), -1) "��ձ޿�"
FROM TBL_INSA
WHERE BUSEO = '�ѹ���'
GROUP BY BUSEO;

SELECT NAME, BUSEO, BASICPAY+SUDANG "�޿�"
FROM TBL_INSA
WHERE (BASICPAY+SUDANG) > (SELECT ROUND(AVG(BASICPAY+SUDANG), -1)
                            FROM TBL_INSA
                            WHERE BUSEO = '�ѹ���')
ORDER BY BUSEO;

--80. �ѹ��� �������� ��� ���纸�� �� ���� ������ �޴� ���� ���� ��ȸ.
SELECT *
FROM TBL_INSA
WHERE (SUDANG) > (SELECT ROUND(AVG(SUDANG), -1)
                  FROM TBL_INSA
                  WHERE BUSEO = '�ѹ���')
ORDER BY SUDANG;


--81. ���� ��ü ��� �޿����� ���� �޿��� �޴� ������ �� ��ȸ.
SELECT COUNT(*) "������"
FROM TBL_INSA
WHERE (BASICPAY+SUDANG) > (SELECT ROUND(AVG(BASICPAY+SUDANG), -1)
                            FROM TBL_INSA)
ORDER BY BUSEO;

--82. 'ȫ�浿' ������ ���� �μ��� ���� ���� ��ȸ.
--    ��, ȫ�浿 ������ �μ��� �ٲ���� �ۼ��� �������� ��� ������ �����ϵ��� ��ȸ.
SELECT *
FROM TBL_INSA
WHERE BUSEO = (SELECT BUSEO
               FROM TBL_INSA
               WHERE NAME = 'ȫ�浿');

--83. '��ž�' ������ ���� �μ�, ������ ���� ���� ���� ��ȸ.
--    ��, ��ž� ������ �μ� �� ������ �ٲ���� �ۼ��� �������� ��� ������ �����ϵ��� ��ȸ.
-- ��� 1
SELECT *
FROM TBL_INSA
WHERE BUSEO = (SELECT BUSEO
               FROM TBL_INSA
               WHERE NAME = '��ž�')
  AND JIKWI = (SELECT JIKWI
               FROM TBL_INSA
               WHERE NAME = '��ž�');
-- ��� 2
SELECT * 
FROM TBL_INSA
WHERE BUSEO || JIKWI = (SELECT BUSEO || JIKWI
                        FROM TBL_INSA
                        WHERE NAME='��ž�');

--84. �μ��� �⺻���� ���� ���� ��� ��ȸ. (�̸�, �μ�, �⺻��)
--    ��, ������� �⺻���� ����Ǵ��� �ۼ��� �������� ��� ������ �����ϵ��� ��ȸ.
-- ��� 1
SELECT *
FROM
(
    SELECT NAME, BUSEO, BASICPAY
         , RANK() OVER(ORDER BY BASICPAY DESC) "�⺻�޼���"
    FROM TBL_INSA
) T
WHERE T.�⺻�޼��� = 1;

--85. ��, ���� �⺻�� ���� ��ȸ.
SELECT NAME, BASICPAY
     , RANK() OVER(PARTITION BY (DECODE(SUBSTR(SSN, 8, 1), '1', '����', '2', '����')) ORDER BY BASICPAY DESC) "��, ���� �⺻�޼���"
     , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '2', '����') "����" 
FROM TBL_INSA;

--86. ����(CITY)���� �޿�(�⺻��+����) 1���� ������ ��ȸ.
SELECT *
FROM
(
    SELECT RANK() OVER(PARTITION BY CITY ORDER BY BASICPAY+SUDANG) "�޿�����"
         , CITY
         , NAME
         , BASICPAY+SUDANG "�޿�"
    FROM TBL_INSA
) T
WHERE T.�޿����� = 1
ORDER BY T.�޿� DESC;

--87. �μ��� �ο����� ���� ���� �μ� �� �ο��� ��ȸ.
SELECT *
FROM
(
    SELECT COUNT(*) "�ο���"
         , RANK() OVER(ORDER BY COUNT(*) DESC) "�ο�������"
         , BUSEO
    FROM TBL_INSA
    GROUP BY BUSEO
)
WHERE �ο������� = 1; 

--88. ����(CITY)�� �ο����� ���� ���� ���� �� �ο��� ��ȸ.
SELECT *
FROM
(
    SELECT COUNT(*) "�ο���"
         , RANK() OVER(ORDER BY COUNT(*) DESC) "�ο�������"
         , CITY
    FROM TBL_INSA
    GROUP BY CITY
)
WHERE �ο������� = 1; 

--89. ����(CITY)�� ��� �޿�(BASICPAY + SUDANG)��
--    ���� ���� ���� �� ��ձ޿� ��ȸ.
SELECT *
FROM
(
    SELECT RANK() OVER(ORDER BY ROUND(AVG(BASICPAY + SUDANG), -1) DESC) "��ձ޿�����"
         , ROUND(AVG(BASICPAY + SUDANG), -1) "��ձ޿�"
         , CITY
    FROM TBL_INSA
    GROUP BY CITY
)
WHERE ��ձ޿����� = 1; 

--90. ���� �ο����� ���� ���� �μ� �� �ο��� ��ȸ.
SELECT *
FROM
(
    SELECT BUSEO
         , COUNT(*) "�����ο���"
         , RANK() OVER(ORDER BY COUNT(*) DESC) "�ο�������"
    FROM TBL_INSA
    WHERE SUBSTR(SSN, 8, 1) IN (2, 4)
    GROUP BY BUSEO
)
WHERE �ο������� = 1;

--91. ������ �ο��� ���� ��ȸ.
SELECT CITY
     , COUNT(*) "�������ο���"
     , RANK() OVER(ORDER BY COUNT(*) DESC) "�ο�������"
FROM TBL_INSA
GROUP BY CITY;

--92. ������ �ο��� ���� ��ȸ�ϵ� 5���������� ���.
SELECT *
FROM
(
    SELECT CITY
         , COUNT(*) "�������ο���"
         , RANK() OVER(ORDER BY COUNT(*) DESC) "�ο�������"
    FROM TBL_INSA
    GROUP BY CITY
)
WHERE �ο������� <= 5;

--93. �̸�, �μ�, ��ŵ�, �⺻��, ����, �⺻��+����, ����, �Ǽ��ɾ� ��ȸ
--    ��, ����: �ѱ޿��� 250���� �̻��̸� 2%, 200���� �̻��̸� 1%, ������ 0.
--    �Ǽ��ɾ�: �ѱ޿�-����
SELECT T.�̸�, T.�μ�, T.��ŵ�, T.�⺻��, T.����, T.�ѱ޿�, T.����
     , T.�ѱ޿� - T.���� "�Ǽ��ɾ�"
FROM
(
    SELECT NAME "�̸�", BUSEO "�μ�", CITY "��ŵ�" , BASICPAY "�⺻��", SUDANG "����", BASICPAY+SUDANG "�ѱ޿�"
         , CASE WHEN BASICPAY+SUDANG >= 2500000
                    THEN (BASICPAY+SUDANG) * 0.02 
                WHEN BASICPAY+SUDANG >= 2000000
                    THEN (BASICPAY+SUDANG) * 0.01 
                ELSE 0 
           END "����"
    FROM TBL_INSA
) T;

--94. �μ��� ��� �޿��� ��ȸ�ϵ�, A, B, C ������� ������ ���.
--    200���� �ʰ� - A���
--    150~200����  - B���
--    150���� �̸� - C���

SELECT BUSEO
     , ROUND(AVG(BASICPAY+SUDANG),-1) "��ձ޿�"
     , CASE WHEN ROUND(AVG(BASICPAY+SUDANG),-1) > 2000000
                    THEN 'A���'
            WHEN ROUND(AVG(BASICPAY+SUDANG),-1) > 1500000
                    THEN 'B���' 
                ELSE 'C���' 
           END "���" 
FROM TBL_INSA
GROUP BY BUSEO
ORDER BY ���;

--95. �⺻��+������ ���� ���� ����� �̸�, �⺻��+���� ��ȸ.
--    MAX() �Լ�, ���� ���� �̿�.
SELECT MAX(BASICPAY + SUDANG) "�޿��ִ밪"
FROM TBL_INSA;

SELECT NAME,BASICPAY + SUDANG "�޿�"
FROM TBL_INSA
WHERE BASICPAY + SUDANG = (SELECT MAX(BASICPAY + SUDANG)
                            FROM TBL_INSA);


----------------------------------------------------------------------------