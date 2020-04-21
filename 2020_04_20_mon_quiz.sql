-- 1.  �ý����� ���� ��¥�� �ð� ��ȸ�ϱ� (dual ���)
select sysdate
from dual;

-- 2.  �޿��� 5000�޷� �̻� �ް�, 2005�⿡ �Ի��� ������ ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, salary, hire_date
from employees
where salary>=5000
    and to_char(hire_date, 'yyyy') = '2005'
order by employee_id;

-- 3.  �̸��� e�� E�� ���Ե� ���� �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where (first_name like '%e%' or first_name like '%E%')    -- or�� ������ �ݵ�� ��ȣ�� or�� ����Ǵ� ���ǵ��� ��������
    and salary>=10000
order by first_name;

-- 4.  �Ի�⵵�� ������� 4���� �Ի��� �������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'mm') = '04'
order by employee_id;

-- 5.  2006�� ��ݱ�(1/1 ~ 6/30)�� �Ի��� �������� ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where hire_date between '2006-01-01' and '2006-06-30'
order by hire_date;

-- 6.  50�� �μ��� �Ҽӵ� �������� �޿��� 13%�λ��Ű���� �Ѵ�.
--     �������̵�, �̸�, ���� �޿�, �λ�� �޿��� ��ȸ�ϱ�
--     �λ�� �޿��� �Ҽ��� ���ϴ� ������.
select employee_id, first_name, salary, trunc(salary*1.13) as rise
from employees
where department_id = 50
order by employee_id;

-- 7.  50�� �μ��� �Ҽӵ� �������� �޿��� ��ȸ�Ϸ��� �Ѵ�.
--     ���� ���̵�, �̸�, �޿� �׸���, �޿� 1000�޷��� *�� �ϳ��� ǥ���϶�.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
select employee_id, first_name, salary
    , lpad('*', trunc(salary/1000), '*') as "*"
from employees
where department_id = 50
order by employee_id;

-- 8.  �����ڰ� �����Ǿ� ���� �ʴ� �μ��� 
--     �μ����̵�, �μ���, ��ġ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
select D.department_id, D.department_name
    , L.location_id, L.city, L.street_address
from departments D, locations L
where D.manager_id is null
    and D.location_id = L.location_id
order by department_id;

-- 9.  'Executive' �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select E.employee_id, E.first_name
    , J.job_title
    , E.salary
from employees E, jobs J, departments D
where E.job_id = J.job_id
    and E.department_id = D.department_id
    and D.department_name = 'Executive'
order by E.employee_id;

-- 10. 100�� ������ �μ������ڷ� ������ �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select E.employee_id, E.first_name, J.job_title, E.salary, D.department_id, D.manager_id
from employees E, jobs J, departments D
where E.department_id = D.department_id
    and D.manager_id = 100
    and E.job_id = J.job_id
order by employee_id;

-- 11. 10, 20, 30�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select E.employee_id, E.first_name, E.salary, G.gra
from employees E, departments D, job_grades G
where E.department_id = D.department_id
    and D.department_id in (10, 20, 30)
    and E.salary >= G.lowest_sal
    and E.salary <= G.highest_sal
order by gra, salary;

-- 12. �������� ���������� �������� �� �ڽ��� �����ϰ� �ִ� ������ �����޿��� �ް� �ִ�
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���������޿��� ��ȸ�ϱ�
select E.employee_id, E.first_name, E.salary, E.job_id
    , J.min_salary as job_min
from employees E, jobs J
where E.job_id = J.job_id
    and E.salary = J.min_salary
order by salary;

-- 13. Ŀ�̼��� �޴� �������� �������̵�, �̸�, Ŀ�̼�, �޿�, �������̵�, ��������, �ҼӺμ� ���̵�, �μ����� ��ȸ�ϱ�
select E.employee_id, E.first_name, E.commission_pct, E.salary
    , E.job_id, J.job_title
    , E.department_id, D.department_name
from employees E, jobs J, departments D
where E.commission_pct is not null
    and E.job_id = J.job_id
    and E.department_id = D.department_id
order by E.employee_id;

-- 14. 'Canada'���� �ٹ��ϰ� �ִ� ������ ���̵�, �̸�, �ҼӺμ� ���̵�, �ҼӺμ���, ��ġ ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
select E.employee_id, E.first_name
    , E.department_id, D.department_name
    , D.location_id, L.city, L.street_address
from employees E, departments D, locations L, countries C
where E.department_id = D.department_id
    and D.location_id = L.location_id
    and L.country_id = C.country_id
    and C.country_name = 'Canada'
order by employee_id;

-- 15. ��� ������ �������̵�, �̸�, �������̵�, ��������, �޿�, �޿����, �ҼӺμ� ���̵�, �ҼӺμ���, ���ø��� ��ȸ�ϱ�
select E.employee_id, E.first_name
    , E.job_id, J.job_title
    , E.salary, G.gra as sal_grade
    , E.department_id, D.department_name
    , L.city
from employees E, jobs J, job_grades G, departments D, locations L
where E.job_id = J.job_id
    and E.salary >= G.lowest_sal and E.salary <= G.highest_sal
    and E.department_id = D.department_id
    and D.location_id = L.location_id
order by employee_id;
 
-- 16. �޿��� 5000�޷� ���Ϸ� �޴� �������� ���̵�, �̸�, ����, �ҼӺμ� ���̵�, �ҼӺμ���, �ҼӺμ� ������ �������̵�, 
--     �ҼӺμ� ������ �����̸��� ��ȸ�ϱ�
select E.employee_id, E.first_name, E.salary
    , J.job_title
    , D.department_id, D.department_name
    , D.manager_id, E2.first_name as manager_name
from employees E, employees E2, jobs J, departments D
where E.salary <= 5000
    and E.job_id = J.job_id
    and E.department_id = D.department_id
    and D.manager_id = E2.employee_id
order by E2.first_name, E.employee_id;

-- 17. 'Asia'������ �������� �ΰ� �ִ� �μ��� ���̵�, �μ���, �μ������� �̸��� ��ȸ�ϱ�
select D.department_id, D.department_name, E.first_name as manager_name
from departments D, employees E, locations L, countries C, regions R
where R.region_name = 'Asia'
    and R.region_id = C.region_id
    and C.country_id = L.country_id
    and L.location_id = D.location_id
    and D.manager_id = E.employee_id
order by department_id;

-- 18. 101�� ������ �ٹ��ߴ� �μ����� �ٹ����� ������ ���̵�, �̸�, �μ����̵�, �μ����� ��ȸ�ϱ�
select distinct E.employee_id, E.first_name, E.department_id, D.department_name
from employees E, departments D, job_history H
where  H.employee_id = 101
    and E.department_id = H.department_id
    and H.department_id = D.department_id
order by department_id, employee_id; 

-- 19. �����߿��� �ڽ��� �����ϰ� �ִ� ������ �ְ�޿� 50%�̻��� �޿��� �ް� �ִ� 
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���� �ְ�޿��� ��ȸ�ϱ�
select E.employee_id, E.first_name, E.salary, E.job_id, J.max_salary
from employees E, jobs J
where E.job_id = J.job_id
    and E.salary >= (J.max_salary*0.5)
order by employee_id;

-- 20. �̱�(US)�� ��ġ�ϰ� �ִ� �μ��� ���̵�, �̸�, ��ġ��ȣ, ���ø�, �ּҸ� ��ȸ�ϱ� 
select D.department_id, D.department_name, D.location_id, L.city, L.street_address
from departments D, locations L
where D.location_id = L.location_id
    and L.country_id = 'US'
order by department_id;