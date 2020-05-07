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
              
-- WITH �� ����ϱ�
-- ��ü �μ��� ��� �� �޿����� �� �޿��� ���� �μ��� ã��
WITH 
dept_costs AS
(SELECT D.department_name, SUM(E.salary) AS dept_total
 FROM employees E, departments D
 WHERE E.department_id = D.department_id
 GROUP BY D.department_name),
avg_cost AS
(SELECT SUM(dept_total)/count(*) AS dept_avg
 FROM dept_costs)
SELECT *
FROM dept_costs
WHERE dept_total > (select dept_avg
                    FROM avg_cost)
ORDER BY department_name;

-- 118�� ����� ���� ��ȸ�ϱ�
SELECT employee_id, first_name, manager_id
FROM employees
START WITH employee_id = 118
CONNECT BY PRIOR manager_id = employee_id;

-- 101�� ������ ��� ���� ��ȸ�ϱ�
-- LEVEL�� LPAD�� ����Ͽ� ���������� depth�� ǥ���ϱ�
SELECT LPAD(employee_id, LEVEL*4, ' ') as employee_id, first_name, manager_id
FROM employees
START WITH employee_id = 101
CONNECT BY PRIOR employee_id = manager_id;

-- 100�� ������ ��� ���� ��ȸ�ϱ�
SELECT LPAD(first_name, LENGTH(first_name) + level*5-5, ' ')
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id;

-- 100�� ��� �������� ��ȸ, Neena�� ����
-- CONNECT BY���� ���� -> Neena�� ���ϵ���� �Բ� ���ܵȴ�.
SELECT LPAD(first_name, LENGTH(first_name) + level*5-5, ' ')
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id
    AND first_name != 'Neena';
    
-- 100�� ���� ���ϵ鸸 ��ȸ�ϱ�
-- LEVEL 2������ ǥ���ϱ�
SELECT LPAD(first_name, LENGTH(first_name) + level*5-5, ' ')
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id
    AND LEVEL<=2;
    
-- 2020/01/01 ~ 2020/12/31 ��¥ �����
SELECT TO_DATE('2020/01/01', 'yyyy/mm/dd') + LEVEL -1
FROM dual
CONNECT BY LEVEL <= 366;

-- 2003�⵵ ���� �Ի��ڼ� ��ȸ�ϱ�
SELECT TO_CHAR(hire_date, 'yyyy-mm'), count(*)
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '2003'
GROUP BY TO_CHAR(hire_date, 'yyyy-mm')
ORDER BY 1;

-- �Ի��ڰ� ���� �޵� ǥ���ϱ�
WITH
months AS
(SELECT '2003-' ||
    CASE
        WHEN LEVEL < 10 THEN '0' || LEVEL
        ELSE to_char(LEVEL)
    END AS mon
 FROM dual
 CONNECT BY LEVEL <= 12),
month_emp_count AS
(SELECT TO_CHAR(hire_date, 'yyyy-mm') AS mon, count(*) AS cnt
 FROM employees
 WHERE TO_CHAR(hire_date, 'yyyy') = '2003'
 GROUP BY TO_CHAR(hire_date, 'yyyy-mm'))
SELECT M.mon, NVL(C.cnt, 0) AS cnt
FROM months M, month_emp_count C
WHERE M.mon = C.mon(+)
ORDER BY M.mon;