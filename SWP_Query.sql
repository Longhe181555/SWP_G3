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
   img varchar(100)
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
   islisted int,
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
fullname varchar(50) not null,
username varchar(MAX) not null,
password varchar(max) not null,
salt varchar(max),
email varchar(50),
phonenumber varchar(50),
gender BIT,
birthdate DATE,
address varchar(MAx),
img varchar(100),
role varchar(100),
status varchar(100),
lastLogin Date
)
-- bit boolean T - Male, F- Female
-- img giu path den file anh

CREATE TABLE [Address](
adid INT IDENTITY(0,1) PRIMARY KEY,
address varchar(100),
aid int FOREIGN KEY (aid) References Account(aid)
)


CREATE TABLE Payment(
 pmid  INT IDENTITY(0,1) PRIMARY KEY,
 bname nvarchar(100),
 bnumber nvarchar(100),
 aid int FOREIGN KEY (aid) REFERENCES Account(aid)
)

CREATE TABLE DiscountType(
 dtid INT IDENTITY(0,1) PRIMARY KEY,
 type varchar(100),
)

CREATE TABLE Discount (
    did INT IDENTITY(1,1) PRIMARY KEY,
    dtid INT,
    piid INT,
    value DECIMAL(10, 2),
    [from] DATE,
    [to] DATE,
    FOREIGN KEY (dtid) REFERENCES DiscountType(dtid),
    FOREIGN KEY (piid) REFERENCES ProductItem(piid)
);


CREATE TABLE [Order](
   orid INT IDENTITY(0,1) PRIMARY KEY,
   aid int FOREIGN KEY (aid) REFERENCES Account(aid),
   date Date,
   description varchar(MAX),
   status int,
   totalprice int,
   address varchar(Max),
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
  soldPrice int not null,  --per Item,  after Discount
  piid int FOREIGN KEY (piid) REFERENCES ProductItem(piid),
  orid int FOREIGN KEY (orid) REFERENCES [Order](orid),
  product_status varchar(50),
  did int FOREIGN KEY (did) REFERENCES [Discount](did)
)
-- giong cart


CREATE TABLE Feedback(
 fid INT IDENTITY(0,1) PRIMARY KEY,
 aid int FOREIGN KEY (aid) REFERENCES Account(aid),
 comment varchar(MAX),
 rating float,
 pid int FOREIGN KEY (pid) REFERENCES Product(pid),
 date DATE
)

-- feed back co the de aid ko co reference key de them kha nang de anonymous comment




CREATE TABLE Cart(
   cartid INT IDENTITY(0,1) PRIMARY KEY,
   amount int not null,
   totalprice int,
   aid int FOREIGN KEY (aid) REFERENCES Account(aid),
   piid int FOREIGN KEY (piid) REFERENCES ProductItem(piid),
   did int FOREIGN KEY(did) REFERENCES Discount(did),
   product_status varchar(50)
)

-- vi cart se luu lai cho nguoi co account the nen can aid
-- chac la giu color o day


insert into Account(fullname,username,password,role,salt) values
('longvnhe181555', 'longvnhe181555','rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==','admin','WrT79x+xWmhh8c3BBkkIkw=='),
('minhtnhe180070', 'minhtnhe180070','5DExJq2Tg429tJe+49JlKW3K656T8hongRAx4eK7JTEibToltE6Zzlafl1WJ/3OvHFJvbNX/V+oKYw3jgrFVyw==','admin','w51cFkFMQFSsjyT2YThmPw=='),
('duyddhe173473', 'duyddhe173473','dOuNAbJRoxe4bDhXeiiiHzQVtebLrCxvybKfgHeLL1EI6K9uwUc700f2xzykx4sp7d96ZxpavpQj6RvqV09XEA==','admin','5yQ0jZsmtsEUHQR8CVgCrg=='),
('binhthhe151011', 'binhthhe151011','rGEutTob/BSpz5YtqXyXBJsaepDh9SRF8EfI4SlQ+eadPiHRst/GITju5ydMfaUKMsiAw6QXpu8UogMykIkKWQ==','admin','qnvXvpwbsWdgDtKmf69sag=='),
('danglhhe161145', 'danglhhe161145','46l9N+161aQAD2LY1SkNsLOj5Uus6oqnYHTPO9Ab8fZDACb8YZf5473sl1cH3Mpm3kXOEDT/8rC6hi6itOxTFw==','admin','AoaQBLzOP+YBa7Zgqo0BkQ==')

INSERT INTO Account(fullname, username, password, role, salt) VALUES 
('nguyenvana', 'nguyenvana', 'Qp3BYQ18K/26dzuMGF0u+/JLtKVriQ4tcevm5dhtJNOzQqgiEPfhSRFRGZIf3XdKEgAOKJMa0ICOoc0fIhH/0A==', 'customer', '8siFHy6/+GPfGcGQyE71DA=='),
('tranthib', 'tranthib', 'EZ00+9qKTXyNfomW/8zCj/XdPh3TEIDnX+TSc1GRX0GHvYQlO8xwHF6unSIZuXVBxHaOgHkca2rThTF5j0LSMg==', 'customer', 'KAvxAu9ro0z+inKPCwD9jg=='),
('phamvand', 'phamvand', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer','WrT79x+xWmhh8c3BBkkIkw=='),
('lethiec', 'lethiec', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer', 'WrT79x+xWmhh8c3BBkkIkw=='),
('hoangminhf', 'hoangminhf', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer','WrT79x+xWmhh8c3BBkkIkw=='),
('nguyenthuh', 'nguyenthuh', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer', 'WrT79x+xWmhh8c3BBkkIkw=='),
('doanvand', 'doanvand', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer', 'WrT79x+xWmhh8c3BBkkIkw=='),
('dangthil', 'dangthil', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer', 'WrT79x+xWmhh8c3BBkkIkw=='),
('buiquynhm', 'buiquynhm', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer', 'WrT79x+xWmhh8c3BBkkIkw=='),
('truonganhp', 'truonganhp', 'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', 'customer', 'WrT79x+xWmhh8c3BBkkIkw==');

INSERT INTO Payment(aid,bname,bnumber) values(5,'TPBank','123456789')

insert into Color(cname) values('placeholder')
insert into Brand(bname) values('placeholder')
insert into Size(sname,height,weight,gender) values('ph','ph','ph',1)
insert into Category(catname,cattype) values('ph','ph')
insert into Product(pname,price,islisted,catid,bid,Date) values('ph',0,0,0,0,GETDATE())
insert into ProductImg(pid,imgpath) values(0,'img/product_picture/placeholder.png'),
(0,'img/product_picture/placeholder.png'),
(0,'img/product_picture/placeholder.png')


-----------------------------------------------------------------------------------------------------------------------------------
--Insert 



INSERT INTO DiscountType (type) VALUES ('percentage');
INSERT INTO DiscountType (type) VALUES ('fixedAmount');



INSERT INTO Category(catname,cattype) values
--('','shirt'),      ('','pant'),
('T-shirt','shirt'),  --1
('Short','pant'),   --2
('Jean','pant'),   --3
('Somi','shirt'), --4
('Polo','shirt')  --5



INSERT INTO Brand(bname,img) VALUES
('Uniqlo','img/other_picture/uniqlo.png'),('Somi omen','img/other_picture/somi-omen.png'),('Nike','img/other_picture/nike.png'),('Adidas','img/other_picture/adidas.png')--,('gucci','img/other/gucci.png'),('chanel','img/other/chanel.png')

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
('AIRism Cotton Half Sleeve Oversized T-Shirt', 391000,1,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-6),
('AIRism Cotton Striped Crew Neck Oversized T-Shirt',391000,1,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-9),
('Crew Neck Short Sleeve T-Shirt',293000,1,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-8),
('Supima Cotton Crew Neck Short Sleeve T-Shirt',191000,1,1,1,'- Smooth, premium 100% SUPIMA® cotton. Basic design styles on its own or in layered looks. Designed with meticulous attention to detail, down to the collar width and stitching.',GETDATE()-7),
--Shirt insert somi omen
('Somi Cotton Linen Cat-style 1',250000,4,2,1,'Cute cat-stack textures',GETDATE()-6),
('Somi Cotton Linen Cat-style 2',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-6),
('Somi Cotton Linen Cat-style 3',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-10),
('Somi Cotton Linen Cat-style 4',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-10),
('Somi Cotton Linen Cat-style 5',290000,4,2,1,'Cat themed shirt, casual wear',GETDATE()-8),

--Short Pant insert uniqlo
('Stretch Slim Fit Shorts',588000,2,1,1,'Stretch twill cotton fabric with a soft texture and an elegant look. Slim fit with minimal stitching. Comfortable elasticated waist',GETDATE()-6),
('Chino Shorts',588000,2,1,1,'Newly updated with light fabric for an airy feel. Long, roomy cut creates a relaxed look. We’ve adjusted the fit and length for easier pairing with oversized tops. These chino shorts are a casual wardrobe essential.',GETDATE()-6),
('Parachute Cargo Shorts',391000,2,1,1,'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.',GETDATE()-7),
('Geared Shorts',291000,2,1,1,'Nylon ripstop material with a water-repellent finish. The finish is not permanent. Convenient side pocket with slide fastener. Utility design includes an easy buckle belt and pockets with high storage capacity. Perfect for everyday wear or the great outdoors.',GETDATE()-9),
('Linen Blend Shorts',199000,2,1,1,'Premium twill weave material combines the benefits of linen and cotton. The distinctive texture of linen, blended with cotton for a soft touch. Gathered elastic waist for comfort.',GETDATE()-10),

--Jean Pant insert uniqlo
('Relaxed Ankle Jeans',980000,3,1,1,'Exceptionally soft fabric ensures a comfortable fit. Made with soft twist and double-ply threads for added durability. Soft yet shape-retaining fabric prevents bagginess at the knees. Wide fit with roomy cut at the thighs.',GETDATE()-6),
('Ultra Stretch Color Jeans',784000,3,1,1,'Ultra stretch satin fabric. Comfortable skinny fit. - Finer yarns create an elegant, glossy brushed texture. Comfortable yet sleek elastic waist design. Drawstring waist means they can be worn without a belt.',GETDATE()-7),
('Slim Fit Jeans',489000,3,1,1,'Stretch denim combines an authentic denim look with a soft feel. Versatile sleek slim fit. Washed using a water-saving process developed at our Jeans Innovation Center and treated with an innovative laser process to create an authentic worn-in look.',GETDATE()-12),

-- nike stuff
('Zion Men T-Shirt',919000,1,3,1,'Made from midweight cotton that feels soft and has a slight drape, this classic tee is a comfortable way to show off your admiration for Zion.',GETDATE()-6),
('Nike Sportswear Men Max90 T-Shirt',1279000,1,3,1,'Throwback hoops style meets soft-cotton comfort in this roomy tee. Dropped shoulders and a loose fit through the body give our Max90 tee a relaxed and casual look, while soft, midweight cotton fabric has you feeling like an all-star.',GETDATE()-6),
('Men Dri-FIT 13cm (approx.) Unlined Versatile Shorts',1019000,2,3,1,'Designed for running, training and yoga, the versatile Form shorts are built to handle those days when you need to shake up your exercise routine.',GETDATE()-10),

--adidas stuff   --('',0,0,4,0,'',GETDATE()-3)
('SPORTSWEAR UNDENIABLE TEE',950000,1,4,1,'Dotted with sneakers, this adidas t-shirt is versatile yet playful. Made from cotton single jersey, it feels comfortable against your torso, and the classic crewneck cut is always a winner. A great option for weekends, this tee will get plenty of wear just like your favourite adidas kicks.',GETDATE()-1),
('ESSENTIALS SINGLE JERSEY LINEAR EMBROIDERED LOGO TEE',550000,1,4,1,'Made from soft cotton jersey, it feels great against your skin. Our cotton products support more sustainable cotton farming',GETDATE()),
('MANCHESTER UNITED TIRO 24 POLO SHIRT',300000,5,4,1,'This adidas polo shirt is made from soft cotton-blend fabric that keeps you feeling comfortable during your downtime. An embroidered club badge on the chest displays your football fandom so you can proudly show your support wherever life leads.',GETDATE()),
('PREMIUM POLO SHIRT',499000,5,4,1,'Woven with lightweight jacquard, it keeps you cool and comfortable while subtly signalling your connection to adidas heritage. Signature details like the embroidered Trefoil on the chest and iconic 3-Stripes down the sleeve twist a sporty look into an everyday essential. ',GETDATE())
INSERT INTO ProductImg(pid,imgpath) VALUES
--(,'img/product_picture/'),
(1,'img/product_picture/alrism-cotton-half-sleeve-0.avif'),
(1,'img/product_picture/alrism-cotton-half-sleeve-1.avif'),
(1,'img/product_picture/alrism-cotton-half-sleeve-2.avif'),
(2,'img/product_picture/alrism-cotton-striped-crew-neck-0.avif'),
(2,'img/product_picture/alrism-cotton-striped-crew-neck-1.avif'),
(2,'img/product_picture/alrism-cotton-striped-crew-neck-2.avif'),
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
(17,'img/product_picture/slim-fit-jeans-0.avif'),

(18,'img/product_picture/zion-t-shirt-0.png'),
(18,'img/product_picture/zion-t-shirt-1.png'),
(18,'img/product_picture/zion-t-shirt-2.png'),

(19,'img/product_picture/sportswear-max90-t-shirt-0.png'),
(19,'img/product_picture/sportswear-max90-t-shirt-1.png'),
(19,'img/product_picture/sportswear-max90-t-shirt-2.png'),

(20,'img/product_picture/form-dri-fit-13cm-unlined-versatile-shorts-0.png'),
(20,'img/product_picture/form-dri-fit-13cm-unlined-versatile-shorts-1.png'),
(20,'img/product_picture/form-dri-fit-13cm-unlined-versatile-shorts-2.png'),

(21,'img/product_picture/Sportswear_Undeniable_Tee_Black_0.avif'),
(21,'img/product_picture/Sportswear_Undeniable_Tee_Black_1.avif'),
(21,'img/product_picture/Sportswear_Undeniable_Tee_Black_2.avif'),

(22,'img/product_picture/Essentials_Single_Jersey_Linear_Embroidered_Logo_Tee_White_0.png'),
(22,'img/product_picture/Essentials_Single_Jersey_Linear_Embroidered_Logo_Tee_White_1.png'),
(22,'img/product_picture/Essentials_Single_Jersey_Linear_Embroidered_Logo_Tee_White_2.png'),

(23,'img/product_picture/Manchester_United_Tiro_24_Polo_Shirt_Blue_0.png'),
(23,'img/product_picture/Manchester_United_Tiro_24_Polo_Shirt_Blue_1.png'),
(23,'img/product_picture/Manchester_United_Tiro_24_Polo_Shirt_Blue_2.png'),

(24,'img/product_picture/Premium_Polo_Shirt_Blue_0.png'),
(24,'img/product_picture/Premium_Polo_Shirt_Blue_1.png'),
(24,'img/product_picture/Premium_Polo_Shirt_Blue_2.png')

-- User 1 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(5, 'Great product!', 5.0, 1, DATEADD(day, -1, GETDATE())),
(5, 'Very comfortable.', 4.5, 2, DATEADD(day, -2, GETDATE())),
(5, 'Good value for money.', 4.0, 3, DATEADD(day, -3, GETDATE())),
(5, 'Nice quality.', 3.5, 4, DATEADD(day, -4, GETDATE())),
(5, 'Very stylish.', 4.5, 5, DATEADD(day, -5, GETDATE()));

-- User 2 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(6, 'Highly recommended.', 5.0, 1, DATEADD(day, -1, GETDATE())),
(6, 'Perfect fit.', 4.0, 2, DATEADD(day, -2, GETDATE())),
(6, 'Would buy again.', 3.5, 3, DATEADD(day, -3, GETDATE())),
(6, 'Exceeded expectations.', 4.5, 4, DATEADD(day, -4, GETDATE())),
(6, 'Very satisfied.', 5.0, 5, DATEADD(day, -5, GETDATE()));

-- User 3 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(7, 'Excellent quality.', 5.0, 1, DATEADD(day, -1, GETDATE())),
(7, 'Good product.', 4.0, 2, DATEADD(day, -2, GETDATE())),
(7, 'Very durable.', 3.5, 3, DATEADD(day, -3, GETDATE())),
(7, 'Love it!', 4.5, 4, DATEADD(day, -4, GETDATE())),
(7, 'Good material.', 4.0, 5, DATEADD(day, -5, GETDATE()));

-- User 4 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(8, 'Awesome!', 5.0, 1, DATEADD(day, -1, GETDATE())),
(8, 'Very good.', 4.0, 2, DATEADD(day, -2, GETDATE())),
(8, 'Nice design.', 3.5, 3, DATEADD(day, -3, GETDATE())),
(8, 'Well-made.', 4.5, 4, DATEADD(day, -4, GETDATE())),
(8, 'Happy with purchase.', 5.0, 5, DATEADD(day, -5, GETDATE()));

-- User 5 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(9, 'Amazing quality!', 5.0, 6, DATEADD(day, -1, GETDATE())),
(9, 'Very pleased.', 4.5, 7, DATEADD(day, -2, GETDATE())),
(9, 'Worth the price.', 4.0, 8, DATEADD(day, -3, GETDATE())),
(9, 'Great fabric.', 3.5, 9, DATEADD(day, -4, GETDATE())),
(9, 'Love this item.', 4.5, 10, DATEADD(day, -5, GETDATE())),
(9, 'Great gift.', 4.5, 18, DATEADD(day, -5, GETDATE()))

-- User 6 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(10, 'Good product.', 5.0, 11, DATEADD(day, -1, GETDATE())),
(10, 'Highly recommend.', 4.0, 12, DATEADD(day, -2, GETDATE())),
(10, 'Well worth it.', 3.5, 13, DATEADD(day, -3, GETDATE())),
(10, 'Excellent fit.', 4.5, 14, DATEADD(day, -4, GETDATE())),
(10, 'Very happy.', 5.0, 15, DATEADD(day, -5, GETDATE())),
(10, 'Amzing material.', 4, 18, DATEADD(day, -5, GETDATE()))

-- User 7 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(11, 'Superb quality.', 5.0, 16, DATEADD(day, -1, GETDATE())),
(11, 'Very comfortable.', 4.0, 17, DATEADD(day, -2, GETDATE())),
(11, 'Nice item.', 3.5, 1, DATEADD(day, -3, GETDATE())),
(11, 'Happy purchase.', 4.5, 2, DATEADD(day, -4, GETDATE())),
(11, 'Good value.', 4.0, 3, DATEADD(day, -5, GETDATE())),
(11, 'Liked the design.', 4, 18, DATEADD(day, -5, GETDATE()))

-- User 8 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(12, 'Quality product.', 5.0, 4, DATEADD(day, -1, GETDATE())),
(12, 'Perfect fit.', 4.0, 5, DATEADD(day, -2, GETDATE())),
(12, 'Stylish.', 3.5, 6, DATEADD(day, -3, GETDATE())),
(12, 'Well made.', 4.5, 7, DATEADD(day, -4, GETDATE())),
(12, 'Very nice.', 4.0, 8, DATEADD(day, -5, GETDATE()))

-- User 9 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(13, 'Great buy.', 5.0, 9, DATEADD(day, -1, GETDATE())),
(13, 'Satisfied.', 4.5, 10, DATEADD(day, -2, GETDATE())),
(13, 'Good material.', 4.0, 11, DATEADD(day, -3, GETDATE())),
(13, 'Very good.', 3.5, 12, DATEADD(day, -4, GETDATE())),
(13, 'Nice quality.', 4.5, 13, DATEADD(day, -5, GETDATE()))

-- User 10 feedback
INSERT INTO Feedback (aid, comment, rating, pid, date) VALUES 
(14, 'Excellent!', 5.0, 14, DATEADD(day, -1, GETDATE())),
(14, 'Highly recommend.', 4.0, 15, DATEADD(day, -2, GETDATE())),
(14, 'Love it.', 3.5, 16, DATEADD(day, -3, GETDATE())),
(14, 'Very pleased.', 4.5, 17, DATEADD(day, -4, GETDATE())),
(14, 'Great quality.', 4.0, 1, DATEADD(day, -5, GETDATE())),

(5, 'Love it <3.', 4.5, 19, DATEADD(day, -3, GETDATE())),
(6, 'Amazing.', 5, 19, DATEADD(day, -4, GETDATE())),
(9, 'Saved up just for this.', 4.5, 19, DATEADD(day, -2, GETDATE())),
(13, 'Very cool design but slow shipping.', 4, 19, DATEADD(day, -1, GETDATE())),
(6, 'Hate the feel.', 3, 20, DATEADD(day, -1, GETDATE())),
(7, 'So expensive, not worth it.', 3.5, 20, DATEADD(day, -4, GETDATE())),
(8, 'Good design, but bad material.', 4, 20, DATEADD(day, -3, GETDATE())),
(10, 'Love it!.', 5, 20, DATEADD(day, -5, GETDATE())),
(10, 'Amazing.', 4, 21, DATEADD(day, -4, GETDATE())),
(8, 'Well made.', 4.5, 21, DATEADD(day, -3, GETDATE())),
(6, 'Stylish.', 3.5, 21, DATEADD(day, -4, GETDATE())),
(14, 'Great quality.', 5, 21, DATEADD(day, -1, GETDATE()))



--('white'),('black'),('gray'),('blue'),('pink'),('yellow'),('green'),('red')

--1. 'S'
--2. 'M'
--3. 'L'
--4. 'XL'


INSERT INTO ProductItem (pid, cid, sid,stockcount) VALUES
(1, 1, 1,30),
(1, 2, 2,30),
(1, 3, 3,30),
(1, 4, 4,30), 
(2, 1, 1,30),
(2, 2, 2,30), 
(2, 3, 3,30), 
(2, 4, 4,30),
(3, 1, 1,30), 
(3, 2, 2,30), 
(3, 3, 3,30), 
(3, 4, 4,30), 
(4, 1, 1,30), 
(4, 2, 2,30), 
(4, 3, 3,30), 
(4, 4, 4,30),
(10, 1, 1,30),
(10, 2, 2,30),
(10, 3, 3,30),
(10, 4, 4,30), 
(11, 1, 1,30),
(11, 2, 2,30), 
(11, 3, 3,30), 
(11, 4, 4,30),
(12, 1, 1,30), 
(12, 2, 2,30), 
(12, 3, 3,30), 
(12, 4, 4,30), 
(13, 1, 1,30), 
(13, 2, 2,30), 
(13, 3, 3,30), 
(13, 4, 4,30),
(5, 1, 1,50),
(5, 1, 2,50),
(5, 1, 3,50),
(5, 1, 4,50),
(6,6,1,50),
(6,6,2,50),
(6,6,3,50),
(6,6,4,50),
(8,2,1,50),
(8,2,2,50),
(8,2,3,50),
(8,2,4,50),
(19,2,1,100),
(19,2,2,100),
(19,2,3,100)
--Select * from ProductItem
--Select * from Product
--Select * from Color
INSERT INTO Discount (dtid, piid, value, [from], [to])
VALUES 
(0, 0, 20,DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0, 1, 20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0, 2, 20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0, 3, 20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0, 4, 20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,32,20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,33,20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,37,20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,38,20, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,40,30, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,41,30, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,46,15, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,45,30, DATEADD(day, -3, GETDATE()), DATEADD(day, 4, GETDATE())),
(0,46,30, DATEADD(day, -9, GETDATE()), DATEADD(day, -3, GETDATE()))


INSERT INTO Cart (amount,piid,totalprice,aid) values(1,1,391000,5),(1,13,191000,5)

-- Order will insert of different month, week interval for testing purpose, from the same user, for now user aid 5 will be the tester


--Order today pending
INSERT INTO [Order] (aid,address,date,description,pmid,status,totalprice) values(5,'Ha Noi',getDate(),'',0,0,1000000)
INSERT INTO [OrderItem] (orid,amount,piid,soldPrice) values (0,4,32,250000)
--Order last month
INSERT INTO [Order] (aid,address,date,description,pmid,status,totalprice) values(5,'Ha Noi',getDate()-30,'',0,1,3000000)
INSERT INTO [OrderItem] (orid,amount,piid,soldPrice) values (1,5,32,250000),(1,4,33,250000),(1,3,34,250000)
--Order last 2 month
INSERT INTO [Order] (aid,address,date,description,pmid,status,totalprice) values(5,'Ha Noi',getDate()-60,'',0,1,3000000)
INSERT INTO [OrderItem] (orid,amount,piid,soldPrice) values (2,5,32,250000),(2,4,33,250000),(2,3,34,250000)
--Order last 3 month
INSERT INTO [Order] (aid,address,date,description,pmid,status,totalprice) values(5,'Ha Noi',getDate()-90,'',0,1,1500000)
INSERT INTO [OrderItem] (orid,amount,piid,soldPrice) values (3,2,32,250000),(3,2,33,250000),(3,2,34,250000)

--Order yesterday approved
INSERT INTO [Order] (aid,address,date,description,pmid,status,totalprice) values(5,'Ha Noi',getDate()-1,'',0,1,1146000)
INSERT INTO [OrderItem] (orid,amount,piid,soldPrice) values (4,2,13,191000),(3,2,33,191000),(3,2,34,191000)

--Order last week approved
INSERT INTO [Order] (aid,address,date,description,pmid,status,totalprice) values(5,'Ha Noi',getDate()-7,'',0,1,1146000)
INSERT INTO [OrderItem] (orid,amount,piid,soldPrice) values (5,2,13,191000),(3,2,33,191000),(3,2,34,191000)




