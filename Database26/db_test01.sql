DROP TABLE reservation;
DROP TABLE theater;
DROP TABLE customer;
DROP TABLE cinema;

CREATE TABLE cinema (
    cinema_number    NUMBER          PRIMARY KEY,
    cinema_name    VARCHAR2(100)   NOT NULL,
    cinema_location        VARCHAR2(100)
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


-- 1) 영화 가격이 9,000원 이상인 상영관의 극장번호를 추출하시오
SELECT cinema_number 
FROM theater 
WHERE price >= 9000;
-- 2)극장별 상영관(두 테이블 조인)
SELECT * 
FROM cinema,theater 
WHERE cinema.cinema_number = theater.cinema_number;
-- 3)영화 가격이 10,000원 이상인 영화를 상영하는 극장이름
SELECT DISTINCT t.cinema_name 
FROM cinema t 
JOIN theater s 
ON t.cinema_number = s.cinema_number 
WHERE s.price >= 10000;
-- 4)예약 날짜가 2024년 1월 1일 이후인 고객 정보와 예약 내용-- (예약이 없는 고객도 포함 → LEFT OUTER JOIN)
SELECT c.customer_number, c.customer_name, c.customer_address, r.cinema_number, r.theater_number, r.number_of_seats, r.movie_date 
FROM customer c 
LEFT OUTER JOIN reservation r 
ON c.customer_number = r.customer_number 
AND r.movie_date > TO_DATE('2024-01-01','YYYY-MM-DD');
-- 5) 강남에 있는 모든 극장을 예약한 고객의 이름과 극장번호를 출력
SELECT c.customer_name, r.cinema_number
FROM customer c
JOIN reservation r ON c.customer_number = r.customer_number
WHERE r.cinema_number IN (SELECT cinema_number FROM cinema WHERE cinema_location = '강남')
AND c.customer_number IN (
    SELECT r2.customer_number
    FROM reservation r2
    WHERE r2.cinema_number IN (SELECT cinema_number FROM cinema WHERE cinema_location = '강남')
    GROUP BY r2.customer_number
    HAVING COUNT(DISTINCT r2.cinema_number) = (SELECT COUNT(*) FROM cinema WHERE cinema_location = '강남')
);
-- 1) 극장테이블에서 극장이름, 위치를 추출하시오
SELECT cinema_name, cinema_location 
FROM cinema;
-- 2) 영화 가격이 10000이하인 영화제목을 추출하시오
SELECT movie_name 
FROM theater 
WHERE price <= 10000;
-- 3) 고객테이블에서 이름,주소를 추출하시오
SELECT customer_name, customer_address 
FROM customer;
--4) 극장 위치가 강남인 곳에서 상영 중인 영화제목을 추출하시오
SELECT s.movie_name 
FROM cinema t 
JOIN theater s 
ON t.cinema_number = s.cinema_number
WHERE t.cinema_location = '강남';
-- 5)강남에 위치한 극장을 모두 예약한 고객 이름
SELECT c.customer_name 
FROM customer c 
WHERE NOT EXISTS(SELECT t.cinema_number FROM cinema t WHERE 
t.cinema_location ='강남' 
MINUS
SELECT r.cinema_number FROM reservation r 
WHERE r.customer_number = c.customer_number);




-- 1. 극장테이블에서 극장이름, 위치를 추출하시오
SELECT cinema_name, cinema_location FROM cinema;
-- 2. 극장 테이블에서 위치가 '서울'인 극장의 극장이름을 조회하시오.
SELECT cinema_name FROM cinema WHERE cinema_location = '서울';
-- 3. 상영관 테이블에서 가격이 10000원 이상인 상영관의 극장번호, 상영관번호, 영화제목을 조
-- 회하시오.
SELECT cinema_number, theater_number, movie_name FROM theater WHERE price >= 10000;
-- 4. 상영관 테이블에서 영화제목별 상영관 수를 조회하시오.
SELECT movie_name, count(theater_number) FROM theater GROUP BY movie_name;
-- 5. 예약 테이블에서 날짜가 '2024-10-01'인 모든 예약 정보를 조회하시오.
SELECT * FROM reservation WHERE movie_date = TO_DATE('2024-10-01','YYYY-MM-DD');
-- 6. 고객 테이블에서 주소별 고객 수를 조회하시오.
SELECT customer_address, count(customer_number) FROM customer GROUP BY customer_address;
-- 7. 상영관 테이블에서 좌석수가 가장 많은 상영관의 극장번호와 상영관번호를 조회하시오.
SELECT cinema_number, theater_number FROM theater
WHERE number_of_seats = (SELECT MAX(number_of_seats) FROM theater);
-- 8. 예약 테이블에서 고객번호별 예약 횟수를 조회하시오.
SELECT count(customer_number) FROM reservation GROUP BY customer_number;
-- 9. 상영관 테이블에서 극장번호별 평균 가격을 조회하시오.
SELECT AVG(price) FROM theater GROUP BY theater_number;
-- 10. 고객 테이블에서 이름이 '김'으로 시작하는 고객의 이름과 주소를 조회하시오.
SELECT customer_name, customer_address FROM customer WHERE customer_name LIKE '김%';
-- 11. 극장과 상영관 테이블을 조인하여 극장이름과 해당 극장의 영화제목을 조회하시오.
SELECT c.cinema_name, t.movie_name 
FROM cinema c JOIN theater t ON c.cinema_number = t.cinema_number;
-- 12. 극장, 상영관, 예약 테이블을 조인하여 극장이름, 영화제목, 예약 날짜를 조회하시오.
SELECT c.cinema_name, t.movie_name, r.movie_date 
FROM cinema c 
JOIN theater t ON c.cinema_number = t.cinema_number
JOIN reservation r ON t.cinema_number = r.cinema_number AND t.theater_number = r.theater_number;
-- 13. 고객과 예약 테이블을 조인하여 고객 이름과 해당 고객의 예약 날짜를 조회하시오.
SELECT c.customer_name, r.movie_date 
FROM customer c JOIN reservation r ON c.customer_number = r.customer_number;
-- 14. 극장, 상영관, 예약, 고객 테이블을 모두 조인하여 극장이름, 영화제목, 고객이름, 좌석번호를 조회하시오.
SELECT ci.cinema_name, t.movie_name, cu.customer_name, r.number_of_seats 
FROM cinema ci
JOIN theater t ON ci.cinema_number = t.cinema_number
JOIN reservation r ON t.cinema_number = r.cinema_number AND t.theater_number = r.theater_number
JOIN customer cu ON r.customer_number = cu.customer_number;
-- 15. 상영관과 예약 테이블을 조인하여 영화제목별 총 예약 수를 조회하시오.
SELECT t.movie_name, COUNT(r.customer_number) as total_reservations
FROM theater t LEFT JOIN reservation r ON t.cinema_number = r.cinema_number AND t.theater_number = r.theater_number
GROUP BY t.movie_name;
-- 16. 극장과 상영관 테이블을 조인하여 위치가 '서울'인 극장에서 상영 중인 영화제목과 가격을 조회하시오.
SELECT t.movie_name, t.price 
FROM cinema c JOIN theater t ON c.cinema_number = t.cinema_number 
WHERE c.cinema_location = '서울';
-- 17. 고객과 예약 테이블을 LEFT JOIN하여 예약이 한 건도 없는 고객의 이름을 조회하시오.
SELECT c.customer_name 
FROM customer c LEFT JOIN reservation r ON c.customer_number = r.customer_number 
WHERE r.customer_number IS NULL;
-- 18. 극장, 상영관, 예약 테이블을 조인하여 극장별 총 예약 수를 조회하시오.
SELECT c.cinema_name, COUNT(r.customer_number) 
FROM cinema c 
LEFT JOIN reservation r ON c.cinema_number = r.cinema_number 
GROUP BY c.cinema_name;
-- 19. 상영관과 예약 테이블을 조인하여 가격이 15000원 이상인 상영관을 예약한 고객번호와 영화제목을 조회하시오.
SELECT r.customer_number, t.movie_name 
FROM theater t JOIN reservation r ON t.cinema_number = r.cinema_number AND t.theater_number = r.theater_number 
WHERE t.price >= 15000;
-- 20. 극장, 상영관, 예약, 고객 테이블을 조인하여 고객별 총 예약 횟수와 이름을 조회하시오.
SELECT c.customer_name, COUNT(r.customer_number) 
FROM customer c LEFT JOIN reservation r ON c.customer_number = r.customer_number 
GROUP BY c.customer_name, c.customer_number;
-- 21. 예약 테이블에서 가장 많은 예약이 발생한 극장번호를 조회하시오.
SELECT cinema_number FROM (
    SELECT cinema_number, COUNT(*) as cnt FROM reservation GROUP BY cinema_number ORDER BY cnt DESC
) WHERE ROWNUM = 1;
-- 22. 고객 테이블에서 예약 테이블에 예약 기록이 있는 고객의 이름과 주소를 조회하시오. (IN 사용)
SELECT customer_name, customer_address 
FROM customer 
WHERE customer_number IN (SELECT customer_number FROM reservation);
-- 23. 극장 테이블에서 상영관이 3개 이상 등록된 극장의 극장이름을 조회하시오.
SELECT cinema_name FROM cinema 
WHERE cinema_number IN (SELECT cinema_number FROM theater GROUP BY cinema_number HAVING COUNT(*) >= 3);
-- 24. 상영관 테이블에서 전체 상영관 평균 가격보다 비싼 상영관의 영화제목과 가격을 조회하시오.
SELECT movie_name, price 
FROM theater 
WHERE price > (SELECT AVG(price) FROM theater);
-- 25. 고객 테이블에서 예약 테이블에 예약 기록이 전혀 없는 고객의 이름을 조회하시오. (NOT IN 사용)
SELECT customer_name 
FROM customer 
WHERE customer_number NOT IN (SELECT DISTINCT customer_number FROM reservation WHERE customer_number IS NOT NULL);
-- 26. 극장 테이블에서 예약 테이블에 예약된 적이 없는 극장의 극장이름을 조회하시오.
SELECT cinema_name FROM cinema 
WHERE cinema_number NOT IN (SELECT DISTINCT cinema_number FROM reservation);
-- 27. 예약 테이블에서 예약 횟수가 전체 고객 평균 예약 횟수보다 많은 고객번호를 조회하시오.
SELECT customer_number FROM reservation 
GROUP BY customer_number 
HAVING COUNT(*) > (SELECT AVG(COUNT(*)) FROM reservation GROUP BY customer_number);
-- 28. 상영관 테이블에서 좌석수가 가장 적은 상영관이 속한 극장의 극장이름을 조회하시오.
SELECT cinema_name FROM cinema 
WHERE cinema_number IN (SELECT cinema_number FROM theater WHERE number_of_seats = (SELECT MIN(number_of_seats) FROM theater));
-- 29. 예약 테이블에서 '2024-01-01'에 예약이 발생한 상영관의 영화제목을 조회하시오.
SELECT DISTINCT t.movie_name 
FROM theater t JOIN reservation r ON t.cinema_number = r.cinema_number AND t.theater_number = r.theater_number 
WHERE r.movie_date = TO_DATE('2024-01-01', 'YYYY-MM-DD');
-- 30. 고객 테이블에서 두 번 이상 예약한 고객의 이름을 조회하시오.
SELECT customer_name FROM customer 
WHERE customer_number IN (SELECT customer_number FROM reservation GROUP BY customer_number HAVING COUNT(*) >= 2);
-- 31. 고객 테이블에서 예약 테이블에 기록이 존재하는 고객의 이름을 조회하시오. (EXISTS 사용)
SELECT c.customer_name FROM customer c 
WHERE EXISTS (SELECT 1 FROM reservation r WHERE r.customer_number = c.customer_number);
-- 32. 상영관 테이블에서 같은 극장 내 상영관들의 평균 가격보다 비싼 상영관의 영화제목과 가격을 조회하시오.
SELECT t1.movie_name, t1.price 
FROM theater t1 
WHERE t1.price > (SELECT AVG(t2.price) FROM theater t2 WHERE t2.cinema_number = t1.cinema_number);
-- 33. 극장 테이블에서 해당 극장에 예약된 건수가 5건 이상인 극장의 극장이름을 조회하시오.
SELECT cinema_name FROM cinema c 
WHERE (SELECT COUNT(*) FROM reservation r WHERE r.cinema_number = c.cinema_number) >= 5;
-- 34. 예약한 좌석번호가 'A1'인 기록이 존재하는 고객의 이름을 조회하시오. A1이 없고 다 숫자로만 저장되어 있어서 15로 문제를 바꿔서 사용하겠습니다
SELECT customer_name FROM customer c 
WHERE EXISTS (SELECT 1 FROM reservation r WHERE r.customer_number = c.customer_number AND r.number_of_seats = 15);
-- 35. 상영관 테이블에서 해당 상영관에 예약된 기록이 하나도 없는 상영관의 영화제목을 조회하시오. (NOT EXISTS 사용)
SELECT t.movie_name FROM theater t 
WHERE NOT EXISTS (SELECT 1 FROM reservation r WHERE r.cinema_number = t.cinema_number AND r.theater_number = t.theater_number);
-- 36. 예약 테이블에서 같은 고객이 동일 날짜에 두 건 이상 예약한 고객번호와 날짜를 조회하시오.
SELECT customer_number, movie_date 
FROM reservation 
GROUP BY customer_number, movie_date HAVING COUNT(*) >= 2;
-- 37. 모든 상영관의 가격이 10000원 이상인 극장의 극장이름을 조회하시오. (NOT EXISTS 활용)
SELECT cinema_name FROM cinema c 
WHERE NOT EXISTS (SELECT 1 FROM theater t WHERE t.cinema_number = c.cinema_number AND t.price < 10000);
-- 38. 서로 다른 극장에 2곳 이상 예약한 고객의 이름을 조회하시오.
SELECT customer_name FROM customer c 
WHERE (SELECT COUNT(DISTINCT cinema_number) FROM reservation r WHERE r.customer_number = c.customer_number) >= 2;
-- 39. 상영관 테이블에서 같은 극장 내에서 좌석수가 가장 많은 상영관의 영화제목을 조회하시오.
SELECT t1.movie_name 
FROM theater t1 
WHERE t1.number_of_seats = (SELECT MAX(t2.number_of_seats) FROM theater t2 WHERE t2.cinema_number = t1.cinema_number);
-- 40. 고객 테이블에서 가장 최근 날짜에 예약한 고객의 이름을 조회하시오.
SELECT customer_name FROM customer 
WHERE customer_number IN (SELECT customer_number FROM reservation WHERE movie_date = (SELECT MAX(movie_date) FROM reservation));