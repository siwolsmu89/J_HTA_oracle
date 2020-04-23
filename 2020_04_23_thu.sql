-- å ������ �����ϴ� ���̺� �����ϱ�
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

-- �Ϸù�ȣ�� �����ϴ� ������ �����ϱ�
CREATE SEQUENCE sample_book_sequence START WITH 10000;
-- ������ �����ϱ�
DROP SEQUENCE sample_book_sequence;

CREATE SEQUENCE sample_book_seq START WITH 10000;

SELECT sample_book_seq.NEXTVAL FROM  dual;

-- å ���� ����ϱ�
INSERT INTO sample_books
(book_no, book_title, book_writer, book_genre, book_publisher, book_price, book_discount_price, book_registered_date)
VALUES
(sample_book_seq.NEXTVAL, '�ڹ��� ����', '���ü�', 'IT', '�������ǻ�', 30000, 27000, SYSDATE);   