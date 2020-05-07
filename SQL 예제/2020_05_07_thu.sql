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
              
-- WITH 절