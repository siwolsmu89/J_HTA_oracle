-- 1����

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

-- �� ������ �����ϴ� ���̺� �����ϱ�
CREATE TABLE sample_book_users (
    user_id                 VARCHAR2(50) PRIMARY KEY,
    user_password           VARCHAR2(50) NOT NULL,
    user_name               VARCHAR2(100) NOT NULL,
    user_email              VARCHAR2(256) NOT NULL,
    user_point              NUMBER(10,0),
    user_registered_date    DATE
);

CREATE TABLE sample_book_orders (
    order_no                NUMBER(6,0) PRIMARY KEY,                                -- �ֹ���ȣ
    user_id                 VARCHAR2(50) REFERENCES sample_book_users (user_id),    -- �ֹ��� ���̵�
    book_no                 NUMBER(6,0) REFERENCES sample_books (book_no),          -- �ֹ����� ��ȣ
    order_price             NUMBER(7,0),                                            -- ���űݾ�
    order_amount            NUMBER(3,0),                                            -- ���ż���
    order_registered_date   DATE                                                    -- �ֹ���¥
);

-- sequence �߸� ����� drop sequence sample_order_seq; �ϸ� ��
CREATE SEQUENCE sample_order_seq START WITH 500000;

-- ����� ���
INSERT INTO sample_book_users 
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
VALUES
('hong', 'zxcv1234', 'ȫ�浿', 'hong@gmail.com', 1000, SYSDATE);

-- �ֹ� ���
INSERT INTO sample_book_orders
(order_no, user_id, book_no, order_price, order_amount, order_registered_date)
VALUES
(sample_order_seq.NEXTVAL, 'hong', 10012, (SELECT book_discount_price FROM sample_books WHERE book_no = 10012)*2, 2, SYSDATE);

-- ���Ե��� ���� ID�δ� �ֹ� ��� �Ұ�
INSERT INTO sample_book_orders
(order_no, user_id, book_no, order_price, order_amount, order_registered_date)
VALUES
(sample_order_seq.NEXTVAL, 'KIM', 10012, (SELECT book_discount_price FROM sample_books WHERE book_no = 10012), 2, SYSDATE);