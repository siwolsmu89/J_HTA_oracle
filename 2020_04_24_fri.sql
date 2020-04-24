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