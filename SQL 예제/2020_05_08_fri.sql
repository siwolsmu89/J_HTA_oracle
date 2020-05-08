EXECUTE update_salary(100);

SELECT salary
FROM employees
WHERE employee_id = 100;

SELECT employee_id, first_name, salary, get_annual_salary(employee_id) AS annual
FROM employees
WHERE department_id = 60;

-- �μ����̵�, �μ���, ����� ��ȸ�ϱ�
-- �׷��Լ��� ����� ��ȸ�ϱ�
-- ����� ���� �μ��� ����ϰ� ������ ���������� ����ؾ� ��
SELECT D.department_id, D.department_name, C.cnt
FROM (SELECT department_id, COUNT(*) AS cnt
      FROM employees
      GROUP BY department_id) C, departments D
WHERE D.department_id = C.department_id
ORDER BY department_id;

-- �μ����̵�, �μ���, ����� ��ȸ�ϱ�
-- �Ʊ� ������ �Լ��� Ȱ���Ͽ� ��ȸ�ϱ�
-- ���� ������ ���� �ʾƵ� ����� ���� �μ����� ���
SELECT department_id, department_name, get_emp_count(department_id) AS cnt
FROM departments
ORDER BY department_id;

SELECT get_total_salary
FROM dual;

-- �μ� ���̵�, �μ���, �μ� �Ҽ� �����, �μ� �� ���� ��ȸ�ϱ�
SELECT department_id, department_name
    , get_emp_count(department_id) AS cnt
    , get_dept_total_salary(department_id) AS total_salary
FROM departments
ORDER BY department_id;

-- Ʈ���� ���� ��, insert �۾� �� Ʈ���Ű� �ڵ����� ����ȴ�.
-- sample_book_likes�� ���� �߰��Ǹ� �ش� ���� book_no�� ��ȸ�Ͽ� sample_books���� book_no�� ��ġ�ϴ� book_likes�� 1 �����ȴ�.
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
    (SAMPLE_REVIEW_SEQ.NEXTVAL, '����', 1, SYSDATE, 10007, 'kimmi');

EXECUTE add_book_order('kimmi', 10012, 3);

SELECT get_total_order_amount(10012) AS "TOTAL_AMOUNT(10012)"
FROM dual;

SELECT get_total_order_price(10012) AS "TOTAL_PRICE(10012)"
FROM dual;