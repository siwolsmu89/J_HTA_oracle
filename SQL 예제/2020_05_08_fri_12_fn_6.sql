CREATE OR REPLACE FUNCTION get_total_order_price
    (i_book_no IN sample_books.book_no%TYPE)
    RETURN NUMBER
IS
    v_total_amount  sample_book_orders.order_amount%TYPE := 0;
    v_price         sample_book_orders.order_price%TYPE;
    v_total_price   NUMBER := 0;
    
BEGIN
    
    SELECT SUM(order_amount)
    INTO v_total_amount
    FROM sample_book_orders
    WHERE book_no = i_book_no;
    
    SELECT book_discount_price
    INTO v_price
    FROM sample_books
    WHERE book_no = i_book_no;
    
    v_total_price := v_price * v_total_amount;
    
    RETURN v_total_price;
    
END;