-- ����Ŭ ����(����) SYS���� ���� ����
/*
CREATE USER no1 IDENTIFIED BY hello;
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO no1;
ALTER USER no1 DEFAULT TABLESPACE USERS;
ALTER USER no1 TEMPORARY TABLESPACE TEMP;
*/

SELECT *
FROM TABS;

DROP TABLE TBL_ADMIN PURGE;
DROP TABLE TBL_PROFESSOR PURGE;
DROP TABLE TBL_CLASS PURGE;
DROP TABLE TBL_ABLE PURGE;
DROP TABLE TBL_COURSE PURGE;
DROP TABLE TBL_CLASSROOM PURGE;
DROP TABLE TBL_OCOURSE PURGE;
DROP TABLE TBL_TEXTBOOK PURGE;
DROP TABLE TBL_OCLASS PURGE;
DROP TABLE TBL_STUDENT PURGE;
DROP TABLE TBL_REASON PURGE;
DROP TABLE TBL_SIGN PURGE;
DROP TABLE TBL_FAIL PURGE;
DROP TABLE TBL_POINT PURGE;
DROP TABLE TBL_GRADE PURGE;


-- TBL_ADMIN(������) ���� ------------------------------------------------------

CREATE TABLE TBL_ADMIN  
( ADMIN_ID      VARCHAR2(30)	                                                                    -- ������ ���̵� (PK)
, ADMIN_PW      VARCHAR2(15)	                    CONSTRAINT ADMIN_ADMIN_PW_NN NOT NULL       -- ������ ��й�ȣ
, ADMIN_NAME	VARCHAR2(30)                                                                    -- �����ڸ�
, ADMIN_DATE	DATE            DEFAULT SYSDATE     CONSTRAINT ADMIN_ADMIN_DATE_NN NOT NULL	    -- ������ �����
, CONSTRAINT ADMIN_ADMIN_ID_PK PRIMARY KEY(ADMIN_ID)
);  

-- COMMENT �߰�
COMMENT ON TABLE TBL_ADMIN IS '������ ���̺�';

COMMENT ON COLUMN TBL_ADMIN.ADMIN_ID IS '������ ���̵�';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_PW IS '������ ��й�ȣ';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_NAME IS '�����ڸ�';
COMMENT ON COLUMN TBL_ADMIN.ADMIN_DATE IS '������ �����';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_ADMIN_INSERT('IDID1', '2111111', '���α�');
EXEC PRC_ADMIN_INSERT('IDID2', '2111132', '�ֳ���');
EXEC PRC_ADMIN_INSERT('IDID3', '2111123', '���̰�');
EXEC PRC_ADMIN_INSERT('IDID4', '2211123', '����');
EXEC PRC_ADMIN_INSERT('IDID4', '2211123', '����');   -- �ߺ� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_ADMIN_UPDATE('IDID5', '1111111', '���α�');   -- ���� ������
EXEC PRC_ADMIN_UPDATE('IDID1', '1111111', '���α�');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_ADMIN_DELETE('IDID6');     -- ���� ������
EXEC PRC_ADMIN_DELETE('IDID5');

SELECT *
FROM TBL_ADMIN;


-- TBL_PROFESSOR(����) ���� ----------------------------------------------------

CREATE TABLE TBL_PROFESSOR
( PRO_ID        VARCHAR2(30)                                                    -- ���� ���̵� (PK)
, PRO_NAME      VARCHAR2(30)    CONSTRAINT PROFESSOR_PRO_NAME_NN NOT NULL       -- ������
, PRO_PW        VARCHAR2(15)    CONSTRAINT PROFESSOR_PRO_PW_NN NOT NULL         -- ��й�ȣ
, PRO_SSN       CHAR(14)        CONSTRAINT PROFESSOR_SSN_NN NOT NULL            -- �ֹε�Ϲ�ȣ
, PRO_EMAIL     VARCHAR2(30)                                                    -- ���� �̸���
, PRO_PHONE     VARCHAR2(20)                                                    -- ���� ����ȣ
, PRO_DATE      DATE           DEFAULT SYSDATE                                  -- ���� ���Գ�¥
, CONSTRAINT PROFESSOR_PRO_ID_PK PRIMARY KEY(PRO_ID)
);

-- UK �������� �߰�
ALTER TABLE TBL_PROFESSOR
ADD CONSTRAINT PROFESSOR_PRO_SNN_UK UNIQUE(PRO_SSN);

-- COMMENT �߰�
COMMENT ON TABLE TBL_PROFESSOR IS '���� ���̺�';

COMMENT ON COLUMN TBL_PROFESSOR.PRO_ID IS '���� ���̵�';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_NAME IS '������';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_PW IS '��й�ȣ';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_SSN IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_EMAIL IS '���� �̸���';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_PHONE IS '���� ����ȣ';
COMMENT ON COLUMN TBL_PROFESSOR.PRO_DATE IS '���� ���Գ�¥';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_PROFESSOR_INSERT('PRO1', '����', '123456-2222222', 'RHDUSTN6223@GMAIL.COM', '');
EXEC PRC_PROFESSOR_INSERT('PRO1', '���α�', '123456-1111111', '', '010-1234-5678');                        -- ���� ���̵�
EXEC PRC_PROFESSOR_INSERT('PRO3', '������', '234567-1111111', 'ALSCKSDN12@NAVER.COM', '');
EXEC PRC_PROFESSOR_INSERT('PRO4', '���̰�', '123456-2222222', 'WJDALRUD00@GMAIL.COM', '010-5678-1234');    -- ���� �ֹι�ȣ
EXEC PRC_PROFESSOR_INSERT('PRO5', '�ֳ���', '345678-2222222', 'SKDBSNO1@GMAIL.COM', '010-1111-2222');

EXEC PRC_PROFESSOR_INSERT('PRO6', '������', '456789-2222222', 'SKDBSNO1@GMAIL.COM', '010-1111-2222');      -- UPDATE �� DELETE ���ν��� �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_PROFESSOR_UPDATE('PRO7', '���α�', '1111111', '', '010-1234-5678');       -- ���� ������
EXEC PRC_PROFESSOR_UPDATE('PRO6', '������', '2111111', '', '010-1111-2222');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_PROFESSOR_DELETE('PRO7');      -- ���� ������
EXEC PRC_PROFESSOR_DELETE('PRO1');      -- ��� ���� ������
EXEC PRC_PROFESSOR_DELETE('PRO6');

SELECT *
FROM TBL_PROFESSOR;


-- TBL_CLASS(����) ���� --------------------------------------------------------

CREATE TABLE TBL_CLASS
( CLASS_CODE    NUMBER                                                      -- �����ڵ� (PK)
, CLASS_NAME    VARCHAR2(30)    CONSTRAINT CLASS_CLASS_NAME_NN NOT NULL     -- �����
, CONSTRAINT CLASS_CLASS_CODE_PK PRIMARY KEY(CLASS_CODE)
);

-- �������� �߰�
ALTER TABLE TBL_CLASS
ADD CONSTRAINT CLASS_CLASS_NAME_UK UNIQUE(CLASS_NAME);

-- �ڵ�� ������ ����
CREATE SEQUENCE TBL_CLASS_SEQ
NOCACHE;

-- COMMENT �߰�
COMMENT ON TABLE TBL_CLASS IS '���� ���̺�';

COMMENT ON COLUMN TBL_CLASS.CLASS_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_CLASS.CLASS_NAME IS '�����';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_CLASS_INSERT('����Ŭ');
EXEC PRC_CLASS_INSERT('����Ŭ');       -- ���� �����
EXEC PRC_CLASS_INSERT('�ڹ�');
EXEC PRC_CLASS_INSERT('���̽�');
EXEC PRC_CLASS_INSERT('������');
EXEC PRC_CLASS_INSERT('JSP');

EXEC PRC_CLASS_INSERT('TEST');          -- UPDATE �� DELETE �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_CLASS_UPDATE(8, 'TEST2');      -- ���� ������
EXEC PRC_CLASS_UPDATE(1, '����Ŭ');     -- �ߺ� ������
EXEC PRC_CLASS_UPDATE(6, 'TEST2');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_CLASS_DELETE('NULL');         -- ���� ������
EXEC PRC_CLASS_DELETE('����Ŭ');         -- �̹� ��� ���� ������
EXEC PRC_CLASS_DELETE('TEST2');

SELECT *
FROM TBL_CLASS;


-- TBl_ABLE(���� ���� ����) ���� -----------------------------------------------

CREATE TABLE TBL_ABLE
( ABLE_CODE   NUMBER                                                        -- ���� ���� ���� �ڵ�  (PK)
, CLASS_CODE  NUMBER        CONSTRAINT ABLE_CLASS_CODE_NN NOT NULL          -- �����ڵ� (FK : TBL_CLASS)
, PRO_ID    VARCHAR2(10)    CONSTRAINT ABLE_PRO_ID_NN NOT NULL              -- ���� ���̵� (FK : TBL_PROFESSOR)
, CONSTRAINT ABLE_ABLE_CODE_PK PRIMARY KEY(ABLE_CODE)
);

-- FK �������� �߰�
ALTER TABLE TBL_ABLE
ADD ( CONSTRAINT ABLE_CLASS_CODE_FK FOREIGN KEY(CLASS_CODE)
                 REFERENCES TBL_CLASS(CLASS_CODE)
    , CONSTRAINT ABLE_PRO_ID_FK FOREIGN KEY(PRO_ID)
                 REFERENCES TBL_PROFESSOR(PRO_ID) );
                 
-- UK �������� �߰�
ALTER TABLE TBL_ABLE
ADD CONSTRAINT ABLE_NAME_UK UNIQUE(PRO_ID, CLASS_CODE);
                 
-- �ڵ�� ������ ����
CREATE SEQUENCE TBL_ABLE_SEQ
NOCACHE;

-- COMMENT �߰�
COMMENT ON TABLE TBL_ABLE IS '���� ���� ���� ���̺�';

COMMENT ON COLUMN TBL_ABLE.ABLE_CODE IS '���� ���� ���� �ڵ�';
COMMENT ON COLUMN TBL_ABLE.CLASS_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_ABLE.PRO_ID IS '���� ���̵�';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_ABLE_INSERT('����', '����Ŭ');
EXEC PRC_ABLE_INSERT('����', '�ڹ�');             -- ���� ������
EXEC PRC_ABLE_INSERT('���α�', '�ڹ�');
EXEC PRC_ABLE_INSERT('������', '����');           -- ���� �����
EXEC PRC_ABLE_INSERT('���̰�', 'JSP');
EXEC PRC_ABLE_INSERT('�ֳ���', '������');

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_ABLE_UPDATE(10, '���̽�', '����');     -- ���� ������
EXEC PRC_ABLE_UPDATE(1, '���̽�', '����');        -- ���� ������
EXEC PRC_ABLE_UPDATE(1, '����', '����');        -- ���� �����
EXEC PRC_ABLE_UPDATE(3, '���̽�', '����');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_ABLE_DELETE(8);        -- ���� ������
EXEC PRC_ABLE_DELETE(1);        -- �̹� ��� ���� ������
EXEC PRC_ABLE_DELETE(5);

SELECT *
FROM TBL_ABLE;
SELECT *
FROM TBL_CLASS;
SELECT *
FROM TBL_PROFESSOR;



-- TBL_COURSE(����) ���� -------------------------------------------------------

CREATE TABLE TBL_COURSE 
( COURSE_CODE   NUMBER                                                          -- �����ڵ� (PK)
, COURSE_NAME	VARCHAR2(50)    CONSTRAINT COURSE_COURSE_NAME_NN  NOT NULL      -- ������
, CONSTRAINT COURSE_COURSE_CODE_PK  PRIMARY KEY(COURSE_CODE)
);

-- COMMENT �߰�
COMMENT ON TABLE TBL_COURSE IS '����';

COMMENT ON COLUMN TBL_COURSE.COURSE_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_COURSE.COURSE_NAME IS '������';

-- ������ ����
CREATE SEQUENCE TBL_COURSE_SEQ
START WITH 1
INCREMENT BY 1 
NOMAXVALUE
NOCACHE;

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_COURSE_INSERT('Ǯ���� A');
EXEC PRC_COURSE_INSERT('Ǯ���� B');
EXEC PRC_COURSE_INSERT('�鿣�� A');
EXEC PRC_COURSE_INSERT('�鿣�� B');

EXEC PRC_COURSE_INSERT('TEST');             -- UPDATE �� DELETE �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_COURSE_UPDATE(10, 'Ǯ���� C');        -- ���� ������
EXEC PRC_COURSE_UPDATE(1, 'Ǯ���� C');
EXEC PRC_COURSE_UPDATE(5, 'TEST2');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_COURSE_UPDATE('TEST100');        -- ���� ������
EXEC PRC_COURSE_DELETE('Ǯ���� A');
EXEC PRC_COURSE_DELETE('TEST2');


SELECT *
FROM TBL_COURSE;
SELECT *
FROM TBL_GRADE;
SELECT *
FROM TBL_OCOURSE;
SELECT *
FROM TBL_OCLASS;

COMMIT;

-- TBL_CLASSROOM(���ǽ�) ���� --------------------------------------------------

CREATE TABLE TBL_CLASSROOM
( ROOM_CODE    NUMBER                                                           -- ���ǽ��ڵ� (PK)
, ROOM_NAME    VARCHAR2(30)  CONSTRAINT CLASSROOM_ROOM_NAME_NN   NOT NULL       -- ���ǽǸ�
, ROOM_INWON   NUMBER(3)     CONSTRAINT CLASSROOM_ROOM_INWON_NN   NOT NULL      -- ���ǽ� ���� �ο�
, CONSTRAINT   CLASSROOM_ROOM_CODE_PK  PRIMARY KEY(ROOM_CODE)
);

-- COMMENT �߰�
COMMENT ON TABLE TBL_CLASSROOM IS '���ǽ�';

COMMENT ON COLUMN TBL_CLASSROOM.ROOM_CODE IS '���ǽ��ڵ�';
COMMENT ON COLUMN TBL_CLASSROOM.ROOM_NAME IS '���ǽǸ�';
COMMENT ON COLUMN TBL_CLASSROOM.ROOM_INWON IS '���ǽ� ���� �ο�';

-- ������ ����
CREATE SEQUENCE TBL_CLASSROOM_SEQ
START WITH 1
INCREMENT BY 1 
NOMAXVALUE
NOCACHE;

-- ������ INSERT
EXEC PRC_CLASSROOM_INSERT('1���ǽ�', 100);
EXEC PRC_CLASSROOM_INSERT('2���ǽ�', 100);
EXEC PRC_CLASSROOM_INSERT('3���ǽ�', 100);
EXEC PRC_CLASSROOM_INSERT('4���ǽ�', 100);
EXEC PRC_CLASSROOM_INSERT('5���ǽ�', 100);

EXEC PRC_CLASSROOM_INSERT('6���ǽ�', 100);     -- UPDATE �� DELETE �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_CLASSROOM_UPDATE(6, 'A���ǽ�', 50);   -- ���� ������
EXEC PRC_CLASSROOM_UPDATE(1, 'A���ǽ�', 50);   -- �̹� ��� ���� ������
EXEC PRC_CLASSROOM_INSERT('6���ǽ�', 50);

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_CLASSROOM_DELETE('6���ǽ�');

SELECT *
FROM TBL_CLASSROOM;
SELECT *
FROM TBL_OCOURSE;



-- TBL_OCOURSE(��������) ���� --------------------------------------------------

CREATE TABLE TBL_OCOURSE
( OCOURSE_CODE  NUMBER                                                                              -- ���������ڵ� (PK)
, START_DATE    DATE            CONSTRAINT OCOURSE_START_DATE_NN   NOT NULL                         -- ���� ������
, END_DATE      DATE            CONSTRAINT OCOURSE_END_DATE_NN NOT NULL                             -- ���� ������
, INSERT_DATE   DATE            DEFAULT SYSDATE CONSTRAINT OCOURSE_INSERT_DATE_NN NOT NULL          -- ��������     
, COURSE_CODE   NUMBER        CONSTRAINT OCOURSE_COURSE_CODE_NN NOT NULL                            -- �����ڵ� (FK : TBL_CLASSROOM)
, ROOM_CODE     NUMBER        CONSTRAINT OCOURSE_ROOM_CODE_NN NOT NULL                              -- ���ǽ��ڵ� (FK : TBL_COURSE)
, CONSTRAINT OCOURSE_OCOURSE_CODE_PK  PRIMARY KEY(OCOURSE_CODE)
);

-- FK �������� �߰�
ALTER TABLE TBL_OCOURSE
ADD ( CONSTRAINT OCOURSE_ROOM_CODE_FK FOREIGN KEY(ROOM_CODE)
                REFERENCES TBL_CLASSROOM(ROOM_CODE)
    , CONSTRAINT OCOURSE_COURSE_CODE_FK FOREIGN KEY(COURSE_CODE)
                REFERENCES TBL_COURSE(COURSE_CODE) );
                
-- ������ ����
CREATE SEQUENCE TBL_OCOURSE_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCACHE;

-- COMMENT �߰�
COMMENT ON TABLE TBL_OCOURSE IS '��������';

COMMENT ON COLUMN TBL_OCOURSE.OCOURSE_CODE IS '���������ڵ�';
COMMENT ON COLUMN TBL_OCOURSE.START_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCOURSE.END_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCOURSE.INSERT_DATE IS '��������';
COMMENT ON COLUMN TBL_OCOURSE.COURSE_CODE IS '����.�����ڵ� ����Ű';
COMMENT ON COLUMN TBL_OCOURSE.ROOM_CODE IS '���ǽ�.���ǽ��ڵ� ����Ű';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_OCOURSE_INSERT(TO_DATE('2022-06-01','YYYY-MM-DD'), TO_DATE('2022-06-30','YYYY-MM-DD'), 1, 1);
EXEC PRC_OCOURSE_INSERT(TO_DATE('2022-07-01','YYYY-MM-DD'), TO_DATE('2022-07-30','YYYY-MM-DD'), 2, 2);
EXEC PRC_OCOURSE_INSERT(TO_DATE('2022-08-01','YYYY-MM-DD'), TO_DATE('2022-08-30','YYYY-MM-DD'), 3, 3);
EXEC PRC_OCOURSE_INSERT(TO_DATE('2022-09-01','YYYY-MM-DD'), TO_DATE('2022-09-30','YYYY-MM-DD'), 4, 4);
EXEC PRC_OCOURSE_INSERT(TO_DATE('2022-09-01','YYYY-MM-DD'), TO_DATE('2022-09-30','YYYY-MM-DD'), 4, 4);

    -- Ʈ���� �� ���ν��� �׽�Ʈ�� ������
EXEC PRC_OCOURSE_INSERT(TO_DATE('2022-10-01','YYYY-MM-DD'), TO_DATE('2023-09-30','YYYY-MM-DD'), 4, 4); 
EXEC PRC_OCOURSE_INSERT(TO_DATE('2023-11-01','YYYY-MM-DD'), TO_DATE('2023-11-30','YYYY-MM-DD'), 5, 4);

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_OCOURSE_UPDATE(5, TO_DATE('2022-09-20', 'YYYY-MM-DD'), TO_DATE('2022-10-20'), 4, 2);       -- �̹� ���� ���� ����
EXEC PRC_OCOURSE_UPDATE(10, TO_DATE('2022-09-20', 'YYYY-MM-DD'), TO_DATE('2022-10-20'), 4, 2);      -- ���� ������
EXEC PRC_OCOURSE_UPDATE(6, TO_DATE('2022-10-10', 'YYYY-MM-DD'), TO_DATE('2022-10-20'), 4, 2);

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_OCOURSE_DELETE(6);
EXEC PRC_OCOURSE_DELETE(7);     -- Ʈ���� �׽�Ʈ��

SELECT *
FROM TBL_OCOURSE;
SELECT *
FROM TBL_OCLASS;
SELECT *
FROM TBL_COURSE;


-- TBL_TEXTBOOK(����) ���� ----------------------------------------------------- 

CREATE TABLE TBL_TEXTBOOK
( BOOK_CODE     NUMBER                                                          -- ���� �ڵ� (PK)
, BOOK_NAME     VARCHAR2(20)    CONSTRAINT TEXTBOOK_BOOK_NAME_NN NOT NULL       -- �����
, BOOK_PUB      VARCHAR2(20)                                                    -- ���ǻ�
, CONSTRAINT TEXTBOOK_BOOK_CODE_PK PRIMARY KEY(BOOK_CODE)
);

-- ������ ����
CREATE SEQUENCE TBL_TEXTBOOK_SEQ
NOCACHE;

-- COMMENT �߰�
COMMENT ON TABLE TBL_TEXTBOOK IS '���� ���̺�';

COMMENT ON COLUMN TBL_TEXTBOOK.BOOK_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_TEXTBOOK.BOOK_NAME IS '�����';
COMMENT ON COLUMN TBL_TEXTBOOK.BOOK_PUB IS '���ǻ�.';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_TEXTBOOK_INSERT('���� ����', NULL);       -- ������ ������
EXEC PRC_TEXTBOOK_INSERT('DB', '����');            -- ������ ������
EXEC PRC_TEXTBOOK_INSERT('DB', '����');            -- �ߺ� ������ �׽�Ʈ

    -- Ʈ���� �� ���ν��� �׽�Ʈ�� ������
EXEC PRC_TEXTBOOK_INSERT('�ڹ�', NULL);
EXEC PRC_TEXTBOOK_INSERT('����Ŭ', NULL);

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_TEXTBOOK_UPDATE(3, '�ڹ�', 'å�� ���');
EXEC PRC_TEXTBOOK_UPDATE(4, '�ڹ�', 'å�� ���');     -- ���� ������

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_TEXTBOOK_DELETE(4);

SELECT *
FROM TBL_TEXTBOOK;

COMMIT;


-- TBL_OCLASS(���� ����) ���� --------------------------------------------------

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

-- FK �������� �߰�
ALTER TABLE TBL_OCLASS
ADD CONSTRAINT OCLASS_ABLE_V_FK FOREIGN KEY(ABLE_CODE)
                    REFERENCES TBL_ABLE(ABLE_CODE);

ALTER TABLE TBL_OCLASS
ADD CONSTRAINT OCLASS_OCOURSE_CODE_FK FOREIGN KEY(OCOURSE_CODE)
                    REFERENCES TBL_OCOURSE(OCOURSE_CODE);

ALTER TABLE TBL_OCLASS
ADD CONSTRAINT OCLASS_BOOK_CODE_FK FOREIGN KEY(BOOK_CODE)
                    REFERENCES TBL_TEXTBOOK(BOOK_CODE);
                    
-- ������ �߰�
CREATE SEQUENCE TBL_OCLASS_SEQ
NOCACHE;
                    
-- COMMENT �߰�
COMMENT ON TABLE TBL_OCLASS IS '�������� ���̺�';

COMMENT ON COLUMN TBL_OCLASS.OCLASS_CODE IS '�������� �ڵ�';
COMMENT ON COLUMN TBL_OCLASS.START_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCLASS.END_DATE IS '���� ������';
COMMENT ON COLUMN TBL_OCLASS.INSERT_DATE IS '���� ����';
COMMENT ON COLUMN TBL_OCLASS.ABLE_CODE IS '���� ���� ���� �ڵ�';
COMMENT ON COLUMN TBL_OCLASS.OCOURSE_CODE IS '�������� �ڵ�';
COMMENT ON COLUMN TBL_OCLASS.BOOK_CODE IS '���� �ڵ�';

SELECT *
FROM TBL_OCOURSE;

-- INSERT �׽�Ʈ
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);   
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);   
--> ������������ �� ū ������ �������� ��¥ ���� ��
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-06-02', 'YYYY-MM-DD'), TO_DATE('2022-06-30', 'YYYY-MM-DD'), 1, 1, 1);   
--> �������ں��� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-06-02', 'YYYY-MM-DD'), TO_DATE('2022-06-01', 'YYYY-MM-DD'), 2, 1, 1);   
--> �������ں��� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-12-25', 'YYYY-MM-DD'), TO_DATE('2022-11-01', 'YYYY-MM-DD'), 2, 1, 1);   
--> �����Ϻ��� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), TO_DATE('2022-09-30', 'YYYY-MM-DD'), 1, 5, 100);   
--> ���� ���� ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), TO_DATE('2022-09-30', 'YYYY-MM-DD'), 100, 5, 1);   
--> ���� ������ �����Ͱ� ���� ���
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-30', 'YYYY-MM-DD'), TO_DATE('2022-10-01', 'YYYY-MM-DD'), 3, 5, 1);   
--> ���������� �ִ� A������ �������� ��¥�� ���� ��¥�� �ֱ�
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-30', 'YYYY-MM-DD'), TO_DATE('2022-10-01', 'YYYY-MM-DD'), 3, 5, 1);   
--> ���������� �ִ� A������ �������� ��¥ ������ ��¥�� �ֱ�
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-29', 'YYYY-MM-DD'), TO_DATE('2022-10-02', 'YYYY-MM-DD'), 3, 5, 1);   
--> ���������� �ִ� A������ �������� ��¥�� ���� �� ū ��¥�� �ֱ�
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-30', 'YYYY-MM-DD'), TO_DATE('2022-10-01', 'YYYY-MM-DD'), 3, 5, 1);  
--> ������ ������
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-09-30', 'YYYY-MM-DD'), TO_DATE('2022-10-01', 'YYYY-MM-DD'), 1, 5, 1);  
EXEC PRC_OCLASS_INSERT(TO_DATE('2022-10-02', 'YYYY-MM-DD'), TO_DATE('2022-10-20', 'YYYY-MM-DD'), 1, 6, 1);  

-- UPDATE
EXEC PRC_OCLASS_UPDATE(TO_DATE('2022-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 1, 1, 1);          -- ������������ �� ū ������ �������� ��¥
EXEC PRC_OCLASS_UPDATE(TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 6, 100);        -- ���� ����
EXEC PRC_OCLASS_UPDATE(TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 100, 6, 1);        -- ���� ���� ���� �ڵ�
EXEC PRC_OCLASS_UPDATE(TO_DATE('2022-09-30', 'YYYY-MM-DD'), TO_DATE('2022-10-01', 'YYYY-MM-DD'), 2, 5, 1);          -- ���� �ߺ�
EXEC PRC_OCLASS_UPDATE(TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1, 6, 1);

-- DELETE �׽�Ʈ
EXEC PRC_OCLASS_DELETE(3);

SELECT *
FROM TBL_OCLASS;
SELECT *
FROM TBL_POINT;


-- TBL_STUDENT(�л�) ���� ------------------------------------------------------

CREATE TABLE TBL_STUDENT 
( STU_ID	    VARCHAR2(30)	                                                            -- �л� ���̵� (PK)
, STU_NAME	    VARCHAR2(30)	    CONSTRAINT STUDENT_STU_NAME_NN NOT NULL                 -- �л���
, STU_PW	    VARCHAR2(15)	CONSTRAINT STUDENT_STU_PW_NN NOT NULL                   -- �л� ��й�ȣ
, STU_SSN	    CHAR(14)        CONSTRAINT STUDENT_STU_SSN_NN NOT NULL                  -- �ֹε�Ϲ�ȣ
, STU_EMAIL	    VARCHAR2(30)	                                                            -- �л� �̸���
, STU_PHONE	    VARCHAR2(20)	                                                            -- �л� ��ȭ��ȣ
, STU_DATE	    DATE    DEFAULT SYSDATE     CONSTRAINT STUDENT_STU_DATE_NN NOT NULL     -- �л� ���Գ�¥
, CONSTRAINT STUDENT_STU_ID_PK PRIMARY KEY(STU_ID)
);

-- UK �������� �߰�
ALTER TABLE TBL_STUDENT
ADD CONSTRAINT STUDENT_STU_SSN_UK UNIQUE(STU_SSN);

-- COMMENT �߰�
COMMENT ON TABLE TBL_STUDENT IS '�л����̺�';

COMMENT ON COLUMN TBL_STUDENT.STU_ID IS '�л� ���̵�';
COMMENT ON COLUMN TBL_STUDENT.STU_NAME IS '�л� �̸�';
COMMENT ON COLUMN TBL_STUDENT.STU_PW IS '�л� ��й�ȣ';
COMMENT ON COLUMN TBL_STUDENT.STU_SSN IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN TBL_STUDENT.STU_EMAIL IS '�л� �̸���';
COMMENT ON COLUMN TBL_STUDENT.STU_PHONE IS '�л� ��ȭ��ȣ';
COMMENT ON COLUMN TBL_STUDENT.STU_DATE IS '�л� ���Գ�¥';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_STUDENT_INSERT('ID1', '���α�', '990325-2111111', 'a@naver.com',  '010-1111-1111');
EXEC PRC_STUDENT_INSERT('ID2', '������', '930325-1111111', 'b@naver.com',  '010-1111-1112');
EXEC PRC_STUDENT_INSERT('ID3', '������', '990325-1111112', 'c@naver.com',  '010-1111-1113');
EXEC PRC_STUDENT_INSERT('ID4', '���¹�', '990326-2111111', 'd@naver.com',  '010-1111-1114');
EXEC PRC_STUDENT_INSERT('ID6', '����', '940326-2111111', 'd@naver.com',  '010-1111-1114');

EXEC PRC_STUDENT_INSERT('ID5', '����', '940325-2111111', 'd@naver.com',  '010-1111-1114');       -- DELETE �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_STUDENT_UPDATE('ID8', '1111111', '���α�', '990325-2111111', '', '010-1111-1111');        -- ���� ������
EXEC PRC_STUDENT_UPDATE('ID8', '1111111', '���α�', '930325-2111111', '', '010-1111-1111');        -- �ߺ� ssn
EXEC PRC_STUDENT_UPDATE('ID1', '1111111', '���α�', '990325-2111111', '', '010-1111-1111');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_STUDENT_DELETE('ID5');

SELECT *
FROM TBL_STUDENT;


-- TBL_REASON(Ż�� ����) ���� --------------------------------------------------

CREATE TABLE TBL_REASON         
( REASON_CODE  NUMBER                                                           -- Ż�� ���� �ڵ�(PK)
, REASON_MEMO   VARCHAR2(50)    CONSTRAINT REASON_REASON_MEMO_NN NOT NULL       -- Ż�� ����
, CONSTRAINT REASON_REASON_CODE_PK PRIMARY KEY(REASON_CODE)
);

-- COMMENT �߰�
COMMENT ON TABLE TBL_REASON IS 'Ż�� ���� ���̺�';
COMMENT ON COLUMN TBL_REASON.REASON_CODE IS 'Ż�� ���� �ڵ�';
COMMENT ON COLUMN TBL_REASON.REASON_MEMO IS 'Ż�� ����';


-- ������ ���� - �⺻ ������ �ۼ�
CREATE SEQUENCE TBL_REASON_SEQ
START WITH 1                       -- ���۰�
INCREMENT BY 1
NOMAXVALUE 
NOCACHE;

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_REASON_INSERT('Ż��'); 
EXEC PRC_REASON_INSERT('Ż��');         -- �ߺ�������
EXEC PRC_REASON_INSERT('����');  
EXEC PRC_REASON_INSERT('���κ���'); 
EXEC PRC_REASON_INSERT('�µ��ҷ�'); 
EXEC PRC_REASON_INSERT('���');
EXEC PRC_REASON_INSERT('�����̴�');

EXEC PRC_REASON_INSERT('�µ��ҷ�');     -- DELETE ���ν��� �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_REASON_UPDATE(8, '�µ��ҷ�');      -- ���� ������
EXEC PRC_REASON_UPDATE(4, '�⼮�̴�');

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_REASON_DELETE(8);              -- ���� ������
EXEC PRC_REASON_DELETE(6);

SELECT *
FROM TBL_REASON;

COMMIT;


-- TBL_SIGN(������û) ���� -----------------------------------------------------

CREATE TABLE TBL_SIGN
( SIGN_CODE     NUMBER                                                                    -- ������û �ڵ�(PK)
, SIGN_DATE     DATE            DEFAULT SYSDATE CONSTRAINT SIGN_SIGN_DATE_NN NOT NULL     -- Ż�� ����
, STU_ID        VARCHAR2(10)    CONSTRAINT SIGN_STU_ID_NN NOT NULL                        -- ������û �ڵ�(FK: TBL_STUDENT)
, OCOURSE_CODE  NUMBER          CONSTRAINT SIGN_OCOURSE_CODE_NN NOT NULL                    -- �������� �ڵ�(FK: TBL_OCOURSE)
, CONSTRAINT SIGN_SIGN_CODE_PK PRIMARY KEY(SIGN_CODE)
);

-- FK �������� �߰�
ALTER TABLE TBL_SIGN
ADD ( CONSTRAINT SIGN_STU_ID_FK FOREIGN KEY(STU_ID)
                 REFERENCES TBL_STUDENT(STU_ID)
    , CONSTRAINT SIGN_OCOURSE_CODE_FK FOREIGN KEY(OCOURSE_CODE)
                 REFERENCES TBL_OCOURSE(OCOURSE_CODE) );

-- COMMENT �߰�
COMMENT ON TABLE TBL_SIGN IS '������û ���̺�';

COMMENT ON COLUMN TBL_SIGN.SIGN_CODE IS '������û �ڵ�';
COMMENT ON COLUMN TBL_SIGN.SIGN_DATE IS '������û ��¥';
COMMENT ON COLUMN TBL_SIGN.STU_ID IS '�л� ���̵�';
COMMENT ON COLUMN TBL_SIGN.OCOURSE_CODE IS '�������� �ڵ�';


-- ������ ����
CREATE SEQUENCE TBL_SIGN_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE 
NOCACHE;


-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_SIGN_INSERT('ID1', 5); 
EXEC PRC_SIGN_INSERT('ID2', 5); 
EXEC PRC_SIGN_INSERT('ID3', 5);   
EXEC PRC_SIGN_INSERT('ID4', 5);   
EXEC PRC_SIGN_INSERT('ID5', 5);
EXEC PRC_SIGN_INSERT('ID6', 5);         -- ���� ������

EXEC PRC_SIGN_INSERT('ID7', 5);         -- UPDATE �� DELETE �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_SIGN_UPDATE(1, 'ID1', 4);      -- �̹� ���� ���� ����
EXEC PRC_SIGN_UPDATE(5, 'ID6', 5);      -- �л� ������ �߰� �� ������Ʈ

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_SIGN_DELETE(1);            -- ������ �̹� �Էµ� �л�
EXEC PRC_SIGN_DELETE(8);            -- ���� ������
EXEC PRC_SIGN_DELETE(6);


SELECT *
FROM TBL_SIGN;
SELECT *
FROM TBL_OCOURSE;
SELECT *
FROM TBL_GRADE;



-- TBL_FAIL(�ߵ� Ż��) ���� ----------------------------------------------------

CREATE TABLE TBL_FAIL
( FAIL_CODE     NUMBER                                                                      -- �ߵ� Ż�� �ڵ�(PK)                
, FAIL_DATE     DATE          CONSTRAINT FAIL_FAIL_DATE_NN NOT NULL                         -- Ż�� ����
, SIGN_CODE     NUMBER        CONSTRAINT FAIL_SIGN_CODE_NN NOT NULL                         -- ������û �ڵ�(FK: TBL_SIGN)
, REASON_CODE   NUMBER        CONSTRAINT FAIL_REASON_CODE_NN NOT NULL                       -- Ż�� ���� �ڵ�(FK: TBL_REASON)
, CONSTRAINT FAIL_FAIL_CODE_PK PRIMARY KEY(FAIL_CODE)
);

-- FK �������� �߰�
ALTER TABLE TBL_FAIL
ADD ( CONSTRAINT FAIL_FAIL_CODE_FK FOREIGN KEY(SIGN_CODE)
                 REFERENCES TBL_SIGN(SIGN_CODE)
    , CONSTRAINT FAIL_REASON_CODE_FK FOREIGN KEY(REASON_CODE)
                 REFERENCES TBL_REASON(REASON_CODE) );

-- COMMENT �߰�
COMMENT ON TABLE TBL_FAIL IS '�ߵ� Ż�� ���̺�';

COMMENT ON COLUMN TBL_FAIL.FAIL_CODE IS '�ߵ� Ż�� �ڵ�';
COMMENT ON COLUMN TBL_FAIL.FAIL_DATE IS 'Ż�� ����';
COMMENT ON COLUMN TBL_FAIL.SIGN_CODE IS '������û �ڵ�';
COMMENT ON COLUMN TBL_FAIL.REASON_CODE IS 'Ż�� ���� �ڵ�';

-- ������ ����
CREATE SEQUENCE TBL_FAIL_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE 
NOCACHE;

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 1, 5);
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 2, 5);
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 3, 5);
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 4, 5);
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 5, 5);
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 5, 5);        -- �ߺ� ������

    -- Ʈ���� �� ���ν��� �׽�Ʈ�� ������
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 5, 5);
EXEC PRC_FAIL_INSERT(TO_DATE('2022-09-14', 'YYYY-MM-DD'), 5, 5);

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_FAIL_UPDATE(1, TO_DATE('2022-09-15', 'YYYY-MM-DD'), 100, 5);         -- ���� ������û ������
EXEC PRC_FAIL_UPDATE(1, TO_DATE('2022-09-15', 'YYYY-MM-DD'), 1, 100);         -- ���� ���� ������
EXEC PRC_FAIL_UPDATE(1, TO_DATE('2022-09-15', 'YYYY-MM-DD'), 1, 5);

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_FAIL_DELETE(100);      -- ���� ������
EXEC PRC_FAIL_DELETE(4);
EXEC PRC_FAIL_DELETE(5);

SELECT *
FROM TBL_FAIL;
SELECT *
FROM TBL_OCLASS;
SELECT *
FROM TBL_SIGN;



-- TBL_POINT(����) ���� --------------------------------------------------------

CREATE TABLE TBL_POINT
( POINT_CODE        NUMBER                                                                  -- �����ڵ� (PK)
, POINT_ATTEND      NUMBER(3)       CONSTRAINT POINT_POINT_ATTEND_NN NOT NULL               -- ��� ���� 
, POINT_PRACTICE    NUMBER(3)       CONSTRAINT POINT_POINT_PRACTICE_NN NOT NULL             -- �Ǳ� ����
, POINT_WRITE       NUMBER(3)       CONSTRAINT POINT_POINT_WRITE_NN NOT NULL                -- �ʱ� ����
, OCLASS_CODE       NUMBER          CONSTRAINT POINT_OCLASS_CODE_NN NOT NULL                -- �������� �ڵ� (FK : TBL_OCLASS)
, CONSTRAINT POINT_POINT_CODE_PK PRIMARY KEY(POINT_CODE)
);

-- FK �������� �߰�
ALTER TABLE TBL_POINT
ADD CONSTRAINT POINT_OCLASS_CODE_FK FOREIGN KEY(OCLASS_CODE)
                    REFERENCES TBL_OCLASS(OCLASS_CODE);
                    
-- ������ ����
CREATE SEQUENCE TBL_POINT_SEQ
NOCACHE;
                    
-- COMMENT �߰�
COMMENT ON TABLE TBL_POINT IS '���� ���̺�';

COMMENT ON COLUMN TBL_POINT.POINT_CODE IS '���� �ڵ�';
COMMENT ON COLUMN TBL_POINT.POINT_ATTEND IS '���'; 
COMMENT ON COLUMN TBL_POINT.POINT_PRACTICE IS '�Ǳ�'; 
COMMENT ON COLUMN TBL_POINT.POINT_WRITE IS '�ʱ�'; 
COMMENT ON COLUMN TBL_POINT.OCLASS_CODE IS '�������� �ڵ�';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_POINT_INSERT(0,0,0,100);         -- ���µ����� 
EXEC PRC_POINT_INSERT(20, 20, 60, 1);     -- �ߺ������� 
EXEC PRC_POINT_INSERT(-1, 60, 20, 2);     -- �⼮ ����
EXEC PRC_POINT_INSERT(20, -1, 60, 2);     -- �Ǳ� ���� 
EXEC PRC_POINT_INSERT(20, 60, -1, 2);     -- �ʱ� ���� 
EXEC PRC_POINT_INSERT(100, 100, 100, 2);  -- ���� 100 �̻� 
EXEC PRC_POINT_INSERT(1, 1, 1, 2);        -- ���� 100 ���� 
EXEC PRC_POINT_INSERT(20, 20, 60, 2);     -- ������ ������ 
EXEC PRC_POINT_INSERT(0, 0, 0, 2);       -- 0�� ���� ������ ������

EXEC PRC_POINT_INSERT(40, 10, 50, 2);     -- �׽�Ʈ�� ������

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_POINT_UPDATE(10, 20, 20, 60);      -- ���� ������
EXEC PRC_POINT_UPDATE(3, 20, 20, 70);       -- ���� 100 �ʰ�
EXEC PRC_POINT_UPDATE(3, 20, 20, 40);       -- ���� 100 �̸�
EXEC PRC_POINT_UPDATE(3, -1, 20, 60);       -- ����
EXEC PRC_POINT_UPDATE(3, 20, 20, 60);

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_POINT_DELETE(10);          -- ���� ������
EXEC PRC_POINT_DELETE(2);

SELECT *
FROM TBL_POINT;


-- TBL_GRADE(����) ���� --------------------------------------------------------

CREATE TABLE TBL_GRADE
( GRADE_CODE        NUMBER  	                                                -- �����ڵ� (PK)
, GRADE_ATTEND	    NUMBER(3)	                                                -- ���
, GRADE_PRACTICE	NUMBER(3)	                                                -- �Ǳ�
, GRADE_WRITE	    NUMBER(3)	                                                -- �ʱ�
, OCLASS_CODE       NUMBER  	    CONSTRAINT GRADE_OCLASS_CODE_NN NOT NULL    -- �������� �ڵ� (FK : TBL_OCLASS)                
, SIGN_CODE	        NUMBER  	    CONSTRAINT GRADE_SIGN_CODE_NN NOT NULL      -- ������û �ڵ� (FK : TBL_SIGN)
, CONSTRAINT GRADE_GRADE_CODE_PK PRIMARY KEY(GRADE_CODE)
);

-- FK �������� �߰�
ALTER TABLE TBL_GRADE 
ADD ( CONSTRAINT GRADE_OCLASS_CODE_FK FOREIGN KEY(OCLASS_CODE) 
                                       REFERENCES  TBL_OCLASS(OCLASS_CODE)
    , CONSTRAINT GRADE_SIGN_CODE_FK  FOREIGN KEY(SIGN_CODE)
                                       REFERENCES TBL_SIGN(SIGN_CODE) );

-- COMMENT �߰�
COMMENT ON TABLE TBL_GRADE IS '���� ���̺�';

COMMENT ON COLUMN TBL_GRADE.GRADE_CODE IS '�����ڵ�';
COMMENT ON COLUMN TBL_GRADE.GRADE_ATTEND IS '���';
COMMENT ON COLUMN TBL_GRADE.GRADE_PRACTICE IS '�Ǳ�';
COMMENT ON COLUMN TBL_GRADE.GRADE_WRITE IS '�ʱ�';
COMMENT ON COLUMN TBL_GRADE.OCLASS_CODE IS '�������� �ڵ�';
COMMENT ON COLUMN TBL_GRADE.SIGN_CODE IS '������û �ڵ�';

-- INSERT ���ν��� �׽�Ʈ
EXEC PRC_GRADE_INSERT(100, 90, 60, 1, 1);
EXEC PRC_GRADE_INSERT(90, 90, 60, 2, 2);
EXEC PRC_GRADE_INSERT(100, 90, 70, 1, 3);
EXEC PRC_GRADE_INSERT(80, 60, 60, 1, 4);
EXEC PRC_GRADE_INSERT(80, 60, 60, 1, 4);        -- �̹� ������ �Էµ� ������
EXEC PRC_GRADE_INSERT(-1, 60, 60, 1, 4);        -- ����
EXEC PRC_GRADE_INSERT(-1, 60, 60, 1, 10);       -- ���� ������û �ڵ�
EXEC PRC_GRADE_INSERT(-1, 60, 60, 10, 4);       -- ���� ���� ���� �ڵ�
EXEC PRC_GRADE_INSERT(100, 100, 100, 2, 1);     -- ���� �������� ���� ���� �ڵ�
EXEC PRC_GRADE_INSERT(40, 20, 100, 2, 5);       -- �����̴� �ߵ�Ż�� �׽�Ʈ

-- UPDATE ���ν��� �׽�Ʈ
EXEC PRC_GRADE_UPDATE(5, 100, 100, 100);        -- ���� ������
EXEC PRC_GRADE_UPDATE(1, 100, 100, 100);

-- DELETE ���ν��� �׽�Ʈ
EXEC PRC_GRADE_DELETE(9);       -- ���� ������
EXEC PRC_GRADE_DELETE(4);


SELECT *
FROM TBL_GRADE;
SELECT *
FROM TBL_OCLASS;

SELECT *
FROM TBL_FAIL;

SELECT *
FROM TBL_SIGN;

DELETE
FROM TBL_FAIL
WHERE FAIL_CODE = 7;

ROLLBACK;









