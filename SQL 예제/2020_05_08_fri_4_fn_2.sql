-- 지정된 부서에 소속된 사원 수를 반환하는 함수
CREATE OR REPLACE FUNCTION get_emp_count
    (i_dept_no IN NUMBER)
    
    RETURN NUMBER
IS
    v_emp_count NUMBER(3,0);
BEGIN
    SELECT COUNT(*)
    INTO v_emp_count
    FROM employees
    WHERE department_id = i_dept_no;
    
    RETURN v_emp_count;
END;