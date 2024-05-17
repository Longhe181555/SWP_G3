IF DB_ID('SWP_G3') IS NULL
BEGIN
    CREATE DATABASE SWP_G3;
END
GO


USE SWP_G3;
GO


CREATE TABLE Size(
   sid INT IDENTITY(0,1) PRIMARY KEY,
   sname varchar(4) NOT NUll,
   height varchar(100),
   weight varchar(100),
   gender bit
)

CREATE TABLE Category(
   catid INT IDENTITY(0,1) PRIMARY KEY,
   catname varchar(100) NOT NULL,
   cattype varchar(4) NOT NULL
)

CREATE TABLE Brand(
   bid INT IDENTITY(0,1) PRIMARY KEY,
   bname varchar(100) NOT NULL,
)
CREATE TABLE Color(
   cid INT IDENTITY(0,1) PRIMARY KEY,
   cname varchar(100) NOT NULL,
)


CREATE TABLE Product(
   pid INT IDENTITY(0,1) PRIMARY KEY,
   pname varchar(100),
   price float,
   catid int FOREIGN KEY (catid) REFERENCES Category(catid),
   bid int FOREIGN KEY (bid) REFERENCES Brand(bid),
   islisted BIT,
)

CREATE TABLE ProductImg(
  iid INT IDENTITY(0,1) PRIMARY KEY,
  imgpath varchar(100),
  pid int FOREIGN KEY (pid) REFERENCES Product(pid)
)


-- islisted dung de quyet dinh hien thi tren page - de bit boolean T/F
--productimg de du path den img trong file

CREATE TABLE ProductItem(
   piid INT IDENTITY(0,1) PRIMARY KEY,
   stockcount int,
   pid int FOREIGN KEY (pid) REFERENCES Product(pid),
   sid int FOREIGN KEY (sid) REFERENCES Size(sid),
   cid int FOREIGN KEY (cid) REFERENCES Color(cid),
)

CREATE TABLE Account(
aid INT IDENTITY(0,1) PRIMARY KEY,
loginname varchar(50) not null,
username varchar(MAX) not null,
password varchar(50) not null,
email varchar(50),
phonenumber varchar(50),
gender BIT,
birthdate DATE,
address varchar(MAX),
img varchar(100),
role varchar(100)
)
-- bit boolean T - Male, F- Female
-- img giu path den file anh

CREATE TABLE Payment(
 pmid  INT IDENTITY(0,1) PRIMARY KEY,
 bname nvarchar(100),
 bnumber nvarchar(100),
 aid int FOREIGN KEY (aid) REFERENCES Account(aid)
)


CREATE TABLE Cart(
   cartid INT IDENTITY(0,1) PRIMARY KEY,
   amount int not null,
   totalprice float,
   aid int FOREIGN KEY (aid) REFERENCES Account(aid),
   piid int FOREIGN KEY (piid) REFERENCES ProductItem(piid),
   stockstatus bit
)

-- vi cart se luu lai cho nguoi co account the nen can aid
-- chac la giu color o day


CREATE TABLE [Order](
   orid INT IDENTITY(0,1) PRIMARY KEY,
   aid int FOREIGN KEY (aid) REFERENCES Account(aid),
   date DATE,
   bill float,
   description varchar(MAX),
   status bit,
   pmid int FOREIGN KEY (pmid) REFERENCES Payment(pmid)
)

-- Giu thong tin tong cua order, OrderItem giu do trong order day
-- Co the them "address" trong day, default se la address trong account va nguoi dung co the doi
-- description la cho note cho shipper hoac cho seller.
-- status de biet reject hay accept
-- bill giu total price, gia tien cua ca order
-- date chi giu ngay order dc dat 

CREATE TABLE OrderItem(
  oiid INT IDENTITY(0,1) PRIMARY KEY,
  amount int not null,
  piid int FOREIGN KEY (piid) REFERENCES ProductItem(piid),
  orid int FOREIGN KEY (orid) REFERENCES [Order](orid)
)
-- giong cart


CREATE TABLE Feedback(
 fid INT IDENTITY(0,1) PRIMARY KEY,
 aid int FOREIGN KEY (aid) REFERENCES Account(aid),
 comment varchar(MAX),
 rating int,
 pid int FOREIGN KEY (pid) REFERENCES Product(pid),
 date DATE
)

-- feed back co the de aid ko co reference key de them kha nang de anonymous comment


CREATE TABLE ConnectionStatus(
Connection bit
)
insert into ConnectionStatus values(1);

insert into Account(loginname,username,password,role) values
('longvnhe181555', 'longvnhe181555','123','admin'),
('minhtnhe180070', 'minhtnhe180070','123','admin'),
('duyddhe173473', 'duyddhe173473','123','admin'),
('binhthhe151011', 'binhthhe151011','123','admin'),
('danglhhe161145', 'danglhhe161145','123','admin')


insert into Color(cname) values('placeholder')
insert into Brand(bname) values('placeholder')
insert into Size(sname,height,weight,gender) values('ph','ph','ph',1)
insert into Category(catname,cattype) values('ph','ph')
insert into Product(pname,price,islisted,catid,bid) values('ph',0.0,0,0,0)
insert into ProductImg(pid,imgpath) values(0,'img/product_picture/placeholder.png'),
(0,'img/product_picture/placeholder.png'),
(0,'img/product_picture/placeholder.png')


SELECT iid,pid,imgpath FROM ProductImg Where pid = 0