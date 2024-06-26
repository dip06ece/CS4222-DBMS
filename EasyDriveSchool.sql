USE [master]
GO
/****** Object:  Database [EasyDriveSchool ]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[Total_Lessons_Attended]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[Total_Lessons_Attended_Before]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Clients]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[DrivingLessons]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  View [dbo].[Client_Lesson]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Staffs]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  View [dbo].[Lesson_Info]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[IdentifiedFault]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Faults]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Inspection]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Cars]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  View [dbo].[Car_Fault_History_Details]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Office]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  View [dbo].[Office_Managers_Birthday]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[Client_Lessons_for_Client]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[BunchList]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[DrivingTest]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Interview]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[PermitValidation]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AllLessionsbyClient]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[AllLessionsbyInstructor]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Demo_Cursor_Determine_Fee_With_Case]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Demo_Cursor_Determine_Fee_With_ifelse]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[InstructorsClients]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[OneWeekLessionsbyClientFromDate]    Script Date: 11/23/2023 4:24:58 PM ******/
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
/****** Object:  StoredProcedure [dbo].[OneWeekLessionsbyInstructorFromDate]    Script Date: 11/23/2023 4:24:58 PM ******/
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
