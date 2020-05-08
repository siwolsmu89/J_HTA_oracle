-- 하나 만들어보기
-- 유저아이디, 책번호, 구매수량을 입력받아 책을 주문하는 프로시저
CREATE OR REPLACE PROCEDURE add_book_order
    (i_user_id        IN    sample_book_users.user_id%TYPE
    , i_book_no       IN    sample_books.book_no%TYPE
    , i_order_amount  IN    sample_book_orders.order_amount%TYPE)
IS
    v_order_price   sample_books.book_discount_price%TYPE;
    v_stock         sample_books.book_stock%TYPE;
    
BEGIN
    SELECT book_discount_price, book_stock
    INTO v_order_price, v_stock
    FROM sample_books
    WHERE book_no = i_book_no;
    
    IF i_order_amount <= v_stock THEN 
        INSERT INTO sample_book_orders
            (order_no, user_id, book_no, order_price, order_amount, order_registered_date)
        VALUES
            (sample_order_seq.NEXTVAL, i_user_id, i_book_no, v_order_price, i_order_amount, SYSDATE);
            
        UPDATE sample_books
            SET
                book_stock = v_stock - i_order_amount
        WHERE book_no = i_book_no;
    END IF;
    
END;