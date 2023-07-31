create table goods(
	idx int not null auto_increment,
	brand_idx int not null,
	name varchar(50) not null,
	price int not null,
	Thumbnail varchar(100) not null,
	goods_like int default 0,
	secondcatagory_idx int not null,
	primary key(idx),
	foreign key(brand_idx) REFERENCES brand(idx),
	foreign key(secondcatagory_idx) REFERENCES secondcategory(secondCategory_Idx)
);
select * from goods_option;
drop table review;

SELECT cart.idx AS idx, goods.thumbnail AS order_ThumbNail, brand.name AS order_Brand, goods.name AS order_Name, goods_option.goods_option AS order_Option, goods.price AS order_Price,  cart.stock, cart.goods_idx, cart.option_idx, goods_stock.stock
		FROM cart
		JOIN goods ON goods.idx = cart.goods_idx
		JOIN goods_option ON goods_option.option_idx = cart.option_idx
		JOIN goods_stock ON goods_stock.option_idx = goods_option.option_idx
		JOIN brand ON brand.idx = goods.brand_idx
		WHERE cart.member_idx = 11;
		
SELECT cart.idx AS idx, goods.thumbnail AS order_ThumbNail, brand.name AS order_Brand, goods.name AS order_Name, goods_option.goods_option AS order_Option, goods.price AS order_Price,  cart.stock, cart.goods_idx, cart.option_idx, (SELECT stock FROM goods_stock WHERE goods_idx = cart.goods_idx AND option_idx = cart.option_idx) AS goods_Stock
		FROM cart
		JOIN goods ON goods.idx = cart.goods_idx
		JOIN goods_option ON goods_option.option_idx = cart.option_idx
		JOIN brand ON brand.idx = goods.brand_idx
		WHERE cart.member_idx = 11;

select * from member;
select * from goods_option;
select * from goods_stock;
		
DELETE FROM orderhistory_detail WHERE idx = 133;

create table draw(
	idx int not null auto_increment,
	brand_idx int not null,
	name varchar(50) not null,
	price int not null,
	fsname text not null,
	fname text not null,
);

delete from orderhistory;
delete from orderhistory_detail;
delete from review;
SELECT idx FROM member ORDER BY idx DESC LIMIT 0, 1;

SELECT r.*, g.name AS goods_Name, b.name AS brand_Name, go.goods_option AS option_Name, m.name AS member_Name, count(*) AS review_Cnt
		FROM review r
		JOIN goods g ON g.idx = r.goods_idx
		JOIN orderHistory_detail oh ON oh.idx = r.orderHistory_detail_idx
		JOIN goods_option go ON go.option_idx = oh.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		JOIN member m ON m.idx = r.member_idx
		WHERE r.goods_idx = 33; 
		
SELECT *, (SELECT count(*) FROM COUPON WHERE member_idx = 16;) AS coupon_Count, (SELECT count(*) FROM orderhistory_detail ohd JOIN orderhistory oh ON oh.idx = ohd.orderhistory_idx WHERE ohd.status = '구매확정' AND ohd.review_status = '미작성' AND oh.member_idx = 16;) AS review_Count
		FROM member 
		WHERE idx = 16;

SELECT *,
    (SELECT COUNT(*) FROM COUPON WHERE member_idx = 16) AS coupon_Count,
    (SELECT COUNT(*) FROM orderhistory_detail ohd 
    JOIN orderhistory oh ON oh.idx = ohd.orderhistory_idx 
    WHERE ohd.status = '구매확정' AND ohd.review_status = '미작성' AND oh.member_idx = 16) AS review_Count
FROM member 
WHERE idx = 16;
		

SELECT r.*, g.name AS goods_Name, b.name AS brand_Name, go.goods_option AS option_Name, m.name AS member_Name, (SELECT count(*) FROM review r2 WHERE r2.goods_idx = 33) AS review_Cnt
FROM review r
JOIN goods g ON g.idx = r.goods_idx
JOIN orderHistory_detail oh ON oh.idx = r.orderHistory_detail_idx
JOIN goods_option go ON go.option_idx = oh.option_idx
JOIN brand b ON b.idx = g.brand_idx
JOIN member m ON m.idx = r.member_idx
WHERE r.goods_idx = 33;
		
SELECT COUNT(*)
			FROM maincategory
			JOIN subcategory ON maincategory.Category_Idx = subcategory.category_idx
			JOIN secondcategory ON subcategory.subCategory_Idx = secondcategory.subcategory_idx
			JOIN goods ON secondcategory.secondCategory_Idx = goods.secondcategory_idx
			JOIN brand ON brand.idx = goods.brand_idx
			WHERE maincategory.Category_Idx = 2;

SELECT r.*, g.name, b.name, go.goods_option, m.name
		FROM review r
		JOIN goods g ON g.idx = r.goods_idx
		JOIN orderHistory_detail oh ON oh.idx = r.orderHistory_detail_idx
		JOIN goods_option go ON go.option_idx = oh.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		JOIN member m ON m.idx = r.member_idx
		WHERE r.goods_idx = 33; 

		
create table review(
	idx int not null auto_increment,
	goods_Idx int not null,
	member_Idx int not null,
	orderHistory_Detail_Idx int not null,
	fsname text,
	fname text,
	content text not null,
	score int not null,
	wDate datetime default now(),
	confirm varchar(10) default '미승인',
	primary key(idx),
	foreign key(goods_Idx) REFERENCES goods(idx),
	foreign key(member_Idx) REFERENCES member(idx),
	foreign key(orderHistory_Detail_Idx) REFERENCES orderHistory_Detail(idx)
);

SELECT r.*, g.name, b.name, go.goods_option, m.name
		FROM review r
		JOIN goods g ON g.idx = r.goods_idx
		JOIN goods_option go ON go.option_idx = g.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		JOIN member m ON m.idx = r.member_idx
		WHERE r.goods_idx = 33; 

select * from goods_option;
select * from goods;
drop table review;
show tables;

select * from 

SELECT  g.*, b.name as brand_Name
		FROM orderhistory_detail ohd
		JOIN goods g ON g.idx = ohd.goods_Idx
		JOIN brand b ON b.idx = g.brand_Idx

		WHERE ohd.idx = 133;

SELECT  g.name AS order_Name, g.thumbnail AS order_ThumbNail, go.goods_option AS order_Option, b.name as order_Brand
		FROM orderhistory_detail ohd
		JOIN goods g ON g.idx = ohd.goods_Idx
		JOIN brand b ON b.idx = g.brand_Idx
		JOIN goods_option go ON go.option_idx = ohd.option_Idx
		WHERE ohd.idx = 133;
		
delete from goods;
delete from goods_stock;
delete from cart;
delete from orderhistory_detail;
delete from orderhistory;
delete from refund WHERE orderhistory_detail_idx = (SELECT idx FROM orderhistory_detail WHERE goods_idx = 24);
delete from goods_image;
delete from exchange;
desc goods;

select * from orderhistory_detail;
select * from goods_image;

SELECT orderhistory_idx FROM orderhistory_detail WHERE goods_idx = 24;

select * from orderhistory_detail;
show tables;

create table goods_image(
	idx int not null auto_increment,
	goods_idx int not null,
	fName varchar(255),
	fSName varchar(255),
	primary key(idx),
	foreign key(goods_idx) REFERENCES goods(idx)
);

select * from goods_image;

select * from goods_stock;

SELECT * 
FROM subCategory sc
JOIN maincategory m = m.category_idx = sc.category_idx
WHERE sc.category_idx = 1;

select * from subcategory;
select * from maincategory;
select * from member where birthday = now();

 SELECT * FROM member WHERE DATE(birthday) = CURDATE();

SELECT ohd.idx, ohd.orderhistory_idx, oh.orderdate, ohd.returns_status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
		FROM orderhistory_detail ohd
		JOIN orderhistory oh ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE ohd.idx = 5;

SELECT g.thumbnail AS goods_ThumbNail, g.name AS goods_Name, b.name AS goods_Brand, go.goods_option AS goods_Option, ed.stock, go2.goods_option, sum(ed.stock) AS dd
		FROM exchange_detail ed
		JOIN goods_option go ON go.option_idx = ed.option_idx
		JOIN goods g ON g.idx = ed.goods_idx
		JOIN brand b ON b.idx = g.brand_idx
		JOIN exchange e ON e.idx = ed.exchange_idx
		JOIN orderHistory_detail ohd ON ohd.idx = e.orderhistory_detail_idx
		JOIN goods_option go2 ON go2.option_idx = ohd.option_idx
		WHERE ed.exchange_idx = 3
		GROUP BY 
    g.thumbnail, 
    g.name, 
    b.name, 
    go.goods_option, 
    ohd.option_idx, 
    go2.goods_option;

SELECT 
    g.thumbnail AS goods_ThumbNail, 
    g.name AS goods_Name, 
    b.name AS goods_Brand, 
    go.goods_option AS goods_Option, 
    SUM(ed.stock) AS total_Stock, -- stock 값을 모두 더한 값
    ohd.option_idx, 
    go2.goods_option
FROM exchange_detail ed
JOIN goods_option go ON go.option_idx = ed.option_idx
JOIN goods g ON g.idx = ed.goods_idx
JOIN brand b ON b.idx = g.brand_idx
JOIN exchange e ON e.idx = ed.exchange_idx
JOIN orderHistory_detail ohd ON ohd.idx = e.orderhistory_detail_idx
JOIN goods_option go2 ON go2.option_idx = ohd.option_idx
WHERE ed.exchange_idx = 3
GROUP BY 
    g.thumbnail,
    g.name, 
    b.name, 
    go.goods_option, 
    ohd.option_idx, 
    go2.goods_option;

CREATE TABLE Coupon (
  idx INT not null AUTO_INCREMENT PRIMARY KEY,
  member_Idx INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  dcPercentage INT NOT NULL,
  issuedDate DATETIME DEFAULT now(),
  usageDate DATETIME DEFAULT (DATE_ADD(now(), INTERVAL 1 YEAR)),
  status BOOLEAN DEFAULT FALSE,
  usedDate DATETIME,
  FOREIGN KEY (member_idx) REFERENCES Member(idx)
);
select * from coupon;
desc coupon;
SELECT 
    g.thumbnail AS goods_ThumbNail, 
    g.name AS goods_Name, 
    b.name AS goods_Brand, 
    go.goods_option AS goods_Option,
    ed.stock,
    (
        SELECT SUM(ed2.stock) 
        FROM exchange_detail ed2
        JOIN exchange e2 ON e2.idx = ed2.exchange_idx
        JOIN orderHistory_detail ohd2 ON ohd2.idx = e2.orderhistory_detail_idx
        WHERE ohd2.option_idx = ohd.option_idx
    ) AS total_Stock,
    go2.goods_option AS order_Option
FROM exchange_detail ed
JOIN goods_option go ON go.option_idx = ed.option_idx
JOIN goods g ON g.idx = ed.goods_idx
JOIN brand b ON b.idx = g.brand_idx
JOIN exchange e ON e.idx = ed.exchange_idx
JOIN orderHistory_detail ohd ON ohd.idx = e.orderhistory_detail_idx
JOIN goods_option go2 ON go2.option_idx = ohd.option_idx
WHERE ed.exchange_idx = 3;
   
drop table orderHistory_detail;
drop table orderHistory;
drop table refund;
drop table exchange;
drop table exchange_detail;

select * from orderHistory_detail;


select * from orderhistory



select * from exchange;


select * from exchange_detail;
select * from refund;
select g.thumbnail, g.name, b.name, go.goods_option, ed.stock
from exchange_detail ed
join goods_option go on go.option_idx = ed.option_idx
join goods g on g.idx = ed.goods_idx
JOIN brand b ON b.idx = g.brand_idx;

SELECT ohd.idx, ohd.orderhistory_idx, oh.shipping_num, oh.orderdate, oh.status, ohd.returns_status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand, g.price AS goods_Price
		FROM orderhistory oh
		JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE oh.member_idx = 
		ORDER BY ohd.idx DESC;

SELECT ohd.idx, ohd.orderhistory_idx, oh.orderdate, ohd.returns_status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
		FROM orderhistory oh
		JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE oh.idx = 21;

SELECT ohd.idx, ohd.orderhistory_idx, oh.shipping_num, oh.orderdate, oh.status, ohd.returns_status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
FROM orderhistory oh
JOIN orderhistory_detail ohd ON oh.idx = ohd.orderhistory_idx
JOIN goods g ON g.idx = ohd.goods_idx
JOIN goods_option go ON go.option_idx = ohd.option_idx
JOIN brand b ON b.idx = g.brand_idx
WHERE oh.member_idx = 11;

SELECT ohd.idx, ohd.orderhistory_idx, oh.shipping_num, oh.orderdate, oh.status, ohd.returns_status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
		FROM orderhistory_detail ohd
		JOIN orderhistory oh ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE ohd.idx = 23;


SELECT cart.idx AS idx, goods.thumbnail AS order_ThumbNail, brand.name AS order_Brand, goods.name AS order_Name, goods_option.goods_option AS order_Option, goods.price AS order_Price,  cart.stock AS order_Stock, cart.goods_idx, cart.option_idx
		FROM cart
		JOIN goods ON goods.idx = cart.goods_idx
		JOIN goods_option ON goods_option.option_idx = cart.option_idx
		JOIN brand ON brand.idx = goods.brand_idx
		WHERE cart.idx = 23;
		
		
select * from refund;
select * from cart;
select * from orderhistory;
select * from orderhistory_detail;
create table cart(
	idx int not null auto_increment,
	member_Idx int not null,
	goods_Idx int not null,
	option_Idx int not null,
	stock int not null,
	primary key(idx),
	foreign key(member_idx) REFERENCES member(idx),
	foreign key(goods_idx) REFERENCES goods(idx),
	foreign key(option_idx) REFERENCES goods_option(option_idx)
);

CREATE TABLE goods_option(
	option_idx INT NOT NULL AUTO_INCREMENT,
	goods_option VARCHAR(20) NOT NULL,
	primary key(option_idx)
);

CREATE TABLE goods_stock(
	goods_idx int not null,
	option_idx int not null,
	stock int not null,
	primary key(goods_idx,option_idx),
	foreign key(goods_idx) REFERENCES goods(idx),
	foreign key(option_idx) REFERENCES goods_option(option_idx)
);

create table member_shippingAddress(
	idx int not null auto_increment,
	member_idx int not null,
	ship_name varchar(255) not null,
	ship_telNum varchar(255) not null,
	ship_address varchar(255) not null,
	primary key(idx),
	foreign key(member_idx) references member(idx)
);

create table orderhistory(
	idx int not null auto_increment,
	member_idx int not null,
	orderdate datetime default now(),
	finalprice int not null,
	shipping_num int,
	Recipient_name varchar(255) not null,
	Recipient_telNum varchar(255) not null,
	Recipient_Address varchar(255) not null,
	primary key(idx),
	foreign key(member_idx) references member(idx)
);
select * from member;
INSERT INTO orderHistory(idx, member_idx, orderdate, finalprice, category) VALUES(default, 11, default, 2000, '환불');

SELECT oh.idx as orderhistory_idx, COUNT(od.idx) as orderhistory_detail_count
FROM orderhistory oh
LEFT JOIN orderhistory_detail od ON oh.idx = od.orderhistory_idx
GROUP BY oh.idx;

SELECT COUNT(od.idx) as orderhistory_detail_count
FROM orderhistory oh
LEFT JOIN orderhistory_detail od ON oh.idx = od.orderhistory_idx
WHERE oh.idx = 84;

create table orderhistory_detail(
	idx int not null auto_increment,
	orderhistory_idx int not null,
	goods_idx int not null,
	option_idx int not null,
	goods_stock int not null,
	status varchar(50) not null default '결제완료',
	primary key(idx),
	foreign key(orderhistory_idx) references orderhistory(idx),
	foreign key(goods_idx) references goods(idx),
	foreign key(option_idx) references goods_option(option_idx)
);

create table refund(
	idx int not null auto_increment,
	orderhistory_detail_idx int not null,
	stock int not null,
	reason varchar(255) not null,
	refundPrice int not null,
	applicationDate datetime default now(),
	status varchar(255) default '신청접수',	
	primary key(idx),
	foreign key(orderhistory_detail_idx) references orderhistory_detail(idx)
);
drop table exchange;
create table exchange(
	idx int not null auto_increment,
	orderhistory_detail_idx int not null,
	applicationDate datetime default now(),
	reason varchar(255) not null,
	shipping_num int,
	Recipient_name varchar(255) not null,
	Recipient_telNum varchar(255) not null,
	Recipient_Address varchar(255) not null,
	status varchar(255) default '신청접수',
	primary key(idx),
	foreign key(orderhistory_detail_idx) references orderhistory_detail(idx)
);
SELECT ohd.idx, ohd.orderhistory_idx, oh.shipping_num, oh.orderdate, oh.status, ohd.returns_status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand, g.price AS goods_Price, oh.recipient_Name, oh.recipient_telNum, oh.recipient_Address
		FROM orderhistory_detail ohd
		JOIN orderhistory oh ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE ohd.idx = 27;


select * from orderhistory_detail;
create table exchange_detail(
	idx int not null auto_increment,
	exchange_Idx int not null,
	goods_Idx int not null,
	option_Idx int not null,
	stock int not null,
	primary key(idx),
	foreign key(exchange_Idx) references exchange(idx)
);

create table brand(
	idx int not null auto_increment,
	name varchar(20) not null,
	content varchar(255) not null,
	brand_like int default 0,
	primary key(idx)
);

CREATE TABLE maincategory (
    Category_Idx INT NOT NULL AUTO_INCREMENT,
    Category_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Category_Idx)
);
select * from maincategory;
CREATE TABLE subcategory (
    subCategory_Idx INT NOT NULL AUTO_INCREMENT,
    subCategory_Name VARCHAR(255) NOT NULL,
    category_idx int not null,
    PRIMARY KEY (subCategory_Idx),
    FOREIGN KEY(category_idx) REFERENCES maincategory(Category_Idx)
);
SELECT sc.subcategory_idx, sc.subcategory_name, m.category_Name AS maincategory_name
FROM subCategory sc
JOIN maincategory m ON m.category_idx = sc.category_idx
WHERE sc.category_idx = 1;

SELECT scc.secondcategory_idx, scc.secondcategory_name, sc.subCategory_Name, m.category_Name AS maincategory_name 
FROM secondcategory scc
JOIN subCategory sc ON sc.subcategory_idx = scc.subcategory_idx
JOIN mainCategory m ON m.category_idx = sc.category_idx
WHERE scc.subcategory_idx = 2;


select * from subcategory;
select * from secondcategory;

select * from secondCategory;
CREATE TABLE secondcategory (
    secondCategory_Idx INT NOT NULL AUTO_INCREMENT,
    secondCategory_Name VARCHAR(255) NOT NULL,
    subcategory_idx int not null,
    PRIMARY KEY (secondCategory_Idx),
    FOREIGN KEY(subcategory_idx) REFERENCES subcategory(subcategory_idx)
);

show tables;


INSERT INTO goods_option VALUES(default,'XS');
INSERT INTO goods_option VALUES(default,'S');
INSERT INTO goods_option VALUES(default,'M');
INSERT INTO goods_option VALUES(default,'L');
INSERT INTO goods_option VALUES(default,'XL');
INSERT INTO goods_option VALUES(default,'220');
INSERT INTO goods_option VALUES(default,'230');
INSERT INTO goods_option VALUES(default,'240');
INSERT INTO goods_option VALUES(default,'250');
INSERT INTO goods_option VALUES(default,'260');
INSERT INTO goods_option VALUES(default,'270');
INSERT INTO goods_option VALUES(default,'280');
INSERT INTO goods_option VALUES(default,'290');
INSERT INTO goods_option VALUES(default,'26');
INSERT INTO goods_option VALUES(default,'28');
INSERT INTO goods_option VALUES(default,'30');
INSERT INTO goods_option VALUES(default,'32');
INSERT INTO goods_option VALUES(default,'34');
INSERT INTO goods_option VALUES(default,'36');
INSERT INTO goods_option VALUES(default,'FREE');


INSERT INTO maincategory values(default,'남자');
INSERT INTO maincategory values(default,'여자');
INSERT INTO maincategory values(default,'생활');


INSERT INTO subcategory VALUES(default,'자켓',1);
INSERT INTO subcategory VALUES(default,'스웨트 & 니트',1);
INSERT INTO subcategory VALUES(default,'셔츠',1);
INSERT INTO subcategory VALUES(default,'티셔츠',1);
INSERT INTO subcategory VALUES(default,'바지',1);
INSERT INTO subcategory VALUES(default,'반바지',1);
INSERT INTO subcategory VALUES(default,'수영복 & 언더웨어',1);
INSERT INTO subcategory VALUES(default,'신발',1);
INSERT INTO subcategory VALUES(default,'모자',1);
INSERT INTO subcategory VALUES(default,'가방',1);
INSERT INTO subcategory VALUES(default,'액세서리',1);

INSERT INTO subcategory VALUES(default,'자켓',2);
INSERT INTO subcategory VALUES(default,'스웨트 & 니트',2);
INSERT INTO subcategory VALUES(default,'셔츠',2);
INSERT INTO subcategory VALUES(default,'티셔츠',2);
INSERT INTO subcategory VALUES(default,'스커트',2);
INSERT INTO subcategory VALUES(default,'바지',2);
INSERT INTO subcategory VALUES(default,'반바지',2);
INSERT INTO subcategory VALUES(default,'수영복 & 언더웨어',2);
INSERT INTO subcategory VALUES(default,'신발',2);
INSERT INTO subcategory VALUES(default,'모자',2);
INSERT INTO subcategory VALUES(default,'가방',2);
INSERT INTO subcategory VALUES(default,'액세서리',2);


INSERT INTO secondcategory VALUES
(DEFAULT, '라이트', 1),
(DEFAULT, '헤비', 1),
(DEFAULT, '크루', 2),
(DEFAULT, '후드', 2),
(DEFAULT, '풀오버', 2),
(DEFAULT, '가디건', 2),
(DEFAULT, '긴팔 셔츠', 3),
(DEFAULT, '반팔 셔츠', 3),
(DEFAULT, '긴팔 티셔츠', 4),
(DEFAULT, '반팔 티셔츠', 4),
(DEFAULT, '치노', 5),
(DEFAULT, '데님', 5),
(DEFAULT, '트라우져', 5),
(DEFAULT, '스웨트', 5),
(DEFAULT, '워크', 5),
(DEFAULT, '카고', 5),
(DEFAULT, '기타', 5),
(DEFAULT, '치노', 6),
(DEFAULT, '데님', 6),
(DEFAULT, '스웨트', 6),
(DEFAULT, '워크', 6),
(DEFAULT, '카고', 6),
(DEFAULT, '기타', 6),
(DEFAULT, '수영복', 7),
(DEFAULT, '속옷', 7),
(DEFAULT, '양말', 7),
(DEFAULT, '운동화', 8),
(DEFAULT, '구두', 8),
(DEFAULT, '슬리퍼', 8),
(DEFAULT, '캡', 9),
(DEFAULT, '버킷', 9),
(DEFAULT, '비니', 9),
(DEFAULT, '페도라', 9),
(DEFAULT, '클래식', 9),
(DEFAULT, '백팩', 10),
(DEFAULT, '스몰백', 10),
(DEFAULT, '토트백', 10),
(DEFAULT, '기타', 10),
(DEFAULT, '기타', 11),
(DEFAULT, '벨트', 11),
(DEFAULT, '지갑', 11),
(DEFAULT, '시계', 11),
(DEFAULT, '스카프', 11),
(DEFAULT, '열쇠고리', 11),
(DEFAULT, '쥬얼리', 11),
(DEFAULT, '장갑', 11),
(DEFAULT, '선글라스', 11);


INSERT INTO secondcategory VALUES
(DEFAULT, '라이트', 12),
(DEFAULT, '헤비', 12),
(DEFAULT, '크루', 13),
(DEFAULT, '후드', 13),
(DEFAULT, '풀오버', 13),
(DEFAULT, '가디건', 13),
(DEFAULT, '긴팔 셔츠', 14),
(DEFAULT, '반팔 셔츠', 14),
(DEFAULT, '긴팔 티셔츠', 15),
(DEFAULT, '반팔 티셔츠', 15),
(DEFAULT, '스커트', 16),
(DEFAULT, '치노', 17),
(DEFAULT, '데님', 17),
(DEFAULT, '트라우져', 17),
(DEFAULT, '스웨트', 17),
(DEFAULT, '워크', 17),
(DEFAULT, '카고', 17),
(DEFAULT, '기타', 17),
(DEFAULT, '치노', 18),
(DEFAULT, '데님', 18),
(DEFAULT, '스웨트', 18),
(DEFAULT, '워크', 18),
(DEFAULT, '카고', 18),
(DEFAULT, '기타', 18),
(DEFAULT, '수영복', 19),
(DEFAULT, '속옷', 19),
(DEFAULT, '양말', 19),
(DEFAULT, '운동화', 20),
(DEFAULT, '구두', 20),
(DEFAULT, '슬리퍼', 20),
(DEFAULT, '캡', 21),
(DEFAULT, '버킷', 21),
(DEFAULT, '비니', 21),
(DEFAULT, '페도라', 21),
(DEFAULT, '클래식', 21),
(DEFAULT, '백팩', 22),
(DEFAULT, '스몰백', 22),
(DEFAULT, '토트백', 22),
(DEFAULT, '기타', 22),
(DEFAULT, '기타', 23),
(DEFAULT, '벨트', 23),
(DEFAULT, '지갑', 23),
(DEFAULT, '시계', 23),
(DEFAULT, '스카프', 23),
(DEFAULT, '열쇠고리', 23),
(DEFAULT, '쥬얼리', 23),
(DEFAULT, '장갑', 23),
(DEFAULT, '선글라스', 23);
INSERT INTO subcategory VALUES(default)
