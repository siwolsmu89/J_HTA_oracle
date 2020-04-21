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