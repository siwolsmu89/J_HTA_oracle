-- sample_book_orders�� ���ο� �ֹ��� �߰��� ������ sample_book_useres�� ����Ʈ�� ������Ų��.
CREATE OR REPLACE TRIGGER increase_user_point_trigger
AFTER
INSERT ON sample_book_orders
FOR EACH ROW
DECLARE
    -- ������ ����� �ڸ�
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