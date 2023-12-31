-- NOT NULL : 빈 값을 허용하지 않음
CREATE TABLE TABLE_NOTNULL (
    LOGIN_ID    VARCHAR2(20) NOT NULL,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);

INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('곰돌이사육사', 'SDFJ23N4', NULL);
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('곰돌이', 'SDFJ23N4', NULL);
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('사육사', 'SDFJ23N4', NULL);
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL)
    VALUES(NULL, , NULL); -- 오류남

SELECT * FROM TABLE_NOTNULL;
DROP TABLE TABLE_NOTNULL;
-- UNIQUE : 중복되지 않는 값
CREATE TABLE TABLE_UNIQUE (
    LOGIN_ID    VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);

DROP TABLE TABLE_UNIQUE;

INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('곰돌이사육사', 'SDFJ23N4', NULL);
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES(NULL, 'SDFJ23N4', NULL);
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('곰돌이사육사', 'SDFJ23N4', NULL); -- 오류남

SELECT * FROM TABLE_UNIQUE;

-- FOREIGN KEY : 외래키는 서로 다른 테이블간 관계를 정의
-- 참조하고 있는 기본키의 데이터 타입과 일치해야 하며, 외래키에 참조되는 기본키는 삭제할 수 없음.
CREATE TABLE DEPT_FK (
    DEPTNO  NUMBER(2) PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13)
);

CREATE TABLE EMP_FK (
    EMPNO   NUMBER(4) PRIMARY KEY,
    ENAME   VARCHAR2(10) NOT NULL,
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    SAL     NUMBER(7, 2),
    COMM    NUMBER(7, 2),
    DEPTNO  NUMBER(2) REFERENCES DEPT_FK (DEPTNO) -- 외래키(참조키)
);


INSERT INTO DEPT_FK 
    VALUES (10, '농구부', '서울');
INSERT INTO EMP_FK
    VALUES (9000, '강백호','농구',8000, 2300, 1200, 10);

SELECT *
FROM EMP_FK E JOIN DEPT_FK D
ON E.DEPTNO = D.DEPTNO;

-- CHECK : 데이터 형태와 범위를 정함
-- EX) ID 및 PASSWORD 길이 제한
-- EX) 유효 값 범위 확인 (나이 / 성적 / 전화번호 / 이메일)
CREATE TABLE TABLE_CHECK(
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) CHECK(LENGTH(LOGIN_PWD) >= 5),
    TEL VARCHAR2(20)
);

INSERT INTO TABLE_CHECK VALUES('JKS2024','SPHB333', '010-1234-5678');
SELECT * FROM TABLE_CHECK;

-- DEFAULT : 열에 저장할 값이 지정되지 않았을 경우에 기본값을 정함
CREATE TABLE TABLE_DEFAULT (
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) CHECK(LENGTH(LOGIN_PWD) >= 5),
    TEL VARCHAR2(15) DEFAULT '010-0000-0000'
);
DROP TABLE TABLE_DEFAULT;
INSERT INTO TABLE_DEFAULT(LOGIN_ID, LOGIN_PWD) VALUES('JKS2024', 'SPEH2K34');
SELECT * FROM TABLE_DEFAULT;

-- SEQUENCE : 특정 규칙에 맞는 연속 숫자를 생성하는 객체

CREATE TABLE DEPT_SEQ (
    DEPTNO  NUMBER(2) PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13)
);

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10 -- 증가 값
START WITH 10 -- 시작 값
MAXVALUE 90 -- 최대값
MINVALUE 0 -- 최소값
NOCYCLE -- 반복
CACHE 2;

INSERT INTO DEPT_SEQ VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQ VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'FRONT', 'BUSAN');

SELECT * FROM DEPT_SEQ;
