SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Date Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�

--3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�

--4. Ŀ��, �ѹ�
--==>> TCL(Transaction Control Language)

--------------------------------------------------------------------------------

--����  PROCEDURE(���ν���)  ����--

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó�����ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [�ֿ� ���� ����;]
BEGIN
    -- ���౸��;
    ...
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/

-- �� FUNCTION �� ������ ��, 
--    ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--    ��RETURN�� �� ��ü�� �������� ������,
--    ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--    IN, OUT, INOUT ���� ���еȴ�.


--3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2)]

*/


-- ���ν��� ���� �ǽ� ������ ����
-- 20220901_02_scott.sql ���Ͽ�
-- ���̺� ���� �� ������ �Է� ����

--�� ���ν��� ���� 
-- ���ν��� ��: PRC_STUDENTS_INSERT(���̵�, �н�����, �̸�, ��ȭ, �ּ�)
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
(
    ���̵�, �н�����, �̸�, ��ȭ, �ּ�
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
(   V_ID    IN TBL_STUDENTS.ID%TYPE
,   V_PW    IN TBL_IDPW.PW%TYPE
,   V_NAME  IN TBL_STUDENTS.NAME%TYPE
,   V_TEL   IN TBL_STUDENTS.TEL%TYPE
,   V_ADDR  IN TBL_STUDENTS.ADDR%TYPE

)
IS
    -- �����(�ֿ� ���� ����)
BEGIN
    -- �����(���� �� ó��)
    -- TBL_IDPW ���̺� ������ �Է�
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID,V_PW);
    -- TBL_STUDENTS ���̺� ������ �Է�
    INSERT INTO TBL_STUDENTS(ID,NAME,TEL,ADDR)
    VALUES(V_ID,V_NAME,V_TEL,V_ADDR);
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_SUNGJUK ���̺� ������ �Է� ��
--   Ư�� �׸��� �����͸� �Է��ϸ� 
--   ------------------
--   (�й�, �̸�, ��, ��, ��������)
--   ���������� ����, ���, ��� �׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�(�����Ѵ�)
--   ���ν��� �� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '���ҿ�', 90, 80, 70);

�� ���ν��� ȣ��� ó���� ���
�й�  �̸�  ��������  ��������  ��������  ����  ���  ���
 1   ���ҿ�    90        80        70      240   80     B
*/

-- �ڵ� �ۼ� ���� ����!! �� ~ ��
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( --�� ���� ����
  V_HAKBUN    IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME      IN TBL_SUNGJUK.NAME%TYPE
, V_KOR       IN TBL_SUNGJUK.KOR%TYPE
, V_ENG       IN TBL_SUNGJUK.ENG%TYPE
, V_MAT       IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����(�ֿ� ���� ����)
    --�� INSERT ������ ������ �ϱ� ���� �ʿ��� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����(���� �� ó��)
    --�� INSERT �������� �����ϱ� ����
    --   ����ο��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�
    --   ����, ���, ��� ���ϱ�
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    --V_GRADE := DECODE(TRUNC(V_AVG, -1), 90, 'A', 80, 'B', 70, 'C', 60, 'D', 'F');
    -- ( DECODE �� PL/SQL���� �۵����� ���� �� IF���� CASE���� �̹� �ֱ� ����)
    
--    V_GRADE := CASE TRUNC(V_AVG, -1) WHEN 100 THEN 'A'
--                                     WHEN 90 THEN 'B'
--                                     WHEN 80 THEN 'C'
--                                     WHEN 70 THEN 'D'
--                                     ELSE 'F' 
--                END;

    --�� IF�� ���ǽĿ� ��ȣ ���̴� ������ ���� ��
    --   �־ ������ ������, ���� �� ���� ����� ��찡 �ִ�
    IF (V_AVG >= 90) THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
    
    --�� ������� ������ ������ INSERT ������ ���� 
    --   TBL_SUNGJUK ���̺� ������ �Է�
--    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
--    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, ????, ????, ????);
    
    --�� ���� INSERT ������ ���� 
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);

    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_SUNGJUK ���̺� Ư�� �л��� ���� ������ ���� ��
--   Ư�� �׸��� �����͸� �Է��ϸ� 
--   ------------------
--   (��, ��, ��������)
--   ���������� ����, ���, ��� �׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�(�����Ѵ�)
--   ���ν��� �� : PRC_SUNGJUK_UPDATE()
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);

�� ���ν��� ȣ��� ó���� ���
�й�  �̸�  ��������  ��������  ��������  ����  ���  ���
 1   ���ҿ�    50        50        50      150   50     F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
(
    --�� �ܰ�
  V_HAKBUN    IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR       IN TBL_SUNGJUK.KOR%TYPE
, V_ENG       IN TBL_SUNGJUK.ENG%TYPE
, V_MAT       IN TBL_SUNGJUK.MAT%TYPE
)
IS
    --�� �ܰ�
    -- �����
    -- ������Ʈ ������ ������ ���� �ʿ��� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �� �ܰ�
    -- ������Ʈ ������ ���࿡ �ռ� �߰��� ������ �ֿ� �����鿡 �� ��Ƴ���
    -- ���ο� ����, ���, ��� ���ϱ�
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
 
    --�� IF�� ���ǽĿ� ��ȣ ���̴� ������ ���� ��
    --   �־ ������ ������, ���� �� ���� ����� ��찡 �ִ�                    
    IF (V_AVG >= 90) THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80) THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70) THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60) THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
    
    --�� �ܰ�
    -- ������ ����, ���, ����� ������ ������Ʈ ������ ����
--    UPDATE TBL_SUNGJUK
--    SET KOR = V_KOR
--      , ENG = V_ENG
--      , MAT = V_MAT
--      , TOT = ????
--      , AVG = ????
--      , GRADE = ????
--    WHERE HAKBUN = V_HAKBUN;
    
    --�� �ܰ�
    -- ���� ������Ʈ ������ ����    
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR
      , ENG = V_ENG
      , MAT = V_MAT
      , TOT = V_TOT
      , AVG = V_AVG
      , GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
        
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�
--   ��, ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�
--   ���ν��� �� : PRC_STUDENTS_UPDATE()
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '������ Ⱦ��');
--> �н����� ����ġ --==>> ������ ���� X

EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '������ Ⱦ��');
--> �н����� ��ġ --==>> ������ ���� O
*/

DESC TBL_STUDENTS;
/*
�̸�   ��? ����            
---- -- ------------- 
ID      VARCHAR2(10)  
NAME    VARCHAR2(40)  
TEL     VARCHAR2(20)  
ADDR    VARCHAR2(100) 
*/
DESC TBL_IDPW;
/*
�̸� ��?       ����           
-- -------- ------------ 
ID NOT NULL VARCHAR2(10) 
PW          VARCHAR2(20)
*/

SELECT *
FROM TBL_STUDENTS;
/*
superman	�ֵ���	010-1111-1111	���ֵ� ��������
batman	    ���¹�	010-2222-2222	���� ������
*/

SELECT *
FROM TBL_IDPW;
/*
superman	java002$
batman	    java002$
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
    --�� �ܰ�
    V_ID    IN TBL_STUDENTS.ID%TYPE
,   V_PW    IN TBL_IDPW.PW%TYPE
,   V_TEL   IN TBL_STUDENTS.TEL%TYPE
,   V_ADDR  IN TBL_STUDENTS.ADDR%TYPE
)
IS
    --�� �ܰ�
    -- �����
    V_PW2   TBL_IDPW.PW%TYPE;   -- ���� ����� ���� ��� ����
    V_FLAG  NUMBER := 0;        -- ��,������ ������ ����
BEGIN 
    
    --�� �ܰ�
    -- ������Ʈ ������ ���࿡ �ռ� �߰��� ������ �ֿ� �����鿡 �� ��Ƴ���
    -- �н����尡 �´��� Ȯ��
    -- (����ڰ� �Է��� V_PW �� ���� �н������ �������� Ȯ��)
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE V_FLAG := 2;
    END IF;

    --�� �ܰ�
    -- ��� ��ġ�ϴ��� Ȯ���ϴ� ������ ������ ������Ʈ ������ ����    
--    UPDATE TBL_STUDENTS
--    SET TEL = V_TEL
--      , ADDR = V_ADDR
--    WHERE ID = V_ID
--      AND ????;

    --�� �ܰ�
    -- ���� ������Ʈ ������ ����    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL
      , ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_FLAG = 1;
        
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.


CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
-- �Ű������� ���� �� : ���̵� ��й�ȣ ��ȭ��ȣ �ּ�
  V_ID IN TBL_IDPW.ID%TYPE
, V_PW IN TBL_IDPW.PW%TYPE
, V_TEL IN TBL_STUDENTS.TEL%TYPE
, V_ADDR IN TBL_STUDENTS.TEL%TYPE
)
IS
-- ���� ���� : ���� �� ���� ,,, ����!
BEGIN
-- ���� ���� : "���̵� ��й�ȣ�� TBL_IDPW �� ��ġ�Ѵٸ�" TBL_STUDENTS�� ������Ʈ ���� COMMIT �Ѵ�.
    
    -- ���1
--    UPDATE TBL_STUDENTS
--    SET TEL = V_TEL
--      , ADDR=V_ADDR
--    WHERE ID = V_ID 
--      AND (SELECT PW
--           FROM TBL_IDPW
--           WHERE ID=V_ID) = V_PW;
           
    -- ���2
--    UPDATE TBL_STUDENTS
--    SET TEL = V_TEL
--      , ADDR=V_ADDR
--    WHERE ID = (SELECT P.ID
--                FROM TBL_STUDENTS S JOIN TBL_IDPW P
--                ON S.ID = SA.ID
--                WHERE P.PW = V_PW 
--                  AND P.ID = V_ID);
    -- ���3
    UPDATE(SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
           FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
           ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL
      , T.ADDR = V_ADDR
    WHERE T.ID = V_ID
      AND T.PW = V_PW;
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.



--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   ���� ������ �÷� ��
--   NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   �� ������ �Է� ��
--   NUM �÷�(�����ȣ)�� ����
--   ���� �ο��� ��� ��ȣ�� ������ ��ȣ �� ���� ��ȣ�� �ڵ����� �Է� ó���� �� �ִ�
--   ���ν����� �����Ѵ�
--   ���ν��� �� : PRC_INSA_INSERT()
/*
���� ��)
INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
VALUES(1061, );

EXEC PRC_INSA_INSERT('������', '970124-2234567', SYSDATE, '����', '010-7202-6306', '���ߺ�', '�븮', 2000000, 2000000);

�� ���ν��� ȣ��� ó���� ���
1061 ������ 970124-2234567 2022-09-01 ���� 010-7202-6306 ���ߺ� �븮 2000000 2000000
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
(
  V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM   TBL_INSA.NUM%TYPE;
BEGIN
    
--    V_NUM := SELECT MAX(NUM)
--            FROM TBL_INSA;
    --> �����߻�
    --> PLS-00103: Encountered the symbol "SELECT" when expecting one of the following:
    
--    SELECT MAX(NUM) INTO V_NUM
--    FROM TBL_INSA;
    --> �̷���� TBL_INSA ���̺� �����Ͱ� ���� ��� NUM�� NULL���� ����
    --> NVL()�� NULL ó���� ����� �Ѵ�
    
--    SELECT MAX(NVL(NUM, 0) ) INTO V_NUM
--    FROM TBL_INSA;
--    
--    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
--    VALUES(V_NUM+1, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    -- MAX ������ �̸� +1�� ���ָ� �μ�Ʈ���� +1�� �� �ʿ� ����
    SELECT MAX(NVL(NUM, 0) ) + 1 INTO V_NUM
    FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.
















