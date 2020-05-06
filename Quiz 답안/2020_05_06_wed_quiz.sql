--1. ������̺��� �޿��� 5000�̻� 12000������ ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 12000
ORDER BY employee_id;

--2. ������� �Ҽӵ� �μ��� �μ����� �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id
ORDER BY department_name;

--3. 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT employee_id, first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '2007';

--4. �޿��� 5000�̻� 12000�����̰�, 20���� 50�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary, D.department_name
FROM employees E, departments D
WHERE (E.salary BETWEEN 5000 AND 12000)
    AND E.department_id = D.department_id
    AND E.department_id IN (20, 50)
ORDER BY employee_id;

--5. 100�� �������� �����ϴ� ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary, G.gra
FROM employees E, job_grades G, employees M
WHERE E.manager_id = M.employee_id
    AND E.manager_id = 100
    AND (E.salary BETWEEN G.lowest_sal AND g.highest_sal)
ORDER BY employee_id;

--6. 80�� �μ��� �ҼӵǾ� �ְ�, 80�� �μ��� ��ձ޿����� ���� �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary
FROM employees E
WHERE E.department_id = 80
    AND E.salary < (SELECT AVG(salary)
                    FROM employees
                    WHERE department_id = 80)
ORDER BY E.employee_id;

--7. 50�� �μ��� �Ҽӵ� ��� �߿��� �ش� ������ �ּұ޿����� 2�� �̻��� �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary
FROM employees E
WHERE E.salary >= 2* (SELECT MIN(salary)
                      FROM employees
                      WHERE job_id=E.job_id)
    AND E.department_id = 50;
    
--8. ����� �߿��� �ڽ��� ��纸�� ���� �Ի��� ����� ���̵�, �̸�, �Ի���, ����� �̸�, ����� �Ի����� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.hire_date, M.first_name as manager_name, M.hire_date as manager_hire_date
FROM employees E, employees M
WHERE E.manager_id = M.employee_id
    AND E.hire_date < M.hire_date
ORDER BY E.employee_id;
    
--9. Steven King�� ���� �μ����� �ٹ��ϴ� ����� ���̵�� �̸��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name
FROM employees E, (SELECT department_id
                   FROM employees
                   WHERE first_name = 'Steven'
                    AND last_name = 'King') D
WHERE E.department_id = D.department_id;

--10. �����ں� ������� ��ȸ�ϱ�, ������ ���̵�, ������� ����Ѵ�. ������ ���̵� ������������ ����
SELECT M.employee_id as manager_id, C.count
FROM employees M, (SELECT manager_id, count(*) as count
                   FROM employees
                   GROUP BY manager_id) C
WHERE M.employee_id = C.manager_id
ORDER BY manager_id;                   

--11. Ŀ�̼��� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY employee_id;

--12. �޿��� ���� ���� �޴� ��� 3���� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM (SELECT employee_id, first_name, salary
      FROM employees
      ORDER BY salary DESC)
WHERE ROWNUM <= 3;

--13. 'Ismael'�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.hire_date
FROM employees E, (SELECT department_id, TO_CHAR(hire_date, 'yyyy') as hire_year
                   FROM employees
                   WHERE first_name = 'Ismael') Ism
WHERE E.department_id = Ism.department_id
    AND TO_CHAR(E.hire_date, 'yyyy') = Ism.hire_year;

--14. 'Renske'���� ����޴� ����� ���̵�� �̸�, �޿�, �޿� ����� ��ȸ�ϱ�
SELECT M.employee_id, M.first_name, M.salary, G.gra
FROM employees M, employees E, job_grades G
WHERE E.manager_id = M.employee_id
    AND E.first_name = 'Renske'
    AND (M.salary BETWEEN G.lowest_sal AND G.highest_sal);

--15. ������̺��� �޿��� �������� �޿������ ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�
SELECT G.gra, count(*)
FROM employees E, job_grades G
WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
GROUP BY G.gra
ORDER BY G.gra;

--16. �Ի��ڰ� ���� ���� ������ �� �ؿ� �Ի��� ��� ���� ��ȸ�ϱ�
SELECT hire_year, count
FROM (SELECT TO_CHAR(hire_date, 'yyyy') as hire_year, count(*) as count
      FROM employees
      GROUP BY TO_CHAR(hire_date, 'yyyy')
      ORDER BY TO_CHAR(hire_date, 'yyyy'))
WHERE ROWNUM = 1;

--17. �����ں� ��� ���� ��ȸ���� �� �����ϴ� ��� ���� 10���� �Ѵ� �������� ���̵�� ������� ��ȸ�ϱ�
SELECT manager_id, count
FROM (SELECT M.employee_id as manager_id, count(*) as count
      FROM employees M, employees E
      WHERE E.manager_id = M.employee_id
      GROUP BY M.employee_id)
WHERE count >= 10;

--18. 'Europe'�������� �ٹ����� ����� ���̵�, �̸�, �ҼӺμ���, ������ ���ø�, �����̸��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, D.department_name, L.city, C.country_name
FROM employees E, departments D, locations L, countries C, regions R
WHERE E.department_id = D.department_id
    AND D.location_id = L.location_id
    AND L.country_id = C.country_id
    AND C.region_id = R.region_id
    AND R.region_name = 'Europe'
ORDER BY employee_id;

--19. ��ü ����� ������̵�, �̸�, �޿�, �ҼӺμ����̵�, �ҼӺμ���, ����� �̸��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary, E.department_id, D.department_name, M.first_name as manager_name
FROM employees E, departments D, employees M
WHERE E.department_id = D.department_id
    AND E.manager_id = M.employee_id
UNION
SELECT E.employee_id, E.first_name, E.salary, E.department_id, D.department_name, '(no manager)'
FROM employees E, departments D
WHERE E.department_id = D.department_id
    AND E.manager_id IS NULL
ORDER BY employee_id;

--20. 50�� �μ��� �ٹ����� ������� �޿��� 500�޷� �λ��Ű��
UPDATE employees
    SET
        salary = 500 + salary
WHERE department_id = 50;

--21. ����� ���̵�, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�
-- ���ʽ��� 20000�޷� �̻��� �޿��� 10%, 10000�޷� �̻��� �޿��� 15%, �� �ܴ� �޿��� 20%�� �����Ѵ�.
SELECT employee_id, first_name, salary
    , CASE 
        WHEN salary >= 20000 THEN salary*0.1
        WHEN salary >= 10000 THEN salary*0.15
        ELSE salary*0.2
      END as bonus
FROM employees
ORDER BY employee_id;

-- 22. �ҼӺμ����� �Ի����� ������ �� ���� �޿��� �޴� ����� �̸�, �Ի���, �ҼӺμ���, �޿��� ��ȸ�ϱ�
-- �� ���̶� �ڱ⺸�� �Ի����� ������ �޿��� ���� �޴� ����� ������ ������ ������Ų��.

--23. �μ��� ��ձ޿��� ��ȸ���� �� �μ��� ��ձ޿��� 10000�޷� ������ �μ��� ���̵�, �μ���, ��ձ޿��� ��ȸ�ϱ�
-- ��ձ޿��� �Ҽ��� 1�ڸ������� ǥ���Ѵ�
SELECT D.department_id, D.department_name, Davg.avg_sal
FROM departments D, (SELECT department_id, TRUNC(AVG(salary), 1) AS avg_sal
                     FROM employees
                     GROUP BY department_id) Davg 
WHERE Davg.avg_sal <= 10000
    AND D.department_id = Davg.department_id
ORDER BY D.department_id;

--24. ����� �߿��� �ڽ��� �����ϰ� �ִ� ������ �ִ�޿��� ������ �޿��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary, E.job_id
FROM employees E, (SELECT job_id, MAX(salary) as max_sal
                   FROM employees
                   GROUP BY job_id) M
WHERE E.salary = M.max_sal
    AND E.job_id = M.job_id
ORDER BY E.employee_id;

--25. �м��Լ��� ����ؼ� ������� �޿������� �����ϰ�, ������ �ο����� �� 6~10��° ���ϴ� ����,
-- ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT E.RN, E.employee_id, E.first_name, E.salary, G.gra
FROM (SELECT ROW_NUMBER() OVER(ORDER BY salary DESC) AS RN, first_name, salary, employee_id
      FROM employees) E, job_grades G
WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
    AND (E.RN BETWEEN 6 AND 10)
ORDER BY E.RN;
