-- Ʈ���� �����ϱ�
-- sample_book_likes�� INSERT �۾��� ����� ������ sample_books�� book_likes �÷��� ���� 1 ������Ű�� Ʈ����
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