--�� LPAD()
--   Byte �� Ȯ���Ͽ� ���ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
     , LPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--> 1. 10Byte ������ Ȯ���Ѵ�.                       �� �� ��° �Ķ���� ���� ����
--  2. Ȯ���� ������ 'ORACLE' �̶�� ���ڿ��� ��´� �� ù ��° �Ķ���� ���� ����
--  3. �����ִ� Byte ������ ���ʺ��� �� ��° �Ķ���� ������ ä���
--  4. �̷��� ������ ���� ������� ��ȯ�Ѵ�
--==>> ORACLE	****ORACLE

--�� RPAD()
--   Byte �� Ȯ���Ͽ� �����ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
     , RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--> 1. 10Byte ������ Ȯ���Ѵ�.                       �� �� ��° �Ķ���� ���� ����
--  2. Ȯ���� ������ 'ORACLE' �̶�� ���ڿ��� ��´� �� ù ��° �Ķ���� ���� ����
--  3. �����ִ� Byte ������ �����ʺ��� �� ��° �Ķ���� ������ ä���
--  4. �̷��� ������ ���� ������� ��ȯ�Ѵ�
--==>> ORACLE	ORACLE****


--�� TRIM()
SELECT TRIM('    TEST    ') "RESULT"
FROM DUAL;
--==>> TEST

--�� LTRIM()
SELECT 'ORAORAORAORACLEORACLE' "COL1" -- ���� ���� ���� ����Ŭ ����Ŭ
     , LTRIM('ORAORAORAORACLEORACLE', 'ORA') "COL2"
     , LTRIM('AAAAAAORAORACLEORACLE', 'ORA') "COL3"
     , LTRIM('ORAORAoRAORACLEORACLE', 'ORA') "COL4"     -- ��ҹ���
     , LTRIM('ORAORA ORAORACLEORACLE', 'ORA') "COL5"    -- ����
     , LTRIM('                ORACLE', ' ') "COL6"      -- ����
     , LTRIM('                ORACLE') "COL7"           -- ������ �� ��° �Ķ���� ���� ����
FROM DUAL;
--> ������� ������ ��!!
--  �� ��° �Ķ���Ͱ� ORA ��� �ؼ�
--  ù ��° �Ķ���͸� ORA ������ �ڸ��°� �ƴ϶�
--  O �ڸ��� R �ڸ��� A �ڸ��� �ٸ� ����(C)�� ������ �� �ڸ��� ������ ������ ����Ѵ�
--  (�����̷� �ڸ��°� �ƴ϶�� ��)

--  COL3 �� ���� �� ���ذ� ����
--  ORA�� �������� A�� ���� �ϳ��ϳ� �߶󳪰��� ������ COL2�� COL3�� ���� ������� ���

--  ��ҹ��ڸ� �����ϸ� �ڸ�
--  ���鵵 ������
--  ������ �� ��° �Ķ���� ���� ����

--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  ���ʺ��� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
--  ���� ���ڰ� ������ ��� �̸� ������ ������� ��ȯ�Ѵ�
--  ��, �ϼ������� ó������ �ʴ´�
--==>>
/*
ORAORAORAORACLEORACLE	
CLEORACLE	
CLEORACLE	
oRAORACLEORACLE	 
ORAORACLEORACLE	
ORACLE	
ORACLE
*/

SELECT LTRIM('����̱���̱���̱��������̽ŽŽŹ��̱��', '�����') "COL1"
FROM DUAL;
--==>> ���̱��

--�� RTRIM()
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  �����ʺ��� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
--  ���� ���ڰ� ������ ��� �̸� ������ ������� ��ȯ�Ѵ�
--  ��, �ϼ������� ó������ �ʴ´�



--�� TRANSLATE()
--> 1:1 �� �ٲ��ش�
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "COL1"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-1234-5678'
                , '0123456789'
                , '�����̻�����ĥ�ȱ�') "COL1"
FROM DUAL;
--==>> ���ϰ�-���̻��-����ĥ��

--�� REPLACE()
SELECT REPLACE('MY ORACLE SERVER ORAHOME', 'ORA', '����') "COL1"
FROM DUAL;
--==>> MY ����CLE SERVER ����HOME

--------------------------------------------------------------------------------

--�� ROUND() �ݿø��� ó���� �ִ� �Լ�
SELECT 48.678 "COL1"              -- 48.678
     , ROUND(48.678, 2) "COL2"    -- 48.68    -- �� ��° �Ķ���� : �Ҽ��� ���� �� ° �ڸ����� ǥ��
     , ROUND(48.674, 2) "COL3"    -- 48.67
     , ROUND(48.674, 1) "COL4"    -- 48.7
     , ROUND(48.674, 0) "COL5"    -- 49
     , ROUND(48.674) "COL6"       -- 49       -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
     , ROUND(48.674, -1) "COL7"   -- 50
     , ROUND(48.674, -2) "COL8"   -- 0
     , ROUND(48.674, -3) "COL9"   -- 0
FROM DUAL;


--�� TRUNC() ������ ó���� �ִ� �Լ�
SELECT 48.678 "COL1"               -- 48.678
     , TRUNC(48.678, 2) "COL2"     -- 48.67    -- �� ��° �Ķ���� : �Ҽ��� ���� �� ° �ڸ����� ǥ��
     , TRUNC(48.674, 2) "COL3"     -- 48.67
     , TRUNC(48.674, 1) "COL4"     -- 48.6
     , TRUNC(48.674, 0) "COL5"     -- 48
     , TRUNC(48.674) "COL6"        -- 48       -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
     , TRUNC(48.678, -1) "COL7"    -- 40
     , TRUNC(48.678, -2) "COL8"    -- 0
     , TRUNC(48.678, -3) "COL9"    -- 0
FROM DUAL;


--�� MOD() �������� ��ȯ�ϴ� �Լ� �� %
SELECT MOD(5, 2) "COL1"
FROM DUAL;
--> 5�� 2�� ���� ������ ����� ��ȯ
--==>> 1

--�� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5, 3) "COL1"
FROM DUAL;
--> 5�� 3���� ��������� ��ȯ
--==>> 125


--�� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2) "COL1"
FROM DUAL;
--> ��Ʈ 2 �� ���� ����� ��ȯ
--==>> 1.41421356237309504880168872420969807857


--�� LOG() �α� �Լ�
--   ����Ŭ�� �ڿ��α�, ���α� ��� �����Ѵ�
--   �ڿ��α�
SELECT LN(95) "RESULT"
FROM DUAL;
--==>> 4.55387689160054083460978676511404117675

--   ���α�
SELECT LOG(10, 100) "COL1"
     , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677

--�� �ﰢ�Լ�
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
--> ���� ����, �ڻ���, ź��Ʈ ������� ��ȯ�Ѵ�


--�� �ﰢ�Լ��� ���Լ�(���� : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>> 
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/
--> ���� �����, ���ڻ���, ��ź��Ʈ ������� ��ȯ�Ѵ�


--�� SIGN() ����, ��ȣ, Ư¡
--   ���� ������� ����̸� 1, 0�̸� 0, �����̸� -1 �� ��ȯ�Ѵ�
SELECT SIGN(5-2) "COL1"
     , SIGN(5-5) "COL2"
     , SIGN(5-7) "COL3"
FROM DUAL;
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ�� �� ���� ���ȴ�
--==>> 
/*
1   : ������� 3(���) �̹Ƿ� 1�� ��ȯ
0	: ������� 0 �̹Ƿ� 0�� ��ȯ
-1  : ������� -2(����) �̹Ƿ� -1�� ��ȯ
*/

--�� ASCII(), CHR() �� ���� ����(����)�ϴ� �Լ�
SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A
--> ASCII() : �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�
--  CHR()   : �Ű������� �Ѱܹ��� �ƽ�Ű�ڵ� ������ �ش� ���ڸ� ��ȯ�Ѵ�

--------------------------------------------------------------------------------

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ��¥ ������ �⺻ ������ �ϼ�(DAY) �̴�!! CHECK~!!
SELECT SYSDATE "COL1"       -- 2022-08-17 11:13:57
     , SYSDATE +1 "COL2"    -- 2022-08-18 11:13:57
     , SYSDATE -2 "COL3"    -- 2022-08-15 11:13:57
     , SYSDATE +30 "COL4"   -- 2022-09-16 11:13:57
FROM DUAL;

--�� �ð� ���� ����
SELECT SYSDATE "COL1"           -- 2022-08-17 11:15:39
     , SYSDATE + 1/24 "COL2"    -- 2022-08-17 12:15:39
     , SYSDATE - 2/24 "COL3"    -- 2022-08-17 09:15:39
FROM DUAL;

--�� ���� �ð��� ���� �ð� ���� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ
SELECT SYSDATE "COL1"                                                            -- 2022-08-17 11:18:09
     , SYSDATE + 1 + 2/24 + 3/1440 + 4/86400 "COL2"                              -- 2022-08-18 13:21:13
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "COL3"                -- 2022-08-18 13:21:13
     , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "COL4"     -- 2022-08-18 13:21:13
FROM DUAL;


--�� ��¥ - ��¥ �� �ϼ�
SELECT TO_DATE('2023-01-16', 'YYYY-MM-DD') - TO_DATE('2022-06-27', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 203

--�۵����� Ÿ���� ��ȯ
SELECT TO_DATE('2022-08-17', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 2022-08-17 00:00:00

SELECT TO_DATE('2022-08-32', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> ���� �߻� 
--     ORA-01847: day of month must be between 1 and last day of month

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01839: date not valid for month specified

SELECT TO_DATE('2022-13-17', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01843: not a valid month

--�� TO_DATE() �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� �����ϴ� ��������
--   ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������

--�� ADD_MONTHS() ���� ���� �����ִ� �Լ�
SELECT SYSDATE "COL1"                    -- 2022-08-17 11:36:23
     , ADD_MONTHS(SYSDATE, 2) "COL2"     -- 2022-10-17 11:36:23
     , ADD_MONTHS(SYSDATE, 3) "COL3"     -- 2022-11-17 11:36:23
     , ADD_MONTHS(SYSDATE, -2) "COL4"    -- 2022-06-17 11:36:23
FROM DUAL;


--�� MONTHS_BETWEEN()
--   ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ�Ѵ� �� ���� : ���� ��
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "COL1"
FROM DUAL;
--==>> 242.564094982078853046594982078853046595

--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
--  ������� ��ȣ�� -(����)�� ��ȯ�Ǿ��� ��쿡��
--  ù ��° ���ڰ��� �ش��ϴ� ��¥����
--  �� ��° ���ڰ��� �ش��ϴ� ��¥�� �̷� ��� �ǹ̷� Ȯ���� �� �ִ�


--�� NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '��') "COL1"
     , NEXT_DAY(SYSDATE, '��') "COL2"
FROM DUAL;
--> ���� ��¥�� �������� ���� ���� ���ƿ��� �� ��° �Ķ���� ���� ������ �������� �˷��ִ� �Լ�
--==>>
/*
2022-08-20 11:44:18	
2022-08-22 11:44:18
*/

--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.

-- ��¥ ���� �� ����� �ٲٰ� �ٽ� ��ȸ
SELECT NEXT_DAY(SYSDATE, '��') "COL1"
     , NEXT_DAY(SYSDATE, '��') "COL2"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01846: not a valid day of the week

-- �� ��° �Ķ���� ������ ����� �ٲٰ� ��ȸ
SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;

--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- ��¥ ���� �� �ѱ۷� �ٲٰ� �ٽ� ��ȸ
SELECT NEXT_DAY(SYSDATE, '��') "COL1"
     , NEXT_DAY(SYSDATE, '��') "COL2"
FROM DUAL;


--�� LAST_DAY()
-->  �ش� ��¥�� ���ԵǾ� �ִ� �� ���� ������ ���� ��ȯ�Ѵ�
SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
     , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL3"
FROM DUAL;
--==>>
/*
2022-08-31	
2020-02-29	
2019-02-28
*/

--�� ���úη�... �¹��̰� ���뿡 �ٽ� ���� ����..
--   ���� �Ⱓ�� 22������ �Ѵ�

-- 1. ���� ���ڸ� ���Ѵ�
SELECT SYSDATE "COL1"
     , ADD_MONTHS(SYSDATE, 22) "COL2"
FROM DUAL;
--==>> 2024-06-17

-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �Ѵٰ� �����ϸ�
--    �¹��̰� �� ���� �Ծ�� ���� �����ٱ�
--    (���� ���� - �Դ� ����) * 3
SELECT SYSDATE "���� �ð�"
     , ADD_MONTHS(SYSDATE, 22) "���¹� ������"
     , (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3 "�Ļ� Ƚ��"
FROM DUAL;

--�� ���� ��¥ �� �ð����κ���
--   ������(2023-01-16 18:00:00) ����
--   ���� �Ⱓ��... ������ ���� ���·� ��ȸ�� �� �ֵ��� �������� �����Ѵ�
/*
-------------------- -------------------- ---- ----- --- ---
����ð�             ������               ��   �ð�  ��  ��
-------------------- -------------------- ---- ----- --- ---
2022-08-17 14:55:30  2023-01-16 18:00:00  152     3   4  30
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- ��� 1 �밡��...
SELECT SYSDATE "����ð�"
     , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
     
     -- ������ - ���ó�¥�� �Ҽ��� ���� ���� = �ϼ�
     , TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE), 0) "��"
     
     -- [(������ - ���ó�¥) - ������(������ - ���ó�¥)] �� *24 = ���� ���� �ð�
     -- �ϼ��� �Ҽ����� *24�� �� ��
     -- ���� ���� �ð��� �����ϸ� = �ð�
     , TRUNC(
                ( TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                    - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                ) *24
         , 0) "�ð�"
     
     -- [(������ - ���ó�¥) - ������(������ - ���ó�¥)] �� *24 �� ���� ���� �ð�
     --   - [(������-���糯¥) - ������(������ - ���ó�¥)] �� *24 �� ������ �ð� = �ð�
     -- ���� ���� �ð� - �ð�  �� *60 �ϸ� = ���� ���� ��
     -- ���� ���� ���� �����ϸ� = ��
     , TRUNC(
                (
                    (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                       - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                    ) *24 
                       - TRUNC(
                                 (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                    - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                                 ) *24
                              ) 
                ) *60
         , 0) "��"

     -- ��
     , ROUND(
                (
                    (
                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                           - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                        ) *24
                            - TRUNC(
                                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                           - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
                                        ) *24
                                    )
                     ) *60
                        - TRUNC(
                                    (
                                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                            - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
                                        ) *24
                                            - TRUNC(
                                                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                                            - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
                                                        )*24
                                                    )
                                    )*60
                                )
                ) *60
         , 0) "��"
FROM DUAL;

-- ��Ʈ
-- 1�� 2�ð� 3�� 4�� �� "��" �� ȯ���ϸ�
SELECT (1��) + (2�ð�) + (3��) + (4��)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- ��93784�ʡ���... �ٽ� ��, �ð�, ��, �ʷ� ȯ���ϸ�...
SELECT MOD(93784, 60) "��"
     , MOD(TRUNC(93784/60), 60) "��"
     , MOD(TRUNC(93784/60/60), 24) "�ð�"
     , TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "��"
FROM DUAL;
--==>> 4	3	2	1

-- ��� 2
SELECT MOD(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60) "��"
     , MOD(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "��"
     , MOD(TRUNC(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "�ð�"
     , TRUNC(TRUNC(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24) "�ϼ�"
     , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
     , SYSDATE "���� �ð�"
FROM DUAL;

-- ��� 3
SELECT  SYSDATE "���� �ð�"
     , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
     , TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "��"
     , TRUNC(MOD((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24, 24)) "��"
     , TRUNC(MOD((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24*60, 60)) "��"
     , TRUNC(MOD((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24*60*60, 60)) "��"
FROM DUAL;


-- �ش�
-- �����ϱ��� ���� �Ⱓ Ȯ�� (���� : �ϼ�)
SELECT �������� - ��������
FROM DUAL;

SELECT TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 152.09849537037037037037037037037037037

-- �����ϱ��� ���� �Ⱓ Ȯ�� (���� : ��)
SELECT (�����Ⱓ) * (�Ϸ縦�����ϴ���ü��)
FROM DUAL;

SELECT (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 13141117.99999999999999999999999999999999

-- ���� ���� ��ȣ�� �־
SELECT ( (�����Ⱓ) * (�Ϸ縦�����ϴ���ü��) )
FROM DUAL;

SELECT ((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))
FROM DUAL;

-- ��Ʈ ������ "��" �ڸ��� �ֱ�
SELECT TRUNC(MOD(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60)) "��"
     , MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60), 60) "��"
     , MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60/60), 24) "�ð�"
     , TRUNC(TRUNC(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60)/24) "��"
FROM DUAL;


--�� ���� �¾ ��¥ �� �ð����κ���...�������
--   �󸶸�ŭ�� �ð��� ��� �ִ���..
--   ������ ���� ���·� ��ȸ�� �� �ֵ��� �������� �����Ѵ�
/*
-------------------- -------------------- ------ ----- ---- ----
����ð�             �������                 ��  �ð�  ��   ��
-------------------- -------------------- ------ ----- ---- ----
2022-08-17 16:04:34  1993-07-13 10:45:00  10627     5   19   34
*/
-- ������Ϻ��� ���ݱ��� ���� �Ⱓ Ȯ�� (���� : �ϼ�)
SELECT �������� - �������
FROM DUAL;

SELECT SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 10627.2135185185185185185185185185185185

-- ������Ϻ��� ���ݱ��� ���� �Ⱓ Ȯ�� (���� : ��)
SELECT (�����Ⱓ) * (�Ϸ縦�����ϴ���ü��)
FROM DUAL;

SELECT (SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)
FROM DUAL;
--==>> 918191331.000000000000000000000000000003

-- ���� ���� ��ȣ�� �־
SELECT ( (�����Ⱓ) * (�Ϸ縦�����ϴ���ü��) )
FROM DUAL;

SELECT ((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))
FROM DUAL;

-- ��Ʈ ������ "��" �ڸ��� �ֱ�
SELECT TRUNC(MOD(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)), 60)) "��"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60), 60) "��"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60/60), 24) "�ð�"
     , TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60)/60)/24) "��"
     , TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS') "�������"
     , SYSDATE "����ð�"
FROM DUAL;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

--�� ��¥ �����͸� ������� �ݿø�, ���� ���� ������ ������ �� �ִ�

--�� ��¥ �ݿø�
SELECT SYSDATE "COL1"               -- 2022-08-17   ��  �⺻ ���� ��¥
    ,  ROUND(SYSDATE, 'YEAR')"COL2" -- 2023-01-01   ��  �������� ��ȿ�� ������(��ݱ� / �Ϲݱ� ����)
    ,  ROUND(SYSDATE, 'MONTH')"COL3"-- 2022-09-01   ��  ������ ��ȿ�� ������(15�� ����)
    ,  ROUND(SYSDATE, 'DD') "COL4"  -- 2022-08-18   ��  �ϱ��� ��ȿ�� ������(���� ����)
    ,  ROUND(SYSDATE, 'DAY')"COL5"  -- 2022-08-21   ��  �ϱ��� ��ȿ�� ������(������ ���� ����)
FROM DUAL;

--�� ��¥ ����
SELECT SYSDATE "COL1"               -- 2022-08-17   ��  �⺻ ���� ��¥
    ,  TRUNC(SYSDATE, 'YEAR')"COL2" -- 2022-01-01   ��  �������� ��ȿ�� ������
    ,  TRUNC(SYSDATE, 'MONTH')"COL3"-- 2022-08-01   ��  ������ ��ȿ�� ������
    ,  TRUNC(SYSDATE, 'DD') "COL4"  -- 2022-08-17   ��  �ϱ��� ��ȿ�� ������
    ,  TRUNC(SYSDATE, 'DAY')"COL5"  -- 2022-08-14   ��  �� �� �ֿ� �ش��ϴ� �Ͽ���
FROM DUAL;

--------------------------------------------------------------------------------
--���� ��ȯ �Լ� ����--

-- TO_CHAR()    : ���ڳ� ��¥ �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_DATE()    : ���� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_NUMBER()  : ���� �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�

--�� ��¥�� �� ������
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"    -- 2022-08-17
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"          -- 2022
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"          -- TWENTY TWENTY-TWO
     , TO_CHAR(SYSDATE, 'MM') "COL4"            -- 08
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"         -- 8�� 
     , TO_CHAR(SYSDATE, 'MON') "COL6"           -- 8�� 
     , TO_CHAR(SYSDATE, 'DD') "COL7"            -- 17
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"         -- 08-17
     , TO_CHAR(SYSDATE, 'DAY') "COL9"           -- ������
     , TO_CHAR(SYSDATE, 'DY') "COL10"           -- ��
     , TO_CHAR(SYSDATE, 'HH24') "COL11"         -- 17
     , TO_CHAR(SYSDATE, 'HH') "COL12"           -- 05
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"        -- 05 ����
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"        -- 05 ����
     , TO_CHAR(SYSDATE, 'MI') "COL15"           -- 11
     , TO_CHAR(SYSDATE, 'SS') "COL16"           -- 20
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"        -- 62464    ���� ����(00:00)���� ����ð����� �ʷ� ǥ��
     , TO_CHAR(SYSDATE, 'Q') "COL18"            -- 3        8���̶� 3�б�
FROM DUAL;

--�� ��¥�� ��ȭ ������ ���� ���� ���...
--   �������� ���� ������ ������ �� �ִ�

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\'; -- \ �� �� �̴�.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--�� ������ ������
SELECT 7 "COL1"
     , '7' "COL2"
     , TO_CHAR(7) "COL3"
FROM DUAL;
--> ��ȸ ����� ���� �������� ���� �������� Ȯ��~

SELECT TO_NUMBER('4') "COL1"
     , '4' "COL2"
     , 4 "COL3"
     , TO_NUMBER('04') "COL4"
FROM DUAL;
--==>> 4	4	4	4
--> ��ȸ ����� ���� �������� ���� �������� Ȯ��~


--�� ���� ��¥���� ���� �⵵(2022)�� ���� ���·� ��ȸ(��ȯ)
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) "RESULT"
FROM DUAL;
--==>> 2022
--> ��ȸ ����� ���� �������� ���� �������� Ȯ��~


--�� EXTRACT()   
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"      -- 2022(������)    �� ������ �����Ͽ� ���� Ÿ������
     , TO_CHAR(SYSDATE, 'MM') "COL2"        -- 08(������)      �� ���� �����Ͽ� ���� Ÿ������
     , TO_CHAR(SYSDATE, 'DD') "COL3"        -- 17(������)      �� ���� �����Ͽ� ���� Ÿ������
     , EXTRACT(YEAR FROM SYSDATE) "COL4"    -- 2022(������)    �� ������ �����Ͽ� ���� Ÿ������
     , EXTRACT(MONTH FROM SYSDATE) "COL5"   -- 8(������)       �� ���� �����Ͽ� ���� Ÿ������
     , EXTRACT(DAY FROM SYSDATE) "COL6"     -- 17(������)      �� ���� �����Ͽ� ���� Ÿ������
FROM DUAL;
--> EXTRACT()�� ��, ��, �� �̿��� �ٸ� �׸��� �Ұ�


--�� TO_CHAR() Ȱ�� �� ���� ���� ǥ�� ����� ��ȯ
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"  -- ȭ����� ǥ��
     , TO_CHAR(60000, '$99,999') "COL3" -- $ ǥ��
     , TO_CHAR(60000, 'L99,999') "COL4" -- �� ǥ�� �� ȭ�� ��ȣ�� ���󸶴� �ٸ��Ƿ� ���ʿ� ������ �ִ�
     , LTRIM(TO_CHAR(60000, 'L99,999')) "COL5" --  �� �׷��Ƿ� LTRIM()�� �̿��� ���� ������ ���� �� �ִ� 
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� ���� �ð��� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�

SELECT SYSDATE "����ð�"
     , SYSDATE + 1 "1����"
     , SYSDATE + 1 + (2/24) "1��2�ð���"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) "1��2�ð�3����"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1��2�ð�3��4����"
FROM DUAL;
--==>>
/*
2022-08-17 17:43:55	
2022-08-18 17:43:55	
2022-08-18 19:43:55	
2022-08-18 19:46:55	
2022-08-18 19:46:59
*/

--�� ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6�� �ĸ� ��ȸ
--   TO_YMINTERVAL()   �� YearMonth ��~�� ������ ����
--   TO_DSINTERVAL()   �� DaySeconds ��~�� ������ ����
SELECT SYSDATE "����ð�"
     , SYSDATE + TO_YMINTERVAL('01-00') + TO_DSINTERVAL('003 04:05:06') "������"
FROM DUAL;
--==>> 2022-08-17 17:47:57
--     2023-10-20 21:53:03
--------------------------------------------------------------------------------







