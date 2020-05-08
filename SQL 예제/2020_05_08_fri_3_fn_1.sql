-- �������̵� ���޹޾Ƽ� �� ������ ����(Ŀ�̼��� ���Ե�)�� ��ȯ�ϴ� �Լ�
CREATE OR REPLACE FUNCTION get_annual_salary
    (i_emp_id IN NUMBER)        -- �������̵� �Ű������� ���޹޴´�.
    RETURN NUMBER               -- �� �Լ��� ��ȯ���� ���ڰ��̴�.
    
IS
    v_salary        employees.salary%TYPE;              -- �޿�
    v_cms           employees.commission_pct%TYPE;      -- Ŀ�̼�
    v_annual_salary employees.salary%TYPE;              -- ����
    
BEGIN
    -- �������̵� �ش��ϴ� ������ �޿��� Ŀ�̼��� ��ȸ�ؼ� ������ ����
    SELECT salary, NVL(commission_pct, 0)
    INTO v_salary, v_cms
    FROM employees
    WHERE employee_id = i_emp_id;
    
    -- Ŀ�̼��� �ݿ��� ������ ����ؼ� ������ �����Ѵ�.
    v_annual_salary := TRUNC(v_salary * 12 * (1 + v_cms));
    
    -- ������ ����� ���� ��ȯ�Ѵ�.
    RETURN v_annual_salary;
    
END;