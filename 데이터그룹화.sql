-- GROUP BY : 여러 데이터에서 의미있는 하나의 결과를 특정 열 값별로 묶어서 출력할 때 사용
SELECT AVG(SAL)
FROM EMP;

SELECT ROUND(AVG(SAL), 2) AS 사원전체평균
FROM EMP;

-- 부서별 사원 평균
SELECT DEPTNO, ROUND(AVG(SAL), 2) AS 부서별평균
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- GROUP BY 절 없이 구현
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 10;
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 20;
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 30;

-- 집합 연산자를 사용하여 구현
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30;

-- 부서코드, 급여 합계, 부서 평균, 부서 코드 순 정렬
SELECT DEPTNO 부서코드,
    SUM(SAL) 합계,
    ROUND(AVG(SAL),2)평균,
    COUNT(*) -- 각 그룹에 해당하는 인원이 몇명인지 확인
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- HAVING 절 : GROUP BY 절이 존재하는 경우에만 사용 가능
-- GROUP BY 절을 통해 그룹화된 결과 값의 범위를 제한할 때 사용
SELECT DEPTNO, JOB, ROUND(AVG(SAL), 2)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, ROUND(AVG(SAL), 2)
FROM EMP
WHERE SAL >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- 1. 부서별 직책의 평균 급여가 500 이상인 사원들의 부서 번호, 직책, 부서별 직책의 평균 급여 출력
SELECT DEPTNO , JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 500
ORDER BY DEPTNO, JOB;

-- 2. 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력
-- 평균 급여를 출력할 때는 소수점 제외하고 부서 번호별로 출력
SELECT DEPTNO, ROUND(AVG(SAL),0), MAX(SAL), MIN(SAL), COUNT(*)
FROM EMP
GROUP BY DEPTNO;

-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT TO_CHAR(HIREDATE, 'YYYY') 입사일,
DEPTNO,
COUNT(*) 사원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X)
SELECT NVL2(COMM, 'O', 'X') AS 추가수당,
COUNT(*) AS 사원수
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

-- 6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO, TO_CHAR(HIREDATE, 'YYYY') 입사년도,
COUNT(*) 사원수,
MAX(SAL) 최고급여,
TRUNC(AVG(SAL)) 평균급여,
SUM(SAL) 합계
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY DEPTNO;

-- 조인 : 두개 이상의 테이블에서 데이터를 가져와서 연결하는 SQL 기능
-- RDBMS에서는 테이블 설계 시 무결성 원칙으로 인해 동일한 정보가 여러군데 존재하면 안 됨,
-- 필연적으로 테이블을 관리 목적에 맞게 설계함.
SELECT * FROM EMP, DEPT
ORDER BY EMPNO;

-- 열 이름을 비교하는 조건식으로 조인하기
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

-- 테이블 별칭 사용하기
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- 조인 종류 : 두개 이상의 테이블을 하나의 테이블처럼 가로로 늘려서 출력하기 위해 사용
-- 조인은 대상 데이터를 어떻게 연결하는 지에 따라 등가/비등가/자체/외부 조인으로 나뉨
-- 등가 조인 : 테이블을 연결한 후에 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 방식
-- 등가 조인(내부 조인 / 단순 조인)은 안시 조인과 오라클 조인이 있음

-- EMP 테이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 다음과 같이 등가 조인을 했을 때 급여가 2500 이하이고 사원 번호가 9999 이하인
-- 사원의 정보가 출력되도록 작성
-- 오라클 조인
SELECT EMPNO, ENAME, SAL, E.DEPTNO, DNAME, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND SAL <= 2500
AND EMPNO <= 9999
ORDER BY EMPNO;

-- ANSI 조인
SELECT EMPNO, ENAME, SAL, E.DEPTNO, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE SAL <= 2500
AND EMPNO <= 9999
ORDER BY EMPNO;