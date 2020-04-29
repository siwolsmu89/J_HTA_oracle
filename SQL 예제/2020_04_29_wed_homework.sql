INSERT INTO sample_school_regs
    (reg_no, course_no, student_no, reg_canceled, reg_completed, reg_grade, reg_registered_date)
VALUES
    (sample_school_reg_seq.NEXTVAL, 300, 2000, 'N', 'N', NULL, SYSDATE);

INSERT INTO sample_school_regs
    (reg_no, course_no, student_no, reg_canceled, reg_completed, reg_grade, reg_registered_date)
VALUES
    (sample_school_reg_seq.NEXTVAL, 300, 2001, 'N', 'N', NULL, SYSDATE);

INSERT INTO sample_school_regs
    (reg_no, course_no, student_no, reg_canceled, reg_completed, reg_grade, reg_registered_date)
VALUES
    (sample_school_reg_seq.NEXTVAL, 300, 2002, 'N', 'N', NULL, SYSDATE);

UPDATE sample_school_courses
    SET course_student_count=3
WHERE course_no=300;