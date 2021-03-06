CREATE TABLE DEPT (
  DEPTNO INT CONSTRAINT PK_DEPT PRIMARY KEY,
  DNAME VARCHAR(14) ,
  LOC VARCHAR(13)
);

CREATE TABLE EMP (
  EMPNO INT CONSTRAINT PK_EMP PRIMARY KEY,
  ENAME VARCHAR(10),
  JOB VARCHAR(9),
  MGR SMALLINT,
  HIREDATE DATETIME,
  SAL NUMERIC(7,2),
  COMM NUMERIC(7,2),
  DEPTNO INT CONSTRAINT FK_DEPTNO REFERENCES DEPT
);

CREATE TABLE UniDAC_BLOB (
  ID INT PRIMARY KEY,
  Title VARCHAR(30),
  Picture IMAGE
);

CREATE TABLE UniDAC_Text(
  ID INT PRIMARY KEY,
  Title VARCHAR(30),
  TextField TEXT
);

CREATE TABLE UniDAC_Loaded (
  Intg INTEGER,
  Dbl  DOUBLE PRECISION,
  Str  VARCHAR(50),
  Dat  DATETIME
);

CREATE TABLE CRGRID_TEST (
  Id INT PRIMARY KEY,
  Name VARCHAR(10),
  Country VARCHAR(30),
  City VARCHAR(30),
  Street VARCHAR(30),
  BirthDate DATETIME,
  Job VARCHAR(9),
  Hiredate DATETIME,
  Sal NUMERIC(7, 2),
  Remarks TEXT
);

INSERT INTO DEPT VALUES
  (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES
  (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
  (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
  (40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES
  (7369,'SMITH','CLERK',7902, CONVERT(DATETIME, '17-12-1980', 105),800,NULL,20);
INSERT INTO EMP VALUES
  (7499,'ALLEN','SALESMAN',7698,CONVERT(DATETIME, '20-02-1981', 105),1600,300,30);
INSERT INTO EMP VALUES
  (7521,'WARD','SALESMAN',7698,CONVERT(DATETIME, '22-02-1981', 105),1250,500,30);
INSERT INTO EMP VALUES
  (7566,'JONES','MANAGER',7839,CONVERT(DATETIME, '02-04-1981', 105),2975,NULL,20);
INSERT INTO EMP VALUES
  (7654,'MARTIN','SALESMAN',7698,CONVERT(DATETIME, '28-09-1981', 105),1250,1400,30);
INSERT INTO EMP VALUES
  (7698,'BLAKE','MANAGER',7839,CONVERT(DATETIME, '01-05-1981', 105),2850,NULL,30);
INSERT INTO EMP VALUES
  (7782,'CLARK','MANAGER',7839,CONVERT(DATETIME, '09-06-1981', 105),2450,NULL,10);
INSERT INTO EMP VALUES
  (7788,'SCOTT','ANALYST',7566,CONVERT(DATETIME, '13-07-1987', 105),3000,NULL,20);
INSERT INTO EMP VALUES
  (7839,'KING','PRESIDENT',NULL,CONVERT(DATETIME, '17-11-1981', 105),5000,NULL,10);
INSERT INTO EMP VALUES
  (7844,'TURNER','SALESMAN',7698,CONVERT(DATETIME, '08-09-1981', 105),1500,0,30);
INSERT INTO EMP VALUES
  (7876,'ADAMS','CLERK',7788,CONVERT(DATETIME, '13-07-1987', 105),1100,NULL,20);
INSERT INTO EMP VALUES
  (7900,'JAMES','CLERK',7698,CONVERT(DATETIME, '03-12-1981', 105),950,NULL,30);
INSERT INTO EMP VALUES
  (7902,'FORD','ANALYST',7566,CONVERT(DATETIME, '03-12-1981', 105),3000,NULL,20);
INSERT INTO EMP VALUES
  (7934,'MILLER','CLERK',7782,CONVERT(DATETIME, '23-01-1982', 105),1300,NULL,10);

INSERT INTO CRGRID_TEST (Id, Name, Country, City, Street, BirthDate, Job, HireDate, Sal) VALUES
  (5001, 'SMITH', 'ENGLAND', 'LONDON', 'BOND st.', CONVERT(DATETIME, '12-10-1963', 105), 'CLERK',
   CONVERT(DATETIME, '17-12-1980', 105), 800);
INSERT INTO CRGRID_TEST (Id, Name, Country, City, Street, BirthDate, Job, HireDate, Sal) VALUES
  (5002, 'ALLEN', 'ENGLAND', 'LONDON', 'BAKER st.', CONVERT(DATETIME, '04-03-1961', 105), 'SALESMAN',
   CONVERT(DATETIME, '20-02-1981', 105), 1600);
INSERT INTO CRGRID_TEST (Id, Name, Country, City, Street, BirthDate, Job, HireDate, Sal) VALUES
  (5003, 'MARTIN', 'FRANCE', 'LION', 'WEAVER st.', CONVERT(DATETIME, '23-01-1957', 105), 'MANAGER',
   CONVERT(DATETIME, '02-04-1981', 105), 2900);


GO
CREATE PROCEDURE SEL_FROM_EMP
AS
BEGIN
  SELECT * FROM Emp ORDER BY EmpNo;
END;