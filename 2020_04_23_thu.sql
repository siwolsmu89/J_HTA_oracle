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