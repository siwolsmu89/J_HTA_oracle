-- 1교시

-- 책 정보를 저장하는 테이블 생성하기
CREATE TABLE sample_books (
    book_no                   NUMBER(6,0) PRIMARY KEY,
    book_title                VARCHAR2(500) NOT NULL,
    book_writer               VARCHAR2(200) NOT NULL,
    book_genre                VARCHAR2(200) NOT NULL,
    book_publisher            VARCHAR2(200) NOT NULL,
    book_price                NUMBER(7,0) NOT NULL,
    book_discount_price       NUMBER(7,0) NOT NULL,
    book_registered_date      DATE
);

-- 일련번호를 발행하는 시퀀스 생성하기
CREATE SEQUENCE sample_book_sequence START WITH 10000;
-- 시퀀스 삭제하기
DROP SEQUENCE sample_book_sequence;

CREATE SEQUENCE sample_book_seq START WITH 10000;

SELECT sample_book_seq.NEXTVAL FROM  dual;

-- 책 정보 등록하기
INSERT INTO sample_books
(book_no, book_title, book_writer, book_genre, book_publisher, book_price, book_discount_price, book_registered_date)
VALUES
(sample_book_seq.NEXTVAL, '자바의 정석', '남궁성', 'IT', '도우출판사', 30000, 27000, SYSDATE);   

-- 고객 정보를 저장하는 테이블 생성하기
CREATE TABLE sample_book_users (
    user_id                 VARCHAR2(50) PRIMARY KEY,
    user_password           VARCHAR2(50) NOT NULL,
    user_name               VARCHAR2(100) NOT NULL,
    user_email              VARCHAR2(256) NOT NULL,
    user_point              NUMBER(10,0),
    user_registered_date    DATE
);

CREATE TABLE sample_book_orders (
    order_no                NUMBER(6,0) PRIMARY KEY,                                -- 주문번호
    user_id                 VARCHAR2(50) REFERENCES sample_book_users (user_id),    -- 주문자 아이디
    book_no                 NUMBER(6,0) REFERENCES sample_books (book_no),          -- 주문도서 번호
    order_price             NUMBER(7,0),                                            -- 구매금액
    order_amount            NUMBER(3,0),                                            -- 구매수량
    order_registered_date   DATE                                                    -- 주문날짜
);

-- sequence 잘못 만들면 drop sequence sample_order_seq; 하면 됨
CREATE SEQUENCE sample_order_seq START WITH 500000;

-- 사용자 등록
INSERT INTO sample_book_users 
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
VALUES
('hong', 'zxcv1234', '홍길동', 'hong@gmail.com', 1000, SYSDATE);

-- 주문 등록
INSERT INTO sample_book_orders
(order_no, user_id, book_no, order_price, order_amount, order_registered_date)
VALUES
(sample_order_seq.NEXTVAL, 'hong', 10012, (SELECT book_discount_price FROM sample_books WHERE book_no = 10012)*2, 2, SYSDATE);

-- 가입되지 않은 ID로는 주문 등록 불가
INSERT INTO sample_book_orders
(order_no, user_id, book_no, order_price, order_amount, order_registered_date)
VALUES
(sample_order_seq.NEXTVAL, 'KIM', 10012, (SELECT book_discount_price FROM sample_books WHERE book_no = 10012), 2, SYSDATE);