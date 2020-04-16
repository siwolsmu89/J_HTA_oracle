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

-- In(��1, ��2, ��3...) ����ϱ�
-- 10�� �μ��� 20�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id in (10, 20);

-- 50, 60, 70, 80�� �μ��� �Ҽӵ��� ���� ����� ���̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id not in (50, 60, 70, 80);

-- �������̵� JP, US�� ������ ��ġ���̵�, �ּ�, �������̵� ��ȸ�ϱ�
select location_id, street_address, country_id
from locations
where country_id in ('JP', 'US');

-- ������ �������̵� AD_PRES�̰ų� AD_VP�� ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN('AD_PRES', 'AD_VP');

-- 50�� Ȥ�� 60�� �μ��� �ٹ��� ���� �ִ� ����� ���̵�, �ٹ�������, �ٹ��������� ��ȸ�ϱ�
SELECT employee_id, start_date, end_date
from job_history
where department_id in (50, 60);

-- 101���̳� 102�� ������ ���� ������ ����� ���̵�, �̸�, �Ŵ������̵� ��ȸ�ϱ�
select employee_id, first_name, manager_id
from employees
where manager_id in(101,102);

select first_name
from employees
where first_name like '___________';