/*Amember(회원정보 테이블)*/
CREATE TABLE Amember(
	Amember_num number not null,
	id varchar2(30) unique not null,
	auth number(1) default 2 not null, /*회원 등급:0이 탈퇴회원, 1이 정지회원,2 일반회원,3 관리자*/
	constraint amember_pk primary key(Amember_num)
);

/*Amember_detail(회원 상세 정보 테이블)*/
CREATE TABLE Amember_detail(
	Amember_num number not null,
	name varchar2(30) not null,
	nickname varchar2(30) not null,
	password varchar2(30) not null,
	age date not null,
	phone varchar2(11) not null,
	address varchar2(90) not null,
	address_favor varchar2(90),
	email varchar2(50),
	photo varchar2(150),
	rate number(5),
	reg_date date default SYSDATE not null,
	constraint amember_detail_pk primary key(Amember_num),
	constraint amemeber_detail_fk foreign key (Amember_num) references Amember(Amember_num)
);
create sequence Amember_seq;

/*Acategory(상품 분류 정보 테이블)*/
CREATE TABLE Acategory(
	category number(2) not null,
	name varchar2(90) not null,
	constraint Acategory_pk primary key(category)
);

/*Acategory 초기 데이터 세팅 */
INSERT INTO acategory
	SELECT 1, '디지털기기' FROM DUAL UNION ALL
	SELECT 2, '생활/가전' FROM DUAL UNION ALL
	SELECT 3, '남성의류/잡화' FROM DUAL UNION ALL
	SELECT 4, '여성의류/잡화/미용' FROM DUAL UNION ALL
	SELECT 5, '유아동/유아도서' FROM DUAL UNION ALL
	SELECT 6, '스포츠' FROM DUAL UNION ALL
	SELECT 7, '생활/가구' FROM DUAL;

/*Aproduct(상품정보 테이블)*/
CREATE TABLE Aproduct(
	Aproduct_num number not null,
	Amember_num number not null,
	photo1 varchar2(150) not null,
	photo2 varchar2(150),
	photo3 varchar2(150),
	photo4 varchar2(150),
	photo5 varchar2(150),
	title varchar2(150) not null,
	price number(9) not null,
	content clob not null,
	category number(2) not null,
	reg_date date default SYSDATE,
	modify_date date,
	complete number(1) default 0,
	buyer_num number,
	constraint Aproduct_pk primary key(Aproduct_num),
	constraint Aproduct_fk1 foreign key (Amember_num) references Amember(Amember_num),
	constraint Aproduct_fk2 foreign key (category) references Acategory(category),
	constraint Aproduct_fk3 foreign key (buyer_num) references Amember(Amember_num)
);
create sequence aproduct_seq;

/*Amyproduct(찜한 상품 테이블)*/
CREATE TABLE Amyproduct(
	Amyproduct_num number not null,
	Aproduct_num number not null,
	Amember_num number not null,
	constraint Amyproduct_pk primary key(Amyproduct_num),
	constraint Amyproduct_fk1 foreign key(Aproduct_num) references Aproduct(Aproduct_num),
	constraint Amyproduct_fk2 foreign key(Amember_num) references Amember(Amember_num)
);
create sequence Amyproduct_seq;

/*Amanner(매너 평가 정보 테이블)*/
CREATE TABLE Amanner(
	Amanner_num number not null,
	Amember_num number not null,
	Aproduct_num number not null,
	rate number(1) not null,
	review clob not null,
	buyer_num number not null,
	constraint Amanner_pk primary key(Amanner_num),
	constraint Amanner_fk1 foreign key(Amember_num) references Amember(Amember_num),
	constraint Amanner_fk2 foreign key(Aproduct_num) references Aproduct(Aproduct_num),
	constraint Amanner_fk3 foreign key(buyer_num) references Amember(Amember_num)
);
create sequence Amanner_seq;

/*Acomment(상품 댓글 테이블)*/
CREATE TABLE Acomment(
	Acomment_num number not null,
	Amember_num number not null,
	Aproduct_num number not null,
	content varchar2(900) not null,
	Acomment_parent number,
	reg_date date default sysdate,
	constraint Acomment_pk primary key(Acomment_num),
	constraint Acomment_fk1 foreign key(Amember_num) references Amember(Amember_num),
	constraint Acomment_fk2 foreign key(Aproduct_num) references Aproduct(Aproduct_num)
);
ALTER TABLE Acomment ADD CONSTRAINT Acomment_fk3 foreign key(Acomment_parent) references Acomment(Acomment_num);

/*Aboard(공지 및 회원 상담 테이블)*/
CREATE TABLE Aboard(
	Aboard_num number not null,
	Amember_num number not null,
	category varchar2(1) not null,
	title varchar2(150) not null,
	content clob not null,
	auth_num number(1) not null,
	reg_date date default sysdate,
	reply_num number,
	constraint Aboard_pk primary key(Aboard_num),
	constraint Aboard_fk1 foreign key(Amember_num) references Amember(Amember_num)
	constraint Aboard_fk2 foreign key(auth_num) references Amember(Amember_num)
);
ALTER TABLE Aboard ADD CONSTRAINT Aboard_fk3 foreign key(reply_num) references Aboard(Aboard_num);
create sequence Aboard_seq;

/*Achat(채팅 정보 테이블)*/
CREATE TABLE Achat(
	Amember_num number not null,
	opponent_num number not null,
	content varchar2(900) not null,
	send_date date default sysdate,
	read_date date,
	read number(1) default 1,
	constraint Achat_fk1 foreign key(Amember_num) references Amember(Amember_num),
	constraint Achat_fk2 foreign key(opponent_num) references Amember(Amember_num)
);