-- 재고가 없는 책을 주문하려고 하면 예외 발생
EXECUTE add_book_order('kimmi', 10011, 3);

SELECT get_total_order_price(10012)
FROM dual;

SELECT book_no 번호
    , book_title 제목
    , book_price 가격
    , book_discount_price 할인가
    , book_stock 재고
    , get_total_order_amount(book_no) 총판매량
    , get_total_order_price(book_no) 총판매금액
FROM sample_books;