-- 직원아이디를 전달받아서 그 직원의 연봉(커미션이 포함된)을 반환하는 함수
CREATE OR REPLACE FUNCTION get_annual_salary
    (i_emp_id IN NUMBER)        -- 직원아이디를 매개변수로 전달받는다.
    RETURN NUMBER               -- 이 함수의 반환값은 숫자값이다.
    
IS
    v_salary        employees.salary%TYPE;              -- 급여
    v_cms           employees.commission_pct%TYPE;      -- 커미션
    v_annual_salary employees.salary%TYPE;              -- 연봉
    
BEGIN
    -- 직원아이디에 해당하는 직원의 급여와 커미션을 조회해서 변수에 저장
    SELECT salary, NVL(commission_pct, 0)
    INTO v_salary, v_cms
    FROM employees
    WHERE employee_id = i_emp_id;
    
    -- 커미션이 반영된 연봉을 계싼해서 변수에 대입한다.
    v_annual_salary := TRUNC(v_salary * 12 * (1 + v_cms));
    
    -- 변수에 저장된 값을 반환한다.
    RETURN v_annual_salary;
    
END;