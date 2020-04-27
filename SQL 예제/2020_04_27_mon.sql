-- 트랜잭션 처리
INSERT INTO sample_book_users               -- 트랜잭션 시작
(user_id, user_password, user_name, user_email)
VALUES
('kkim', 'zxcv1234', '낌낌', 'kkim@kim.k');

UPDATE sample_book_users
SET user_point = 1000
WHERE user_id = 'kkim';

SAVEPOINT add_new_user;                     -- 저장지점 생성

INSERT INTO sample_book_orders (order_no, user_id, book_no, order_price, order_amount)
VALUES (sample_order_seq.NEXTVAL, 'kkim', 10010, (SELECT book_discount_price FROM sample_books WHERE book_no=10010), 20);

UPDATE sample_book_users
SET user_point = user_point + trunc((SELECT book_discount_price FROM sample_books WHERE book_no=10010)*20*0.03)
WHERE user_id = 'kkim';

SELECT * FROM sample_book_users;
SELECT * FROM sample_book_orders;

ROLLBACK TO SAVEPOINT add_new_user;         -- 저장지점 이후의 작업으로 변경된 내용이 사라짐

COMMIT; -- 현재 트랜잭션의 변경내용을 저장, 현재 트랜잭션 종료, 새 트랜잭션 시작

-- DML1 작업
-- DML2 작업
-- DML3 작업

ROLLBACK; -- 새로 시작된 트랜잭션의 변경사항(DML1~3)을 버림, 현재 트랜잭션 종료, 새 트랜잭션 시작

SELECT ROWID, user_id, user_email
FROM sample_book_users;

-- 북스토어 문의 게시판
-- 번호,    제목,     작성자,    내용,     조회수, 작성일, 상태(답변완료여부), 질문유형
-- NUMBER, VARCHAR2, VARCHAR2, VARCHAR2, NUMBER, DATE, CHAR,             VARCHAR2
CREATE TABLE sample_book_questions (
    question_no                    NUMBER(7,0)      PRIMARY KEY, 
    question_title                 VARCHAR2(500)    NOT NULL, 
    user_id                        VARCHAR2(50)     REFERENCES sample_book_users (user_id), 
    question_content               VARCHAR2(4000)   NOT NULL,
    question_view_count            NUMBER(7,0)      DEFAULT 0,
    question_registered_date       DATE             DEFAULT SYSDATE,
    question_status                CHAR(1)          DEFAULT 'N',
    question_type                  VARCHAR2(200)    NOT NULL
);

-- 북스토어 답변 게시판
-- 번호,    내용,     작성일, 문의글번호
-- NUMBER, VARCHAR2, DATE,  NUMBER
CREATE TABLE sample_book_answers (
    answer_no                      NUMBER(7,0)     PRIMARY KEY,
    answer_content                 VARCHAR2(4000)  NOT NULL,
    answer_registered_date         DATE            DEFAULT SYSDATE,
    question_no                    NUMBER(7,0)     REFERENCES sample_book_questions (question_no)
);

-- 테이블 이름 변경하기
-- RENAME 지금 이름 TO 새 이름
RENAME sample_books_answers TO sample_book_answers;

-- 문의/답변 게시판용 일련번호 생성기 만들기
-- 일반적인 환경에서는 DB가 설치된 컴퓨터를 안 끄기 때문에 일련번호를 일정 수량 미리 생성해놓고, 사용할 때마다 생성된 번호를 하나씩 제공
-- 이런 방법을 채택할 경우 미리 생성한 일련번호를 사용하지 않고 컴퓨터를 종료하면 전에 생성된 일련번호 이후의 일련번호부터 사용
-- NOCACHE : 일련번호를 미리 생성하지 않도록 하는 키워드
CREATE SEQUENCE sample_question_seq START WITH 1000000 NOCACHE;
CREATE SEQUENCE sample_answer_seq START WITH 1000000 NOCACHE;

INSERT INTO sample_book_questions
    (question_no, question_title, user_id, question_content, question_view_count, question_registered_date, question_status, question_type)
VALUES  
    (sample_question_seq.NEXTVAL, '질문 테스트 001', 'JasikZasik', '쿼리문 테스트 한 번 해봅니다', DEFAULT, SYSDATE, DEFAULT, '테스트');