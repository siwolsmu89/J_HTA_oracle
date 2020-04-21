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
-- ��������
SELECT D.department_name, D.manager_id, E.first_name as manager_name
FROM employees E, departments D
WHERE D.manager_id = E.employee_id(+)
ORDER BY D.department_id;

-- �μ����̵�, �μ���, �μ������ھ��̵�, �μ������� �̸� ��ȸ�ϱ�
SELECT D.department_id, D.department_name 
    , Mgr.employee_id, Mgr.first_name
FROM departments D, employees Mgr
WHERE D.manager_id = Mgr.employee_id(+)
ORDER BY department_id;

-- ��� ������ �̸�, �޿�, �������̵�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.first_name, E.salary, E.job_id, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id(+)
ORDER BY E.employee_id;

-- 5����

-- 6����

-- group by�� where �� order by �տ� ���´�.
-- cf. ������ �ۼ� ����
-- select
-- from
-- [where]
-- [group by]
-- [having] : ���� �� ���
-- [order by]

-- ���� �� �Լ� ����ϱ�
-- employees�� ��� �� ���� ��ȸ�ϱ�
select count(*)
from employees;

-- 50�� �μ����� ���ϴ� ������ ���� ��ȸ�ϱ�
select count(*)
from employees
where department_id = 50;

select department_id, count(*)
from employees
group by department_id
order by department_id;

-- Ŀ�̼��� �޴� ������ ���� ��ȸ�ϱ�
select count(commission_pct) as cms_not_null -- �÷��� �����ϸ� �ش� �÷��� ���� null�� �ƴ� �͸� ī��Ʈ�Ѵ�.
from employees;

-- Ŀ�̼��� �޴� ������ ���� ��ȸ�ϱ� II
select count(*)
from employees
where commission_pct is not null;

-- ������ �߿��� �ְ�޿�, �����޿��� �޴� ������ �޿��� ��ȸ�ϱ�
select max(salary), min(salary)
from employees;

-- �ְ�޿��� �޴� ����� �̸��� �ְ�޿��� ��ȸ�ϱ�
-- ������ �߻��ϴ� ������(�׷��Լ��� �׷��Լ��� �ƴ� ���� ������ �� ����)
select first_name, max(salary)
from employees;

-- �̷��� ������ ���� �� �ִ� (���߿� ��� ��)
-- ���������� ����ϴ� ���
-- �𸣴� ���� ��ȸ �������� ���õ� ��, �ش� ���� ã�� �������� �������� ���� ��.
SELECT first_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) 
                FROM employees);
                
                
-- ��� ���й����� Ǯ�� ��

-- ��ȸ�� ���� ������ ���ϱ�
-- count(*) : ��ȸ�� ��� ���� ������ ��ȯ�Ѵ�
-- count(�÷���) : �ش� �÷��� ���� null�� �ƴ� ���� ������ ��ȯ�Ѵ�.
-- count(distinct �÷���) : �ش� �÷��� ���� ���� �ߺ��� ���� 1���� ī��Ʈ�ؼ� ���� ������ ��ȯ�Ѵ�.
select count(*)
from employees;

select count(job_id)
from employees;

select count(distinct job_id)
from employees;

select count(distinct to_char(hire_date,'yyyy'))
from employees;

select distinct to_char(hire_date, 'yyyy')
from employees;

-- ��ȸ�� ���� Ư�� �÷��� ���� �հ踦 ���ϱ�
-- sum(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ������ �հ踦 ��ȯ�Ѵ�
-- ��ü ������� �޿� �Ѿ� ���ϱ�
select sum(salary)
from employees;

-- ��ü ������� Ŀ�̼� �հ� ���ϱ�
select sum(commission_pct)
from employees;

-- ��ȸ�� ���� Ư�� �÷��� ���� ����� ���ϱ�
-- avg(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ���� ��鿡 ���� ��հ��� ��ȯ�Ѵ�.
select trunc(avg(salary))
from employees;

select trunc(avg(commission_pct), 2)
from employees;

-- ��ȸ�� ���� Ư�� �÷��� ���� �ִ밪, �ּҰ� ���ϱ�
-- min(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ���� ���� ��ȯ�Ѵ�.
-- max(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ū ���� ��ȯ�Ѵ�.
select min(salary), max(salary)
from employees;

select min(commission_pct), max(commission_pct)
from employees;

-- group by�� �׷��Լ��� ����ؼ� ������ �����ϱ�
-- ������ ���� ���� ��ȸ�ϱ�
-- �׷��Լ��� �׷��Լ��� �ƴ� ���� ������ ���� ������, group by�� ���� column���� ���������� �Բ� ���� �� �ִ�.
select job_id, count(*)
from employees
group by job_id;

-- �Ի翬���� �����
SELECT TO_CHAR(hire_date, 'yyyy') as hired_year, COUNT(*) as count
FROM employees
GROUP BY TO_CHAR(hire_date, 'yyyy')
ORDER BY 2 desc;