-- Ʈ����� ó��
INSERT INTO sample_book_users               -- Ʈ����� ����
(user_id, user_password, user_name, user_email)
VALUES
('kkim', 'zxcv1234', '����', 'kkim@kim.k');

UPDATE sample_book_users
SET user_point = 1000
WHERE user_id = 'kkim';

SAVEPOINT add_new_user;                     -- �������� ����

INSERT INTO sample_book_orders (order_no, user_id, book_no, order_price, order_amount)
VALUES (sample_order_seq.NEXTVAL, 'kkim', 10010, (SELECT book_discount_price FROM sample_books WHERE book_no=10010), 20);

UPDATE sample_book_users
SET user_point = user_point + trunc((SELECT book_discount_price FROM sample_books WHERE book_no=10010)*20*0.03)
WHERE user_id = 'kkim';

SELECT * FROM sample_book_users;
SELECT * FROM sample_book_orders;

ROLLBACK TO SAVEPOINT add_new_user;         -- �������� ������ �۾����� ����� ������ �����

COMMIT; -- ���� Ʈ������� ���泻���� ����, ���� Ʈ����� ����, �� Ʈ����� ����

-- DML1 �۾�
-- DML2 �۾�
-- DML3 �۾�

ROLLBACK; -- ���� ���۵� Ʈ������� �������(DML1~3)�� ����, ���� Ʈ����� ����, �� Ʈ����� ����