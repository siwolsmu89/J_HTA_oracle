-- �ڹٿ����� ������ȣ�� �̾���̱�� ���������� oracle������ ||�� �̾���̴� ��ȣ��.
-- concat ���� ���� �� : ||�� �ټ��� ���ڸ� �̾���� �� �־ ������ �� ���� ����.
select first_name ||' ' || last_name  
from employees;

-- �������� select�� ���� ��, where ������ ���� ������ �࿡ ���� ������ ����
-- �׷��� �� ���̺� �ִ� ��� ���� �������µ�, ���� �츮�� ������ ������� ����� ǥ���ϰ� �ȴ�.
select substr('891027', 3, 2)
from employees;

-- �׷��� oracle������ 1��1��¥�� ���̺��� dual�� ����� �� (column dummy, ���� x)
-- �� ���̺��� ���� ���� ��� ����� �� ���� ��Ÿ������ ���� �� ����ϴ� ���̺�(��û ���� ����)
select *
from dual;

select instr('010-7942-4465', '-')
from dual;

-- �ּҿ��� �պκи� �߶� ����ϱ�
select street_address, substr(street_address,1,instr(street_address,' ')-1)
from locations;

select replace(first_name, 'a', 'A')
from employees;

-- �����Լ�
select
    round(1265.737,2) "2",
    round(1265.737,1) "1",
    round(1265.737,0) "0",
    round(1265.737) " ",
    round(1265.737,-1) "-1",
    round(1265.737,-2) "-2"
from dual;

select
    trunc(1265.737,2) "2",
    trunc(1265.737,1) "1",
    trunc(1265.737,0) "0",
    trunc(1265.737) " ",
    trunc(1265.737,-1) "-1",
    trunc(1265.737,-2) "-2"
from dual;

-- �������� �ñ��� ��ȸ�ϱ�
-- �������̵�, �̸�, �������̵�, �޿�, �ñ�
-- �ñ� = �޿�*ȯ��/40, �ñ��� ������������ ǥ���Ѵ�
select employee_id, first_name, job_id, salary, trunc(salary*1220.40/(5*8)) pay_for_hour
from employees
order by pay_for_hour desc;

-- �������� ���ϱ�
select mod(32, 5)
from dual;

-- ��¥ �Լ�
-- ���� ��¥�� �ð����� ��ȸ�ϱ�
select sysdate
from dual;

-- �������̵�, ������, �Ի���, ���ñ��� �ٹ��� ��¥
select 
    employee_id, first_name, hire_date
    , trunc(sysdate-hire_date) as worked_days
    , trunc(trunc(sysdate-hire_date)/365) as worked_years
from employees
order by worked_days desc;

-- ����, 3����, 1������, 1������, 3������
select sysdate "����"
    , sysdate -1 "1�� ��"
    , sysdate -7 "1���� ��"
    , sysdate -30 "�Ѵ� ��"
from dual;

-- 60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �Ի���, �ٹ��� �������� ��ȸ�ϱ�
-- �������� �Ҽ����κ��� ������.
select employee_id
    , first_name
    , hire_date
    , trunc(months_between(sysdate, hire_date)) as worked_months
    , trunc(months_between(sysdate, hire_date)/12, 1) as worked_years
from employees
where department_id=60
order by worked_months;

-- ���ú��� 3���� ���� ��¥��?
select add_months(sysdate, 3) as "3 months later"
from dual;

-- ���ú��� 1�� ���� ��¥��
select add_months(sysdate, -12) as "1 year before"
from dual;

-- ��¥ �ݿø��ϱ�, ������
select sysdate+0.5, round(sysdate+0.5), trunc(sysdate+0.5)
from dual;

-- 
select firsT_name, hire_date
from employees;

-- �� ��¥�� �ϼ� ����ϱ�
-- ���� ��¥�� ���� trunc() �Լ��� �ú��ʸ� ��� 0���� ���� ��¥ ������ �ߴ�.
select employee_id
    , first_name
    , hire_date
    , sysdate - hire_date
    , trunc(sysdate)-hire_date
from employees;

-- �̹����� ������ �� ��ȸ�ϱ�
select last_day(trunc(sysdate)) , last_day(sysdate)
from dual;

-- ������ �������� ���� �� �����
-- next_day(���س�¥, ���Ϲ�ȣ) : ���� Ư���� ������ ���������� �˷� �ִ� �Լ�
-- ���Ϲ�ȣ�� 1~7(�Ͽ���~�����)
select next_day(trunc(sysdate), 7)
from dual;

-- ������ �������� ���� �� �ݿ���
select next_day(trunc(sysdate), 6)
from dual;

-- ������ �������� ���� �� �Ͽ���
select next_day(trunc(sysdate), 1)
from dual;

select to_date('09-10-27')+4000 as "4000days"
from dual;

-- ��ȯ �Լ�
-- ��¥�� ���ڷ� ��ȯ�ϱ�
select to_char(sysdate, 'yyyy') as ����
    , to_char(sysdate, 'mm') as ��
    , to_char(sysdate, 'dd') as ��
    , to_char(sysdate, 'day') as ����
    , to_char(sysdate, 'am') as "����/����"
    , to_char(sysdate, 'hh') as �ð�
    , to_char(sysdate, 'hh24') as "�ð�(24)"
    , to_char(sysdate, 'mi') as ��
    , to_char(sysdate, 'ss') as ��
from dual;

-- 2003�⵵�� �Ի��� ����� ���̵�, �̸�, �Ի��� ��ȸ
select employee_id, first_name, to_char(hire_date, 'mm') as hire_month
from employees
where to_char(hire_date, 'yyyy') = '2003';

-- �Ի����� ���� ��¥�� ���� ��¥�� �Ի��� ������ ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'mmdd') = to_char(sysdate, 'mmdd');

-- Ư����¥�� ��Ÿ���� ���ڸ� ��¥(DATEŸ��)�� ��ȯ�ϱ�
select to_date('2018-12-31', 'yyyy-mm-dd') +1000
from dual;

-- Ư����¥�� ��Ÿ���� ���ڸ� ��¥�� ��ȯ�ؼ� ���ñ����� �ϼ�, �������� ��ȸ�ϱ�
select trunc(sysdate) - to_date('1989-10-27', 'yyyy-mm-dd') as days
    , trunc(months_between(trunc(sysdate), to_date('1989-10-27', 'yyyy-mm-dd'))) as months
from dual;

-- 2005-01-01 ~ 2005-03-31 ���̿� �Ի��� ����� ���̵�, �̸�, �Ի���, �������̵� ��ȸ�ϱ�
select employee_id, first_name, hire_date, job_id
from employees
where hire_date>=to_date('2005-01-01')
    and hire_date<=to_date('2005-03-31')
order by hire_date;

-- between���� �غ���
select employee_id, first_name, hire_date, job_id
from employees
where hire_date between to_date('2005-01-01') 
                and to_date('2005-03-31')
order by hire_date;

-- 2003�⿡ �Ի��� ������ ���̵�, �̸�, �Ի��� ��ȸ
-- where ���ǽĿ� ���� ������ �����ϸ� ������ ���� �� �״�� �ΰ� �������� �����ؼ� ���
-- to_char(hire_date, 'yyyy') = '2003' �̷� ������ ���� ����� ��
-- ������ hire_date �״�� �ΰ� �������� ����
select employee_id, first_name, hire_date
from employees
where hire_date > to_date('2003-01-01', 'yyyy-mm-dd')
    and hire_date < to_date('20040101', 'yyyymmdd')
order by hire_date;

-- ���ڸ� õ�������� �����ڸ� ���Խ��� ��ȸ�ϱ�
select to_char(10000, '000,000'), to_char(10000, '999,999')
from dual;

-- ���ڸ� �Ҽ��� 2�ڸ����� �ݿø��� �� �ؽ�Ʈ�� ��ȯ�� ��ȸ�ϱ�
select to_char(123.456, '000.00'), to_Char(123.456, '999.99')
from dual;

-- ���ڸ� ���ڷ� ��ȯ�ؼ� ����ϱ�
-- �޿��� 15000�޷� �̻��� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
-- to_number�� ����ص� ������ '����' ���� �״�� ����ص� ��(��ü�� �̷��� ��)
-- ������ �� ��ȯ�� �Ͼ�ٰ� ǥ���Ѵ�.
select employee_id, first_name, salary
from employees
where salary >= '15000';

-- to_number�� ����� ���(�����۵�)
select employee_id, first_name, salary
from employees
where salary >= to_number('15000');

-- ���ڿ� ,�� �� ���·� ǥ���� �Ǿ����� �� ����. 
-- �̷� ���� to_number�� ��� (�� ��쿡�� �ݵ�� to_number�� ����ؾ� ��)
select employee_id, first_name, salary
from employees
where salary >= to_number('15,000', '99,999');

-- ��¥�� ���ڿ� ���������� ������ �� ��ȯ�� �����ϴ�.
select employee_id, first_name, hire_date
from employees
where hire_date > '2003-01-01'
    and hire_date < '2004/01/01'
order by hire_date;

-- NVL �Լ�
select nvl(10,1)            -- 10�� �������̴�
     , nvl(null, 1)          -- 1�� �������̴�
from dual;

-- �������̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
-- Ŀ�̼ǰ��� null�� ��� 0���� ��ȸ�Ѵ�.
select employee_id, first_name, salary, nvl(commission_pct, 0) as cms_pct
from employees
order by cms_pct desc;

-- �������̵�, �̸�, �Ǳ޿��� ��ȸ�ϱ�
-- �Ǳ޿� = �޿� + �޿�*Ŀ�̼��̴�.
select employee_id
    , first_name, salary
    , salary+ salary*nvl(commission_pct, 0) as actual_pay
    , salary+ (salary*commission_pct) as error_pay
    , commission_pct as cms
from employees
order by actual_pay desc;

-- �μ����̵�, �μ���, �ش�μ� ������ ���̵� ��ȸ�ϱ�
-- ������ ���̵� null�� ��� '������ ������ ����'���� ��ȸ�ϱ�
select department_id
    , department_name
    , nvl(to_char(manager_id), 'no manager') as manager
from departments
order by manager_id;

-- �μ����̵�, �μ���, �ش�μ� ������ ���̵� ��ȸ�ϱ�
-- ������ ���̵� null�� ��� 100�� ����(����)�� �����ڷ� �����Ѵ�.
select department_id
    , department_name
    , nvl(manager_id, 100) as manager
from departments
order by manager desc;

select department_id
    , department_name
    , case 
        when manager_id is not null then to_char(manager_id)
        when manager_id is null then 100||'(*)'
     end as manager
from departments
order by manager;

-- nvl2() �Լ� ����ϱ�
select nvl2(10, 1, 0)      -- �������� 1�̴�.
    , nvl2(null, 1, 0)     -- �������� 0�̴�.
from dual;

-- �������̵�, �̸�, Ŀ�̼� ���ɿ��θ� 'yes', 'no'�� ��ȸ�ϱ�
select employee_id, first_name, nvl2(commission_pct, 'yes', 'no') as cms
from employees
order by cms desc, commission_pct desc, salary desc;

-- case ~ when 
-- �������̵�, �̸�, �޿�, �޿���� ��ȸ�ϱ�
-- �޿������
-- 20000�޷� �̻� A
-- 10000�޷� �̻� B
-- 5000 �޷� �̻� C
-- �� �ܴ� D
select employee_id, first_name, salary
    , case
        when salary>=20000 then 'A'
        when salary>=10000 then 'B'
        when salary>=5000 then 'C'
        else 'D'
       end as grade
from employees
order by salary desc;

-- case~when
-- �������̵�, �̸�, �޿�, �λ�� �޿� ��ȸ�ϱ�
-- �޿� �λ���
-- 20000�޷� �̻� 10%
-- 10000�޷� �̻� 15%
-- 5000�޷� �̻� 20%
-- �׿� 25%
select employee_id, first_name, salary
    , case
        when salary>=20000 then salary*(1.1)
        when salary>=10000 then salary*(1.15)
        when salary>=5000 then salary*(1.2)
        else salary*(1.25)
    end as rise
from employees
order by rise desc;

select employee_id
    , first_name
    , salary
    , decode (department_id, 50, salary*1.1,
                             80, salary*1.15,
                             salary*1.05) rise
from employees
order by employee_id;

-- decode()�Լ��� ����ؼ� ��ȸ�ϱ�
-- decode() �ȿ� decode() ����
-- �������̵�, �̸�, �޿�, �޿���� ��ȸ�ϱ�
-- �λ��
-- 20000 �޷� �̻� A
-- 10000 �޷� �̻� B
-- 5000 �޷� �̻� C
-- �׿� D
select employee_id, first_name
    , decode (trunc(salary, -4), 20000, 'A'
                                 , 10000, 'B'
                                 , decode (trunc(salary/5000)*5000, 5000, 'C'       -- ������ ���Ӽ��� �����ϱ� ����
                                                                        , 'D')
              ) as salary_grade
from employees
order by salary_grade;