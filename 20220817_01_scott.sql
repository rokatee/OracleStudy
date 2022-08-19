--○ LPAD()
--   Byte 를 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
     , LPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--> 1. 10Byte 공간을 확보한다.                       → 두 번째 파라미터 값에 의해
--  2. 확보한 공간에 'ORACLE' 이라는 문자열을 담는다 → 첫 번째 파라미터 값에 의해
--  3. 남아있는 Byte 공간을 왼쪽부터 세 번째 파라미터 값으로 채운다
--  4. 이렇게 구성된 최종 결과값을 반환한다
--==>> ORACLE	****ORACLE

--○ RPAD()
--   Byte 를 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
     , RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--> 1. 10Byte 공간을 확보한다.                       → 두 번째 파라미터 값에 의해
--  2. 확보한 공간에 'ORACLE' 이라는 문자열을 담는다 → 첫 번째 파라미터 값에 의해
--  3. 남아있는 Byte 공간을 오른쪽부터 세 번째 파라미터 값으로 채운다
--  4. 이렇게 구성된 최종 결과값을 반환한다
--==>> ORACLE	ORACLE****


--○ TRIM()
SELECT TRIM('    TEST    ') "RESULT"
FROM DUAL;
--==>> TEST

--○ LTRIM()
SELECT 'ORAORAORAORACLEORACLE' "COL1" -- 오라 오라 오라 오라클 오라클
     , LTRIM('ORAORAORAORACLEORACLE', 'ORA') "COL2"
     , LTRIM('AAAAAAORAORACLEORACLE', 'ORA') "COL3"
     , LTRIM('ORAORAoRAORACLEORACLE', 'ORA') "COL4"     -- 대소문자
     , LTRIM('ORAORA ORAORACLEORACLE', 'ORA') "COL5"    -- 띄어쓰기
     , LTRIM('                ORACLE', ' ') "COL6"      -- 공백
     , LTRIM('                ORACLE') "COL7"           -- 공백은 두 번째 파라미터 생략 가능
FROM DUAL;
--> 손톱깍이 생각할 것!!
--  두 번째 파라미터가 ORA 라고 해서
--  첫 번째 파라미터를 ORA 단위로 자르는게 아니라
--  O 자르고 R 자르고 A 자르고 다른 문자(C)를 만났을 때 자르는 행위를 끝내고 출력한다
--  (뭉텅이로 자르는게 아니라는 말)

--  COL3 를 보면 더 이해가 쉬움
--  ORA가 없음에도 A를 보며 하나하나 잘라나가기 때문에 COL2과 COL3는 같은 결과값을 출력

--  대소문자를 구분하며 자름
--  공백도 구분함
--  공백은 두 번째 파라미터 생략 가능

--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  왼쪽부터 연속적으로 등장하는 두 번째 파라미터 값에서 지정한 글자와
--  같은 글자가 등장할 경우 이를 제거한 결과값을 반환한다
--  단, 완성형으로 처리되지 않는다
--==>>
/*
ORAORAORAORACLEORACLE	
CLEORACLE	
CLEORACLE	
oRAORACLEORACLE	 
ORAORACLEORACLE	
ORACLE	
ORACLE
*/

SELECT LTRIM('김신이김신이김신이김김김이이이신신신박이김신', '김신이') "COL1"
FROM DUAL;
--==>> 박이김신

--○ RTRIM()
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--  오른쪽부터 연속적으로 등장하는 두 번째 파라미터 값에서 지정한 글자와
--  같은 글자가 등장할 경우 이를 제거한 결과값을 반환한다
--  단, 완성형으로 처리되지 않는다



--○ TRANSLATE()
--> 1:1 로 바꿔준다
SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                , 'abcdefghijklmnopqrstuvwxyz') "COL1"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-1234-5678'
                , '0123456789'
                , '공일이삼사오육칠팔구') "COL1"
FROM DUAL;
--==>> 공일공-일이삼사-오육칠팔

--○ REPLACE()
SELECT REPLACE('MY ORACLE SERVER ORAHOME', 'ORA', '오라') "COL1"
FROM DUAL;
--==>> MY 오라CLE SERVER 오라HOME

--------------------------------------------------------------------------------

--○ ROUND() 반올림을 처리해 주는 함수
SELECT 48.678 "COL1"              -- 48.678
     , ROUND(48.678, 2) "COL2"    -- 48.68    -- 두 번째 파라미터 : 소수점 이하 둘 째 자리까지 표현
     , ROUND(48.674, 2) "COL3"    -- 48.67
     , ROUND(48.674, 1) "COL4"    -- 48.7
     , ROUND(48.674, 0) "COL5"    -- 49
     , ROUND(48.674) "COL6"       -- 49       -- 두 번째 파라미터 값이 0일 경우 생략 가능
     , ROUND(48.674, -1) "COL7"   -- 50
     , ROUND(48.674, -2) "COL8"   -- 0
     , ROUND(48.674, -3) "COL9"   -- 0
FROM DUAL;


--○ TRUNC() 절삭을 처리해 주는 함수
SELECT 48.678 "COL1"               -- 48.678
     , TRUNC(48.678, 2) "COL2"     -- 48.67    -- 두 번째 파라미터 : 소수점 이하 둘 째 자리까지 표현
     , TRUNC(48.674, 2) "COL3"     -- 48.67
     , TRUNC(48.674, 1) "COL4"     -- 48.6
     , TRUNC(48.674, 0) "COL5"     -- 48
     , TRUNC(48.674) "COL6"        -- 48       -- 두 번째 파라미터 값이 0일 경우 생략 가능
     , TRUNC(48.678, -1) "COL7"    -- 40
     , TRUNC(48.678, -2) "COL8"    -- 0
     , TRUNC(48.678, -3) "COL9"    -- 0
FROM DUAL;


--○ MOD() 나머지를 반환하는 함수 → %
SELECT MOD(5, 2) "COL1"
FROM DUAL;
--> 5를 2로 나눈 나머지 결과값 반환
--==>> 1

--○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "COL1"
FROM DUAL;
--> 5의 3승을 결과값으로 반환
--==>> 125


--○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2) "COL1"
FROM DUAL;
--> 루트 2 에 대한 결과값 반환
--==>> 1.41421356237309504880168872420969807857


--○ LOG() 로그 함수
--   오라클은 자연로그, 상용로그 모두 지원한다
--   자연로그
SELECT LN(95) "RESULT"
FROM DUAL;
--==>> 4.55387689160054083460978676511404117675

--   상용로그
SELECT LOG(10, 100) "COL1"
     , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677

--○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
--> 각각 사인, 코사인, 탄젠트 결과값을 반환한다


--○ 삼각함수의 역함수(범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>> 
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/
--> 각각 어사인, 어코사인, 어탄젠트 결과값을 반환한다


--○ SIGN() 서명, 부호, 특징
--   연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1 을 반환한다
SELECT SIGN(5-2) "COL1"
     , SIGN(5-5) "COL2"
     , SIGN(5-7) "COL3"
FROM DUAL;
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 종종 사용된다
--==>> 
/*
1   : 결과값이 3(양수) 이므로 1을 반환
0	: 결과값이 0 이므로 0을 반환
-1  : 결과값이 -2(음수) 이므로 -1을 반환
*/

--○ ASCII(), CHR() → 서로 대응(상응)하는 함수
SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A
--> ASCII() : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다
--  CHR()   : 매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환한다

--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--※ 날짜 연산의 기본 단위는 일수(DAY) 이다!! CHECK~!!
SELECT SYSDATE "COL1"       -- 2022-08-17 11:13:57
     , SYSDATE +1 "COL2"    -- 2022-08-18 11:13:57
     , SYSDATE -2 "COL3"    -- 2022-08-15 11:13:57
     , SYSDATE +30 "COL4"   -- 2022-09-16 11:13:57
FROM DUAL;

--○ 시간 단위 연산
SELECT SYSDATE "COL1"           -- 2022-08-17 11:15:39
     , SYSDATE + 1/24 "COL2"    -- 2022-08-17 12:15:39
     , SYSDATE - 2/24 "COL3"    -- 2022-08-17 09:15:39
FROM DUAL;

--○ 현재 시간과 현재 시간 기준 1일 2시간 3분 4초 후를 조회
SELECT SYSDATE "COL1"                                                            -- 2022-08-17 11:18:09
     , SYSDATE + 1 + 2/24 + 3/1440 + 4/86400 "COL2"                              -- 2022-08-18 13:21:13
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "COL3"                -- 2022-08-18 13:21:13
     , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "COL4"     -- 2022-08-18 13:21:13
FROM DUAL;


--○ 날짜 - 날짜 → 일수
SELECT TO_DATE('2023-01-16', 'YYYY-MM-DD') - TO_DATE('2022-06-27', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 203

--○데이터 타입의 변환
SELECT TO_DATE('2022-08-17', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 2022-08-17 00:00:00

SELECT TO_DATE('2022-08-32', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 에러 발생 
--     ORA-01847: day of month must be between 1 and last day of month

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 에러 발생
--     ORA-01839: date not valid for month specified

SELECT TO_DATE('2022-13-17', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==>> 에러 발생
--     ORA-01843: not a valid month

--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 수행하는 과정에서
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다

--○ ADD_MONTHS() 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"                    -- 2022-08-17 11:36:23
     , ADD_MONTHS(SYSDATE, 2) "COL2"     -- 2022-10-17 11:36:23
     , ADD_MONTHS(SYSDATE, 3) "COL3"     -- 2022-11-17 11:36:23
     , ADD_MONTHS(SYSDATE, -2) "COL4"    -- 2022-06-17 11:36:23
FROM DUAL;


--○ MONTHS_BETWEEN()
--   첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환한다 → 단위 : 개월 수
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "COL1"
FROM DUAL;
--==>> 242.564094982078853046594982078853046595

--> 개월 수의 차이를 반환하는 함수
--  결과값의 부호가 -(음수)로 반환되었을 경우에는
--  첫 번째 인자값에 해당하는 날짜보다
--  두 번째 인자값에 해당하는 날짜가 미래 라는 의미로 확인할 수 있다


--○ NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--> 오늘 날짜를 기준으로 가장 빨리 돌아오는 두 번째 파라미터 값의 요일이 언제인지 알려주는 함수
--==>>
/*
2022-08-20 11:44:18	
2022-08-22 11:44:18
*/

--※ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

-- 날짜 세션 언어를 영어로 바꾸고 다시 조회
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 에러 발생
--     ORA-01846: not a valid day of the week

-- 두 번째 파라미터 요일을 영어로 바꾸고 조회
SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;

--※ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- 날짜 세션 언어를 한글로 바꾸고 다시 조회
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;


--○ LAST_DAY()
-->  해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다
SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
     , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL3"
FROM DUAL;
--==>>
/*
2022-08-31	
2020-02-29	
2019-02-28
*/

--○ 오늘부로... 태민이가 군대에 다시 끌려 간다..
--   복무 기간은 22개월로 한다

-- 1. 전역 일자를 구한다
SELECT SYSDATE "COL1"
     , ADD_MONTHS(SYSDATE, 22) "COL2"
FROM DUAL;
--==>> 2024-06-17

-- 2. 하루 꼬박꼬박 3끼 식사를 한다고 가정하면
--    태민이가 몇 끼를 먹어야 집에 보내줄까
--    (전역 일자 - 입대 일자) * 3
SELECT SYSDATE "현재 시간"
     , ADD_MONTHS(SYSDATE, 22) "김태민 전역일"
     , (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3 "식사 횟수"
FROM DUAL;

--○ 현재 날짜 및 시각으로부터
--   수료일(2023-01-16 18:00:00) 까지
--   남은 기간을... 다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다
/*
-------------------- -------------------- ---- ----- --- ---
현재시각             수료일               일   시간  분  초
-------------------- -------------------- ---- ----- --- ---
2022-08-17 14:55:30  2023-01-16 18:00:00  152     3   4  30
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- 방법 1 노가다...
SELECT SYSDATE "현재시각"
     , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     
     -- 수료일 - 오늘날짜를 소수점 없이 절삭 = 일수
     , TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE), 0) "일"
     
     -- [(수료일 - 오늘날짜) - 절삭한(수료일 - 오늘날짜)] 에 *24 = 절삭 안한 시간
     -- 일수의 소수점에 *24를 한 것
     -- 절삭 안한 시간을 절삭하면 = 시간
     , TRUNC(
                ( TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                    - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                ) *24
         , 0) "시간"
     
     -- [(수료일 - 오늘날짜) - 절삭한(수료일 - 오늘날짜)] 에 *24 → 절삭 안한 시간
     --   - [(수료일-현재날짜) - 절삭한(수료일 - 오늘날짜)] 에 *24 → 절삭한 시간 = 시간
     -- 절삭 안한 시간 - 시간  에 *60 하면 = 절삭 안한 분
     -- 절삭 안한 분을 절삭하면 = 분
     , TRUNC(
                (
                    (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                       - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                    ) *24 
                       - TRUNC(
                                 (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                    - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                                 ) *24
                              ) 
                ) *60
         , 0) "분"

     -- 초
     , ROUND(
                (
                    (
                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                           - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) 
                        ) *24
                            - TRUNC(
                                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                           - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
                                        ) *24
                                    )
                     ) *60
                        - TRUNC(
                                    (
                                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                            - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
                                        ) *24
                                            - TRUNC(
                                                        (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE 
                                                            - TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
                                                        )*24
                                                    )
                                    )*60
                                )
                ) *60
         , 0) "초"
FROM DUAL;

-- 힌트
-- 1일 2시간 3분 4초 를 "초" 로 환산하면
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- 『93784초』를... 다시 일, 시간, 분, 초로 환산하면...
SELECT MOD(93784, 60) "초"
     , MOD(TRUNC(93784/60), 60) "분"
     , MOD(TRUNC(93784/60/60), 24) "시간"
     , TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "일"
FROM DUAL;
--==>> 4	3	2	1

-- 방법 2
SELECT MOD(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60) "초"
     , MOD(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "분"
     , MOD(TRUNC(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "시간"
     , TRUNC(TRUNC(TRUNC((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60)/24) "일수"
     , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , SYSDATE "현재 시간"
FROM DUAL;

-- 방법 3
SELECT  SYSDATE "현재 시간"
     , TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , TRUNC(TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "일"
     , TRUNC(MOD((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24, 24)) "시"
     , TRUNC(MOD((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24*60, 60)) "분"
     , TRUNC(MOD((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24*60*60, 60)) "초"
FROM DUAL;


-- 해답
-- 수료일까지 남은 기간 확인 (단위 : 일수)
SELECT 수료일자 - 현재일자
FROM DUAL;

SELECT TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 152.09849537037037037037037037037037037

-- 수료일까지 남은 기간 확인 (단위 : 초)
SELECT (남은기간) * (하루를구성하는전체초)
FROM DUAL;

SELECT (TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
--==>> 13141117.99999999999999999999999999999999

-- 위의 식을 괄호에 넣어서
SELECT ( (남은기간) * (하루를구성하는전체초) )
FROM DUAL;

SELECT ((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))
FROM DUAL;

-- 힌트 구문의 "초" 자리에 넣기
SELECT TRUNC(MOD(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)), 60)) "초"
     , MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60), 60) "분"
     , MOD(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60/60), 24) "시간"
     , TRUNC(TRUNC(TRUNC(((TO_DATE('2023-01-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/60)/24) "일"
FROM DUAL;


--○ 각자 태어난 날짜 및 시각으로부터...현재까지
--   얼마만큼의 시간을 살고 있는지..
--   다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다
/*
-------------------- -------------------- ------ ----- ---- ----
현재시각             생년월일                 일  시간  분   초
-------------------- -------------------- ------ ----- ---- ----
2022-08-17 16:04:34  1993-07-13 10:45:00  10627     5   19   34
*/
-- 생년월일부터 지금까지 지난 기간 확인 (단위 : 일수)
SELECT 현재일자 - 생년월일
FROM DUAL;

SELECT SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--==>> 10627.2135185185185185185185185185185185

-- 생년월일부터 지금까지 지난 기간 확인 (단위 : 초)
SELECT (지난기간) * (하루를구성하는전체초)
FROM DUAL;

SELECT (SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)
FROM DUAL;
--==>> 918191331.000000000000000000000000000003

-- 위의 식을 괄호에 넣어서
SELECT ( (지난기간) * (하루를구성하는전체초) )
FROM DUAL;

SELECT ((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))
FROM DUAL;

-- 힌트 구문의 "초" 자리에 넣기
SELECT TRUNC(MOD(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)), 60)) "초"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60), 60) "분"
     , MOD(TRUNC(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60/60), 24) "시간"
     , TRUNC(TRUNC(TRUNC(((SYSDATE - TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60))/60)/60)/24) "일"
     , TO_DATE('1993-07-13 10:45:00', 'YYYY-MM-DD HH24:MI:SS') "생년월일"
     , SYSDATE "현재시간"
FROM DUAL;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

--※ 날짜 데이터를 대상으로 반올림, 절삭 등의 연산을 수행할 수 있다

--○ 날짜 반올림
SELECT SYSDATE "COL1"               -- 2022-08-17   →  기본 현재 날짜
    ,  ROUND(SYSDATE, 'YEAR')"COL2" -- 2023-01-01   →  연도까지 유효한 데이터(상반기 / 하반기 기준)
    ,  ROUND(SYSDATE, 'MONTH')"COL3"-- 2022-09-01   →  월까지 유효한 데이터(15일 기준)
    ,  ROUND(SYSDATE, 'DD') "COL4"  -- 2022-08-18   →  일까지 유효한 데이터(정오 기준)
    ,  ROUND(SYSDATE, 'DAY')"COL5"  -- 2022-08-21   →  일까지 유효한 데이터(수요일 정오 기준)
FROM DUAL;

--○ 날짜 절삭
SELECT SYSDATE "COL1"               -- 2022-08-17   →  기본 현재 날짜
    ,  TRUNC(SYSDATE, 'YEAR')"COL2" -- 2022-01-01   →  연도까지 유효한 데이터
    ,  TRUNC(SYSDATE, 'MONTH')"COL3"-- 2022-08-01   →  월까지 유효한 데이터
    ,  TRUNC(SYSDATE, 'DD') "COL4"  -- 2022-08-17   →  일까지 유효한 데이터
    ,  TRUNC(SYSDATE, 'DAY')"COL5"  -- 2022-08-14   →  그 전 주에 해당하는 일요일
FROM DUAL;

--------------------------------------------------------------------------------
--■■■ 변환 함수 ■■■--

-- TO_CHAR()    : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
-- TO_DATE()    : 문자 데이터를 날짜 타입으로 변환시켜주는 함수
-- TO_NUMBER()  : 문자 데이터를 숫자 타입으로 변환시켜주는 함수

--○ 날짜형 → 문자형
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"    -- 2022-08-17
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"          -- 2022
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"          -- TWENTY TWENTY-TWO
     , TO_CHAR(SYSDATE, 'MM') "COL4"            -- 08
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"         -- 8월 
     , TO_CHAR(SYSDATE, 'MON') "COL6"           -- 8월 
     , TO_CHAR(SYSDATE, 'DD') "COL7"            -- 17
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"         -- 08-17
     , TO_CHAR(SYSDATE, 'DAY') "COL9"           -- 수요일
     , TO_CHAR(SYSDATE, 'DY') "COL10"           -- 수
     , TO_CHAR(SYSDATE, 'HH24') "COL11"         -- 17
     , TO_CHAR(SYSDATE, 'HH') "COL12"           -- 05
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"        -- 05 오후
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"        -- 05 오후
     , TO_CHAR(SYSDATE, 'MI') "COL15"           -- 11
     , TO_CHAR(SYSDATE, 'SS') "COL16"           -- 20
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"        -- 62464    오늘 자정(00:00)부터 현재시간까지 초로 표현
     , TO_CHAR(SYSDATE, 'Q') "COL18"            -- 3        8월이라 3분기
FROM DUAL;

--※ 날짜나 통화 형식이 맞지 않을 경우...
--   설정값을 통해 세션을 설정할 수 있다

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\'; -- \ 는 ￦ 이다.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--○ 숫자형 문자형
SELECT 7 "COL1"
     , '7' "COL2"
     , TO_CHAR(7) "COL3"
FROM DUAL;
--> 조회 결과가 좌측 정렬인지 우측 정렬인지 확인~

SELECT TO_NUMBER('4') "COL1"
     , '4' "COL2"
     , 4 "COL3"
     , TO_NUMBER('04') "COL4"
FROM DUAL;
--==>> 4	4	4	4
--> 조회 결과가 좌측 정렬인지 우측 정렬인지 확인~


--○ 현재 날짜에서 현재 년도(2022)를 숫자 형태로 조회(반환)
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) "RESULT"
FROM DUAL;
--==>> 2022
--> 조회 결과가 좌측 정렬인지 우측 정렬인지 확인~


--○ EXTRACT()   
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"      -- 2022(문자형)    → 연도를 추출하여 문자 타입으로
     , TO_CHAR(SYSDATE, 'MM') "COL2"        -- 08(문자형)      → 월을 추출하여 문자 타입으로
     , TO_CHAR(SYSDATE, 'DD') "COL3"        -- 17(문자형)      → 일을 추출하여 문자 타입으로
     , EXTRACT(YEAR FROM SYSDATE) "COL4"    -- 2022(숫자형)    → 연도를 추출하여 문자 타입으로
     , EXTRACT(MONTH FROM SYSDATE) "COL5"   -- 8(숫자형)       → 월을 추출하여 문자 타입으로
     , EXTRACT(DAY FROM SYSDATE) "COL6"     -- 17(숫자형)      → 일을 추출하여 문자 타입으로
FROM DUAL;
--> EXTRACT()은 년, 월, 일 이외의 다른 항목은 불가


--○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"  -- 화폐단위 표기
     , TO_CHAR(60000, '$99,999') "COL3" -- $ 표기
     , TO_CHAR(60000, 'L99,999') "COL4" -- ￦ 표기 → 화폐 기호는 나라마다 다르므로 왼쪽에 공백이 있다
     , LTRIM(TO_CHAR(60000, 'L99,999')) "COL5" --  → 그러므로 LTRIM()을 이용해 왼쪽 공백을 없앨 수 있다 
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다

SELECT SYSDATE "현재시간"
     , SYSDATE + 1 "1일후"
     , SYSDATE + 1 + (2/24) "1일2시간후"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) "1일2시간3분후"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일2시간3분4초후"
FROM DUAL;
--==>>
/*
2022-08-17 17:43:55	
2022-08-18 17:43:55	
2022-08-18 19:43:55	
2022-08-18 19:46:55	
2022-08-18 19:46:59
*/

--○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회
--   TO_YMINTERVAL()   → YearMonth 연~월 까지의 간격
--   TO_DSINTERVAL()   → DaySeconds 일~초 까지의 간격
SELECT SYSDATE "현재시간"
     , SYSDATE + TO_YMINTERVAL('01-00') + TO_DSINTERVAL('003 04:05:06') "연산결과"
FROM DUAL;
--==>> 2022-08-17 17:47:57
--     2023-10-20 21:53:03
--------------------------------------------------------------------------------







