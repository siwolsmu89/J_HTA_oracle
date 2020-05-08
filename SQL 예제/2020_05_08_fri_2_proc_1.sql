-- 직원 번호와 인상률을 전달받아서 그 직원의 급여를 인상시키는 프로시저 작성하기
-- 작성 후 실행하면 프로시저가 컴파일됨(프로시저 항목 아래에 생성되어 있음)
CREATE OR REPLACE PROCEDURE update_salary
    (i_emp_id IN NUMBER) -- 매개변수
IS 
    -- 변수를 정의하는 부분
    -- 변수명        변수의 데이터타입
    -- v_emp_salary NUMBER;
    -- 변수명     테이블.컬럼%TPYE : 해당 컬럼의 데이터타입과 동일한 데이터타입으로 변수 선언
    v_emp_salary employees.salary%TYPE; -- 사원의 급여
    v_update_rate NUMBER(3,2);          -- 인상률
    
BEGIN
    -- SQL문장 혹은 PL/SQL 구문을 작성하는 부분
    -- 전달받은 직원아이디에 해당하는 직원정보를 조회한다.
    -- 조회된 직원의 급여를 위에서 선언한 v_emp_salary에 대입한다.
    SELECT salary 
    INTO v_emp_salary
    FROM employees
    WHERE employee_id = i_emp_id;
    
    -- 직원의 급여에 따라서 인상률을 결정하기
    -- 20000달러 이상 10%, 10000달러 이상 15%, 그외 20%
    IF v_emp_salary >= 20000 THEN v_update_rate := 0.10;
    ELSIF v_emp_salary >= 10000 THEN v_update_rate := 0.15;
    ELSE v_update_rate := 20;
    END IF;
 
    -- 급여를 인상시키기
    UPDATE employees
    SET
        salary = salary + TRUNC(salary * v_update_rate)
    WHERE 
        employee_id = i_emp_id;
        
    -- DB에 영구적으로 반영시키기
    COMMIT;
    
END;