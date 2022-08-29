SELECT USER
FROM DUAL;
--==>> HR

--■■■ 정규화 (Nomalization) ■■■--

--○ 정규화란?
--   한 마디로 데이터베이스 서버의 메모리 낭비를 막기 위해
--   어떤 하나의 테이블을... 식별자를 가지는 여러 개의 테이블로 나누는 과정을 말한다
SELECT *
FROM EMPLOYEES;

-- ex) 현성이가...옥장판을 판매한다
--     고객리스트 → 거래처 직원 명단이 적혀있는 수첩의 정보를
--                   데이터베이스화 하려 한다

-- 테이블명 : 거래처직원
/*
  10Byte       10Byte       10Byte      10Byte     10Byte  10Byte  10Byte
--------------------------------------------------------------------------------
거래처회사명  회사주소    회사전화    거래처직원명  직급  이메일     휴대폰
--------------------------------------------------------------------------------
    LG       서울여의도  02-345-6789     정미경     부장  jmk@na...   010-1...
    LG       서울여의도  02-345-6789     정영준     과장  jyj@na...   010-7...
    LG       서울여의도  02-345-6789     조영관     대리  cyk@na...   010-3...
    LG       서울여의도  02-345-6789     고연수     부장  kys@na...   010-1...
    SK       서울소공동  02-987-6543     최나윤     부장  cny@da...   010-9...
    LG       부산동래구  051-221-2111    민찬우     대리  mcw@go...   010-1...
    SK       서울소공동  02-987-6543     유동현     과장  ydh@na...   010-8...
                    
                                    :
--------------------------------------------------------------------------------

가정) 서울 여의도 LG(본사) 라는 회사에 근무하는 거래처 직원 명단이
      총 100만 명이라고 가정한다
      (한 행(레코드)은 70Byte)

      어느 날... 서울 여의도 에 위치한 LG 본사가 경기분당으로
      사옥을 이전하게 되었다
      회사주소는 경기분당 으로 바뀌고, 회사전화는 031-111-2222 로 바뀌게 되었다

      그러면 100만 명의 회사주소와 회사전화를 변경해야 한다

      -- 이때 수행되어야 할 쿼리문 → UPDATE 

      UPDATE 거래처직원
      SET 회사주소 = '경기분당', 회사전화 = '031-111-2222'
      WHERE 거래처회사명 = 'LG'
        AND 회사주소 = '서울여의도';

      -- 100만 개 행을 하드디스크상에서 읽어다가
         메모리에 로드시켜 주어야 한다
         즉, 100만 * 70Byte 를 모두
         하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다

         → 이는 테이블의 설계가 잘못되었으므로
            DB 서버는 조만간 메모리 고갈로 이해 DOWN 될 것이다

            → 그러므로 정규화 과정을 수행해야 한다



━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━   
제 1 정규화 │  제 2 정규화  │  제 3 정규화  │ 제 4 정규화  │역정규화(비정규화)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    
    
●  제 1 정규화 

어떤 하나의 테이블에 반복되어 컬럼 값들이 존재한다면 값들이 반복되어 
나오는 컬럼을 분리하여 새로운 테이블을 만들어준다 .

-- 테이블명  : 회사 → 부모 테이블

10Byte      10Byte         10Byte       10Byte    
-----------------------------------------------------
회사ID  │거래처회사명 │  회사주소  │  회사전화 
------
참조받는 컬럼
-----------------------------------------------------

    10          LG        서울여의도    02-345-6789     
    20          SK        서울소공동    02-987-6543    
    30          LG        부산동래구    051-221-2111   
-----------------------------------------------------


-- 테이블명 : 직원 → 자식 테이블

  10Byte       10Byte   10Byte     10Byte      10Byte
-------------------------------------------------------------

거래처직원명 │ 직급 │이메일  │  휴대폰   │ 회사ID
                                               -------
                                               참조하는 컬럼
-------------------------------------------------------------

정미경          부장   jmk@na...   010-1...      10
정영준          과장   jyj@na...   010-7...      10
조영관          대리   cyk@na...   010-3...      10
고연수          부장   kys@na...   010-1...      10
최나윤          부장   cny@da...   010-9...      20
민찬우          대리   mcw@go...   010-1...      30
유동현          과장   ydh@na...   010-8...      20
    :
-------------------------------------------------------------
*/
--> 제 1 정규화를 수행하는 과정에서 분리된 테이블은
--  ★ 반드시 부모 테이블과 자식 테이블의 관계를 갖게 된다. 

-->  부모 테이블 → 참조받는 컬럼 → PRIMARY KEY
--   자식 테이블 → 참조하는 컬럼 → FOREIGN KEY

--※ 참조받는 컬럼이 갖는 특징
--   반드시 고유한 값(데이터)만 들어와야 한다
--   중복된 값(데이터)이 있어서는 안된다
--   비어있으면(NULL이 있어서는) 안된다
--   즉, NOT NULL 이어야 한다

--> 제 1 정규화를 수행하는 과정에서
--  부모 테이블의 PRIMARY KEY 는 항상 자식 테이블의 FOREIGN KEY 로 전이된다


/*
-- 테이블이 분리(분할)되기 이전 상태로 조회
SELECT A.거래처회사명, A.회사주소, A.회사전화
     , B.거래처직원명, B.직급, B.이메일, B.휴대폰
FROM 회사 A, 직원 B
WHERE A.회사ID = B.회사ID;

가정) 서울 여의도 LG(본사) 라는 회사에 근무하는 거래처 직원 명단이
      총 100만 명이라고 가정한다
      
      어느 날... '서울 여의도' 에 위치한 LG 본사가 경기분당으로
      사옥을 이전하게 되었다
      회사주소는 '경기분당' 으로 바뀌고, 회사전화는 031-111-2222 로 바뀌게 되었다

      그러면 회사 테이블에서 1건의 회사주소와 회사전화를 변경해야 한다

      -- 이때 수행되어야 할 쿼리문 → UPDATE 

      UPDATE 거래처직원
      SET 회사주소 = '경기분당', 회사전화 = '031-111-2222'
      WHERE 거래처회사명 = 'LG'
        AND 회사주소 = '서울여의도';
        
      UPDATE 회사
      SET 회사주소 = '경기분당', 회사전화 = '031-111-2222'
      WHERE 회사ID = 10;

      -- 1 개 행을 하드디스크상에서 읽어다가
         메모리에 로드시켜 주어야 한다
         즉, 1 * 40Byte 를 모두
         하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다

         → 정규화 이전에는 100만 건을 처리해야 할 업무에서
            1건만 처리하면 되는 업무로 바뀐 상황이기 때문에
            DB 서버는 메모리 고갈이 일어나지 않고 아주 빠르게 처리될 것이다



--○ 정규화 이후 테이블                 | ○ 정규화 이전 테이블                                    
-- 거래처회사명, 회사전화               |
SELECT 거래처회사명, 회사전화           | SELECT 거래처회사명, 회사전화
FROM 회사;                              | FROM 거래처직원;
--> 3 * 40 Byte                         | --> 200만 * 70 Byte
                                        
-- 거래처직원명, 직급                   | 
SELECT 거래처직원명, 직급               | SELECT 거래처직원명, 직급
FROM 직원;                              | FROM 거래처직원;
--> 200만 * 50 Byte                     | --> 200만 * 70 Byte


-- 거래처회사명, 거래처직원명           | 
SELECT A.거래처회사명, B.거래처직원명   | SELECT 거래처회사명, 거래처직원명
FROM 회사 A JOIN 직원 B                 | FROM 거래처직원;
ON A.회사ID = B.회사ID ;                |  --> 200만 * 70 Byte
--> (3 * 40 Byte) + (200만 * 50 Byte)

*/




-- 테이블명 : 주문
/*
--------------------------------------------------------------------------------
  고객ID                 제품코드                주문일자           주문수량
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                     (P.K)
--------------------------------------------------------------------------------
 KIK1174(김인교)      P-KKBK(꿀꽈배기)     2022-04-30 13:50:23         10
 KYL8335(김유림)      P-KKBC(꼬북칩)       2022-04-30 14:23:11         20
 MCW3235(민찬우)      P-KKDS(쿠크다스)     2022-05-11 16:14:37         12
 CHH3235(조현하)      P-SWKK(새우깡)       2022-05-12 10:32:48         12
                            :
                            :

--------------------------------------------------------------------------------
*/

--※ 하나의 테이블에 존재하는 PRIMARY KEY 의 최대 개수는 1개이다
--   하지만, PRIMARY KEY 를 이루는(구성하는) 컬럼의 개수는 복수(여러개)인 것이 가능하다
--   컬럼 1개로만 구성된 PRIMARY KEY 를 SINGLE PRIMARY KEY 라고 부른다
--   (단일 프라이머리 키)
--   두 개 이상의 컬럼으로 구성된 PRIMARY KEY 를 COMPOSITE PRIMARY KEY 라고 부른다
--   (복합 프라이머리 키)


-- 제 2 정규화는... 
--> 제 1 정규화를 마친 결과물에서 PRIMARY KEY 가 SINGLE COLUMN 이라면
--  제 2 정규화는 수행하지 않는다.
--  하지만 Primary KEY 가 COMPOSITION COLUMN 이라면
--  반★드★시 제 2 정규화를 수행해야 한다. 


--> 식별자가 아닌 컬럼은 식별자 전체 컬럼에 대해 의존적이어야 하는데
--  식별자 전체 컬럼이 아닌 일부 식별자 컬럼에 대해서만 의존적이라면
--  이를 분리하여 새로운 테이블을 생성해준다. 
--  이 과정을 제 2 정규화라 한다

/*
-- 테이블명 : 과목 → 부모 테이블
--------------------------------------------------------------------------------------
과목번호    과목명     교수번호     교수자명    강의실코드   강의실설명
++++++++               ++++++++
   (     PRIMARY KEY     )
--------------------------------------------------------------------------------------
J0101      자바기초       21        슈바이처       A301      전산실습관 3층 30석 규모
J0102      자바중급       22        테슬라         T502      전자공학관 5층 60석 규모
03090      오라클중급     22        테슬라         A201      전산실습관 2층 30석 규모
03010      오라클심화     10        장영실         T502      전자공학관 5층 60석 규모
J3342      JSP응용        20        맥스웰         K101      인문사회관 1층 90석 규모
                                        :
                                        :
--------------------------------------------------------------------------------------


-- 테이블명 : 점수 → 자식 테이블
--------------------------------------------------
과목번호    교수번호         학번          점수
====================
    FORIGN KEY
++++++++                     +++++
    (        PRIMARY KEY       )
--------------------------------------------------
03090          22       2209130(김태민)     92
03090          22       2209142(정영준)     80
03090          22       2209115(최나윤)     96
                     :
                     :
--------------------------------------------------

나누고 분리한다 데이터서버 메모리 낭비 막기 위해서 하나의 테이블을 식별자를 갖는 테이블로 나누는 것 
부모테이블과 자식테이블의 관계로 나타난다 참조받는 컬럼은 자식테이블의 참조하는 컬럼이 된다
부모 테이블의 참조받는 컬럼의 특징 1. 고유값 갖는다(= 중복값 없어야) 2. NOT NULL
이게 끝나고 2정규화 해야 한다. 그 전에 PRIMARY KEY에 대해 논의하고 넘어왔다.
한 테이블에 한 개까지 올 수 있다. 프라이머리키가 여러 개가 될 수 있다. 하나를 구성하는 컬럼은
복수 컬럼이 가능하다. 컬럼이 하나이면 단일 프라이머리 키 컬럼이 두 개 이상 여러 개 일 경우 복합
프라이머리 키라고 부른다. 1정규화 결과가 단일 프라이머리키면 필요없지만 복합이라면 2정규화 해야한다.
식별자 전체 컬럼이 의존적이어야 하는데 
일부 식별자에게만 의존적이라면 ....
예를 들어 과목명은 과목번호에만 의존적이다. 교수자명은 교수자번호에만 의존적이다. 
이 둘을 분리해서 새로운 테이블을 만들어주어야 한다. 이것이 제 2 정규화



● 제 3 정규화

식별자가 아닌 컬럼이 식별자가 아닌 컬럼에 의존적인 상황이라면
이를 분리하여 새로운 테이블을 생성해주어야 한다.
이 과정을 제 3 정규형이라 한다


※ 관계(Relation) 의 종류
-- 1 : 다수 의 관계
--> 제 1 정규화를 적용하여 수행을 마친 결과물에서 나타나는 바람직한 관계
--  관계형 데이터베이스를 활용하는 과정에서 추구해야 하는 관계

-- 1 : 1 의 관계
--> 논리적, 물리적으로 존재할 수 있는 관계이긴 하지만
--  관계형 데이터베이스 설계 과정에서 가급적이면 피해야 할 관계

-- 다수 : 다수 의 관계
--> 논리적인 모델링에서 존재할 수 있지만, 
    (머리로 생각해보면 존재할 수 있지만 해보려고 하면 안 됨)
--  실제 물리적인 모델링에서는 존재할 수 없는 관계


 - 테이블명 : 고객                           - 테이블명 : 제품
-------------------------------------    ------------------------------------------------
고객번호  고객명   이메일    전화번호     제품번호   제품명  제품단가  제품설명
++++++++                                  ++++++++
=====================================    ================================================
 1001     고연수  abc@tes...  010-1        pswk      새우깡     500    새우가 들어있는
 1002     김인교  bcd@tes...  010-2        pkjk      감자깡     600    감자가 들어있는
 1003     김태민  cde@tes...  010-3        pkkm      고구마깡   700    고구마가 들어있는
 1004     정영준  def@tes...  010-4        pjkc      자갈치     400    자갈이 들어있는
            :                                           :
-------------------------------------    ------------------------------------------------


 - 테이블명 : 주문접수(판매)
--------------------------------------------------------
주문번호   고객번호    제품번호    주문일자    주문수량
           ++++++++    +++++++++
========================================================
   27        1001       pswk      2022-06~..      10
   28        1001       pkjk      2022-06~..      30
   29        1001       pjkc      2022-06~..      20
   30        1002       pswk      2022-06~..      20
   31        1002       pswk      2022-06~..      50
                          :
--------------------------------------------------------
   
제 4 정규화 : 
  위에서 확인한 내용과 같이 '다 : 다 관계' 를 
  '1 : 다 관계' 로 깨뜨리는 과정이 제 4 정규화의 수행 과정이다.
  → 일반적으로 파생 테이블 생성 → 다 : 다 관계를 1 : 다 관계로 깨뜨리는 역할 수행

  '1 : 1' 할 수 있지만 대부분 피해야한다
  '1 : 다' 가 가장 이상적이다, '1 : 다' 학생과 과목 사이에 수강신청 이제 제4정규화이다.    
*/

/*
● 역정규화 (비정규화)

--==>> A 경우 → 역정규화를 수행하지 않는 것이 바람직한 경우

-- 테이블명 : 부서            -- 테이블명 : 사원
   10Byte     10    10          10      10     10   10    10      10         10
--------------------------   ------------------------------------------- + -------
-- 부서번호 부서명 주소       사원번호 사원명 직급 급여 입사일 부서번호    부서명
--------------------------   ------------------------------------------- + -------
--   10 개 레코드(행)                  1,000,000 개 레코드(행)
--------------------------   ------------------------------------------- + -------

--> 조회 결과물
---------------------------
-- 부서명 사원명 직급 급여
---------------------------

--> '부서' 테이블과 '사원' 테이블을 JOIN 했을 때의 크기
--  (10 * 30 Byte) + (1,000,000 * 60 Byte) = 300 + 60,000,000 = 60,000,300 Byte

--> '사원' 테이블을 역정규화 한 후 이 테이블만 읽어올 때의 크기
--  즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우
--  1,000,000 * 70 Byte = 70,000,000 Byte




--==>> B 경우 → 역정규화를 수행하는 것이 바람직한 경우

-- 테이블명 : 부서            -- 테이블명 : 사원
   10Byte     10    10          10      10     10   10    10      10         10
--------------------------   ------------------------------------------- + -------
-- 부서번호 부서명 주소       사원번호 사원명 직급 급여 입사일 부서번호    부서명
--------------------------   ------------------------------------------- + -------
-- 500,000 개 레코드(행)                  1,000,000 개 레코드(행)
--------------------------   ------------------------------------------- + -------

--> 조회 결과물
---------------------------
-- 부서명 사원명 직급 급여
---------------------------

--> '부서' 테이블과 '사원' 테이블을 JOIN 했을 때의 크기
--  (500,000 * 30 Byte) + (1,000,000 * 60 Byte) = 15,000,000 + 60,000,000 = 71,000,000 Byte

--> '사원' 테이블을 역정규화 한 후 이 테이블만 읽어올 때의 크기
--  즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우
--  1,000,000 * 70 Byte = 70,000,000 Byte
--  역정규화를 했을 때가 JOIN 했을 때보다 테이블이 차지하는 메모리 크기가 작다.
--  이런 경우들이 역정규화를 할지 말지에 대한 단서를 제공해준다.
*/

--※ 
/*
1. 관계(Relationship, relation)
    - 모든 엔트리(entry)는 단일값을 가진다
    - 각 열 (column)은 유일한 이름을 가지며 순서는 무의미하다
    - 테이블의 모든 행(row==튜플==tuple)은 동일하지 않으며 순서는 무의미하다
    
2. 속성(Attribute)
    - 테이블의 열(column)을 나타낸다.
    - 자료의 이름을 가진 최소 논리적 단위 : 객체의 성질, 상태 기술
    - 일반 파일(file)의 항목(아이템==item==필드==field)에 해당한다
    - 엔티티(entity)의 특성과 상태를 기술
    - 속성(Atrribute)의 이름은 모두 달라야 한다.
    
3. 튜플(tuple)
    - 테이블의 행(row==엔티티=entity)
    - 연관된 몇 개의 속성(attribute) 으로 구성
    - 개념 정보 단위
    - 일반 파일(file)의 레코드(record)에 해당한다
    - 튜플변수(tuple variable)
        : 튜플(tuple)을 가리키는 변수, 모든 튜플 집합을 도메인으로 하는 변수
    
4. 도메인(domain)
    - 각 속성(attribute)이 가질 수 있도록 허용된 값들의 집합
    - 속성 명과 도메인 명이 반드시 동일할 필요는 없음
    - 모든 릴레이션에서 모든 속성들의 도메인은 원자적(atomic)이어야 함
    - 원자적 도메인.
        : 도메인의 원소가 더 이상 나누어질 수 없는 단일체일 때를 나타냄
    
5. 릴레이션(relation)
    - 파일 시스템에서 파일과 같은 개념
    - 중복된 튜플(tuple==entity==엔티티)을 포함하지 않는다 → 모두 상이함(튜플의 유일성)
    - 릴레이션 = 튜플(엔티티==entity)의 집합, 따라서 튜플의 순서는 무의미하다.
    - 속성(attribute) 간에는 순서가 없다
*/


--------------------------------------------------------------------------------
/*
--■■■ 무결성(Intergrity) ■■■--
1. 무결성에는 개체 무결성(Entity Intergrity) 
              참조 무결성(Relational Intergrity)
              도메인 무결성(Domain Intergrity) 이 있다.

2. 개체 무결성(Entity Intergrity) 
   개체 무결성은 릴레이션에서 저장되는 튜플(tuple)의 
   유일성을 보장하기 위한 제약조건이다. 

3. 참조 무결성(Relational Intergrity)
   참조 무결성은 릴레이션 간의 데이터 일관성을 보장하기 위한 제약조건이다. 

4. 도메인 무결성(Domain Intergrity) 
   바캐릭터타입으로 10을 줬다 그러면 그 안에서만 입력가능
   도메인 무결성은 허용 가능한 값의 범위를 지정하기 위한 제약조건이다

5. 제약조건의 종류

    - PRIMARY KEY(PK or P) 부모테이블의 참조받는 컬럼 ▶ 기본키, 고유키, 식별자, 식별자
      해당 컬럼의 값은반드시 존재해야 하며, 유일해야 한다.  
      (NOT NULL과 UNIQUE0RK 가 결합된 형태)
    
    - FOREIGN KEY(FK , F, R) 자식테이블의 참조하는 컬럼 ▶ 외래키 외부키 참조키
      해당 컬럼의 값은 참조되는 테이블의 컬럼 데이터들 중 하나와 일치하거나 NULL을 가진다.
    
    - UNIQUE(UK:U)
      테이블내에서 해당 컬럼의 값은 항상 유일해야 한다. 
      PRIMARY의 경우 UNIQUE와 NOT NULL이 합쳐진 것
    
    - NOT NULL(NN:CK,C)체크제약조건이다.
      해당 컬럼은 NULL을 포함할 수 없다.(비어있어선 안된다)
    
    - CHECK(CK:C)
      해당 컬럼에서 저장 가능한 데이터의 값의 범위나 조건을 정한다.
*/

--■■■ PRIMARY KEY ■■■--

-- 1. 테이블에 대한 기본키를 생성한다.

-- 2. 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합이다.
--    기본 키는 테이블 당 최대 하나만 존재한다.
--    그러나 반드시 하나의 컬럼으로만 구성되는 것은 아니다.
--    NULL일 수 없고, 이미 테이블에 존재하고 있는 데이터를
--    다시 입력할 수 없도록 처리된다
--    UNIQUE INDEX가 자동으로 생성된다. (오라클이 자체적으로 만든다.)

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컴럼명 데이터타입[CONSTRAINT CONSTRAINT명] PRIMARY KEY[(컬럼명,...)]

-- ② 테이블 레벨의형N식
-- 컬럼명 데이터타입
-- 컬럼명 데이터타입,
-- CONSTRAINT CONTSTRAINT명'PRIMARY KEY(컬럼명[,...])

-- 4. CONSTRAINT 추가 시 CONSTRAINT 명을 생략하면
-- 오라클 서버가 자동적으로 CONTSTRAINT 명을 부여하게 된다.
-- 일반적으로 CONSTARINT 명은 테이블명_컬럼명_CONSTRAINT 약어
-- 형식으로 기술한다.



--○ PK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST1
(  COL1 NUMBER(5)       PRIMARY KEY
,  COL2 VARCHAR(30)
);
--==>>Table TBL_TEST1이(가) 생성되었습니다.


DESC TBL_TEST1;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/


--데이터 입력
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'TEST');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'TEST'); --> 에러 발샐
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(1,'ABCD'); --> 에러 발생
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'ABCD');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(3,NULL);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(COL1) VALUES(4);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(2,'ABCD'); --> 에러발생
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(5,'ABCD');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(COL1,COL2) VALUES(NULL,NULL); -->에러발생
INSERT INTO TBL_TEST1(COL2) VALUES('STUDY'); --> 에러발생

-- 커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/
DESC TBL_TEST1;

/*
커밋 완료.
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
-- 주의! NOT NULL 이라는 게 PRIMARY KEY라는 것은아니다



-- ● 제약조건 확인
SELECT *
FROM USER_CONSTRAINTS;
/*
HR	SYS_C004102	            O	EMP_DETAILS_VIEW					            ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME		2014-05-29				
HR	JHIST_DATE_INTERVAL	    C	JOB_HISTORY	        end_date > start_date		ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				
HR	JHIST_JOB_NN	        C	JOB_HISTORY	        "JOB_ID" IS NOT NULL		ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				
HR	JHIST_END_DATE_NN	    C	JOB_HISTORY	        "END_DATE" IS NOT NULL		ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				
HR	JHIST_START_DATE_NN	    C	JOB_HISTORY	        "START_DATE" IS NOT NULL	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	    USER NAME			2014-05-29				                            :
                            :
*/
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='TBL_TEST1';
/* OWNER    CONSTRAINT_NAME     CONSTRAINT_TYPE   TABLE_NAME    SEARCH_CONDITION    R_OWNER
----------------------------------------------------------------------------------------------
    HR	    SYS_C007096	            P	           TBL_TEST1	(null)	             (null)
*/


-- ● 제약 조건이 지정된 컬럼확인(조회)
SELECT *
FROM USER_CONS_COLUMNS;
--==>>
/*
HR	SYS_C007096	    TBL_TEST1	COL1	    1
HR	REGION_ID_NN	REGIONS	    REGION_ID	
HR	REG_ID_PK	    REGIONS	    REGION_ID	1
HR	LOC_CITY_NN	    LOCATIONS	CITY	
HR	LOC_ID_PK	    LOCATIONS	LOCATION_ID	1
            :
            :
*/


SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME ='TBL_TEST1';
--==>> HR	SYS_C007096	TBL_TEST1	COL1	1

-- ● USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
--   제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>>
/*
HR	REG_ID_PK	    REGIONS	    P	REGION_ID
HR	REGION_ID_NN	REGIONS	    C	REGION_ID
HR	COUNTRY_C_ID_PK	COUNTRIES	P	COUNTRY_ID
HR	COUNTR_REG_FK	COUNTRIES	R	REGION_ID
HR	COUNTRY_ID_NN	COUNTRIES	C	COUNTRY_ID
            :
            :
*/

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST1';
--==>> HR	SYS_C007096	TBL_TEST1	P	COL1
           --============  오라클이 자동으로 붙여준 제약조건의 이름



--○ PK 지정 실습(② 테이블 레벨의 형식)
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)       
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--===>>Table TBL_TEST2이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'TEST');
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'TEST'); --> 에러발생
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1,'ABCD'); --> 에러발생
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(2,'ABCD');
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(3,NULL);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST2(COL1) VALUES(4);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST2(COL1) VALUES(4);
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(5,'ABCD');
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(NULL,NULL);-->에러발생
INSERT INTO TBL_TEST2(COL2) VALUES('KKKKK'); --> 에러발생

COMMIT;

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	TEST
2	ABCD
3	(null)
4	(null)
5	ABCD
*/

-- ● USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
--   제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST2';
--==>> HR	TEST2_COL1_PK	TBL_TEST2	P	COL1


--○ PK 지정 실습(③ 다중 컬럼 PK 지정 → 복합 프라이머리 키)
-- 테이블 생성
/*
CREATE TABLE TBL_TEST3
(  COL1 NUMBER(5)       
,   COL2 VARCHAR2(30)
,   CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL1)
,   CONSTRAINT TEST3_COL1_PK PRIMARY KEY(COL2)
);
*/
--==>> 이렇게 하면 안된다

CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');    --> 에러발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);      --> 에러발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'TEST'); --> 에러발생
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL); --> 에러발생

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	ABCD
1	TEST
2	ABCD
2	TEST
*/

-- ● USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
--   제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST3';
--==>> 두 개의 제약조건명(타입)이 똑같기에 프라이머리키가 2개인게 아니라 1개임
/*
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL1
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL2
*/

--○ PK 지정 실습(④ 테이블 생성 이후 제약조건 추가 설정)
-- 테이블 설정
CREATE TABLE TBL_TEST4
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST4이(가) 생성되었습니다.

--※ 제약 조건을 추가하려고 하는데 주의해야 할 점 
--   이미 생성(만들어져 있는) 테이블에 
--   부여하려는 제약조건을 위반한 데이터가 포함되어 있을 경우
--   해당 테이블에 제약 조건을 추가하는 것은 불가능하다.


-- 제약 조건 추가
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4이(가) 변경되었습니다.

-- ● USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
--   제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME ='TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1


--※ 제약조건 확인 전용 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
    ,  UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
    ,  UC.TABLE_NAME "TABLE_NAME"  --여기서 " TABLE_NAME" ← 이렇게 공백주면 안되는이유는?
    ,  UC.CONSTRAINT_TYPE "CONSTRAINT TYPE"
    ,  UCC.COLUMN_NAME "COLUMN_NAME"
    ,  UC.SEARCH_CONDITION "SEARCH_CONDITION"
    ,  UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK이(가) 생성되었습니다.

--○ 생성된 뷰(VIEW)를 통한 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1		

--------------------------------------------------------------------------------

--■■■ UNIQUE(UK:U) ■■■--

-- 1. 테이블에서 지정한 컬럼의 데이터가 중복되지 않고 유일할 수 있도록 설정하는 제약조건
--    PRIMARY KEY 와 유사한 제약조건이지만, NULL 을 허용한다는 차이점이 있다
--    내부적으로 PRIMARY KEY 와 마찬가지로 UNIQUE INDEX 가 자동 생성된다
--    하나의 테이블 내에서 UNIQUE 제약조건은 여러 번 설정하는 것이 가능하다
--    즉, 하나의 테이블에 UNIQUE 제약조건을 여러 개 만드는 것은 가능하다는 것이다


-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터 타입[CONSTRAINT CONSTRAINT명] UNIQUE

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 UNIQUE(컬럼명[, ...])

--● UK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)      PRIMARY KEY
, COL2  VARCHAR2(30)   UNIQUE
);
--==>>Table TBL_TEST5이(가) 생성되었습니다.

-- 제약 조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
--==>>
/*
HR	SYS_C007100	TBL_TEST5	P	COL1		
HR	SYS_C007101	TBL_TEST5	U	COL2		
*/

-- 데이터 입력
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(1, 'TEST'); --> 에러발생
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3, 'ABCD'); --> 에러발생
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4);
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5, 'ABCD'); --> 에러발생

-- 확인
SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	(null)
4	(null)
*/


--○ UK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6이(가) 생성되었습니다.

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
--==>> 
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/

--○ UK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> 조회 결과 없음

-- 제약조건 추가
/*
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
        +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);
        ↓
*/
ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>> Table TBL_TEST7이(가) 변경되었습니다.


-- 제약조건 추가 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/


--------------------------------------------------------------------------------
--■■■ CHECK(CK:C) ■■■--

-- 1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건
--    컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록 한다
--    또한, 컬럼에서 수정되는 데이터를 검사하여 조건에 맞는 데이터로 수정되는 것만 
--    허용하는 기능을 수행하게 된다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
--    컬럼명 데이터타입[CONSTRAINT CONSTRAINT명] CHECK (컬럼조건)

-- ② 테이블 레벨의 형식
--    컬럼명 데이터타입,
--    컬럼명 데이터타입, 
--    CONSTRAINT CONSTRAINT명 CHECK(컬럼조건)


-- ● CK 지정 실습( ① 컬럼 레벨의 형식  )
-- 테이블 생성
CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)      PRIMARY KEY
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)      CHECK (COL3 BETWEEN 0 AND 100)
);
--==> Table TBL_TEST8이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(1,'조영관',100);
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(1,'민찬우',100);   --> 에러발생
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(2,'민찬우',101);   --> 에러발생
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(2,'민찬우',-1);    --> 에러발생
INSERT INTO TBL_TEST8(COL1,COL2,COL3) VALUES(2,'민찬우',80);


-- 확인
SELECT *
FROM TBL_TEST8;
--==>> 
/*
1	조영관	100
2	민찬우	80
*/

COMMIT;
--==>> 커밋 완료.


-- 제약 조건 완료
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
HR	SYS_C007106	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	 (null)
HR	SYS_C007107	TBL_TEST8	P	COL1	(null)                   (null)	
*/

--○ CK 지정실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST9
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TESE9_COL2_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(1,'조영관',100);
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(1,'민찬우',100);   --> 에러발생
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'민찬우',101);   --> 에러발생
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'민찬우',-1);    --> 에러발생
INSERT INTO TBL_TEST9(COL1,COL2,COL3) VALUES(2,'민찬우',80);


-- 확인
SELECT *
FROM TBL_TEST9;
--==>> 
/*
1	조영관	100
2	민찬우	80
*/

COMMIT;
--==>> 커밋 완료.


-- 제약 조건 완료
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TESE9_COL2_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	 (null)	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1	(null)                   (null)
*/


-- ● CK 지정 실습 ( ③ 테이블 생성 이후 제약조건 추가 → CK 제약조건 추가  )
-- 테이블 생성
CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==>>Table TBL_TEST10이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST10';
--==>> 조회결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1) 
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100) );
--==>> Table TBL_TEST10이(가) 변경되었습니다.

-- 제약 조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/



-- ● TBL_TESTMEMBER 테이블의 SSN컬럼(주민번호 컬럼)에서 
-- 데이터 입력이나 수정 시, 성별이 유효한 데이터만 입력될 수 있도록 
-- 체크 제약조건을 추가할 수 있도록 한다.
-- (→ 주민번호 특정 자리에 입력 가능한 데이터로 1, 2, 3, 4 만 가능하도록 처리)
-- 또한, SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.
CREATE TABLE TBL_TESTMEMBER
( SID  NUMBER
, NAME VARCHAR(30)
, SSN  CHAR(14)           -- 입력형태 'YYMMDD-NNNNNNN'
, TEL  VARCHAR2(40)
);
--==> Table TBL_TESTMEMBER이(가) 생성되었습니다.

-- 데이터 확인
SELECT *
FROM TBL_TESTMEMBER;

-- 제약조건 추가
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID) 
--    , CONSTRAINT TESTMEMBER_SSN_CK CHECK( SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4') )
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK( (SUBSTR(SSN, 8, 1) BETWEEN 1 AND 4) ) );
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.

-- 제약 조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TESTMEMBER';
--==>>
/*
HR	TBL_TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TBL_TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	 (SUBSTR(SSN, 8, 1) BETWEEN 1 AND 4) 	
*/

-- 데이터 입력
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(1,'엄소연','941124-2234567','010-1111-1111');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(2,'최동현','950222-1234567','010-2222-2222');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(3,'유동현','040601-3234567','010-3333-3333');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(4,'김유림','050215-4234567','010-4444-4444');
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(5,'박원석','980301-5234567','010-5555-5555'); --> 에러발생 SSN 범위초과
INSERT INTO TBL_TESTMEMBER(SID,NAME,SSN,TEL) VALUES(6,'한은영','990729-6234567','010-6666-6666'); --> 에러발생 SSN 범위초과

-- 제약조건 추가 및 데이터 입력 후 데이터 확인
SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	엄소연	941124-2234567	010-1111-1111
2	최동현	950222-1234567	010-2222-2222
3	유동현	040601-3234567	010-3333-3333
4	김유림	050215-4234567	010-4444-4444
*/

COMMIT;
--==>> 커밋 완료.

--------------------------------------------------------------------------------
--■■■ FOREIGN KEY(FK:F:R) ■■■--

-- 1. 참조 키(R) 또는 외래 키(FK:F)는 두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 열이다. 한 테이블의 기본 기 값이
--    있는 열을 다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래 키가 된다.

-- 2. 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조하는 컬럼이 포함된 테이블) 이 생성되어야 한다.
--    이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                    REFERENCES 참조테이블명(참조컬럼명)
--                   [ON DELETE CASCADE | ON DELETE SEL NULL] → 추가 옵션
                
                
-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- 컬럼명 테이터타입
-- CONSTRAINT CONSTRAINT명 FOREIGN KEY (컬럼명)
--            REFERENCES 참조테이블명(참조컬럼명)
--            [ON DELETE CASCADE | ON DELETE SEL NULL] → 추가 옵션


-- ※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는 
--    독립적인 하나의 테이블을 생성하여 처리하는 것이 아니라
--    부모 테이블 생성 작업을 먼저 수행해야 한다.
--    그리고 이때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이
--    설정된 컬럼이 존재해야 한다.


-- 부모 테이블 생성
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>>Table TBL_JOBS이(가) 생성되었습니다.

-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '부장');

SELECT *
FROM TBL_JOBS;
--==>>
/*
1   사원
2   대리
3   과장
4   부장
*/

COMMIT;
-- 커밋 완료.



--○FK 지정 실습(①컬럼 레벨의 형식)
--테이블 생성
CREATE TABLE TBL_EMP1
( SID  NUMBER         PRIMARY KEY
, NAME VARCHAR2(30)
, JIKWI_ID NUMBER    REFERENCES TBL_JOBS(JIKWI_ID) --
);
--==>>Table TBL_EMP1이(가) 생성되었습니다.

--NUMBER 에서 길이지정을 안한다면 NUMBER의 표현범위를 다쓴다는 거고
--CHAR 에서 길이지정을 안한다면 1개의 문자를 의미한다.


--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007115	TBL_EMP1	P	SID		
HR	SYS_C007116	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (1, '정미경', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (2, '최나윤', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (3, '민찬우', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (4, '조영관', 4);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (5, '고연수', 5);--==>> 에러발생 5번 직위는 없음
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES (5, '고연수', 1);
INSERT INTO TBL_EMP1(SID, NAME) VALUES (6, '김태민');

SELECT *
FROM TBL_EMP1;
--==>>
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	4
5	고연수	1
6	김태민	(null)
*/

COMMIT;
--==>> 커밋 완료.



-- ● FK 지정 실습(② 테이블 레벨의 형식)

-- 테이블 생성
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
            REFERENCES TBL_JOBS(JIKWI_ID)
);

--==>Table TBL_EMP2이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	            P	SID		
HR	EMP2_JIKWI_ID_FK	    TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--○ FK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.

-- 제약 조건 추가
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3이(가) 변경되었습니다.

-- 제약 조건 제거
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>> Table TBL_EMP3이(가) 변경되었습니다.

-- 제약 조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> HR	EMP3_SID_PK	TBL_EMP3	P	SID		

-- 다시 제약 조건 추가
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID);
--==>> Table TBL_EMP3이(가) 변경되었습니다.

-- 다시 제약 조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 
/*
HR	EMP3_SID_PK	TBL_EMP3	            P	SID		
HR	EMP3_JIKWI_ID_FK	    TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


/*
 4. FOREIGNKEY 생성 시 주의사항
     참고하고자 하는 부모 테이블을 먼저 생성해야 한다.
     참고하고자 하는 컬럼이 PRIMARY KEY 나 UNIQUE 제약조건이 설정되어 있어야 한다.
     테이블 사이에 PRIMARY KEY 와 FOREIGN KEY 가 정의되어 있으면
     PRIMARY KEY 제약조건이 설정된 데이터 삭제 시 
     FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.   
     (즉, 자식 테이블에 참조하는 레코드가 존재할 경우,
      부모 테이블의 참조받는 해당 레코드는 삭제할 수 없다는 것이다.)
     단, FK 설정 과정에서 ON DELETE CASCADE 나 ON DELETE SET NULL 옵션을 
     사용하여 설정한 경우에는 삭제가 가능하다.
     또한, 부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다. 
*/

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/


-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	4
5	고연수	1
6	김태민	(null)
*/


-- 부모 테이블 제거 시도
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     ORA-02449: unique/primary keys in table referenced by foreign keys


-- 부모 테이블의 부장 직위 삭제 시도
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--=>> 4	부장

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--=>> 에러 발생
--    ORA-02292: integrity constraint (HR.SYS_C007116) violated - child record found


-- 조영관 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID = 4;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	1
5	고연수	1
6	김태민	(null)
*/

COMMIT;
--==>> 커밋 완료.

-- 부모 테이블(TBL_JOBS) 의 부장 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1) 의 데이터가 존재하지 않는 상황

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 부장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.

-- 확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/

COMMIT;
--==>> 커밋 완료.


-- 부모 테이블(TBL_JOBS) 의 사원 데이터 삭제
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1	사원

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 에러 발생
--     ORA-02292: integrity constraint (HR.SYS_C007116) violated - child record found
--     만약 여기서 에러가 안뜨고 사원 데이터가 삭제되면
--     사원 데이터와 연결된 모든 (회원)정보가 삭제되기에 에러 뜨는게 오히려 안전한 것이다


--※ 부모 테이블의 데이터를 자유롭게(?) 삭제하기 위해서는
--   ON DELETE CASCADE 옵션 지정이 필요하다

-- TBL_EMP1 테이블(자식 테이블) 에서 FK 제약조건을 제거한 후
-- CASCADE 옵션을 포함하여 다시 FK 제약조건을 설정한다

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007115	TBL_EMP1	P	SID		
HR	SYS_C007116	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/


-- 제약 조건 제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007116;
--==>> Table TBL_EMP1이(가) 변경되었습니다.

-- 제약 조건 제거 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_EMP1';
--==>> HR	SYS_C007115	TBL_EMP1	P	SID		


-- ON DELETE CASCADE 옵션이 포함된 내용으로 제약조건 다시 지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;
--==>> Table TBL_EMP1이(가) 변경되었습니다.

-- 제약조건 생성 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007115	TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/

--※ CASCADE 옵션을 지정한 후에는
--   참조받고 있는 부모 테이블의 데이터를
--   언제든지 자유롭게 삭제하는 것이 가능하다
--   단, 부모 테이블의 데이터가 삭제될 경우
--   이를 참조하는 자식 테이블의 데이터도 모두 함께 삭제된다 

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
*/


-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	정미경	1
2	최나윤	2
3	민찬우	3
4	조영관	1
5	고연수	1
6	김태민	(null)
*/


-- 부모 테이블(TBL_JOBS) 에서 과장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	정미경	1
2	최나윤	2
4	조영관	1
5	고연수	1
6	김태민	(null)
*/

-- 부모 테이블(TBL_JOBS) 에서 사원 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
2	최나윤	2
6	김태민	(null)
*/

DROP TABLE TBL_EMP2;
--==>> Table TBL_EMP2이(가) 삭제되었습니다.
DROP TABLE TBL_EMP3;
--==>> Table TBL_EMP3이(가) 삭제되었습니다.
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     ORA-02449: unique/primary keys in table referenced by foreign keys
--     TBL_EMP1 이 남아있어 삭제 불가능
DROP TABLE TBL_EMP1;
--==>> Table TBL_EMP1이(가) 삭제되었습니다.
DROP TABLE TBL_JOBS;
--==>> Table TBL_JOBS이(가) 삭제되었습니다.

-- 그런데 CASCADE 가 무슨 뜻????  --==>> 종속이란 뜻