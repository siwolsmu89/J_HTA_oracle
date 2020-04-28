-- 책에 대한 리뷰와 평점을 담는 테이블
CREATE TABLE sample_book_reviews (
    review_no               NUMBER(7,0)     CONSTRAINT review_no_pk         PRIMARY KEY,
    review_content          VARCHAR2(2000)  CONSTRAINT review_content_nn    NOT NULL, 
    review_point            NUMBER(1,0)     CONSTRAINT review_point_ck      CHECK (review_point >=0 AND review_point <= 5),
    review_registered_date  DATE                                            DEFAULT SYSDATE,
    book_no                 NUMBER(7,0)     CONSTRAINT review_bookno_fk     REFERENCES sample_books (book_no),
    user_id                 VARCHAR2(50)    CONSTRAINT reivew_userid_fk     REFERENCES sample_book_users (user_id),
    CONSTRAINT reviews_uk UNIQUE (book_no, user_id)         -- 같은 책에 대한 리뷰는 유저별로 한 번만 작성할 수 있도록 설정
);

CREATE SEQUENCE sample_review_seq NOCACHE;

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '아주 감동적이었습니다', 5, 10016, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '아주 감동적이었습니다', 5, 10016, 'kimkim');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '실화를 바탕으로 했다는 것이 믿기지 않았습니다', 5, 10021, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '오랜만에 꿈도 꾸지 않고 잘 잤습니다', 2, 11021, 'kimkim');

-- 평점평균 확인
SELECT TRUNC(AVG(review_point),1) as avg_point
FROM sample_book_reviews
WHERE book_no = 10011;

UPDATE sample_books
    SET 
        book_point = (SELECT TRUNC(AVG(review_point),1)
                        FROM sample_book_reviews
                        WHERE book_no = 10011)
    WHERE book_no = 10011;

-- 추천도서 테이블
-- 누가 무슨 책을 좋아요 했는지 확인
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
    
-- 뷰를 이용해서 간편하게 원하는 데이터를 조회하기
-- SELECT문 작성 시 테이블과 똑같은 방법으로 사용할 수 있지만, 물리적으로 데이터가 저장된 것은 아니다.
-- 주로 복잡한 질의문을 간단하게 사용하기 위해 사용한다.
-- 뷰를 사용해 INSERT, UPDATE, DELETE 작업은 하지 않는다. (단일 뷰는 가능하지만 X, 복합 뷰는 애초에 INSERT, UPDATE, DELETE가 불가능)
SELECT *        
FROM emp_salary_grade_view
WHERE gra = 'A';

CREATE OR REPLACE VIEW emp_salary_view
		AS SELECT employee_id, first_name, salary,
			  salary*4*12 + salary*nvl(commission_pct, 0)*4*12 AS annual_salary
		   FROM employees;
           
-- 인라인뷰 사용하기
-- 엄청 많이 사용된다.
SELECT id, name, salary
FROM (SELECT employee_id AS id, first_name || ' ' || last_name AS name, salary, department_id AS deptid 
      FROM employees)
WHERE deptid = 60;

-- 전체 사원들 중에서 자신이 소속된 부서의 평균급여보다 급여를 적게 받는 사원의
-- 사원 아이디, 이름, 급여, 부서아이디, 부서의 평균급여를 조회하기
SELECT E.employee_id, E.first_name, E.salary, D.dept_id, D.avg_sal
FROM employees E, (SELECT department_id AS dept_id, TRUNC(AVG(salary)) AS avg_sal
                   FROM employees
                   WHERE department_id IS NOT NULL
                   GROUP BY department_id) D
WHERE E.department_id = D.dept_id
    AND E.salary < D.avg_sal
ORDER BY E.employee_id;

-- 부서아이디, 부서명, 부서별 사원수, 도시명을 출력하기
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