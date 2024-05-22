-- Check if the database exists
IF DB_ID('SWP_G3') IS NULL
BEGIN
    -- Create the database if it does not exist
    CREATE DATABASE SWP_G3;
END
GO

-- Use the database
USE SWP_G3;
GO

-- Drop all foreign key constraints and tables if the database already exists
IF DB_ID('SWP_G3') IS NOT NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) = N'';

    -- Build dynamic SQL to drop all foreign key constraints
    SELECT @sql += 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
                   ' DROP CONSTRAINT ' + QUOTENAME(CONSTRAINT_NAME) + ';'
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_TYPE = 'FOREIGN KEY';

    -- Execute the dynamic SQL to drop foreign key constraints
    EXEC sp_executesql @sql;

    -- Reset the SQL variable for dropping tables
    SET @sql = N'';

    -- Build dynamic SQL to drop all tables
    SELECT @sql += 'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ';'
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = 'BASE TABLE';

    -- Execute the dynamic SQL to drop tables
    EXEC sp_executesql @sql;
END
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
   cattype varchar(5) NOT NULL
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
   price int,
   [description] varchar(max),
   catid int FOREIGN KEY (catid) REFERENCES Category(catid),
   bid int FOREIGN KEY (bid) REFERENCES Brand(bid),
   islisted BIT,
   Date Date
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
   totalprice int,
   aid int FOREIGN KEY (aid) REFERENCES Account(aid),
   piid int FOREIGN KEY (piid) REFERENCES ProductItem(piid),
   stockstatus bit
)

-- vi cart se luu lai cho nguoi co account the nen can aid
-- chac la giu color o day


CREATE TABLE [Order](
   orid INT IDENTITY(0,1) PRIMARY KEY,
   aid int FOREIGN KEY (aid) REFERENCES Account(aid),
   date int,
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
insert into Product(pname,price,islisted,catid,bid) values('ph',0,0,0,0)
insert into ProductImg(pid,imgpath) values(0,'img/product_picture/placeholder.png'),
(0,'img/product_picture/placeholder.png'),
(0,'img/product_picture/placeholder.png')


-----------------------------------------------------------------------------------------------------------------------------------
--Insert 

INSERT INTO Category(catname,cattype) values
--('','shirt'),      ('','pant'),
('T-shirt','shirt'),
('short','pant'),
('jean','pant'),
('somi','shirt'),
('polo','shirt')



INSERT INTO Brand(bname) VALUES
('uniqlo'),('somi omen')

INSERT INTO Color(cname) VALUES
('white'),('black'),('gray'),('blue'),('pink'),('yellow'),('green'),('red')

INSERT INTO  Size(sname,height,weight,gender) VALUES
('S','1m60-1m65','55-60kg',1),
('M','1m64-1m69','60-65kg',1),
('L','1m70-1m74','66-70kg',1),
('XL','1m74-1m76','70-76kg',1)

--('S','1m48-1m53','38-43kg',0),
--('M','1m53-1m55','43-46kg',0),
--('L','1m53-1m58','46-53kg',0),
--('XL','1m55-1m66','57-66kg',0)

INSERT INTO Product(pname,price,catid,bid,islisted,description,Date) VALUES
--('', 0,0,0,1)

--Shirt insert uniqlo
('AIRism Cotton Half Sleeve Oversized T-Shirt', 391000,1,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-1),
('AIRism Cotton Striped Crew Neck Oversized T-Shirt',391000,1,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-2),
('Crew Neck Short Sleeve T-Shirt',293000,1,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-3),
('Supima Cotton Crew Neck Short Sleeve T-Shirt',191000,1,1,1,'- Smooth, premium 100% SUPIMA® cotton. Basic design styles on its own or in layered looks. Designed with meticulous attention to detail, down to the collar width and stitching.',GETDATE()-5),
--Shirt insert somi omen
('Somi Cotton Linen Cat-style 1',250000,4,2,1,'Cute cat-stack textures',GETDATE()-4),
('Somi Cotton Linen Cat-style 2',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-6),
('Somi Cotton Linen Cat-style 3',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-10),
('Somi Cotton Linen Cat-style 4',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-10),
('Somi Cotton Linen Cat-style 5',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-8),

--Short Pant insert uniqlo
('Stretch Slim Fit Shorts',588000,2,1,1,'Stretch twill cotton fabric with a soft texture and an elegant look. Slim fit with minimal stitching. Comfortable elasticated waist',GETDATE()),
('Chino Shorts',588000,2,1,1,'Newly updated with light fabric for an airy feel. Long, roomy cut creates a relaxed look. We’ve adjusted the fit and length for easier pairing with oversized tops. These chino shorts are a casual wardrobe essential.',GETDATE()-5),
('Parachute Cargo Shorts',391000,2,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-4),
('Geared Shorts',291000,2,1,1,'Nylon ripstop material with a water-repellent finish. The finish is not permanent. Convenient side pocket with slide fastener. Utility design includes an easy buckle belt and pockets with high storage capacity. Perfect for everyday wear or the great outdoors.',GETDATE()),
('Linen Blend Shorts',199000,2,1,1,'Premium twill weave material combines the benefits of linen and cotton. The distinctive texture of linen, blended with cotton for a soft touch. Gathered elastic waist for comfort.',GETDATE()-1),

--Jean Pant insert uniqlo
('Relaxed Ankle Jeans',980000,3,1,1,'Exceptionally soft fabric ensures a comfortable fit. Made with soft twist and double-ply threads for added durability. Soft yet shape-retaining fabric prevents bagginess at the knees. Wide fit with roomy cut at the thighs.',GETDATE()-2),
('Ultra Stretch Color Jeans',784000,3,1,1,'Ultra stretch satin fabric. Comfortable skinny fit. - Finer yarns create an elegant, glossy brushed texture. Comfortable yet sleek elastic waist design. Drawstring waist means they can be worn without a belt.',GETDATE()-1),
('Slim Fit Jeans',489000,3,1,1,'Stretch denim combines an authentic denim look with a soft feel. Versatile sleek slim fit. Washed using a water-saving process developed at our Jeans Innovation Center and treated with an innovative laser process to create an authentic worn-in look.',GETDATE()-12)





INSERT INTO ProductImg(pid,imgpath) VALUES
--(,'img/product_picture/'),
(1,'img/product_picture/alrism-cotton-half-sleeve-0.avif'),
(2,'img/product_picture/alrism-cotton-striped-crew-neck-0.avif'),
(3,'img/product_picture/crew-neck-short-sleeve-0.avif'),
(4,'img/product_picture/supima-cotton-crew-neck-0.avif'),

(5,'img/product_picture/somi-cotton-linen-cat-style-1-0.jpg'),
(6,'img/product_picture/somi-cotton-linen-cat-style-2-0.jpg'),
(7,'img/product_picture/somi-cotton-linen-cat-style-3-0.jpg'),
(8,'img/product_picture/somi-cotton-linen-cat-style-4-0.jpg'),
(9,'img/product_picture/somi-cotton-linen-cat-style-5-0.jpg'),
(9,'img/product_picture/somi-cotton-linen-cat-style-5-1.jpg'),

(10,'img/product_picture/stretch-slim-fit-0.avif'),
(11,'img/product_picture/chino-shorts-0.avif'),
(12,'img/product_picture/parachute-cargo-0.avif'),
(13,'img/product_picture/geared-shorts-0.avif'),
(14,'img/product_picture/linen-blend-shorts-0.avif'),

(15,'img/product_picture/relaxed-ankle-jeans-0.avif'),
(16,'img/product_picture/ultra-stretch-color-jeans-0.avif'),
(17,'img/product_picture/slim-fit-jeans-0.avif')