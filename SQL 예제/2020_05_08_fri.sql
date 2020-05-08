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

SELECT get_total_salary
FROM dual;

-- 부서 아이디, 부서명, 부서 소속 사원수, 부서 총 연봉 조회하기
SELECT department_id, department_name
    , get_emp_count(department_id) AS cnt
    , get_dept_total_salary(department_id) AS total_salary
FROM departments
ORDER BY department_id;

-- 트리거 생성 후, insert 작업 시 트리거가 자동으로 실행된다.
-- sample_book_likes에 행이 추가되면 해당 행의 book_no를 조회하여 sample_books에서 book_no에 일치하는 book_likes가 1 증가된다.
INSERT INTO sample_book_likes
    (book_no, user_id)
VALUES
    (10011, 'kimmi');
    
INSERT INTO sample_book_orders
    (order_no, user_id, book_no, order_price, order_amount, order_registered_date)
VALUES
    (SAMPLE_ORDER_SEQ.NEXTVAL, 'kimmi', 10012, 13500, 10, SYSDATE);
    
INSERT INTO sample_book_reviews
    (review_no, review_content, review_point, review_registered_date, book_no, user_id)
VALUES
    (SAMPLE_REVIEW_SEQ.NEXTVAL, '노잼', 1, SYSDATE, 10007, 'kimmi');

EXECUTE add_book_order('kimmi', 10012, 3);

SELECT get_total_order_amount(10012) AS "TOTAL_AMOUNT(10012)"
FROM dual;

SELECT get_total_order_price(10012) AS "TOTAL_PRICE(10012)"
FROM dual;