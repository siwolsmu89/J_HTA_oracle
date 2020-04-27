-- 1교시

-- 데이터 그룹의 생성
-- group by 절을 사용하면 테이블의 정보를 작은 그룹으로 나누어서 그룹당 데이터를 집계할 수 있다.
-- 소속부서별 직원수를 조회하기 (단, 소속부서가 지정되지 않은 직원은 제외한다)
SELECT department_id, COUNT(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

-- 관리자별 자신이 관리하는 직원 수를 조회하기
-- 단, 관리자가 지정되지 않은 직원은 제외
-- 관리자아이디, 직원수를 조회한다.
SELECT manager_id, COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY manager_id;

-- 부서별 직원 수를 조회하기
-- 단, 부서가 지정되지 않은 사원은 제외한다.
-- 부서이름, 직원수를 조회하기
SELECT D.department_name, COUNT(*)
FROM departments D, employees E
WHERE E.department_id IS NOT NULL
    AND E.department_id = D.department_id
GROUP BY D.department_name;

-- 도시별 직원수를 조회하기
SELECT L.city, COUNT(*)
FROM employees E, departments D, locations L
WHERE E.department_id = D.department_id
    AND D.location_id = L.location_id
GROUP BY L.city;

-- 2교시

-- 도시별, 부서별 직원수를 조회하기
-- 도시명, 부서명, 직원수를 조회한다
SELECT L.city, D.department_name, COUNT(*)
FROM employees E, departments D, locations L
WHERE E.department_id = D.department_id
    AND D.location_id = L.location_id
GROUP BY L.city, D.department_name
ORDER BY L.city, D.department_name;

-- 급여별 사원수를 조회하기
SELECT TRUNC(salary, -3) salary, COUNT(*)
FROM employees
GROUP BY TRUNC(salary, -3)
HAVING COUNT(*) >= 10            -- COUNT(*)값이 10개 이상인 결과만 출력하도록 조건 제한(WHERE에는 그룹함수를 사용할 수 없음)
ORDER BY salary;

-- 3교시

-- 부서별 평균급여 조회하기
-- 부서명과 부서별 평균급여를 조회한다. 평균급여는 소수점이하를 버린다.
SELECT D.department_name, TRUNC(AVG(salary),0) AS average_sal
FROM departments D, employees E
WHERE E.department_id = D.department_id
GROUP BY D.department_name
ORDER BY D.department_name;

-- 그룹함수의 중첩
-- 부서별로 직원수를 조회했을 때 가장 많은 사원수는 몇명인가?
-- SELECT department_id, max(count(*))    이러면 오류가 발생한다. max() 결과는 하나뿐인데 department_id는 여러개이므로
SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id;

-- 급여 등급별 평균 급여와 급여 등급별 사원수를 조회하기
-- 급여등급과 등급별 평균 급여, 사원수를 표시한다.
SELECT G.gra AS grade, TRUNC(AVG(salary)) AS avg_sal, COUNT(*) AS employees
FROM employees E, job_grades G
WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal)
GROUP BY G.gra
ORDER BY 1;

-- 4교시

-- 서브쿼리
-- 이름이 Neena인 사원과 같은 해에 입사한 사원들의 이름, 입사일을 조회하기
SELECT first_name, hire_date
FROM employees 
WHERE to_char(hire_date, 'yyyy') IN (SELECT to_char(hire_date, 'yyyy')
                                    FROM employees
                                    WHERE first_name = 'Neena')
ORDER BY hire_date;

-- Stephen과 같은 직종의 일을 하는 직원들의 아이디와 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE job_id IN (SELECT job_id
                 FROM employees
                 WHERE first_name = 'Stephen')
ORDER BY employee_id;

-- Mozhe와 같은 직종의 일을 하고,
-- Mozhe의 급여보다 급여를 많이 받는 직원의 아이디와 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE job_id IN (SELECT job_id
                 FROM employees
                 WHERE first_name = 'Mozhe')
    AND salary > (SELECT salary
                  FROM employees
                  WHERE first_name = 'Mozhe')
ORDER BY employee_id;

-- 전체 직원의 평균급여보다 적은 급여를 받는 직원들의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees)
ORDER BY 1;

-- 가장 적은 급여를 받는 직원들의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees)
ORDER BY 1;

-- 부서별 사원 수를 조회했을 때 가장 많은 부서의 아이디와 사원 수를 조회하기
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM employees
                   GROUP BY department_id);

-- 5교시

-- WITH 절을 사용해서 중복 실행되는 쿼리작업을 한 번만 실행되게 할 수 있다.
-- 쿼리의 실행 성능을 향상시킨다.
WITH deptCnt
AS (SELECT department_id, COUNT(*) cnt
    FROM employees
    GROUP BY department_id)
SELECT department_id, cnt
FROM deptCnt
WHERE cnt = (SELECT MAX(cnt)
             FROM deptCnt);
             
-- 다중행 서브쿼리
-- 50번 부서에 근무했던 적이 있는 사원의 아이디, 이름, 직종, 소속부서아이디를 조회하기
SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE employee_id in (SELECT employee_id
                     FROM job_history
                     WHERE department_id = 50);
                     
-- 다중행 서브쿼리 대신 조인을 사용해 조회하기
SELECT E.employee_id, E.first_name, E.job_id, E.department_id
FROM employees E, job_history H
WHERE E.employee_id = H.employee_id
    and H.department_id = 50;
    
-- Seattle에 위치하고 있는 부서의 관리자 직원 아이디, 이름을 조회하기
-- 좋은 방법은 아니다. 이런 식으로 쓸 수 있다는 것만 기억하자.
SELECT employee_id, first_name
FROM employees
WHERE employee_id IN (SELECT manager_id
                      FROM departments
                      WHERE location_id = (SELECT location_id
                                           FROM locations
                                           WHERE city = 'Seattle'));

-- 테이블 조인으로 조회하기                                           
SELECT E.employee_id, E.first_name
FROM employees E, departments D, locations L
WHERE E.employee_id = D.manager_id
    AND D.location_id = L.location_id
    AND L.city = 'Seattle';
