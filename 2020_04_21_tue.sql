-- 1교시, 2교시 : 04_20_quiz 풀이

-- 셀프 조인
SELECT E.employee_id, E.first_name, E.manager_id, E.salary
    , E2.first_name as manager_name
FROM employees E, employees E2
WHERE E2.employee_id = E.manager_id
ORDER BY E.employee_id;

-- 3교시
SELECT worker.employee_id as id, worker.first_name, worker.salary
    ,worker.manager_id as manager,  manager.first_name as manager_name
    , nvl(manager.manager_id, manager.employee_id) as super
FROM employees worker, employees manager
WHERE worker.manager_id = manager.employee_id
ORDER BY manager.employee_id, worker.employee_id;

-- 셀프조인(자체조인)
-- 101번 사원의 이름, 직종, 자신의 상사이름을 조회하기
SELECT Emp.first_name as 이름, Emp.job_id as 직종, Mgr.first_name as 상사
FROM employees Emp, employees Mgr
WHERE Emp.employee_id = 101
    AND Emp.manager_id = Mgr.employee_id;
    
-- 60번 부서에 근무중인 사원의 아이디, 이름, 직종, 상사의 이름, 상사의 직종, 부서아이디, 부서명, 부서관리자 아이디, 부서관리자 이름을 조회하기
SELECT Emp.employee_id as "직원 ID"
    , Emp.first_name as "직원 이름"
    , Emp.job_id as "직원 직종"
    , Mgr.first_name as "상사 이름"
    , Mgr.job_id as "상사 직종"
    , D.department_id as "부서 ID"
    , D.department_name as "부서명"
    , D.manager_id as "부서장 ID"
    , DMgr.first_name as "부서장 이름"
FROM employees Emp, employees Mgr, employees DMgr, Departments D
WHERE Emp.department_id = 60
    AND Emp.manager_id = Mgr.employee_id
    AND Emp.department_id = D.department_id
    AND D.manager_id = DMgr.employee_id
ORDER BY D.department_id, Emp.employee_id;

-- 4교시
-- 포괄조인
SELECT D.department_name, D.manager_id, E.first_name as manager_name
FROM employees E, departments D
WHERE D.manager_id = E.employee_id(+)
ORDER BY D.department_id;

-- 부서아이디, 부서명, 부서관리자아이디, 부서관리자 이름 조회하기
SELECT D.department_id, D.department_name 
    , Mgr.employee_id, Mgr.first_name
FROM departments D, employees Mgr
WHERE D.manager_id = Mgr.employee_id(+)
ORDER BY department_id;

-- 모든 직원의 이름, 급여, 직종아이디, 소속부서명을 조회하기
SELECT E.first_name, E.salary, E.job_id, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id(+)
ORDER BY E.employee_id;

-- 5교시

-- 6교시

-- group by는 where 뒤 order by 앞에 적는다.
-- cf. 쿼리문 작성 순서
-- select
-- from
-- [where]
-- [group by]
-- [having] : 아직 안 배움
-- [order by]

-- 다중 행 함수 사용하기
-- employees의 모든 행 개수 조회하기
select count(*)
from employees;

-- 50번 부서에서 일하는 직원의 수를 조회하기
select count(*)
from employees
where department_id = 50;

select department_id, count(*)
from employees
group by department_id
order by department_id;

-- 커미션을 받는 직원의 수를 조회하기
select count(commission_pct) as cms_not_null -- 컬럼을 지정하면 해당 컬럼의 값이 null이 아닌 것만 카운트한다.
from employees;

-- 커미션을 받는 직원의 수를 조회하기 II
select count(*)
from employees
where commission_pct is not null;

-- 직원들 중에서 최고급여, 최저급여를 받는 직원의 급여를 조회하기
select max(salary), min(salary)
from employees;

-- 최고급여를 받는 사람의 이름과 최고급여를 조회하기
-- 오류가 발생하는 쿼리문(그룹함수와 그룹함수가 아닌 것을 병기할 수 없다)
select first_name, max(salary)
from employees;

-- 이렇게 적으면 구할 수 있다 (나중에 배울 것)
-- 서브쿼리를 사용하는 방식
-- 모르는 값이 조회 조건으로 제시될 때, 해당 값을 찾는 쿼리문을 조건절에 적는 것.
SELECT first_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) 
                FROM employees);
                
                
-- 잠깐 수학문제좀 풀다 옴

-- 조회된 행의 개수를 구하기
-- count(*) : 조회된 모든 행의 개수를 반환한다
-- count(컬럼명) : 해당 컬럼의 값이 null이 아닌 행의 개수를 반환한다.
-- count(distinct 컬럼명) : 해당 컬럼의 값에 대해 중복된 값은 1번만 카운트해서 행의 개수를 반환한다.
select count(*)
from employees;

select count(job_id)
from employees;

select count(distinct job_id)
from employees;

select count(distinct to_char(hire_date,'yyyy'))
from employees;

select distinct to_char(hire_date, 'yyyy')
from employees;

-- 조회된 행의 특점 컬럼에 대한 합계를 구하기
-- sum(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 값들의 합계를 반환한다
-- 전체 사원들의 급여 총액 구하기
select sum(salary)
from employees;

-- 전체 사원들의 커미션 합계 구하기
select sum(commission_pct)
from employees;

-- 조회된 행의 특정 컬럼에 대한 평균을 구하기
-- avg(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 값을 가진 행들에 대한 평균값을 반환한다.
select trunc(avg(salary))
from employees;

select trunc(avg(commission_pct), 2)
from employees;

-- 조회된 행의 특정 컬럼에 대한 최대값, 최소값 구하기
-- min(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 가장 작은 값을 반환한다.
-- max(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 가장 큰 값을 반환한다.
select min(salary), max(salary)
from employees;

select min(commission_pct), max(commission_pct)
from employees;

-- group by와 그룹함수를 사용해서 데이터 집계하기
-- 직종별 직원 수를 조회하기
-- 그룹함수와 그룹함수가 아닌 것을 병기할 수는 없지만, group by에 나온 column명은 예외적으로 함께 적을 수 있다.
select job_id, count(*)
from employees
group by job_id;

-- 입사연도별 사원수
SELECT TO_CHAR(hire_date, 'yyyy') as hired_year, COUNT(*) as count
FROM employees
GROUP BY TO_CHAR(hire_date, 'yyyy')
ORDER BY 2 desc;