-- 책에 대한 리뷰가 작성될 때마다 책 번호에 해당 평점을 반영하는 트리거
CREATE OR REPLACE TRIGGER update_review_point_trigger
BEFORE
INSERT ON sample_book_reviews
FOR EACH ROW
DECLARE
    CURSOR review_list (param_book_no sample_books.book_no%TYPE) IS
    SELECT review_point
    FROM sample_book_reviews
    WHERE book_no = param_book_no;
    
    v_total_point     NUMBER := 0;
    v_row_count       NUMBER := 0;
    v_avg_point       NUMBER;
    
BEGIN
    FOR review IN review_list (:NEW.book_no) LOOP
        v_total_point := v_total_point + review.review_point;
        v_row_count := v_row_count + 1;
    END LOOP;
    
    v_avg_point := TRUNC((v_total_point + :NEW.review_point) / (v_row_count + 1), 1);
    
    UPDATE sample_books
        SET
            book_point = v_avg_point
    WHERE book_no = :NEW.book_no;
    
END;