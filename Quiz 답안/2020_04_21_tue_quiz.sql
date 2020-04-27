--1. 모든 직원들의 모든 업무아이디를 조회하기
SELECT DISTINCT job_id
FROM employees;

--2. 급여를 12,000달러 이상 받는 직원의 이름과 급여를 조회하기
SELECT first_name, salary
FROM employees
WHERE salary>=12000;

--3. 직원번호가 176번 직원과 같은 부서에서 근무하는 직원의 아이디와 이름 직종아이디를 조회하기
SELECT E.employee_id, E.first_name, E.job_id
FROM employees E, employees E2
WHERE E2.employee_id = 176
    AND E.department_id = E2.department_id;

--4. 급여를 12,000달러 이상 15,000달러 이하 받는 직원들의 직원 아이디와 이름과 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 12000 AND 15000;

--5. 2005년 1월 1일부터 2000년 6월 30일 사이에 입사한 직원의 아이디, 이름, 업무아이디, 입사일을 조회하기
SELECT employee_id, first_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '2005-01-01' AND '2005-06-30'
ORDER BY hire_date;

--6. 급여가 5,000달러와 12,000달러 사이이고, 부서번호가 20 또는 50인 직원의 이름과 급여를 조회하기
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 5000 and 12000
    AND department_id IN (20, 50)
ORDER BY first_name;

--7. 관리자가 없는 직원의 이름과 업무아이디를 조회하기
SELECT first_name, job_id
FROM employees
WHERE manager_id is null;

--8. 커미션을 받는 모든 직원의 이름과 급여, 커미션을 급여 및 커미션의 내림차순으로 정렬해서 조회하기
SELECT first_name, salary, commission_pct as cms
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary desc, commission_pct desc;

--9. 이름의 2번째 글자가 e인 모든 직원의 이름을 조회하기
SELECT first_name
FROM employees
WHERE first_name like '_e%'
ORDER BY first_name;

--10. 업무아이디가 ST_CLERK 또는 SA_REP이고 급여를 2,500달러, 3,500달러, 7,000달러 받는 모든 직원의 이름과 업무아이디, 급여를 조회하기
SELECT first_name, job_id, salary
FROM employees
WHERE job_id in ('ST_CLERK', 'SA_REP')
    AND salary in (2500, 3500, 7000)
ORDER BY salary;

--11. 모든 직원의 이름과 입사일, 근무 개월 수를 계산하여 조회하기, 근무개월 수는 정수로 반올림하고, 근무개월수를 기준으로 오름차순으로 정렬하기
SELECT first_name, hire_date
    , trunc(months_between(trunc(sysdate), hire_date)) as worked_months
FROM employees
ORDER BY worked_months;

--12. 직원의 이름과 커미션을 조회하기, 커미션을 받지 않는 직원은 '없음'으로 표시하기
SELECT first_name, nvl(to_char(commission_pct, '0.99'),'없음') as cms
FROM employees
ORDER BY cms;

--13. 모든 직원의 이름, 부서번호, 부서이름을 조회하기
SELECT E.first_name, E.department_id AS dept_id, D.department_name
FROM employees E, departments D
ORDER BY E.employee_id;

--14. 80번부서에 소속된 직원의 이름과 업무아이디, 업무제목, 부서이름을 조회하기
SELECT E.first_name AS name
    , J.job_id
    , J.job_title
    , D.department_name AS dept
FROM employees E, departments D, jobs J
WHERE E.job_id = J.job_id
    AND E.department_id = D.department_id
    AND E.department_id = 80;

--15. 커미션을 받는 모든 직원의 이름과 업무아이디, 업무제목, 부서이름, 부서소재지 도시명을 조회하기
SELECT E.first_name, E.employee_id
    , J.job_title
    , D.department_name
    , L.city
FROM employees E, jobs J, departments D, locations L
WHERE E.commission_pct IS NOT NULL
    AND E.department_id = D.department_id
    AND E.job_id = J.job_id
    AND D.location_id = L.location_id
ORDER BY first_name;

--16. 유럽에 소재지를 두고 있는 모든 부서아이디와 부서이름을 조회하기
SELECT D.department_id, D.department_name
FROM departments D, locations L, countries C, regions R
WHERE region_name = 'Europe'
    AND D.location_id = L.location_id
    AND L.country_id = C.country_id
    AND C.region_id = R.region_id
ORDER BY department_id;

--17. 직원의 이름과 소속부서명, 급여, 급여 등급을 조회하기
SELECT E.first_name, D.department_name, E.salary, G.gra as grade
FROM employees E, job_grades G, departments D
WHERE E.salary BETWEEN G.lowest_sal AND G.highest_sal
    AND E.department_id = D.department_id
ORDER BY salary;

--18. 직원의 이름과 소속부서명, 소속부서의 관리자명을 조회하기, 소속부서가 없는 직원은 소속부서명 '없음, 관리자명 '없음'으로 표시하기
SELECT E.first_name, nvl(D.department_name, '없음') as dept, nvl(M.first_name, '없음') AS mgr_name
FROM employees E, departments D, employees M
WHERE E.department_id = D.department_id(+)
    AND D.manager_id = M.employee_id(+)
ORDER BY E.employee_id;

--19. 모든 사원의 이름, 직종아이디, 급여, 소속부서명을 조회하기
SELECT E.first_name, E.job_id, E.salary, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id(+)
ORDER BY employee_id;

--20. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여, 최대급여를 조회하기
SELECT E.first_name, E.job_id, J.job_title, E.salary, J.min_salary, J.max_salary 
FROM employees E, jobs J
WHERE E.job_id = J.job_id
ORDER BY salary desc;

--21. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여와 본인 급여의 차이를 조회하기
SELECT E.first_name, E.job_id, J.job_title, E.salary, (E.salary-J.min_salary) as gap
FROM employees E, jobs J
WHERE E.job_id = J.job_id
ORDER BY gap desc;

--22. 커미션을 받는 모든 사원의 아이디, 부서이름, 소속부서의 소재지(도시명)을 조회하기
SELECT E.employee_id, D.department_name, L.city
FROM employees E, departments D, locations L
WHERE E.commission_pct IS NOT NULL
    AND E.department_id = D.department_id
    AND D.location_id = l.location_id
ORDER BY E.employee_id;

--23. 이름이 A나 a로 시작하는 모든 사원의 이름과 직종, 직종제목, 급여, 소속부서명을 조회하기
SELECT E.first_name, E.job_id, J.job_title, E.salary, D.department_name
FROM employees E, departments D, jobs J
WHERE (E.first_name LIKE 'A%' OR E.first_name LIKE 'a%')
    AND E.department_id = D.department_id
    AND E.job_id = J.job_id
ORDER BY E.first_name;

--24. 30, 60, 90번 부서에 소속되어 있는 사원들 중에서 100에게 보고하는 사원들의 이름, 직종, 급여,
--    급여등급을 조회하기
SELECT E.first_name, E.job_id, E.salary, G.gra as grade 
FROM employees E, departments D, job_grades G
WHERE E.department_id IN (30, 60, 90)
    AND D.manager_id = 100
    AND E.department_id = D.department_id
    AND (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
ORDER BY E.salary;

--25. 80번 부서에 소속된 사원들의 이름, 직종, 직종제목, 급여, 최소급여, 최대급여, 급여등급, 
--    소속부서명을 조회하기
SELECT E.first_name, E.job_id, J.job_title, E.salary, J.min_salary, J.max_salary, G.gra as grade, D.department_name
FROM employees E, jobs J, job_grades G, departments D
WHERE D.department_id = 80
    AND E.department_id = D.department_id
    AND E.job_id = J.job_id
    AND (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
ORDER BY grade desc, salary;

--26. 사원들중에서 자신의 상사보다 먼저 입사한 사원들의 이름, 입사일, 상사의 이름, 상사의 입사일을
--    조회하기
SELECT E.first_name, E.hire_date, M.first_name as manager_name, M.hire_date as manager_hired
FROM employees E, employees M
WHERE E.manager_id = M.employee_id
    AND (0 > E.hire_date - M.hire_date )
ORDER BY E.first_name;

--27. 부서명이 IT인 부서에 근무하는 사원들의 이름과, 직종, 급여, 급여등급, 상사의 이름과 직종을
--    조회하기
SELECT E.first_name, E.job_id, E.salary, G.gra AS grade, M.first_name AS manager_name, M.job_id AS manager_job
FROM employees E, employees M, departments D, job_grades G
WHERE D.department_name = 'IT'
    AND E.manager_id = M.employee_id
    AND E.department_id = D.department_id
    AND (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
ORDER BY E.first_name;

--28. 'ST_CLERK'로 근무하다가 다른 직종으로 변경한 사원의 아이디, 이름, 변경전 부서명,
--     현재 직종, 현재 근무부서명을 조회하기
SELECT E.employee_id, E.first_name
    , OldDept.department_name as old_dept
    , E.job_id as current_job, CurrentDept.department_name as cureent_dept
FROM employees E, job_history H, departments OldDept, departments CurrentDept
WHERE H.job_id = 'ST_CLERK'
    AND E.employee_id = H.employee_id
    AND E.department_id = CurrentDept.department_id
    AND H.department_id = OldDept.department_id
ORDER BY E.first_name;