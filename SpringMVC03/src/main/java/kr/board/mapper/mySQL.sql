drop table board;

-- Board 게시판 테이블 생성
create table board(
	idx int not null auto_increment,
	memID varchar(20) not null, -- 수정 할 때 컬럼 추가
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(30) not null,
	indate datetime default now(),
	count int default 0,
	primary key(idx)
);



select * from board;

-- 회원테이블 생성

create table member(
	memIdx int auto_increment,
	memID varchar(20) not null,
	memPassword varchar(20) not null,
	memName varchar(20) not null,
	memAge int,
	memGender varchar(20),
	memEmail varchar(50),
	memProfile varchar(50),
	primary key(memIdx)
);


select * from member;

insert into member(memID, memPassword, memName, memAge, memGender, memEmail)
values('admin','1234','관리자', 20, '남자', 'admin@gmail.com');
insert into member(memID, memPassword, memName, memAge, memGender, memEmail)
values('juhui','1111','이주희', 20, '여자', 'juhui@gmail.com');
insert into member(memID, memPassword, memName, memAge, memGender, memEmail)
values('chicken','7777','병아리', 20, '남자', 'chicken@gmail.com');


delete from member;


















insert into board(title, content, writer)
values('오늘 명성식당 최고','진짜 본토 맛집같음','박병관');
insert into board(title, content, writer)
values('비가와야 당근이 잘 클텐데','당근당근!바니바니!','황해도');
insert into board(title, content, writer)
values('여러분! 옥수수 좋아하시나요?!','제키는 옥수수와 같은 2M입니다','최영화');
insert into board(title, content, writer)
values('JSP&Servlet 어렵지 않아요','사실 재미까지 있어요','이주희');
insert into board(title, content, writer)
values('대접으로 놀러오세요~!','그냥집밥도 좋아요!','조승재');



