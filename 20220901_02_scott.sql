SELECT USER
FROM DUAL;
--==>> SCOTT

-- 프로시저 관련 실습 진행

-- 실습 테이블 생성
CREATE TABLE TBL_STUDENTS
( ID     VARCHAR2(10)
, NAME   VARCHAR2(40)
, TEL    VARCHAR2(20)
, ADDR   VARCHAR2(100)
);
--==>> Table TBL_STUDENTS이(가) 생성되었습니다.

-- 실습 테이블 생성(TBL_IDPW)
CREATE TABLE TBL_IDPW
( ID     VARCHAR2(10)
, PW     VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>>Table TBL_IDPW이(가) 생성되었습니다.

-- 두 테이블에 데이터 입력
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '최동현', '010-1111-1111', '제주도 서귀포시');
INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java002$');
--==>> 1 행 이(가) 삽입되었습니다. * 2

-- 확인
SELECT *
FROM TBL_STUDENTS;
--==>> superman	최동현	010-1111-1111	제주도 서귀포시

SELECT *
FROM TBL_IDPW;
--==>> superman	java002$

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- 위의 업무를 수행하는 프로시저(INSERT 프로시저, 입력 프로시저)를 생성하게 되면
-- EXECUTE PRC_STUDENTS_INSERT('batman', 'java002$', '김태민', '010-2222-2222', '서울 마포구');
-- EXEC PRC_STUDENTS_INSERT('batman', 'java002$', '김태민', '010-2222-2222', '서울 마포구');    --EXECUTE를 EXEC로 줄여도 된다
-- 이와 같은 구문 한 줄로 양쪽 테이블에 모두 제대로 입력할 수 있다.


--※ 프로시저 생성 구문은
--   20220901_01_scott(plsql).sql 파일 참조~!!!


--○ PRC_STUDENTS_INSERT 프로시저 호출을 통한 확인
EXEC PRC_STUDENTS_INSERT('batman', 'java002$', '김태민', '010-2222-2222', '서울 마포구');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ PRC_STUDENTS_INSERT 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	최동현	010-1111-1111	제주도 서귀포시
batman	    김태민	010-2222-2222	서울 마포구
*/

SELECT *
FROM TBL_IDPW;
--==>>
/*
superman	java002$
batman	    java002$
*/


--○ 실습 테이블 생성(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
(
  HAKBUN    NUMBER          -- 예시일 뿐, 학번은 NUMBER 자료형을 쓰면 안된다
, NAME      VARCHAR2(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK이(가) 생성되었습니다.


--○ 생성된 테이블에 컬럼 추가
--   (총점 → TOT, 평균 → AVG, 등급 → GRADE)
ALTER TABLE TBL_SUNGJUK
ADD (TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR);
--==>> Table TBL_SUNGJUK이(가) 변경되었습니다.

-- ※ 여기서 추가한 컬럼에 대한 항목들은 프로시저 실습을 위해 추가하는 것일 뿐
--    실제 테이블 구조에 적합하지 않다.
--    (국, 영, 수 점수로 등급, 평균, 총점 다 알 수 있는 값이기 때문에)
--    (EX. 국+영+수 = 총점)


--○ 변경된 테이블 구조 확인
DESC TBL_SUNGJUK;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)  
*/


--○ PRC_SUNGJUK_INSERT 프로시저 호출 전 데이터 조회
SELECT *
FROM TBL_SUNGJUK;
--==>> 조회 결과 없음

--○ PRC_SUNGJUK_INSERT 프로시저 호출을 통한 확인
EXEC PRC_SUNGJUK_INSERT(1, '엄소연', 90, 80, 70);
EXEC PRC_SUNGJUK_INSERT(2, '정미경', 80, 70, 60);
EXEC PRC_SUNGJUK_INSERT(3, '임시연', 82, 71, 60);
EXEC PRC_SUNGJUK_INSERT(4, '유동현', 54, 63, 72);
EXEC PRC_SUNGJUK_INSERT(5, '장현성', 44, 33, 22);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ PRC_SUNGJUK_INSERT 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_SUNGJUK;
--==>> 
/*
1	엄소연	90	80	70	240	80	C
2	정미경	80	70	60	210	70	C
3	임시연	82	71	60	213	71	C
4	유동현	54	63	72	189	63	D
5	장현성	44	33	22	99	33	F
*/


--○ PRC_SUNGJUK_UPDATE 프로시저 호출을 통한 확인
EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);
EXEC PRC_SUNGJUK_UPDATE(5, 100, 99, 98);

--○ PRC_SUNGJUK_UPDATE 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_SUNGJUK;
--==>>
/*
1	엄소연	50	50	50	150	50	F
2	정미경	80	70	60	210	70	C
3	임시연	82	71	60	213	71	C
4	유동현	54	63	72	189	63	D
5	장현성	100	99	98	297	99	A
*/




--○ PRC_STUDENTS_UPDATE 프로시저 호출 전 데이터 조회
SELECT *
FROM TBL_STUDENTS;
--==>> 
/*
superman	최동현	010-1111-1111	제주도 서귀포시
batman	    김태민	010-2222-2222	서울 마포구
*/

--○ PRC_STUDENTS_UPDATE 프로시저 호출을 통한 확인
-- 비번이 다를 경우
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '강원도 횡성');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
--> 하지만 비번이 다르므로, 데이터 변경은 이뤄지지 않는다

-- 비번이 같을 경우
EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '강원도 횡성');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ PRC_STUDENTS_UPDATE 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_STUDENTS;
--==>> 
/*
superman	최동현	010-9876-5432	강원도 횡성
batman	    김태민	010-2222-2222	서울 마포구
*/


SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 2;
--==>> 조회 결과 없음

SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 1;
--==>> 조회 결과 있음


SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
ON T1.ID = T2.ID;
--==>>
/*
superman	java002$	010-9876-5432	강원도 횡성
batman	    java002$	010-9876-5432	강원도 횡성
*/



--○ PRC_INSA_INSERT 프로시저를 만들기 위해 NUM 최대값 체크
--   (최대값 다음 숫자를 자동으로 부여해 데이터 추가하기 위함)
SELECT *
FROM TBL_INSA;
-- 조회결과 NUM 최대값 : 1060

--○ PRC_INSA_INSERT 프로시저 호출 전 데이터 조회
SELECT *
FROM TBL_INSA;
--==>> 
/*
기존 데이터 유지
*/

--○ PRC_INSA_INSERT 프로시저 호출을 통한 확인
EXEC PRC_INSA_INSERT('조현하', '970124-2234567', SYSDATE, '서울', '010-7202-6306', '개발부', '대리', 2000000, 2000000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ PRC_INSA_INSERT 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_INSA;
--==>> 
/*
『1061	조현하	970124-2234567	2022-09-01	서울	010-7202-6306	개발부	대리	2000000	2000000』
기존 부여된 사원 번호 마지막 번호의 그 다음 번호가 된 데이터가 추가된 것을 확인할 수 있음
*/




--○ 실습 테이블 생성(TBL_상품)
CREATE TABLE TBL_상품
( 상품코드       VARCHAR2(20)
, 상품명         VARCHAR2(100)
, 소비자가격     NUMBER
, 재고수량       NUMBER DEFAULT 0
, CONSTRAINT 상품_상품코드_PK PRIMARY KEY(상품코드)
);
--==>> Table TBL_상품이(가) 생성되었습니다.


--○ 실습 테이블 생성(TBL_입고)
-- 한글로 만들지만 실무에선 절대 이렇게 하지말자 실습을 위한 테이블

CREATE TABLE TBL_입고
( 입고번호  NUMBER
, 상품코드  VARCHAR2(20)
, 입고일자  DATE DEFAULT SYSDATE
, 입고수량  NUMBER
, 입고단가  NUMBER
, CONSTRAINT 입고_입고번호_PK PRIMARY KEY(입고번호)
, CONSTRAINT 입고_상품코드_FK FOREIGN KEY(상품코드) 
                REFERENCES TBL_상품(상품코드)
);
--==>> Table TBL_입고이(가) 생성되었습니다.


--○ TBL_상품 테이블에 상품 데이터 입력
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C001', '구구콘', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C002', '월드콘', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C003', '브라보콘', 1300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C004', '누가콘', 1800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C005', '슈퍼콘', 1900);
--==>> 1 행 이(가) 삽입되었습니다. * 5

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H001', '스크류바', 1000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H002', '캔디바', 300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H003', '쌍쌍바', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H004', '돼지바', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H005', '메로나', 500);
--==>> 1 행 이(가) 삽입되었습니다. * 5

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E001', '찰떡아이스', 2500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E002', '붕어싸만코', 2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E003', '빵또아', 2300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E004', '거북알', 2300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E005', '쿠키오', 2400);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E006', '국화빵', 2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E007', '투게더', 3000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E008', '엑설런트', 3000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E009', '셀렉션', 3000);
--==>> 1 행 이(가) 삽입되었습니다. * 9

--○ 확인
SELECT *
FROM TBL_상품;
--==>>
/*
C001	구구콘	    1500	0
C002	월드콘	    1500	0
C003	브라보콘	1300	0
C004	누가콘	    1800	0
C005	슈퍼콘	    1900	0
H001	스크류바	1000	0
H002	캔디바	     300	0
H003	쌍쌍바	     500	0
H004	돼지바	     600	0
H005	메로나	     500	0
E001	찰떡아이스	2500	0
E002	붕어싸만코	2000	0
E003	빵또아	    2300	0
E004	거북알	    2300	0
E005	쿠키오	    2400	0
E006	국화빵	    2000	0
E007	투게더	    3000	0
E008	엑설런트	3000	0
E009	셀렉션	    3000	0
*/

--○ 커밋
COMMIT;
--==> 커밋 완료.

--○ TBK_입고 테이블에 데이터 넣기 전 아래 두 개의 차이 유의!!
SELECT MAX(입고번호) 
FROM TBL_입고;
--==>> 빈 row 하나는 리턴된다

SELECT NVL(입고번호, 0) 
FROM TBL_입고;
--==>> 아무 row도 반환되지 않는다
--※ 그러므로 맥스화 부터 시켜주고 널값을 처리해야 한다


--○ PRC_입고_INSERT 프로시저 호출 전 데이터 조회
SELECT * 
FROM TBL_입고;
--==>> 조회 결과 없음

SELECT * 
FROM TBL_상품;
--==>> 기존 데이터 유지 확인

--○ PRC_입고_INSERT 프로시저 호출을 통한 확인
EXEC PRC_입고_INSERT('C001', 30, 1200);   -- 구구콘 30개 입고

EXEC PRC_입고_INSERT('C002', 30, 1200);   -- 월드콘 30개 입고

EXEC PRC_입고_INSERT('H001', 50, 800);    -- 캔디바 50개 입고

EXEC PRC_입고_INSERT('H002', 50, 200);    -- 스크류바 50개 입고

EXEC PRC_입고_INSERT('H001', 50, 800);    -- 캔디바 50개 추가 입고

EXEC PRC_입고_INSERT('H002', 50, 200);    -- 스크류바 50개 추가 입고
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ PRC_입고_INSERT 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_입고;
--==>> 
/*
입고 데이터 추가된 것 확인
1	C001	2022-09-02	30	1200
2	C002	2022-09-02	30	1200
3	H001	2022-09-02	50	 800
4	H002	2022-09-02	50	 200
5	H001	2022-09-02	50	 800
6	H002	2022-09-02	50	 200
*/

SELECT * 
FROM TBL_상품;
--==>> 
/*
기존 데이터 변경 확인
C001	구구콘	    1500	30
C002	월드콘	    1500	30
    :
H001	스크류바	1000   100
H002	캔디바	     300   100
*/

--○ 실습 테이블 생성(TBL_출고)
CREATE TABLE TBL_출고
( 출고번호  NUMBER
, 상품코드  VARCHAR2(20)
, 출고일자  DATE DEFAULT SYSDATE
, 출고수량  NUMBER
, 출고단가  NUMBER
);
--==>>Table TBL_출고이(가) 생성되었습니다.

--○ TBL_출고 테이블의 출고번호에 PK 제약조건 지정
ALTER TABLE TBL_출고
ADD CONSTRAINT 출고_출고번호_PK PRIMARY KEY(출고번호);
--==>>Table TBL_출고이(가) 변경되었습니다.


--○ TBL_출고 테이블의 상품코드는 TBL_상품테이블의 상품코드를 
-- 참조할 수 있도록 외래키(FK) 제약조건 지정
ALTER TABLE TBL_출고
ADD CONSTRAINT 출고_상품코드_FK FOREIGN KEY(상품코드)
               REFERENCES TBL_상품(상품코드);
--==>> Table TBL_출고이(가) 변경되었습니다.


--○ PRC_출고_INSERT 프로시저 호출 전 데이터 조회
SELECT * 
FROM TBL_출고;
--==>> 조회 결과 없음

SELECT * 
FROM TBL_상품;
--==>> 
/*
H001	스크류바	1000	100
기존 데이터와 동일한 것 확인
*/

--○ 프로시저 호출을 통한 확인
EXEC PRC_출고_INSERT('H001', 50, 1000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ PRC_출고_INSERT 프로시저 호출 이후 데이터 조회
SELECT * 
FROM TBL_출고;
--==>> 1	H001	2022-09-02	50	1000

SELECT * 
FROM TBL_상품;
--==>> 
/*
H001	스크류바	1000	50
재고수량 출고된 것 확인
*/

--○ PRC_출고_INSERT 프로시저 호출 이후 추가 출고
EXEC PRC_출고_INSERT('H001', 80, 1000);
--==>> 에러발생
--> ORA-20002: 재고수량 부족

--○ PRC_출고_INSERT 프로시저 호출 이후 데이터 조회
SELECT * 
FROM TBL_출고;
--==>> 
/*
1	H001	2022-09-02	50	1000
재고수량 에러로 인해 출고 데이터 변동 없는 것 확인
*/

SELECT * 
FROM TBL_상품;
--==>> 
/*
H001	스크류바	1000	50
재고수량 에러로 인해 재고수량 변동 없는 것 확인
*/

--------------------------------------------------------------------------------
--■■■ 프로시저 내에서의 예외 처리 ■■■--

--○ 실습 테이블 생성(TBL_MEMBER)
CREATE TABLE TBL_MEMBER
( NUM   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CITY  VARCHAR2(60)
, CONSTRAINT MEMBER_NUM_PK PRIMARY KEY(NUM)
);
--==>> Table TBL_MEMBER이(가) 생성되었습니다.

--○ 프로시저 호출을 통한 확인
EXEC PRC_MEMBER_INSERT('임시연', '010-1111-1111', '서울');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--확인
SELECT *
FROM TBL_MEMBER;
--==>> 1	임시연	010-1111-1111	서울
--> 데이터 입력된 것 확인

EXEC PRC_MEMBER_INSERT('김보경', '010-2222-2222', '부산');
--==>> 에러 발생
--> ORA-20001: 서울, 경기, 대전만 입력이 가능합니다
--> 데이터 입력 X

--확인
SELECT *
FROM TBL_MEMBER;
--> 데이터 입력 안된 것 확인

--------------------------------------------------------------------------------

--○ PRC_출고_INSERT 프로시저 호출 전 데이터 조회
SELECT *
FROM TBL_출고;
--==>> 1	H001	2022-09-02	50	1000
--> 기존 데이터와 동일한 것 확인

SELECT *
FROM TBL_상품;
--==>> H001	스크류바	1000	50
--> 기존 데이터와 동일한 것 확인

--○ 프로시저 호출을 통한 확인
EXEC PRC_출고_UPDATE(1, 110);
--==>> 재고가 10개 부족해 에러 발생
--> ORA-20002: 재고수량 부족

EXEC PRC_출고_UPDATE(1, 100);
--==>> 
/*
해당 프로시저를 호출하면
출고 테이블에서 출고번호 1번의 출고수량이 100개 추가되어 100개가 되어야 하고 
상품 테이블에서 출고번호 1번인 H001 의 재고수량이 50개 감소되어 0개 되어야 한다
*/

--○ PRC_출고_INSERT 프로시저 호출 이후 데이터 조회
SELECT *
FROM TBL_출고;
--==>> 1	H001	2022-09-02	100	1000

SELECT *
FROM TBL_상품;
--==>> H001	스크류바	1000	0







--○ PRC_출고_INSERT 프로시저 호출 전 데이터 조회
SELECT *
FROM TBL_출고;
--==>> 1	H001	2022-09-02	100	1000
--> 기존 데이터와 동일한 것 확인

SELECT *
FROM TBL_상품;
--==>> H001	스크류바	1000	0
--> 기존 데이터와 동일한 것 확인

--○ 프로시저 호출을 통한 확인
EXEC PRC_출고_DELETE(2);
--==>> 출고번호 2번이 없어 에러발생
--> ORA-01403: no data found

EXEC PRC_출고_DELETE(1);
--==>> 
/*
해당 프로시저를 호출하면
출고 테이블에서 출고번호 1번의 데이터가 삭제되고
상품 테이블에서 출고번호 1번인 H001 의 재고수량이 100개 추가 되어야 한다
*/

--○ PRC_출고_INSERT 프로시저 호출 이후 데이터 조회
SELECT *
FROM TBL_출고;
--==>> 조회결과 없음

SELECT *
FROM TBL_상품;
--==>> H001	스크류바	1000	100






--UPDATE TBL_입고
--SET 입고수량 = 20
--WHERE 상품코드 = 'E009';  

INSERT INTO TBL_입고(입고번호,상품코드, 입고수량, 입고단가)
    VALUES(8, 'E008', 10, 10);
--
UPDATE TBL_상품
SET 재고수량 = 10
WHERE 상품명 = '엑설런트';
--
--INSERT INTO TBL_출고(출고번호,상품코드, 출고수량, 출고단가)
--    VALUES(2, 'E009', 10, 11);

--UPDATE TBL_출고
--SET 출고수량 = 11
--WHERE 상품코드 = 'E009';

--○ PRC_입고_DELETE 프로시저 호출 전 데이터 조회
SELECT *
FROM TBL_입고;
--==>> 
/*
7	E009	2022-09-02	20	10
8	E008	2022-09-02	10	10
*/
--> 기존 데이터와 동일한 것 확인

SELECT *
FROM TBL_상품;
--==>> 
/*
E009	셀렉션	    3000	9
E008	엑설런트	3000	10
*/
--> 기존 데이터와 동일한 것 확인

SELECT *
FROM TBL_출고;
--==>> 2	E009	2022-09-02	11	11
--> 기존 데이터와 동일한 것 확인

--○ 프로시저 호출을 통한 확인
EXEC PRC_입고_DELETE(100);
--==>> 출고번호 100번이 없어 롤백

EXEC PRC_입고_DELETE(7);
--==>> 
/*
해당 프로시저를 호출하면
입고 테이블에서 입고번호 7번의 데이터가 삭제가 안되고
상품 테이블에서 상품코드 E009이 기존재고수량(9) - 입고된수량(20) = (출고된수량)-11 < 0 에러발생
(입고20개 → 재고20개, 이때 출고11개 → 재고20-11=9개, 이때 입고 -20개 하면 
  → 이미 출고가 된 상태라 재고9개 이므로 출고로 빠져나간 상품11개가 부족해 입고 삭제 X)
*/

EXEC PRC_입고_DELETE(8);
--==>>
/*
해당 프로시저를 호출하면 
입고 테이블에서 입고번호 8번의 데이터가 삭제되고
상품 테이블에서 상품코드 E008이 기존재고수량(10) - 입고된수량(10) < 0 이므로
입고 제거 성공
*/

--○ PRC_입고_DELETE 프로시저 호출 이후 데이터 조회
SELECT *
FROM TBL_입고;
--==>> 
/*
7	E009	2022-09-02	20	10
8	E008	2022-09-02	10	10  ◀
*/
--> 8번 데이터 삭제 확인

SELECT *
FROM TBL_상품;
--==>> 
/*
E009	셀렉션	    3000	9
E008	엑설런트	3000	0   ◀
*/
--> 상품코드 E008 데이터의 재고수량 0으로 변경 확인