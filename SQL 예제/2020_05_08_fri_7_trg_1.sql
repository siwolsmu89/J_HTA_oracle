-- 트리거 생성하기
-- sample_book_likes에 INSERT 작업이 실행될 때마다 sample_books의 book_likes 컬럼의 값을 1 증가시키는 트리거
CREATE OR REPLACE TRIGGER INCREASE_BOOK_LIKES_TRIGGER
AFTER
INSERT ON sample_book_likes
FOR EACH ROW
BEGIN
    UPDATE sample_books
    SET
        book_likes = book_likes +1
    WHERE
        book_no = :NEW.book_no;
END;