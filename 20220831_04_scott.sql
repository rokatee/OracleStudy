SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_INSA;

--○ TBL_INSA 테이블을 대상으로
--   주민번호(SSN)를 가지고 성별을 조회한다

SELECT NAME, SSN
     , DECODE(SUBSTR(SSN, 8, 1), '1', '남자', '2', '여자', '3', '남자', '4', '여자', '성별확인불가' ) "성별"
FROM TBL_INSA;

SELECT NAME, SSN
     , FN_GENDER(SSN) "성별"
FROM TBL_INSA;

SELECT FN_GENDER('751212-1234657') "성별확인"
FROM DUAL;



--○ 정의한 함수 테스트
-- FN_POW()
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000

-- FN_PAY()
SELECT NAME "이름", FN_PAY(BASICPAY, SUDANG) "기본급+수당"
FROM TBL_INSA;
--==>>
/*
홍길동	31520000
이순신	16040000
    :
김신애	10902000
*/

-- FN_WORKYEAR()
SELECT NAME, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
홍길동	23.9
이순신	21.7
이순애	23.5
    :
김신애	20.9
*/








