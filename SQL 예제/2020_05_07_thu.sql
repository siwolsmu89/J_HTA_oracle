-- ���߿� �������� ����ϱ�
-- 'Karen'�� ���� ������ �����ϰ�, ���� �μ��� �ҼӵǾ� �ִ� ����� ���̵�, �̸�, ����, �μ����̵� ��ȸ�ϱ�
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE (job_id, department_id) IN (SELECT job_id, department_id
                                  FROM employees
                                  WHERE first_name = 'Karen');
                                  
-- �μ��� �ְ� �޿��� �޴� ����� ���̵�, �̸�, �޿�, �μ����̵� ��ȸ�ϱ�
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE (department_id, salary) IN ((SELECT department_id, MAX(salary)
                                   FROM employees
                                   WHERE department_id IS NOT NULL
                                   GROUP BY department_id))
ORDER BY employee_id;

-- ��Į�� �������� ����ϱ�
-- ��ü ��պ��� ���� �޿��� �޴� ������ ���̵�, �̸�, �޿�, ��ձ޿�, ��ձ޿����� ���̸� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
    , TRUNC((SELECT AVG(salary) FROM employees)) AS avg_sal
    , TRUNC((SELECT AVG(salary) FROM employees)) - salary AS gap
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees);