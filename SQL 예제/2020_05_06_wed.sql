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