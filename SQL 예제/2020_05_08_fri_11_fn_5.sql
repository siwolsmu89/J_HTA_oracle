CREATE OR REPLACE FUNCTION get_total_order_amount
    (i_book_no IN sample_books.book_no%TYPE)
    RETURN NUMBER
IS
    v_total_amount  sample_book_orders.order_amount%TYPE := 0;
    
BEGIN
    
    SELECT SUM(order_amount)
    INTO v_total_amount
    FROM sample_book_orders
    WHERE book_no = i_book_no;
    
    RETURN v_total_amount;
    
END;