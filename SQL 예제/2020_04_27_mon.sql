-- Ʈ����� ó��
INSERT INTO sample_book_users               -- Ʈ����� ����
(user_id, user_password, user_name, user_email)
VALUES
('kkim', 'zxcv1234', '����', 'kkim@kim.k');

UPDATE sample_book_users
SET user_point = 1000
WHERE user_id = 'kkim';

SAVEPOINT add_new_user;                     -- �������� ����

INSERT INTO sample_book_orders (order_no, user_id, book_no, order_price, order_amount)
VALUES (sample_order_seq.NEXTVAL, 'kkim', 10010, (SELECT book_discount_price FROM sample_books WHERE book_no=10010), 20);

UPDATE sample_book_users
SET user_point = user_point + trunc((SELECT book_discount_price FROM sample_books WHERE book_no=10010)*20*0.03)
WHERE user_id = 'kkim';

SELECT * FROM sample_book_users;
SELECT * FROM sample_book_orders;

ROLLBACK TO SAVEPOINT add_new_user;         -- �������� ������ �۾����� ����� ������ �����

COMMIT; -- ���� Ʈ������� ���泻���� ����, ���� Ʈ����� ����, �� Ʈ����� ����

-- DML1 �۾�
-- DML2 �۾�
-- DML3 �۾�

ROLLBACK; -- ���� ���۵� Ʈ������� �������(DML1~3)�� ����, ���� Ʈ����� ����, �� Ʈ����� ����

SELECT ROWID, user_id, user_email
FROM sample_book_users;

-- �Ͻ���� ���� �Խ���
-- ��ȣ,    ����,     �ۼ���,    ����,     ��ȸ��, �ۼ���, ����(�亯�ϷῩ��), ��������
-- NUMBER, VARCHAR2, VARCHAR2, VARCHAR2, NUMBER, DATE, CHAR,             VARCHAR2
CREATE TABLE sample_book_questions (
    question_no                    NUMBER(7,0)      PRIMARY KEY, 
    question_title                 VARCHAR2(500)    NOT NULL, 
    user_id                        VARCHAR2(50)     REFERENCES sample_book_users (user_id), 
    question_content               VARCHAR2(4000)   NOT NULL,
    question_view_count            NUMBER(7,0)      DEFAULT 0,
    question_registered_date       DATE             DEFAULT SYSDATE,
    question_status                CHAR(1)          DEFAULT 'N',
    question_type                  VARCHAR2(200)    NOT NULL
);

-- �Ͻ���� �亯 �Խ���
-- ��ȣ,    ����,     �ۼ���, ���Ǳ۹�ȣ
-- NUMBER, VARCHAR2, DATE,  NUMBER
CREATE TABLE sample_book_answers (
    answer_no                      NUMBER(7,0)     PRIMARY KEY,
    answer_content                 VARCHAR2(4000)  NOT NULL,
    answer_registered_date         DATE            DEFAULT SYSDATE,
    question_no                    NUMBER(7,0)     REFERENCES sample_book_questions (question_no)
);

-- ���̺� �̸� �����ϱ�
-- RENAME ���� �̸� TO �� �̸�
RENAME sample_books_answers TO sample_book_answers;

-- ����/�亯 �Խ��ǿ� �Ϸù�ȣ ������ �����
-- �Ϲ����� ȯ�濡���� DB�� ��ġ�� ��ǻ�͸� �� ���� ������ �Ϸù�ȣ�� ���� ���� �̸� �����س���, ����� ������ ������ ��ȣ�� �ϳ��� ����
-- �̷� ����� ä���� ��� �̸� ������ �Ϸù�ȣ�� ������� �ʰ� ��ǻ�͸� �����ϸ� ���� ������ �Ϸù�ȣ ������ �Ϸù�ȣ���� ���
-- NOCACHE : �Ϸù�ȣ�� �̸� �������� �ʵ��� �ϴ� Ű����
CREATE SEQUENCE sample_question_seq START WITH 1000000 NOCACHE;
CREATE SEQUENCE sample_answer_seq START WITH 1000000 NOCACHE;

INSERT INTO sample_book_questions
    (question_no, question_title, user_id, question_content, question_view_count, question_registered_date, question_status, question_type)
VALUES  
    (sample_question_seq.NEXTVAL, '���� �׽�Ʈ 001', 'JasikZasik', '������ �׽�Ʈ �� �� �غ��ϴ�', DEFAULT, SYSDATE, DEFAULT, '�׽�Ʈ');