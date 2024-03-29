USE [master]
GO
/****** Object:  Database [BeanScene]    Script Date: 18/11/2021 4:54:25 PM ******/
CREATE DATABASE [BeanScene]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BeanScene', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BeanScene.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BeanScene_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BeanScene_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BeanScene] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BeanScene].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BeanScene] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BeanScene] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BeanScene] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BeanScene] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BeanScene] SET ARITHABORT OFF 
GO
ALTER DATABASE [BeanScene] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BeanScene] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BeanScene] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BeanScene] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BeanScene] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BeanScene] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BeanScene] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BeanScene] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BeanScene] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BeanScene] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BeanScene] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BeanScene] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BeanScene] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BeanScene] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BeanScene] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BeanScene] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [BeanScene] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BeanScene] SET RECOVERY FULL 
GO
ALTER DATABASE [BeanScene] SET  MULTI_USER 
GO
ALTER DATABASE [BeanScene] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BeanScene] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BeanScene] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BeanScene] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BeanScene] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BeanScene] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BeanScene', N'ON'
GO
ALTER DATABASE [BeanScene] SET QUERY_STORE = OFF
GO
USE [BeanScene]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime2](7) NOT NULL,
	[Duration] [int] NOT NULL,
	[AdditionalTimeRequested] [bit] NOT NULL,
	[Guests] [int] NOT NULL,
	[Notes] [nvarchar](200) NULL,
	[Source] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[ServiceId] [int] NULL,
	[CustomerId] [int] NULL,
	[Table] [nvarchar](max) NULL,
 CONSTRAINT [PK_Bookings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewAllBookings]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewAllBookings]
AS
SELECT        dbo.Bookings.*
FROM            dbo.Bookings
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](max) NULL,
	[VisitCount] [int] NOT NULL,
	[Tier] [nvarchar](max) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[UserLogin] [nvarchar](450) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Reason] [nvarchar](max) NOT NULL,
	[Comments] [nvarchar](250) NULL,
	[Rating] [int] NOT NULL,
	[FollowUpRequested] [bit] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Phone] [nvarchar](max) NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceArea]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceArea](
	[AreasId] [int] NOT NULL,
	[ServicesId] [int] NOT NULL,
 CONSTRAINT [PK_ServiceArea] PRIMARY KEY CLUSTERED 
(
	[AreasId] ASC,
	[ServicesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[MaxCapacity] [int] NOT NULL,
	[State] [nvarchar](max) NOT NULL,
	[SittingId] [int] NULL,
 CONSTRAINT [PK_Services] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sittings]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sittings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MealType] [nvarchar](max) NOT NULL,
	[DayOfWeek] [nvarchar](max) NOT NULL,
	[StartTime] [datetime2](7) NOT NULL,
	[EndTime] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TablesInside] [int] NOT NULL,
	[TablesOutside] [int] NOT NULL,
	[TablesBalcony] [int] NOT NULL,
 CONSTRAINT [PK_Sittings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableReservation]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableReservation](
	[BookingsId] [int] NOT NULL,
	[TablesId] [int] NOT NULL,
 CONSTRAINT [PK_TableReservation] PRIMARY KEY CLUSTERED 
(
	[BookingsId] ASC,
	[TablesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 18/11/2021 4:54:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Prefix] [nvarchar](max) NULL,
	[Seats] [int] NOT NULL,
	[AreaId] [int] NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211022003639_init', N'5.0.11')
GO
SET IDENTITY_INSERT [dbo].[Areas] ON 

INSERT [dbo].[Areas] ([Id], [Name]) VALUES (1, N'Balcony')
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (2, N'Outside')
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (3, N'Inside')
INSERT [dbo].[Areas] ([Id], [Name]) VALUES (21, N'Bar')
SET IDENTITY_INSERT [dbo].[Areas] OFF
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'27f2f889-e8df-454b-be20-dfd0e6eea26d', N'Member', N'MEMBER', N'1d32319e-7acd-4d60-9afb-bd52ca6bad38')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'2c657949-fa0b-40ec-819e-c3e9fab0bb59', N'Manager', N'MANAGER', N'f80b9155-2a66-41b8-9098-316682656a57')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'6588d913-b472-401f-96fa-8af99fe93fe1', N'Employee', N'EMPLOYEE', N'8fe909dd-f071-45b9-840e-303b4ba5c35c')
GO
INSERT [dbo].[AspNetUserLogins] ([LoginProvider], [ProviderKey], [ProviderDisplayName], [UserId]) VALUES (N'Google', N'104205302224654045972', N'Google', N'29f0b5d9-deab-4647-9e9b-af84d4184c39')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'22789bff-9925-48c4-acf2-dbe2af4b0110', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'29f0b5d9-deab-4647-9e9b-af84d4184c39', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'594e6ef7-11ec-442b-9ade-9f2da5745922', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'911ee441-fd63-4719-9368-e7225b5328b1', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c0a7d2f9-7000-4f63-acd3-3a7b2aae117a', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c28bb9cf-7d56-43c1-b000-a00f5946a067', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e854d305-221b-466d-9dcb-6c61e22622bc', N'27f2f889-e8df-454b-be20-dfd0e6eea26d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'684ed7b8-57bd-4e89-9dd3-4b382a76e5b2', N'2c657949-fa0b-40ec-819e-c3e9fab0bb59')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'87b09651-dbd3-4f35-abca-35a318249f50', N'2c657949-fa0b-40ec-819e-c3e9fab0bb59')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a941d432-329e-4e57-834f-e5a8fc18a087', N'2c657949-fa0b-40ec-819e-c3e9fab0bb59')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8db28098-c235-4966-b62f-9a21d392e4f6', N'6588d913-b472-401f-96fa-8af99fe93fe1')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'921b552c-cf2f-4e77-bda2-4002217ece48', N'6588d913-b472-401f-96fa-8af99fe93fe1')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'22789bff-9925-48c4-acf2-dbe2af4b0110', N'IdentityUser', N'Jack', N'JACK', N'jacky134@gmail.com', N'JACKY134@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEEbpnNQQt1yLHnTbbm6lp+Ja86Qa3wwAYwifb8Ko5BtRg9fz6keEytx50g/kU1ZN0A==', N'SQ4BRDJFX733YT4IDYNPIFJDBYK2YKN3', N'512d03cf-b847-48c7-8057-49671f8039d2', N'0456748567', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'29f0b5d9-deab-4647-9e9b-af84d4184c39', N'IdentityUser', N'Ben', N'BEN', N'ben.talese@gmail.com', N'BEN.TALESE@GMAIL.COM', 0, NULL, N'I2YS2C475VAN3J44T6XEROQL27ODQS32', N'34fe11ce-076b-443e-b44a-85d430959a18', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'594e6ef7-11ec-442b-9ade-9f2da5745922', N'IdentityUser', N'Morty', N'MORTY', N'morty.smith@gmail.com', N'MORTY.SMITH@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOZB1ezBqxsPw4RzCo8H7RK/QChPmhyh8FRd+MV2BbMLGeGiAZ9LeapbsJIsOvLHDg==', N'WJBE45QUFWXB7GP265C2OTQG72TZPTQ5', N'39144009-cd94-42a2-a3df-e9c48c311bc5', N'0423231313', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'684ed7b8-57bd-4e89-9dd3-4b382a76e5b2', N'IdentityUser', N'Manager', N'MANAGER', N'manager@email.com', N'MANAGER@EMAIL.COM', 0, N'AQAAAAEAACcQAAAAEL+yLxukECp9dmPuMoGrXscT+SXacZtcY1KtWA5HsRKNeNRNRapkNIENwhfngRrMQg==', N'KF56FKXJH254XAINUXV46SKWVIIWKIXB', N'230765bc-de7d-450e-823f-03258a791c17', N'0458686932', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'87b09651-dbd3-4f35-abca-35a318249f50', N'IdentityUser', N'Matthew', N'MATTHEW', N'matthew@beanscene.com', N'MATTHEW@BEANSCENE.COM', 0, N'AQAAAAEAACcQAAAAEHXwVFIvLlzPLJBecBoIcHxZZnXyMu7v6qD4TCAgdAiv+tlIpAPSWMBujEGTvae6QQ==', N'V3342KTOJZL6CVUMRSXSHJWEWHF2DOAE', N'6a2724b5-3c26-4645-9f94-b20df64d1178', N'0456345123', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8db28098-c235-4966-b62f-9a21d392e4f6', N'IdentityUser', N'Luke', N'LUKE', N'luke@beanscene.com', N'LUKE@BEANSCENE.COM', 0, N'AQAAAAEAACcQAAAAEKNI3Vw+eUjRhWMkjJHu3Dx5Yvwy1BV3bRAaIGmN0sTfDpqLvpACc2PtHc02af3W3A==', N'3GNTKST65P4ZMCQJGTEJYH765VGVGY7G', N'ba476c11-9484-4057-b626-237063407fe5', N'0456345123', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'911ee441-fd63-4719-9368-e7225b5328b1', N'IdentityUser', N'Jane', N'JANE', N'abotto5556@hotmail.com', N'ABOTTO5556@HOTMAIL.COM', 0, N'AQAAAAEAACcQAAAAENDnnkv9H5KgvEf37NaypqXn0/zNoUab6yETK1RO4vE+tUhEDWlEebycojIxn/2TtQ==', N'R4KDJX45C64QVKREUFX2JO7CPK5FCUDO', N'ebe01b66-cd76-4731-9d45-771023e7530e', N'0456781234', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'921b552c-cf2f-4e77-bda2-4002217ece48', N'IdentityUser', N'Employee', N'EMPLOYEE', N'employee@email.com', N'EMPLOYEE@EMAIL.COM', 0, N'AQAAAAEAACcQAAAAEINUlBcDpZJAJLJI2Zu3x1bMHBL/B27B9F7cj7Y62IL5YV/0wRXDZ+dud3DoFpDgpA==', N'CLKF3OQRFXWIRB6L5OZEPKARKM4QWA64', N'6e1dc445-5bc3-4423-bd23-4e1c4c934324', N'0450694031', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'a941d432-329e-4e57-834f-e5a8fc18a087', N'IdentityUser', N'Paul', N'PAUL', N'paul@beanscene.com', N'PAUL@BEANSCENE.COM', 0, N'AQAAAAEAACcQAAAAEB4hi65YnLi3yL4Ws2MJzEVKvCP8lXctzxhkh+qDvI+l9hM5CNT3QWq+WJdYA+lJ7w==', N'LQIGG3GJUXFMRZZRG4V3ZCSLQGQ4MEGP', N'7d34f38b-2f2a-4043-8343-003af0460b0a', N'0456784561', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c0a7d2f9-7000-4f63-acd3-3a7b2aae117a', N'IdentityUser', N'Gregg', N'GREGG', N'gregg.philabuster@gmail.com', N'GREGG.PHILABUSTER@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEA5EA7KV5ZOrnmLcOvmMEr9LBsATWL9S8g8IBtCfO0f8aps6Z76usI4suf5m4Koy/g==', N'YG5HWEMMGEDDPX7GCH22WGQM4O6DKPNZ', N'd3a767f8-7eac-4d2d-84e6-fc33bc7290c0', N'0456723232', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'c28bb9cf-7d56-43c1-b000-a00f5946a067', N'IdentityUser', N'Rick', N'RICK', N'rick.outerspace@gmail.com', N'RICK.OUTERSPACE@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFHwKVpwAQmfzUYE0lBbyemBh26btJV4+Lhvlz/Tp2s4o07OwGToVy4is3aWePnD5w==', N'QRYRC26TRJFLJOYR2UKHAL3M7WB4HRFD', N'26a0eb87-bd38-4af8-9e75-4a0ea08afd4a', N'0454567575', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [Discriminator], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e854d305-221b-466d-9dcb-6c61e22622bc', N'IdentityUser', N'Sam', N'SAM', N'sammy.mendel@gmail.com', N'SAMMY.MENDEL@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEJSubeCiEMnbZV2IlWM8/KXH50TzPKKsaPf4G/a0Z/H+HHrHA31MrseoS+JNzYsnVQ==', N'FT3UGMGX72ZVIJWKI7UNCPJ73XPTEK2P', N'5c6abd2d-69cb-412a-9771-aafac16c2955', N'0467456234', 0, 0, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (19, CAST(N'2021-11-11T12:30:00.0000000' AS DateTime2), 90, 1, 5, NULL, N'App', N'NoShow', 266, 35, N'O-20')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (20, CAST(N'2021-11-11T13:00:00.0000000' AS DateTime2), 90, 0, 2, NULL, N'Website', N'Approved', 266, 36, N'I-12')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (21, CAST(N'2021-11-11T13:15:00.0000000' AS DateTime2), 90, 0, 20, NULL, N'Website', N'Approved', 266, 37, N'B-4B-5, I-14, I-15, ')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (22, CAST(N'2021-11-11T14:15:00.0000000' AS DateTime2), 90, 0, 1, NULL, N'Email', N'Approved', 266, 38, N'B-1')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (23, CAST(N'2021-11-11T18:15:00.0000000' AS DateTime2), 90, 0, 11, NULL, N'Email', N'Approved', 267, 39, N'O-20O-21, ')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (24, CAST(N'2021-11-11T18:45:00.0000000' AS DateTime2), 90, 1, 17, NULL, N'Website', N'Approved', 267, 40, N'B-3B-4, B-5, O-27, ')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (25, CAST(N'2021-11-11T20:00:00.0000000' AS DateTime2), 90, 0, 8, NULL, N'Phone', N'Approved', 267, 41, N'O-20')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (26, CAST(N'2021-11-11T11:15:00.0000000' AS DateTime2), 90, 1, 4, NULL, N'Website', N'Complete', 266, 42, N'B-1B-2, ')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (27, CAST(N'2021-11-11T14:30:00.0000000' AS DateTime2), 90, 0, 4, NULL, N'Website', N'Approved', 266, 43, N'O-20')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (28, CAST(N'2021-11-11T19:30:00.0000000' AS DateTime2), 90, 0, 10, NULL, N'InPerson', N'Cancelled', 267, 44, NULL)
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (29, CAST(N'2021-11-11T19:30:00.0000000' AS DateTime2), 90, 0, 4, NULL, N'Website', N'Approved', 267, 45, N'B-1B-2, ')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (30, CAST(N'2021-11-11T19:30:00.0000000' AS DateTime2), 90, 1, 4, NULL, N'App', N'Approved', 267, 32, N'B-7')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (31, CAST(N'2021-11-11T19:30:00.0000000' AS DateTime2), 90, 0, 1, NULL, N'App', N'Approved', 267, 29, N'O-24')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (32, CAST(N'2021-11-12T12:30:00.0000000' AS DateTime2), 90, 0, 1, NULL, N'Website', N'Approved', 185, 46, N'B-2')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (33, CAST(N'2021-11-13T20:15:00.0000000' AS DateTime2), 90, 0, 10, NULL, N'Website', N'Approved', 187, 47, N'O-20O-21, ')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (34, CAST(N'2021-11-14T19:45:00.0000000' AS DateTime2), 90, 0, 1, NULL, N'Website', N'Pending', 191, 43, NULL)
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (35, CAST(N'2021-11-12T13:30:00.0000000' AS DateTime2), 90, 1, 7, NULL, N'Website', N'Pending', 185, 48, NULL)
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (36, CAST(N'2021-11-13T06:30:00.0000000' AS DateTime2), 90, 0, 7, NULL, N'Website', N'Approved', 189, 49, N'B-3')
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (37, CAST(N'2021-11-12T19:00:00.0000000' AS DateTime2), 90, 0, 7, NULL, N'Website', N'Pending', 47, 50, NULL)
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (38, CAST(N'2021-11-12T11:45:00.0000000' AS DateTime2), 90, 0, 4, NULL, N'InPerson', N'Pending', 185, 34, NULL)
INSERT [dbo].[Bookings] ([Id], [StartTime], [Duration], [AdditionalTimeRequested], [Guests], [Notes], [Source], [Status], [ServiceId], [CustomerId], [Table]) VALUES (39, CAST(N'2021-11-18T20:00:00.0000000' AS DateTime2), 90, 1, 4, N'High chair please!', N'Website', N'Pending', 199, 51, NULL)
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (25, N'Jack', N'Daniels', N'jacky134@gmail.com', N'0456748567', 3, N'VIP', CAST(N'1999-09-09T00:00:00.0000000' AS DateTime2), N'22789bff-9925-48c4-acf2-dbe2af4b0110')
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (26, N'Jane', N'Abottson', N'abotto5556@hotmail.com', N'0456781234', 1, N'Member', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'911ee441-fd63-4719-9368-e7225b5328b1')
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (27, N'Sam', N'Mendel', N'sammy.mendel@gmail.com', N'0467456234', 17, N'Patron', CAST(N'2001-09-10T00:00:00.0000000' AS DateTime2), N'e854d305-221b-466d-9dcb-6c61e22622bc')
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (28, N'Gregg', N'Phillips', N'gregg.philabuster@gmail.com', N'0456723232', 46, N'VVIP', CAST(N'1955-02-26T00:00:00.0000000' AS DateTime2), N'c0a7d2f9-7000-4f63-acd3-3a7b2aae117a')
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (29, N'Rick', N'Sanchez', N'rick.outerspace@gmail.com', N'0454567575', 3, N'Member', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'c28bb9cf-7d56-43c1-b000-a00f5946a067')
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (30, N'Morty', N'Smith', N'morty.smith@gmail.com', N'0423231313', 7, N'Member', CAST(N'1996-05-22T00:00:00.0000000' AS DateTime2), N'594e6ef7-11ec-442b-9ade-9f2da5745922')
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (32, N'Summer', N'Smith', N'summer.smith@gmail.com', N'0455524514', 5, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (34, N'Leonardo', N'Dicaprio', N'leo.dabest@hotmail.com', N'0456735455', 2, N'VVIP', CAST(N'1981-02-11T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (35, N'Chuck', N'Chuck', N'chucky@email.com', N'0495920396', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (36, N'Bob', N'Smith', N'bob@smith.com', N'0458687968', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (37, N'Jan', N'Joe', N'jan.joe@email.com', N'0458673456', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (38, N'Jack', N'Smith', N'jacky@email.com', N'0456928567', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (39, N'Jacky', N'Jones', N'jackyjones@gmail.com', N'0495929362', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (40, N'Jenny', N'Smith', N'jenny@email.com', N'0205992059', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (41, N'Kaleb', N'Jans', N'kaleb@email.com', N'0496929295', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (42, N'Greg', N'Smith', N'greg@smith.com', N'0450292962', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (43, N'Benny', N'Jassnes', N'Benny@email.com', N'0459282851', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (44, N'Justin', N'Jones', N'justin@email.com', N'0404291504', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (45, N'Khan', N'Smith', N'khan@email.com', N'0404969491', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (46, N'Bob', N'Bobby', N'bob@email.com', N'0492848682', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (47, N'Hank', N'Smith', N'hank@email.com', N'0492928285', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (48, N'Jake', N'Jackson', N'jake@email.com', N'0429285862', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (49, N'Jenson', N'James', N'Jenson@email.com', N'0492928285', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (50, N'Jackson', N'Jones', N'jackson@email.com', N'049228581', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [VisitCount], [Tier], [DateOfBirth], [UserLogin]) VALUES (51, N'John', N'Smith', N'john.smith@gmail.com', N'0456345134', 0, N'Guest', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([Id], [Title], [Reason], [Comments], [Rating], [FollowUpRequested], [Name], [Email], [Phone]) VALUES (1, N'Great Service!', N'Waitstaff', N'The waitstaff were friendly to me.', 4, 0, N'Jerry', N'jerry@email.com', N'0123456789')
INSERT [dbo].[Feedback] ([Id], [Title], [Reason], [Comments], [Rating], [FollowUpRequested], [Name], [Email], [Phone]) VALUES (2, NULL, N'Booking', N'The booking process was so easy!', 5, 0, N'Beth', N'beth@email.com', N'7894561230')
INSERT [dbo].[Feedback] ([Id], [Title], [Reason], [Comments], [Rating], [FollowUpRequested], [Name], [Email], [Phone]) VALUES (3, N'Your Kitchen is Terrible...', N'Kitchen', N'I choked on a meatball.', 3, 1, N'Morty', N'morty@email.com', N'9876543210')
INSERT [dbo].[Feedback] ([Id], [Title], [Reason], [Comments], [Rating], [FollowUpRequested], [Name], [Email], [Phone]) VALUES (4, NULL, N'Bar', N'RAN OUT OF BOOZE!!!', 0, 0, N'Rick', N'rick@email.com', N'0123456789')
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (47, CAST(N'2021-11-12T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (48, CAST(N'2022-01-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (49, CAST(N'2022-01-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (50, CAST(N'2022-01-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (51, CAST(N'2022-01-09T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (52, CAST(N'2022-01-09T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (53, CAST(N'2022-01-10T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (54, CAST(N'2022-01-10T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (55, CAST(N'2022-01-10T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (56, CAST(N'2022-01-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (57, CAST(N'2022-01-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (58, CAST(N'2022-01-12T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (59, CAST(N'2022-01-12T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (60, CAST(N'2022-01-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (61, CAST(N'2022-01-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (62, CAST(N'2022-01-14T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (63, CAST(N'2022-01-14T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (65, CAST(N'2022-01-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (66, CAST(N'2022-01-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (67, CAST(N'2022-01-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (68, CAST(N'2022-01-16T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (69, CAST(N'2022-01-16T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (70, CAST(N'2022-01-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (72, CAST(N'2022-01-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (73, CAST(N'2022-01-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (74, CAST(N'2022-01-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (75, CAST(N'2021-12-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (76, CAST(N'2021-12-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (77, CAST(N'2021-12-28T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (78, CAST(N'2021-12-28T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (79, CAST(N'2021-12-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (80, CAST(N'2021-12-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (81, CAST(N'2021-12-30T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (82, CAST(N'2021-12-30T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (83, CAST(N'2021-12-31T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (84, CAST(N'2021-12-31T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (86, CAST(N'2022-01-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (87, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (88, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (89, CAST(N'2022-01-02T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (90, CAST(N'2022-01-02T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (91, CAST(N'2022-01-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (92, CAST(N'2022-01-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (93, CAST(N'2022-01-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (94, CAST(N'2022-01-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (95, CAST(N'2022-01-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (96, CAST(N'2022-01-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (97, CAST(N'2022-01-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (98, CAST(N'2022-01-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (99, CAST(N'2022-01-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (100, CAST(N'2021-12-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (101, CAST(N'2022-01-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (102, CAST(N'2022-01-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (103, CAST(N'2022-01-30T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (104, CAST(N'2022-01-31T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (105, CAST(N'2022-01-31T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (106, CAST(N'2022-01-31T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (107, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (108, CAST(N'2022-02-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (109, CAST(N'2022-02-02T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (110, CAST(N'2022-02-02T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (111, CAST(N'2022-02-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (112, CAST(N'2022-02-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (113, CAST(N'2022-02-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (114, CAST(N'2022-02-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (116, CAST(N'2022-02-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (117, CAST(N'2022-02-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (118, CAST(N'2022-02-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (119, CAST(N'2022-02-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (120, CAST(N'2022-02-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (121, CAST(N'2022-02-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (122, CAST(N'2022-02-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (123, CAST(N'2022-02-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (124, CAST(N'2022-02-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (125, CAST(N'2022-02-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (126, CAST(N'2022-01-30T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (127, CAST(N'2022-01-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (128, CAST(N'2022-01-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (129, CAST(N'2022-01-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (130, CAST(N'2022-01-19T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (131, CAST(N'2022-01-19T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (132, CAST(N'2022-01-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (133, CAST(N'2022-01-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (134, CAST(N'2022-01-21T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (135, CAST(N'2022-01-21T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (137, CAST(N'2022-01-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (138, CAST(N'2022-01-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (139, CAST(N'2022-01-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (140, CAST(N'2022-01-23T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (141, CAST(N'2022-01-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (142, CAST(N'2022-01-23T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (143, CAST(N'2022-01-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (144, CAST(N'2022-01-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (145, CAST(N'2022-01-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (146, CAST(N'2022-01-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (147, CAST(N'2022-01-26T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (148, CAST(N'2022-01-26T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (149, CAST(N'2022-01-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (150, CAST(N'2022-01-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
GO
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (151, CAST(N'2022-01-28T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (152, CAST(N'2022-01-28T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (154, CAST(N'2022-01-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (155, CAST(N'2022-02-09T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (156, CAST(N'2021-12-26T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (157, CAST(N'2021-12-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (158, CAST(N'2021-11-23T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (159, CAST(N'2021-11-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (160, CAST(N'2021-11-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (161, CAST(N'2021-11-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (162, CAST(N'2021-11-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (163, CAST(N'2021-11-26T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (164, CAST(N'2021-11-26T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (166, CAST(N'2021-11-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (167, CAST(N'2021-11-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (168, CAST(N'2021-11-27T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (169, CAST(N'2021-11-28T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (170, CAST(N'2021-11-28T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (171, CAST(N'2021-11-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (172, CAST(N'2021-11-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (173, CAST(N'2021-11-29T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (174, CAST(N'2021-11-30T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (175, CAST(N'2021-11-30T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (176, CAST(N'2021-12-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (177, CAST(N'2021-12-01T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (178, CAST(N'2021-12-02T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (179, CAST(N'2021-12-02T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (180, CAST(N'2021-12-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (181, CAST(N'2021-11-23T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (182, CAST(N'2021-11-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (183, CAST(N'2021-11-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (184, CAST(N'2021-11-22T00:00:00.0000000' AS DateTime2), 30, N'Closed', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (185, CAST(N'2021-11-12T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (187, CAST(N'2021-11-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (188, CAST(N'2021-11-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (189, CAST(N'2021-11-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (190, CAST(N'2021-11-14T00:00:00.0000000' AS DateTime2), 30, N'Closed', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (191, CAST(N'2021-11-14T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (192, CAST(N'2021-11-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (193, CAST(N'2021-11-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (194, CAST(N'2021-11-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (195, CAST(N'2021-11-16T00:00:00.0000000' AS DateTime2), 30, N'Closed', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (196, CAST(N'2021-12-03T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (197, CAST(N'2021-11-16T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (198, CAST(N'2021-11-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (199, CAST(N'2021-11-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (200, CAST(N'2021-11-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (201, CAST(N'2021-11-19T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (202, CAST(N'2021-11-19T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (204, CAST(N'2021-11-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (205, CAST(N'2021-11-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (206, CAST(N'2021-11-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (207, CAST(N'2021-11-21T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (208, CAST(N'2021-11-21T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (209, CAST(N'2021-11-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (210, CAST(N'2021-12-26T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (212, CAST(N'2021-12-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (213, CAST(N'2021-12-16T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (214, CAST(N'2021-12-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (215, CAST(N'2021-12-17T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (217, CAST(N'2021-12-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (218, CAST(N'2021-12-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (219, CAST(N'2021-12-18T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (220, CAST(N'2021-12-19T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (221, CAST(N'2021-12-19T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (222, CAST(N'2021-12-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (223, CAST(N'2021-12-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (224, CAST(N'2021-12-20T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (225, CAST(N'2021-12-21T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (226, CAST(N'2021-12-21T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (227, CAST(N'2021-12-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (228, CAST(N'2021-12-22T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (229, CAST(N'2021-12-23T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (230, CAST(N'2021-12-23T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (231, CAST(N'2021-12-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (232, CAST(N'2021-12-24T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (234, CAST(N'2021-12-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (235, CAST(N'2021-12-25T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (236, CAST(N'2021-12-16T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (237, CAST(N'2021-12-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (238, CAST(N'2021-12-15T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (239, CAST(N'2021-12-14T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (240, CAST(N'2021-12-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (241, CAST(N'2021-12-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (242, CAST(N'2021-12-05T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (243, CAST(N'2021-12-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (244, CAST(N'2021-12-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (245, CAST(N'2021-12-06T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (246, CAST(N'2021-12-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (247, CAST(N'2021-12-07T00:00:00.0000000' AS DateTime2), 30, N'Open', 15)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (248, CAST(N'2021-12-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 12)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (249, CAST(N'2021-12-08T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (250, CAST(N'2021-12-09T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (251, CAST(N'2021-12-04T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (252, CAST(N'2021-12-09T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (253, CAST(N'2021-12-10T00:00:00.0000000' AS DateTime2), 30, N'Open', 7)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (255, CAST(N'2021-12-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 3)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (256, CAST(N'2021-12-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 4)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (257, CAST(N'2021-12-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 5)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (258, CAST(N'2021-12-12T00:00:00.0000000' AS DateTime2), 30, N'Open', 10)
GO
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (259, CAST(N'2021-12-12T00:00:00.0000000' AS DateTime2), 30, N'Open', 21)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (260, CAST(N'2021-12-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 16)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (261, CAST(N'2021-12-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 17)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (262, CAST(N'2021-12-13T00:00:00.0000000' AS DateTime2), 30, N'Open', 18)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (263, CAST(N'2021-12-14T00:00:00.0000000' AS DateTime2), 30, N'Open', 1)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (264, CAST(N'2021-12-10T00:00:00.0000000' AS DateTime2), 30, N'Open', 6)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (265, CAST(N'2022-02-09T00:00:00.0000000' AS DateTime2), 30, N'Open', 13)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (266, CAST(N'2021-11-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 11)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (267, CAST(N'2021-11-11T00:00:00.0000000' AS DateTime2), 30, N'Open', 9)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (269, CAST(N'2021-11-11T00:00:00.0000000' AS DateTime2), 30, N'Closed', 20)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (270, CAST(N'2021-11-12T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (271, CAST(N'2022-01-30T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (272, CAST(N'2022-01-28T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (273, CAST(N'2022-01-23T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (274, CAST(N'2022-01-21T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (275, CAST(N'2022-01-16T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (276, CAST(N'2022-01-14T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (277, CAST(N'2022-01-09T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (278, CAST(N'2022-01-07T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (279, CAST(N'2022-01-02T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (280, CAST(N'2021-12-31T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (281, CAST(N'2021-12-26T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (282, CAST(N'2021-12-24T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (283, CAST(N'2021-12-19T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (284, CAST(N'2021-12-17T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (285, CAST(N'2021-12-12T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (286, CAST(N'2021-12-10T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (287, CAST(N'2021-12-05T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (288, CAST(N'2021-12-03T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (289, CAST(N'2021-11-28T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (290, CAST(N'2021-11-26T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (291, CAST(N'2021-11-21T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (292, CAST(N'2021-11-19T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (293, CAST(N'2021-11-14T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (294, CAST(N'2022-02-04T00:00:00.0000000' AS DateTime2), 0, N'Open', 23)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (295, CAST(N'2022-02-06T00:00:00.0000000' AS DateTime2), 0, N'Open', 2)
INSERT [dbo].[Services] ([Id], [Date], [MaxCapacity], [State], [SittingId]) VALUES (296, CAST(N'2021-11-14T00:00:00.0000000' AS DateTime2), 0, N'Open', 24)
SET IDENTITY_INSERT [dbo].[Services] OFF
GO
SET IDENTITY_INSERT [dbo].[Sittings] ON 

INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (1, N'Lunch', N'Tuesday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (2, N'Breakfast', N'Sunday', CAST(N'2021-11-11T06:00:00.0000000' AS DateTime2), CAST(N'2021-11-11T10:30:00.0000000' AS DateTime2), 1, 0, 0, 0)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (3, N'Dinner', N'Saturday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (4, N'Lunch', N'Saturday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (5, N'Breakfast', N'Saturday', CAST(N'2021-10-30T06:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (6, N'Dinner', N'Friday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (7, N'Lunch', N'Friday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (8, N'Breakfast', N'Friday', CAST(N'2021-10-30T06:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), 0, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (9, N'Dinner', N'Thursday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (10, N'Lunch', N'Sunday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (11, N'Lunch', N'Thursday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (12, N'Dinner', N'Wednesday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (13, N'Lunch', N'Wednesday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (14, N'Breakfast', N'Wednesday', CAST(N'2021-10-30T06:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), 0, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (15, N'Dinner', N'Tuesday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (16, N'Breakfast', N'Monday', CAST(N'2021-11-08T06:00:00.0000000' AS DateTime2), CAST(N'2021-11-08T11:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (17, N'Lunch', N'Monday', CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T15:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (18, N'Dinner', N'Monday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (19, N'Breakfast', N'Tuesday', CAST(N'2021-10-30T06:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), 0, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (20, N'Breakfast', N'Thursday', CAST(N'2021-10-30T06:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T11:00:00.0000000' AS DateTime2), 0, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (21, N'Dinner', N'Sunday', CAST(N'2021-10-30T18:00:00.0000000' AS DateTime2), CAST(N'2021-10-30T22:00:00.0000000' AS DateTime2), 1, 10, 10, 10)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (23, N'Drinks', N'Friday', CAST(N'2021-11-11T22:00:00.0000000' AS DateTime2), CAST(N'2021-11-11T02:15:00.0000000' AS DateTime2), 1, 0, 0, 0)
INSERT [dbo].[Sittings] ([Id], [MealType], [DayOfWeek], [StartTime], [EndTime], [IsActive], [TablesInside], [TablesOutside], [TablesBalcony]) VALUES (24, N'Drinks', N'Sunday', CAST(N'2021-11-12T00:00:00.0000000' AS DateTime2), CAST(N'2021-11-12T03:00:00.0000000' AS DateTime2), 1, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Sittings] OFF
GO
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (22, 1)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (26, 1)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (29, 1)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (26, 2)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (29, 2)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (32, 2)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (36, 3)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (21, 4)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (24, 4)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (21, 5)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (24, 5)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (30, 7)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (20, 12)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (21, 14)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (21, 15)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (19, 20)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (23, 20)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (25, 20)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (27, 20)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (33, 20)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (23, 21)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (33, 21)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (31, 24)
INSERT [dbo].[TableReservation] ([BookingsId], [TablesId]) VALUES (24, 27)
GO
SET IDENTITY_INSERT [dbo].[Tables] ON 

INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (1, N'B', 2, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (2, N'B', 2, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (3, N'B', 8, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (4, N'B', 6, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (5, N'B', 7, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (6, N'B', 6, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (7, N'B', 4, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (8, N'B', 4, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (9, N'I', 3, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (10, N'I', 3, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (11, N'I', 4, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (12, N'I', 4, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (13, N'I', 8, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (14, N'I', 3, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (15, N'I', 5, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (16, N'I', 6, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (17, N'I', 6, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (18, N'I', 5, 3)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (19, N'O', 8, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (20, N'O', 6, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (21, N'O', 7, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (22, N'O', 2, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (23, N'O', 7, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (24, N'O', 3, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (25, N'O', 5, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (26, N'O', 4, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (27, N'O', 8, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (28, N'O', 4, 2)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (29, N'B', 8, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (30, N'B', 6, 1)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (35, N'B', 1, 21)
INSERT [dbo].[Tables] ([Id], [Prefix], [Seats], [AreaId]) VALUES (45, N'B', 3, 21)
SET IDENTITY_INSERT [dbo].[Tables] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUsers_Email]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_AspNetUsers_Email] ON [dbo].[AspNetUsers]
(
	[Email] ASC
)
WHERE ([Email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Bookings_CustomerId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_Bookings_CustomerId] ON [dbo].[Bookings]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Bookings_ServiceId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_Bookings_ServiceId] ON [dbo].[Bookings]
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Customers_Email]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Customers_Email] ON [dbo].[Customers]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Customers_UserLogin]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Customers_UserLogin] ON [dbo].[Customers]
(
	[UserLogin] ASC
)
WHERE ([UserLogin] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServiceArea_ServicesId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_ServiceArea_ServicesId] ON [dbo].[ServiceArea]
(
	[ServicesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Services_SittingId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_Services_SittingId] ON [dbo].[Services]
(
	[SittingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TableReservation_TablesId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_TableReservation_TablesId] ON [dbo].[TableReservation]
(
	[TablesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tables_AreaId]    Script Date: 18/11/2021 4:54:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tables_AreaId] ON [dbo].[Tables]
(
	[AreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bookings] ADD  DEFAULT ((90)) FOR [Duration]
GO
ALTER TABLE [dbo].[Bookings] ADD  DEFAULT ((1)) FOR [Guests]
GO
ALTER TABLE [dbo].[Sittings] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsActive]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_Customers_CustomerId]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_Services_ServiceId] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Services] ([Id])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_Services_ServiceId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_AspNetUsers_UserLogin] FOREIGN KEY([UserLogin])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_AspNetUsers_UserLogin]
GO
ALTER TABLE [dbo].[ServiceArea]  WITH CHECK ADD  CONSTRAINT [FK_ServiceArea_Areas_AreasId] FOREIGN KEY([AreasId])
REFERENCES [dbo].[Areas] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceArea] CHECK CONSTRAINT [FK_ServiceArea_Areas_AreasId]
GO
ALTER TABLE [dbo].[ServiceArea]  WITH CHECK ADD  CONSTRAINT [FK_ServiceArea_Services_ServicesId] FOREIGN KEY([ServicesId])
REFERENCES [dbo].[Services] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ServiceArea] CHECK CONSTRAINT [FK_ServiceArea_Services_ServicesId]
GO
ALTER TABLE [dbo].[Services]  WITH CHECK ADD  CONSTRAINT [FK_Services_Sittings_SittingId] FOREIGN KEY([SittingId])
REFERENCES [dbo].[Sittings] ([Id])
GO
ALTER TABLE [dbo].[Services] CHECK CONSTRAINT [FK_Services_Sittings_SittingId]
GO
ALTER TABLE [dbo].[TableReservation]  WITH CHECK ADD  CONSTRAINT [FK_TableReservation_Bookings_BookingsId] FOREIGN KEY([BookingsId])
REFERENCES [dbo].[Bookings] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TableReservation] CHECK CONSTRAINT [FK_TableReservation_Bookings_BookingsId]
GO
ALTER TABLE [dbo].[TableReservation]  WITH CHECK ADD  CONSTRAINT [FK_TableReservation_Tables_TablesId] FOREIGN KEY([TablesId])
REFERENCES [dbo].[Tables] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TableReservation] CHECK CONSTRAINT [FK_TableReservation_Tables_TablesId]
GO
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [FK_Tables_Areas_AreaId] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([Id])
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [FK_Tables_Areas_AreaId]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Bookings_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 377
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAllBookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAllBookings'
GO
USE [master]
GO
ALTER DATABASE [BeanScene] SET  READ_WRITE 
GO
