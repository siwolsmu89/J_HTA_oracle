CREATE OR REPLACE FUNCTION get_total_order_price
    (i_book_no IN sample_books.book_no%TYPE)
    RETURN NUMBER
IS
    v_total_price   NUMBER := 0;
    
BEGIN
    
    SELECT NVL(SUM(order_amount * order_price), 0)
    INTO v_total_price
    FROM sample_book_orders
    WHERE book_no = i_book_no;
    
    RETURN v_total_price;
    
END;