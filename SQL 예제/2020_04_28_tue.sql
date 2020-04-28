-- å�� ���� ����� ������ ��� ���̺�
CREATE TABLE sample_book_reviews (
    review_no               NUMBER(7,0)     CONSTRAINT review_no_pk         PRIMARY KEY,
    review_content          VARCHAR2(2000)  CONSTRAINT review_content_nn    NOT NULL, 
    review_point            NUMBER(1,0)     CONSTRAINT review_point_ck      CHECK (review_point >=0 AND review_point <= 5),
    review_registered_date  DATE                                            DEFAULT SYSDATE,
    book_no                 NUMBER(7,0)     CONSTRAINT review_bookno_fk     REFERENCES sample_books (book_no),
    user_id                 VARCHAR2(50)    CONSTRAINT reivew_userid_fk     REFERENCES sample_book_users (user_id),
    CONSTRAINT reviews_uk UNIQUE (book_no, user_id)         -- ���� å�� ���� ����� �������� �� ���� �ۼ��� �� �ֵ��� ����
);

CREATE SEQUENCE sample_review_seq NOCACHE;

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '���� �������̾����ϴ�', 5, 10016, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '���� �������̾����ϴ�', 5, 10016, 'kimkim');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '��ȭ�� �������� �ߴٴ� ���� �ϱ��� �ʾҽ��ϴ�', 5, 10021, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '�������� �޵� ���� �ʰ� �� ����ϴ�', 2, 11021, 'kimkim');

-- ������� Ȯ��
SELECT TRUNC(AVG(review_point),1) as avg_point
FROM sample_book_reviews
WHERE book_no = 10011;

UPDATE sample_books
    SET 
        book_point = (SELECT TRUNC(AVG(review_point),1)
                        FROM sample_book_reviews
                        WHERE book_no = 10011)
    WHERE book_no = 10011;

-- ��õ���� ���̺�
-- ���� ���� å�� ���ƿ� �ߴ��� Ȯ��
CREATE TABLE sample_book_likes (
    book_no NUMBER(7,0) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    CONSTRAINT likes_bookno_fk FOREIGN KEY (book_no) 
        REFERENCES sample_books (book_no),
    CONSTRAINT likes_userid_fk FOREIGN KEY (user_id) 
        REFERENCES sample_book_users (user_id),
    CONSTRAINT likes_uk UNIQUE (book_no, user_id)
);

CREATE OR REPLACE VIEW emp_salary_grade_view
		AS SELECT E.employee_id, E.first_name, E.salary, G.gra
		   FROM employees E, job_grades G
		   WHERE (E.salary BETWEEN G.lowest_sal AND G.highest_sal);
    
-- �並 �̿��ؼ� �����ϰ� ���ϴ� �����͸� ��ȸ�ϱ�
-- SELECT�� �ۼ� �� ���̺�� �Ȱ��� ������� ����� �� ������, ���������� �����Ͱ� ����� ���� �ƴϴ�.
-- �ַ� ������ ���ǹ��� �����ϰ� ����ϱ� ���� ����Ѵ�.
-- �並 ����� INSERT, UPDATE, DELETE �۾��� ���� �ʴ´�. (���� ��� ���������� X, ���� ��� ���ʿ� INSERT, UPDATE, DELETE�� �Ұ���)
SELECT *        
FROM emp_salary_grade_view
WHERE gra = 'A';

CREATE OR REPLACE VIEW emp_salary_view
		AS SELECT employee_id, first_name, salary,
			  salary*4*12 + salary*nvl(commission_pct, 0)*4*12 AS annual_salary
		   FROM employees;
           
-- �ζ��κ� ����ϱ�
-- ��û ���� ���ȴ�.
SELECT id, name, salary
FROM (SELECT employee_id AS id, first_name || ' ' || last_name AS name, salary, department_id AS deptid 
      FROM employees)
WHERE deptid = 60;

-- ��ü ����� �߿��� �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �޿��� ���� �޴� �����
-- ��� ���̵�, �̸�, �޿�, �μ����̵�, �μ��� ��ձ޿��� ��ȸ�ϱ�
SELECT E.employee_id, E.first_name, E.salary, D.dept_id, D.avg_sal
FROM employees E, (SELECT department_id AS dept_id, TRUNC(AVG(salary)) AS avg_sal
                   FROM employees
                   WHERE department_id IS NOT NULL
                   GROUP BY department_id) D
WHERE E.department_id = D.dept_id
    AND E.salary < D.avg_sal
ORDER BY E.employee_id;

-- �μ����̵�, �μ���, �μ��� �����, ���ø��� ����ϱ�
SELECT D.department_id, D.department_name, N.dept_people, L.city
FROM departments D, locations L, (SELECT department_id, COUNT(*) AS dept_people
                                  FROM employees
                                  GROUP BY department_id
                                  ) N
WHERE D.location_id = L.location_id
    AND N.department_id = D.department_id
ORDER BY N.dept_people DESC, L.city, D.department_name;



SELECT review_no
						, review_content 
						, review_point 
						, review_registered_date 
						, book_no 
						, user_id 
					FROM sample_book_reviews 
					WHERE user_id = 'kimmi';