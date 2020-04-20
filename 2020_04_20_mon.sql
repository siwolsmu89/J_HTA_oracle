-- 1교시
-- Join 사용법
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

-- 2교시

-- 조인하기
-- 급여를 3000달러 받는 사원의 아이디, 이름, 직종아이디, 소속부서아이디, 소속부서명을 조회
select employees.employee_id as id
    , employees.first_name as name
    , employees.job_id as job
    , employees.department_id as dept_id
    , departments.department_name as dept_name
    , salary
from employees, departments     -- 조인할 테이블 지정
where 
    employees.salary=3000                                       -- 조회 조건을 지정
    and employees.department_id = departments.department_id     -- 조인 조건을 지정
order by employees.employee_id;

-- 급여를 15000달러 이상 받은 직원의 직원아이디, 이름,급여, 직종아이디, 직종제목, 직종최저급여, 직종최대급여 조회하기
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

-- 부서관리자가 지정된 부서의 부서아이디, 부서명, 도시명, 우편번호, 주소 조회하기
select D.department_id as id
    , D.department_name as dept
    , L.city
    , nvl(L.postal_code, 'Unknown') as "POSTAL CODE"
    , L.street_address as address
from departments D, locations L
where D.manager_id is not null
    and D.location_id = L.location_id
order by D.department_id;

-- 관리자가 지정된 부서의 부서아이디, 부서명, 관리자아이디, 관리자 이름을 조회하기
select D.department_id, D.department_name, D.manager_id, E.first_name
from departments D, employees E
where D.manager_id is not null
    and D.manager_id = E.employee_id
order by d.department_id;

-- 3교시

-- 3개 이상의 테이블 조인하기
-- 급여를 12000이상 받은 사원의 사원아이디, 이름, 급여, 직종아이디, 직종제목, 소속부서아이디, 소속부서명을 조회하기
select E.employee_id, E.first_name, E.salary
    , E.job_id, J.job_title
    , E.department_id, D.department_name
from employees E, departments D, jobs J
where E.salary >= 12000
    and E.department_id = D.department_id
    and E.job_id = J.job_id
order by employee_id;

-- 4교시

-- 부서 관리자가 지정된 부서의 부서아이디, 부서명, 관리자의 직원아이디, 직원명, 위치아이디, 도시명, 주소 조회하기
select D.department_id, D.department_name
    , D.manager_id, E.first_name
    , D.location_id, L.city, L.street_address
from departments D, employees E, locations L
where D.manager_id is not null
    and D.manager_id = E.employee_id
    and D.location_id = L.location_id
order by D.department_id;

-- 부서 관리자가 지정된 부서의 부서아이디, 부서명, 위치아이디, 도시명, 주소, 국가아이디, 국가명 조회하기
select D.department_id, D.department_name
    ,L.location_id, L.city, L.street_address
    ,C.country_id, C.country_name
from departments D, locations L, countries C
where D.manager_id is not null
    and D.location_id = L.location_id
    and L.country_id = C.country_id
order by D.department_id;

-- Seattle에서 근무하는 직원의 아이디, 이름, 직종, 소속부서 아이디, 소속부서명을 조회하기
select E.employee_id, E.first_name, E.job_id
    , D.department_id, D.department_name
from locations L, departments D, employees E
where L.city = 'Seattle'
    and L.location_id = D.location_id
    and D.department_id = E.department_id
order by D.department_id, E.employee_id;

-- 6교시

-- 직종 변경 이력에서
-- 직원아이디, 직원이름, 업무시작일, 업무종료일, 직종아이디, 직종제목, 소속부서아이디, 부서명 조회하기
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

-- 7교시

select E.employee_id, E.first_name, E.salary
    , G.gra as grade
from employees E, job_grades G
where E.salary >= G.lowest_sal 
    and E.salary <= G.highest_sal
order by salary desc;

-- 비등가 조인
-- 50번 부서에 소속된 직원의 급여 등급을 조회하기
-- 직원아이디, 이름, 급여, 급여 등급
select E.employee_id, E.first_name
    , G.lowest_sal min, E.salary, G.highest_sal max
    , G.gra as grade
from employees E, job_grades G
where E.department_id = 50
    and E.salary >= G.lowest_sal
    and E.salary <= G.highest_sal
order by salary desc, first_name;

-- 직종별 최저/최고급여의 등급 조회하기
select J.job_id, J.job_title
    , J.min_salary, G1.gra as min_sal_grade
    , J.max_salary, G2.gra as max_sal_grade
from jobs J, job_grades G1, job_grades G2
where J.min_salary >= G1.lowest_sal
    and J.min_salary <= G1.highest_sal
    and J.max_salary >= G2.lowest_sal
    and J.max_salary <= G2.highest_sal
order by max_sal_grade desc, min_sal_grade desc;