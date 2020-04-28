-- å�� ���� ����� ������ ��� ���̺�
CREATE TABLE sample_book_reviews (
    review_no               NUMBER(7,0)     CONSTRAINT review_no_pk         PRIMARY KEY,
    review_content          VARCHAR2(2000)  CONSTRAINT review_content_nn    NOT NULL, 
    review_point            NUMBER(1,0)     CONSTRAINT review_point_ck      CHECK (review_point >=0 AND review_point <= 5),
    review_registered_date  DATE                                            DEFAULT SYSDATE,
    book_no                 NUMBER(7,0)     CONSTRAINT review_bookno_fk     REFERENCES sample_books (book_no),
    user_id                 VARCHAR2(50)    CONSTRAINT reivew_userid_fk     REFERENCES sample_book_users (user_id),
    CONSTRAINT reviews_uk UNIQUE (book_no, user_id)         -- ���� å�� ���� ����� �������� �� ���� �ۼ��� �� �ֵ��� ����
);

CREATE SEQUENCE sample_review_seq NOCACHE;

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '���� �������̾����ϴ�', 5, 10016, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '���� �������̾����ϴ�', 5, 10016, 'kimkim');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '��ȭ�� �������� �ߴٴ� ���� �ϱ��� �ʾҽ��ϴ�', 5, 10021, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '�������� �޵� ���� �ʰ� �� ����ϴ�', 2, 11021, 'kimkim');

-- ������� Ȯ��
SELECT TRUNC(AVG(review_point),1)
FROM sample_book_reviews
WHERE book_no = 10021;

-- ��õ���� ���̺�
-- ���� ���� å�� ���ƿ� �ߴ��� Ȯ��
CREATE TABLE sample_book_likes (
    book_no NUMBER(7,0) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    CONSTRAINT likes_bookno_fk FOREIGN KEY (book_no) 
        REFERENCES sample_books (book_no),
    CONSTRAINT likes_userid_fk FOREIGN KEY (user_id) 
        REFERENCES sample_book_users (user_id),
    CONSTRAINT likes_uk UNIQUE (book_no, user_id)
);