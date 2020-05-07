-- 다중열 서브쿼리 사용하기
-- 'Karen'과 같은 직종에 종사하고, 같은 부서에 소속되어 있는 사원의 아이디, 이름, 직종, 부서아이디 조회하기
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE (job_id, department_id) IN (SELECT job_id, department_id
                                  FROM employees
                                  WHERE first_name = 'Karen');
                                  
-- 부서별 최고 급여를 받는 사원의 아이디, 이름, 급여, 부서아이디를 조회하기
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE (department_id, salary) IN ((SELECT department_id, MAX(salary)
                                   FROM employees
                                   WHERE department_id IS NOT NULL
                                   GROUP BY department_id))
ORDER BY employee_id;

-- 스칼라 서브쿼리 사용하기
-- 전체 평균보다 적은 급여를 받는 직원의 아이디, 이름, 급여, 평균급여, 평균급여와의 차이를 조회하기
SELECT employee_id, first_name, salary
    , TRUNC((SELECT AVG(salary) FROM employees)) AS avg_sal
    , TRUNC((SELECT AVG(salary) FROM employees)) - salary AS gap
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees);
                
-- 20000달러 이상은 전체 평균급여의 10%를 보너스로, 10000달러 이상은 15% 그 외는 20%를 보너스로 지급하려고 한다.
-- 아이디, 이름, 급여, 보너스 조회하기
SELECT employee_id, first_name, salary
    , CASE
        WHEN salary>=20000 THEN TRUNC((SELECT AVG(salary) FROM employees) *0.1)
        WHEN salary>=10000 THEN TRUNC((SELECT AVG(salary) FROM employees) *0.15)
        ELSE TRUNC((SELECT AVG(salary) FROM employees) *0.2)
      END AS bonus
FROM employees;

-- 전체 평균급여보다 급여를 많이 받는 사원의 이름, 급여를 조회하기
-- 상호연관서브쿼리를 사용하지 않은 경우
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) 
                FROM employees);
                
-- 자신이 소속된 소속부서의 평균급여보다 많은 급여를 받는 사원의 이름, 급여를 조회하기
-- 상호연관쿼리를 사용하는 경우
SELECT outterr.first_name, outterr.salary
FROM employees outterr
WHERE salary > (SELECT AVG(innerr.salary)
                FROM employees innerr
                WHERE innerr.department_id = outterr.department_id);
-- 외부 SQL이 먼저 실행되어 행을 가져온다.(후보행)
-- 후보행의 행마다 department_id 값을 가져와서 서브쿼리를 실행한다.
-- 서브쿼리의 결과값을 사용해 후보행을 검증한다.
-- 후보행이 남지 않을 때까지 반복한다.

-- 부서아이디, 부서명, 해당부서의 사원수를 조회하기
-- 상호연관서브쿼리와 실행방식이 비슷하지만 이런 형태를 상호연관서브쿼리라고는 부르지 않는다. (이건 스칼라 서브쿼리의 한 종류일 뿐이다)
-- 상호연관서브쿼리는 where절에 쓰일 때만 상호연관서브쿼리라고 한다.
SELECT D.department_id, D.department_name
    , (SELECT count(*)
       FROM employees I
       WHERE I.department_id = D.department_id) AS count
FROM departments D;

-- 부하직원을 가지고 있는 직원을 조회하기
-- EXISTS 연산자를 사용하지 않는 경우
-- 상호연관 서브쿼리(인 동시에 스칼라 서브쿼리)를 활용하기
-- 1명이 발견되더라도 끝까지 조회하고 반드시 몇 명인지 먼저 세어야 한다는 단점 존재
SELECT *
FROM employees M
WHERE (SELECT count(*)
        FROM employees E
        WHERE E.manager_id = M.employee_id) > 0;
        
-- EXISTS 연산자 사용하기
-- 부하직원을 가지고 있는 직원을 조회하기
SELECT *
FROM employees M
WHERE EXISTS (SELECT 1
              FROM employees E
              WHERE E.manager_id = M.employee_id);
              
-- WITH 절 사용하기
-- 전체 부서의 평균 총 급여보다 총 급여가 많은 부서를 찾기
WITH 
dept_costs AS
(SELECT D.department_name, SUM(E.salary) AS dept_total
 FROM employees E, departments D
 WHERE E.department_id = D.department_id
 GROUP BY D.department_name),
avg_cost AS
(SELECT SUM(dept_total)/count(*) AS dept_avg
 FROM dept_costs)
SELECT *
FROM dept_costs
WHERE dept_total > (select dept_avg
                    FROM avg_cost)
ORDER BY department_name;

-- 118번 사원의 상사롤 조회하기
SELECT employee_id, first_name, manager_id
FROM employees
START WITH employee_id = 118
CONNECT BY PRIOR manager_id = employee_id;

-- 101번 직원의 모든 부하 조회하기
-- LEVEL과 LPAD를 사용하여 직관적으로 depth를 표현하기
SELECT LPAD(employee_id, LEVEL*4, ' ') as employee_id, first_name, manager_id
FROM employees
START WITH employee_id = 101
CONNECT BY PRIOR employee_id = manager_id;

-- 100번 직원의 모든 부하 조회하기
SELECT LPAD(first_name, LENGTH(first_name) + level*5-5, ' ')
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id;

-- 100의 모든 부하직원 조회, Neena는 제외
-- CONNECT BY에서 설정 -> Neena의 부하들까지 함께 제외된다.
SELECT LPAD(first_name, LENGTH(first_name) + level*5-5, ' ')
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id
    AND first_name != 'Neena';
    
-- 100의 직속 부하들만 조회하기
-- LEVEL 2까지만 표시하기
SELECT LPAD(first_name, LENGTH(first_name) + level*5-5, ' ')
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id
    AND LEVEL<=2;
    
-- 2020/01/01 ~ 2020/12/31 날짜 만들기
SELECT TO_DATE('2020/01/01', 'yyyy/mm/dd') + LEVEL -1
FROM dual
CONNECT BY LEVEL <= 366;

-- 2003년도 월별 입사자수 조회하기
SELECT TO_CHAR(hire_date, 'yyyy-mm'), count(*)
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '2003'
GROUP BY TO_CHAR(hire_date, 'yyyy-mm')
ORDER BY 1;

-- 입사자가 없는 달도 표시하기
WITH
months AS
(SELECT '2003-' ||
    CASE
        WHEN LEVEL < 10 THEN '0' || LEVEL
        ELSE to_char(LEVEL)
    END AS mon
 FROM dual
 CONNECT BY LEVEL <= 12),
month_emp_count AS
(SELECT TO_CHAR(hire_date, 'yyyy-mm') AS mon, count(*) AS cnt
 FROM employees
 WHERE TO_CHAR(hire_date, 'yyyy') = '2003'
 GROUP BY TO_CHAR(hire_date, 'yyyy-mm'))
SELECT M.mon, NVL(C.cnt, 0) AS cnt
FROM months M, month_emp_count C
WHERE M.mon = C.mon(+)
ORDER BY M.mon;