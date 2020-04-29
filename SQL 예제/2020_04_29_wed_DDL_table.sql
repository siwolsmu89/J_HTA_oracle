CREATE TABLE sample_school_depts (
    dept_no NUMBER(3,0) PRIMARY KEY
    , dept_name VARCHAR2(30) CONSTRAINT school_dept_name_uk UNIQUE 
                             CONSTRAINT school_dept_name_nn NOT NULL
);

CREATE TABLE sample_school_profs (
    prof_no                   NUMBER(4,0) PRIMARY KEY
    , prof_name               VARCHAR2(20) CONSTRAINT prof_name_nn NOT NULL
    , prof_position           VARCHAR2(20) DEFAULT 'PROFESSOR'
                                           CONSTRAINT prof_position_nn NOT NULL 
    , dept_no                 NUMBER(3,0) CONSTRAINT prof_dept_no_fk REFERENCES sample_school_depts(dept_no) 
    , prof_registered_date    DATE  DEFAULT SYSDATE
);

CREATE TABLE sample_school_students (
    student_no                  NUMBER(4,0) PRIMARY KEY
    , student_name              VARCHAR2(20) CONSTRAINT student_name_nn NOT NULL
    , student_year              NUMBER(1,0) DEFAULT 1 
                                            CONSTRAINT student_year_cc CHECK (student_year BETWEEN 1 AND 4) 
                                            CONSTRAINT student_year_nn NOT NULL
    , dept_no                   NUMBER(3,0) CONSTRAINT student_dept_no_fk REFERENCES sample_school_depts(dept_no)
    , student_registered_date   DATE DEFAULT SYSDATE
);

CREATE TABLE sample_school_subjects (
    subject_no                  NUMBER(2,0) PRIMARY KEY
    , subject_title             VARCHAR2(60) CONSTRAINT subject_title_nn NOT NULL
    , dept_no                   NUMBER(3,0) CONSTRAINT subject_dept_no_fk REFERENCES sample_school_depts(dept_no)
    , subject_registered_date   DATE DEFAULT SYSDATE,
    CONSTRAINT subject_title_and_no_uk UNIQUE (subject_title, dept_no)
);

CREATE TABLE sample_school_courses (
    course_no               NUMBER(3,0) PRIMARY KEY
    , course_title          VARCHAR2(60) CONSTRAINT course_title_uk UNIQUE 
                                         CONSTRAINT course_title_nn NOT NULL
    , dept_no               NUMBER(3,0) CONSTRAINT course_dept_no_fk REFERENCES sample_school_depts(dept_no)
    , subject_no            NUMBER(2,0) CONSTRAINT course_subject_no_fk REFERENCES sample_school_subjects(subject_no)
    , prof_no               NUMBER(4,0) CONSTRAINT course_prof_no_fk REFERENCES sample_school_profs(prof_no)
    , course_student_count  NUMBER(2,0) CONSTRAINT course_student_count_cc CHECK (course_student_count >= 0)
    , course_registerable   CHAR(1)     DEFAULT 'Y'
                                        CONSTRAINT course_registerable_cc CHECK (course_registerable IN ('Y', 'N'))
    , course_registered_date DATE DEFAULT SYSDATE
);

CREATE TABLE sample_school_regs (
    reg_no                     NUMBER(3,0) PRIMARY KEY
    , course_no                NUMBER(3,0) CONSTRAINT reg_course_no_fk REFERENCES sample_school_courses(course_no)
    , student_no               NUMBER(4,0) CONSTRAINT reg_student_no_fk REFERENCES sample_school_students(student_no)
    , reg_canceled             CHAR(1) DEFAULT 'N' CONSTRAINT reg_canceled_cc CHECK (reg_canceled IN ('Y', 'N'))
    , reg_completed            CHAR(1) DEFAULT 'N' CONSTRAINT reg_completed_cc CHECK (reg_completed IN ('Y', 'N'))
    , reg_grade                NUMBER(3, 0) CONSTRAINT reg_grade_cc CHECK (reg_grade BETWEEN 0 AND 100)
    , reg_registered_date      DATE DEFAULT SYSDATE,
    CONSTRAINT sample_school_regs_uk UNIQUE (course_no, student_no)
);