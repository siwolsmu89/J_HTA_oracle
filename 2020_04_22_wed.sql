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