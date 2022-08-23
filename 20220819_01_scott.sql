SELECT USER
FROM DUAL;
--==>> SCOTT


--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다
/*
--------- -------------
   성별      급여함
--------- -------------
   남        XXXXXX
   여        XXXXXX
모든사원     XXXXXX
--------- -------------
*/
SELECT *
FROM TBL_SAWON;

-- 1단계
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            ELSE '성별판별불가'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON;
/*
여성	3000
여성	2000
여성	4000
남성	2000
남성	1000
여성	3000
여성	4000
여성	1500
남성	1300
여성	2600
여성	1300
남성	2400
남성	2800
여성	5200
여성	5200
남성	1500
*/

-- 2단계
SELECT T.성별 "성별"
     , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            ELSE '성별판별불가'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON
) T
GROUP BY T.성별;
--==>>
/*
여성	31800
남성	11000
*/
SELECT T.성별 "성별"
     , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
            ELSE '성별판별불가'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
-- 이렇게하면 성별이 NULL인 사원이 나온다
/*
남성	11000
여성	31800
(null)	42800
*/

-- 3단계 CASE WHEN THEN ELSE END 방법
SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별 
                             ELSE '모든사원'
       END "성별"
     , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별판별불가'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>> 
/*
남성	    11000
여성	    31800
모든사원	42800
*/

-- 3단계 NVL 방법
SELECT NVL(T.성별, '모든사원') "성별"
     , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성' 
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
            ELSE '성별판별불가'
       END "성별"
     , SAL "급여"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>> 
/*
남성	    11000
여성	    31800
모든사원	42800
*/


--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다
/*
-------- --------
 연령대   인원수
-------- --------
  10         ?
  20         ?
  30         ?
  50         ?
 전체       16
 -------- --------
*/

SELECT *
FROM TBL_SAWON;

-- INLINE VIEW 를 두 번 중첩
-- 1단계 현재나이 구하기
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
            ELSE 0
       END "현재나이"
FROM TBL_SAWON;

-- 2단계 서브쿼리문을 이용해 연령으로 표기하기
SELECT CASE WHEN T.현재나이 >= 50 THEN 50
            WHEN T.현재나이 >= 40 THEN 40
            WHEN T.현재나이 >= 30 THEN 30
            WHEN T.현재나이 >= 20 THEN 20
            WHEN T.현재나이 >= 10 THEN 10
       ELSE 0
       END "연령"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                ELSE 0
           END "현재나이"
    FROM TBL_SAWON
) T
ORDER BY 1;
--==>>
/*
10
10
20
20
20
20
20
20
20
20
30
30
50
50
50
50
*/

-- 3단계 2중 서브쿼리문을 이용해 연령대 별로 묶기
SELECT CASE WHEN T2.연령 IS NULL THEN '전체' 
            ELSE TO_CHAR(T2.연령)
       END "연령대"
    -- NVL(TO_CHAR(T2.연령), '전체') "연령대" -- 바로 윗 줄과 같은 의미
    
     , COUNT(T2.연령) "인원수"
FROM
(
    SELECT CASE WHEN T.현재나이 >= 50 THEN 50
                WHEN T.현재나이 >= 40 THEN 40
                WHEN T.현재나이 >= 30 THEN 30
                WHEN T.현재나이 >= 20 THEN 20
                WHEN T.현재나이 >= 10 THEN 10
           ELSE 0
           END "연령"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999) 
                    ELSE 0
               END "현재나이"
        FROM TBL_SAWON
    ) T
) T2
GROUP BY ROLLUP(T2.연령);
--==>>
/*
10	     2
20	     8
30	     2
50	     4
전체	16
*/


-- INLINE VIEW 를 한 번 사용
-- 1단계 TRUNC() 를 이용해 현재나이에서 첫째자리 절삭해 0으로 표시함으로서 연령으로 바꾸기
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE 0
       END, -1) "연령"
FROM TBL_SAWON
ORDER BY 1;
--==>>
/*
10
10
20
20
20
20
20
20
20
20
30
30
50
50
50
50
*/

-- 2단계 서브쿼리문을 이용해 연령대 구하기
SELECT 
     /*CASE WHEN T.연령 IS NULL THEN '전체' 
            ELSE TO_CHAR(T.연령)*/
       CASE GROUPING(T.연령) WHEN 0 THEN TO_CHAR(T.연령)
            ELSE '전체'
       END "T.연령"
     , COUNT(*) "인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                        THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                      ELSE 0
                 END, -1) "연령"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령);
--==>>
/*
10	     2
20	     8
30	     2
50	     4
전체	16
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300   -- 10번 부서 CLERK     직종의 급여합
10	    MANAGER	     2450   -- 10번 부서 MANAGER   직종의 급여합
10	    PRESIDENT	 5000   -- 10번 부서 PRESIDENT 직종의 급여합
10	    (null)	     8750   -- 10번 부서 모든      직종의 급여합
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875   -- 20번 부서 모든 직종의 급여합
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400   -- 30번 부서 모든 직종의 급여합
(null)  (null)      29025   -- 모든 부서 모든 직종의 급여합
*/


--○ CUBE() → ROLLUP() 보다 더 자세한 결과를 반환받는다.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10	    (null)	     8750
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)	    10875
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)	     9400
(null)	ANALYST	     6000   -- 모든 부서 ANALYST    직종의 급여합
(null)	CLERK	     4150   -- 모든 부서 CLERK      직종의 급여합
(null)	MANAGER	     8275   -- 모든 부서 MANAGER    직종의 급여합
(null)	PRESIDENT  	 5000   -- 모든 부서 PRESIDENT  직종의 급여합
(null)	SALESMAN	 5600   -- 모든 부서 SALESMAN   직종의 급여합
(null)	(null)	    29025   -- 모든 부서     모든   직종의 급여합
*/


--※ ROLLUP() 과 CUBE()는
--   그룹을 묶어주는 방식이 다르다.(차이)

-- ex.

-- ROLLUP(A, B, C)
-- → (A,B,C,) / (A,B) / (A) / ()


-- CUBE(A, B, C)
-- → (A, B, C)/(A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위의 과정은 (ROLLUP())묶음 방식이 다소 모자랄 때가 있고
--     아래 과정은(CUBE()) 묶음 방식이 다소 지나칠 때가 있기 때문에
--     다음과 같은 방식의 쿼리를 더 많이 사용하게 된다
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만
--     『GROUPING SETS』를 이용하여 묶어주는 방식이다.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	 8750

20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875

30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종	 9400

인턴	    CLERK	     3500
인턴	    SALESMAN	 5200
인턴	    전체직종	 8700

전체부서	전체직종	37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	 8750

20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875

30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종	 9400

인턴	    CLERK	     3500
인턴	    SALESMAN	 5200
인턴	    전체직종	 8700

전체부서	ANALYST	     6000
전체부서	CLERK	     7650
전체부서	MANAGER	     8275
전체부서	PRESIDENT	 5000
전체부서	SALESMAN	10800

전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
--==>> CUBE() 를 사용한 결과와 같은 조회 결과 반환

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())
ORDER BY 1, 2;
--==>> ROLLUP() 를 사용한 결과와 같은 조회 결과 반환


--------------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

--○ TBL_EMP 테이블을 대상으로
--   입사년도별 인원수를 조회한다
/*
    입사년도    인원수
------------------------
   1980          1
   1981          10
   1982          1
   1987          2
   2022          5
   전체          19
*/
-- 1단계
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(EXTRACT(YEAR FROM HIREDATE)) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)), ())
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987 	 2
2022	 5
(null)	19
*/

-- 2단계
SELECT CASE WHEN EXTRACT(YEAR FROM HIREDATE) IS NULL THEN '전체' 
            ELSE TO_CHAR(EXTRACT(YEAR FROM HIREDATE)) 
       END "입사년도"
     , COUNT(EXTRACT(YEAR FROM HIREDATE)) "인원수"
FROM TBL_EMP
GROUP BY GROUPING SETS((EXTRACT(YEAR FROM HIREDATE)), ())
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
전체	19
*/


--해답 풀이
-- 1단계
SELECT ? "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY 입사년도;

-- 2단계
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
--==>>

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;



SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러발생
--     ORA-00979: not a GROUP BY expression

SELECT  EXTRACT(YEAR FROM HIREDATE) "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;
--==>> 에러발생
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE) 
            ELSE '전체'
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러발생
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE) 
            ELSE '전체'
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러발생
--     ORA-00932: inconsistent datatypes: expected NUMBER got CHAR

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY') 
            ELSE '전체'
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러발생
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY') 
            ELSE '전체'
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러발생
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY') 
            ELSE '전체'
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
전체	19
*/

--------------------------------------------------------------------------------
--■■■ HAVING ■■■--

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE 부서번호가 20, 30
GROUP BY 부서번호;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO;
--==>>
/*
30	 9400
20	10875
*/

SELECT DEPTNO "부서번호"
     , SUM(SAL) "급여합"
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO
ORDER BY 1;
--==>> 에러발생
--     ORA-00934: group function is not allowed here
--     WHERE 조건절에서 SUM()을 쓸 수 없음

-- ①
SELECT DEPTNO "부서번호"
     , SUM(SAL) "급여합"
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000     -- 그래서 HAVING절을 쓴다
ORDER BY 1;
--==>> 30	9400

-- ②
SELECT DEPTNO "부서번호"
     , SUM(SAL) "급여합"
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
   AND DEPTNO IN (20, 30)
ORDER BY 1;
--==>> 30	9400
--     이렇게 써도 논리적으로 문제도 없지만
--     ①의 경우 WHERE절까지 포함해서 메모리에 올리므로 메모리 공간 차지가 적고,
--     ②의 경우 WHERE절이 없어 모든 데이터를 메모리에 올리므로
--     메모리에 쓸데없이 공간차지가 많다
--     그러므로 ①가 더 적절한 코드이다

--     ※HAVING절을 쓸땐 WHERE절에서 사용가능한지 고민해보고 코드 작성할 것

--------------------------------------------------------------------------------
--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수는 2 LEVEL 까지 중첩해서 사용할 수 있다
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875



-- RANK() / DENSE_RANK()
--> ORACLE 9i 부터 적용...MMSQL 2005 부터 적용

--> 하위 버전에서는 RANK() 나 DENSE_RANK() 를 사용할 수 없기 때문에
--  예를 들어... 급여 순위를 구하고자 한다면..
--  해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
--  확인한 숫자에 +1 을 추가 연산해주면
--  그 값이 곧 해당 사원의 등수가 된다

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1     -- SMITH 보다 급여가 높은 사람이 13명이므로
FROM EMP                -- SMITH 의 급여 등수는 +1을 해줘야 한다
WHERE SAL > 800;        -- SMITH 의 급여
--==>> 14               -- SMITH 의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;       -- ALLEN 의 급여
--==>> 7                -- ALLEN 의 급여 등수


--※ 서브 상관 쿼리(상관 서브 쿼리)
--   메인 쿼리가 있는 테이블의 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리(상관 서브 쿼리) 라고 부른다

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여", (1) "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > 800) "급여등수"
FROM EMP;

SELECT E.ENAME "사원명", E.SAL "급여"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "급여등수"
FROM EMP E
ORDER BY 3;
--==>>
/*
KING	5000	 1
FORD	3000	 2
SCOTT	3000	 2
JONES	2975	 4
BLAKE	2850	 5
CLARK	2450	 6
ALLEN	1600	 7
TURNER	1500	 8
MILLER	1300	 9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	 950	13
SMITH	 800	14
*/


--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목 조회
--   단, RANK() 함수를 사용하지 않고 서브상관쿼리를 활용할 수 있도록 한다

-- 참고↓----------------------
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;

SELECT E.ENAME "사원명", E.SAL "급여"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "급여등수"
FROM EMP E
ORDER BY 3;
-- 참고↑----------------------

SELECT E.ENAME "사원명", E.SAL "급여", E.DEPTNO "부서번호"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL) "전체급여등수"
     ,(1) "부서내급여등수"
FROM EMP E
ORDER BY 4;

SELECT E.ENAME "사원명", E.SAL "급여", E.DEPTNO "부서번호"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL) "전체급여등수"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL 
         AND DEPTNO = E.DEPTNO) "부서내급여등수"
FROM EMP E
ORDER BY 3, 5;
--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	2	2
MILLER	1300	10	3	3
SCOTT	3000	20	1	1
FORD	3000	20	1	1
JONES	2975	20	3	3
ADAMS	1100	20	4	4
SMITH	 800	20	5	5
BLAKE	2850	30	1	1
ALLEN	1600	30	2	2
TURNER	1500	30	3	3
MARTIN	1250	30	4	4
WARD	1250	30	4	4
JAMES	 950	30	6	6
*/

-- 해답 풀이
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800         -- SMITH 의 급여
  AND DEPTNO = 20;      -- SMITH 의 부서번호
--==>> 5                -- SMITH 의 부서내 급여 등수

SELECT E.ENAME "사원명", E.SAL "급여", E.DEPTNO "부서번호"
     ,(1) "부서내급여등수"
     ,(1) "전체급여등수"
FROM EMP E;

SELECT E.ENAME "사원명", E.SAL "급여", E.DEPTNO "부서번호"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL
         AND DEPTNO = E.DEPTNO) "부서내급여등수"
     ,(SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > E.SAL
         AND DEPTNO = E.DEPTNO) "전체급여등수"
FROM EMP E
ORDER BY 3, 5;
--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	2	2
MILLER	1300	10	3	3
SCOTT	3000	20	1	1
FORD	3000	20	1	1
JONES	2975	20	3	3
ADAMS	1100	20	4	4
SMITH	 800	20	5	5
BLAKE	2850	30	1	1
ALLEN	1600	30	2	2
TURNER	1500	30	3	3
MARTIN	1250	30	4	4
WARD	1250	30	4	4
JAMES	 950	30	6	6
*/



--○ EMP 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문 구성
/*
                                         - 각 부서 내에서 입사일자 별로 
                                           누적된 급여의 합
---------------------------------------------------------------------
 사원명    부서번호    입사일         급여      부서내입사별급여누적
---------------------------------------------------------------------
 SMITH	      20	  1980-12-17	   800              800
 JONES	      20	  1981-04-02	  2975             3775
 FORD	      20	  1981-12-03	  3000             6775
 SCOTT	      20	  1987-07-13	  3000               :
 ADAMS	      20	  1987-07-13	  1100               :
                           :                             :
*/
-- 1단계
SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , (1) "부서내입사별급여누적"
FROM EMP
ORDER BY DEPTNO, HIREDATE;

-- 입사순 누적 급여 → 위의 (1)에 넣으면 된다
SELECT SUM(SAL)
FROM EMP
WHERE DEPTNO = E.DEPTNO 
  AND HIREDATE <= E.HIREDATE;

-- 2단계
SELECT E.ENAME "사원명", E.DEPTNO "부서번호", E.HIREDATE "입사일", E.SAL "급여"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO) "부서내입사별급여누적"
FROM EMP E
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
CLARK	10	1981-06-09	2450	8750
KING	10	1981-11-17	5000	8750
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	 800	10875
JONES	20	1981-04-02	2975	10875
FORD	20	1981-12-03	3000	10875
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	9400
WARD	30	1981-02-22	1250	9400
BLAKE	30	1981-05-01	2850	9400
TURNER	30	1981-09-08	1500	9400
MARTIN	30	1981-09-28	1250	9400
JAMES	30	1981-12-03	 950	9400
*/

-- 3단계
SELECT E.ENAME "사원명", E.DEPTNO "부서번호", E.HIREDATE "입사일", E.SAL "급여"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO
          AND HIREDATE <= E.HIREDATE) "부서내입사별급여누적"
FROM EMP E
ORDER BY DEPTNO, HIREDATE;
--==>>
/*
CLARK	10	1981-06-09	2450	 2450
KING	10	1981-11-17	5000	 7450
MILLER	10	1982-01-23	1300	 8750

SMITH	20	1980-12-17	 800	  800
JONES	20	1981-04-02	2975	 3775
FORD	20	1981-12-03	3000	 6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875

ALLEN	30	1981-02-20	1600	 1600
WARD	30	1981-02-22	1250	 2850
BLAKE	30	1981-05-01	2850	 5700
TURNER	30	1981-09-08	1500	 7200
MARTIN	30	1981-09-28	1250	 8450
JAMES	30	1981-12-03	 950	 9400
*/


--○ EMP 테이블을 대상으로
--   입사한 사원의 수가 가장 많았을 때의
--   입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성
/*
---------- -------------------
 입사년월       인원수
---------- -------------------
 1981-02          2
 1981-09          2
 1981-12          2
 1987-07          2
---------- -------------------
*/
-- 야매로 일단 해봐
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = MAX(2)
ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (입사년월 기준 최대 인원)
ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');

-- EMP에서 입사한 사원의 수가 가장 많을 때의 수
SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');

-- 완성
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'))
ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT T1.입사년월, T1.인원수
FROM
(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
         , COUNT(*) "인원수"
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
) T1
WHERE T1.인원수 = (SELECT MAX(T2.인원수)
                   FROM
                   (
                        SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
                             , COUNT(*) "인원수"
                        FROM EMP
                        GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
                   ) T2
                  )
ORDER BY 1;