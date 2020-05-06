CREATE TABLE contacts (
    contact_name VARCHAR2(100) NOT NULL
    , contact_tel VARCHAR2(50) NOT NULL
    , contact_email VARCHAR2(250)
    , contact_create_date DATE DEFAULT SYSDATE
);

INSERT INTO contacts (contact_name, contact_tel, contact_email)
VALUES ('ȫ�浿', '010-1234-5678', 'hong@gmail.com');

INSERT INTO contacts (contact_name, contact_tel, contact_email)
VALUES ('������', '010-6789-3453', 'kim@naver.com');

commit;

select *
from contacts;

-- HR ����ڿ��� CONATCTS�� ���� ��ü���� �ο��ϱ� : SELECT
GRANT SELECT
ON contacts
TO hr;

-- HR ����ڿ��� CONTACTS�� ���� ��ü���� �ο��ϱ� : UPDATE / name�� ����Ұ�, tel, email�� ���氡���ϵ���
GRANT UPDATE (contact_tel, contact_email)
ON contacts
TO hr;


-- erm���Ϸ� ���� DDL�� �����ؼ� �ٿ��ְ� ��ũ��Ʈ ����
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
    SELECT C.course_no          -- ������ȣ
        , C.course_name         -- ������
        , C.course_quota        -- ���� ����
        , C.course_reg_cnt      -- ��û�ο�
        , C.course_closed       -- ��������
        , S.subject_no          -- �����ȣ
        , S.subject_name        -- �����
        , P.prof_no             -- ��米����ȣ
        , P.prof_name           -- ��米���̸�
        , D.dept_no             -- �����а���ȣ
        , D.dept_name           -- �����а���
        , c.course_create_date  -- �����
    FROM school_courses C, school_professors P, school_subjects S, school_departments D
    WHERE C.prof_no = P.prof_no
        AND C.subject_no = S.subject_no
        AND S.dept_no = D.dept_no;
        
-- �������� ������ ����        
SELECT *
FROM school_courses_view
WHERE course_no = ?;

-- Ư�� �а����� ������ ���� ����
SELECT *
FROM school_courses_view
WHERE dept_name = ?;

-- Ư�� ������ ������ ���� ����
SELECT *
FROM school_courses_view
WHERE prof_name = ?;

-- �������� ���� ���� ����
SELECT *
FROM school_courses_view
WHERE course_closed = 'N';