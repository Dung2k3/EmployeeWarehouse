USE [master]
GO
/****** Object:  Database [Employees]    Script Date: 5/16/2024 11:58:13 PM ******/
CREATE DATABASE [Employees]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Employees', FILENAME = N'/var/opt/mssql/data/Employees.mdf' , SIZE = 270336KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Employees_log', FILENAME = N'/var/opt/mssql/data/Employees_log.ldf' , SIZE = 2891776KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Employees] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Employees].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Employees] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Employees] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Employees] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Employees] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Employees] SET ARITHABORT OFF 
GO
ALTER DATABASE [Employees] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Employees] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Employees] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Employees] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Employees] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Employees] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Employees] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Employees] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Employees] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Employees] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Employees] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Employees] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Employees] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Employees] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Employees] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Employees] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Employees] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Employees] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Employees] SET  MULTI_USER 
GO
ALTER DATABASE [Employees] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Employees] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Employees] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Employees] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Employees] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Employees', N'ON'
GO
ALTER DATABASE [Employees] SET QUERY_STORE = OFF
GO
USE [Employees]
GO
/****** Object:  Table [dbo].[departments]    Script Date: 5/16/2024 11:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departments](
	[dept_no] [char](4) NOT NULL,
	[dept_name] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_departments] PRIMARY KEY CLUSTERED 
(
	[dept_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dept_emp]    Script Date: 5/16/2024 11:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dept_emp](
	[emp_no] [int] NOT NULL,
	[dept_no] [char](4) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dept_manager]    Script Date: 5/16/2024 11:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dept_manager](
	[emp_no] [int] NOT NULL,
	[dept_no] [char](4) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 5/16/2024 11:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[emp_no] [int] NOT NULL,
	[birth_date] [date] NOT NULL,
	[first_name] [varchar](14) NOT NULL,
	[last_name] [varchar](16) NOT NULL,
	[gender] [char](1) NOT NULL,
	[hire_date] [date] NOT NULL,
 CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salaries]    Script Date: 5/16/2024 11:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salaries](
	[emp_no] [int] NOT NULL,
	[salary] [int] NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
	[rating] [int] NULL,
	[performance_review] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[titles]    Script Date: 5/16/2024 11:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[titles](
	[emp_no] [int] NOT NULL,
	[title] [varchar](50) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [Employees] SET  READ_WRITE 
GO
