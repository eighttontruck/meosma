CREATE TABLE inquiry (
  idx INT not null AUTO_INCREMENT PRIMARY KEY,
  Member_Idx INT not null,
  Product_Idx INT not null,
  category VARCHAR(255) not null,
  title VARCHAR(255) not null,
  content VARCHAR(255) not null,
  wdate DATE not null,
  ansWhether BOOLEAN default false,
  lockWhether BOOLEAN default false,
  answerContent text,
  ansDate DATE,
  FOREIGN KEY (Member_idx) REFERENCES member(idx),
  FOREIGN KEY (Product_Idx) REFERENCES product(idx)
);

desc inquiry;

drop table inquiry;

insert into inquiry  values(default,1,1, )

select count(Inquiry_Idx) from inquiry where Product_idx=1 order by Inquiry_Idx desc;