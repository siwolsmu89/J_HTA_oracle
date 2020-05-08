-- ������ �μ��� �Ҽӵ� ��� ���� ��ȯ�ϴ� �Լ�
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