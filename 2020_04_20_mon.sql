-- 1����
-- Join ����
select *
from employees, departments
where employees.department_id = departments.department_id
order by employee_id;

select employee_id, first_name, department_name, departments.department_id
from employees, departments
where employees.department_id = departments.department_id
order by employee_id;

select employee_id as ID, first_name as manager, department_name
    , nvl(to_char(employees.manager_id), ' ') as super
from employees, departments
where departments.manager_id = employees.employee_id
order by departments.department_id;

select employee_id, first_name, employees.job_id, job_title
from employees, jobs
where employees.job_id = jobs.job_id
order by employee_id;

-- 2����

-- �����ϱ�
-- �޿��� 3000�޷� �޴� ����� ���̵�, �̸�, �������̵�, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ
select employees.employee_id as id
    , employees.first_name as name
    , employees.job_id as job
    , employees.department_id as dept_id
    , departments.department_name as dept_name
    , salary
from employees, departments     -- ������ ���̺� ����
where 
    employees.salary=3000                                       -- ��ȸ ������ ����
    and employees.department_id = departments.department_id     -- ���� ������ ����
order by employees.employee_id;

-- �޿��� 15000�޷� �̻� ���� ������ �������̵�, �̸�,�޿�, �������̵�, ��������, ���������޿�, �����ִ�޿� ��ȸ�ϱ�
select A.employee_id as E_ID
    , A.first_name as name
    , A.salary as sal
    , A.job_id as j_ID
    , B.job_title as job
    , B.min_salary as min    
    , B.max_salary as max
from employees A, jobs B
where A.salary>=15000
    and A.job_id = B.job_id
order by salary;

-- �μ������ڰ� ������ �μ��� �μ����̵�, �μ���, ���ø�, �����ȣ, �ּ� ��ȸ�ϱ�
select D.department_id as id
    , D.department_name as dept
    , L.city
    , nvl(L.postal_code, 'Unknown') as "POSTAL CODE"
    , L.street_address as address
from departments D, locations L
where D.manager_id is not null
    and D.location_id = L.location_id
order by D.department_id;

-- �����ڰ� ������ �μ��� �μ����̵�, �μ���, �����ھ��̵�, ������ �̸��� ��ȸ�ϱ�
select D.department_id, D.department_name, D.manager_id, E.first_name
from departments D, employees E
where D.manager_id is not null
    and D.manager_id = E.employee_id
order by d.department_id;

-- 3����

-- 3�� �̻��� ���̺� �����ϱ�
-- �޿��� 12000�̻� ���� ����� ������̵�, �̸�, �޿�, �������̵�, ��������, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
select E.employee_id, E.first_name, E.salary
    , E.job_id, J.job_title
    , E.department_id, D.department_name
from employees E, departments D, jobs J
where E.salary >= 12000
    and E.department_id = D.department_id
    and E.job_id = J.job_id
order by employee_id;

-- 4����

-- �μ� �����ڰ� ������ �μ��� �μ����̵�, �μ���, �������� �������̵�, ������, ��ġ���̵�, ���ø�, �ּ� ��ȸ�ϱ�
select D.department_id, D.department_name
    , D.manager_id, E.first_name
    , D.location_id, L.city, L.street_address
from departments D, employees E, locations L
where D.manager_id is not null
    and D.manager_id = E.employee_id
    and D.location_id = L.location_id
order by D.department_id;

-- �μ� �����ڰ� ������ �μ��� �μ����̵�, �μ���, ��ġ���̵�, ���ø�, �ּ�, �������̵�, ������ ��ȸ�ϱ�
select D.department_id, D.department_name
    ,L.location_id, L.city, L.street_address
    ,C.country_id, C.country_name
from departments D, locations L, countries C
where D.manager_id is not null
    and D.location_id = L.location_id
    and L.country_id = C.country_id
order by D.department_id;

-- Seattle���� �ٹ��ϴ� ������ ���̵�, �̸�, ����, �ҼӺμ� ���̵�, �ҼӺμ����� ��ȸ�ϱ�
select E.employee_id, E.first_name, E.job_id
    , D.department_id, D.department_name
from employees E, departments D, locations L
where E.department_id = D.department_id
    and D.location_id = L.location_id
    and L.city = 'Seattle'
order by D.department_id, E.employee_id;