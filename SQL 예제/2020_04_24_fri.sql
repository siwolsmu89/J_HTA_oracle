-- 1교시

-- 사용자 정보 등록하기
-- 모든 컬럼에 값을 명시적으로 저장하기
-- 나열된 컬럼 순서에 맞게 값을 나열한다.
INSERT INTO sample_book_users
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
VALUES 
('siwol_smu', 'zxcv1234', '권민석', 'siwol_smu@oct.over', 10, SYSDATE);

-- 컬럼명을 생략한 경우
-- 테이블의 컬럼 순서에 맞게 값을 나열한다.
INSERT INTO sample_book_users
VALUES 
('Neena', 'zxcv1234', '니나', 'neena@ni.no', 100, SYSDATE);

-- 컬럼명을 생략한 경우
-- 반드시 테이블의 컬럼순서에 맞게 모든 값을 나열해야 한다.
-- 값이 부족한 경우 실행 시 오류가 발생 (not enough value 발생)
INSERT INTO sample_book_users
VALUES 
('ssosso', 'zxcv1234', '소영선배', 'ssosso@gmail.com');

-- 나열된 컬럼에만 값을 저장하고, 나머지는 NULL이나 DEFAULT값이 저장되도록 하기
INSERT INTO sample_book_users
(user_id, user_password, user_name)
VALUES
('JasikZasik', 'zxcv1234', '사랑이');

-- NOT NULL이면서 DEFAULT가 없는 컬럼을 제외하고 값을 저장하려고 시도한 경우 오류가 발생한다.
-- (cannot insert NULL into 오류 발생)
-- 1교시

-- 사용자 정보 등록하기
-- 모든 컬럼에 값을 명시적으로 저장하기
-- 나열된 컬럼 순서에 맞게 값을 나열한다.
INSERT INTO sample_book_users
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
VALUES 
('siwol_smu', 'zxcv1234', '권민석', 'siwol_smu@oct.over', 10, SYSDATE);

-- 컬럼명을 생략한 경우
-- 테이블의 컬럼 순서에 맞게 값을 나열한다.
INSERT INTO sample_book_users
VALUES 
('Neena', 'zxcv1234', '니나', 'neena@ni.no', 100, SYSDATE);

-- 컬럼명을 생략한 경우
-- 반드시 테이블의 컬럼순서에 맞게 모든 값을 나열해야 한다.
-- 값이 부족한 경우 실행 시 오류가 발생 (not enough value 발생)
INSERT INTO sample_book_users
VALUES 
('ssosso', 'zxcv1234', '소영선배', 'ssosso@gmail.com');

-- 나열된 컬럼에만 값을 저장하고, 나머지는 NULL이나 DEFAULT값이 저장되도록 하기
INSERT INTO sample_book_users
(user_id, user_password, user_name)
VALUES
('JasikZasik', 'zxcv1234', '사랑이');

-- NOT NULL이면서 DEFAULT가 없는 컬럼을 제외하고 값을 저장하려고 시도한 경우 오류가 발생한다.
-- (cannot insert NULL into (컬럼명) 오류 발생)
INSERT INTO sample_book_users
(user_id, user_password)
VALUES
('errorman1','zxcv1234');                                                                                                                                                                                                   

-- 컬럼에 지정된 데이터 길이를 넘어가는 값을 입력하려고 시도하는 경우 오류가 발생한다.
-- value too large for column (컬럼명)
INSERT INTO sample_book_users
(user_id, user_password, user_name)
VALUES
('errorman2','zxcv1234', '엉기조차벙기조차엉기벙기버벙기엉기조차벙기조차엉기벙기버벙기엉기조차벙기조차엉기벙기버벙기');

COMMIT;

-- 테이블의 값 수정하기
-- 모든 행의 특정 컬럼값을 수정하기 (WHERE 절 생략)
-- 모든 사용자의 비밀번호를 'zxcv1234'로 변경하기
UPDATE sample_book_users 
SET 
    user_password = 'zxcv1234';

-- commit되지 않은 변경 사항 취소하기
rollback;

-- 모든 행의 특정 컬럼값을 수정하기
-- 모든 직원들의 급여를 500불 인상하기
UPDATE employees
SET
    salary = (salary+500);
    
rollback;

-- WHERE 절을 사용해서 조건식을 만족하는 특정 행의 컬럼값을 수정하기
-- 90번 부서에 소속된 직원의 급여를 10000달러 인상시키기
UPDATE employees
SET
    salary = (salary + 10000)
WHERE department_id = 90;

-- 한 번에 여러 컬럼의 값을 변경하기
-- 10014번 책의 제목, 가격, 할인가격을 수정하기
UPDATE sample_books
SET
    book_title = '이것이 자바다 개정판'
    , book_price = 40000
    , book_discount_price = 38000
WHERE book_no = 10014;

-- 서브쿼리를 이용해서 값 변경하기

-- 최소 급여를 받는 직원
SELECT employee_id, salary, department_id
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);

-- 최소 급여를 받는 직원에게 부서의 평균 급여만큼 급여를 인상시키기
UPDATE employees
SET
    salary = salary + (SELECT TRUNC(AVG(salary))
                       FROM employees
                       WHERE department_id = 50)
WHERE employee_id = 132;

-- 270번 부서의 부서번호를 300번으로 변경하기
UPDATE departments
SET
    department_id = 300
WHERE department_id = 270;

-- 10번 부서의 부서번호를 301번으로 변경하기
-- 오류 : 자식 테이블(employees)에 자식 레코드가 존재
UPDATE departments
SET
    department_id = 301
WHERE department_id = 10;

-- 100번 사원의 소속부서를 500번으로 변경하기
-- 오류 : 부모테이블(departments)에 500번 부서가 존재하지 않음
UPDATE employees
SET
    department_id = 500
WHERE employee_id = 100; 

-- 데이터 삭제하기
DELETE sample_book_users
WHERE user_id = 'honghong';

CREATE TABLE copy_sample_book_users (
    user_id VARCHAR2(50) PRIMARY KEY,
    user_password VARCHAR2(50),
    user_name VARCHAR2(100),
    user_email VARCHAR2(256),
    user_point NUMBER(10,0),
    user_registered_date DATE
);

-- sample_book_users의 모든 행을 copy_sample_book_users에 추가하기
INSERT INTO copy_sample_book_users
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
SELECT user_id, user_password, user_name, user_email, user_point, user_registered_date
FROM sample_book_users;

-- 원본테이블에 새로운 행 추가
INSERT INTO sample_book_users
VALUES
('parkpark', 'zxcv1234', '박박이', 'pplee@ppl.com', 10, SYSDATE);

INSERT INTO sample_book_users
VALUES
('bakbak', 'zxcv1234', '박박', 'bakbak@baba.kk', 10, SYSDATE);

-- 여기까지 했을 때 원본테이블에는 행이 5개, 대상테이블에는 행이 3개, 값도 조금씩 달라짐
-- 원본테이블의 추가 및 변경사항을 대상 테이블과 병합하고 싶을 때
-- 단, 원본테이블에서 삭제된 행은 병합 이후에도 복제 테이블에 그대로 남아있다 (완전히 똑같게 만드는 것은 아님)
-- 조인 조건 : 아이디
MERGE INTO copy_sample_book_users C     -- 복제테이블 C
    USING sample_book_users O            -- 원본테이블 O
    ON (C.user_id = O.user_id)          -- 유저아이디가 일치하는 컬럼을 찾는다
WHEN MATCHED THEN                        -- 일치하는 컬럼 발견 시
    UPDATE SET                           -- C의 컬럼에 O의 컬럼값을 넣는다.
        C.user_password = O.user_password,
        C.user_name = O.user_name,
        C.user_email = O.user_email,
        C.user_point = O.user_point,
        C.user_registered_date = O.user_registered_date
WHEN NOT MATCHED THEN                    -- O 테이블에 존재하지만 C 테이블에는 조건이 일치하지 않는 컬럼이 있을 경우
    INSERT VALUES                        -- C 테이블에 새로운 행을 추가한다.
    (O.user_id, O.user_password, O.user_name, O.user_email, O.user_point, O.user_registered_date);
    
SELECT A.order_no, B.user_name
    , C.book_title, C.book_price
    , A.order_price, A.order_amount, A.order_registered_date
FROM sample_book_orders A, sample_book_users B, sample_books C
WHERE A.user_id = B.user_id
    AND A.book_no = C.book_no
    AND A.user_id = 'hong'
ORDER BY order_no ASC;