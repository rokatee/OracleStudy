SELECT USER
FROM DUAL;
--==>> SCOTT  

--���� UNION / UNION ALL ����--

--�� �ǽ� ���̺� ����(TBL_JUMUN)
CREATE TABLE TBL_JUMUN              -- �ֹ� ���̺� ����
( JUNO      NUMBER                  -- �ֹ� ��ȣ
, JECODE    VARCHAR2(30)            -- ��ǰ �ڵ�
, JUSU      NUMBER                  -- �ֹ� ����
, JUDAY     DATE DEFAULT SYSDATE    -- �ֹ� ����
);
--==>> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
--> ���� �ֹ��� �߻�(����)�Ǿ��� ���
--  �ֹ� ���뿡 ���� �����Ͱ� �Էµ� �� �ֵ��� ó���ϴ� ���̺�

--�� ������ �Է� �� ���� �ֹ� �߻�(����)
INSERT INTO TBL_JUMUN
VALUES(1, 'ġ�佺', 20, TO_DATE('2001-11-01 09:10:12', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(2, '������', 10, TO_DATE('2001-11-01 10:10:12', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(3, '������', 30, TO_DATE('2001-11-01 13:10:20', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(4, '������', 10, TO_DATE('2001-11-02 11:11:11', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(5, '��īĨ', 20, TO_DATE('2001-11-02 17:50:11', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(6, '�Ҹ���', 10, TO_DATE('2001-11-03 10:00:10', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(7, '���ڱ�', 20, TO_DATE('2001-11-04 05:05:05', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(8, '��ǹ�', 20, TO_DATE('2001-11-04 06:07:08', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(9, '�����', 10, TO_DATE('2001-11-05 13:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(10, '����Ĩ', 20, TO_DATE('2001-11-05 14:10:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(11, 'Ȩ����', 10, TO_DATE('2001-11-05 15:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(12, 'Ȩ����', 10, TO_DATE('2001-11-05 15:10:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(13, '����Ĩ', 20, TO_DATE('2001-11-06 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(14, '������', 10, TO_DATE('2001-11-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(15, '������', 20, TO_DATE('2001-11-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(16, '����ƽ', 10, TO_DATE('2001-11-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(17, '������', 20, TO_DATE('2001-11-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(18, 'Ȩ����', 10, TO_DATE('2001-11-11 15:10:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(19, '����ƽ', 10, TO_DATE('2001-11-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );

INSERT INTO TBL_JUMUN
VALUES(20, '����ƽ', 20, TO_DATE('2001-11-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS') );
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 20

--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>> 
/*
1	ġ�佺	20	2001-11-01 09:10:12
2	������	10	2001-11-01 10:10:12
3	������	30	2001-11-01 13:10:20
4	������	10	2001-11-02 11:11:11
5	��īĨ	20	2001-11-02 17:50:11
6	�Ҹ���	10	2001-11-03 10:00:10
7	���ڱ�	20	2001-11-04 05:05:05
8	��ǹ�	20	2001-11-04 06:07:08
9	�����	10	2001-11-05 13:00:00
10	����Ĩ	20	2001-11-05 14:10:00
11	Ȩ����	10	2001-11-05 15:00:00
12	Ȩ����	10	2001-11-05 15:10:00
13	����Ĩ	20	2001-11-06 12:00:00
14	������	10	2001-11-07 12:00:00
15	������	20	2001-11-08 12:00:00
16	����ƽ	10	2001-11-09 12:00:00
17	������	20	2001-11-10 12:00:00
18	Ȩ����	10	2001-11-11 15:10:00
19	����ƽ	10	2001-11-12 12:00:00
20	����ƽ	20	2001-11-13 12:00:00
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �߰� ������ �Է� �� 2001�� ���� ���۵� �ֹ��� ����(2022��)���� ��� �߻�~!!! ���� ��~!!!
INSERT INTO TBL_JUMUN VALUES(98764, '����Ĩ', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98765, '������', 30, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98766, '������', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98767, '���̽�', 40, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98768, 'Ȩ����', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98769, '���ڱ�', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98770, '������', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98771, '���Ͻ�', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98772, '������', 30, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98773, '������', 20, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98774, '������', 50, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98775, '������', 10, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	ġ�佺	20	2001-11-01 09:10:12
2	������	10	2001-11-01 10:10:12
3	������	30	2001-11-01 13:10:20
4	������	10	2001-11-02 11:11:11
5	��īĨ	20	2001-11-02 17:50:11
6	�Ҹ���	10	2001-11-03 10:00:10
7	���ڱ�	20	2001-11-04 05:05:05
8	��ǹ�	20	2001-11-04 06:07:08
9	�����	10	2001-11-05 13:00:00
10	����Ĩ	20	2001-11-05 14:10:00
11	Ȩ����	10	2001-11-05 15:00:00
12	Ȩ����	10	2001-11-05 15:10:00
13	����Ĩ	20	2001-11-06 12:00:00
14	������	10	2001-11-07 12:00:00
15	������	20	2001-11-08 12:00:00
16	����ƽ	10	2001-11-09 12:00:00
17	������	20	2001-11-10 12:00:00
18	Ȩ����	10	2001-11-11 15:10:00
19	����ƽ	10	2001-11-12 12:00:00
20	����ƽ	20	2001-11-13 12:00:00
98764	����Ĩ	10	2022-08-22 16:55:42
98765	������	30	2022-08-22 16:55:44
98766	������	20	2022-08-22 16:55:46
98767	���̽�	40	2022-08-22 16:55:47
98768	Ȩ����	10	2022-08-22 16:55:48
98769	���ڱ�	20	2022-08-22 16:55:50
98770	������	10	2022-08-22 16:55:52
98771	���Ͻ�	20	2022-08-22 16:55:55
98772	������	30	2022-08-22 16:55:57
98773	������	20	2022-08-22 16:56:00
98774	������	50	2022-08-22 16:56:04
98775	������	10	2022-08-22 16:56:08
*/


--�� �����̰� ���� ���θ� � ��...
--   TBL_JUMUN ���̺��� ���ſ��� ��Ȳ
--   ���ø����̼ǰ��� �������� ���� �ֹ� ������ �ٸ� ���̺�
--   ����� �� �ֵ��� ����� ���� ���� �Ұ����� ��Ȳ
--   ������ ��� �����͸� ������� ����� �͵� �Ұ����� ��Ȳ
--   �� ���������
--      ������� ������ �ֹ� ������ ��
--      ���� �߻��� �ֹ� ������ �����ϰ�
--      ������ �����͸� �ٸ� ���̺�(TBL_JUMUNBACKUP) �� �̰��Ͽ� ����� ������ ��ȹ
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE ���� �߻��� �ֹ��� �ƴѰ�;

CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
                                      ------------------------------
                                      -- '2022-08-22;
--==>> Table TBL_JUMUNBACKUP��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_JUMUNBACKUP;
--==>>
/*
1	ġ�佺	20	2001-11-01 09:10:12
2	������	10	2001-11-01 10:10:12
3	������	30	2001-11-01 13:10:20
4	������	10	2001-11-02 11:11:11
5	��īĨ	20	2001-11-02 17:50:11
6	�Ҹ���	10	2001-11-03 10:00:10
7	���ڱ�	20	2001-11-04 05:05:05
8	��ǹ�	20	2001-11-04 06:07:08
9	�����	10	2001-11-05 13:00:00
10	����Ĩ	20	2001-11-05 14:10:00
11	Ȩ����	10	2001-11-05 15:00:00
12	Ȩ����	10	2001-11-05 15:10:00
13	����Ĩ	20	2001-11-06 12:00:00
14	������	10	2001-11-07 12:00:00
15	������	20	2001-11-08 12:00:00
16	����ƽ	10	2001-11-09 12:00:00
17	������	20	2001-11-10 12:00:00
18	Ȩ����	10	2001-11-11 15:10:00
19	����ƽ	10	2001-11-12 12:00:00
20	����ƽ	20	2001-11-13 12:00:00
*/
--> TBL_JUMUN ���̺��� �����͵� ��
--  ���� �ֹ� ���� �̿��� �����ʹ� ��� TBL_JUMUNBACKUP ���̺�
--  ����� ��ģ ����

-- TBL_JUMUN ���̺��� �����͵� ��
-- ����� ��ģ �����͵� �� ��, ���� �߻��� �ֹ� ������ �ƴ� �����͵� �� ����
DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
                                      ------------------------------
                                      -- '2022-08-22;
--==>> 20�� �� ��(��) �����Ǿ����ϴ�.
--     (98763�� ���� �����Ǿ����ϴ�. �� �ǵ��� ��)

-- Ȯ��
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	����Ĩ	10	2022-08-22 16:55:42
98765	������	30	2022-08-22 16:55:44
98766	������	20	2022-08-22 16:55:46
98767	���̽�	40	2022-08-22 16:55:47
98768	Ȩ����	10	2022-08-22 16:55:48
98769	���ڱ�	20	2022-08-22 16:55:50
98770	������	10	2022-08-22 16:55:52
98771	���Ͻ�	20	2022-08-22 16:55:55
98772	������	30	2022-08-22 16:55:57
98773	������	20	2022-08-22 16:56:00
98774	������	50	2022-08-22 16:56:04
98775	������	10	2022-08-22 16:56:08
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ���� ��ǰ �߼��� �̷������ ���� ���� �ֹ� �����͸� �����ϰ�
--   ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ�
--   ���̺��� ��(���ڵ�)�� ������ �پ��� �ſ� �������� ��Ȳ�̴�


-- �׷���, ���ݱ��� �ֹ����� ������ ���� ������
-- ��ǰ�� �� �ֹ������� ��Ÿ����� �� ��Ȳ�� �߻��ϰ� �Ǿ���
-- �׷��ٸ�, TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)��
-- TBL_JUMUN ���̺��� ���ڵ�(��)�� ��� ����
-- �ϳ��� ���̺��� ��ȸ�ϴ� �Ͱ� ���� ����� Ȯ���� �� �ֵ���
-- ��ȸ�� �̷������ �Ѵ�


--�� �÷��� �÷��� ���踦 ����Ͽ� ���̺��� �����ϰ��� �ϴ� ���
--   JOIN �� ���������
--   ���ڵ�� ���ڵ带 �����ϰ��� �ϴ� ���
--   UNION / UNION ALL �� ����� �� �ִ�
SELECT *
FROM TBL_JUMUNBACKUP;
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;



SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;


--�� UNION �� �׻� ������� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�
--   �ݸ�, UNION ALL �� ���յ� ����(�������� ���̺��� ����� ����) ���
--   ��ȸ�� ����� �ִ� �״�� ��ȯ�Ѵ�.(���� ����)
--   �̷� ���� UNION �� ���ϰ� �� ũ��(���ҽ� �Ҹ� �� ũ��)
--   ��, UNION �� ������� �ߺ��� ���ڵ尡(��)�� ������ ���
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �ȴ�

--�� ���ݱ��� �ֹ����� �����͸� ����
--   ��ǰ �� �� �ֹ����� ��ȸ�� �� �ִ� �������� �����Ѵ�
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;
--> �� ������ �ذ��ϴ� ���������� UNION�� ����ؼ��� �ȵȴ�
--  JECODE �� JUSU�� ��ȸ�ϴ� �������� �ߺ��� ���� �����ϴ� ��Ȳ�� �߻�

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT T.JECODE "��ǰ�ڵ�", SUM(T.JUSU) "��ǰ�����ֹ���"
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
) T
GROUP BY T.JECODE;
--==>>
/*
����Ĩ	30
������	20
������	70
���Ͻ�	20
ġ�佺	20
�����	10
���̽�	40
������	30
��īĨ	20
����Ĩ	20
��ǹ�	20
������	110
Ȩ����	40
���ڱ�	40
������	30
������	10
�Ҹ���	10
����ƽ	40
*/


--�� INTERSECT / MINUS ( �� ������/������)

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
-- ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� �ุ �����ϰ��� �Ѵ�.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���ڱ�	20
������	30
Ȩ����	10
*/

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
������	20
����Ĩ	20
������	10
������	10
��ǹ�	20
�����	10
����Ĩ	20
������	20
������	10
�Ҹ���	10
ġ�佺	20
����ƽ	10
����ƽ	20
��īĨ	20
*/


-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� ������� 
-- ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
-- �ֹ���ȣ, ��ǰ�ڵ�, �ֹ�����, �ֹ����� �׸����� ��ȸ�Ѵ�.
SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;
/*
1	ġ�佺	20	2001-11-01
2	������	10	2001-11-01
3	������	30	2001-11-01
4	������	10	2001-11-02
5	��īĨ	20	2001-11-02
6	�Ҹ���	10	2001-11-03
7	���ڱ�	20	2001-11-04
8	��ǹ�	20	2001-11-04
9	�����	10	2001-11-05
10	����Ĩ	20	2001-11-05
11	Ȩ����	10	2001-11-05
12	Ȩ����	10	2001-11-05
13	����Ĩ	20	2001-11-06
14	������	10	2001-11-07
15	������	20	2001-11-08
16	����ƽ	10	2001-11-09
17	������	20	2001-11-10
18	Ȩ����	10	2001-11-11
19	����ƽ	10	2001-11-12
20	����ƽ	20	2001-11-13
98764	����Ĩ	10	2022-08-22
98765	������	30	2022-08-22
98766	������	20	2022-08-22
98767	���̽�	40	2022-08-22
98768	Ȩ����	10	2022-08-22
98769	���ڱ�	20	2022-08-22
98770	������	10	2022-08-22
98771	���Ͻ�	20	2022-08-22
98772	������	30	2022-08-22
98773	������	20	2022-08-22
98774	������	50	2022-08-22
98775	������	10	2022-08-22
*/

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���ڱ�	20
������	30
Ȩ����	10
*/

SELECT JUNO, JECODE, JUSU, JUDAY
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JUNO, JECODE, JUSU, JUDAY
FROM TBL_JUMUN;
--==>> ��ȸ ��� ���� 
--     �ֹ���ȣ, �ֹ����ڱ��� �����ϸ� �������� �����Ƿ�

-- ��� 1

SELECT T2.JUNO, T1.JECODE, T1.JUSU, T2.JUDAY
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T1
JOIN
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
AND T1.JUSU = T2.JUSU;
--==>>
/*
    3	������	30	2001-11-01
    7	���ڱ�	20	2001-11-04
   11	Ȩ����	10	2001-11-05
   12	Ȩ����	10	2001-11-05
   18	Ȩ����	10	2001-11-11
98768	Ȩ����	10	2022-08-22
98769	���ڱ�	20	2022-08-22
98772	������	30	2022-08-22
*/

-- ��� 2
SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('���ڱ�', '������', 'Ȩ����')
  AND T.JUSU IN (20, 30, 10);
--==>> �̷��� �ϸ� ��ȸ�Ǽ� �ȵǴ� �����͵� ��ȸ ��
-- ���� ������ ��� ������ 20 OR 30 OR 10 �̸� ��� ��ȸ�Ǿ� ����

SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE�� T.SUJU�� ���� ����� '���ڱ�20' '������30' 'Ȩ����10';


SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN ('���ڱ�20', '������30', 'Ȩ����10');

SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN ( SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUNBACKUP
                                    INTERSECT
                                    SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUN );
--==>>
/*
    3	������	30	2001-11-01
    7	���ڱ�	20	2001-11-04
   11	Ȩ����	10	2001-11-05
   12	Ȩ����	10	2001-11-05
   18	Ȩ����	10	2001-11-11
98768	Ȩ����	10	2022-08-22
98769	���ڱ�	20	2022-08-22
98772	������	30	2022-08-22
*/
--------------------------------------------------------------------------------
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D;
--==>> �����߻�

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E NATURAL JOIN DEPT D;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D
USING(DEPTNO);
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/