USE [master]
GO
/****** Object:  Database [SWP_G3]    Script Date: 6/16/2024 10:54:50 PM ******/
CREATE DATABASE [SWP_G3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP_G3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SWP_G3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP_G3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SWP_G3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SWP_G3] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP_G3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP_G3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP_G3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP_G3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP_G3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP_G3] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP_G3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP_G3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP_G3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP_G3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP_G3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP_G3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP_G3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP_G3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP_G3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP_G3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SWP_G3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP_G3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP_G3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP_G3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP_G3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP_G3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP_G3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP_G3] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP_G3] SET  MULTI_USER 
GO
ALTER DATABASE [SWP_G3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP_G3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP_G3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP_G3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP_G3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP_G3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP_G3', N'ON'
GO
ALTER DATABASE [SWP_G3] SET QUERY_STORE = OFF
GO
USE [SWP_G3]
GO
/****** Object:  User [admin]    Script Date: 6/16/2024 10:54:50 PM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[aid] [int] IDENTITY(0,1) NOT NULL,
	[fullname] [varchar](50) NOT NULL,
	[username] [varchar](max) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[salt] [varchar](max) NULL,
	[email] [varchar](50) NULL,
	[phonenumber] [varchar](50) NULL,
	[gender] [bit] NULL,
	[birthdate] [date] NULL,
	[address] [varchar](max) NULL,
	[img] [varchar](100) NULL,
	[role] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[bid] [int] IDENTITY(0,1) NOT NULL,
	[bname] [varchar](100) NOT NULL,
	[img] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cartid] [int] IDENTITY(0,1) NOT NULL,
	[amount] [int] NOT NULL,
	[totalprice] [float] NULL,
	[aid] [int] NULL,
	[color_id] [int] NULL,
	[pid] [int] NULL,
	[size_id] [int] NULL,
 CONSTRAINT [PK__Cart__41663FC087F7EBFA] PRIMARY KEY CLUSTERED 
(
	[cartid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[catid] [int] IDENTITY(0,1) NOT NULL,
	[catname] [varchar](100) NOT NULL,
	[cattype] [varchar](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[catid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Color]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Color](
	[cid] [int] IDENTITY(0,1) NOT NULL,
	[cname] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[did] [int] IDENTITY(1,1) NOT NULL,
	[dtid] [int] NULL,
	[piid] [int] NOT NULL,
	[value] [decimal](10, 2) NULL,
	[from] [date] NULL,
	[to] [date] NULL,
 CONSTRAINT [PK__Discount__D877D216A0AFF1A5] PRIMARY KEY CLUSTERED 
(
	[did] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountType]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountType](
	[dtid] [int] IDENTITY(0,1) NOT NULL,
	[type] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[dtid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[fid] [int] IDENTITY(0,1) NOT NULL,
	[aid] [int] NULL,
	[comment] [varchar](max) NULL,
	[rating] [float] NULL,
	[pid] [int] NULL,
	[date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[orid] [int] IDENTITY(0,1) NOT NULL,
	[aid] [int] NULL,
	[date] [datetime] NULL,
	[description] [varchar](max) NULL,
	[status] [bit] NULL,
	[total] [float] NULL,
 CONSTRAINT [PK__Order__4FCD8522C0DD0008] PRIMARY KEY CLUSTERED 
(
	[orid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[oiid] [int] IDENTITY(0,1) NOT NULL,
	[amount] [int] NOT NULL,
	[pid] [int] NULL,
	[orid] [int] NULL,
	[size_id] [int] NULL,
	[color_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[oiid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[pmid] [float] NOT NULL,
	[bname] [nvarchar](100) NULL,
	[bnumber] [nvarchar](100) NULL,
	[aid] [int] NULL,
	[order_id] [int] NULL,
 CONSTRAINT [PK__Payment__412600BA54C303B4] PRIMARY KEY CLUSTERED 
(
	[pmid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[pid] [int] IDENTITY(0,1) NOT NULL,
	[pname] [varchar](100) NULL,
	[price] [int] NULL,
	[description] [varchar](max) NULL,
	[catid] [int] NULL,
	[bid] [int] NULL,
	[islisted] [bit] NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImg]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImg](
	[iid] [int] IDENTITY(0,1) NOT NULL,
	[imgpath] [varchar](100) NULL,
	[pid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductItem]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductItem](
	[piid] [int] IDENTITY(0,1) NOT NULL,
	[stockcount] [int] NULL,
	[pid] [int] NULL,
	[sid] [int] NULL,
	[cid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[piid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 6/16/2024 10:54:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[sid] [int] IDENTITY(0,1) NOT NULL,
	[sname] [varchar](4) NOT NULL,
	[height] [varchar](100) NULL,
	[weight] [varchar](100) NULL,
	[gender] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (0, N'longvnhe181555', N'longvnhe181555', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'admin')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (1, N'minhtnhe180070', N'minhtnhe180070', N'5DExJq2Tg429tJe+49JlKW3K656T8hongRAx4eK7JTEibToltE6Zzlafl1WJ/3OvHFJvbNX/V+oKYw3jgrFVyw==', N'w51cFkFMQFSsjyT2YThmPw==', NULL, NULL, NULL, NULL, NULL, NULL, N'admin')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (2, N'duyddhe173473', N'duyddhe173473', N'dOuNAbJRoxe4bDhXeiiiHzQVtebLrCxvybKfgHeLL1EI6K9uwUc700f2xzykx4sp7d96ZxpavpQj6RvqV09XEA==', N'5yQ0jZsmtsEUHQR8CVgCrg==', NULL, NULL, NULL, NULL, NULL, NULL, N'admin')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (3, N'binhthhe151011', N'binhthhe151011', N'rGEutTob/BSpz5YtqXyXBJsaepDh9SRF8EfI4SlQ+eadPiHRst/GITju5ydMfaUKMsiAw6QXpu8UogMykIkKWQ==', N'qnvXvpwbsWdgDtKmf69sag==', NULL, NULL, NULL, NULL, NULL, NULL, N'admin')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (4, N'danglhhe161145', N'danglhhe161145', N'46l9N+161aQAD2LY1SkNsLOj5Uus6oqnYHTPO9Ab8fZDACb8YZf5473sl1cH3Mpm3kXOEDT/8rC6hi6itOxTFw==', N'AoaQBLzOP+YBa7Zgqo0BkQ==', NULL, NULL, NULL, NULL, NULL, NULL, N'admin')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (5, N'nguyenvana', N'nguyenvana', N'Qp3BYQ18K/26dzuMGF0u+/JLtKVriQ4tcevm5dhtJNOzQqgiEPfhSRFRGZIf3XdKEgAOKJMa0ICOoc0fIhH/0A==', N'8siFHy6/+GPfGcGQyE71DA==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (6, N'tranthib', N'tranthib', N'EZ00+9qKTXyNfomW/8zCj/XdPh3TEIDnX+TSc1GRX0GHvYQlO8xwHF6unSIZuXVBxHaOgHkca2rThTF5j0LSMg==', N'KAvxAu9ro0z+inKPCwD9jg==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (7, N'phamvand', N'phamvand', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (8, N'lethiec', N'lethiec', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (9, N'hoangminhf', N'hoangminhf', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (10, N'nguyenthuh', N'nguyenthuh', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (11, N'doanvand', N'doanvand', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (12, N'dangthil', N'dangthil', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (13, N'buiquynhm', N'buiquynhm', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (14, N'truonganhp', N'truonganhp', N'rrCK1A1O+C9t/V+gri/EDuAqlh7roC7gJtto3wDvJ1C3uIVsAPdR1HQNJIbmh4mlw5F7DBV6Cmr8yjJ5numf+Q==', N'WrT79x+xWmhh8c3BBkkIkw==', NULL, NULL, NULL, NULL, NULL, NULL, N'customer')
INSERT [dbo].[Account] ([aid], [fullname], [username], [password], [salt], [email], [phonenumber], [gender], [birthdate], [address], [img], [role]) VALUES (15, N'test', N'test', N'iFDwfJImQzzSWpyxjlDcd7HlS+x0xhUh7ZrAwHv4rLqR7/+aI+EiF+aWWrG3Y7LsNvpsWo/davW8/u/v5VRRNQ==', N'8e8X1f5P0BVMNz+pqieC6Q==', N'test@gmail.com', NULL, 0, NULL, NULL, N'img/profile_picture/placeholder.png', N'customer')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([bid], [bname], [img]) VALUES (0, N'placeholder', NULL)
INSERT [dbo].[Brand] ([bid], [bname], [img]) VALUES (1, N'uniqlo', N'img/other_picture/uniqlo.png')
INSERT [dbo].[Brand] ([bid], [bname], [img]) VALUES (2, N'somi omen', N'img/other_picture/somi-omen.png')
INSERT [dbo].[Brand] ([bid], [bname], [img]) VALUES (3, N'nike', N'img/other_picture/nike.png')
INSERT [dbo].[Brand] ([bid], [bname], [img]) VALUES (4, N'adidas', N'img/other_picture/adidas.png')
SET IDENTITY_INSERT [dbo].[Brand] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([cartid], [amount], [totalprice], [aid], [color_id], [pid], [size_id]) VALUES (7, 2, 99.99, 1, 1, 23, 1)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([catid], [catname], [cattype]) VALUES (0, N'ph', N'ph')
INSERT [dbo].[Category] ([catid], [catname], [cattype]) VALUES (1, N'T-shirt', N'shirt')
INSERT [dbo].[Category] ([catid], [catname], [cattype]) VALUES (2, N'short', N'pant')
INSERT [dbo].[Category] ([catid], [catname], [cattype]) VALUES (3, N'jean', N'pant')
INSERT [dbo].[Category] ([catid], [catname], [cattype]) VALUES (4, N'somi', N'shirt')
INSERT [dbo].[Category] ([catid], [catname], [cattype]) VALUES (5, N'polo', N'shirt')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Color] ON 

INSERT [dbo].[Color] ([cid], [cname]) VALUES (0, N'placeholder')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (1, N'white')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (2, N'black')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (3, N'gray')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (4, N'blue')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (5, N'pink')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (6, N'yellow')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (7, N'green')
INSERT [dbo].[Color] ([cid], [cname]) VALUES (8, N'red')
SET IDENTITY_INSERT [dbo].[Color] OFF
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 

INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (1, 0, 1, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (2, 0, 10, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (3, 0, 2, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (4, 0, 3, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (5, 0, 4, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (6, 0, 12, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (7, 0, 14, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (8, 0, 13, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (9, 0, 19, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (10, 0, 15, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (11, 0, 16, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (12, 0, 17, CAST(15.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (13, 0, 18, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-06-13' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Discount] ([did], [dtid], [piid], [value], [from], [to]) VALUES (14, 0, 20, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-06-07' AS Date), CAST(N'2024-06-13' AS Date))
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[DiscountType] ON 

INSERT [dbo].[DiscountType] ([dtid], [type]) VALUES (0, N'percentage')
INSERT [dbo].[DiscountType] ([dtid], [type]) VALUES (1, N'fixedAmount')
SET IDENTITY_INSERT [dbo].[DiscountType] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (0, 5, N'Great product!', 5, 1, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (1, 5, N'Very comfortable.', 4.5, 2, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (2, 5, N'Good value for money.', 4, 3, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (3, 5, N'Nice quality.', 3.5, 4, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (4, 5, N'Very stylish.', 4.5, 5, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (5, 6, N'Highly recommended.', 5, 1, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (6, 6, N'Perfect fit.', 4, 2, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (7, 6, N'Would buy again.', 3.5, 3, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (8, 6, N'Exceeded expectations.', 4.5, 4, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (9, 6, N'Very satisfied.', 5, 5, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (10, 7, N'Excellent quality.', 5, 1, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (11, 7, N'Good product.', 4, 2, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (12, 7, N'Very durable.', 3.5, 3, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (13, 7, N'Love it!', 4.5, 4, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (14, 7, N'Good material.', 4, 5, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (15, 8, N'Awesome!', 5, 1, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (16, 8, N'Very good.', 4, 2, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (17, 8, N'Nice design.', 3.5, 3, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (18, 8, N'Well-made.', 4.5, 4, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (19, 8, N'Happy with purchase.', 5, 5, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (20, 9, N'Amazing quality!', 5, 6, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (21, 9, N'Very pleased.', 4.5, 7, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (22, 9, N'Worth the price.', 4, 8, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (23, 9, N'Great fabric.', 3.5, 9, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (24, 9, N'Love this item.', 4.5, 10, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (25, 9, N'Great gift.', 4.5, 18, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (26, 10, N'Good product.', 5, 11, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (27, 10, N'Highly recommend.', 4, 12, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (28, 10, N'Well worth it.', 3.5, 13, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (29, 10, N'Excellent fit.', 4.5, 14, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (30, 10, N'Very happy.', 5, 15, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (31, 10, N'Amzing material.', 4, 18, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (32, 11, N'Superb quality.', 5, 16, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (33, 11, N'Very comfortable.', 4, 17, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (34, 11, N'Nice item.', 3.5, 1, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (35, 11, N'Happy purchase.', 4.5, 2, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (36, 11, N'Good value.', 4, 3, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (37, 11, N'Liked the design.', 4, 18, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (38, 12, N'Quality product.', 5, 4, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (39, 12, N'Perfect fit.', 4, 5, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (40, 12, N'Stylish.', 3.5, 6, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (41, 12, N'Well made.', 4.5, 7, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (42, 12, N'Very nice.', 4, 8, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (43, 13, N'Great buy.', 5, 9, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (44, 13, N'Satisfied.', 4.5, 10, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (45, 13, N'Good material.', 4, 11, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (46, 13, N'Very good.', 3.5, 12, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (47, 13, N'Nice quality.', 4.5, 13, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (48, 14, N'Excellent!', 5, 14, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (49, 14, N'Highly recommend.', 4, 15, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (50, 14, N'Love it.', 3.5, 16, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (51, 14, N'Very pleased.', 4.5, 17, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (52, 14, N'Great quality.', 4, 1, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (53, 5, N'Love it <3.', 4.5, 19, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (54, 6, N'Amazing.', 5, 19, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (55, 9, N'Saved up just for this.', 4.5, 19, CAST(N'2024-06-14' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (56, 13, N'Very cool design but slow shipping.', 4, 19, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (57, 6, N'Hate the feel.', 3, 20, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (58, 7, N'So expensive, not worth it.', 3.5, 20, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (59, 8, N'Good design, but bad material.', 4, 20, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (60, 10, N'Love it!.', 5, 20, CAST(N'2024-06-11' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (61, 10, N'Amazing.', 4, 21, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (62, 8, N'Well made.', 4.5, 21, CAST(N'2024-06-13' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (63, 6, N'Stylish.', 3.5, 21, CAST(N'2024-06-12' AS Date))
INSERT [dbo].[Feedback] ([fid], [aid], [comment], [rating], [pid], [date]) VALUES (64, 14, N'Great quality.', 5, 21, CAST(N'2024-06-15' AS Date))
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([orid], [aid], [date], [description], [status], [total]) VALUES (1, 15, CAST(N'2024-06-16T22:40:04.967' AS DateTime), NULL, 0, 1187600)
INSERT [dbo].[Order] ([orid], [aid], [date], [description], [status], [total]) VALUES (2, 15, CAST(N'2024-06-16T22:43:34.130' AS DateTime), NULL, 0, 1187600)
INSERT [dbo].[Order] ([orid], [aid], [date], [description], [status], [total]) VALUES (3, 15, CAST(N'2024-06-16T22:44:43.930' AS DateTime), NULL, 0, 1187600)
INSERT [dbo].[Order] ([orid], [aid], [date], [description], [status], [total]) VALUES (4, 15, CAST(N'2024-06-16T22:46:52.820' AS DateTime), NULL, 0, 0)
INSERT [dbo].[Order] ([orid], [aid], [date], [description], [status], [total]) VALUES (5, 15, CAST(N'2024-06-16T22:47:17.270' AS DateTime), NULL, 0, 0)
INSERT [dbo].[Order] ([orid], [aid], [date], [description], [status], [total]) VALUES (6, 15, CAST(N'2024-06-16T22:49:29.623' AS DateTime), NULL, 0, 637200)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (6, 4, 3, 2, 3, 2)
INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (7, 1, 5, 2, 2, 1)
INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (8, 4, 3, 3, 3, 2)
INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (9, 1, 5, 3, 2, 1)
INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (10, 1, 4, 6, 2, 2)
INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (11, 1, 3, 6, 2, 2)
INSERT [dbo].[OrderItem] ([oiid], [amount], [pid], [orid], [size_id], [color_id]) VALUES (12, 1, 5, 6, 2, 1)
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (0, N'ph', 0, NULL, 0, 0, 0, NULL)
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (1, N'AIRism Cotton Half Sleeve Oversized T-Shirt', 391000, N'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.', 1, 1, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (2, N'AIRism Cotton Striped Crew Neck Oversized T-Shirt', 391000, N'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.', 1, 1, 1, CAST(N'2024-06-07' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (3, N'Crew Neck Short Sleeve T-Shirt', 293000, N'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.', 1, 1, 1, CAST(N'2024-06-08' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (4, N'Supima Cotton Crew Neck Short Sleeve T-Shirt', 191000, N'- Smooth, premium 100% SUPIMA® cotton. Basic design styles on its own or in layered looks. Designed with meticulous attention to detail, down to the collar width and stitching.', 1, 1, 1, CAST(N'2024-06-09' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (5, N'Somi Cotton Linen Cat-style 1', 250000, N'Cute cat-stack textures', 4, 2, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (6, N'Somi Cotton Linen Cat-style 2', 290000, N'Cat themed shirt, casual wear', 4, 2, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (7, N'Somi Cotton Linen Cat-style 3', 290000, N'Cat themed shirt, casual wear', 4, 2, 1, CAST(N'2024-06-06' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (8, N'Somi Cotton Linen Cat-style 4', 290000, N'Cat themed shirt, casual wear', 4, 2, 1, CAST(N'2024-06-06' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (9, N'Somi Cotton Linen Cat-style 5', 290000, N'Cat themed shirt, casual wear', 4, 2, 1, CAST(N'2024-06-08' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (10, N'Stretch Slim Fit Shorts', 588000, N'Stretch twill cotton fabric with a soft texture and an elegant look. Slim fit with minimal stitching. Comfortable elasticated waist', 2, 1, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (11, N'Chino Shorts', 588000, N'Newly updated with light fabric for an airy feel. Long, roomy cut creates a relaxed look. We’ve adjusted the fit and length for easier pairing with oversized tops. These chino shorts are a casual wardrobe essential.', 2, 1, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (12, N'Parachute Cargo Shorts', 391000, N'The Uniqlo U collection is the realization of a dedicated and skilled team of international designers based at our Paris Research and Development Center led by Artistic Director Christophe Lemaire.', 2, 1, 1, CAST(N'2024-06-09' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (13, N'Geared Shorts', 291000, N'Nylon ripstop material with a water-repellent finish. The finish is not permanent. Convenient side pocket with slide fastener. Utility design includes an easy buckle belt and pockets with high storage capacity. Perfect for everyday wear or the great outdoors.', 2, 1, 1, CAST(N'2024-06-07' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (14, N'Linen Blend Shorts', 199000, N'Premium twill weave material combines the benefits of linen and cotton. The distinctive texture of linen, blended with cotton for a soft touch. Gathered elastic waist for comfort.', 2, 1, 1, CAST(N'2024-06-06' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (15, N'Relaxed Ankle Jeans', 980000, N'Exceptionally soft fabric ensures a comfortable fit. Made with soft twist and double-ply threads for added durability. Soft yet shape-retaining fabric prevents bagginess at the knees. Wide fit with roomy cut at the thighs.', 3, 1, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (16, N'Ultra Stretch Color Jeans', 784000, N'Ultra stretch satin fabric. Comfortable skinny fit. - Finer yarns create an elegant, glossy brushed texture. Comfortable yet sleek elastic waist design. Drawstring waist means they can be worn without a belt.', 3, 1, 1, CAST(N'2024-06-09' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (17, N'Slim Fit Jeans', 489000, N'Stretch denim combines an authentic denim look with a soft feel. Versatile sleek slim fit. Washed using a water-saving process developed at our Jeans Innovation Center and treated with an innovative laser process to create an authentic worn-in look.', 3, 1, 1, CAST(N'2024-06-04' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (18, N'Zion Men T-Shirt', 919000, N'Made from midweight cotton that feels soft and has a slight drape, this classic tee is a comfortable way to show off your admiration for Zion.', 1, 3, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (19, N'Nike Sportswear Men Max90 T-Shirt', 1279000, N'Throwback hoops style meets soft-cotton comfort in this roomy tee. Dropped shoulders and a loose fit through the body give our Max90 tee a relaxed and casual look, while soft, midweight cotton fabric has you feeling like an all-star.', 1, 3, 1, CAST(N'2024-06-10' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (20, N'Men Dri-FIT 13cm (approx.) Unlined Versatile Shorts', 1019000, N'Designed for running, training and yoga, the versatile Form shorts are built to handle those days when you need to shake up your exercise routine.', 2, 3, 1, CAST(N'2024-06-06' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (21, N'SPORTSWEAR UNDENIABLE TEE', 950000, N'Dotted with sneakers, this adidas t-shirt is versatile yet playful. Made from cotton single jersey, it feels comfortable against your torso, and the classic crewneck cut is always a winner. A great option for weekends, this tee will get plenty of wear just like your favourite adidas kicks.', 1, 4, 1, CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (22, N'ESSENTIALS SINGLE JERSEY LINEAR EMBROIDERED LOGO TEE', 550000, N'Made from soft cotton jersey, it feels great against your skin. Our cotton products support more sustainable cotton farming', 1, 4, 1, CAST(N'2024-06-16' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (23, N'MANCHESTER UNITED TIRO 24 POLO SHIRT', 300000, N'This adidas polo shirt is made from soft cotton-blend fabric that keeps you feeling comfortable during your downtime. An embroidered club badge on the chest displays your football fandom so you can proudly show your support wherever life leads.', 5, 4, 1, CAST(N'2024-06-16' AS Date))
INSERT [dbo].[Product] ([pid], [pname], [price], [description], [catid], [bid], [islisted], [Date]) VALUES (24, N'PREMIUM POLO SHIRT', 499000, N'Woven with lightweight jacquard, it keeps you cool and comfortable while subtly signalling your connection to adidas heritage. Signature details like the embroidered Trefoil on the chest and iconic 3-Stripes down the sleeve twist a sporty look into an everyday essential. ', 5, 4, 1, CAST(N'2024-06-16' AS Date))
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImg] ON 

INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (0, N'img/product_picture/placeholder.png', 0)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (1, N'img/product_picture/placeholder.png', 0)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (2, N'img/product_picture/placeholder.png', 0)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (3, N'img/product_picture/alrism-cotton-half-sleeve-0.avif', 1)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (4, N'img/product_picture/alrism-cotton-half-sleeve-1.avif', 1)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (5, N'img/product_picture/alrism-cotton-half-sleeve-2.avif', 1)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (6, N'img/product_picture/alrism-cotton-striped-crew-neck-0.avif', 2)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (7, N'img/product_picture/alrism-cotton-striped-crew-neck-1.avif', 2)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (8, N'img/product_picture/alrism-cotton-striped-crew-neck-2.avif', 2)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (9, N'img/product_picture/crew-neck-short-sleeve-0.avif', 3)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (10, N'img/product_picture/supima-cotton-crew-neck-0.avif', 4)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (11, N'img/product_picture/somi-cotton-linen-cat-style-1-0.jpg', 5)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (12, N'img/product_picture/somi-cotton-linen-cat-style-2-0.jpg', 6)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (13, N'img/product_picture/somi-cotton-linen-cat-style-3-0.jpg', 7)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (14, N'img/product_picture/somi-cotton-linen-cat-style-4-0.jpg', 8)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (15, N'img/product_picture/somi-cotton-linen-cat-style-5-0.jpg', 9)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (16, N'img/product_picture/somi-cotton-linen-cat-style-5-1.jpg', 9)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (17, N'img/product_picture/stretch-slim-fit-0.avif', 10)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (18, N'img/product_picture/chino-shorts-0.avif', 11)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (19, N'img/product_picture/parachute-cargo-0.avif', 12)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (20, N'img/product_picture/geared-shorts-0.avif', 13)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (21, N'img/product_picture/linen-blend-shorts-0.avif', 14)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (22, N'img/product_picture/relaxed-ankle-jeans-0.avif', 15)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (23, N'img/product_picture/ultra-stretch-color-jeans-0.avif', 16)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (24, N'img/product_picture/slim-fit-jeans-0.avif', 17)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (25, N'img/product_picture/zion-t-shirt-0.png', 18)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (26, N'img/product_picture/zion-t-shirt-1.png', 18)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (27, N'img/product_picture/zion-t-shirt-2.png', 18)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (28, N'img/product_picture/sportswear-max90-t-shirt-0.png', 19)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (29, N'img/product_picture/sportswear-max90-t-shirt-1.png', 19)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (30, N'img/product_picture/sportswear-max90-t-shirt-2.png', 19)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (31, N'img/product_picture/form-dri-fit-13cm-unlined-versatile-shorts-0.png', 20)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (32, N'img/product_picture/form-dri-fit-13cm-unlined-versatile-shorts-1.png', 20)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (33, N'img/product_picture/form-dri-fit-13cm-unlined-versatile-shorts-2.png', 20)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (34, N'img/product_picture/Sportswear_Undeniable_Tee_Black_0.avif', 21)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (35, N'img/product_picture/Sportswear_Undeniable_Tee_Black_1.avif', 21)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (36, N'img/product_picture/Sportswear_Undeniable_Tee_Black_2.avif', 21)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (37, N'img/product_picture/Essentials_Single_Jersey_Linear_Embroidered_Logo_Tee_White_0.png', 22)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (38, N'img/product_picture/Essentials_Single_Jersey_Linear_Embroidered_Logo_Tee_White_1.png', 22)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (39, N'img/product_picture/Essentials_Single_Jersey_Linear_Embroidered_Logo_Tee_White_2.png', 22)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (40, N'img/product_picture/Manchester_United_Tiro_24_Polo_Shirt_Blue_0.png', 23)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (41, N'img/product_picture/Manchester_United_Tiro_24_Polo_Shirt_Blue_1.png', 23)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (42, N'img/product_picture/Manchester_United_Tiro_24_Polo_Shirt_Blue_2.png', 23)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (43, N'img/product_picture/Premium_Polo_Shirt_Blue_0.png', 24)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (44, N'img/product_picture/Premium_Polo_Shirt_Blue_1.png', 24)
INSERT [dbo].[ProductImg] ([iid], [imgpath], [pid]) VALUES (45, N'img/product_picture/Premium_Polo_Shirt_Blue_2.png', 24)
SET IDENTITY_INSERT [dbo].[ProductImg] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductItem] ON 

INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (0, 30, 1, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (1, 30, 1, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (2, 30, 1, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (3, 30, 1, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (4, 30, 2, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (5, 30, 2, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (6, 30, 2, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (7, 30, 2, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (8, 30, 3, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (9, 30, 3, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (10, 30, 3, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (11, 30, 3, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (12, 30, 4, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (13, 30, 4, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (14, 30, 4, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (15, 30, 4, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (16, 30, 10, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (17, 30, 10, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (18, 30, 10, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (19, 30, 10, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (20, 30, 11, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (21, 30, 11, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (22, 30, 11, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (23, 30, 11, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (24, 30, 12, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (25, 30, 12, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (26, 30, 12, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (27, 30, 12, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (28, 30, 13, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (29, 30, 13, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (30, 30, 13, 3, 3)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (31, 30, 13, 4, 4)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (32, 50, 5, 1, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (33, 50, 5, 2, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (34, 50, 5, 3, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (35, 50, 5, 4, 1)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (36, 50, 6, 1, 6)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (37, 50, 6, 2, 6)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (38, 50, 6, 3, 6)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (39, 50, 6, 4, 6)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (40, 50, 8, 1, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (41, 50, 8, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (42, 50, 8, 3, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (43, 50, 8, 4, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (44, 100, 19, 1, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (45, 100, 19, 2, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (46, 100, 19, 3, 2)
INSERT [dbo].[ProductItem] ([piid], [stockcount], [pid], [sid], [cid]) VALUES (47, 40, 3, 1, 1)
SET IDENTITY_INSERT [dbo].[ProductItem] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([sid], [sname], [height], [weight], [gender]) VALUES (0, N'ph', N'ph', N'ph', 1)
INSERT [dbo].[Size] ([sid], [sname], [height], [weight], [gender]) VALUES (1, N'S', N'1m60-1m65', N'55-60kg', 1)
INSERT [dbo].[Size] ([sid], [sname], [height], [weight], [gender]) VALUES (2, N'M', N'1m64-1m69', N'60-65kg', 1)
INSERT [dbo].[Size] ([sid], [sname], [height], [weight], [gender]) VALUES (3, N'L', N'1m70-1m74', N'66-70kg', 1)
INSERT [dbo].[Size] ([sid], [sname], [height], [weight], [gender]) VALUES (4, N'XL', N'1m74-1m76', N'70-76kg', 1)
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK__Cart__aid__4D94879B] FOREIGN KEY([aid])
REFERENCES [dbo].[Account] ([aid])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK__Cart__aid__4D94879B]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Color] FOREIGN KEY([color_id])
REFERENCES [dbo].[Color] ([cid])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Color]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Size1] FOREIGN KEY([size_id])
REFERENCES [dbo].[Size] ([sid])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Size1]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK__Discount__dtid__49C3F6B7] FOREIGN KEY([dtid])
REFERENCES [dbo].[DiscountType] ([dtid])
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK__Discount__dtid__49C3F6B7]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK_Discount_ProductItem] FOREIGN KEY([piid])
REFERENCES [dbo].[ProductItem] ([piid])
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_ProductItem]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([aid])
REFERENCES [dbo].[Account] ([aid])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK__Order__aid__3C69FB99] FOREIGN KEY([aid])
REFERENCES [dbo].[Account] ([aid])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK__Order__aid__3C69FB99]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK__OrderItem__orid__412EB0B6] FOREIGN KEY([orid])
REFERENCES [dbo].[Order] ([orid])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK__OrderItem__orid__412EB0B6]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[ProductItem] ([piid])
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Product] FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Product]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK__Payment__aid__398D8EEE] FOREIGN KEY([aid])
REFERENCES [dbo].[Account] ([aid])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK__Payment__aid__398D8EEE]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([orid])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Order]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([bid])
REFERENCES [dbo].[Brand] ([bid])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([catid])
REFERENCES [dbo].[Category] ([catid])
GO
ALTER TABLE [dbo].[ProductImg]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[ProductItem]  WITH CHECK ADD FOREIGN KEY([cid])
REFERENCES [dbo].[Color] ([cid])
GO
ALTER TABLE [dbo].[ProductItem]  WITH CHECK ADD FOREIGN KEY([pid])
REFERENCES [dbo].[Product] ([pid])
GO
ALTER TABLE [dbo].[ProductItem]  WITH CHECK ADD FOREIGN KEY([sid])
REFERENCES [dbo].[Size] ([sid])
GO
USE [master]
GO
ALTER DATABASE [SWP_G3] SET  READ_WRITE 
GO
