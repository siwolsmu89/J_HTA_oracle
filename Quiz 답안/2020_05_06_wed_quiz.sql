--1. 사원테이블에서 급여가 5000이상 12000이하인 사원의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 12000
ORDER BY employee_id;

--2. 사원들이 소속된 부서의 부서명을 중복없이 조회하기
SELECT DISTINCT department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id
ORDER BY department_name;

--3. 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
SELECT employee_id, first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '2007';

--4. 급여가 5000이상 12000이하이고, 20번과 50번 부서에 소속된 사원의 아이디, 이름, 급여, 소속부서명을 조회하기
SELECT E.employee_id, E.first_name, E.salary, D.department_name
FROM employees E, departments D
WHERE (E.salary BETWEEN 5000 AND 12000)
    AND E.department_id = D.department_id
    AND E.department_id IN (20, 50)
ORDER BY employee_id;

--5. 100번 직원에게 보고하는 사원의 아이디, 이름, 급여, 급여등급을 조회하기
SELECT E.employee_id, E.first_name, E.salary, G.gra
FROM employees E, job_grades G, employees M
WHERE E.manager_id = M.employee_id
    AND E.manager_id = 100
    AND (E.salary BETWEEN G.lowest_sal AND g.highest_sal)
ORDER BY employee_id;

--6. 80번 부서에 소속되어 있고, 80번 부서의 평균급여보다 적은 급여를 받는 사원의 아이디, 이름, 급여를 조회하기
SELECT E.employee_id, E.first_name, E.salary
FROM employees E
WHERE E.department_id = 80
    AND E.salary < (SELECT AVG(salary)
                    FROM employees
                    WHERE department_id = 80)
ORDER BY E.employee_id;

--7. 50번 부서에 소속된 사원 중에서 해당 직종의 최소급여보다 2배 이상의 급여를 받는 사원의 아이디, 이름, 급여를 조회하기
SELECT E.employee_id, E.first_name, E.salary
FROM employees E
WHERE E.salary >= 2* (SELECT MIN(salary)
                      FROM employees
                      WHERE job_id=E.job_id)
    AND E.department_id = 50;
    
--8. 사원들 중에서 자신의 상사보다 먼저 입사한 사원의 아이디, 이름, 입사일, 상사의 이름, 상사의 입사일을 조회하기
SELECT E.employee_id, E.first_name, E.hire_date, M.first_name as manager_name, M.hire_date as manager_hire_date
FROM employees E, employees M
WHERE E.manager_id = M.employee_id
    AND E.hire_date < M.hire_date
ORDER BY E.employee_id;
    
--9. Steven King과 같은 부서에서 근무하는 사원의 아이디와 이름을 조회하기
SELECT E.employee_id, E.first_name
FROM employees E, (SELECT department_id
                   FROM employees
                   WHERE first_name = 'Steven'
                    AND last_name = 'King') D
WHERE E.department_id = D.department_id;

--10. 관리자별 사원수를 조회하기, 관리자 아이디, 사원수를 출력한다. 관리자 아이디 오름차순으로 정렬
SELECT M.employee_id as manager_id, C.count
FROM employees M, (SELECT manager_id, count(*) as count
                   FROM employees
                   GROUP BY manager_id) C
WHERE M.employee_id = C.manager_id
ORDER BY manager_id;                   

--11. 커미션을 받는 사원의 아이디, 이름, 급여, 커미션을 조회하기
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY employee_id;

--12. 급여를 가장 많이 받는 사원 3명의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM (SELECT employee_id, first_name, salary
      FROM employees
      ORDER BY salary DESC)
WHERE ROWNUM <= 3;

--13. 'Ismael'과 같은 해에 입사했고, 같은 부서에 근무하는 사원의 아이디, 이름, 입사일을 조회하기
SELECT E.employee_id, E.first_name, E.hire_date
FROM employees E, (SELECT department_id, TO_CHAR(hire_date, 'yyyy') as hire_year
                   FROM employees
                   WHERE first_name = 'Ismael') Ism
WHERE E.department_id = Ism.department_id
    AND TO_CHAR(E.hire_date, 'yyyy') = Ism.hire_year;

--14. 'Renske'에게 보고받는 사원의 아이디와 이름, 급여, 급여 등급을 조회하기
SELECT M.employee_id, M.first_name, M.salary, G.gra
FROM employees M, employees E, job_grades G
WHERE E.manager_id = M.employee_id
    AND E.first_name = 'Renske'
    AND (M.salary BETWEEN G.lowest_sal AND G.highest_sal);

--15. 사원테이블의 급여를 기준으로 급여등급을 조회했을 때, 급여등급별 사원수를 조회하기
SELECT G.gra, count(*)
FROM employees E, job_grades G
WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
GROUP BY G.gra
ORDER BY G.gra;

--16. 입사자가 가장 적은 연도와 그 해에 입사한 사원 수를 조회하기
SELECT hire_year, count
FROM (SELECT TO_CHAR(hire_date, 'yyyy') as hire_year, count(*) as count
      FROM employees
      GROUP BY TO_CHAR(hire_date, 'yyyy')
      ORDER BY TO_CHAR(hire_date, 'yyyy'))
WHERE ROWNUM = 1;

--17. 관리자별 사원 수를 조회했을 때 관리하는 사원 수가 10명이 넘는 관리자의 아이디와 사원수를 조회하기
SELECT manager_id, count
FROM (SELECT M.employee_id as manager_id, count(*) as count
      FROM employees M, employees E
      WHERE E.manager_id = M.employee_id
      GROUP BY M.employee_id)
WHERE count >= 10;

--18. 'Europe'지역에서 근무중인 사원의 아이디, 이름, 소속부서명, 소재지 도시명, 나라이름을 조회하기
SELECT E.employee_id, E.first_name, D.department_name, L.city, C.country_name
FROM employees E, departments D, locations L, countries C, regions R
WHERE E.department_id = D.department_id
    AND D.location_id = L.location_id
    AND L.country_id = C.country_id
    AND C.region_id = R.region_id
    AND R.region_name = 'Europe'
ORDER BY employee_id;

--19. 전체 사원의 사원아이디, 이름, 급여, 소속부서아이디, 소속부서명, 상사의 이름을 조회하기
SELECT E.employee_id, E.first_name, E.salary, E.department_id, D.department_name, M.first_name as manager_name
FROM employees E, departments D, employees M
WHERE E.department_id = D.department_id
    AND E.manager_id = M.employee_id
UNION
SELECT E.employee_id, E.first_name, E.salary, E.department_id, D.department_name, '(no manager)'
FROM employees E, departments D
WHERE E.department_id = D.department_id
    AND E.manager_id IS NULL
ORDER BY employee_id;

--20. 50번 부서에 근무중인 사원들의 급여를 500달러 인상시키기
UPDATE employees
    SET
        salary = 500 + salary
WHERE department_id = 50;

--21. 사원의 아이디, 이름, 급여, 보너스를 조회하기
-- 보너스는 20000달러 이상은 급여의 10%, 10000달러 이상은 급여의 15%, 그 외는 급여의 20%를 지겁한다.
SELECT employee_id, first_name, salary
    , CASE 
        WHEN salary >= 20000 THEN salary*0.1
        WHEN salary >= 10000 THEN salary*0.15
        ELSE salary*0.2
      END as bonus
FROM employees
ORDER BY employee_id;

-- 22. 소속부서에서 입사일이 늦지만 더 많은 급여를 받는 사원의 이름, 입사일, 소속부서명, 급여를 조회하기
-- 한 명이라도 자기보다 입사일이 빠르고 급여를 적게 받는 사원이 있으면 조건을 만족시킨다.
SELECT DISTINCT E.first_name, E.hire_date, D.department_name, E.salary
FROM employees A, employees E, departments D
WHERE A.department_id = E.department_id
    AND (A.hire_date < E.hire_date AND A.salary < E.salary)
    AND E.department_id = D.department_id
ORDER BY D.department_name;

--23. 부서별 평균급여를 조회했을 때 부서별 평균급여가 10000달러 이하인 부서의 아이디, 부서명, 평균급여를 조회하기
-- 평균급여는 소수점 1자리까지만 표시한다
SELECT D.department_id, D.department_name, Davg.avg_sal
FROM departments D, (SELECT department_id, TRUNC(AVG(salary), 1) AS avg_sal
                     FROM employees
                     GROUP BY department_id) Davg 
WHERE Davg.avg_sal <= 10000
    AND D.department_id = Davg.department_id
ORDER BY D.department_id;

--24. 사원들 중에서 자신이 종사하고 있는 직종의 최대급여와 동일한 급여를 받는 사원의 아이디, 이름, 급여를 조회하기
SELECT E.employee_id, E.first_name, E.salary, E.job_id
FROM employees E, (SELECT job_id, MAX(salary) as max_sal
                   FROM employees
                   GROUP BY job_id) M
WHERE E.salary = M.max_sal
    AND E.job_id = M.job_id
ORDER BY E.employee_id;

--25. 분석함수를 사용해서 사원들을 급여순으로 정렬하고, 순번을 부여했을 때 6~10번째 속하는 순번,
-- 사원의 아이디, 이름, 급여, 급여등급을 조회하기
SELECT E.RN, E.employee_id, E.first_name, E.salary, G.gra
FROM (SELECT ROW_NUMBER() OVER(ORDER BY salary DESC) AS RN, first_name, salary, employee_id
      FROM employees) E, job_grades G
WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
    AND (E.RN BETWEEN 6 AND 10)
ORDER BY E.RN;
