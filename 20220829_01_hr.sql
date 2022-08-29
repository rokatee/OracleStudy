SELECT USER
FROM DUAL;
--==>> HR

--���� NOT NULL(NN:CK:C) ����--
-- 1. ���̺��� ������ �÷��� �����Ͱ� NULL�� ���� ���ϵ��� �ϴ� ��������

-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] NOT NULL

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��
-- �÷��� ������Ÿ��
-- CONSTRAINT CONSTRAINT�� CHECK(�÷��� IS NOT NULL)

-- 3. ������ �����Ǿ� �ִ� ���̺� NOT NULL ���������� �߰��� ���
-- ADD ���� MODIFY ���� �� ���� ���ȴ�.
-- ALTER TABLE ���̺��
-- MODIFY �÷��� ������Ÿ�� NOT NULL;

-- 4. ���� ���̺� �����Ͱ� �̹� ������� ���� �÷�(�� NULL �� ������ �÷�)��
--    NOT NULL ���������� ���Բ� �����ϴ� ��쿡�� ���� �߻��Ѵ�. (�Ұ����ϴ�)

--�� NOT NULL ���� �ǽ�( �÷� ������ ���� )
-- ���̺� ����
SELECT *
FROM TAB;
-- ������ ���̺�� Ȯ��

CREATE TABLE TBL_TEST11
( COL1 NUMBER(5)     PRIMARY KEY
, COL2 VARCHAR2(30)  NOT NULL
);
--==>> Table TBL_TEST11��(��) �����Ǿ����ϴ�.


-- ������ �Է�
INSERT INTO TBL_TEST11(COL1,COL2) VALUES (1,'TEST');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES (2,'ABCD');
INSERT INTO TBL_TEST11(COL1) VALUES (3);                --> ���� �߻�
INSERT INTO TBL_TEST11(COL1,COL2) VALUES (3,NULL);      --> ���� �߻�

-- Ȯ��
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/

-- ���� ���� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*
HR	SYS_C007177	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007178	TBL_TEST11	P	COL1		
*/


--�� NOT NULL ���� �ǽ�(�� ���̺� ������ ����)
CREATE TABLE TBL_TEST12
( COL1 NUMBER(5) 
, COL2 VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/


--�� NOT NULL ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST13
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST13��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> ��ȸ ��� ����

-- ���� ���� �߰�
ALTER TABLE TBL_TEST13
ADD( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST13��(��) ����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/


-- �� NOT NULL �������Ǹ� TBL_TEST13 ���̺��� COL2�� �߰��ϴ� ���
--    ������ ���� ����� �����ϴ�. 

-- ���̺����
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--===>>Table TBL_TEST14��(��) ����Ǿ����ϴ�.



-- NOT NULL �� �÷� �������� �����ϱ⸦ �����Ѵ�, �� ������??

-- �÷� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST11)
DESC TBL_TEST11;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/

-- ���̺� �������� ���� ���������� ������ ���̺�
DESC TBL_TEST12;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- ���غ��� �Ʒ��� COL2 �� NOT NULL �� ����.

--> DESC �� ���� COL2 �÷��� NOT NULL �� ������ Ȯ�εǴ� ��Ȳ
-- �� �� DESC�� NOT NULL �� �ƴϴ��� ���������� �ɷ������� ���� �����±���

-- ���̺� ���� ���� ADD�� ���� NOT NULL ���������� �߰��Ͽ�����
-- ���⿡ ���Ͽ� MODIFY ���� ���� NOT NULL ���������� �߰��� ���̺�
DESC TBL_TEST13;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 

*/

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('TBL_TEST11', 'TBL_TEST12', 'TBL_TEST13');
--==>>
/*
HR	SYS_C007177	    TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007178 	TBL_TEST11	P	COL1		

HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		

HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007183	    TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/


--�� NOT NULL ���� �ǽ�(�� �÷� ������ �������� �̸� �ο�)
-- ���̺� ����
CREATE TABLE TBL_TEST14
( COL1 NUMBER(5)        CONSTRAINT TEST14_COL1_PK PRIMARY KEY
, COL2 VARCHAR2(30)     CONSTRAINT TEST14_COL2_NN NOT NULL
);
--==>> Table TBL_TEST14��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST14';
--==>>
/*
HR	TEST14_COL2_NN	TBL_TEST14	C	COL2	"COL2" IS NOT NULL	
HR	TEST14_COL1_PK	TBL_TEST14	P	COL1		
*/

DESC TBL_TEST14;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/


-- NOT NULL ������ �÷� �������� �����ϰ� �̹� ���̺��� ��������ִٸ� MODIFY ���� �ϵ���!
-- ���� �� ���� NOT NULL ���������� ���̺� �������� ������ �� 
-- DESC ���� NOT NULL�� ������ �ʴ� ������ �����. 

-- ���� �÷� �������� 
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] NOT NULL 
-- �� �������ְų� 

-- ���̺��� �̹� �����Ǿ� �ִٸ� MODIFY�� ���� NOT NULL ���������� �߰������ �Ѵ�. 
 
--ALTER TABLE TBL_TEST14
--MODIFY COL2 NOT NULL;



--------------------------------------------------------------------------------
--����   DEFAULT ǥ����   ����

-- 1. INSERT �� UPDATE������
-- Ư�� ���� �ƴ� �⺻���� �Է��ϵ��� ó���� �� �ִ�. 

-- 2. ���� �� ����
-- �÷��� ������Ÿ�� DEFAULT �⺻��

-- 3. INSERT ��� �� �ش� �÷��� �Էµ� ���� �Ҵ����� �ʰų�
--    DEFAULT Ű���带 Ȱ���Ͽ� �⺻������ ������ ���� �Է��ϵ��� �� �� �ִ�.

-- 4. DEFAUT Ű����� �ٸ� ����(NOT NULL ��) ǥ�Ⱑ �Բ� ���Ǿ�� �ϴ� ���
--    DEFAULT Ű���带 ���� ǥ��(�ۼ�)�� ���� �����Ѵ�.

-- �� DEFAULT ǥ���� �ǽ�
-- ���̺� ����
CREATE TABLE TBL_BBS                       -- �Խ��� ���̺� ����
( SID        NUMBER        PRIMARY KEY     -- �Խù� ��ȣ �� �ĺ��� �� �ڵ� ����
, NAME       VARCHAR2(20)                  -- �Խù� �ۼ���
, CONTENTS   VARCHAR2(200)                 -- �Խù� ����
, WRITEDAY   DATE          DEFAULT SYSDATE -- �Խù� �ۼ���   (���� ��¥ �ڵ� �Է�)
, COUNTS     NUMBER        DEFAULT 0       -- �Խù� ��ȸ ��  (�⺻�� 0 )
, COMMENTS   NUMBER        DEFAULT 0       -- �Խù� ��� ����(�⺻�� 0)
);
--==>>Table TBL_BBS��(��) �����Ǿ����ϴ�.

--�� SID�� �ڵ����� ���� ������ ��Ϸ��� ������ ��ü�� �ʿ��ϴ�. 
--   �ڵ����� �ԷµǴ� �÷��� ������� �Է� �׸񿡼� ���ܽ�ų �� �ִ�.

-- ������ ����
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==>> Sequence SEQ_BBS��(��) �����Ǿ����ϴ�.


--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


-- �Խù� �ۼ�
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '���ҿ�', '����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.'
      , TO_DATE('2022-08-29 10:48:10', 'YYYY-MM-DD HH24:MI:SS'), 0, 0);
--===>>1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS) 
VALUES (SEQ_BBS.NEXTVAL, '�ֵ���', '��� �ǽ����Դϴ�.', SYSDATE, 0, 0);
--===>>1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS) 
VALUES (SEQ_BBS.NEXTVAL, '������', '������ �ǽ����Դϴ�.', DEFAULT, 0, 0);
--===>>1 �� ��(��) ���ԵǾ����ϴ�. 

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES (SEQ_BBS.NEXTVAL, '������', '������ �ǽ����Դϴ�.', DEFAULT, DEFAULT, DEFAULT);
--===>>1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS) 
VALUES (SEQ_BBS.NEXTVAL, '���̰�', '������ ���Դϴ�.');
--===>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_BBS;
--==>>
/*
1	���ҿ�	����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.	2022-08-29 10:48:10	0	0
2	�ֵ���	��� �ǽ����Դϴ�.	                    2022-08-29 11:07:25	0	0
3	������	������ �ǽ����Դϴ�.	                2022-08-29 11:07:27	0	0
4	������	������ �ǽ����Դϴ�.	                2022-08-29 11:07:29	0	0
5	���̰�	������ ���Դϴ�.	                    2022-08-29 11:07:31	0	0
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�

-- �� DEFAULT ǥ���� Ȯ��(��ȸ)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='TBL_BBS';
--==>>
/*
TBL_BBS	SID	NUMBER			             22			N	1													                    NO	NO		  0		NO	YES	NONE
TBL_BBS	NAME	    VARCHAR2			 20			Y	2											                CHAR_CS	20	NO	NO		 20	B	NO	YES	NONE
TBL_BBS	CONTENTS	VARCHAR2			200			Y	3											                CHAR_CS	200	NO	NO		200	B	NO	YES	NONE
TBL_BBS	WRITEDAY	DATE			      7			Y	4	63	"SYSDATE -- �Խù� �ۼ���   (���� ��¥ �ڵ� �Է�)"				NO	NO		  0		NO	YES	NONE
TBL_BBS	COUNTS	    NUMBER			     22			Y	5	48	"0       -- �Խù� ��ȸ ��  (�⺻�� 0 )"						NO	NO		  0		NO	YES	NONE
TBL_BBS	COMMENTS	NUMBER			     22			Y	6	48	"0       -- �Խù� ��� ����(�⺻�� 0)"							NO	NO		  0		NO	YES	NONE
*/


-- ���̺� ���� ���� DEFAULT ǥ���� �߰� / ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT �⺻��;

-- ���̺� ���� ���� ������ DEAULT ǥ���� ����(����)
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT NULL;