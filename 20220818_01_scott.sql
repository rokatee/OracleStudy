SELECT USER
FROM DUAL;
--==>> SCOTT

--�� CASE ����(���ǹ�, �б⹮)
/*
CASE
WHEN
THEN
ELSE
END
*/

SELECT CASE 5+2 WHEN 4 THEN '5+2=4' ELSE '5+2�� �����' END
FROM DUAL;
--==>> 5+2�� �����

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2�� �����' END
FROM DUAL;
--==>> 5+2=7

SELECT CASE 1+1 WHEN 2 THEN '1+1=2' 
                WHEN 3 THEN '1+1=3' 
                WHEN 4 THEN '1+1=4'
                ELSE '����'
       END
FROM DUAL;
--==>> 1+1=2

SELECT CASE 1+1 WHEN 2 THEN '1+1=2' 
                WHEN 3 THEN '1+1=3' 
                WHEN 2 THEN '1+1=4'
                ELSE '����'
       END
FROM DUAL;
--==>> 1+1=2
--> ���� ��츦 ã���� �� ���� ������ �Ĵٺ��� �ʰ� 
--  CASE���� �������� ������� ����Ѵ�

SELECT CASE WHEN 5+2=4 THEN '5+2=4'
            WHEN 6-3=2 THEN '6-3=2'
            WHEN 2*1=2 THEN '2*1=2'
            WHEN 6/3=3 THEN '6/3=3'
            ELSE '����'
       END     
FROM DUAL;
--==>> 2*1=2

SELECT CASE WHEN 5+2=7 THEN '5+2=7'
            WHEN 6-3=3 THEN '6-3=3'
            WHEN 2*1=2 THEN '2*1=2'
            WHEN 6/3=2 THEN '6/3=2'
            ELSE '����'
       END     
FROM DUAL;
--==>> 5+2=7
--> ���� ��츦 ã���� �� ���� ������ �Ĵٺ��� �ʰ� 
--  CASE���� �������� ������� ����Ѵ�


--�� DECODE()
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '����') "���Ȯ��"
FROM DUAL;
--==>> 5-2=3


--�� CASE WHEN THEN ELSE END (���ǹ�, �б⹮) Ȱ��
SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5�� 2�� �� �Ұ�'
       END "���"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '�缮����'
            WHEN 5>2 OR 2=3 THEN '�������'
            ELSE '���ϸ���'
       END "���"
FROM DUAL;
--==>> �缮����

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '��������'
            WHEN 5<2 AND 2=3 THEN 'ȫö����'
            ELSE '���ϸ���'
       END "���"
FROM DUAL;
--==>> ��������

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '��������'
            WHEN 5<2 AND 2=3 THEN 'ȫö����'
            ELSE '���ϸ���'
       END "���"
FROM DUAL;
--==>> ���ϸ���


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT * 
FROM TBL_SAWON;
--==>>
/*
1001	����	    9409252234567	2005-01-03	3000
1002	�躸��	    9809022234567	1999-11-23	2000
1003	���̰�	    9810092234567	2006-08-10	4000
1004	���α�	    9307131234567	1998-05-13	2000
1005	������	    7008161234567	1998-05-13	1000
1006	������	    9309302234567	1999-10-10	3000
1007	������	    0302064234567	2010-10-23	4000
1008	�μ���	    6807102234567	1998-03-20	1500
1009	������	    6710261234567	1998-03-20	1300
1010	������	6511022234567	1998-12-20	2600
1011	���켱	    0506174234567	2011-10-10	1300
1012	���ù�	    0102033234567	2010-10-10	2400
1013	����	    0210303234567	2011-10-10	2800
1014	�ݺ���	    9903142234567	2012-11-11	5200
1015	������	    9907292234567	2012-11-11	5200
1016	���̰�	    0605063234567	2015-01-20	1500
*/

--�� TBL_SAWON ���̺��� Ȱ���Ͽ� ������ ���� �׸��� ��ȸ�� �� �ֵ��� ������ �ۼ�
--   �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--   , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ�
--   ��, ���糪�̴� �⺻ �ѱ����� ������ ���� ������ ����
--   ����, ������������ �ش� ������ ���̰� �ѱ� ���̷� 60���� �Ǵ� ����
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�
--   �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� �����
--   �� ����� ���� �޿� ���� 30% ����, 2000�� �̻� �ٹ��� �����
--   �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�

-- EX) 1001	���� 9409252234567 ���� 29��	2005-01-03 2053-01-03 XXX�� XXX�� 3000 1500

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ" 
     , CASE WHEN JUBUN LIKE '______2%' 
              OR JUBUN LIKE '______4%' THEN '����'
            WHEN JUBUN LIKE '______1%' 
              OR JUBUN LIKE '______3%' THEN '����'
            ELSE '�Ǻ��Ұ�'
       END "����"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0
       END"���糪��"
     , HIREDATE "�Ի���"
     -- , �¾ ���� + 60�� "����������"
     -- , �¾ ���� + TO_YMINTERVAL('60-���糪��') "����������"
     -- , TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD')"����������"
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60-CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                                                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                                            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                                                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                                            ELSE 0
                                         END
                                     )*12), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')"����������"
     , TRUNC(SYSDATE - HIREDATE) "�ٹ��ϼ�"
     
        -- , ���������� - ����ð� "�����ϼ�"
        -- , ���������� - SYSDATE "�����ϼ�"
        -- , TRUNC(TO_DATE( TO_CHAR(ADD_MONTHS(SYSDATE, (60-T.���糪��)*12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') ) - SYSDATE)"�����ϼ�"
    
     , CASE WHEN SUBSTR(JUBUN, 1, 1) = '0'
                 THEN TRUNC(HIREDATE + TO_YMINTERVAL(60 - (EXTRACT(YEAR FROM HIREDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2)) - 2000 + 1) || '-00') - SYSDATE)
            ELSE TRUNC(HIREDATE + TO_YMINTERVAL(60 - (EXTRACT(YEAR FROM HIREDATE) - TO_NUMBER(SUBSTR(JUBUN, 1, 2)) - 1900 + 1) || '-00') - SYSDATE)     
         END  "�����ϼ�"

     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60-CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                                                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                                            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                                                 THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                                            ELSE 0
                                         END
                                     )*12), 'YYYY') || '-' || TO_CHAR(HIREDATE, 'MM-DD')) - SYSDATE) "�����ϼ�"
     , SAL "�޿�"
     , CASE WHEN TRUNC(SYSDATE - HIREDATE)>=5000 THEN SAL*0.5
            WHEN 1000<=TRUNC(SYSDATE - HIREDATE) THEN (SAL*0.3)
            ELSE 0
       END "���ʽ�"
FROM TBL_SAWON;


--------------------------------------------------------------------------------
-- �ش�
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ" 
     , CASE WHEN �ֹι�ȣ 7��°�ڸ� 1���� '1' �Ǵ� '3' THEN '����' 
            WHEN �ֹι�ȣ 7��°�ڸ� 1���� '2' �Ǵ� '4' THEN '����' 
            ELSE '����Ȯ�κҰ�'
       END "����"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ" 
     , CASE WHEN SUBSTR(JUBUN, 7, 1) �� '1' �Ǵ� '3' THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) �� '2' �Ǵ� '4' THEN '����' 
            ELSE '����Ȯ�κҰ�'
       END "����"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '3') THEN '����' 
            WHEN SUBSTR(JUBUN, 7, 1) IN('2', '4') THEN '����' 
            ELSE '����Ȯ�κҰ�'
       END "����"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���)
     , CASE WHEN 1900��� ���̶�� THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1899) 
            WHEN 2000��� ���̶�� THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1999)
            -- ELSE '����Ȯ�κҰ�'  
            -- ���� THEN�� ���ǹ��� ����Ÿ���ε� ELSE���� ����Ÿ�� �ϰ�� �����߻��Ѵ�
            -- ���糪�̴� ����Ÿ������ �ξ�� ���߿� Ȱ���ϱ� ���ϹǷ�
            -- THEN ELSE�� ����Ÿ������ �����ش�
            ELSE -1
       END "���糪��"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     , CASE WHEN �ֹι�ȣ 7��°�ڸ� 1���� '1' �Ǵ� '2'
                 THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1899) 
            WHEN �ֹι�ȣ 7��°�ڸ� 1���� '3' �Ǵ� '4'
                 THEN ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1999)
            ELSE -1
       END "���糪��"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
     -- ���糪��
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
             -- THEN TO_CHAR(SYSDATE, 'YYYY') - (�ֹι�ȣ�յ��ڸ� + 1899)  -- �̷��� ����⵵�� ����Ÿ���̹Ƿ�
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)  -- ����̸� ����Ÿ������ �̾ƽ��
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "���糪��"
FROM TBL_SAWON;


SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����", ����*2 "�ι迬��"
FROM EMP;
--==>> �����߻�
--     ORA-00904: "����": invalid identifier

SELECT EMPNO, ENAME, SAL, COMM, ����
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
    FROM EMP
);

-- ���������� : ������ �ȿ� �������� ���ԵǾ� �ִ� ����
SELECT ����*2 "�ι迬��"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
    FROM EMP
);

CREATE VIEW VIEW_EMP
AS
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
FROM EMP;
--==>> �����߻�
--     ORA-01031: insufficient privileges �� ���� ����

--�� SYS�� �����Ͽ� SCOTT ������ CREATE VIEW ���� �ο� �� �ٽ� ����
CREATE VIEW VIEW_EMP
AS
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
FROM EMP;
--==>> View VIEW_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_EMP;



SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     -- ����������
     -- ���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
     -- ���� ���̰�... 57��... 3�� ��    2022 �� 2025
     -- ���� ���̰�... 28��...32�� ��    2022 �� 2054
     -- ADD_MONTHS(SYSDATE, �������*12)
     --                     ---------
     --                     60 - ���糪��
     -- ADD_MONTHS(SYSDATE, (60 - ���糪��) * 12) �� Ư����¥
     -- TO_CHAR('Ư����¥', 'YYYY')               �� �������� �⵵�� ����
     -- TO_CHAR('�Ի���', 'MM-DD')                �� �Ի� ���ϸ� ����
     -- TO_CHAR('Ư����¥', 'YYYY') || '-' || TO_CHAR('�Ի���', 'MM-DD') �� ����������
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - ���糪��) * 12), 'YYYY') || '-' || TO_CHAR('�Ի���', 'MM-DD') �� ����������
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') 
     || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
     
     -- �ٹ��ϼ�
     -- �ٹ��ϼ� = ������ - �Ի���
     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     
     -- �����ϼ�
     -- �����ϼ� = ���������� - ������
     -- , TO_DATE(�����������ڿ�, 'YYYY-MM-DD') - ������ "�����ϼ�"
     , TRUNC(TO_DATE((TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') 
     || '-' || TO_CHAR(T.�Ի���, 'MM-DD')), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
     
     
     -- �޿�
     , T.�޿�
     
     -- ���ʽ�
     -- �ٹ��ϼ��� 1000�� �̻� 2000�� �̸� �� �޿��� 30% ����
     -- �ٹ��ϼ��� 2000�� �̻�             �� �޿��� 50% ����
     -- ������                             �� 0
     ---------------------------------------------------------
     -- �ٹ��ϼ��� 2000�� �̻�             �� �޿� * 0.5
     -- �ٹ��ϼ��� 1000�� �̻�             �� �޿� * 0.3
     -- ������                             �� 0
     -- , CASE WHEN �ٹ��ϼ� >= 2000 THEN �޿� * 0.5 
     , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5 
            WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
            ELSE 0
       END "���ʽ�"
     
FROM
(   
    SELECT SANO"�����ȣ", SANAME"�����", JUBUN"�ֹι�ȣ"
        ,  CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '����'
                ELSE '����Ȯ�κҰ�'
                END "����"
          -- ���糪�� = ����⵵ - �¾�⵵ + 1(1900��� /2000���)
          , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1899)
                WHEN SUBSTR(JUBUN,7,1) IN('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1999)
                ELSE -1
            END "���糪��"
          -- �Ի���
         , HIREDATE "�Ի���"
          -- �޿�
         , SAL "�޿�"
    FROM TBL_SAWON
)T;
--==>>
/*
1001	����	    9409252234567	����	29	05/01/03	2053-01-03	6436	11095	3000	1500
1002	�躸��	    9809022234567	����	25	99/11/23	2057-11-23	8304	12880	2000	1000
1003	���̰�	    9810092234567	����	25	06/08/10	2057-08-10	5852	12775	4000	2000
1004	���α�	    9307131234567	����	30	98/05/13	2052-05-13	8863	10860	2000	1000
1005	������	    7008161234567	����	53	98/05/13	2029-05-13	8863	 2459	1000	 500
1006	������	    9309302234567	����	30	99/10/10	2052-10-10	8348	11010	3000	1500
1007	������	    0302064234567	����	20	10/10/23	2062-10-23	4317	14675	4000	2000
1008	�μ���	    6807102234567	����	55	98/03/20	2027-03-20	8917	 1674	1500	 750
1009	������	    6710261234567	����	56	98/03/20	2026-03-20	8917	 1309	1300	 650
1010	������	6511022234567	����	58	98/12/20	2024-12-20	8642	  854	2600	1300
1011	���켱	    0506174234567	����	18	11/10/10	2064-10-10	3965	15393	1300	 650
1012	���ù�	    0102033234567	����	22	10/10/10	2060-10-10	4330	13932	2400	1200
1013	����	    0210303234567	����	21	11/10/10	2061-10-10	3965	14297	2800	1400
1014	�ݺ���	    9903142234567	����	24	12/11/11	2058-11-11	3567	13233	5200	2600
1015	������	    9907292234567	����	24	12/11/11	2058-11-11	3567	13233	5200	2600
1016	���̰�	    0605063234567	����	17	15/01/20	2065-01-20	2767	15495	1500	 750
*/

-- ������ ó���� ������ �������
-- Ư�� �ٹ��ϼ��� ����� Ȯ���ؾ� �Ѵٰų�
-- Ư�� ���ʽ� �ݾ��� �޴� ����� Ȯ���ؾ� �� ��찡 �߻��� �� �ִ�
-- (��, �߰����� ��ȸ ������ �߻��ϰų�, ������ �Ļ��Ǵ� ���)
-- �̿� ���� ���,,, �ش� �������� �ٽ� �����ؾ� �ϴ� ���ŷο��� ���� �� �ֵ���
-- ��(VIEW)�� ����� ������ �� �� �ִ�

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
     -- ����������
     -- ���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
     -- ���� ���̰�... 57��... 3�� ��    2022 �� 2025
     -- ���� ���̰�... 28��...32�� ��    2022 �� 2054
     -- ADD_MONTHS(SYSDATE, �������*12)
     --                     ---------
     --                     60 - ���糪��
     -- ADD_MONTHS(SYSDATE, (60 - ���糪��) * 12) �� Ư����¥
     -- TO_CHAR('Ư����¥', 'YYYY')               �� �������� �⵵�� ����
     -- TO_CHAR('�Ի���', 'MM-DD')                �� �Ի� ���ϸ� ����
     -- TO_CHAR('Ư����¥', 'YYYY') || '-' || TO_CHAR('�Ի���', 'MM-DD') �� ����������
     -- TO_CHAR(ADD_MONTHS(SYSDATE, (60 - ���糪��) * 12), 'YYYY') || '-' || TO_CHAR('�Ի���', 'MM-DD') �� ����������
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') 
     || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
     
     -- �ٹ��ϼ�
     -- �ٹ��ϼ� = ������ - �Ի���
     , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     
     -- �����ϼ�
     -- �����ϼ� = ���������� - ������
     -- , TO_DATE(�����������ڿ�, 'YYYY-MM-DD') - ������ "�����ϼ�"
     , TRUNC(TO_DATE((TO_CHAR(ADD_MONTHS(SYSDATE, (60 - T.���糪��) * 12), 'YYYY') 
     || '-' || TO_CHAR(T.�Ի���, 'MM-DD')), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
     
     
     -- �޿�
     , T.�޿�
     
     -- ���ʽ�
     -- �ٹ��ϼ��� 1000�� �̻� 2000�� �̸� �� �޿��� 30% ����
     -- �ٹ��ϼ��� 2000�� �̻�             �� �޿��� 50% ����
     -- ������                             �� 0
     ---------------------------------------------------------
     -- �ٹ��ϼ��� 2000�� �̻�             �� �޿� * 0.5
     -- �ٹ��ϼ��� 1000�� �̻�             �� �޿� * 0.3
     -- ������                             �� 0
     -- , CASE WHEN �ٹ��ϼ� >= 2000 THEN �޿� * 0.5 
     , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5 
            WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
            ELSE 0
       END "���ʽ�"
     
FROM
(   
    SELECT SANO"�����ȣ", SANAME"�����", JUBUN"�ֹι�ȣ"
        ,  CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2','4') THEN '����'
                ELSE '����Ȯ�κҰ�'
                END "����"
          -- ���糪�� = ����⵵ - �¾�⵵ + 1(1900��� /2000���)
          , CASE WHEN SUBSTR(JUBUN, 7, 1) IN('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1899)
                WHEN SUBSTR(JUBUN,7,1) IN('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1999)
                ELSE -1
            END "���糪��"
          -- �Ի���
         , HIREDATE "�Ի���"
          -- �޿�
         , SAL "�޿�"
    FROM TBL_SAWON
)T;
--==>> View VIEW_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON;
--==>>
/*
1001	����	    9409252234567	����	29	05/01/03	2053-01-03	6436	11095	3000	1500
1002	�躸��	    9809022234567	����	25	99/11/23	2057-11-23	8304	12880	2000	1000
1003	���̰�	    9810092234567	����	25	06/08/10	2057-08-10	5852	12775	4000	2000
1004	���α�	    9307131234567	����	30	98/05/13	2052-05-13	8863	10860	2000	1000
1005	������	    7008161234567	����	53	98/05/13	2029-05-13	8863	 2459	1000	 500
1006	������	    9309302234567	����	30	99/10/10	2052-10-10	8348	11010	3000	1500
1007	������	    0302064234567	����	20	10/10/23	2062-10-23	4317	14675	4000	2000
1008	�μ���	    6807102234567	����	55	98/03/20	2027-03-20	8917	 1674	1500	 750
1009	������	    6710261234567	����	56	98/03/20	2026-03-20	8917	 1309	1300	 650
1010	������	6511022234567	����	58	98/12/20	2024-12-20	8642	  854	2600	1300
1011	���켱	    0506174234567	����	18	11/10/10	2064-10-10	3965	15393	1300	 650
1012	���ù�	    0102033234567	����	22	10/10/10	2060-10-10	4330	13932	2400	1200
1013	����	    0210303234567	����	21	11/10/10	2061-10-10	3965	14297	2800	1400
1014	�ݺ���	    9903142234567	����	24	12/11/11	2058-11-11	3567	13233	5200	2600
1015	������	    9907292234567	����	24	12/11/11	2058-11-11	3567	13233	5200	2600
1016	���̰�	    0605063234567	����	17	15/01/20	2065-01-20	2767	15495	1500	 750
*/

SELECT *
FROM VIEW_SAWON
WHERE �ٹ��ϼ� >= 5000;
--==>>
/*
1001	����	    9409252234567	����	29	05/01/03	2053-01-03	6436	11095	3000	1500
1002	�躸��	    9809022234567	����	25	99/11/23	2057-11-23	8304	12880	2000	1000
1003	���̰�	    9810092234567	����	25	06/08/10	2057-08-10	5852	12775	4000	2000
1004	���α�	    9307131234567	����	30	98/05/13	2052-05-13	8863	10860	2000	1000
1005	������	    7008161234567	����	53	98/05/13	2029-05-13	8863	 2459	1000	 500
1006	������	    9309302234567	����	30	99/10/10	2052-10-10	8348	11010	3000	1500
1008	�μ���	    6807102234567	����	55	98/03/20	2027-03-20	8917	 1674	1500	 750
1009	������	    6710261234567	����	56	98/03/20	2026-03-20	8917	 1309	1300	 650
1010	������	6511022234567	����	58	98/12/20	2024-12-20	8642	  854	2600	1300
*/

SELECT *
FROM VIEW_SAWON
WHERE ���ʽ� >= 2000;
--==>>
/*
1003	���̰�	9810092234567	����	25	06/08/10	2057-08-10	5852	12775	4000	2000
1007	������	0302064234567	����	20	10/10/23	2062-10-23	4317	14675	4000	2000
1014	�ݺ���	9903142234567	����	24	12/11/11	2058-11-11	3567	13233	5200	2600
1015	������	9907292234567	����	24	12/11/11	2058-11-11	3567	13233	5200	2600
*/


--�� ���������� Ȱ���Ͽ�
--   TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�
/*
--------------------------------------------
  �����  ����  ���糪��  �޿�  ���̺��ʽ�
--------------------------------------------
*/
-- ��, ���̺��ʽ��� ���� ���̰� 40�� �̻��̸� �޿��� 70%
-- 30�� �̻� 40�� �̸��̸� �޿��� 50%
-- 20�� �̻� 30�� �̸��̸� �޿��� 30%�� �Ѵ�

-- ����, �̷��� �ϼ��� ��ȸ ������ ����
-- VIEW_SAWON2 ��� �̸��� ��(VIEW)�� ������ �� �ֵ��� �Ѵ�
CREATE OR REPLACE VIEW VIEW_SAWON2
AS
-- SELECT T2.�����, T2.����, T2.���糪��, T2.�޿�
SELECT T.*
     , CASE WHEN T2.���糪�� >= 40 THEN T2.�޿� * 0.7
            WHEN T2.���糪�� >= 30 THEN T2.�޿� * 0.5
            WHEN T2.���糪�� >= 20 THEN T2.�޿� * 0.3
            ELSE 0 
       END "���̺��ʽ�"
FROM
(   
    SELECT SANAME "�����"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE 0
           END "���糪��"
         , SAL "�޿�"
    FROM TBL_SAWON
)T2;
--==>> View VIEW_SAWON2��(��) �����Ǿ����ϴ�.

--�� ������ ��(VIEW) ��ȸ
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
����	    ����	29	3000	 900
�躸��	    ����	25	2000	 600
���̰�	    ����	25	4000	1200
���α�	    ����	30	2000	1000
������	    ����	53	1000	 700
������	    ����	30	3000	1500
������	    ����	20	4000	1200
�μ���      ����	55	1500	1050
������      ����	56	1300	 910
������	����	58	2600	1820
���켱	    ����	18	1300	   0
���ù�	    ����	22	2400	 720
����	    ����	21	2800	 840
�ݺ���	    ����	24	5200	1560
������	    ����	24	5200	1560
���̰�	    ����	17	1500	   0
*/

--------------------------------------------------------------------------------

--�� RANK() �� ���(����)�� ��ȯ�ϴ� �Լ�
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
--==>>
/*
7839	KING	10	5000	 1
7902	FORD	20	3000	 2
7788	SCOTT	20	3000	 2
7566	JONES	20	2975	 4 
7698	BLAKE	30	2850	 5 
7782	CLARK	10	2450	 6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500	 8
7934	MILLER	10	1300	 9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	 950	13
7369	SMITH	20	 800	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 6
7934	MILLER	10	1300	3	 9
7902	FORD	20	3000	1 	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	3	 4 
7876	ADAMS	20	1100	4	12
7369	SMITH	20	 800	5	14
7698	BLAKE	30	2850	1	 5
7499	ALLEN	30	1600	2	 7
7844	TURNER	30	1500	3	 8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	 950	6	13
*/


--�� DENSE_RANK() �� ������ ��ȯ�ϴ� �Լ�
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"     
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"     
FROM EMP
ORDER BY 3, 4 DESC;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 5
7934	MILLER	10	1300	3	 8
7902	FORD	20	3000	1 	 2
7788	SCOTT	20	3000	1 	 2
7566	JONES	20	2975	2	 3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12
7698	BLAKE	30	2850	1	 4
7499	ALLEN	30	1600	2	 6
7844	TURNER	30	1500	3	 7
7654	MARTIN	30	1250	4	 9
7521	WARD	30	1250	4	 9
7900	JAMES	30	 950	5	11
*/


--�� EMP ���̺��� ��� �����͸�
--   �����, �μ���ȣ, ����, �μ�����������, ��ü�������� �׸����� ��ȸ
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ�����������"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü��������"
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
KING	10	60000	1	 1
CLARK	10	29400	2	 6
MILLER	10	15600	3	10
FORD	20	36000	1	 2
SCOTT	20	36000	1 	 2
JONES	20	35700	3	 4  
ADAMS	20	13200	4	12
SMITH	20	 9600	5	14
BLAKE	30	34200	1	 5
ALLEN	30	19500	2	 7
TURNER	30	18000	3	 8
MARTIN	30	16400	4	 9
WARD	30	15500	5	11
JAMES	30	11400	6	13
*/

SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ�����������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
    FROM EMP
) T;
--==>>
/*
KING	10	60000	1	 1
FORD	20	36000	1 	 2
SCOTT	20	36000	1	 2
JONES	20	35700	3	 4
BLAKE	30	34200	1	 5
CLARK	10	29400	2	 6
ALLEN	30	19500	2	 7
TURNER	30	18000	3	 8
MARTIN	30	16400	4	 9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	 9600	5	14
*/

--�� EMP ���̺��� ��ü ���� ����(���)�� 1����� 5�������
--   �����, �μ���ȣ, ����, ��ü�������� �׸����� ��ȸ
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) "��ü��������"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM,0)) <= 5
ORDER BY DEPTNO;
--==>> �����߻�
--     ORA-30483: window  functions are not allowed here

--�� ���� ������ RANK() OVER() �Լ��� WHERE ���������� ����� ����̸�
--   �� �Լ��� WHERE ���������� ����� �� ���� ������ �߻��ϴ� �����̴�
--   �� ���, �츮�� INLINE VIEW �� Ȱ���ؼ� Ǯ���ؾ� �Ѵ�

SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü��������"
    FROM EMP
) T
WHERE T.��ü�������� <= 5;
--==>>
/*
MILLER	10	15600	5
SMITH	20	 9600	1
ADAMS	20	13200	3
WARD	30	15500	4
JAMES	30	11400	2
*/


--�� EMP ���̺��� �� �μ����� ���� ����� 1�� ���� 2�� ������ ��ȸ�Ѵ�
--   �����, �μ���ȣ, ����, �μ����������, ��ü�������
--   �׸��� ��ȸ�� �� �ֵ��� �Ѵ�

-- 1�ܰ�
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ����������"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü�������"
FROM EMP
ORDER BY DEPTNO;

-- 2�ܰ� - 1
SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ����������"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü�������"
    FROM EMP
) T
WHERE T.�μ���������� IN(1,2);
/*
KING	10	60000	1	1
FORD	20	36000	1	2
SCOTT	20	36000	1	2
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
*/

-- 2�ܰ� - 2
SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ����������"
     , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü�������"
    FROM EMP
) T
WHERE T.�μ���������� <= 2;
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
FORD	20	36000	1	2
SCOTT	20	36000	1	2
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
*/


--------------------------------------------------------------------------------
-- ���� �׷� �Լ� ����--
-- SUM() ��, AVG() ���, COUNT() ī��Ʈ, MAX() �ִ밪, MIN() �ּҰ�
-- , VARIENCE() �л�, STDDEV() ǥ������

--�� �׷� �Լ��� ���� ū Ư¡
--   ó���ؾ� �� �����͵� �� NULL �� �����Ѵٸ�(���ԵǾ� �ִٸ�)
--   �� NULL �� ������ ���·� ������ �����Ѵٴ� ���̴�.
--   ��, NULL �� ������ ��󿡼� ���ܵȴ�


--�� SUM() ��
--   EMP ���̺��� ������� ��ü ������� �޿� ������ ��ȸ
SELECT SAL
FROM EMP;
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
*/
SELECT SUM(SAL)  -- 800 + 1600 + 1250 + ... + 1300
FROM EMP;
--==>> 29025

SELECT COMM
FROM EMP;
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
*/

SELECT SUM(COMM) -- NULL + 300 + 500 + ... + NULL �� SUM�� �̷��� �۵��Ǵ°� �ƴϴ�
--                                                �� NULL�� ���ܵǰ� ���ȴ�
FROM EMP;
--==>> 2200


--�� COUNT() ��(���ڵ�)�� ���� ��ȸ �� �����Ͱ� �� ������ Ȯ��
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- �� NULL �� �����ϰ� ��ȸ�ǹǷ� ����!!
FROM EMP;
--==>> 4

SELECT COUNT(*)     -- �� �̷����ϸ� ���ڵ忡 ���� �ֵ� ��ȯ�ϹǷ� ����ص� ��
FROM EMP;
--==>> 14


--�� AVG() ��� ��ȯ
SELECT AVG(SAL) "COL1"
     , SUM(SAL) / COUNT(SAL) "COL2"
FROM EMP;
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/

SELECT AVG(COMM) "COL1"
     , SUM(COMM) / COUNT(COMM) "COL2"
FROM EMP;
--==>> 550	550

SELECT COMM
FROM EMP;

SELECT 2200 / 14 "RESULT"
FROM DUAL;
--==>> 157.142857142857142857142857142857142857


--�� �����Ͱ� NULL �� �÷��� ���ڵ�� ���� ��󿡼� ���ܵǱ� ������
--   �����Ͽ� ���� ó���ؾ� �Ѵ�



-- VARIANCE(), STDDEV()
--�� ǥ�������� ������ �л�, �л��� �������� ǥ������
SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
/*
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2) "COL1"
     , VARIANCE(SAL) "COL2"
FROM EMP;
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/


SELECT SQRT(VARIANCE(SAL)) "COL1"
     , STDDEV(SAL) "COL2"
FROM EMP;
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


--�� MAX(), MIN()
--   �ִ밪, �ּҰ� ��ȯ
SELECT MAX(SAL) "COL1"
     , MIN(SAL) "COL2"
FROM EMP;
--==>> 5000     800


--�� ����
SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> �����߻�
--     ORA-00937: not a single-group group function
-- ��(���ڵ�)�� ������ �ٸ��� ������(?)


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
--==>>
/*
10	8750
20	10875
30	9400
*/

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
/*
10	2450
10	5000
10	1300
20	2975
20	3000
20	1100
20	800
20	3000
30	1250
30	1500
30	1600
30	950
30	2850
30	1250
*/

-- ���� �ǽ� ���̺� ����
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

-- ���ο� �ǽ� ���̺� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� �ǽ�
INSERT INTO TBL_EMP VALUES
(8001, '���¹�', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8002, '������', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8003, '�躸��', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8004, '������', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8005, '������', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	80/12/17	 800		    20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	 300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	 500	30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7788	SCOTT	ANALYST	    7566	87/07/13	3000	    	20
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	   0	30
7876	ADAMS	CLERK	    7788	87/07/13	1100		    20
7900	JAMES	CLERK	    7698	81/12/03	 950		    30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
8001	���¹�	CLERK	    7566	22/08/18	1500	        10	
8002	������	CLERK	    7566	22/08/18	2000	        10	
8003	�躸��	SALESMAN	7698	22/08/18	1700		
8004	������	SALESMAN	7698	22/08/18	2500		
8005	������	SALESMAN	7698	22/08/18	1000		
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
20	 800	
	1700	
	1000	
10	1300	
20	2975	
30	2850	
10	2450	
20	3000	
10	5000	
	2500	
20	1100	
30	 950	
20	3000	
30	1250	1400
30	1250	 500
30	1600	 300
	1500	  10
	2000	  10
30	1500	   0  
*/

--�� ����Ŭ������ NULL �� ���� ū ������ �����Ѵ�
--   (ORACLE 9i ������ NULL �� ���� ���� ������ �����߾���)
--   MSSQL �� NULL �� ���� ���� ������ �����Ѵ�


--�� TBL_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
--   �μ���ȣ, �޿��� �׸� ��ȸ
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	 8750
20	10875
30	 9400
	 8700        -- �μ���ȣ�� NULL �� ������� �޿���
*/


SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	 8750
20	10875
30	 9400
	 8700      -- �μ���ȣ�� NULL �� �������� �޿���
	37725      -- ��� �μ� �������� �޿���
*/


SELECT NVL(DEPTNO, '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>> �����߻�
--     ORA-01722: invalid number

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>> 
/*
10	         8750
20	        10875
30	         9400
���μ�	29025
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>> 
/*
10	         8750
20	        10875
30	         9400
���μ�	29025
*/

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
-- ���μ��� �� ������ ������ ������ �߻�
/*
10	         8750
20	        10875
30	         9400
���μ�	 8700
���μ�	37725
*/

-- GROUPING()
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
  GROUPING  �μ���ȣ      �޿���
---------- ---------- ----------
         0         10       8750
         0         20      10875
         0         30       9400
         0     (null)       8700
         1     (null)      37725
*/


SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	 8750
20	10875
30	 9400
	 8700
	37725
*/

--�� ������ ��ȸ�� �ش� ������
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/
-- �̿� ���� ��ȸ�ǵ��� �������� �����϶�
--�� ����
-- GROUPING()
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
  GROUPING  �μ���ȣ      �޿���
---------- ---------- ----------
         0         10       8750
         0         20      10875
         0         30       9400
         0     (null)       8700
         1     (null)      37725
*/
--�� ��Ʈ
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN '���Ϻμ�' ELSE '���μ�' END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
���Ϻμ�	 8750
���Ϻμ�	10875
���Ϻμ�	 9400
���Ϻμ�	 8700
���μ�	37725
*/

/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO
                             ELSE '���μ�' 
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> ���� �߻�
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
--     ����Ÿ�԰� ����Ÿ���� ��� �ֱ� ����

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
                             ELSE '���μ�' 
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	         8750
20	        10875
30	         9400
(null)       8700
���μ�	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                             ELSE '���μ�' 
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/


SELECT CASE WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 0 THEN '����'
            WHEN DEPTNO IS NULL AND GROUPING(DEPTNO) = 1 THEN '���μ�'
            ELSE TO_CHAR(DEPTNO)
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	     8700
���μ�	37725
*/