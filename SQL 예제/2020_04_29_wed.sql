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