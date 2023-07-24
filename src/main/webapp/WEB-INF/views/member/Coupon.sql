CREATE TABLE Coupon (
  idx INT AUTO_INCREMENT PRIMARY KEY,
  member_Idx INT not null,
  name VARCHAR(255) not null,
  dcPercentage INT not null,
  issuedDate datetime default now(),
  usageDate datetime default DATE_ADD(now(), INTERVAL 1 YEAR),
  usedDate datetime default now(),
  FOREIGN KEY (member_Idx) REFERENCES Member(idx)
);

SELECT ohd.idx, ohd.orderhistory_idx, oh.orderdate, ohd.goods_idx, ohd.option_idx, ohd.goods_stock, ohd.totalPrice, g.thumbnail AS goods_thumbnail, g.name AS goods_name, go.goods_option, b.name AS goods_brand
	FROM orderhistory oh
	LEFT JOIN orderhistory_detail ohd ON ohd.orderhistory_idx = oh.idx
	LEFT JOIN goods g ON g.idx = ohd.goods_idx
	LEFT JOIN goods_option go ON go.option_idx = ohd.option_idx
	LEFT JOIN brand b ON b.idx = g.brand_idx
	WHERE oh.member_idx = 4
	ORDER BY ohd.idx DESC;

desc member;
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
select * from member;
insert into coupon(idx,member_idx,name,dcPercentage,issueddate,usageDate,status) values(default, 11,'가입기념쿠폰',10,default,default,default)

drop table COupon;
UPDATE coupon
SET status = true ,usedDate = now()
WHERE idx = 1;

select * from coupon;
desc coupon;

drop table coupon;