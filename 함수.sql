-- 문자 함수 : 문자 데이터를 가공하는 것
-- UPPER : 대문자, LOWER : 소문자, INITCAP : 첫글자만 대문자
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER('james');

-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열의 바이트 수 반환
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- SUBSTR / SUBSTRB
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB,5)
FROM EMP;

SELECT JOB,
SUBSTR(JOB, -LENGTH(JOB)), -- 음수는 뒤에서 계산, 길이에 대한 음수 값으로 역순 접근
SUBSTR(JOB, -LENGTH(JOB), 2),
SUBSTR(JOB, -3)
FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
INSTR('HELLO, ORACLE!', 'L',5) AS INSTR_2, -- 3번째 인자로 시작 위치 지정
INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3 -- 3번째 인자는 시작 위치, 4번째 인자는 몇번째까지
FROM DUAL;


-- 특정 문자가 포함된 행 찾기
SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체
-- 대체할 문자를 넣지 않으면 해당 문자 삭제
SELECT '010-1234-5678' AS REPLACE_BEFORE,
REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1,
REPLACE('010-1234-5678', '-') AS REPLACE_2
FROM DUAL;

-- LPAD / RPAD : 기준 공간의 칸 수를 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+')
FROM DUAL;
SELECT RPAD('ORACLE', 10, '+')
FROM DUAL;

SELECT 'ORACLE',
LPAD('ORACLE',10,'#'),
RPAD('ORACLE',10,'*'),
LPAD('ORACLE',10),
RPAD('ORACLE',10)
FROM DUAL;

-- 개인정보 뒷자리 * 표시로 출력하기
SELECT 
    RPAD('971225-', 14, '*') AS RPAD_JMNO,
    RPAD('010-1234-',13, '*') AS RPAD_PHONE
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),
    CONCAT(EMPNO, CONCAT(' : ', ENAME))
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM / LTRIM / RTRIM : 문자열 내에서 특정 문자열을 지우기 위해 사용
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
 '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
 '[' || LTRIM('<_Oracle_>', '<_') || ']' AS LTRIM_2,
 '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
 '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM_2
 FROM DUAL;

 -- 날짜 데이터를 다루는 날짜 함수
 -- SYSDATE : 운영체제의 현재 날짜와 시간 정보를 가져옴
 SELECT SYSDATE FROM DUAL;

 -- 날짜 데이터는 정수 값으로 +,- 가능
 SELECT SYSDATE AS 오늘,
 SYSDATE-1 AS 어제,
 SYSDATE+1 AS 내일
 FROM DUAL;

 -- 몇개월 이후 날짜 구하는 ADD_MONTH 함수
 -- 특정 날짜로부터 지정한 개월 수 이후의 날짜 데이터를 반환
SELECT SYSDATE,
ADD_MONTHS(SYSDATE, 3) -- 2번째 인자는 개월 수를 의미
FROM DUAL;

-- EMP에서 입사 10주년이 되는 사원들 데이터 출력
SELECT EMPNO, ENAME, HIREDATE,
ADD_MONTHS(HIREDATE, 120) AS 입사10주년
FROM EMP;

-- SYSDATE와 ADD_MONTHS 함수를 사용하여 현재 날짜와 6개월 후 날짜를 출력
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 6)
FROM DUAL;

-- 두 날짜 간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3,
ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS4
FROM EMP;

-- 날짜 정보 추출 함수
-- EXTRACT 함수는 날짜 유형의 데이터로부터 날짜 정보를 분리하여 새로운 컬름의 형태로 출력
SELECT EXTRACT(YEAR FROM DATE '2023-09-15') AS 년도추출
FROM DUAL;

SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 12;

-- 오늘 날짜 조회
SELECT SYSDATE
FROM DUAL;

-- 사번, 사원명, 급여 조회
-- ( 단 급여는 100단위의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, ROUND(SAL, -2)
FROM EMP
ORDER BY SAL DESC;

-- 사원번호가 홀수인 사람들 조회
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) != 0;

-- 사원명, 입사일 조회
-- 입사일은 년도와 월을 분리 추출해서 출력
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE) AS YEAR,
EXTRACT(MONTH FROM HIREDATE) AS MONTH
FROM EMP;

-- 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;

-- 81년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

-- 이름이 'E'로 끝나는 직원 조회
SELECT * FROM EMP
WHERE ENAME LIKE '%E';

-- 이름의 세 번째 글자가 'R'인 직원의 정보 조회
SELECT * FROM EMP
WHERE ENAME LIKE '__R%';

-- 사번, 사원명, 입사일 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 480) AS YEAR40
FROM EMP;

-- 입사일로부터 38년 이상 근무한 직원의 정보 조회

-- 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE) AS 년도
FROM DUAL;