-- ������� ��ü ���� �Ѿ��� ����ϱ�
CREATE OR REPLACE FUNCTION get_total_salary
    RETURN NUMBER
IS
    v_total_salary  NUMBER := 0;
    v_salary        employees.salary%TYPE;
    v_cms           employees.commission_pct%TYPE;
    v_annual_salary employees.salary%TYPE;
    
    -- Ŀ�� ����
    -- emp_list Ŀ���� �Ʒ� SELECT ���� ���� ����� ����Ű�� �ִ�.
    CURSOR emp_list IS 
    SELECT salary, NVL(commission_pct, 0) AS cms
    FROM employees;
    
BEGIN
    -- Ŀ���� FOR������ �����Ų��.
    -- FOR ������ IN Ŀ���� LOOP
    --    ���๮;
    -- END LOOP;

    FOR emp IN emp_list LOOP
       
    END LOOP;

    RETURN v_total_salary;
END;