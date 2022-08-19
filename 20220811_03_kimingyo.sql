--�� ���� ������ ����� ���� Ȯ��
SELECT USER
FROM DUAL;
--==>> KIMINGYO

--�� ���̺� ����(���̺�� : TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO       NUMBER(10)
, NAME     VARCHAR2(30)
);
-- TBL_ORAUSERTEST ��� �̸��� ���̺��� ����µ�
-- NO���� 10���� ���ڸ�, NAME ���� 30���ڱ���
--==>> �����߻�
--     (ORA-01031: insufficient privileges)
-- ���� ������ �̸� ������ CREATE SESSION ���Ѹ� ���� ������
-- ���̺��� ������ �� �ִ� ������ ���� ���� ���� �����̴�
-- �׷��Ƿ� �����ڷκ��� ���̺��� ������ �� �ִ� ������ �ο��޾ƾ� �Ѵ�


--�� SYS�� ���� CREATE TABLE ������ �ο����� ��
--   �ٽ� ���̺� ����
CREATE TABLE TBL_ORAUSERTEST
( NO       NUMBER(10)
, NAME     VARCHAR2(30)
);
--==>> �����߻�
--     (ORA-01950: no privileges on tablespace 'TBS_EDUA')
-->    ���̺��� ������ �� �ִ� ���ѱ��� �ο����� ��Ȳ������
--     ������ �̸� ������ �⺻ ���̺����̽�(DEFAULT TABLESPACE)��
--     TBS_EDUA �̸�, �� ������ ���� �Ҵ緮�� �ο����� ���� �����̴�
--     �׷��Ƿ� �� ���̺����̽��� ����� ������ ���ٴ� �����޼�����
--     ����Ŭ�� ������ �ְ� �ִ� ��Ȳ


--�� ���̺����̽�(TBS_EDUA)�� ���� �Ҵ緮�� �ο����� ����
--   �ٽ� ���̺� ����
CREATE TABLE TBL_ORAUSERTEST
( NO       NUMBER(10)
, NAME     VARCHAR2(30)
);
--==>> Table TBL_ORAUSERTEST��(��) �����Ǿ����ϴ�.


--�� �ڽſ��� �ο��� �Ҵ緮 ��ȸ
SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	-1	8	-1	NO
--MAX_BYTES �� ������ ��� �������̶�� ��


--�� ������ ���̺�(TBL_ORAUSERTEST)��
--   � ���̺����̽��� ����Ǿ� �ִ��� ��ȸ
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> TBL_ORAUSERTEST	TBS_EDUA

