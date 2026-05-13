
-- [질의 3-1] 모든 도서의 이름과 가격을 검색하시오.
SELECT	 bookname, price
FROM	 Book;

SELECT	 price, bookname
FROM	 Book;

-- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
SELECT	 bookid, bookname, publisher, price
FROM	 Book;

SELECT	*
FROM	 Book;

-- [질의 3-3] 도서 테이블(Book)에 있는 모든 출판사를 검색하시오.
SELECT	 publisher
FROM	 Book;

SELECT 	DISTINCT	 publisher
FROM	 Book;

-- [질의 3-4] 가격이 20,000원 미만인 도서를 검색하시오.

SELECT	*
FROM	 Book
WHERE	 price < 20000;

-- [질의 3-5] 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT	*
FROM	 Book
WHERE	 price BETWEEN 10000 AND 20000;

SELECT	*
FROM	 Book
WHERE	 price >= 10000 AND price <= 20000;

-- [질의 3-6] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
SELECT	*
FROM	 Book
WHERE	 publisher IN ('굿스포츠', '대한미디어');

SELECT	*
FROM	 Book
WHERE	 publisher NOT IN ('굿스포츠', '대한미디어');

-- [질의 3-7] “축구의 역사”를 출간한 출판사를 검색하시오.
SELECT	 bookname, publisher
FROM	 Book
WHERE	 bookname LIKE '축구의 역사';

-- [질의 3-8] 도서이름에 ‘축구’가 포함된 출판사를 검색하시오.
SELECT	 bookname, publisher
FROM	 Book
WHERE	 bookname LIKE '%축구%';

-- [질의 3-9] 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자가 포함된 도서를 검색하시오.
SELECT	*
FROM	 Book
WHERE	 bookname LIKE '_구%';

-- [질의 3-10] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT	*
FROM	 Book
WHERE	 bookname LIKE '%축구%' AND price >=20000;

-- [질의 3-11] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
SELECT	*
FROM	 Book
WHERE	 publisher ='굿스포츠' OR publisher ='대한미디어';

-- [질의 3-12] 도서를 이름순으로 검색하시오.
SELECT	*
FROM	 Book
ORDER BY  bookname;

-- [질의 3-13] 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT	*
FROM	 Book
ORDER BY  price, bookname;

--[질의 3-14] 도서를 가격의 내림차순으로 검색하시오. 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT 	 *
FROM 	 Book
ORDER BY  price DESC, publisher ASC;

-- [질의 3-15] 고객이 주문한 도서의 총판매액을 구하시오.
SELECT	 SUM(saleprice)
FROM	 Orders;

SELECT	 SUM(saleprice) AS 총매출 FROM  Orders;

-- [질의 3-16] 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오.
SELECT	 SUM(saleprice) AS 총매출
FROM	 Orders
WHERE	 custid =2;

-- [질의 3-17] 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT	 SUM(saleprice) AS Total,
	 AVG(saleprice) AS Average,
	 MIN(saleprice) AS Minimum,
	 MAX(saleprice) AS Maximum
FROM	 Orders;

-- [질의 3-18] 마당서점의 도서 판매 건수를 구하시오.
SELECT	 COUNT(*)
FROM	 Orders;

--[질의 3-19] 고객별로 주문한 도서의 총수량과 총판매액을 구하시오.
SELECT	 custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
FROM	 Orders
GROUP BY  custid;

-- [질의 3-20] 가격이 8,000원 이상인 도서를 구매한 고객 중에서, 주문 도서의 총수량이 2권 이상인 고객을 구하시오.
SELECT	 custid, COUNT(*) AS 도서수량	 
FROM	 Orders				 
WHERE	 saleprice ＞= 8000		 
GROUP BY   custid				 
HAVING	 count(*) ＞= 2			 
ORDER BY  custid;	
        
-- [질의 3-21] 고객과 고객의 주문에 관한 데이터를 모두 나타내시오.
SELECT	*
FROM	 Customer, Orders
WHERE	 Customer.custid = Orders.custid;

-- [질의 3-22] 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 나타내시오.
SELECT	*
FROM	 Customer, Orders
WHERE	 Customer.custid = Orders.custid
ORDER BY  Customer.custid;

-- [질의 3-23] 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT	 name, saleprice
FROM	 Customer, Orders
WHERE	 Customer.custid = Orders.custid;

--[질의 3-24] 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객 이름 순으로 정렬하시오.
SELECT	 name, SUM(saleprice) AS 총판매액
FROM	 Customer, Orders
WHERE	 Customer.custid = Orders.custid
GROUP BY  name
ORDER BY  name;

-- [질의 3-25] 고객의 이름(name)과 고객이 주문한 도서의 이름(bookname)을 구하시오.
SELECT	 Customer.name, book.bookname
FROM	 Customer, Orders, Book
WHERE	 Customer.custid =Orders.custid AND Orders.bookid =Book.bookid;

-- [질의 3-26] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT	 Customer.name, book.bookname
FROM	 Customer, Orders, Book
WHERE	 Customer.custid =Orders.custid 
	     AND Orders.bookid =Book.bookid AND Book. price =20000;
        
-- [질의 3-27] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT	 Customer.name, saleprice
FROM	 Customer LEFT OUTER JOIN Orders
	    	ON Customer.custid =Orders.custid;
        
-- [질의 3-28] 가장 비싼 도서의 이름을 보이시오.
SELECT	 bookname
FROM	 Book
WHERE	 price =(SELECT MAX(price) FROM Book);

-- [질의 3-29] 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT	 name
FROM	 Customer
WHERE	 custid IN (SELECT custid FROM Orders);
        
-- [질의 3-30] ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.  
SELECT	 name
FROM	 Customer
WHERE	 custid IN(SELECT	 custid
		FROM	 Orders
		WHERE	 bookid IN(SELECT	 bookid
				  FROM	 Book
				  WHERE	 publisher = '대한미디어'));
                  
-- [질의 3-31] 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.

SELECT	 b1.bookname
FROM	 Book b1
WHERE	 b1.price > (SELECT	avg(b2.price)
		    FROM		Book b2
		    WHERE	b2.publisher = b1.publisher);
            
            
-- [질의 3-32] 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT	 name
FROM	 Customer
MINUS
SELECT	 name
FROM	 Customer
WHERE	 custid IN (SELECT custid FROM Orders);

-- [질의 3-33] 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT	 name, address
FROM	 Customer cs
WHERE	 EXISTS (SELECT	 *
		FROM	 Orders od
		WHERE	 cs.custid = od.custid);
        
-- [질의 3-34] 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 정수형은 NUMBER를 사용하며 문자 형은 가변형 문자타입인 VARCHAR2을 사용한다.
CREATE TABLE	 NewBook (
    bookid	 NUMBER,
    bookname  VARCHAR2(20),
    publisher  VARCHAR2(20),
    price	 NUMBER);

-- [질의 3-35] 다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
CREATE TABLE	 NewCustomer (
    custid	 NUMBER	  PRIMARY KEY,
    name	 VARCHAR2(40),
    address	 VARCHAR2(40),
    phone	 VARCHAR2(30));
    
-- [질의 3-36] 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
CREATE TABLE	 NewOrders (
    orderid	 NUMBER,
    custid	 NUMBER	 NOT NULL,
    bookid	 NUMBER	 NOT NULL,
    saleprice  NUMBER,
    orderdate  DATE,
    PRIMARY KEY(orderid),
    FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE);
    
-- [질의 3-37] NewBook 테이블에 isbn 속성을 VARCHAR2(13) 자료형으로 추가하시오.
ALTER TABLE NewBook ADD isbn VARCHAR2(13);

-- [질의 3-38] NewBook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오.
ALTER TABLE NewBook MODIFY isbn NUMBER;

--[질의 3-39] NewBook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE NewBook DROP COLUMN isbn;

--[질의 3-40] NewBook 테이블의 bookname 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE NewBook MODIFY bookname VARCHAR(20) NOT NULL;

--[질의 3-41] NewBook 테이블의 bookid 속성을 기본키로 변경하시오.
ALTER TABLE NewBook ADD PRIMARY KEY(bookid);

--[질의 3-42] NewBook 테이블을 삭제하시오.
DROP TABLE NewBook;

-- [질의 3-43] NewCustomer 테이블을 삭제하시오. 
DROP TABLE NewCustomer;

DROP TABLE NewOrders;
DROP TABLE NewCustomer;

-- [질의 3-44] Book 테이블에 새로운 도서 ‘스포츠 의학’을 삽입하시오. 스포츠 의학은 ‘한솔의학서적’에서 출간했으며 가격은 90,000원이다.
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES (11, '스포츠 의학', '한솔의학서적', 90000);

SELECT * FROM Book;    

--[질의 3-45] Book 테이블에 새로운 도서 ‘의학 이야기’을 삽입하시오. 의학 이야기는 ‘한솔의학서적’에서 출간했으며 가격은 ‘미정’이다.
INSERT INTO Book(bookid, bookname, publisher)
    VALUES (14, '의학 이야기', '한솔의학서적');
    
SELECT * FROM Book;    

-- [질의 3-46] Imported_book 테이블의 모든 도서를 Book 테이블에 삽입하시오.
INSERT INTO Book(bookid, bookname, price, publisher)
    SELECT	bookid, bookname, price, publisher
    FROM 	Imported_book;
    
select * from book;    

--[질의 3-47] Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
UPDATE	 Customer
SET	 address ='대한민국 부산'
WHERE	 custid =5;

SELECT * FROM Customer;

-- [질의 3-48] Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.

UPDATE	 Customer
SET	 address = (SELECT	address
		   FROM		Customer
		   WHERE		name = '김연아')
WHERE	 name = '박세리';

SELECT * FROM Customer;

-- [질의 3-49] Customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
DELETE	 FROM	 Customer
WHERE	 custid =5;

/* 삭제 작업의 결과 확인 */
SELECT * FROM Customer;

-- [질의 3-50] 모든 고객을 삭제하시오.
DELETE	 FROM	 Customer;