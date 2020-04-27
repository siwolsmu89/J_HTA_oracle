SELECT *
FROM DEPARTMENTS;

SELECT *
FROM COUNTRIES;

select *
from jobs;

SELECT *
FROM job_history;

-- 사원 테이블에서 사원 아이디
select employee_id,first_name, salary 
from employees;

-- 부서 테이블에서 부서아이디, 부서명 조회하기
select department_id, department_name
from departments;

-- 잡아이디, 잡타이틀을 조회하기
select job_id, job_title
from jobs;

-- 나라이름 조회하기
select country_name
from countries;

-- 사원아이디, 이름, 급여, 연봉, 10%인상된 급여 조회하기
select employee_id id, first_name name, salary sal, salary*12 as ann_sal, salary*1.1 "INCREMENT SALARY"
from employees;

-- 부서아이디, 부서명, 부서담당자 아이디 조회하기
select department_id ID, department_name name, manager_id m_id
from departments;

-- 사원아이디, 이름, 급여, 커미션, 커미션이 포함된 급여 조회하기
-- 커미션이 포함된 급여는 급여 + 급여*커미션
select employee_id id, first_name name, salary sal, commission_pct "CMS %", salary + salary*commission_pct as "SAL with CMS"
from employees;

-- 중복행없이 조회하기
-- 사원들이 종사하고 있는 직종 아이디를 전부 조회하기
select distinct job_id
from employees;

-- 60번 부서에 근무하는 사원의 아이디, 이름, 직종, 급여, 부서아이디를 조회하기
select employee_id as id, first_name as name, job_id as job, salary as SAL, department_id as dept
from employees
where department_id=60;

-- 급여를 15000달러 이상 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary>=15000;