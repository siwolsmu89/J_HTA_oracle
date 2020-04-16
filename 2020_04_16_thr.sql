select job_title
from jobs;

-- ���̺��� ���� �����ؼ� ��ȸ�ϱ�
-- ������̵�, �����, �������̵�, �޿� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees;

-- �������̵�, ������ �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, min_salary, max_salary
from jobs;

-- �������̵�, ���ø�, �ּ� ��ȸ�ϱ�
select location_id, city, street_address
from locations;

-- ������̵�, �����, �Ի��� ��ȸ�ϱ�
select employee_id as id, first_name as name, hire_date
from employees;

-- �����ڸ� �̿��ϱ�, ��Ī ����ϱ�
-- ������̵�, ����, �޿�, ������ ��ȸ�ϰ� ������ ��Ī �ο��ϱ�
select employee_id as id, job_id as job, salary, salary*4*12 as ANN_SAL
from employees;

-- ������̵�, ����, �޿�, �ñ��� ��ȸ�ϰ� ������ ��Ī �ο��ϱ�, �ñ��� �޿�/(5*24) �̴�.
select employee_id id, job_id job, salary sal, salary/(5*24) time_sal
from employees;

-- ���� �����ؼ� ��ȸ�ϱ�
-- 60�� �μ����� �ٹ��ϴ� ����� ���̵�, �̸�, ����, �μ����̵� ��ȸ�ϱ�
select employee_id id, first_name name, job_id job, department_id dept
from employees
where (department_id=60);

-- �޿��� 5000�޷� ���Ϸ� �޴� ������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id id, first_name name, job_id job, salary
from employees
where salary<=5000;

-- 100�� �������� �����ϴ� ������ ���̵�, �̸� ��ȸ�ϱ�
select employee_id id, first_name name
from employees
where manager_id=100;

-- 100�� ������ �μ�����ڷ� ������ �μ��� ���̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments
where manager_id=100;

-- ���� �ִ� �޿��� 15000�޷� �̻� �Ǵ� ������ ���̵�, ��������, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, max_salary
from jobs
where max_salary>=15000;

-- �ñ��� 100�޷� �̻� �޴� ������ ���̵�, �̸�, ����, �޿�, �ñ��� ��ȸ�ϱ�
select employee_id id, first_name name, job_id job, salary, salary/(5*8) as "SALARY/H"
from employees
where salary/(5*8)>100;

-- �̸��� Neena�� ����� �������̵�, �̸�, �̸���, ��ȭ��ȣ�� ��ȸ�ϱ�
select employee_id, first_name, last_name, email, phone_number
from employees
where first_name = 'Neena';

-- Ŀ�̼��� null�� ������ �������̵�, �̸�, �ҼӺμ����̵� Ȯ���ϱ�
select employee_id, first_name, department_id
from employees
where commission_pct is null;

-- Ŀ�̼��� null�� �ƴ� ������ �������̵�, �̸�, �������̵�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id 
from employees
where commission_pct is not null;

-- �ҼӺμ��� �������� ���� ������ ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where department_id is null;

-- �μ�����ڰ� �������� ���� �μ��� ���̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments
where manager_id is null;

-- �μ�����ڰ� ������ �μ��� �μ����̵�, �μ���, ����� �������̵� ��ȸ�ϱ�
select department_id, department_name, manager_id
from departments
where manager_id is not null;

-- between a and b ����ϱ�
-- �޿��� 2000�̻� 3000���Ϸ� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary between 2000 and 3000;