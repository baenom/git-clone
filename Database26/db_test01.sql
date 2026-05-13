DROP TABLE reservation;
DROP TABLE theater;
DROP TABLE customer;
DROP TABLE cinema;

CREATE TABLE cinema (
    cinema_number    NUMBER          PRIMARY KEY,
    cinema_name    VARCHAR2(100)   NOT NULL,
    location        VARCHAR2(100)
);
CREATE TABLE theater (
    cinema_number    NUMBER,
    theater_number  NUMBER,
    movie_name    VARCHAR2(200)   NOT NULL,
    price        NUMBER,
    number_of_seats      NUMBER,
    CONSTRAINT pk_theater     PRIMARY KEY (cinema_number, theater_number),
    CONSTRAINT fk_theater_cinema FOREIGN KEY (cinema_number) REFERENCES cinema(cinema_number)
);
CREATE TABLE customer (
    customer_number    NUMBER          PRIMARY KEY,
    customer_name        VARCHAR2(100)   NOT NULL,
    customer_address        VARCHAR2(200)
);
CREATE TABLE reservation (
    cinema_number    NUMBER,
    theater_number  NUMBER,
    customer_number    NUMBER,
    number_of_seats    NUMBER,
    movie_date        DATE,
    CONSTRAINT pk_reservation        PRIMARY KEY (cinema_number, theater_number, customer_number),
    CONSTRAINT fk_reservation_theater FOREIGN KEY (cinema_number, theater_number)
                              REFERENCES theater(cinema_number, theater_number),
    CONSTRAINT fk_pk_reservation_customer   FOREIGN KEY (customer_number) REFERENCES customer(customer_number)
);
INSERT INTO cinema VALUES (1, '강남극장', '강남');
INSERT INTO cinema VALUES (2, '강동극장', '강동');
INSERT INTO cinema VALUES (3, '홍대극장', '마포');
INSERT INTO cinema VALUES (4, '신촌극장', '서대문');
INSERT INTO cinema VALUES (5, '잠실극장', '송파');
INSERT INTO theater VALUES (1, 1, '아바타',       12000, 150);
INSERT INTO theater VALUES (1, 2, '범죄도시4',    11000, 120);
INSERT INTO theater VALUES (1, 3, '파묘',          9000,  80);
INSERT INTO theater VALUES (2, 1, '듄2',          13000, 200);
INSERT INTO theater VALUES (2, 2, '건국전쟁',      8000,  60);
INSERT INTO theater VALUES (3, 1, '오펜하이머',   12000, 180);
INSERT INTO theater VALUES (3, 2, '서울의봄',     10000, 100);
INSERT INTO theater VALUES (3, 3, '밀수',          9000,  90);
INSERT INTO theater VALUES (4, 1, '콘크리트유토피아', 11000, 130);
INSERT INTO theater VALUES (4, 2, '외계+인',       7000,  70);
INSERT INTO theater VALUES (5, 1, '탑건매버릭',   13000, 250);
INSERT INTO theater VALUES (5, 2, '앤트맨',       10000, 110);
INSERT INTO customer VALUES (1, '김철수', '서울시 강남구 역삼동');
INSERT INTO customer VALUES (2, '이영희', '서울시 강동구 천호동');
INSERT INTO customer VALUES (3, '박민준', '서울시 마포구 홍대동');
INSERT INTO customer VALUES (4, '최수연', '서울시 서대문구 신촌동');
INSERT INTO customer VALUES (5, '정하늘', '서울시 송파구 잠실동');
INSERT INTO customer VALUES (6, '한지민', '서울시 강북구 수유동');
INSERT INTO customer VALUES (7, '강감찬', '서울시 용산구 이태원동');
INSERT INTO customer VALUES (8, '장내윤', '서울시 성동구 왕십리동');
INSERT INTO reservation VALUES (1, 1, 1,  15, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (1, 1, 2,  23, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (1, 2, 3,   7, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (1, 3, 4,  11, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (2, 1, 1,  50, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (2, 1, 5,  88, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (2, 2, 6,   3, TO_DATE('2024-10-12', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (3, 1, 2,  77, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (3, 2, 7,  45, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (3, 3, 8,  62, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (4, 1, 3,  19, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (4, 2, 4,  33, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (5, 1, 5, 100, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (5, 1, 6, 120, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (5, 2, 7,  55, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO reservation VALUES (5, 2, 8,  67, TO_DATE('2024-10-25', 'YYYY-MM-DD'));


SELECT * FROM cinema;
SELECT * FROM theater;
SELECT * FROM customer;
SELECT * FROM reservation;
SELECT  t.cinema_name,
        s.theater_number,
        s.movie_name,
        s.price,
        c.customer_name      AS customer_name,
        r.number_of_seats,
        r.movie_date
FROM cinema t
JOIN theater s ON t.cinema_number   = s.cinema_number
JOIN reservation r   ON s.cinema_number   = r.cinema_number
          AND s.theater_number = r.theater_number
JOIN customer c   ON r.customer_number   = c.customer_number
ORDER BY r.movie_date, t.cinema_number;


-- (문제1)
SELECT cinema_number FROM theater WHERE price >= 9000;
-- (문제2)
SELECT * FROM cinema,theater WHERE cinema.cinema_number = theater.cinema_number;
-- (문제3)
SELECT DISTINCT t.cinema_name FROM cinema t JOIN theater s ON t.cinema_number = s.cinema_number WHERE s.price >= 10000;
-- (문제4)
SELECT c.customer_number, c.customer_name, c.customer_address, r.cinema_number, r.theater_number, r.number_of_seats, r.movie_date FROM customer c LEFT OUTER JOIN reservation r ON c.customer_number = r.customer_number AND r.movie_date > TO_DATE('2024-01-01','YYYY-MM-DD');
-- (문제5)
SELECT DISTINCT c.name, t.cinema_number FROM customer c WHERE NOT EXISTS(SELECT t.cinema_number FROM cinema t WHERE t.located = '강남' MINUS SELECT r.cinema_number FROM reservation r WHERE r.customer_number = c.customer_number);