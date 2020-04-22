-- 1����

-- ������ �׷��� ����
-- group by ���� ����ϸ� ���̺��� ������ ���� �׷����� ����� �׷�� �����͸� ������ �� �ִ�.
-- �ҼӺμ��� �������� ��ȸ�ϱ� (��, �ҼӺμ��� �������� ���� ������ �����Ѵ�)
SELECT department_id, COUNT(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

-- �����ں� �ڽ��� �����ϴ� ���� ���� ��ȸ�ϱ�
-- ��, �����ڰ� �������� ���� ������ ����
-- �����ھ��̵�, �������� ��ȸ�Ѵ�.
SELECT manager_id, COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY manager_id;

-- �μ��� ���� ���� ��ȸ�ϱ�
-- ��, �μ��� �������� ���� ����� �����Ѵ�.
-- �μ��̸�, �������� ��ȸ�ϱ�
SELECT D.department_name, COUNT(*)
FROM departments D, employees E
WHERE E.department_id IS NOT NULL
    AND E.department_id = D.department_id
GROUP BY D.department_name;

-- ���ú� �������� ��ȸ�ϱ�
SELECT L.city, COUNT(*)
FROM employees E, departments D, locations L
WHERE E.department_id = D.department_id
    AND D.location_id = L.location_id
GROUP BY L.city;

-- 2����

-- ���ú�, �μ��� �������� ��ȸ�ϱ�
-- ���ø�, �μ���, �������� ��ȸ�Ѵ�
SELECT L.city, D.department_name, COUNT(*)
FROM employees E, departments D, locations L
WHERE E.department_id = D.department_id
    AND D.location_id = L.location_id
GROUP BY L.city, D.department_name
ORDER BY L.city, D.department_name;

-- �޿��� ������� ��ȸ�ϱ�
SELECT TRUNC(salary, -3) salary, COUNT(*)
FROM employees
GROUP BY TRUNC(salary, -3)
HAVING COUNT(*) >= 10            -- COUNT(*)���� 10�� �̻��� ����� ����ϵ��� ���� ����(WHERE���� �׷��Լ��� ����� �� ����)
ORDER BY salary;