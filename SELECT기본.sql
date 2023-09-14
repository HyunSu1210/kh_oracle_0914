DESC EMP;
DESC DEPT;
DESC BONUS;
DESC SALGRADE;
---------------------------------------------

 -- 기본 SELECT *(열을 의미) FROM EMP(테이블 이름);  세미콜론으로 끝남
 SELECT * FROM EMP;
 -- EMP테이블에서 사원번호, 사원이름, 사원이 속한 부서번호만 조회
 SELECT EMPNO, ENAME, DEPTNO
 FROM EMP;
 -- SQL문 작성 시 유의 사항
 -- SQL문은 대소문자를 구분하지 않는다.
 -- SQL문장은 한줄 또는 여러 줄에 입력 될 수 있음.
 -- 일반적으로 키워드는 대문자로 입력 한다.
 -- SQL문의 마지막 절은 ;으로 끝나야 한다.
 
 -- 사원번호와 부서 번호만 나오도록 EMP 테이블 조회하기
 SELECT EMPNO, DEPTNO FROM EMP;
 -- 별칭 설정 하기 : AS, 열 이름 또는 컬럼 이름을 별칭으로 표시할 수 있음.
 SELECT ENAME AS 사원명, SAL AS 월급여, SAL*12+COMM AS 연봉,COMM AS 성과급 
 FROM EMP;
 
 
 ---중복 제거하기: DISTINCT, 데이터를 조회할 때 중복된 데이터 중 하나만 선택하고자 하는 경우
 SELECT * FROM EMP;
 SELECT DISTINCT DEPTNO FROM EMP;
 SELECT DISTINCT JOB FROM EMP;
 -- 컬럼값을 계산하는 산술연산자 : +,-,*,/
 SELECT ENAME, SAL, SAL-12
 FROM EMP;
 -- WHERE구문 : 데이터를 조회할 때 사용자가 원하는 조건에 맞는 데이터만 조회하고 싶을 때 사용(행을 제한)
 -- 여러 연산자와 함게 사용 함.
 SELECT * FROM EMP
 WHERE DEPTNO = 10;    -- DB에서는 '=' 같다라는 의미로 쓰임.
 
 SELECT * FROM EMP
 WHERE EMPNO = 7369;
 
 --급여가 2500 초과인 사람의 사원번호, 이름,직무,급여
SELECT EMPNO AS 사원번호,ENAME AS 사원명 ,JOB AS 직무,SAL AS 급여
FROM EMP
WHERE SAL > 2500;

SELECT *
FROM EMP
WHERE SAL * 12 = 36000;


-----성과급이 500 초과인 사원 출력
SELECT * FROM EMP
WHERE COMM > 500;

--입사일이 81년 1월 1일 이전인 데이터를 조회하는 명령
-- 날짜를 비교할 경우 날짜 형식에 맞춰서 비교하면 됨.
SELECT * FROM EMP
WHERE HIREDATE < '81/01/01';

--같지 않음을 표현하는 방법은 여러가지 존재: <> , !=, ^=, NOT
SELECT * FROM EMP
WHERE DEPTNO ^= 30;

-- 급여가 3000이상이고, 부서가 20번인 사원 조회(2가지 조건을 모두 만족해야 하는 경우)
SELECT * 
FROM EMP
WHERE SAL >= 3000 AND DEPTNO =20;

-- 급여가 300이상이고, 부서가 20번이고, 입사일이 82년 1월1일 이전 입사인 사원 조회
SELECT * 
FROM EMP
WHERE SAL >=3000 AND DEPTNO = 20 AND HIREDATE < '82/01/01';


--급여가 3000 이상이고, 부서가 20번이거나 입사일이 82년 1월 1일 이전의 사원 조회
SELECT *
FROM EMP
WHERE SAL >=3000  AND (DEPTNO = 20 OR HIREDATE <'82/01/01');


-- 급여가 2500 이상이고 직업이 MANAGER인 사원정보만 출력
SELECT * 
FROM EMP
WHERE SAL > 2500 AND JOB = 'MANAGER';


SELECT *
FROM EMP
WHERE SAL != 3000;


--IN연산자 : WHERE 조건 속, 특정 조건의 열만을 출력.
SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN','CLERK');   

SELECT *
FROM EMP
WHERE DEPTNO NOT IN (20,30);

--BETWEEN A AND B  연산자 : 일정한 범위를 조회할 때 사용하는 연산자

--급여가 2000이상 3000이하인 사원 조회
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;




SELECT *
FROM EMP
WHERE EMPNO BETWEEN 7689 AND 9702;

-- 1980년에 입사하지 않은 사원 조회
SELECT *
FROM EMP
WHERE NOT HIREDATE < '1981/01/01';

--LIKE, NOT LIKE 연산자: 일부 문자열이 포함되어 있는지 여부를 확인하는 연산자, 주로 검색에서 사용
-- % : 길이와 상관없이 모든 문자를 의미
-- _ : 문자 1자를 의미
SELECT EMPNO, ENAME 
FROM EMP
WHERE ENAME LIKE '%K%';

SELECT *
FROM EMP
WHERE ENAME LIKE '_L%'
--사원 이름에 AM이 포함되어 있는 사원데이터 출력

SELECT *
FROM EMP
WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM이 포함되어 있지 않은 사원데이터 출력
SELECT *
FROM EMP
WHERE ENAME NOT LIKE '%AM%';

--NULL : 미확정 또는 알 수 없는 값을 의미함, 그래서 연산, 할당, 비교 불가(=,IN사용불가)
SELECT ENAME, SAL*12+COMM AS 연봉 ,COMM
FROM EMP;

SELECT *
FROM EMP
WHERE COMM =NULL;  --값이 없기에, 연산불가

--IS NULL
SELECT *
FROM EMP
WHERE COMM IS NOT NULL -- NULL 여부를 확인할 때 사용하는 연산자

--MANAGER가 있는 사원만 조회.
SELECT *
FROM EMP
WHERE MGR IS NOT NULL;


