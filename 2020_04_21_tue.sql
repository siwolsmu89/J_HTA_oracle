-- ºø«¡ ¡∂¿Œ
SELECT E.employee_id, E.first_name, E.manager_id
    , E2.first_name as manager_name
FROM employees E, employees E2
WHERE E2.employee_id = E.manager_id
ORDER BY E.employee_id;