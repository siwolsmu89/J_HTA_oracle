-- 사원들의 전체 연봉 총액을 계산하기
CREATE OR REPLACE FUNCTION get_total_salary
    RETURN NUMBER
IS
    v_total_salary  NUMBER := 0;
    v_salary        employees.salary%TYPE;
    v_cms           employees.commission_pct%TYPE;
    v_annual_salary employees.salary%TYPE;
    
    -- 커서 선언
    -- emp_list 커서는 아래 SELECT 문의 실행 결과를 가리키고 있다.
    CURSOR emp_list IS 
    SELECT salary, NVL(commission_pct, 0) AS cms
    FROM employees;
    
BEGIN
    -- 커서를 FOR문에서 실행시킨다.
    -- FOR 변수명 IN 커서명 LOOP
    --    수행문;
    -- END LOOP;

    FOR emp IN emp_list LOOP
       
    END LOOP;

    RETURN v_total_salary;
END;