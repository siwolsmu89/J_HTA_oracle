-- sample_book_orders에 새로운 주문이 추가될 때마다 sample_book_useres의 포인트를 증가시킨다.
CREATE OR REPLACE TRIGGER increase_user_point_trigger
AFTER
INSERT ON sample_book_orders
FOR EACH ROW
DECLARE
    -- 변수를 만드는 자리
    v_order_price       sample_book_orders.order_price%TYPE; 
    v_order_amount      sample_book_orders.order_amount%TYPE; 
    v_deposit_point     sample_book_users.user_point%TYPE;
    
BEGIN
    
    v_order_price       := :NEW.order_price;
    v_order_amount      := :NEW.order_amount;
    v_deposit_point     := TRUNC(v_order_price * v_order_amount * 0.02);

    UPDATE sample_book_users
    SET
        user_point = user_point + v_deposit_point
    WHERE user_id = :NEW.user_id;
    
END;