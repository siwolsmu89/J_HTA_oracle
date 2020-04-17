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