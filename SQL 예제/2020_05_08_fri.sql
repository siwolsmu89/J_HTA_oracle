EXECUTE update_salary(100);

SELECT salary
FROM employees
WHERE employee_id = 100;

SELECT employee_id, first_name, salary, get_annual_salary(employee_id) AS annual
FROM employees
WHERE department_id = 60;

-- �μ����̵�, �μ���, ����� ��ȸ�ϱ�
-- �׷��Լ��� ����� ��ȸ�ϱ�
-- ����� ���� �μ��� ����ϰ� ������ ���������� ����ؾ� ��
SELECT D.department_id, D.department_name, C.cnt
FROM (SELECT department_id, COUNT(*) AS cnt
      FROM employees
      GROUP BY department_id) C, departments D
WHERE D.department_id = C.department_id
ORDER BY department_id;

-- �μ����̵�, �μ���, ����� ��ȸ�ϱ�
-- �Ʊ� ������ �Լ��� Ȱ���Ͽ� ��ȸ�ϱ�
-- ���� ������ ���� �ʾƵ� ����� ���� �μ����� ���
SELECT department_id, department_name, get_emp_count(department_id) AS cnt
FROM departments
ORDER BY department_id;