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
                
-- 20000�޷� �̻��� ��ü ��ձ޿��� 10%�� ���ʽ���, 10000�޷� �̻��� 15% �� �ܴ� 20%�� ���ʽ��� �����Ϸ��� �Ѵ�.
-- ���̵�, �̸�, �޿�, ���ʽ� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
    , CASE
        WHEN salary>=20000 THEN TRUNC((SELECT AVG(salary) FROM employees) *0.1)
        WHEN salary>=10000 THEN TRUNC((SELECT AVG(salary) FROM employees) *0.15)
        ELSE TRUNC((SELECT AVG(salary) FROM employees) *0.2)
      END AS bonus
FROM employees;

-- ��ü ��ձ޿����� �޿��� ���� �޴� ����� �̸�, �޿��� ��ȸ�ϱ�
-- ��ȣ�������������� ������� ���� ���
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) 
                FROM employees);
                
-- �ڽ��� �Ҽӵ� �ҼӺμ��� ��ձ޿����� ���� �޿��� �޴� ����� �̸�, �޿��� ��ȸ�ϱ�
-- ��ȣ���������� ����ϴ� ���
SELECT outterr.first_name, outterr.salary
FROM employees outterr
WHERE salary > (SELECT AVG(innerr.salary)
                FROM employees innerr
                WHERE innerr.department_id = outterr.department_id);
-- �ܺ� SQL�� ���� ����Ǿ� ���� �����´�.(�ĺ���)
-- �ĺ����� �ึ�� department_id ���� �����ͼ� ���������� �����Ѵ�.
-- ���������� ������� ����� �ĺ����� �����Ѵ�.
-- �ĺ����� ���� ���� ������ �ݺ��Ѵ�.

-- �μ����̵�, �μ���, �ش�μ��� ������� ��ȸ�ϱ�
-- ��ȣ�������������� �������� ��������� �̷� ���¸� ��ȣ���������������� �θ��� �ʴ´�. (�̰� ��Į�� ���������� �� ������ ���̴�)
-- ��ȣ�������������� where���� ���� ���� ��ȣ��������������� �Ѵ�.
SELECT D.department_id, D.department_name
    , (SELECT count(*)
       FROM employees I
       WHERE I.department_id = D.department_id) AS count
FROM departments D;

-- ���������� ������ �ִ� ������ ��ȸ�ϱ�
-- EXISTS �����ڸ� ������� �ʴ� ���
-- ��ȣ���� ��������(�� ���ÿ� ��Į�� ��������)�� Ȱ���ϱ�
-- 1���� �߰ߵǴ��� ������ ��ȸ�ϰ� �ݵ�� �� ������ ���� ����� �Ѵٴ� ���� ����
SELECT *
FROM employees M
WHERE (SELECT count(*)
        FROM employees E
        WHERE E.manager_id = M.employee_id) > 0;
        
-- EXISTS ������ ����ϱ�
-- ���������� ������ �ִ� ������ ��ȸ�ϱ�
SELECT *
FROM employees M
WHERE EXISTS (SELECT 1
              FROM employees E
              WHERE E.manager_id = M.employee_id);
              
-- WITH ��