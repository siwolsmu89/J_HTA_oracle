UPDATE sample_school_courses
SET 
    course_student_count=5;

ALTER TABLE sample_school_courses
MODIFY course_student_count DEFAULT 5;

UPDATE sample_school_courses
SET
    course_student_count=2
WHERE course_no = 307;

commit;