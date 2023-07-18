CREATE TABLE Review (
  idx INT not null AUTO_INCREMENT PRIMARY KEY,
  Member_Idx INT not null,
  Product_Idx INT not null,
  content VARCHAR(255) not null,
  score int not null,
  wdate DATE not null,
  confirm BOOLEAN default false,
  like_count INT default 0,
  FOREIGN KEY (Member_Idx) REFERENCES member(idx),
  FOREIGN KEY (Product_Idx) REFERENCES product(idx)
);

drop table review;