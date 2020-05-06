CREATE TABLE contacts (
    contact_name VARCHAR2(100) NOT NULL
    , contact_tel VARCHAR2(50) NOT NULL
    , contact_email VARCHAR2(250)
    , contact_create_date DATE DEFAULT SYSDATE
);

INSERT INTO contacts (contact_name, contact_tel, contact_email)
VALUES ('홍길동', '010-1234-5678', 'hong@gmail.com');

INSERT INTO contacts (contact_name, contact_tel, contact_email)
VALUES ('김유신', '010-6789-3453', 'kim@naver.com');

commit;

select *
from contacts;

-- HR 사용자에게 CONATCTS에 대한 객체권한 부여하기 : SELECT
GRANT SELECT
ON contacts
TO hr;

-- HR 사용자에게 CONTACTS에 대한 객체권한 부여하기 : UPDATE / name은 변경불가, tel, email만 변경가능하도록
GRANT UPDATE (contact_tel, contact_email)
ON contacts
TO hr;


-- erm파일로 만든 DDL문 복사해서 붙여넣고 스크립트 실행
/* Create Tables */

CREATE TABLE SCHOOL_COURSES
(
	COURSE_NO number(4,0) NOT NULL,
	SUBJECT_NO number(4,0) NOT NULL,
	PROF_NO number(4,0) NOT NULL,
	COURSE_NAME varchar2(200) NOT NULL,
	COURSE_QUOTA number(2,0) DEFAULT 30,
	COURSE_REG_CNT number(2,0) DEFAULT 0,
	COURSE_CANCEL_CNT number(2,0) DEFAULT 0,
	COURSE_CLOSED char(1) DEFAULT 'N',
	COURSE_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (COURSE_NO)
);


CREATE TABLE SCHOOL_COURSE_REGISTRATIONS
(
	REG_NO number(5,0) NOT NULL,
	COURSE_NO number(4,0) NOT NULL,
	STUDENT_NO number(4,0) NOT NULL,
	REG_CANCELED char(1) DEFAULT 'N',
	REG_COMPLETED char(1) DEFAULT 'N',
	REG_SCORE number(2,1),
	REG_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (REG_NO),
	CONSTRAINT COURSE_REG_UK UNIQUE (COURSE_NO, STUDENT_NO)
);


CREATE TABLE SCHOOL_DEPARTMENTS
(
	DEPT_NO number(4,0) NOT NULL,
	DEPT_NAME varchar2(100) NOT NULL,
	PRIMARY KEY (DEPT_NO)
);


CREATE TABLE SCHOOL_PROFESSORS
(
	PROF_NO number(4,0) NOT NULL,
	PROF_NAME varchar2(100) NOT NULL,
	PROF_POSITION varchar2(50),
	DEPT_NO number(4,0) NOT NULL,
	PROF_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (PROF_NO)
);


CREATE TABLE SCHOOL_STUDENTS
(
	STUDENT_NO number(4,0) NOT NULL,
	STUD_NAME varchar2(100) NOT NULL,
	STUD_GRADE number(1) NOT NULL,
	DEPT_NO number(4,0) NOT NULL,
	STUD_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (STUDENT_NO)
);


CREATE TABLE SCHOOL_SUBJECTS
(
	SUBJECT_NO number(4,0) NOT NULL,
	SUBJECT_NAME varchar2(200) NOT NULL,
	DEPT_NO number(4,0) NOT NULL,
	SUBJECT_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (SUBJECT_NO)
);



/* Create Foreign Keys */

ALTER TABLE SCHOOL_COURSE_REGISTRATIONS
	ADD FOREIGN KEY (COURSE_NO)
	REFERENCES SCHOOL_COURSES (COURSE_NO)
;


ALTER TABLE SCHOOL_PROFESSORS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPARTMENTS (DEPT_NO)
;


ALTER TABLE SCHOOL_STUDENTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPARTMENTS (DEPT_NO)
;


ALTER TABLE SCHOOL_SUBJECTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPARTMENTS (DEPT_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (PROF_NO)
	REFERENCES SCHOOL_PROFESSORS (PROF_NO)
;


ALTER TABLE SCHOOL_COURSE_REGISTRATIONS
	ADD FOREIGN KEY (STUDENT_NO)
	REFERENCES SCHOOL_STUDENTS (STUDENT_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (SUBJECT_NO)
	REFERENCES SCHOOL_SUBJECTS (SUBJECT_NO)
;

CREATE SEQUENCE SCHOOL_DEPT_SEQ START WITH 10 INCREMENT BY 10 NOCACHE;

CREATE SEQUENCE SCHOOL_PROF_SEQ START WITH 1000 INCREMENT BY 1 NOCACHE;

CREATE SEQUENCE SCHOOL_STUDENT_SEQ START WITH 5000 INCREMENT BY 1 NOCACHE;

CREATE SEQUENCE SCHOOL_SUBJECT_SEQ START WITH 100 INCREMENT BY 10 NOCACHE;

CREATE SEQUENCE SCHOOL_COURSE_SEQ START WITH 100 INCREMENT BY 1 NOCACHE;

CREATE SEQUENCE SCHOOL_COURSE_REG_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE VIEW school_courses_view
AS 
    SELECT C.course_no          -- 과정번호
        , C.course_name         -- 과정명
        , C.course_quota        -- 과정 정원
        , C.course_reg_cnt      -- 신청인원
        , C.course_closed       -- 마감여부
        , S.subject_no          -- 과목번호
        , S.subject_name        -- 과목명
        , P.prof_no             -- 담당교수번호
        , P.prof_name           -- 담당교수이름
        , D.dept_no             -- 개설학과번호
        , D.dept_name           -- 개설학과명
        , c.course_create_date  -- 등록일
    FROM school_courses C, school_professors P, school_subjects S, school_departments D
    WHERE C.prof_no = P.prof_no
        AND C.subject_no = S.subject_no
        AND S.dept_no = D.dept_no;
        
-- 개설과정 상세정보 보기        
SELECT *
FROM school_courses_view
WHERE course_no = ?;

-- 특정 학과에서 개설한 과정 보기
SELECT *
FROM school_courses_view
WHERE dept_name = ?;

-- 특정 교수가 개설한 과정 보기
SELECT *
FROM school_courses_view
WHERE prof_name = ?;

-- 마감되지 않은 과정 보기
SELECT *
FROM school_courses_view
WHERE course_closed = 'N';