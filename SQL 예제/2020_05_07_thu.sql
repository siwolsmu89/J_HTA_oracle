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