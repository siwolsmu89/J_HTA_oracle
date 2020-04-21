-- 1.  시스템의 현재 날짜와 시간 조회하기 (dual 사용)
select sysdate
from dual;

-- 2.  급여를 5000달러 이상 받고, 2005년에 입사한 직원의 아이디, 이름, 급여, 입사일을 조회하기
select employee_id, first_name, salary, hire_date
from employees
where salary>=5000
    and to_char(hire_date, 'yyyy') = '2005'
order by employee_id;

-- 3.  이름에 e나 E가 포함된 직원 중에서 급여를 10000달러 이상 받는 직원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where (first_name like '%e%' or first_name like '%E%')    -- or가 있으면 반드시 괄호로 or이 적용되는 조건들을 묶어주자
    and salary>=10000
order by first_name;

-- 4.  입사년도와 상관없이 4월에 입사한 직원들의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'mm') = '04'
order by employee_id;

-- 5.  2006년 상반기(1/1 ~ 6/30)에 입사한 직원들의 아이디, 이름, 입사일 조회하기
select employee_id, first_name, hire_date
from employees
where hire_date between '2006-01-01' and '2006-06-30'
order by hire_date;

-- 6.  50번 부서에 소속된 직원들의 급여를 13%인상시키려고 한다.
--     직원아이디, 이름, 현재 급여, 인상된 급여를 조회하기
--     인상된 급여는 소숫점 이하는 버린다.
select employee_id, first_name, salary, trunc(salary*1.13) as rise
from employees
where department_id = 50
order by employee_id;

-- 7.  50번 부서에 소속된 직원들의 급여를 조회하려고 한다.
--     직원 아이디, 이름, 급여 그리고, 급여 1000달러당 *를 하나씩 표시하라.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
select employee_id, first_name, salary
    , lpad('*', trunc(salary/1000), '*') as "*"
from employees
where department_id = 50
order by employee_id;

-- 8.  관리자가 지정되어 있지 않는 부서의 
--     부서아이디, 부서명, 위치아이디, 도시명, 주소를 조회하기
select D.department_id, D.department_name
    , L.location_id, L.city, L.street_address
from departments D, locations L
where D.manager_id is null
    and D.location_id = L.location_id
order by department_id;

-- 9.  'Executive' 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select E.employee_id, E.first_name
    , J.job_title
    , E.salary
from employees E, jobs J, departments D
where E.job_id = J.job_id
    and E.department_id = D.department_id
    and D.department_name = 'Executive'
order by E.employee_id;

-- 10. 100번 직원이 부서관리자로 지정된 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select E.employee_id, E.first_name, J.job_title, E.salary, D.department_id, D.manager_id
from employees E, jobs J, departments D
where E.department_id = D.department_id
    and D.manager_id = 100
    and E.job_id = J.job_id
order by employee_id;

-- 11. 10, 20, 30번 부서에 소속된 직원들의 직원아이디, 이름, 급여, 급여등급을 조회하기
select E.employee_id, E.first_name, E.salary, G.gra
from employees E, departments D, job_grades G
where E.department_id = D.department_id
    and D.department_id in (10, 20, 30)
    and E.salary >= G.lowest_sal
    and E.salary <= G.highest_sal
order by gra, salary;

-- 12. 직원들의 직종정보를 참고했을 때 자신이 종사하고 있는 직종의 최저급여를 받고 있는
--     직원의 아이디, 이름, 급여, 직종아이디, 직종최저급여를 조회하기
select E.employee_id, E.first_name, E.salary, E.job_id
    , J.min_salary as job_min
from employees E, jobs J
where E.job_id = J.job_id
    and E.salary = J.min_salary
order by salary;

-- 13. 커미션을 받는 직원들의 직원아이디, 이름, 커미션, 급여, 직종아이디, 직종제목, 소속부서 아이디, 부서명을 조회하기
select E.employee_id, E.first_name, E.commission_pct, E.salary
    , E.job_id, J.job_title
    , E.department_id, D.department_name
from employees E, jobs J, departments D
where E.commission_pct is not null
    and E.job_id = J.job_id
    and E.department_id = D.department_id
order by E.employee_id;

-- 14. 'Canada'에서 근무하고 있는 직원의 아이디, 이름, 소속부서 아이디, 소속부서명, 위치 아이디, 도시명, 주소를 조회하기
select E.employee_id, E.first_name
    , E.department_id, D.department_name
    , D.location_id, L.city, L.street_address
from employees E, departments D, locations L, countries C
where E.department_id = D.department_id
    and D.location_id = L.location_id
    and L.country_id = C.country_id
    and C.country_name = 'Canada'
order by employee_id;

-- 15. 모든 직원의 직원아이디, 이름, 직종아이디, 직종제목, 급여, 급여등급, 소속부서 아이디, 소속부서명, 도시명을 조회하기
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
 
-- 16. 급여를 5000달러 이하로 받는 직원들의 아이디, 이름, 직종, 소속부서 아이디, 소속부서명, 소속부서 관리자 직원아이디, 
--     소속부서 관리자 직원이름을 조회하기
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

-- 17. 'Asia'지역에 소재지를 두고 있는 부서의 아이디, 부서명, 부서관리자 이름을 조회하기
select D.department_id, D.department_name, E.first_name as manager_name
from departments D, employees E, locations L, countries C, regions R
where R.region_name = 'Asia'
    and R.region_id = C.region_id
    and C.country_id = L.country_id
    and L.location_id = D.location_id
    and D.manager_id = E.employee_id
order by department_id;

-- 18. 101번 직원이 근무했던 부서에서 근무중이 직원의 아이디, 이름, 부서아이디, 부서명을 조회하기
select distinct E.employee_id, E.first_name, E.department_id, D.department_name
from employees E, departments D, job_history H
where  H.employee_id = 101
    and E.department_id = H.department_id
    and H.department_id = D.department_id
order by department_id, employee_id; 

-- 19. 직원중에서 자신이 종사하고 있는 직종의 최고급여 50%이상을 급여로 받고 있는 
--     직원의 아이디, 이름, 급여, 직종아이디, 직종 최고급여를 조회하기
select E.employee_id, E.first_name, E.salary, E.job_id, J.max_salary
from employees E, jobs J
where E.job_id = J.job_id
    and E.salary >= (J.max_salary*0.5)
order by employee_id;

-- 20. 미국(US)에 위치하고 있는 부서의 아이디, 이름, 위치번호, 도시명, 주소를 조회하기 
select D.department_id, D.department_name, D.location_id, L.city, L.street_address
from departments D, locations L
where D.location_id = L.location_id
    and L.country_id = 'US'
order by department_id;