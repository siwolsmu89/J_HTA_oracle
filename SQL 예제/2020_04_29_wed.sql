SELECT B.book_no, count(R.review_no)
FROM sample_books B, sample_book_reviews R
WHERE B.book_no = R.book_no
GROUP BY B.book_no;

SELECT DISTINCT *
FROM sample_books B, (SELECT B.book_no, count(R.review_no) AS review_count
                      FROM sample_books B, sample_book_reviews R
                      WHERE B.book_no = R.book_no
                      GROUP BY B.book_no) C
WHERE B.book_no = C.book_no;


-- TOP-N �м�
-- Ư�� �������� ���� ���̺��� ������ �ζ��� �並 �����ϰ�, �� ���� rownum�� Ȯ��
-- rownum <= n : ������ n��° ����� ������
SELECT ROWNUM, salary, first_name
FROM (SELECT salary, first_name
      FROM employees
      WHERE department_id = 50
      ORDER BY salary DESC)
WHERE ROWNUM<=3;

-- �μ��� ������� ������� �� ������� ���� ���� �μ� 3���� ��ȸ�ϱ�
SELECT ROWNUM ranking, department_id, employee_count
FROM (SELECT department_id, count(*) AS employee_count
      FROM employees
      GROUP BY department_id
      ORDER BY employee_count DESC)
WHERE ROWNUM <= 3;

-- �μ��� ������� ������� �� ������� ���� ���� �μ� 3���� ��ȸ�ϱ�
-- �μ����̵�, �μ���, ������� ��µǾ�� ��
SELECT B.ranking, A.department_id, A.department_name, B.employee_count
FROM departments A, (SELECT ROWNUM ranking, department_id, employee_count
                    FROM (SELECT department_id, count(*) AS employee_count
                          FROM employees
                          GROUP BY department_id
                          ORDER BY employee_count DESC)
                    WHERE ROWNUM <= 3) B
WHERE A.department_id = B.department_id;

-- ������ ���� ��� å 3���� ��ȸ�ϱ�
-- ����, ����, ������ ��µǾ�� ��
SELECT ROWNUM, book_no, book_title, book_price
FROM (SELECT *
      FROM sample_books
      ORDER BY book_price DESC)
WHERE ROWNUM <=3;

-- �ֱ� 1���� �̳��� �� å�� ������ ��� ã��
SELECT *
FROM sample_book_orders
WHERE (SYSDATE - order_registered_date) < 7;

SELECT *
FROM sample_book_users U, (SELECT *
                            FROM sample_book_orders
                            WHERE (SYSDATE - order_registered_date) < 7) RO
WHERE U.user_id = RO.user_id;

-- ������ ���� ��� å 3���� ��ȸ���� ��
-- �ֱ� 1���� �̳��� �� å�� �� ����ڸ� ��ȸ�ϱ�
-- ����� ���̵�, ����ڸ�, å����, ���Ű���, ���ż���, ���ų�¥�� ��µǾ�� ��
SELECT U.user_id, U.user_name, EX_books.book_title, O.order_price, O.order_amount, O.order_registered_date
FROM sample_book_users U, sample_book_orders O, (SELECT ROWNUM, book_no, book_title, book_price
                                                 FROM (SELECT book_no, book_title, book_price
                                                       FROM sample_books
                                                       ORDER BY book_price DESC)
                                                 WHERE ROWNUM <= 3) EX_books
WHERE U.user_id = O.user_id
    AND O.book_no = EX_books.book_no
    AND (O.order_registered_date > SYSDATE -7);
    
-- ���ֹ����� ���� ���� �� ��ŷ 10������ ã�Ƽ� ����ǰ ������(����ó) � �ʿ�

-- ����ں� �����Ѿ��� ���� ���� ����� 1�� ã�Ƴ���
-- ���̵�, �̸�, �ѱ��űݾ��� ��ȸ�ϱ�
SELECT U.user_id, U.user_name, Top_user.total_price
FROM sample_book_users U, (SELECT user_id, total_price
                           FROM (SELECT U.user_id, SUM(O.order_price*O.order_amount) AS total_price
                                 FROM sample_book_orders O, sample_book_users U
                                 WHERE O.user_id = U.user_id
                                 GROUP BY U.user_id
                                 ORDER BY total_price DESC)
                           WHERE ROWNUM = 1) Top_user
WHERE U.user_id = Top_user.user_id;

-- �м��Լ� ����ϱ�
-- �޿��� �������� ������ ������ �ο��Ѵ�.
SELECT ROW_NUMBER() OVER(ORDER BY salary DESC) AS sal_rank, salary, first_name
FROM employees;

-- �޿��� �������� �������� �����ؼ� ������ �ο����� �� �޿������� 11~20���� �ش��ϴ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT sal_rank, employee_id, first_name, salary
FROM (SELECT ROW_NUMBER() OVER(ORDER BY salary DESC) AS sal_rank, employee_id, first_name, salary
      FROM employees)
WHERE (sal_rank BETWEEN 11 AND 20);

-- �μ����� �޿��� �������� �������� �����ؼ� ������ �ο��ϱ�
SELECT department_id, ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept, salary, first_name
FROM employees;

-- �μ��� �޿� 1� ��ȸ�ϱ�
SELECT department_id, first_name, salary
FROM (SELECT department_id, ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept
            , salary, first_name
      FROM employees)
WHERE rank_in_dept = 1;

-- ROW_NUMBER(), RANK(), DENSE_RANK() ���� ������ �˾ƺ���
SELECT ROW_NUMBER() OVER(ORDER BY salary DESC) row_number,
       RANK()       OVER(ORDER BY salary DESC) rank,
       DENSE_RANK() OVER(ORDER BY salary DESC) dense_rank,
       salary
FROM employees;

-- ROW_NUMBER() OVER()�� Ȱ���� �����͸� Ư�� �÷��� �������� �������� ������ ��ȸ�ϱ�
-- employee_id������ 10���� ��ȸ�ϱ�
SELECT *
FROM (SELECT ROW_NUMBER() OVER(ORDER BY employee_id ASC) num, employee_id, first_name
      FROM employees)
WHERE (num BETWEEN 1 AND 10);

SELECT *
FROM (SELECT ROW_NUMBER() OVER(ORDER BY employee_id ASC) num, employee_id, first_name
      FROM employees)
WHERE (num BETWEEN 11 AND 20);

SELECT FIRST_VALUE(salary) OVER(PARTITION BY department_id ORDER BY salary DESC) AS largest_sal
        , salary, first_name
FROM employees;

-- 
SELECT sample_order_seq.NEXTVAL FROM dual;

SELECT sample_order_seq.CURRVAL FROM dual;

SELECT employee_id, ROWID
FROM employees;