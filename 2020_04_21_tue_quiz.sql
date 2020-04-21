--1. ��� �������� ��� �������̵� ��ȸ�ϱ�
SELECT DISTINCT job_id
FROM employees;

--2. �޿��� 12,000�޷� �̻� �޴� ������ �̸��� �޿��� ��ȸ�ϱ�
SELECT first_name, salary
FROM employees
WHERE salary>=12000;

--3. ������ȣ�� 176�� ������ ���� �μ����� �ٹ��ϴ� ������ ���̵�� �̸� �������̵� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.job_id
FROM employees E, employees E2
WHERE E2.employee_id = 176
    AND E.department_id = E2.department_id;

--4. �޿��� 12,000�޷� �̻� 15,000�޷� ���� �޴� �������� ���� ���̵�� �̸��� �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 12000 AND 15000;

--5. 2005�� 1�� 1�Ϻ��� 2000�� 6�� 30�� ���̿� �Ի��� ������ ���̵�, �̸�, �������̵�, �Ի����� ��ȸ�ϱ�
SELECT employee_id, first_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '2005-01-01' AND '2005-06-30'
ORDER BY hire_date;

--6. �޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ������ �̸��� �޿��� ��ȸ�ϱ�
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 5000 and 12000
    AND department_id IN (20, 50)
ORDER BY first_name;

--7. �����ڰ� ���� ������ �̸��� �������̵� ��ȸ�ϱ�
SELECT first_name, job_id
FROM employees
WHERE manager_id is null;

--8. Ŀ�̼��� �޴� ��� ������ �̸��� �޿�, Ŀ�̼��� �޿� �� Ŀ�̼��� ������������ �����ؼ� ��ȸ�ϱ�
SELECT first_name, salary, commission_pct as cms
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary desc, commission_pct desc;

--9. �̸��� 2��° ���ڰ� e�� ��� ������ �̸��� ��ȸ�ϱ�
SELECT first_name
FROM employees
WHERE first_name like '_e%'
ORDER BY first_name;

--10. �������̵� ST_CLERK �Ǵ� SA_REP�̰� �޿��� 2,500�޷�, 3,500�޷�, 7,000�޷� �޴� ��� ������ �̸��� �������̵�, �޿��� ��ȸ�ϱ�
SELECT first_name, job_id, salary
FROM employees
WHERE job_id in ('ST_CLERK', 'SA_REP')
    AND salary in (2500, 3500, 7000)
ORDER BY salary;

--11. ��� ������ �̸��� �Ի���, �ٹ� ���� ���� ����Ͽ� ��ȸ�ϱ�, �ٹ����� ���� ������ �ݿø��ϰ�, �ٹ��������� �������� ������������ �����ϱ�
SELECT first_name, hire_date
    , trunc(months_between(trunc(sysdate), hire_date)) as worked_months
FROM employees
ORDER BY worked_months;

--12. ������ �̸��� Ŀ�̼��� ��ȸ�ϱ�, Ŀ�̼��� ���� �ʴ� ������ '����'���� ǥ���ϱ�
SELECT first_name, nvl(to_char(commission_pct, '0.99'),'����') as cms
FROM employees
ORDER BY cms;

--13. ��� ������ �̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϱ�
SELECT E.first_name, E.department_id AS dept_id, D.department_name
FROM employees E, departments D
ORDER BY E.employee_id;

--14. 80���μ��� �Ҽӵ� ������ �̸��� �������̵�, ��������, �μ��̸��� ��ȸ�ϱ�
SELECT E.first_name AS name
    , J.job_id
    , J.job_title
    , D.department_name AS dept
FROM employees E, departments D, jobs J
WHERE E.job_id = J.job_id
    AND E.department_id = D.department_id
    AND E.department_id = 80;

--15. Ŀ�̼��� �޴� ��� ������ �̸��� �������̵�, ��������, �μ��̸�, �μ������� ���ø��� ��ȸ�ϱ�
SELECT E.first_name, E.employee_id
    , J.job_title
    , D.department_name
    , L.city
FROM employees E, jobs J, departments D, locations L
WHERE E.commission_pct IS NOT NULL
    AND E.department_id = D.department_id
    AND E.job_id = J.job_id
    AND D.location_id = L.location_id
ORDER BY first_name;

--16. ������ �������� �ΰ� �ִ� ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
SELECT D.department_id, D.department_name
FROM departments D, locations L, countries C, regions R
WHERE region_name = 'Europe'
    AND D.location_id = L.location_id
    AND L.country_id = C.country_id
    AND C.region_id = R.region_id
ORDER BY department_id;

--17. ������ �̸��� �ҼӺμ���, �޿�, �޿� ����� ��ȸ�ϱ�
SELECT E.first_name, D.department_name, E.salary, G.gra as grade
FROM employees E, job_grades G, departments D
WHERE E.salary BETWEEN G.lowest_sal AND G.highest_sal
    AND E.department_id = D.department_id
ORDER BY salary;

--18. ������ �̸��� �ҼӺμ���, �ҼӺμ��� �����ڸ��� ��ȸ�ϱ�, �ҼӺμ��� ���� ������ �ҼӺμ��� '����, �����ڸ� '����'���� ǥ���ϱ�
SELECT E.first_name, nvl(D.department_name, '����') as dept, nvl(M.first_name, '����') AS mgr_name
FROM employees E, departments D, employees M
WHERE E.department_id = D.department_id(+)
    AND D.manager_id = M.employee_id(+)
ORDER BY E.employee_id;

--19. ��� ����� �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.first_name, E.job_id, E.salary, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id(+)
ORDER BY employee_id;

--20. ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
SELECT E.first_name, E.job_id, J.job_title, E.salary, J.min_salary, J.max_salary 
FROM employees E, jobs J
WHERE E.job_id = J.job_id
ORDER BY salary desc;

--21. ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
SELECT E.first_name, E.job_id, J.job_title, E.salary, (E.salary-J.min_salary) as gap
FROM employees E, jobs J
WHERE E.job_id = J.job_id
ORDER BY gap desc;

--22. Ŀ�̼��� �޴� ��� ����� ���̵�, �μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
SELECT E.employee_id, D.department_name, L.city
FROM employees E, departments D, locations L
WHERE E.commission_pct IS NOT NULL
    AND E.department_id = D.department_id
    AND D.location_id = l.location_id
ORDER BY E.employee_id;

--23. �̸��� A�� a�� �����ϴ� ��� ����� �̸��� ����, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.first_name, E.job_id, J.job_title, E.salary, D.department_name
FROM employees E, departments D, jobs J
WHERE (E.first_name LIKE 'A%' OR E.first_name LIKE 'a%')
    AND E.department_id = D.department_id
    AND E.job_id = J.job_id
ORDER BY E.first_name;

--24. 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ����� �߿��� 100���� �����ϴ� ������� �̸�, ����, �޿�,
--    �޿������ ��ȸ�ϱ�
SELECT E.first_name, E.job_id, E.salary, G.gra as grade 
FROM employees E, departments D, job_grades G
WHERE E.department_id IN (30, 60, 90)
    AND D.manager_id = 100
    AND E.department_id = D.department_id
    AND (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
ORDER BY E.salary;

--25. 80�� �μ��� �Ҽӵ� ������� �̸�, ����, ��������, �޿�, �ּұ޿�, �ִ�޿�, �޿����, 
--    �ҼӺμ����� ��ȸ�ϱ�
SELECT E.first_name, E.job_id, J.job_title, E.salary, J.min_salary, J.max_salary, G.gra as grade, D.department_name
FROM employees E, jobs J, job_grades G, departments D
WHERE D.department_id = 80
    AND E.department_id = D.department_id
    AND E.job_id = J.job_id
    AND (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
ORDER BY grade desc, salary;

--26. ������߿��� �ڽ��� ��纸�� ���� �Ի��� ������� �̸�, �Ի���, ����� �̸�, ����� �Ի�����
--    ��ȸ�ϱ�
SELECT E.first_name, E.hire_date, M.first_name as manager_name, M.hire_date as manager_hired
FROM employees E, employees M
WHERE E.manager_id = M.employee_id
    AND (0 > E.hire_date - M.hire_date )
ORDER BY E.first_name;

--27. �μ����� IT�� �μ��� �ٹ��ϴ� ������� �̸���, ����, �޿�, �޿����, ����� �̸��� ������
--    ��ȸ�ϱ�
SELECT E.first_name, E.job_id, E.salary, G.gra AS grade, M.first_name AS manager_name, M.job_id AS manager_job
FROM employees E, employees M, departments D, job_grades G
WHERE D.department_name = 'IT'
    AND E.manager_id = M.employee_id
    AND E.department_id = D.department_id
    AND (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
ORDER BY E.first_name;

--28. 'ST_CLERK'�� �ٹ��ϴٰ� �ٸ� �������� ������ ����� ���̵�, �̸�, ������ �μ���,
--     ���� ����, ���� �ٹ��μ����� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name
    , OldDept.department_name as old_dept
    , E.job_id as current_job, CurrentDept.department_name as cureent_dept
FROM employees E, job_history H, departments OldDept, departments CurrentDept
WHERE H.job_id = 'ST_CLERK'
    AND E.employee_id = H.employee_id
    AND E.department_id = CurrentDept.department_id
    AND H.department_id = OldDept.department_id
ORDER BY E.first_name;