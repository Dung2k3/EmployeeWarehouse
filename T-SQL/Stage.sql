USE [master]
GO
/****** Object:  Database [EmployeesStage]    Script Date: 5/17/2024 12:01:02 AM ******/
CREATE DATABASE [EmployeesStage]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeesStage', FILENAME = N'/var/opt/mssql/data/EmployeesStage.mdf' , SIZE = 401408KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EmployeesStage_log', FILENAME = N'/var/opt/mssql/data/EmployeesStage_log.ldf' , SIZE = 532480KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [EmployeesStage] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeesStage].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeesStage] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeesStage] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeesStage] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeesStage] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeesStage] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeesStage] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeesStage] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeesStage] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeesStage] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeesStage] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeesStage] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeesStage] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeesStage] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeesStage] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeesStage] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeesStage] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeesStage] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeesStage] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeesStage] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeesStage] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeesStage] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeesStage] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeesStage] SET RECOVERY FULL 
GO
ALTER DATABASE [EmployeesStage] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeesStage] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeesStage] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeesStage] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeesStage] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EmployeesStage] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmployeesStage', N'ON'
GO
ALTER DATABASE [EmployeesStage] SET QUERY_STORE = OFF
GO
USE [EmployeesStage]
GO
/****** Object:  Table [dbo].[FactPer]    Script Date: 5/17/2024 12:01:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactPer](
	[emp_no] [int] NULL,
	[dept_no] [char](4) NULL,
	[title] [varchar](50) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[rating ] [int] NULL,
	[salary] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgDate]    Script Date: 5/17/2024 12:01:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgDate](
	[date_key] [int] NULL,
	[full_date] [date] NULL,
	[day_of_week] [tinyint] NULL,
	[day_num_in_month] [tinyint] NULL,
	[day_num_overall] [smallint] NULL,
	[day_name] [varchar](9) NULL,
	[day_abbrev] [varchar](3) NULL,
	[weekday_flag] [varchar](10) NULL,
	[week_num_in_year] [tinyint] NULL,
	[week_num_overall] [smallint] NULL,
	[week_begin_date] [date] NULL,
	[week_begin_date_key] [int] NULL,
	[month] [tinyint] NULL,
	[month_num_overall] [smallint] NULL,
	[month_name] [varchar](9) NULL,
	[month_abbrev] [varchar](3) NULL,
	[quarter] [tinyint] NULL,
	[year] [smallint] NULL,
	[yearmo] [int] NULL,
	[fiscal_month] [tinyint] NULL,
	[fiscal_quarter] [tinyint] NULL,
	[fiscal_year] [smallint] NULL,
	[last_day_in_month_flag] [varchar](64) NULL,
	[same_day_year_ago_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgDep]    Script Date: 5/17/2024 12:01:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgDep](
	[dept_no] [char](4) NOT NULL,
	[dept_name] [nvarchar](40) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgEmployee]    Script Date: 5/17/2024 12:01:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgEmployee](
	[emp_no] [int] NULL,
	[birth_date] [date] NULL,
	[first_name] [varchar](14) NULL,
	[last_name] [varchar](16) NULL,
	[gender] [varchar](1) NULL,
	[hire_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgFactPromotion]    Script Date: 5/17/2024 12:01:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgFactPromotion](
	[title] [varchar](50) NULL,
	[emp_no] [int] NULL,
	[from_date] [date] NULL,
	[to_date] [date] NULL,
	[dept_no] [varchar](4) NULL,
	[pre_salary] [int] NULL,
	[cur_salary] [int] NULL,
	[increa_salary] [int] NULL,
	[persent_salary] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stgTitles]    Script Date: 5/17/2024 12:01:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgTitles](
	[title_no] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stgDep' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'stgDep'
GO
USE [master]
GO
ALTER DATABASE [EmployeesStage] SET  READ_WRITE 
GO
