-- 사용자 생성 및 권한 관리 (내 컴퓨터 관리자 계정으로 접속)

-- 사용자명 scott
-- 비밀번호 tiger
CREATE USER scott IDENTIFIED BY tiger;

-- 생성된 사용자에게 데이터베이스 연결 권한 부여하기
GRANT CREATE SESSION TO scott;

-- 일반 사용자에게 부여되는 시스템 권한을 그룹화해놓은 롤을 이용해서 권한부여하기
GRANT CONNECT, RESOURCE TO scott;

-- scott 계정의 contacts 테이블 조회하기
-- scott 사용자가 GRANT해주지 않으면 조회하기 불가능
SELECT *
FROM scott.contacts;

-- 전화번호 변경하기
UPDATE scott.contacts
SET
    contact_tel = '010-1122-3344'
WHERE contact_name = '김유신';

-- 권한을 주지 않은 name 열에 대해서는 UPDATE 작업 실행 불가능
-- insufficient privileges : 권한 부족
UPDATE scott.contacts
SET
    contact_name = '강감찬'
WHERE contact_name = '김유신';

-- scott.contacts에 대한 테이블의 동의어를 생성하기
CREATE SYNONYM contacts FOR scott.contacts;

-- 동의어를 사용해 조회하기
SELECT *
FROM contacts;

-- 시스템 권한 보기
SELECT *
FROM ROLE_SYS_PRIVS;

-- 사전테이블 USER_TABLES 보기 (사용자의 모든 테이블 정보 조회)
SELECT *
FROM USER_TABLES;

-- 사용자의 모든 뷰 정보 조회
SELECT *
FROM USER_VIEWS;

-- 사용자의 모든 시퀀스 정보 조회
SELECT *
FROM USER_SEQUENCES;

-- 모든 사용자 정보 조회
SELECT *
FROM USER_USERS;

GRANT CREATE VIEW TO scott;

-- 집합 연산자 사용하기
-- 모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
-- 사원별로 한 번씩만 표시하기
SELECT employee_id, job_id 
FROM employees
UNION
SELECT employee_id, job_id 
FROM job_history;

-- 모든 사원의 현재 부서아이디와 이전 소속부서 아이디를 조회하기
SELECT employee_id, department_id
FROM employees
UNION ALL
SELECT employee_id, department_id
FROM job_history;

-- 현재 종사하는 직종과 같은 직종에서 종사하고 있는 사원의 아이디와 직종아이디 조회하기
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

-- 위의 결과와 같은 조인을 사용한 구문
SELECT E.employee_id, E.job_id
FROM employees E, job_history H
WHERE e.employee_id = H.employee_id
    AND e.job_id = H.job_id;

-- 직종이 변경된 적이 없는 사원의 아이디 조회하기
SELECT employee_id
FROM employees
MINUS
SELECT employee_id
FROM job_history;

-- 직종이 변경된 적이 없는 사원의 아이디와 이름 조회하기
SELECT A.employee_id, B.first_name
FROM (SELECT employee_id
     FROM employees
     MINUS
     SELECT employee_id
     FROM job_history) A, employees B
WHERE A.employee_id = B.employee_id
ORDER BY 1;

-- 직종이 변경된 적이 없는 사원의 아이디, 이름, 현재 직종, 소속부서명을 조회하기
SELECT A.employee_id, E.first_name, E.job_id, D.department_name
FROM (SELECT employee_id
      FROM employees
      MINUS 
      SELECT employee_id
      FROM job_history) A
      , employees E
      , departments D
WHERE A.employee_id = E.employee_id
    AND E.department_id = D.department_id
ORDER BY 1;

-- 모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
-- 사원아이디, 직종, 급여를 조회하기
SELECT employee_id, job_id, salary
FROM employees
UNION 
SELECT employee_id, job_id, 0   
FROM job_history;