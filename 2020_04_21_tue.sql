-- 1����, 2���� : 04_20_quiz Ǯ��

-- ���� ����
SELECT E.employee_id, E.first_name, E.manager_id, E.salary
    , E2.first_name as manager_name
FROM employees E, employees E2
WHERE E2.employee_id = E.manager_id
ORDER BY E.employee_id;

-- 3����
SELECT worker.employee_id as id, worker.first_name, worker.salary
    ,worker.manager_id as manager,  manager.first_name as manager_name
    , nvl(manager.manager_id, manager.employee_id) as super
FROM employees worker, employees manager
WHERE worker.manager_id = manager.employee_id
ORDER BY manager.employee_id, worker.employee_id;

-- ��������(��ü����)
-- 101�� ����� �̸�, ����, �ڽ��� ����̸��� ��ȸ�ϱ�
SELECT Emp.first_name as �̸�, Emp.job_id as ����, Mgr.first_name as ���
FROM employees Emp, employees Mgr
WHERE Emp.employee_id = 101
    AND Emp.manager_id = Mgr.employee_id;
    
-- 60�� �μ��� �ٹ����� ����� ���̵�, �̸�, ����, ����� �̸�, ����� ����, �μ����̵�, �μ���, �μ������� ���̵�, �μ������� �̸��� ��ȸ�ϱ�
SELECT Emp.employee_id as "���� ID"
    , Emp.first_name as "���� �̸�"
    , Emp.job_id as "���� ����"
    , Mgr.first_name as "��� �̸�"
    , Mgr.job_id as "��� ����"
    , D.department_id as "�μ� ID"
    , D.department_name as "�μ���"
    , D.manager_id as "�μ��� ID"
    , DMgr.first_name as "�μ��� �̸�"
FROM employees Emp, employees Mgr, employees DMgr, Departments D
WHERE Emp.department_id = 60
    AND Emp.manager_id = Mgr.employee_id
    AND Emp.department_id = D.department_id
    AND D.manager_id = DMgr.employee_id
ORDER BY D.department_id, Emp.employee_id;

-- 4����