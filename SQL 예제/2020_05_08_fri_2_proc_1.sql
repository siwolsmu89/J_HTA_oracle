-- ���� ��ȣ�� �λ���� ���޹޾Ƽ� �� ������ �޿��� �λ��Ű�� ���ν��� �ۼ��ϱ�
-- �ۼ� �� �����ϸ� ���ν����� �����ϵ�(���ν��� �׸� �Ʒ��� �����Ǿ� ����)
CREATE OR REPLACE PROCEDURE update_salary
    (i_emp_id IN NUMBER) -- �Ű�����
IS 
    -- ������ �����ϴ� �κ�
    -- ������        ������ ������Ÿ��
    -- v_emp_salary NUMBER;
    -- ������     ���̺�.�÷�%TPYE : �ش� �÷��� ������Ÿ�԰� ������ ������Ÿ������ ���� ����
    v_emp_salary employees.salary%TYPE; -- ����� �޿�
    v_update_rate NUMBER(3,2);          -- �λ��
    
BEGIN
    -- SQL���� Ȥ�� PL/SQL ������ �ۼ��ϴ� �κ�
    -- ���޹��� �������̵� �ش��ϴ� ���������� ��ȸ�Ѵ�.
    -- ��ȸ�� ������ �޿��� ������ ������ v_emp_salary�� �����Ѵ�.
    SELECT salary 
    INTO v_emp_salary
    FROM employees
    WHERE employee_id = i_emp_id;
    
    -- ������ �޿��� ���� �λ���� �����ϱ�
    -- 20000�޷� �̻� 10%, 10000�޷� �̻� 15%, �׿� 20%
    IF v_emp_salary >= 20000 THEN v_update_rate := 0.10;
    ELSIF v_emp_salary >= 10000 THEN v_update_rate := 0.15;
    ELSE v_update_rate := 20;
    END IF;
 
    -- �޿��� �λ��Ű��
    UPDATE employees
    SET
        salary = salary + TRUNC(salary * v_update_rate)
    WHERE 
        employee_id = i_emp_id;
        
    -- DB�� ���������� �ݿ���Ű��
    COMMIT;
    
END;