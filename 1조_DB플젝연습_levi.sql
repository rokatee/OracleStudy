SELECT USER
FROM DUAL;
--==>> LEVI



--DROP TABLE TBL_GRADE PURGE;
--DROP TABLE TBL_POINT PURGE;
--DROP TABLE TBL_FAIL PURGE;
--DROP TABLE TBL_SIGN PURGE;
--DROP TABLE TBL_REASON PURGE;
--DROP TABLE TBL_STUDENT PURGE;
--DROP TABLE TBL_OCLASS PURGE;
--DROP TABLE TBL_TEXTBOOK PURGE;
--DROP TABLE TBL_OCOURSE PURGE;
--DROP TABLE TBL_CLASSROOM PURGE;
--DROP TABLE TBL_COURSE PURGE;
--DROP TABLE TBL_ABLE PURGE;
--DROP TABLE TBL_CLASS PURGE;
--DROP TABLE TBL_PROFESSOR PURGE;
--DROP TABLE TBL_ADMIN PURGE;

--------------------------------------------------------------------------------
------TBL_ADMIN ����-------------------------------------------------------------

---- ���̺� ����       
CREATE TABLE TBL_ADMIN
( ADMIN_ID	    VARCHAR2(10)	                                                            -- ������ ���̵� (PK)
, ADMIN_PW	    VARCHAR2(15)	                CONSTRAINT ADMIN_ADMIN_PW_NN NOT NULL       -- ������ ��й�ȣ
, ADMIN_NAME	VARCHAR2(30)	                                                            -- �����ڸ�
, ADMIN_DATE	DATE	        DEFAULT SYSDATE CONSTRAINT ADMIN_ADMIN_DATE_NN NOT NULL	    -- ������ �����
, CONSTRAINT PK_TBL_ADMIN PRIMARY KEY (ADMIN_ID)
);

--------------------------------------------------------------------------------
------TBL_PROFESSOR ����-----------------------------------------------------------

-- ���̺� ����   
CREATE TABLE TBL_PROFESSOR
( PRO_ID        VARCHAR2(10)                                                    -- ���� ���̵� (PK)
, PRO_NAME      VARCHAR2(30)    CONSTRAINT PROFESSOR_PRO_NAME_NN NOT NULL       -- ������
, PRO_PW        VARCHAR2(15)    CONSTRAINT PROFESSOR_PRO_PW_NN NOT NULL         -- ��й�ȣ
, PRO_SSN       CHAR(14)        CONSTRAINT PROFESSOR_SSN_NN NOT NULL            -- �ֹε�Ϲ�ȣ
, PRO_EMAIL     VARCHAR2(30)                                                    -- ���� �̸���
, PRO_PHONE     VARCHAR2(20)                                                    -- ���� ����ȣ
, PRO_DATE      DATE           DEFAULT SYSDATE                                  -- ���� ���Գ�¥
, CONSTRAINT PROFESSOR_PRO_ID_PK PRIMARY KEY(PRO_ID)
);

--------------------------------------------------------------------------------
------TBL_CLASS ����-----------------------------------------------------------

CREATE TABLE TBL_CLASS
( CLASS_CODE    NUMBER                                                      -- �����ڵ� (PK)
, CLASS_NAME    VARCHAR2(30)    CONSTRAINT CLASS_CLASS_NAME_NN NOT NULL     -- �����
, CONSTRAINT CLASS_CLASS_CODE_PK PRIMARY KEY(CLASS_CODE)
);
--------------------------------------------------------------------------------
------TBL_ABLE ����-----------------------------------------------------------

CREATE TABLE TBL_ABLE
( ABLE_CODE   NUMBER                                                        -- ���� ���� ���� �ڵ�  (PK)
, CLASS_CODE  NUMBER        CONSTRAINT ABLE_CLASS_CODE_NN NOT NULL          -- �����ڵ� (FK : TBL_CLASS)
, PRO_ID    VARCHAR2(10)    CONSTRAINT ABLE_PRO_ID_NN NOT NULL              -- ���� ���̵� (FK : TBL_PROFESSOR)
, CONSTRAINT ABLE_ABLE_CODE_PK PRIMARY KEY(ABLE_CODE)
);

ALTER TABLE TBL_ABLE
ADD CONSTRAINT FK_TBL_CLASS_TO_TBL_ABLE_1 FOREIGN KEY (CLASS_CODE)
REFERENCES TBL_CLASS (CLASS_CODE);

ALTER TABLE TBL_ABLE 
ADD CONSTRAINT FK_TBL_PROFESSOR_TO_TBL_ABLE_1 FOREIGN KEY (PRO_ID)
REFERENCES TBL_PROFESSOR (PRO_ID);

--------------------------------------------------------------------------------
------TBL_COURSE ����-----------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_COURSE 
( COURSE_CODE   NUMBER                                                          -- �����ڵ� (PK)
, COURSE_NAME	VARCHAR2(50)    CONSTRAINT COURSE_COURSE_NAME_NN  NOT NULL      -- ������
, CONSTRAINT COURSE_COURSE_CODE_PK  PRIMARY KEY(COURSE_CODE)
);

--------------------------------------------------------------------------------
------TBL_CLASSROOM ����--------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_CLASSROOM
( ROOM_CODE    NUMBER                                                           -- ���ǽ��ڵ� (PK)
, ROOM_NAME    VARCHAR2(10)  CONSTRAINT CLASSROOM_ROOM_NAME_NN   NOT NULL       -- ���ǽǸ�
, ROOM_INWON   NUMBER(3)     CONSTRAINT CLASSROOM_ROOM_INWON_NN   NOT NULL      -- ���ǽ� ���� �ο�
, CONSTRAINT   CLASSROOM_ROOM_CODE_PK  PRIMARY KEY(ROOM_CODE)
);

--------------------------------------------------------------------------------
------TBL_OCOURSE ����----------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_OCOURSE
( OCOURSE_CODE  NUMBER                                                                              -- ���������ڵ� (PK)
, START_DATE    DATE            CONSTRAINT OCOURSE_START_DATE_NN   NOT NULL                         -- ���� ������
, END_DATE      DATE            CONSTRAINT OCOURSE_END_DATE_NN NOT NULL                             -- ���� ������
, INSERT_DATE   DATE            DEFAULT SYSDATE CONSTRAINT OCOURSE_INSERT_DATE_NN NOT NULL          -- ��������     
, COURSE_CODE   NUMBER        CONSTRAINT OCOURSE_COURSE_CODE_NN NOT NULL                            -- �����ڵ� (FK : TBL_CLASSROOM)
, ROOM_CODE     NUMBER        CONSTRAINT OCOURSE_ROOM_CODE_NN NOT NULL                              -- ���ǽ��ڵ� (FK : TBL_COURSE)
, CONSTRAINT OCOURSE_OCOURSE_CODE_PK  PRIMARY KEY(OCOURSE_CODE)
);


-- ���� ���� �߰�
ALTER TABLE TBL_OCOURSE
ADD CONSTRAINT FK_TBL_COURSE_TO_TBL_OCOURSE_1 FOREIGN KEY (COURSE_CODE)
                    REFERENCES TBL_COURSE (COURSE_CODE);

ALTER TABLE TBL_OCOURSE
ADD CONSTRAINT FK_TBL_CLASSROOM_TO_TBL_OCOURS FOREIGN KEY (ROOM_CODE)
                    REFERENCES TBL_CLASSROOM (ROOM_CODE);

--------------------------------------------------------------------------------
------TBL_TEXTBOOK ����---------------------------------------------------------

-- ���̺� ����
CREATE TABLE TBL_TEXTBOOK
( BOOK_CODE     NUMBER                                                          -- ���� �ڵ� (PK)
, BOOK_NAME     VARCHAR2(20)    CONSTRAINT TEXTBOOK_BOOK_NAME_NN NOT NULL       -- �����
, BOOK_PUB      VARCHAR2(20)                                                    -- ���ǻ�
, CONSTRAINT TEXTBOOK_BOOK_CODE_PK PRIMARY KEY(BOOK_CODE)
);

--------------------------------------------------------------------------------
------TBL_OCLASS ����-----------------------------------------------------------

-- ���̺� ����
CREATE TABLE TBL_OCLASS
( OCLASS_CODE   NUMBER                                                                          -- �������� �ڵ� (PK)
, START_DATE    DATE        CONSTRAINT OCLASS_START_DATE_NN NOT NULL                            -- ���� ������
, END_DATE      DATE        CONSTRAINT OCLASS_END_DATE_NN NOT NULL                              -- ���� ������        
, INSERT_DATE   DATE        DEFAULT SYSDATE    CONSTRAINT OCLASS_INSERT_DATE_NN NOT NULL        -- ��������
, ABLE_CODE     NUMBER      CONSTRAINT OCLASS_ABLE_CODE_NN NOT NULL                             -- ���� ���� ���� �ڵ� (FK : TBL_ABLE)
, OCOURSE_CODE  NUMBER      CONSTRAINT OCLASS_OCOURSE_CODE_NN NOT NULL                          -- �������� �ڵ� (FK : TBL_OCOURSE)
, BOOK_CODE     NUMBER      CONSTRAINT OCLASS_BOOK_CODE_NN NOT NULL                             -- ���� �ڵ� (FK : TBL_TEXTBOOK)
, CONSTRAINT OCLASS_OCLASS_CODE_PK PRIMARY KEY(OCLASS_CODE)
);

-- ���� ���� �߰�
ALTER TABLE TBL_OCLASS
ADD CONSTRAINT OCLASS_ABLE_CODE_FK FOREIGN KEY(ABLE_CODE)
                    REFERENCES TBL_ABLE(ABLE_CODE);

ALTER TABLE TBL_OCLASS
ADD CONSTRAINT OCLASS_OCOURSE_CODE_FK FOREIGN KEY(OCOURSE_CODE)
                    REFERENCES TBL_OCOURSE(OCOURSE_CODE);

ALTER TABLE TBL_OCLASS
ADD CONSTRAINT OCLASS_BOOK_CODE_FK FOREIGN KEY(BOOK_CODE)
                    REFERENCES TBL_TEXTBOOK(BOOK_CODE);

--------------------------------------------------------------------------------
------TBL_STUDENT ����----------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_STUDENT 
( STU_ID	    VARCHAR2(10)	                                                            -- �л� ���̵� (PK)
, STU_NAME	    VARCHAR2(30)	    CONSTRAINT STUDENT_STU_NAME_NN NOT NULL                 -- �л���
, STU_PW	    VARCHAR2(15)	CONSTRAINT STUDENT_STU_PW_NN NOT NULL                   -- �л� ��й�ȣ
, STU_SSN	    CHAR(14)        CONSTRAINT STUDENT_STU_SSN_NN NOT NULL                  -- �ֹε�Ϲ�ȣ
, STU_EMAIL	    VARCHAR2(30)	                                                            -- �л� �̸���
, STU_PHONE	    VARCHAR2(20)	                                                            -- �л� ��ȭ��ȣ
, STU_DATE	    DATE    DEFAULT SYSDATE     CONSTRAINT STUDENT_STU_DATE_NN NOT NULL     -- �л� ���Գ�¥
, CONSTRAINT STUDENT_STU_ID_PK PRIMARY KEY(STU_ID)
);

--------------------------------------------------------------------------------
------TBL_REASON ����-----------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_REASON         
( REASON_CODE   NUMBER                                                          -- Ż�� ���� �ڵ�(PK)
, REASON_MEMO   VARCHAR2(50)    CONSTRAINT REASON_REASON_MEMO_NN NOT NULL       -- Ż�� ����
, CONSTRAINT REASON_REASON_CODE_PK PRIMARY KEY(REASON_CODE)
);

--------------------------------------------------------------------------------
------TBL_SIGN ����-------------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_SIGN
( SIGN_CODE     NUMBER                                                                    -- ������û �ڵ�(PK)
, SIGN_DATE     DATE            DEFAULT SYSDATE CONSTRAINT SIGN_SIGN_DATE_NN NOT NULL     -- Ż�� ����
, STU_ID        VARCHAR2(10)    CONSTRAINT SIGN_STU_ID_NN NOT NULL                        -- ������û �ڵ�(FK: TBL_STUDENT)
, OCOURSE_CODE  NUMBER          CONSTRAINT SIGN_OCOURSE_CODE_NN NOT NULL                    -- �������� �ڵ�(FK: TBL_OCOURSE)
, CONSTRAINT SIGN_SIGN_CODE_PK PRIMARY KEY(SIGN_CODE)
);

-- ���� ���� �߰�
ALTER TABLE TBL_SIGN
ADD CONSTRAINT FK_TBL_STUDENT_TO_TBL_SIGN_1 FOREIGN KEY (STU_ID)
                    REFERENCES TBL_STUDENT (STU_ID);

ALTER TABLE TBL_SIGN
ADD CONSTRAINT FK_TBL_OCOURSE_TO_TBL_SIGN_1 FOREIGN KEY (OCOURSE_CODE)
                    REFERENCES TBL_OCOURSE (OCOURSE_CODE);

--------------------------------------------------------------------------------
------TBL_FAIL ����-------------------------------------------------------------

-- ���̺� ����
CREATE TABLE TBL_FAIL
( FAIL_CODE     NUMBER                                                                      -- �ߵ� Ż�� �ڵ�(PK)                
, FAIL_DATE     DATE          DEFAULT SYSDATE   CONSTRAINT FAIL_FAIL_DATE_NN NOT NULL       -- Ż�� ����
, SIGN_CODE     NUMBER        CONSTRAINT FAIL_SIGN_CODE_NN NOT NULL                         -- ������û �ڵ�(FK: TBL_SIGN)
, REASON_CODE   NUMBER        CONSTRAINT FAIL_REASON_CODE_NN NOT NULL                       -- Ż�� ���� �ڵ�(FK: TBL_REASON)
, CONSTRAINT FAIL_FAIL_CODE_PK PRIMARY KEY(FAIL_CODE)
);

-- ���� ���� �߰�
ALTER TABLE TBL_FAIL
ADD CONSTRAINT FK_TBL_SIGN_TO_TBL_FAIL_1 FOREIGN KEY (SIGN_CODE)
                    REFERENCES TBL_SIGN(SIGN_CODE);

ALTER TABLE TBL_FAIL 
ADD CONSTRAINT FK_TBL_REASON_TO_TBL_FAIL_1 FOREIGN KEY (REASON_CODE)
                    REFERENCES TBL_REASON(REASON_CODE);

--------------------------------------------------------------------------------
------TBL_POINT ����------------------------------------------------------------

-- ���̺� ���� -- �������� ��/��/�Ǳ� ���� ���� �����ֱ�
CREATE TABLE TBL_POINT
( POINT_CODE        NUMBER                                                                  -- �����ڵ� (PK)
, POINT_ATTEND      NUMBER(3)       DEFAULT 0   CONSTRAINT POINT_POINT_ATTEND_NN NOT NULL   -- ��� ���� 
, POINT_PRACTICE    NUMBER(3)       DEFAULT 0                                               -- �Ǳ� ����
, POINT_WRITE       NUMBER(3)       DEFAULT 0                                               -- �ʱ� ����
, OCLASS_CODE       NUMBER          CONSTRAINT POINT_OCLASS_CODE_NN NOT NULL                -- �������� �ڵ� (FK : TBL_OCLASS)
, CONSTRAINT POINT_POINT_CODE_PK PRIMARY KEY(POINT_CODE)
);

-- ���� ���� �߰�
ALTER TABLE TBL_POINT
ADD CONSTRAINT POINT_OCLASS_CODE_FK FOREIGN KEY(OCLASS_CODE)
                    REFERENCES TBL_OCLASS(OCLASS_CODE);
                    
--------------------------------------------------------------------------------
------TBL_GRADE ����----------------------------------------------------------

-- ���̺� ����       
CREATE TABLE TBL_GRADE
( GRADE_CODE        NUMBER  	                                                -- �����ڵ� (PK)
, GRADE_ATTEND	    NUMBER(3)	                                                -- ���
, GRADE_PRACTICE	NUMBER(3)	                                                -- �Ǳ�
, GRADE_WRITE	    NUMBER(3)	                                                -- �ʱ�
, OCLASS_CODE       NUMBER  	    CONSTRAINT GRADE_OCLASS_CODE_NN NOT NULL    -- �������� �ڵ� (FK : TBL_OCLASS)                
, SIGN_CODE	        NUMBER  	    CONSTRAINT GRADE_SIGN_CODE_NN NOT NULL      -- ������û �ڵ� (FK : TBL_SIGN)
, CONSTRAINT GRADE_GRADE_CODE_PK PRIMARY KEY(GRADE_CODE)
);

-- ���� ���� �߰�
ALTER TABLE TBL_GRADE
ADD CONSTRAINT FK_TBL_OCLASS_TO_TBL_GRADE_1 FOREIGN KEY (OCLASS_CODE)
REFERENCES TBL_OCLASS (OCLASS_CODE);

ALTER TABLE TBL_GRADE 
ADD CONSTRAINT FK_TBL_SIGN_TO_TBL_GRADE_1 FOREIGN KEY (SIGN_CODE)
REFERENCES TBL_SIGN (SIGN_CODE);



--------------------------------------------------------------------------------
--SEQUENCE ����=====================================================================
--drop SEQUENCE TBL_POINT_SEQ;
--drop SEQUENCE TBL_CLASS_SEQ;
--drop SEQUENCE TBL_ABLE_SEQ;
--drop SEQUENCE TBL_TEXTBOOK_SEQ;
--drop SEQUENCE TBL_OCLASS_SEQ;
--drop SEQUENCE TBL_REASON_SEQ;
--drop SEQUENCE TBL_SIGN_SEQ;
--drop SEQUENCE TBL_FAIL_SEQ;

--TBL_ADMIN 

--TBL_PROFESSOR

--TBL_CLASS
CREATE SEQUENCE TBL_CLASS_SEQ
NOCACHE;

--TBL_ABLE
CREATE SEQUENCE TBL_ABLE_SEQ
NOCACHE;


--TBL_COURSE

--TBL_CLASSROOM

--TBL_OCOURSE

--TBL_TEXTBOOK
CREATE SEQUENCE TBL_TEXTBOOK_SEQ
NOCACHE;

--TBL_OCLASS
CREATE SEQUENCE TBL_OCLASS_SEQ
NOCACHE;

--TBL_STUDENT 

--TBL_REASON
CREATE SEQUENCE TBL_REASON_SEQ
START WITH 1                       -- ���۰�
INCREMENT BY 1
NOMAXVALUE 
NOCACHE;

--TBL_SIGN
CREATE SEQUENCE TBL_SIGN_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE 
NOCACHE;

--TBL_FAIL
CREATE SEQUENCE TBL_FAIL_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE 
NOCACHE;

--TBL_POINT
CREATE SEQUENCE TBL_POINT_SEQ
NOCACHE;

--TBL_GRADE 

--------------------------------------------------------------------------------
--INSERT ����=====================================================================

--TBL_ADMIN 
INSERT INTO TBL_ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NAME)
VALUES('�δ���', 'java001', '������');

--TBL_PROFESSOR
INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
VALUES('pro1', '����1', '1234567', '901010-1234567', 'pro1@gmail.com', '010-1234-5678');

INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
VALUES('pro2', '����2', '2234567', '911010-2234567', NULL, NULL);

INSERT INTO TBL_PROFESSOR(PRO_ID, PRO_NAME, PRO_PW, PRO_SSN, PRO_EMAIL, PRO_PHONE)
VALUES('pro3', '����3', '3334567', '921010-3334567', NULL, NULL);

--TBL_CLASS
INSERT INTO TBL_CLASS(CLASS_CODE, CLASS_NAME)
VALUES(1,'Java');

INSERT INTO TBL_CLASS(CLASS_CODE, CLASS_NAME)
VALUES(2, 'Oracle');

--TBL_ABLE
INSERT INTO TBL_ABLE(ABLE_CODE, CLASS_CODE, PRO_ID)
VALUES(1, 1, 'pro1');

INSERT INTO TBL_ABLE(ABLE_CODE, CLASS_CODE, PRO_ID)
VALUES(2, 1, 'pro2');

INSERT INTO TBL_ABLE(ABLE_CODE, CLASS_CODE, PRO_ID)
VALUES(3, 2, 'pro3');

-- TBL_COURSE
INSERT INTO TBL_COURSE(COURSE_CODE, COURSE_NAME)
VALUES(1, '�ֿ�');

-- TBL_CLASSROOM
INSERT INTO TBL_CLASSROOM(ROOM_CODE, ROOM_NAME, ROOM_INWON)
VALUES(1, 'A', 20);

-- TBL_OCOURSE
INSERT INTO TBL_OCOURSE(OCOURSE_CODE, START_DATE, END_DATE, INSERT_DATE, COURSE_CODE, ROOM_CODE)
VALUES(6, TO_DATE('2022-10-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), TO_DATE('2022-09-14', 'YYYY-MM-DD'), 1, 1);

--TBL_TEXTBOOK
INSERT INTO TBL_TEXTBOOK(BOOK_CODE, BOOK_NAME, BOOK_PUB)
VALUES(1, 'Java', '�ֿ�');

INSERT INTO TBL_TEXTBOOK(BOOK_CODE, BOOK_NAME, BOOK_PUB)
VALUES(2, 'Oracle', NULL);

INSERT INTO TBL_TEXTBOOK(BOOK_CODE, BOOK_NAME, BOOK_PUB)
VALUES(3, 'DB', NULL);

--TBL_OCLASS
INSERT INTO TBL_OCLASS(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
VALUES(1, TO_DATE('2022-06-27', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 1 ,1 ,1 );

INSERT INTO TBL_OCLASS(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
VALUES(2, TO_DATE('2022-01-20', 'YYYY-MM-DD'), TO_DATE('2022-12-25', 'YYYY-MM-DD'), 1 ,1 ,2 );

INSERT INTO TBL_OCLASS(OCLASS_CODE, START_DATE, END_DATE, ABLE_CODE, OCOURSE_CODE, BOOK_CODE)
VALUES(3, TO_DATE('2022-09-10', 'YYYY-MM-DD'), TO_DATE('2022-11-21', 'YYYY-MM-DD'), 1 ,1 ,2 );

--TBL_STUDENT 
INSERT INTO TBL_STUDENT(STU_ID, STU_NAME, STU_PW, STU_SSN, STU_EMAIL, STU_PHONE)
VALUES('STU1', '������', 'java001', '901010-1234567', 'STU1@gamil.com', '010-1234-5678');

INSERT INTO TBL_STUDENT(STU_ID, STU_NAME, STU_PW, STU_SSN, STU_EMAIL, STU_PHONE)
VALUES('STU2', '������2', 'java002', '801010-1234567', NULL, NULL);

--TBL_REASON
INSERT INTO TBL_REASON(REASON_CODE, REASON_MEMO)
VALUES(1, 'Ż��');

--TBL_SIGN
INSERT INTO TBL_SIGN(SIGN_CODE, STU_ID, OCOURSE_CODE)
VALUES(1, 'STU1', 1);

--TBL_FAIL
INSERT INTO TBL_FAIL(FAIL_CODE, SIGN_CODE, REASON_CODE)
VALUES(1,1,1);

--TBL_POINT
INSERT INTO TBL_POINT(POINT_CODE, POINT_ATTEND, POINT_PRACTICE, POINT_WRITE, OCLASS_CODE)
VALUES(1, 20, 20, 60, 1);

INSERT INTO TBL_POINT(POINT_CODE, OCLASS_CODE)
VALUES(2, 1);

--TBL_GRADE 
INSERT INTO TBL_GRADE(GRADE_CODE, GRADE_ATTEND, GRADE_PRACTICE, GRADE_WRITE, OCLASS_CODE, SIGN_CODE)
VALUES(1, 90, 80, 70, 1, 1);

INSERT INTO TBL_GRADE(GRADE_CODE, OCLASS_CODE, SIGN_CODE)
VALUES(2, 1, 1);

INSERT INTO TBL_GRADE(GRADE_CODE, OCLASS_CODE, SIGN_CODE)
VALUES(3, 3, 1);


--------------------------------------------------------------------------------
--==============================================================================
--TBL_ADMIN 
COMMENT ON TABLE TBL_ADMIN IS '������ ���̺�';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_ID IS '������ ���̵�';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_PW IS '������ ��й�ȣ';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_NAME IS '�����ڸ�';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_DATE IS '������ �����';

--TBL_PROFESSOR
COMMENT ON TABLE TBL_PROFESSOR IS '���� ���̺�';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_ID IS'���� ���̵�';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_NAME IS'������';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_PW IS'��й�ȣ';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_SSN IS'�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_EMAIL IS'���� �̸���';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_PHONE IS'���� ����ȣ';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_DATE IS'���� ���Գ�¥';

--TBL_CLASS
COMMENT ON TABLE TBL_CLASS IS '���� ���̺�';
COMMENT ON COLUMN TBL_CLASS.CLASS_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_CLASS.CLASS_NAME IS '�����';

--TBL_ABLE
COMMENT ON TABLE TBL_ABLE IS '���� ���� ���� ���̺�';
COMMENT ON COLUMN TBL_ABLE.ABLE_CODE IS 'DD';
COMMENT ON COLUMN TBL_ABLE.CLASS_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_ABLE.PRO_ID IS '���� ���̵�';

-- TBL_COURSE (����) ���̺�, �÷� �ڸ�Ʈ �Է�
COMMENT ON TABLE TBL_COURSE IS '����';
COMMENT ON COLUMN TBL_COURSE.COURSE_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_COURSE.COURSE_NAME IS '������';

-- TBL_CLASSROOM (���ǽ�) ���̺�, �÷� �ڸ�Ʈ �Է�
COMMENT ON TABLE TBL_CLASSROOM IS '���ǽ�';
COMMENT ON COLUMN TBL_CLASSROOM.ROOM_CODE IS '���ǽ��ڵ�';
COMMENT ON COLUMN TBL_CLASSROOM.ROOM_NAME IS '���ǽǸ�';
COMMENT ON COLUMN TBL_CLASSROOM.ROOM_INWON IS '���ǽ� ���� �ο�';

-- TBL_OCOURSE (��������) ���̺�, �÷� �ڸ�Ʈ �Է�
COMMENT ON TABLE TBL_OCOURSE IS '��������';
COMMENT ON COLUMN TBL_OCOURSE.OCOURSE_CODE IS '���������ڵ�';
COMMENT ON COLUMN TBL_OCOURSE.START_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCOURSE.END_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCOURSE.INSERT_DATE IS '��������';            -- �������� �⺻�� SYSDATE
COMMENT ON COLUMN TBL_OCOURSE.COURSE_CODE IS '����.�����ڵ� ����Ű';
COMMENT ON COLUMN TBL_OCOURSE.ROOM_CODE IS '���ǽ�.���ǽ��ڵ� ����Ű';

--TBL_TEXTBOOK
COMMENT ON TABLE TBL_TEXTBOOK IS '���� ���̺�';
COMMENT ON COLUMN TBL_TEXTBOOK.BOOK_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_TEXTBOOK.BOOK_NAME IS '�����';
COMMENT ON COLUMN TBL_TEXTBOOK.BOOK_PUB IS '���ǻ�.';


--TBL_OCLASS
COMMENT ON TABLE TBL_OCLASS IS '�������� ���̺�';
COMMENT ON COLUMN TBL_OCLASS.OCLASS_CODE IS '�������� �ڵ�';
COMMENT ON COLUMN TBL_OCLASS.START_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCLASS.END_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCLASS.INSERT_DATE IS '���� ����';
COMMENT ON COLUMN TBL_OCLASS.ABLE_CODE IS '���� ���� ���� �ڵ�';
COMMENT ON COLUMN TBL_OCLASS.OCOURSE_CODE IS '�������� �ڵ�';
COMMENT ON COLUMN TBL_OCLASS.BOOK_CODE IS '���� �ڵ�';


--TBL_STUDENT 
COMMENT ON TABLE TBL_STUDENT IS '�л����̺�';
COMMENT ON COLUMN TBL_STUDENT.STU_ID IS '�л� ���̵�';
COMMENT ON COLUMN TBL_STUDENT.STU_NAME IS '�л� �̸�';
COMMENT ON COLUMN TBL_STUDENT.STU_PW IS '�л� ��й�ȣ';
COMMENT ON COLUMN TBL_STUDENT.STU_SSN IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN TBL_STUDENT.STU_EMAIL IS '�л� �̸���';
COMMENT ON COLUMN TBL_STUDENT.STU_PHONE IS '�л� ��ȭ��ȣ';
COMMENT ON COLUMN TBL_STUDENT.STU_DATE IS '�л� ���Գ�¥';

--TBL_REASON
COMMENT ON TABLE TBL_REASON IS 'Ż�� ���� ���̺�';
COMMENT ON COLUMN TBL_REASON.REASON_CODE IS 'Ż�� ���� �ڵ�';
COMMENT ON COLUMN TBL_REASON.REASON_MEMO IS 'Ż�� ����';

--TBL_SIGN
COMMENT ON TABLE TBL_SIGN IS '������û ���̺�';
COMMENT ON COLUMN TBL_SIGN.SIGN_CODE IS '������û �ڵ�';
COMMENT ON COLUMN TBL_SIGN.SIGN_DATE IS '������û ��¥';
COMMENT ON COLUMN TBL_SIGN.STU_ID IS '�л� ���̵�';
COMMENT ON COLUMN TBL_SIGN.OCOURSE_CODE IS '�������� �ڵ�';

--TBL_FAIL
COMMENT ON TABLE TBL_FAIL IS '�ߵ� Ż�� ���̺�';
COMMENT ON COLUMN TBL_FAIL.FAIL_CODE IS '�ߵ� Ż�� �ڵ�';
COMMENT ON COLUMN TBL_FAIL.FAIL_DATE IS 'Ż�� ����';
COMMENT ON COLUMN TBL_FAIL.SIGN_CODE IS '������û �ڵ�';
COMMENT ON COLUMN TBL_FAIL.REASON_CODE IS 'Ż�� ���� �ڵ�';

--TBL_POINT
COMMENT ON TABLE TBL_POINT IS '���� ���̺�';
COMMENT ON COLUMN TBL_POINT.POINT_CODE IS '���� �ڵ�';
COMMENT ON COLUMN TBL_POINT.POINT_ATTEND IS '���'; 
COMMENT ON COLUMN TBL_POINT.POINT_PRACTICE IS '�Ǳ�'; 
COMMENT ON COLUMN TBL_POINT.POINT_WRITE IS '�ʱ�'; 
COMMENT ON COLUMN TBL_POINT.OCLASS_CODE IS '�������� �ڵ�';

--TBL_GRADE 
COMMENT ON TABLE TBL_GRADE IS '���� ���̺�';
COMMENT ON COLUMN TBL_GRADE.GRADE_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_GRADE.GRADE_ATTEND IS '���';
COMMENT ON COLUMN TBL_GRADE.GRADE_PRACTICE IS '�Ǳ�';
COMMENT ON COLUMN TBL_GRADE.GRADE_WRITE IS '�ʱ�';
COMMENT ON COLUMN TBL_GRADE.OCLASS_CODE IS '�������� �ڵ�';
COMMENT ON COLUMN TBL_GRADE.SIGN_CODE IS '������û �ڵ�';