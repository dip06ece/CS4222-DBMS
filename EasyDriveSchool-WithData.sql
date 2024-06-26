USE [master]
GO
/****** Object:  Database [EasyDriveSchool ]    Script Date: 11/23/2023 5:10:50 PM ******/
CREATE DATABASE [EasyDriveSchool ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EasyDriveSchool', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\EasyDriveSchool .mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EasyDriveSchool _log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\EasyDriveSchool _log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EasyDriveSchool ] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EasyDriveSchool ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EasyDriveSchool ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET ARITHABORT OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EasyDriveSchool ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EasyDriveSchool ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EasyDriveSchool ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EasyDriveSchool ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET RECOVERY FULL 
GO
ALTER DATABASE [EasyDriveSchool ] SET  MULTI_USER 
GO
ALTER DATABASE [EasyDriveSchool ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EasyDriveSchool ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EasyDriveSchool ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EasyDriveSchool ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EasyDriveSchool ] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EasyDriveSchool ] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'EasyDriveSchool ', N'ON'
GO
ALTER DATABASE [EasyDriveSchool ] SET QUERY_STORE = OFF
GO
USE [EasyDriveSchool ]
GO
/****** Object:  UserDefinedFunction [dbo].[Total_Lessons_Attended]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das 
-- Create date: 11/22/2023
-- Description:	Function tp return total lesson a client attended
-- =============================================
CREATE FUNCTION [dbo].[Total_Lessons_Attended] 
(
	@ClientID int
)
RETURNS int
AS
BEGIN
	DECLARE @LessonCOUNT int;
	SET @LessonCOUNT  = (SELECT COUNT([ClientID]) 
	FROM [dbo].[DrivingLessons]
	WHERE [ClientID]=@ClientID);

	IF (@LessonCOUNT IS NULL)
        SET @LessonCOUNT = 0;
    RETURN @LessonCOUNT;
END
GO
/****** Object:  UserDefinedFunction [dbo].[Total_Lessons_Attended_Before]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das 
-- Create date: 11/22/2023
-- Description:	Function tp return total lesson a client attended
-- =============================================
CREATE FUNCTION [dbo].[Total_Lessons_Attended_Before] 
(
	@ClientID int,
	@ProvidedDate Date
)
RETURNS int
AS
BEGIN
	DECLARE @LessonCOUNT int;
	SET @LessonCOUNT  = (SELECT COUNT([ClientID]) 
	FROM [dbo].[DrivingLessons]
	WHERE [ClientID]=@ClientID AND [LessonDateTime]<@ProvidedDate);

	IF (@LessonCOUNT IS NULL)
        SET @LessonCOUNT = 0;
    RETURN @LessonCOUNT;
END
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] NOT NULL,
	[OfficeID] [int] NOT NULL,
	[ClientName] [varchar](50) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Sex] [char](1) NOT NULL,
	[PassDate] [date] NULL,
	[DateOfBirth] [date] NULL,
	[AssignedToStaff] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrivingLessons]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivingLessons](
	[LessonID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[MilesDriven] [int] NULL,
	[BunchID] [int] NULL,
	[LessonDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Client_Lesson]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Client_Lesson]
AS
SELECT        TOP (100) PERCENT dbo.Clients.ClientID, dbo.Clients.ClientName, dbo.Clients.Sex, dbo.DrivingLessons.StaffID, dbo.DrivingLessons.MilesDriven, dbo.DrivingLessons.BunchID, 
                         dbo.DrivingLessons.LessonDateTime AS [Lesson Date]
FROM            dbo.Clients INNER JOIN
                         dbo.DrivingLessons ON dbo.Clients.ClientID = dbo.DrivingLessons.ClientID
WHERE        (dbo.DrivingLessons.StaffID = dbo.DrivingLessons.StaffID)
ORDER BY dbo.Clients.ClientID, dbo.DrivingLessons.StaffID
GO
/****** Object:  Table [dbo].[Staffs]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staffs](
	[StaffID] [int] NOT NULL,
	[StaffName] [varchar](50) NOT NULL,
	[TelephoneNo] [varchar](20) NOT NULL,
	[Sex] [char](1) NOT NULL,
	[Birthdate] [date] NOT NULL,
	[OfficeID] [int] NULL,
	[NoOfClients] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Lesson_Info]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Lesson_Info]
AS
SELECT        TOP (100) PERCENT dbo.Client_Lesson.ClientID, dbo.Client_Lesson.ClientName, dbo.Client_Lesson.Sex, dbo.Client_Lesson.MilesDriven, dbo.Client_Lesson.BunchID, dbo.Client_Lesson.[Lesson Date], dbo.Staffs.StaffName, 
                         dbo.Staffs.StaffID AS [Staff ID]
FROM            dbo.Client_Lesson INNER JOIN
                         dbo.Staffs ON dbo.Client_Lesson.StaffID = dbo.Staffs.StaffID
ORDER BY [Staff ID]
GO
/****** Object:  Table [dbo].[IdentifiedFault]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdentifiedFault](
	[IdentifiedFaultID] [int] IDENTITY(1,1) NOT NULL,
	[InspectionID] [int] NULL,
	[FaultID] [int] NOT NULL,
	[FaultDescription] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdentifiedFaultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faults]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faults](
	[FaultID] [int] NOT NULL,
	[FaultType] [varchar](50) NOT NULL,
	[FaultName] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FaultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inspection]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inspection](
	[InspectionID] [int] NOT NULL,
	[InspectionDate] [date] NOT NULL,
	[RegistrationNo] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InspectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars](
	[RegistrationNo] [varchar](20) NOT NULL,
	[OfficeID] [int] NULL,
	[AssignedTo] [int] NULL,
	[InspectionInterval] [int] NOT NULL,
	[LastInspectionDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RegistrationNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Car_Fault_History_Details]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Car_Fault_History_Details]
AS
SELECT        TOP (100) PERCENT dbo.Cars.RegistrationNo, dbo.Cars.OfficeID, dbo.Cars.AssignedTo, dbo.Cars.InspectionInterval, dbo.Cars.LastInspectionDate, dbo.Inspection.InspectionDate, dbo.Inspection.InspectionID, 
                         dbo.IdentifiedFault.FaultID, dbo.IdentifiedFault.FaultDescription, dbo.IdentifiedFault.IdentifiedFaultID, dbo.Faults.FaultType, dbo.Faults.FaultName
FROM            dbo.IdentifiedFault INNER JOIN
                         dbo.Faults ON dbo.IdentifiedFault.FaultID = dbo.Faults.FaultID INNER JOIN
                         dbo.Inspection ON dbo.IdentifiedFault.InspectionID = dbo.Inspection.InspectionID INNER JOIN
                         dbo.Cars ON dbo.Inspection.RegistrationNo = dbo.Cars.RegistrationNo
ORDER BY dbo.Cars.OfficeID, dbo.Cars.RegistrationNo
GO
/****** Object:  Table [dbo].[Office]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Office](
	[OfficeID] [int] IDENTITY(1,1) NOT NULL,
	[ManagedbyStaff] [int] NULL,
	[City] [varchar](50) NOT NULL,
	[Street] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OfficeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Office_Managers_Birthday]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Office_Managers_Birthday]
AS
SELECT        TOP (100) PERCENT dbo.Office.ManagedbyStaff, dbo.Staffs.StaffName, dbo.Staffs.TelephoneNo, dbo.Staffs.Birthdate, dbo.Office.OfficeID
FROM            dbo.Office INNER JOIN
                         dbo.Staffs ON dbo.Office.ManagedbyStaff = dbo.Staffs.StaffID AND dbo.Office.OfficeID = dbo.Staffs.OfficeID
ORDER BY dbo.Office.OfficeID
GO
/****** Object:  UserDefinedFunction [dbo].[Client_Lessons_for_Client]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das 
-- Create date: 11/22/2023
-- Description:	Client_Lessons_for_Client
-- =============================================
CREATE FUNCTION [dbo].[Client_Lessons_for_Client] 
(	
	@ClientID int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT C.ClientID, C.ClientName, C.Address, 
	       C.Sex, D.LessonID, D.StaffID, 
		   D.MilesDriven, D.BunchID, D.LessonDateTime 
	FROM Clients C JOIN DrivingLessons D 
	ON C.ClientID = D.ClientID
	WHERE C.ClientID = @ClientID
	GROUP BY C.ClientID, C.ClientName, C.Address, 
	       C.Sex, D.LessonID, D.StaffID, 
		   D.MilesDriven, D.BunchID, D.LessonDateTime
);
GO
/****** Object:  Table [dbo].[BunchList]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BunchList](
	[BunchID] [int] NOT NULL,
	[BunchDiscount] [float] NULL,
	[BunchStartDate] [date] NULL,
	[BunchEndDate] [date] NULL,
	[TimeSlot] [varchar](20) NULL,
 CONSTRAINT [PK_BunchList] PRIMARY KEY CLUSTERED 
(
	[BunchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DrivingTest]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivingTest](
	[TestID] [int] IDENTITY(1,1) NOT NULL,
	[TestCenter] [varchar](50) NOT NULL,
	[ClientID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[TestDate] [date] NOT NULL,
	[TestResult] [varchar](10) NOT NULL,
	[Remarks] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interview](
	[InterviewID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[InterviewDate] [date] NULL,
	[PermitValidationID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InterviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermitValidation]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermitValidation](
	[PermitValidationID] [int] NOT NULL,
	[InterviewStatus] [varchar](20) NULL,
	[PermitStatus] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[PermitValidationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleEntry] [int] IDENTITY(1,1) NOT NULL,
	[StaffID] [int] NOT NULL,
	[DateFrom] [date] NOT NULL,
	[role] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleEntry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BunchList] ([BunchID], [BunchDiscount], [BunchStartDate], [BunchEndDate], [TimeSlot]) VALUES (1, 15, CAST(N'2023-08-21' AS Date), CAST(N'2023-09-21' AS Date), N'4:00 PM')
INSERT [dbo].[BunchList] ([BunchID], [BunchDiscount], [BunchStartDate], [BunchEndDate], [TimeSlot]) VALUES (2, 15, CAST(N'2023-09-22' AS Date), CAST(N'2023-10-22' AS Date), N'4:00 PM')
INSERT [dbo].[BunchList] ([BunchID], [BunchDiscount], [BunchStartDate], [BunchEndDate], [TimeSlot]) VALUES (3, 20, CAST(N'2023-08-20' AS Date), CAST(N'2023-09-20' AS Date), N'10:15 AM')
GO
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'ABCD012', 10, 14, 30, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'AY2IHWJ', 8, 3, 90, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'BD5ISMR', 7, 1, 90, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'CROSTON', 15, 11, 70, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'GD70E00', 12, 8, 90, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'KBC0123', 11, 7, 60, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'OPI8TES', 13, 9, 80, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'SC07LND', 9, 5, 60, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[Cars] ([RegistrationNo], [OfficeID], [AssignedTo], [InspectionInterval], [LastInspectionDate]) VALUES (N'SEIOMAR', 14, 18, 90, CAST(N'2023-01-01' AS Date))
GO
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (1, 7, N'Fergus Bruce', N'12 Sloe Lane, Glasgow', N'M', NULL, CAST(N'1997-07-23' AS Date), 2)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (2, 8, N'Regan Fleming', N'31 Park Terrace, Edinburgh', N'M', NULL, CAST(N'2000-10-25' AS Date), 3)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (3, 8, N'Ruaridh Sutherland', N'57 Caradon Hill, Edinburgh', N'F', NULL, CAST(N'2004-12-25' AS Date), 3)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (4, 9, N'Joe Robertson', N'11 Friar Street, Aberdeen', N'M', CAST(N'2023-11-18' AS Date), CAST(N'2002-09-22' AS Date), 5)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (5, 9, N'Fergus Davidson', N'3 Buckingham Rd, Aberdeen', N'M', NULL, CAST(N'2001-04-12' AS Date), 5)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (6, 10, N'Will McMillan', N'52 Long Street, Dundee', N'F', NULL, CAST(N'2005-03-11' AS Date), 14)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (7, 10, N'Kyle Wright', N'46 Quay Street, Dundee', N'M', NULL, CAST(N'2007-08-15' AS Date), 14)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (8, 11, N'Ross Hughes', N'7 Thames Street,Livingston', N'F', NULL, CAST(N'1999-02-08' AS Date), 7)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (9, 12, N'Finn Findlay', N'46 Seafield Street, Hamilton', N'F', NULL, CAST(N'2004-02-01' AS Date), 7)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (10, 12, N'Kris Davidson', N'54 Canterbury Road, Hamilton', N'M', CAST(N'2023-11-21' AS Date), CAST(N'2006-01-01' AS Date), 11)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (11, 13, N'Maria Davidson', N'10 Kent Street, Perth', N'F', NULL, CAST(N'2008-01-03' AS Date), 9)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (12, 14, N'Cristina Hunter', N'91 Earls Avenue, Falkirk', N'F', NULL, CAST(N'2005-04-04' AS Date), 18)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (13, 14, N'Jill Fleming', N'86 Iffley Road, Falkirk', N'F', CAST(N'2023-11-20' AS Date), CAST(N'2009-08-08' AS Date), 18)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (14, 15, N'Niall Gordon', N'45 Abingdon Road, Wishaw', N'F', NULL, CAST(N'2003-03-03' AS Date), 11)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (15, 15, N'Callan Paterson', N'56 Huntly Street, Wishaw', N'M', NULL, CAST(N'2002-02-02' AS Date), 11)
INSERT [dbo].[Clients] ([ClientID], [OfficeID], [ClientName], [Address], [Sex], [PassDate], [DateOfBirth], [AssignedToStaff]) VALUES (16, 7, N'Rita Hammer', N'12 Victor Lane, Glasgow', N'F', NULL, CAST(N'2000-01-01' AS Date), 11)
GO
SET IDENTITY_INSERT [dbo].[DrivingLessons] ON 

INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (1, 2, 3, 50, 2, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (2, 3, 3, 40, NULL, CAST(N'2023-11-16T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (3, 4, 5, 50, NULL, CAST(N'2023-11-08T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (4, 6, 14, 30, NULL, CAST(N'2023-11-23T10:30:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (5, 7, 14, 400, 3, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (6, 8, 7, 45, NULL, CAST(N'2023-11-21T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (7, 10, 8, 40, 1, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (8, 11, 9, 35, NULL, CAST(N'2023-11-15T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (9, 12, 18, 90, NULL, CAST(N'2023-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (10, 13, 18, 20, NULL, CAST(N'2023-11-18T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (11, 14, 11, 40, NULL, CAST(N'2023-08-10T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (12, 15, 11, 60, NULL, CAST(N'2023-11-12T00:00:00.000' AS DateTime))
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (14, 2, 3, 30, 2, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (15, 2, 3, 20, 2, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (17, 2, 3, 40, 2, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (18, 2, 3, 40, 2, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (19, 2, 3, 50, 2, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (20, 3, 3, 25, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (21, 3, 3, 30, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (22, 3, 3, 40, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (23, 3, 3, 40, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (24, 4, 5, 50, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (25, 4, 5, 50, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (26, 4, 5, 50, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (27, 6, 14, 30, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (28, 7, 14, 40, 3, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (29, 7, 14, 50, 3, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (30, 7, 14, 20, 3, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (31, 8, 7, 25, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (32, 8, 7, 20, NULL, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (33, 10, 8, 30, 1, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (34, 10, 8, 40, 1, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (35, 10, 8, 40, 1, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (36, 10, 8, 35, 1, NULL)
INSERT [dbo].[DrivingLessons] ([LessonID], [ClientID], [StaffID], [MilesDriven], [BunchID], [LessonDateTime]) VALUES (37, 10, 11, 20, NULL, CAST(N'2023-11-12T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[DrivingLessons] OFF
GO
SET IDENTITY_INSERT [dbo].[DrivingTest] ON 

INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (1, N'Edinburgh', 2, 3, CAST(N'2023-11-22' AS Date), N'Pending', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (2, N'Edinburgh', 3, 3, CAST(N'2023-11-26' AS Date), N'Pending', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (3, N'Aberdeen', 4, 5, CAST(N'2023-11-18' AS Date), N'Pass', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (4, N'Dundee', 7, 14, CAST(N'2023-11-20' AS Date), N'Pass', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (5, N'Hamilton', 10, 8, CAST(N'2023-11-21' AS Date), N'Pass', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (6, N'Falkirk', 12, 18, CAST(N'2023-11-24' AS Date), N'Pending', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (7, N'Falkirk', 13, 18, CAST(N'2023-11-20' AS Date), N'Pass', NULL)
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (8, N'Wishaw', 14, 11, CAST(N'2023-11-10' AS Date), N'Fail', N'Overspeed')
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (9, N'Wishaw', 14, 11, CAST(N'2023-11-11' AS Date), N'Fail', N'Parking Issue')
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (10, N'Wishaw', 14, 11, CAST(N'2023-11-20' AS Date), N'Fail', N'Signal Missed')
INSERT [dbo].[DrivingTest] ([TestID], [TestCenter], [ClientID], [StaffID], [TestDate], [TestResult], [Remarks]) VALUES (12, N'Falkrik', 14, 12, CAST(N'2023-11-21' AS Date), N'Fail', N'Late')
SET IDENTITY_INSERT [dbo].[DrivingTest] OFF
GO
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (1, N'Battery', N'Dead Battery')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (2, N'Spark Plug', N'Aged Spark Plugs')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (3, N'Radiator ', N'Radiator Leaks')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (4, N'Heating', N'OverHeating')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (5, N'Transmission', N'Transmission jammed')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (6, N'Windshield', N'Windshield Crack')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (7, N'Warning', N'Warning Light')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (8, N'Tire', N'Traction error')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (9, N'Tire', N'Low Tire Pressure')
INSERT [dbo].[Faults] ([FaultID], [FaultType], [FaultName]) VALUES (10, N'Tire', N'Flat Tire')
GO
SET IDENTITY_INSERT [dbo].[IdentifiedFault] ON 

INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (3, 1, 1, N'Battery voltage level is found below expected rating')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (5, 2, 2, N'One spark plug is working incorrect ')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (6, 3, 8, N'Car showing warning about improper traction ')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (7, 4, 5, N'Transmission is not working smoothly ')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (8, 5, 7, N'Headlight showing warning but working normal')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (9, 6, 4, N'Sometimes car is getting stopped due to overheating')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (10, 7, 10, N'Tire punctured')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (11, 8, 9, N'Front-left Tire pressure is found 32')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (12, 10, 4, N'Some heating issue is found need to fix')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (13, 15, 3, N'Radiator water is low')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (14, 11, 7, N'Seat belt warning not going ')
INSERT [dbo].[IdentifiedFault] ([IdentifiedFaultID], [InspectionID], [FaultID], [FaultDescription]) VALUES (15, 14, 5, N'Transmission is not smooth ')
SET IDENTITY_INSERT [dbo].[IdentifiedFault] OFF
GO
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (1, CAST(N'2023-01-01' AS Date), N'ABCD012')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (2, CAST(N'2023-01-01' AS Date), N'AY2IHWJ')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (3, CAST(N'2023-01-01' AS Date), N'BD5ISMR')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (4, CAST(N'2023-01-01' AS Date), N'CROSTON')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (5, CAST(N'2023-01-01' AS Date), N'GD70E00')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (6, CAST(N'2023-01-01' AS Date), N'KBC0123')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (7, CAST(N'2023-01-01' AS Date), N'OPI8TES')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (8, CAST(N'2023-01-01' AS Date), N'SC07LND')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (9, CAST(N'2023-01-01' AS Date), N'SEIOMAR')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (10, CAST(N'2022-12-02' AS Date), N'ABCD012')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (11, CAST(N'2022-10-03' AS Date), N'AY2IHWJ')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (12, CAST(N'2022-10-03' AS Date), N'BD5ISMR')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (13, CAST(N'2022-10-23' AS Date), N'CROSTON')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (14, CAST(N'2022-10-03' AS Date), N'GD70E00')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (15, CAST(N'2022-11-02' AS Date), N'KBC0123')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (16, CAST(N'2022-10-13' AS Date), N'OPI8TES')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (17, CAST(N'2022-11-02' AS Date), N'SC07LND')
INSERT [dbo].[Inspection] ([InspectionID], [InspectionDate], [RegistrationNo]) VALUES (18, CAST(N'2022-10-03' AS Date), N'SEIOMAR')
GO
SET IDENTITY_INSERT [dbo].[Interview] ON 

INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (1, 1, 1, CAST(N'2023-11-15' AS Date), 13)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (2, 2, 3, CAST(N'2023-09-22' AS Date), 4)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (3, 3, 3, CAST(N'2023-09-26' AS Date), 5)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (4, 4, 5, CAST(N'2023-10-18' AS Date), 7)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (5, 5, 5, CAST(N'2023-12-15' AS Date), 16)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (6, 5, 5, CAST(N'2023-11-10' AS Date), 12)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (7, 6, 14, CAST(N'2023-11-20' AS Date), 14)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (8, 7, 14, CAST(N'2023-08-20' AS Date), 2)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (9, 8, 7, CAST(N'2023-11-21' AS Date), 15)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (10, 9, 8, CAST(N'2023-11-01' AS Date), 9)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (11, 10, 8, CAST(N'2023-08-21' AS Date), 3)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (12, 11, 9, CAST(N'2023-11-05' AS Date), 10)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (13, 12, 18, CAST(N'2023-11-01' AS Date), 8)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (14, 13, 18, CAST(N'2023-10-01' AS Date), 6)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (15, 14, 11, CAST(N'2023-08-10' AS Date), 1)
INSERT [dbo].[Interview] ([InterviewID], [ClientID], [StaffID], [InterviewDate], [PermitValidationID]) VALUES (16, 15, 11, CAST(N'2023-11-08' AS Date), 11)
SET IDENTITY_INSERT [dbo].[Interview] OFF
GO
SET IDENTITY_INSERT [dbo].[Office] ON 

INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (7, 2, N'Glasgow', N'15 Main Street')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (8, 4, N'Edinburgh', N'19 Leicester Close')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (9, 13, N'Aberdeen', N'12 Orchard Avenue')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (10, 6, N'Dundee', N'35  Redman Close')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (11, 15, N'Livingston', N'18  Willoughby Close')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (12, 16, N'Hamilton', N'3 Honingham Close')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (13, 17, N'Perth', N'8  Great High Ground')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (14, 10, N'Falkirk', N'2  Thwaite Road')
INSERT [dbo].[Office] ([OfficeID], [ManagedbyStaff], [City], [Street]) VALUES (15, 12, N'Wishaw', N'21  Rayleigh Close')
SET IDENTITY_INSERT [dbo].[Office] OFF
GO
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (1, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (2, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (3, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (4, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (5, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (6, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (7, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (8, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (9, N'Failed', N'Applied for Permit')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (10, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (11, N'Passed', N'Ok')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (12, N'Rescheduled', N'Applied for Permit')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (13, N'Failed', N'No Permit')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (14, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (15, N'Passed', N'OK')
INSERT [dbo].[PermitValidation] ([PermitValidationID], [InterviewStatus], [PermitStatus]) VALUES (16, N'Rescheduled', N'Applied for Permit')
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (1, 1, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (2, 2, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (3, 3, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (4, 4, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (5, 5, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (6, 13, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (7, 14, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (8, 6, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (9, 7, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (10, 15, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (11, 16, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (12, 17, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (13, 8, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (14, 9, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (15, 18, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (16, 10, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (17, 11, CAST(N'2001-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (18, 12, CAST(N'2001-01-01' AS Date), N'Senior Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (20, 19, CAST(N'2023-01-01' AS Date), N'Instructor')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (22, 20, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (23, 21, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (24, 22, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (25, 23, CAST(N'2023-10-10' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (26, 24, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (27, 25, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (28, 26, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (29, 27, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (30, 28, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
INSERT [dbo].[Roles] ([RoleEntry], [StaffID], [DateFrom], [role]) VALUES (31, 29, CAST(N'2023-01-01' AS Date), N'Administrative Staff')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (1, N'Dip Ranjon Das', N'641-233-1234', N'M', CAST(N'2001-01-01' AS Date), 7, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (2, N'Richard', N'641-233-2345', N'M', CAST(N'1990-01-02' AS Date), 7, 1)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (3, N'Patrick J. Bonner', N'641-233-3456', N'M', CAST(N'2002-02-06' AS Date), 8, 2)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (4, N'James R. Bennett', N'641-233-4567', N'M', CAST(N'1996-06-06' AS Date), 8, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (5, N'Vilma J. Sanford', N'641-233-5678', N'F', CAST(N'1997-07-07' AS Date), 9, 2)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (6, N'Annie A. Bush', N'641-233-6789', N'F', CAST(N'1998-08-08' AS Date), 10, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (7, N'Raul E. Dunham', N'641-233-0987', N'M', CAST(N'1994-04-04' AS Date), 11, 2)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (8, N'Terry M. Blanchard', N'641-233-0876', N'M', CAST(N'1996-06-06' AS Date), 12, 1)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (9, N'Noel P. Morse', N'641-233-0765', N'M', CAST(N'1992-03-02' AS Date), 13, 1)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (10, N'Cheryl M. Warren', N'641-233-0654', N'F', CAST(N'1990-09-09' AS Date), 14, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (11, N'Grace D. White', N'641-233-0432', N'F', CAST(N'1968-10-10' AS Date), 15, 4)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (12, N'Cynthia B. Predmore', N'641-233-0321', N'M', CAST(N'1990-09-09' AS Date), 15, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (13, N'Louella R. Keenan', N'641-233-0123', N'F', CAST(N'1990-01-01' AS Date), 9, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (14, N'Sara R. Meade', N'641-233-0234', N'F', CAST(N'1991-01-01' AS Date), 10, 2)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (15, N'Elvera E. Murphy', N'641-233-0345', N'F', CAST(N'1992-02-02' AS Date), 11, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (16, N'Lori T. Bone', N'641-233-0456', N'F', CAST(N'1991-01-01' AS Date), 12, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (17, N'Walter S. West', N'641-233-0567', N'M', CAST(N'1988-08-08' AS Date), 13, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (18, N'Harold N. Wilder', N'641-233-0678', N'M', CAST(N'1997-01-01' AS Date), 14, 2)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (19, N'Amina Rahman', N'641-233-0906', N'F', CAST(N'2005-05-05' AS Date), 7, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (20, N'Arwen Watt', N'641-233-0806', N'M', CAST(N'2000-01-02' AS Date), 7, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (21, N'Mason Hill', N'641-233-0807', N'M', CAST(N'2000-01-01' AS Date), 8, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (22, N'Faryl Johnston', N'641-233-9000', N'F', CAST(N'2000-01-01' AS Date), 9, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (23, N'Mathew Clark', N'641-233-9111', N'M', CAST(N'2000-01-01' AS Date), 10, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (24, N'Caoimhe Cameron', N'641-233-9222', N'F', CAST(N'2000-01-01' AS Date), 11, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (25, N'Clara Hay', N'641-233-9110', N'F', CAST(N'2000-01-10' AS Date), 12, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (26, N'Tori Crawford', N'641-233-9112', N'F', CAST(N'1999-01-01' AS Date), 13, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (27, N'Margaret Bruce', N'641-233-9113', N'F', CAST(N'1990-01-01' AS Date), 14, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (28, N'Kadyn Reilly', N'641-233-9114', N'F', CAST(N'1991-01-01' AS Date), 15, NULL)
INSERT [dbo].[Staffs] ([StaffID], [StaffName], [TelephoneNo], [Sex], [Birthdate], [OfficeID], [NoOfClients]) VALUES (29, N'Ciaran Cameron', N'641-233-9115', N'F', CAST(N'1980-01-01' AS Date), 15, NULL)
GO
ALTER TABLE [dbo].[PermitValidation] ADD  DEFAULT (NULL) FOR [InterviewStatus]
GO
ALTER TABLE [dbo].[PermitValidation] ADD  DEFAULT (NULL) FOR [PermitStatus]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD FOREIGN KEY([AssignedTo])
REFERENCES [dbo].[Staffs] ([StaffID])
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD FOREIGN KEY([OfficeID])
REFERENCES [dbo].[Office] ([OfficeID])
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD FOREIGN KEY([OfficeID])
REFERENCES [dbo].[Office] ([OfficeID])
GO
ALTER TABLE [dbo].[DrivingLessons]  WITH CHECK ADD FOREIGN KEY([BunchID])
REFERENCES [dbo].[BunchList] ([BunchID])
GO
ALTER TABLE [dbo].[DrivingLessons]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[DrivingLessons]  WITH CHECK ADD FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staffs] ([StaffID])
GO
ALTER TABLE [dbo].[DrivingTest]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[DrivingTest]  WITH CHECK ADD FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staffs] ([StaffID])
GO
ALTER TABLE [dbo].[IdentifiedFault]  WITH CHECK ADD FOREIGN KEY([FaultID])
REFERENCES [dbo].[Faults] ([FaultID])
GO
ALTER TABLE [dbo].[IdentifiedFault]  WITH CHECK ADD FOREIGN KEY([InspectionID])
REFERENCES [dbo].[Inspection] ([InspectionID])
GO
ALTER TABLE [dbo].[Inspection]  WITH CHECK ADD FOREIGN KEY([RegistrationNo])
REFERENCES [dbo].[Cars] ([RegistrationNo])
GO
ALTER TABLE [dbo].[Interview]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Interview]  WITH CHECK ADD FOREIGN KEY([PermitValidationID])
REFERENCES [dbo].[PermitValidation] ([PermitValidationID])
GO
ALTER TABLE [dbo].[Interview]  WITH CHECK ADD FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staffs] ([StaffID])
GO
ALTER TABLE [dbo].[Office]  WITH CHECK ADD FOREIGN KEY([ManagedbyStaff])
REFERENCES [dbo].[Staffs] ([StaffID])
GO
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staffs] ([StaffID])
GO
ALTER TABLE [dbo].[Staffs]  WITH CHECK ADD FOREIGN KEY([OfficeID])
REFERENCES [dbo].[Office] ([OfficeID])
GO
/****** Object:  StoredProcedure [dbo].[AllLessionsbyClient]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/22/2023
-- Description:	Provide Client name and findout details of all lessons 
-- =============================================
CREATE     PROCEDURE [dbo].[AllLessionsbyClient] 

	@ClientName VARCHAR(20)

AS
BEGIN

	SET NOCOUNT ON;

	SELECT * FROM [dbo].[DrivingLessons] 
	WHERE [ClientID] IN (
					SELECT [ClientID]  
					FROM [dbo].[Clients] 
					WHERE [ClientName] = @ClientName
					);
END
GO
/****** Object:  StoredProcedure [dbo].[AllLessionsbyInstructor]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/22/2023
-- Description:	Provide instructors name and findout details of all lessons 
-- =============================================
CREATE   PROCEDURE [dbo].[AllLessionsbyInstructor] 

	@InstructorName VARCHAR(20)

AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[DrivingLessons] 
	WHERE [StaffID] IN (
					SELECT [StaffID]  
					FROM [dbo].[Staffs] 
					WHERE [StaffName] = @InstructorName
					);
END
GO
/****** Object:  StoredProcedure [dbo].[Demo_Cursor_Determine_Fee_With_Case]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/23/2023
-- Description:	Cursor code with IF Else to increase Fees
-- =============================================
CREATE   PROCEDURE [dbo].[Demo_Cursor_Determine_Fee_With_Case] 

AS
BEGIN
		CREATE TABLE #LessonTable
		(
			LessonID INT,
			ClientID INT,
			StaffID INT, 
			MilesDriven INT,
			BunchID INT,
			LessonDateTime datetime,
			Fee int
		);  --- Creating a temporary table

		INSERT INTO #LessonTable (LessonID,ClientID,StaffID,MilesDriven,BunchID,LessonDateTime)(SELECT * FROM [dbo].[DrivingLessons]);
		--- Reading all Lessons and storing in a new temporary table 

		 
		DECLARE @row_variable1 INT;
		DECLARE @LessonID int,@ClientID int,@StaffID int ,@MilesDriven int,@BunchID int,@LessonDateTime datetime,@Fee int;
		--- Cursor1 code
		DECLARE LessonTable_cursor CURSOR FOR
		SELECT * FROM #LessonTable;

		OPEN LessonTable_cursor;
		FETCH NEXT FROM LessonTable_cursor INTO @LessonID,@ClientID,@StaffID,@MilesDriven,@BunchID,@LessonDateTime,@Fee;  
		--- Fetch first item of the cursor to variable 
		

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Fee = CASE
				WHEN @MilesDriven>30 THEN 10
				WHEN @MilesDriven>25 THEN 8
				WHEN @MilesDriven>20 THEN 5
				ELSE @Fee
			END; 
		  UPDATE #LessonTable SET [Fee] = @FEE WHERE [LessonID] = @LessonID;

		  FETCH NEXT FROM LessonTable_cursor INTO @LessonID,@ClientID,@StaffID,@MilesDriven,@BunchID,@LessonDateTime,@Fee; 
		END;

		CLOSE LessonTable_cursor;
		DEALLOCATE LessonTable_cursor;

		SELECT * FROM #LessonTable;
		DROP Table #LessonTable;
END
GO
/****** Object:  StoredProcedure [dbo].[Demo_Cursor_Determine_Fee_With_ifelse]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/23/2023
-- Description:	Cursor code with IF Else to increase Fees
-- =============================================
CREATE   PROCEDURE [dbo].[Demo_Cursor_Determine_Fee_With_ifelse] 

AS
BEGIN
		CREATE TABLE #LessonTable
		(
			LessonID INT,
			ClientID INT,
			StaffID INT, 
			MilesDriven INT,
			BunchID INT,
			LessonDateTime datetime,
			Fee int
		);  --- Creating a temporary table

		INSERT INTO #LessonTable (LessonID,ClientID,StaffID,MilesDriven,BunchID,LessonDateTime)(SELECT * FROM [dbo].[DrivingLessons]);
		--- Reading all Lessons and storing in a new temporary table 

		 
		DECLARE @row_variable1 INT;
		DECLARE @LessonID int,@ClientID int,@StaffID int ,@MilesDriven int,@BunchID int,@LessonDateTime datetime,@Fee int;
		--- Cursor1 code
		DECLARE LessonTable_cursor CURSOR FOR
		SELECT * FROM #LessonTable;

		OPEN LessonTable_cursor;
		FETCH NEXT FROM LessonTable_cursor INTO @LessonID,@ClientID,@StaffID,@MilesDriven,@BunchID,@LessonDateTime,@Fee;  
		--- Fetch first item of the cursor to variable 
		

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @MilesDriven>30 SET @Fee = 10
			ELSE IF @MilesDriven>25 SET @Fee = 8
			ELSE IF @MilesDriven>20  SET @Fee = 5
			ELSE SET @Fee = @Fee
		  UPDATE #LessonTable SET [Fee] = @FEE WHERE [LessonID] = @LessonID;

		  FETCH NEXT FROM LessonTable_cursor INTO @LessonID,@ClientID,@StaffID,@MilesDriven,@BunchID,@LessonDateTime,@Fee; 
		END;

		CLOSE LessonTable_cursor;
		DEALLOCATE LessonTable_cursor;

		SELECT * FROM #LessonTable;
		DROP Table #LessonTable;
END
GO
/****** Object:  StoredProcedure [dbo].[InstructorsClients]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/22/2023
-- Description:	List of all Staffs and their Clients
-- =============================================
CREATE   PROCEDURE [dbo].[InstructorsClients]
	@InstructorName VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT  S.StaffName, C.ClientName FROM Staffs S JOIN DrivingLessons ON S.StaffID = DrivingLessons.StaffID 
													 JOIN Clients C ON DrivingLessons.ClientID = C.ClientID
								  WHERE S.StaffName = @InstructorName GROUP BY S.StaffName, C.ClientName;
	
END
GO
/****** Object:  StoredProcedure [dbo].[OneWeekLessionsbyClientFromDate]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/22/2023
-- Description:	Provide Client name and findout details of all lessons 
-- =============================================
CREATE     PROCEDURE [dbo].[OneWeekLessionsbyClientFromDate] 

	@ClientName VARCHAR(20), 
	@DateFrom DATE

AS
BEGIN
	DECLARE @NextDate DATE
	SET @NextDate= DATEADD(DAY,7, CAST(@DateFrom AS DATE));
	SELECT * FROM [dbo].[DrivingLessons] 
	WHERE [ClientID] IN (
					SELECT [ClientID]  
					FROM [dbo].[Clients] 
					WHERE [ClientName] = @ClientName)
					AND CAST(LessonDateTime AS Date)
					    BETWEEN @DateFrom AND @NextDate;

	SET NOCOUNT ON;
	
END
GO
/****** Object:  StoredProcedure [dbo].[OneWeekLessionsbyInstructorFromDate]    Script Date: 11/23/2023 5:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dip Ranjon Das
-- Create date: 11/22/2023
-- Description:	Provide instructors name and findout details of all lessons 
-- =============================================
CREATE   PROCEDURE [dbo].[OneWeekLessionsbyInstructorFromDate] 

	@InstructorName VARCHAR(20), 
	@DateFrom DATE

AS
BEGIN
	DECLARE @NextDate DATE
	SET @NextDate= DATEADD(DAY,7, CAST(@DateFrom AS DATE));
	SELECT * FROM [dbo].[DrivingLessons] 
	WHERE [StaffID] IN (
						SELECT [StaffID] FROM [dbo].[Staffs] 
						WHERE [StaffName] = @InstructorName) 
					AND CAST(LessonDateTime AS Date)
					    BETWEEN @DateFrom AND @NextDate;
	SET NOCOUNT ON;
	
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[24] 2[13] 3) )"
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
         Begin Table = "Cars"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Faults"
            Begin Extent = 
               Top = 7
               Left = 809
               Bottom = 120
               Right = 979
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IdentifiedFault"
            Begin Extent = 
               Top = 36
               Left = 562
               Bottom = 166
               Right = 738
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inspection"
            Begin Extent = 
               Top = 14
               Left = 317
               Bottom = 127
               Right = 487
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
      Begin ColumnWidths = 9
         Width = 284
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
      E' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Car_Fault_History_Details'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'nd
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Car_Fault_History_Details'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Car_Fault_History_Details'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[28] 2[34] 3) )"
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
         Begin Table = "Clients"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "DrivingLessons"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 421
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
         Or = 1830
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Client_Lesson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Client_Lesson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Client_Lesson"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Staffs"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Lesson_Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Lesson_Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[17] 2[8] 3) )"
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
         Begin Table = "Office"
            Begin Extent = 
               Top = 24
               Left = 50
               Bottom = 160
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Staffs"
            Begin Extent = 
               Top = 18
               Left = 475
               Bottom = 190
               Right = 658
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
      Begin ColumnWidths = 9
         Width = 284
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Office_Managers_Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Office_Managers_Birthday'
GO
USE [master]
GO
ALTER DATABASE [EasyDriveSchool ] SET  READ_WRITE 
GO
