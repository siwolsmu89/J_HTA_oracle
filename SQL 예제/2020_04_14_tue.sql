SELECT *
FROM DEPARTMENTS;

SELECT *
FROM COUNTRIES;

select *
from jobs;

SELECT *
FROM job_history;

-- ��� ���̺��� ��� ���̵�
select employee_id,first_name, salary 
from employees;

-- �μ� ���̺��� �μ����̵�, �μ��� ��ȸ�ϱ�
select department_id, department_name
from departments;

-- ����̵�, ��Ÿ��Ʋ�� ��ȸ�ϱ�
select job_id, job_title
from jobs;

-- �����̸� ��ȸ�ϱ�
select country_name
from countries;

-- ������̵�, �̸�, �޿�, ����, 10%�λ�� �޿� ��ȸ�ϱ�
select employee_id id, first_name name, salary sal, salary*12 as ann_sal, salary*1.1 "INCREMENT SALARY"
from employees;

-- �μ����̵�, �μ���, �μ������ ���̵� ��ȸ�ϱ�
select department_id ID, department_name name, manager_id m_id
from departments;

-- ������̵�, �̸�, �޿�, Ŀ�̼�, Ŀ�̼��� ���Ե� �޿� ��ȸ�ϱ�
-- Ŀ�̼��� ���Ե� �޿��� �޿� + �޿�*Ŀ�̼�
select employee_id id, first_name name, salary sal, commission_pct "CMS %", salary + salary*commission_pct as "SAL with CMS"
from employees;

-- �ߺ������ ��ȸ�ϱ�
-- ������� �����ϰ� �ִ� ���� ���̵� ���� ��ȸ�ϱ�
select distinct job_id
from employees;

-- 60�� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, ����, �޿�, �μ����̵� ��ȸ�ϱ�
select employee_id as id, first_name as name, job_id as job, salary as SAL, department_id as dept
from employees
where department_id=60;

-- �޿��� 15000�޷� �̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary>=15000;