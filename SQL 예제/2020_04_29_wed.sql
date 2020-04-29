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


-- TOP-N 분석
-- 특정 기준으로 먼저 테이블을 정렬해 인라인 뷰를 생성하고, 그 뷰의 rownum을 확인
-- rownum <= n : 위에서 n번째 행까지 가져옴
SELECT ROWNUM, salary, first_name
FROM (SELECT salary, first_name
      FROM employees
      WHERE department_id = 50
      ORDER BY salary DESC)
WHERE ROWNUM<=3;

-- 부서별 사원수를 계산했을 때 사원수가 가장 많은 부서 3곳을 조회하기
SELECT ROWNUM ranking, department_id, employee_count
FROM (SELECT department_id, count(*) AS employee_count
      FROM employees
      GROUP BY department_id
      ORDER BY employee_count DESC)
WHERE ROWNUM <= 3;

-- 부서별 사원수를 계산했을 때 사원수가 가장 많은 부서 3곳을 조회하기
-- 부서아이디, 부서명, 사원수가 출력되어야 함
SELECT B.ranking, A.department_id, A.department_name, B.employee_count
FROM departments A, (SELECT ROWNUM ranking, department_id, employee_count
                    FROM (SELECT department_id, count(*) AS employee_count
                          FROM employees
                          GROUP BY department_id
                          ORDER BY employee_count DESC)
                    WHERE ROWNUM <= 3) B
WHERE A.department_id = B.department_id;

-- 가격이 가장 비싼 책 3권을 조회하기
-- 순위, 제목, 가격이 출력되어야 함
SELECT ROWNUM, book_no, book_title, book_price
FROM (SELECT *
      FROM sample_books
      ORDER BY book_price DESC)
WHERE ROWNUM <=3;

-- 최근 1주일 이내에 이 책을 구매한 사람 찾기
SELECT *
FROM sample_book_orders
WHERE (SYSDATE - order_registered_date) < 7;

SELECT *
FROM sample_book_users U, (SELECT *
                            FROM sample_book_orders
                            WHERE (SYSDATE - order_registered_date) < 7) RO
WHERE U.user_id = RO.user_id;

-- 가격이 가장 비싼 책 3권을 조회했을 때
-- 최근 1주일 이내에 이 책을 산 사용자를 조회하기
-- 사용자 아이디, 사용자명, 책제목, 구매가격, 구매수량, 구매날짜가 출력되어야 함
SELECT U.user_id, U.user_name, EX_books.book_title, O.order_price, O.order_amount, O.order_registered_date
FROM sample_book_users U, sample_book_orders O, (SELECT ROWNUM, book_no, book_title, book_price
                                                 FROM (SELECT book_no, book_title, book_price
                                                       FROM sample_books
                                                       ORDER BY book_price DESC)
                                                 WHERE ROWNUM <= 3) EX_books
WHERE U.user_id = O.user_id
    AND O.book_no = EX_books.book_no
    AND (O.order_registered_date > SYSDATE -7);
    
-- 총주문량이 가장 많은 고객 랭킹 10위까지 찾아서 사은품 보내기(연락처) 등에 필요

-- 사용자별 구매총액이 가장 높은 사용자 1명 찾아내기
-- 아이디, 이름, 총구매금액을 조회하기
SELECT U.user_id, U.user_name, Top_user.total_price
FROM sample_book_users U, (SELECT user_id, total_price
                           FROM (SELECT U.user_id, SUM(O.order_price*O.order_amount) AS total_price
                                 FROM sample_book_orders O, sample_book_users U
                                 WHERE O.user_id = U.user_id
                                 GROUP BY U.user_id
                                 ORDER BY total_price DESC)
                           WHERE ROWNUM = 1) Top_user
WHERE U.user_id = Top_user.user_id;