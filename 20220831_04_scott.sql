SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_INSA;

--�� TBL_INSA ���̺��� �������
--   �ֹι�ȣ(SSN)�� ������ ������ ��ȸ�Ѵ�

SELECT NAME, SSN
     , DECODE(SUBSTR(SSN, 8, 1), '1', '����', '2', '����', '3', '����', '4', '����', '����Ȯ�κҰ�' ) "����"
FROM TBL_INSA;

SELECT NAME, SSN
     , FN_GENDER(SSN) "����"
FROM TBL_INSA;

SELECT FN_GENDER('751212-1234657') "����Ȯ��"
FROM DUAL;



--�� ������ �Լ� �׽�Ʈ
-- FN_POW()
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000

-- FN_PAY()
SELECT NAME "�̸�", FN_PAY(BASICPAY, SUDANG) "�⺻��+����"
FROM TBL_INSA;
--==>>
/*
ȫ�浿	31520000
�̼���	16040000
    :
��ž�	10902000
*/

-- FN_WORKYEAR()
SELECT NAME, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
ȫ�浿	23.9
�̼���	21.7
�̼���	23.5
    :
��ž�	20.9
*/








