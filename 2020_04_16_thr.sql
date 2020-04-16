select job_title
from jobs;

-- 테이블에서 열을 선택해서 조회하기
-- 사원아이디, 사원명, 직종아이디, 급여 조회하기
select employee_id, first_name, job_id, salary
from employees;

-- 직종아이디, 직종의 최소급여, 최대급여 조회하기
select job_id, min_salary, max_salary
from jobs;

-- 지역아이디, 도시명, 주소 조회하기
select location_id, city, street_address
from locations;

-- 사원아이디, 사원명, 입사일 조회하기
select employee_id as id, first_name as name, hire_date
from employees;

-- 연산자를 이용하기, 별칭 사용하기
-- 사원아이디, 직종, 급여, 연봉을 조회하고 적절한 별칭 부여하기
select employee_id as id, job_id as job, salary, salary*4*12 as ANN_SAL
from employees;

-- 사원아이디, 직종, 급여, 시급을 조회하고 적절한 별칭 부여하기, 시급은 급여/(5*24) 이다.
select employee_id id, job_id job, salary sal, salary/(5*24) time_sal
from employees;

-- 행을 제한해서 조회하기
-- 60번 부서에서 근무하는 사원의 아이디, 이름, 직종, 부서아이디를 조회하기
select employee_id id, first_name name, job_id job, department_id dept
from employees
where (department_id=60);

-- 급여를 5000달러 이하로 받는 사원아이디, 이름, 직종, 급여를 조회하기
select employee_id id, first_name name, job_id job, salary
from employees
where salary<=5000;

-- 100번 직원에게 보고하는 직원의 아이디, 이름 조회하기
select employee_id id, first_name name
from employees
where manager_id=100;

-- 100번 직원이 부서담당자로 지정된 부서의 아이디, 부서명을 조회하기
select department_id, department_name
from departments
where manager_id=100;

-- 직종 최대 급여가 15000달러 이상 되는 직종의 아이디, 직종제목, 최대급여 조회하기
select job_id, job_title, max_salary
from jobs
where max_salary>=15000;

-- 시급을 100달러 이상 받는 직원의 아이디, 이름, 직종, 급여, 시급을 조회하기
select employee_id id, first_name name, job_id job, salary, salary/(5*8) as "SALARY/H"
from employees
where salary/(5*8)>100;

-- 이름이 Neena인 사람의 직원아이디, 이름, 이메일, 전화번호를 조회하기
select employee_id, first_name, last_name, email, phone_number
from employees
where first_name = 'Neena';

-- 커미션이 null인 직원의 직원아이디, 이름, 소속부서아이디 확인하기
select employee_id, first_name, department_id
from employees
where commission_pct is null;

-- 커미션이 null이 아닌 직원의 직원아이디, 이름, 직종아이디, 소속부서 아이디 조회하기
select employee_id, first_name, job_id, department_id 
from employees
where commission_pct is not null;

-- 소속부서를 배정받지 못한 직원의 아이디, 이름, 입사일 조회하기
select employee_id, first_name, hire_date
from employees
where department_id is null;

-- 부서담당자가 지정되지 않은 부서의 아이디, 부서명을 조회하기
select department_id, department_name
from departments
where manager_id is null;

-- 부서담당자가 지정된 부서의 부서아이디, 부서명, 담당자 직원아이디 조회하기
select department_id, department_name, manager_id
from departments
where manager_id is not null;

-- between a and b 사용하기
-- 급여를 2000이상 3000이하로 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary between 2000 and 3000;

-- In(값1, 값2, 값3...) 사용하기
-- 10번 부서와 20번 부서에 소속된 사원의 아이디, 이름, 소속부서 아이디 조회하기
select employee_id, first_name, department_id
from employees
where department_id in (10, 20);

-- 50, 60, 70, 80번 부서에 소속되지 않은 사원의 아이디, 이름, 소속부서 아이디 조회하기
select employee_id, first_name, department_id
from employees
where department_id not in (50, 60, 70, 80);

-- 국가아이디가 JP, US인 지역의 위치아이디, 주소, 국가아이디 조회하기
select location_id, street_address, country_id
from locations
where country_id in ('JP', 'US');

-- 직원의 직종아이디가 AD_PRES이거나 AD_VP인 직원의 아이디, 이름, 직종을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN('AD_PRES', 'AD_VP');

-- 50번 혹은 60번 부서에 근무한 적이 있는 사원의 아이디, 근무시작일, 근무종료일을 조회하기
SELECT employee_id, start_date, end_date
from job_history
where department_id in (50, 60);

-- 101번이나 102번 직원이 상사로 지정된 사원의 아이디, 이름, 매니저아이디를 조회하기
select employee_id, first_name, manager_id
from employees
where manager_id in(101,102);

select first_name
from employees
where first_name like '___________';