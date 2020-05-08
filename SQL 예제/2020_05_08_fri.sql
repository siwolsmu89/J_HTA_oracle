EXECUTE update_salary(100);

SELECT salary
FROM employees
WHERE employee_id = 100;

SELECT employee_id, first_name, salary, get_annual_salary(employee_id) AS annual
FROM employees
WHERE department_id = 60;

-- 부서아이디, 부서명, 사원수 조회하기
-- 그룹함수를 사용해 조회하기
-- 사원이 없는 부서를 출력하고 싶으면 포괄조인을 사용해야 함
SELECT D.department_id, D.department_name, C.cnt
FROM (SELECT department_id, COUNT(*) AS cnt
      FROM employees
      GROUP BY department_id) C, departments D
WHERE D.department_id = C.department_id
ORDER BY department_id;

-- 부서아이디, 부서명, 사원수 조회하기
-- 아까 생성한 함수를 활용하여 조회하기
-- 포괄 조인을 하지 않아도 사원이 없는 부서까지 출력
SELECT department_id, department_name, get_emp_count(department_id) AS cnt
FROM departments
ORDER BY department_id;