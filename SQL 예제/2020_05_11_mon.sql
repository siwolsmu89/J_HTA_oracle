-- ��� ���� å�� �ֹ��Ϸ��� �ϸ� ���� �߻�
EXECUTE add_book_order('kimmi', 10011, 3);

SELECT get_total_order_price(10012)
FROM dual;

SELECT book_no ��ȣ
    , book_title ����
    , book_price ����
    , book_discount_price ���ΰ�
    , book_stock ���
    , get_total_order_amount(book_no) ���Ǹŷ�
    , get_total_order_price(book_no) ���Ǹűݾ�
FROM sample_books;