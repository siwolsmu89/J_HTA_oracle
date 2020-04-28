-- 책에 대한 리뷰와 평점을 담는 테이블
CREATE TABLE sample_book_reviews (
    review_no               NUMBER(7,0)     CONSTRAINT review_no_pk         PRIMARY KEY,
    review_content          VARCHAR2(2000)  CONSTRAINT review_content_nn    NOT NULL, 
    review_point            NUMBER(1,0)     CONSTRAINT review_point_ck      CHECK (review_point >=0 AND review_point <= 5),
    review_registered_date  DATE                                            DEFAULT SYSDATE,
    book_no                 NUMBER(7,0)     CONSTRAINT review_bookno_fk     REFERENCES sample_books (book_no),
    user_id                 VARCHAR2(50)    CONSTRAINT reivew_userid_fk     REFERENCES sample_book_users (user_id),
    CONSTRAINT reviews_uk UNIQUE (book_no, user_id)         -- 같은 책에 대한 리뷰는 유저별로 한 번만 작성할 수 있도록 설정
);

CREATE SEQUENCE sample_review_seq NOCACHE;

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '아주 감동적이었습니다', 5, 10016, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '아주 감동적이었습니다', 5, 10016, 'kimkim');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '실화를 바탕으로 했다는 것이 믿기지 않았습니다', 5, 10021, 'kimmi');

INSERT INTO sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
VALUES
(sample_review_seq.NEXTVAL, '오랜만에 꿈도 꾸지 않고 잘 잤습니다', 2, 11021, 'kimkim');

-- 평점평균 확인
SELECT TRUNC(AVG(review_point),1)
FROM sample_book_reviews
WHERE book_no = 10021;

-- 추천도서 테이블
-- 누가 무슨 책을 좋아요 했는지 확인
CREATE TABLE sample_book_likes (
    book_no NUMBER(7,0) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    CONSTRAINT likes_bookno_fk FOREIGN KEY (book_no) 
        REFERENCES sample_books (book_no),
    CONSTRAINT likes_userid_fk FOREIGN KEY (user_id) 
        REFERENCES sample_book_users (user_id),
    CONSTRAINT likes_uk UNIQUE (book_no, user_id)
);