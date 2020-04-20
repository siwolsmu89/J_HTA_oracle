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
from locations L, departments D, employees E
where L.city = 'Seattle'
    and L.location_id = D.location_id
    and D.department_id = E.department_id
order by D.department_id, E.employee_id;

-- 6����

-- ���� ���� �̷¿���
-- �������̵�, �����̸�, ����������, ����������, �������̵�, ��������, �ҼӺμ����̵�, �μ��� ��ȸ�ϱ�
select H.employee_id, E.first_name
    , H.start_date, H.end_date
    , H.job_id, J.job_title
    , H.department_id, D.department_name
from job_history H, employees E, jobs J, departments D
where H.employee_id = E.employee_id
    and H.job_id = J.job_id
    and H.department_id = D.department_id
order by H.employee_id, H.start_date;

create table job_grades(
    gra char(1) primary key, 
    lowest_sal number(6,0) not null,
    highest_sal number(6,0) not null
);

insert into job_grades values('A', 1000, 2999);
insert into job_grades values('B', 3000, 5999);
insert into job_grades values('C', 6000, 9999);
insert into job_grades values('D', 10000, 14999);
insert into job_grades values('E', 15000, 24999);
insert into job_grades values('F', 25000, 400000);

commit;

-- 7����

select E.employee_id, E.first_name, E.salary
    , G.gra as grade
from employees E, job_grades G
where E.salary >= G.lowest_sal 
    and E.salary <= G.highest_sal
order by salary desc;

-- �� ����
-- 50�� �μ��� �Ҽӵ� ������ �޿� ����� ��ȸ�ϱ�
-- �������̵�, �̸�, �޿�, �޿� ���
select E.employee_id, E.first_name
    , G.lowest_sal min, E.salary, G.highest_sal max
    , G.gra as grade
from employees E, job_grades G
where E.department_id = 50
    and E.salary >= G.lowest_sal
    and E.salary <= G.highest_sal
order by salary desc, first_name;

-- ������ ����/�ְ�޿��� ��� ��ȸ�ϱ�
select J.job_id, J.job_title
    , J.min_salary, G1.gra as min_sal_grade
    , J.max_salary, G2.gra as max_sal_grade
from jobs J, job_grades G1, job_grades G2
where J.min_salary >= G1.lowest_sal
    and J.min_salary <= G1.highest_sal
    and J.max_salary >= G2.lowest_sal
    and J.max_salary <= G2.highest_sal
order by max_sal_grade desc, min_sal_grade desc;