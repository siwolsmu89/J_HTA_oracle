-- 트랜잭션 처리
INSERT INTO sample_book_users               -- 트랜잭션 시작
(user_id, user_password, user_name, user_email)
VALUES
('kkim', 'zxcv1234', '낌낌', 'kkim@kim.k');

UPDATE sample_book_users
SET user_point = 1000
WHERE user_id = 'kkim';

SAVEPOINT add_new_user;                     -- 저장지점 생성

INSERT INTO sample_book_orders (order_no, user_id, book_no, order_price, order_amount)
VALUES (sample_order_seq.NEXTVAL, 'kkim', 10010, (SELECT book_discount_price FROM sample_books WHERE book_no=10010), 20);

UPDATE sample_book_users
SET user_point = user_point + trunc((SELECT book_discount_price FROM sample_books WHERE book_no=10010)*20*0.03)
WHERE user_id = 'kkim';

SELECT * FROM sample_book_users;
SELECT * FROM sample_book_orders;

ROLLBACK TO SAVEPOINT add_new_user;         -- 저장지점 이후의 작업으로 변경된 내용이 사라짐

COMMIT; -- 현재 트랜잭션의 변경내용을 저장, 현재 트랜잭션 종료, 새 트랜잭션 시작

-- DML1 작업
-- DML2 작업
-- DML3 작업

ROLLBACK; -- 새로 시작된 트랜잭션의 변경사항(DML1~3)을 버림, 현재 트랜잭션 종료, 새 트랜잭션 시작