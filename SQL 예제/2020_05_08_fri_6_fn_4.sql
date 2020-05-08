-- 지정된 부서의 연봉 총액을 반환하는 함수
CREATE OR REPLACE FUNCTION get_dept_total_salary
    (i_dept_id IN NUMBER)
    RETURN NUMBER
IS 
    v_salary            employees.salary%TYPE;
    v_cms               employees.commission_pct%TYPE;
    v_annual_salary     employees.salary%TYPE;
    v_total_salary      NUMBER := 0;
    
    -- 파라미터가 필요한 커서
    CURSOR emp_list(param_dept_id NUMBER) IS
    SELECT salary, NVL(commission_pct, 0) AS cms
    FROM employees
    WHERE department_id = param_dept_id;
    
BEGIN
    
    FOR emp IN emp_list(i_dept_id) LOOP
        v_salary := emp.salary;
        v_cms := emp.cms;
        v_annual_salary := TRUNC(v_salary * 12 * (1 + v_cms));
        v_total_salary := v_total_salary + v_annual_salary;
    END LOOP;
    
    RETURN v_total_salary;
    
END;