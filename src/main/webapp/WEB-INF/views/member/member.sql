create table member(
	idx int not null auto_increment,
	emailId varchar(50) not null,
	pwd varchar(100) not null,
	name varchar(20) not null,
	gender varchar(10) not null,
	birthday datetime not null,
	telNum varchar(15) not null,
	level int default 1,
	totVisitCnt int default 0,
	firstJoinDay datetime default now(),
	lastVisitDay datetime default now(),
	todayVisitCnt int default 0,
	memberDel varchar(10) default 'NO',
	point int default 1000,
	primary key(idx)
);

SELECT m.*, COUNT(o.idx) AS order_count
FROM member m
LEFT JOIN orderhistory o ON m.idx = o.member_idx
GROUP BY m.idx;

insert into member values(default,'dd','dd','dd','s  s','20190101','d',default,default,default,default,default,default,default);

select * from member;