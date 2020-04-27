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

-- 3����

-- �μ��� ��ձ޿� ��ȸ�ϱ�
-- �μ���� �μ��� ��ձ޿��� ��ȸ�Ѵ�. ��ձ޿��� �Ҽ������ϸ� ������.
SELECT D.department_name, TRUNC(AVG(salary),0) AS average_sal
FROM departments D, employees E
WHERE E.department_id = D.department_id
GROUP BY D.department_name
ORDER BY D.department_name;

-- �׷��Լ��� ��ø
-- �μ����� �������� ��ȸ���� �� ���� ���� ������� ����ΰ�?
-- SELECT department_id, max(count(*))    �̷��� ������ �߻��Ѵ�. max() ����� �ϳ����ε� department_id�� �������̹Ƿ�
SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id;

-- �޿� ��޺� ��� �޿��� �޿� ��޺� ������� ��ȸ�ϱ�
-- �޿���ް� ��޺� ��� �޿�, ������� ǥ���Ѵ�.
SELECT G.gra AS grade, TRUNC(AVG(salary)) AS avg_sal, COUNT(*) AS employees
FROM employees E, job_grades G
WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
GROUP BY G.gra
ORDER BY 1;

-- 4����

-- ��������
-- �̸��� Neena�� ����� ���� �ؿ� �Ի��� ������� �̸�, �Ի����� ��ȸ�ϱ�
SELECT first_name, hire_date
FROM employees 
WHERE to_char(hire_date, 'yyyy') IN (SELECT to_char(hire_date, 'yyyy')
                                    FROM employees
                                    WHERE first_name = 'Neena')
ORDER BY hire_date;

-- Stephen�� ���� ������ ���� �ϴ� �������� ���̵�� �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE job_id IN (SELECT job_id
                 FROM employees
                 WHERE first_name = 'Stephen')
ORDER BY employee_id;

-- Mozhe�� ���� ������ ���� �ϰ�,
-- Mozhe�� �޿����� �޿��� ���� �޴� ������ ���̵�� �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE job_id IN (SELECT job_id
                 FROM employees
                 WHERE first_name = 'Mozhe')
    AND salary > (SELECT salary
                  FROM employees
                  WHERE first_name = 'Mozhe')
ORDER BY employee_id;

-- ��ü ������ ��ձ޿����� ���� �޿��� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees)
ORDER BY 1;

-- ���� ���� �޿��� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees)
ORDER BY 1;

-- �μ��� ��� ���� ��ȸ���� �� ���� ���� �μ��� ���̵�� ��� ���� ��ȸ�ϱ�
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM employees
                   GROUP BY department_id);

-- 5����

-- WITH ���� ����ؼ� �ߺ� ����Ǵ� �����۾��� �� ���� ����ǰ� �� �� �ִ�.
-- ������ ���� ������ ����Ų��.
WITH deptCnt
AS (SELECT department_id, COUNT(*) cnt
    FROM employees
    GROUP BY department_id)
SELECT department_id, cnt
FROM deptCnt
WHERE cnt = (SELECT MAX(cnt)
             FROM deptCnt);
             
-- ������ ��������
-- 50�� �μ��� �ٹ��ߴ� ���� �ִ� ����� ���̵�, �̸�, ����, �ҼӺμ����̵� ��ȸ�ϱ�
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE employee_id in (SELECT employee_id
                     FROM job_history
                     WHERE department_id = 50);
                     
-- ������ �������� ��� ������ ����� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.job_id, E.department_id
FROM employees E, job_history H
WHERE E.employee_id = H.employee_id
    and H.department_id = 50;
    
-- Seattle�� ��ġ�ϰ� �ִ� �μ��� ������ ���� ���̵�, �̸��� ��ȸ�ϱ�
-- ���� ����� �ƴϴ�. �̷� ������ �� �� �ִٴ� �͸� �������.
SELECT employee_id, first_name
FROM employees
WHERE employee_id IN (SELECT manager_id
                      FROM departments
                      WHERE location_id = (SELECT location_id
                                           FROM locations
                                           WHERE city = 'Seattle'));

-- ���̺� �������� ��ȸ�ϱ�                                           
SELECT E.employee_id, E.first_name
FROM employees E, departments D, locations L
WHERE E.employee_id = D.manager_id
    AND D.location_id = L.location_id
    AND L.city = 'Seattle';
