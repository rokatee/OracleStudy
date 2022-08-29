SELECT USER
FROM DUAL;
--==>> HR

--■■■ NOT NULL(NN:CK:C) ■■■--
-- 1. 테이블에서 지정한 컬럼의 데이터가 NULL을 갖지 못하도록 하는 제약조건

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] NOT NULL

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- 컬럼명 데이터타입
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼명 IS NOT NULL)

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
-- ADD 보다 MODIFY 절이 더 많이 사용된다.
-- ALTER TABLE 테이블명
-- MODIFY 컬럼명 데이터타입 NOT NULL;

-- 4. 기존 테이블에 데이터가 이미 들어있지 않은 컬럼(→ NULL 인 상태의 컬럼)을
--    NOT NULL 제약조건을 갖게끔 수정하는 경우에는 에러 발생한다. (불가능하다)

--● NOT NULL 지정 실습( 컬럼 레벨의 형식 )
-- 테이블 생성
SELECT *
FROM TAB;
-- 생성된 테이블명 확인

CREATE TABLE TBL_TEST11
( COL1 NUMBER(5)     PRIMARY KEY
, COL2 VARCHAR2(30)  NOT NULL
);
--==>> Table TBL_TEST11이(가) 생성되었습니다.


-- 데이터 입력
INSERT INTO TBL_TEST11(COL1,COL2) VALUES (1,'TEST');
INSERT INTO TBL_TEST11(COL1,COL2) VALUES (2,'ABCD');
INSERT INTO TBL_TEST11(COL1) VALUES (3);                --> 에러 발생
INSERT INTO TBL_TEST11(COL1,COL2) VALUES (3,NULL);      --> 에러 발생

-- 확인
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/

-- 제약 조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*
HR	SYS_C007177	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007178	TBL_TEST11	P	COL1		
*/


--○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
CREATE TABLE TBL_TEST12
( COL1 NUMBER(5) 
, COL2 VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
--==>>
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/


--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST13
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==>> Table TBL_TEST13이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 조회 결과 없음

-- 제약 조건 추가
ALTER TABLE TBL_TEST13
ADD( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST13이(가) 변경되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/


-- ※ NOT NULL 제약조건만 TBL_TEST13 테이블의 COL2에 추가하는 경우
--    다음과 같은 방법도 가능하다. 

-- 테이블생성
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--===>>Table TBL_TEST14이(가) 변경되었습니다.



-- NOT NULL 은 컬럼 레벨에서 지정하기를 권장한다, 그 이유는??

-- 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST11)
DESC TBL_TEST11;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/

-- 테이블 레벨에서 낫널 제약조건을 제정한 테이블
DESC TBL_TEST12;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- 비교해보면 아래는 COL2 에 NOT NULL 이 없다.

--> DESC 를 통해 COL2 컬럼이 NOT NULL 인 정보가 확인되는 상황
-- 아 꼭 DESC에 NOT NULL 이 아니더라도 제약조건이 걸려있으면 널이 못들어가는구나

-- 테이블 생성 이후 ADD를 통해 NOT NULL 제약조건을 추가하였으며
-- 여기에 더하여 MODIFY 절을 통해 NOT NULL 제약조건을 추가한 테이블
DESC TBL_TEST13;
--==>>
/*
이름   널?       유형           
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


--○ NOT NULL 지정 실습(④ 컬럼 레벨의 형식으로 이름 부여)
-- 테이블 생성
CREATE TABLE TBL_TEST14
( COL1 NUMBER(5)        CONSTRAINT TEST14_COL1_PK PRIMARY KEY
, COL2 VARCHAR2(30)     CONSTRAINT TEST14_COL2_NN NOT NULL
);
--==>> Table TBL_TEST14이(가) 생성되었습니다.


-- 제약조건 확인
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
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/


-- NOT NULL 조건은 컬럼 레벨에서 생성하고 이미 테이블이 만들어져있다면 MODIFY 절로 하도록!
-- 주의 할 점은 NOT NULL 제약조건을 테이블 레벨에서 생성할 시 
-- DESC 에서 NOT NULL이 보이지 않는 문제가 생긴다. 

-- 따라서 컬럼 레벨에서 
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] NOT NULL 
-- 로 지정해주거나 

-- 테이블이 이미 생성되어 있다면 MODIFY를 통해 NOT NULL 제약조건을 추가해줘야 한다. 
 
--ALTER TABLE TBL_TEST14
--MODIFY COL2 NOT NULL;



--------------------------------------------------------------------------------
--■■■   DEFAULT 표현식   ■■■

-- 1. INSERT 와 UPDATE문에서
-- 특정 값이 아닌 기본값을 입력하도록 처리할 수 있다. 

-- 2. 형식 및 구조
-- 컬럼명 데이터타입 DEFAULT 기본값

-- 3. INSERT 명령 시 해당 컬럼에 입력될 값을 할당하지 않거나
--    DEFAULT 키워드를 활용하여 기본적으로 설정된 값을 입력하도록 할 수 있다.

-- 4. DEFAUT 키워드와 다른 제약(NOT NULL 등) 표기가 함께 사용되어야 하는 경우
--    DEFAULT 키워드를 먼저 표기(작성)할 것을 권장한다.

-- ● DEFAULT 표현식 실습
-- 테이블 생성
CREATE TABLE TBL_BBS                       -- 게시판 테이블 생성
( SID        NUMBER        PRIMARY KEY     -- 게시물 번호 → 식별자 → 자동 증가
, NAME       VARCHAR2(20)                  -- 게시물 작성자
, CONTENTS   VARCHAR2(200)                 -- 게시물 내용
, WRITEDAY   DATE          DEFAULT SYSDATE -- 게시물 작성일   (현재 날짜 자동 입력)
, COUNTS     NUMBER        DEFAULT 0       -- 게시물 조회 수  (기본값 0 )
, COMMENTS   NUMBER        DEFAULT 0       -- 게시물 댓글 개수(기본값 0)
);
--==>>Table TBL_BBS이(가) 생성되었습니다.

--※ SID를 자동으로 증가 값으로 운영하려면 시퀀스 객체가 필요하다. 
--   자동으로 입력되는 컬럼은 사용자의 입력 항목에서 제외시킬 수 있다.

-- 시퀀스 생성
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==>> Sequence SEQ_BBS이(가) 생성되었습니다.


--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


-- 게시물 작성
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '엄소연', '오라클 DEFAULT 표현식을 실습중입니다.'
      , TO_DATE('2022-08-29 10:48:10', 'YYYY-MM-DD HH24:MI:SS'), 0, 0);
--===>>1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS) 
VALUES (SEQ_BBS.NEXTVAL, '최동현', '계속 실습중입니다.', SYSDATE, 0, 0);
--===>>1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS) 
VALUES (SEQ_BBS.NEXTVAL, '조현하', '열심히 실습중입니다.', DEFAULT, 0, 0);
--===>>1 행 이(가) 삽입되었습니다. 

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES (SEQ_BBS.NEXTVAL, '한은영', '무진장 실습중입니다.', DEFAULT, DEFAULT, DEFAULT);
--===>>1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS) 
VALUES (SEQ_BBS.NEXTVAL, '정미경', '마무리 중입니다.');
--===>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_BBS;
--==>>
/*
1	엄소연	오라클 DEFAULT 표현식을 실습중입니다.	2022-08-29 10:48:10	0	0
2	최동현	계속 실습중입니다.	                    2022-08-29 11:07:25	0	0
3	조현하	열심히 실습중입니다.	                2022-08-29 11:07:27	0	0
4	한은영	무진장 실습중입니다.	                2022-08-29 11:07:29	0	0
5	정미경	마무리 중입니다.	                    2022-08-29 11:07:31	0	0
*/

-- 커밋
COMMIT;
--==>> 커밋 완료

-- ● DEFAULT 표현식 확인(조회)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='TBL_BBS';
--==>>
/*
TBL_BBS	SID	NUMBER			             22			N	1													                    NO	NO		  0		NO	YES	NONE
TBL_BBS	NAME	    VARCHAR2			 20			Y	2											                CHAR_CS	20	NO	NO		 20	B	NO	YES	NONE
TBL_BBS	CONTENTS	VARCHAR2			200			Y	3											                CHAR_CS	200	NO	NO		200	B	NO	YES	NONE
TBL_BBS	WRITEDAY	DATE			      7			Y	4	63	"SYSDATE -- 게시물 작성일   (현재 날짜 자동 입력)"				NO	NO		  0		NO	YES	NONE
TBL_BBS	COUNTS	    NUMBER			     22			Y	5	48	"0       -- 게시물 조회 수  (기본값 0 )"						NO	NO		  0		NO	YES	NONE
TBL_BBS	COMMENTS	NUMBER			     22			Y	6	48	"0       -- 게시물 댓글 개수(기본값 0)"							NO	NO		  0		NO	YES	NONE
*/


-- 테이블 생성 이후 DEFAULT 표현식 추가 / 변경
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT 기본값;

-- 테이블 생성 이후 기존의 DEAULT 표현식 제거(삭제)
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT NULL;