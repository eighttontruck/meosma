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

select * from brand;


SELECT b.idx, b.name, b.content, b.brand_like, COUNT(g.idx) AS goods_Count
		FROM brand b
		LEFT JOIN goods g ON b.idx = g.brand_idx
		GROUP BY b.idx, b.name, b.content;
	
		
select cart.idx as idx, goods.thumbnail AS order_ThumbNail, brand.name AS order_Brand, goods.name AS order_Name, goods_option.goods_option AS order_Option, goods.price AS order_Price,  cart.stock AS order_Stock, cart.goods_idx, cart.option_idx
from cart
join goods on goods.idx = cart.goods_idx
join goods_option on goods_option.option_idx = cart.option_idx
join brand on brand.idx = goods.brand_idx
where cart.member_idx =4;
		
SELECT brand.idx, brand.name, brand.content, brand.brand_like, COUNT(goods.idx) AS goods_Count
FROM brand
LEFT JOIN goods ON brand.idx = goods.brand_idx
WHERE brand.name LIKE CONCAT('%','car','%')
GROUP BY brand.idx 
ORDER BY goods_Count ASC
AND brand.idx DESC LIMIT 1, 10;
	
SELECT brand.idx, brand.name, brand.content, brand.brand_like, COUNT(goods.idx) AS goods_Count
FROM brand
LEFT JOIN goods ON brand.idx = goods.brand_idx
WHERE brand.name LIKE CONCAT('%','car','%')
GROUP BY brand.idx 
ORDER BY goods_Count ASC, brand.idx DESC 
LIMIT 0, 15;

SELECT brand.idx, brand.name, brand.content, brand.brand_like, COUNT(goods.idx) AS goods_Count
			FROM brand
			LEFT JOIN goods ON brand.idx = goods.brand_idx
			GROUP BY brand.idx
			ORDER BY idx DESC LIMIT 0, 111;
			
SELECT brand.idx, brand.name, brand.content, brand.brand_like, COUNT(goods.idx) AS goods_Count
FROM brand
LEFT JOIN goods ON brand.idx = goods.brand_idx
WHERE brand.name LIKE CONCAT('%','car','%')
GROUP BY brand.idx 
ORDER BY goods_Count ASC, brand.idx DESC
LIMIT 0, 10;

SELECT b.idx, b.name, b.content, b.brand_like, COUNT(g.idx) AS goods_Count
FROM brand b
LEFT JOIN goods g ON b.idx = g.brand_idx
GROUP BY b.idx, b.name, b.content
ORDER BY b.name DESC;

SELECT brand.idx, brand.name, brand.content, COUNT(goods.idx) AS goodsCount
FROM brand
LEFT JOIN goods ON brand.idx = goods.brand_idx
GROUP BY brand.idx
ORDER BY goodsCount DESC;

SELECT b.idx, b.name, b.content, COUNT(g.idx) AS goods_Count
		FROM brand b
		LEFT JOIN goods g ON b.idx = g.brand_idx
		GROUP BY b.idx, b.name, b.content;

SELECT COUNT(*)
FROM brand
LEFT JOIN goods ON brand.idx = goods.brand_idx
GROUP BY brand.idx, brand.name, brand.content;
ORDER BY goods.idx ASC;
		
SELECT COUNT(*)
			FROM goods
			JOIN brand ON goods.brand_idx = brand.idx 
			WHERE idx LIKE CONCAT('%','1','%');

SELECT COUNT(goods.idx)
FROM maincategory
LEFT JOIN subcategory ON maincategory.Category_Idx = subcategory.category_idx
LEFT JOIN secondcategory ON subcategory.subCategory_Idx = secondcategory.subcategory_idx
LEFT JOIN goods ON secondcategory.secondCategory_Idx = goods.secondcatagory_idx
GROUP BY maincategory.Category_Idx, maincategory.Category_Name;

SELECT COUNT(*)
FROM maincategory
JOIN subcategory ON maincategory.Category_Idx = subcategory.category_idx
JOIN secondcategory ON subcategory.subCategory_Idx = secondcategory.subcategory_idx
JOIN goods ON secondcategory.secondCategory_Idx = goods.secondcatagory_idx
WHERE maincategory.Category_Idx = 1;

SELECT COUNT(*) AS Goods_Count
FROM goods
WHERE secondcatagory_idx IN (
    SELECT secondCategory_Idx
    FROM secondcategory
    WHERE subcategory_idx IN (
        SELECT subCategory_Idx
        FROM subcategory
        WHERE category_idx = <입력받은 카테고리_인덱스>
    )
);
select * from cart;

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

select * from goods_option;
select * from member;
select * from brand;
select * from orderhistory;
delete from brand;
select * from goods_stock;
delete from goods_stock;
select * from orderhis

SELECT goods.idx, goods.name, goods.price, goods.Thumbnail, goods.goods_like, goods.secondcatagory_idx, brand.name as brand_Name
		FROM goods
		JOIN brand ON goods.brand_idx = brand.idx
		WHERE brand.name='아디다스';

SELECT COUNT(*)
FROM maincategory
JOIN subcategory ON maincategory.Category_Idx = subcategory.category_idx
JOIN secondcategory ON subcategory.subCategory_Idx = secondcategory.subcategory_idx
JOIN goods ON secondcategory.secondCategory_Idx = goods.secondcatagory_idx
JOIN brand ON goods.brand_idx = brand.idx
WHERE maincategory.Category_Idx = 3
AND brand.name LIKE CONCAT('%','아디','%');

select * from goods;

select * from secondcategory;
select * from subcategory;
select * from maincategory;

SELECT goods.idx, goods.name, goods.price, goods.Thumbnail, goods.goods_like, goods.secondcatagory_idx, brand.name as brand_Name 
FROM goods
JOIN brand ON goods.brand_idx = brand.idx
ORDER BY idx DESC LIMIT 0, 15;

SELECT goods.idx, goods.name, goods.price, goods.Thumbnail, goods.goods_like, goods.secondcatagory_idx, brand.name as brand_Name
FROM goods
JOIN brand ON goods.brand_idx = brand.idx 
WHERE price BETWEEN 10000 AND 20000;

AND 
price BETWEEN #{startDate} AND #{endDate};
		
SELECT mc.category_idx, sc.subcategory_idx, scc.secondcategory_idx, mc.category_name, sc.subcategory_name,  scc.secondcategory_name
		FROM secondcategory scc
		JOIN subcategory sc ON sc.subcategory_idx = scc.subcategory_idx
		JOIN maincategory mc ON mc.category_idx = sc.category_idx
		where scc.secondCategory_Idx = 4;


SELECT b.idx, b.name, b.content, COUNT(g.idx) AS product_count
FROM brand b
LEFT JOIN goods g ON b.idx = g.brand_idx
GROUP BY b.idx, b.name, b.content;

SELECT m.idx, m.emailid, m.name, m.gender, m.birthday, m.telNum, m.level, m.firstjoinday, m.lastvisitday, COUNT(oh.idx)
FROM member m
LEFT JOIN orderhistory oh ON oh.member_idx = m.idx
GROUP BY m.idx, m.emailid, m.name, m.gender, m.birthday, m.telNum, m.level, m.firstjoinday, m.lastvisitday;

CREATE TABLE goods_option(
	option_idx INT NOT NULL AUTO_INCREMENT,
	goods_option VARCHAR(20) NOT NULL,
	primary key(option_idx)
);

select * from brand;
desc brand;

select * from goods;

SELECT ohd.idx, ohd.orderhistory_idx, ohd.option_idx , ohd.option_idx , ohd.goods_stock , ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name , go.goods_option
FROM orderhistory oh 
JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
JOIN goods g ON g.idx = ohd.goods_idx
JOIN goods_option go ON go.option_idx = ohd.option_idx
WHERE oh.member_idx = 4;

SELECT ohd.idx, ohd.orderhistory_idx, oh.orderdate, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
		FROM orderhistory oh 
		JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE oh.member_idx = 4;

SELECT ohd.idx, ohd.orderhistory_idx, oh.orderdate, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
		FROM orderhistory oh
		JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE oh.member_idx = 4
		ORDER BY ohd.idx DESC;
		
select  * from brand;
CREATE TABLE goods_stock(
	goods_idx int not null,
	option_idx int not null,
	stock int not null,
	primary key(goods_idx,option_idx),
	foreign key(goods_idx) REFERENCES goods(idx),
	foreign key(option_idx) REFERENCES goods_option(option_idx)
);

SELECT ohd.idx, ohd.orderhistory_idx, oh.orderdate, oh.status, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
		FROM orderhistory oh
		JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
		JOIN goods g ON g.idx = ohd.goods_idx
		JOIN goods_option go ON go.option_idx = ohd.option_idx
		JOIN brand b ON b.idx = g.brand_idx
		WHERE oh.idx = 1
		ORDER BY ohd.idx DESC;

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
	status varchar(50) not null default '결제완료',
	shipping_num int,
	Recipient_name varchar(255) not null,
	Recipient_telNum varchar(255) not null,
	Recipient_Address varchar(255) not null,
	primary key(idx),
	foreign key(member_idx) references member(idx)
);
desc orderhistory;

SELECT * FROM orderHistory;

select * from orderHistory;
select * from orderHistory_detail;

create table orderhistory_detail(
	idx int not null auto_increment,
	orderhistory_idx int not null,
	goods_idx int not null,
	option_idx int not null,
	goods_stock int not null,
	totalPrice int not null,
	returns_status varchar(50) not null default '요청 없음',
	primary key(idx),
	foreign key(orderhistory_idx) references orderhistory(idx),
	foreign key(goods_idx) references goods(idx),
	foreign key(option_idx) references goods_option(option_idx)
);

drop table orderhistory_detail;
drop table orderhistory;
select * from brand;

select * from orderhistory;
select * from orderhistory_detail;
delete from orderhistory where idx =2;

select * from member;


select b.idx, b.name, b.content, b.brand_like
from goods g
join brand b on b.idx = g.brand_idx
where g.idx=1;

select g.idx

SELECT goods.idx, goods.name, goods.price, goods.Thumbnail, goods.goods_like, goods.secondcatagory_idx, brand.name as brand_Name
		FROM goods
		JOIN brand ON goods.brand_idx = brand.idx;

select * from brand;
select * from goods;

select * from stock;

select * from goods_stock;

select * from goods_option;

select * from brand where idx = 5;

desc brand;

g

SELECT gs.goods_idx, gs.option_idx, gs.stock, go.goods_option
		FROM goods_stock gs
		JOIN goods_option go ON gs.option_idx = go.option_idx
		WHERE gs.goods_idx=1;

select * from goods_stock;
select gs.goods_idx, gs.option_idx, gs.stock, go.goods_option
from goods_stock gs
join goods_option go on gs.option_idx = go.option_idx
where gs.goods_idx=1;

create table brand(
	idx int not null auto_increment,
	name varchar(20) not null,
	content varchar(255) not null,
	brand_like int default 0,
	primary key(idx)
);

SELECT goods.idx, goods.name, goods.price, goods.Thumbnail, goods.goods_like, goods.secondcatagory_idx, brand.name as brand_Name
FROM brand
JOIN goods ON goods.brand_idx = brand.idx;



select goods_stock.idx, goods_stock.option_idx, goods_stock.stock goods_option.goods_option
from goods_stock
join
where 

SELECT goods.idx, goods.name, goods.price, goods.Thumbnail, goods.goods_like, goods.secondcatagory_idx, brand.name as brand_Name
FROM goods
JOIN brand ON goods.brand_idx = brand.idx;

SELECT g.idx, g.brand_idx, g.name, g.price, g.thumbnail, g.goods_like, g.secondcatagory_idx, b.name
FROM brand b
JOIN goods g ON g.brand_idx = b.idx
WHERE b.idx = 2;

select * from brand;

insert into goods values(default,1,'dd',12,'dd',default,4);
SELECT LAST_INSERT_ID();

select * from brand;
select * from goods_stock;

ALTER TABLE goods_stock AUTO_INCREMENT = 1;

delete from goods where brand_idx=2;

delete from goods_stock where goods_idx=3;

SELECT idx FROM goods order by idx desc limit 0, 1;

SELECT sc.subCategory_Idx, sc.subCategory_Name, mc.Category_Idx
		FROM maincategory mc
		JOIN subcategory sc ON mc.category_Idx = sc.category_Idx
		WHERE mc.Category_Name = '남자';

select * from subCategory where category_idx=1;
SELECT * FROM subCategory WHERE category_idx = 1;

select * 
from secondCategory scc
join subcategory sc on 
		

select * from secondCategory;
select * from goods;

CREATE TABLE maincategory (
    Category_Idx INT NOT NULL AUTO_INCREMENT,
    Category_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Category_Idx)
);
CREATE TABLE subcategory (
    subCategory_Idx INT NOT NULL AUTO_INCREMENT,
    subCategory_Name VARCHAR(255) NOT NULL,
    category_idx int not null,
    PRIMARY KEY (subCategory_Idx),
    FOREIGN KEY(category_idx) REFERENCES maincategory(Category_Idx)
);
CREATE TABLE secondcategory (
    secondCategory_Idx INT NOT NULL AUTO_INCREMENT,
    secondCategory_Name VARCHAR(255) NOT NULL,
    subcategory_idx int not null,
    PRIMARY KEY (secondCategory_Idx),
    FOREIGN KEY(subcategory_idx) REFERENCES subcategory(subcategory_idx)
);

SELECT mc.category_idx, sc.subcategory_idx, scc.secondcategory_idx, mc.category_name, sc.subcategory_name,  scc.secondcategory_name
FROM secondcategory scc
JOIN subcategory sc ON sc.subcategory_idx = scc.subcategory_idx
JOIN maincategory mc ON mc.category_idx = sc.category_idx
where scc.secondCategory_Idx = 58;

insert into brand values(default, 'carharrt','응몰라',default);
insert into brand values(default, '나이키','응몰라',default);
insert into brand values(default, '아디다스','응몰라',default);

select * from goods;
select * from product;
insert into goods values(default,2,'dd',20000,'dad',default,2);

select * from brand;

drop table product;

drop table goods_option;
drop table goods_stock;


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



INSERT INTO goods_stock (goods_idx, option_idx, stock)
VALUES (1, (SELECT option_idx FROM goods_option WHERE goods_option = '270'), 10);

select * from goods_stock;

SELECT option_idx FROM goods_option WHERE goods_option = '270';


SELECT * FROM maincategory;

select * from secondcategory;

select * from subcategory;

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

select * from subcategory;

SELECT mc.Category_Name, sc.subCategory_Name, sc.subCategory_Idx
FROM maincategory mc
JOIN subcategory sc ON mc.Category_Idx = sc.category_idx
JOIN secondcategory sec ON sc.subCategory_Idx = sec.subcategory_idx;

SELECT sc.subcategory_idx, sc.subcategory_name, mc.Category_Idx
FROM maincategory mc
JOIN subcategory sc ON mc.Category_Idx = sc.category_idx
WHERE mc.Category_Name = '남자';

select sc.subcategory_idx, sc.subcategory_name
from maincategory mc
join subcategory sc on 



select * from secondcategory;

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

SELECT scc.secondcategory_idx, scc.secondcategory_name, sc.subcategory_idx
		FROM subcategory sc
		JOIN secondcategory scc ON sc.subcategory_idx = scc.subcategory_idx
		JOIN maincategory mc on sc.category_idx = mc.category_idx
		WHERE sc.subcategory_name = '자켓' and mc.category_name = '남자';