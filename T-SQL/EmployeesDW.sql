/****** Object:  Database EmployeeDW    Script Date: 5/12/2024 12:13:29 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE EmployeeDW
GO
CREATE DATABASE EmployeeDW
GO
ALTER DATABASE EmployeeDW
SET RECOVERY SIMPLE
GO
*/
USE EmployeeDW
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA MDWT
GO






/* Drop table dbo.DimAudit */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimAudit') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimAudit 
;

/* Create table dbo.DimAudit */
CREATE TABLE dbo.DimAudit (
   [AuditKey]  int IDENTITY  NOT NULL
,  [ParentAuditKey]  int   NOT NULL
,  [TableName]  nvarchar(50)  DEFAULT 'Unknown' NOT NULL
,  [PkgName]  nvarchar(50)  DEFAULT 'Unknown' NOT NULL
,  [PkgGUID]  uniqueidentifier   NULL
,  [PkgVersionGUID]  uniqueidentifier   NULL
,  [PkgVersionMajor]  smallint   NULL
,  [PkgVersionMinor]  smallint   NULL
,  [ExecStartDT]  datetime  DEFAULT getdate() NOT NULL
,  [ExecStopDT]  datetime   NULL
,  [ExecutionInstanceGUID]  uniqueidentifier   NULL
,  [ExtractRowCnt]  bigint   NULL
,  [InsertRowCnt]  bigint   NULL
,  [UpdateRowCnt]  bigint   NULL
,  [ErrorRowCnt]  bigint   NULL
,  [TableInitialRowCnt]  bigint   NULL
,  [TableFinalRowCnt]  bigint   NULL
,  [TableMaxSurrogateKey]  bigint   NULL
,  [SuccessfulProcessingInd]  nchar(1)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_dbo.DimAudit] PRIMARY KEY CLUSTERED 
( [AuditKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Audit', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimAudit
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Audit', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimAudit
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Audit dimension tags each data row with the the process that added or updated it.', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimAudit
;

SET IDENTITY_INSERT dbo.DimAudit ON
;
INSERT INTO dbo.DimAudit (AuditKey, ParentAuditKey, TableName, PkgName, PkgGUID, PkgVersionGUID, PkgVersionMajor, PkgVersionMinor, ExecStartDT, ExecStopDT, ExecutionInstanceGUID, ExtractRowCnt, InsertRowCnt, UpdateRowCnt, ErrorRowCnt, TableInitialRowCnt, TableFinalRowCnt, TableMaxSurrogateKey, SuccessfulProcessingInd)
VALUES (-1, -1, 'Audit', 'None: Dummy row', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Y')
;
SET IDENTITY_INSERT dbo.DimAudit OFF
;

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'AuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ParentAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgGUID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgGUID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgVersionGUID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionGUID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgVersionMajor', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMajor'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PkgVersionMinor', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMinor'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExecStartDT', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStartDT'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExecStopDT', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStopDT'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExecutionInstanceGUID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecutionInstanceGUID'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ExtractRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExtractRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'InsertRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'UpdateRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ErrorRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ErrorRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableInitialRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableInitialRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableFinalRowCnt', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableFinalRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TableMaxSurrogateKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableMaxSurrogateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'SuccessfulProcessingInd', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'SuccessfulProcessingInd'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Foreign key to self, to identify calling package execution', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the main table loaded by this package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the SSIS package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier for the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgGUID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier for the package version', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionGUID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Major version number for the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMajor'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Minor version number for the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'PkgVersionMinor'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date-time the package started executing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStartDT'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date-time the package finished executing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecStopDT'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Identifier for the execution of the package', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExecutionInstanceGUID'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows extracted from the source(s)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ExtractRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows inserted in the destination table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'InsertRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows updated in the destination table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'UpdateRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of error rows', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ErrorRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows in target table before we begin', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableInitialRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Count of rows in target table after package ends', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableFinalRowCnt'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Maximum surrogate key value in table (if we''re maintaining ourselves)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'TableMaxSurrogateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Did the package finish executing successfully?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'SuccessfulProcessingInd'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'SuccessfulProcessingInd'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'AuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimAudit', @level2type=N'COLUMN', @level2name=N'ParentAuditKey'; 
;





/* Drop table dbo.FactPerformance */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactPerformance') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactPerformance 
;

/* Create table dbo.FactPerformance */
CREATE TABLE dbo.FactPerformance (
   [EnployeeKey]  int   NOT NULL
,  [DeptKey]  int   NOT NULL
,  [TitlesKey]  int   NOT NULL
,  [FromDate]  int   NOT NULL
,  [ToDate]  int   NOT NULL
,  [InsertAuditKey]  int   NOT NULL
,  [UpdateAuditKey]  int   NOT NULL
,  [BKFactTable]  int   NULL
,  [Rating]  int   NULL
,  [CurrentSalary]  int   NULL
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPerformance
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Performance Review', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPerformance
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Performance Review]'))
DROP VIEW [MDWT].[Performance Review]
GO
CREATE VIEW [MDWT].[Performance Review] AS 
SELECT [EnployeeKey] AS [Employee Key]
, [DeptKey] AS [DeptKey]
, [TitlesKey] AS [Title Key]
, [FromDate] AS [FromDate]
, [ToDate] AS [ToDate]
, [InsertAuditKey] AS [Insert Audit Key]
, [UpdateAuditKey] AS [Update Audit Key]
, [BKFactTable] AS [BK Fact Table]
, [Rating] AS [Rating]
, [CurrentSalary] AS [CurrentSalary]
FROM dbo.FactPerformance
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Employee Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'EnployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DeptKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Title Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'TitlesKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FromDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'FromDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ToDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'ToDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Insert Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Update Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BK Fact Table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'BKFactTable'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Rating', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CurrentSalary', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'CurrentSalary'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimEmployees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'EnployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDepartments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimeTitles', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'TitlesKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'FromDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'ToDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row insertion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row update', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The natural key for the fact table, if any (eg order number)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'BKFactTable'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Rating of employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'Rating'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Current salary of employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'CurrentSalary'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'EnployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'TitlesKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'EnployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'TitlesKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'BKFactTable'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPerformance', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
;





/* Drop table dbo.FactPromotions */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactPromotions') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactPromotions 
;

/* Create table dbo.FactPromotions */
CREATE TABLE dbo.FactPromotions (
   [EmployeeKey]  int   NOT NULL
,  [DeptKey]  int   NOT NULL
,  [TitleKey]  int   NOT NULL
,  [FromDate]  int   NOT NULL
,  [ToDate]  int   NOT NULL
,  [InsertAuditKey]  int   NOT NULL
,  [UpdateAuditKey]  int   NOT NULL
,  [BKFactTable]  int   NULL
,  [CurrentSalary]  int   NULL
,  [PreSalary]  int   NULL
,  [IncreaSalary]  int   NULL
,  [PercentIncrease]  float   NULL
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPromotions
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeePromotions', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=FactPromotions
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[EmployeePromotions]'))
DROP VIEW [MDWT].[EmployeePromotions]
GO
CREATE VIEW [MDWT].[EmployeePromotions] AS 
SELECT [EmployeeKey] AS [Employee Key]
, [DeptKey] AS [Department Key]
, [TitleKey] AS [TitleKey]
, [FromDate] AS [FromDate]
, [ToDate] AS [ToDate]
, [InsertAuditKey] AS [Insert Audit Key]
, [UpdateAuditKey] AS [Update Audit Key]
, [BKFactTable] AS [BK Fact Table]
, [CurrentSalary] AS [CurrentSalary]
, [PreSalary] AS [PreSalary]
, [IncreaSalary] AS [IncreaSalary]
, [PercentIncrease] AS [PercentIncrease]
FROM dbo.FactPromotions
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Employee Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Department Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'TitleKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FromDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'FromDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'ToDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'ToDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Insert Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Update Audit Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BK Fact Table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'BKFactTable'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'CurrentSalary', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'CurrentSalary'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PreSalary', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'PreSalary'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IncreaSalary', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'IncreaSalary'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'PercentIncrease', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'PercentIncrease'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimEmployees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDepartments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDepartments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'FromDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'ToDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row insertion', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to Audit dimension for row update', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The natural key for the fact table, if any (eg order number)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'BKFactTable'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Current salary of employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'CurrentSalary'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Current salary of employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'PreSalary'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always add a description!', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'IncreaSalary'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Always add a description!', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'PercentIncrease'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'BKFactTable'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard auditing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'FactPromotions', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
;





/* Drop table dbo.DimEmployees */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimEmployees') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimEmployees 
;

/* Create table dbo.DimEmployees */
CREATE TABLE dbo.DimEmployees (
   [EmployeeKey]  int IDENTITY  NOT NULL
,  [EmployeeNo]  int   NOT NULL
,  [BirthDate]  date   NOT NULL
,  [FirstName]  varchar(14)   NOT NULL
,  [LastName]  varchar(16)   NOT NULL
,  [Gender]  varchar(1)   NOT NULL
,  [HireDate]  date   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int   NOT NULL
,  [UpdateAuditKey]  int   NOT NULL
, CONSTRAINT [PK_dbo.DimEmployees] PRIMARY KEY CLUSTERED 
( [EmployeeKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployees
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Employees', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployees
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Employees dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimEmployees
;

SET IDENTITY_INSERT dbo.DimEmployees ON
;
INSERT INTO dbo.DimEmployees (EmployeeKey, EmployeeNo, BirthDate, FirstName, LastName, Gender, HireDate, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, -1, '', '', '', '', '', 'Y', '12/31/1899', '12/31/9999', 'N/A', -1, -1)
;
SET IDENTITY_INSERT dbo.DimEmployees OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Employees]'))
DROP VIEW [MDWT].[Employees]
GO
CREATE VIEW [MDWT].[Employees] AS 
SELECT [EmployeeKey] AS [EmployeeKey]
, [EmployeeNo] AS [EmployeeNo]
, [BirthDate] AS [BirthDate]
, [FirstName] AS [FirstName]
, [LastName] AS [LastName]
, [Gender] AS [Gender]
, [HireDate] AS [HireDate]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimEmployees
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'EmployeeNo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'BirthDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FirstName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'LastName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Gender', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'HireDate', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each employee in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID of each employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Birth date of each employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'First name of each employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Last name of each employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Gender of each employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Hired date of each emloyee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'10001', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2/21/2003', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Georgi', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Facello', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'M', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2/21/2003', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'employee', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'emp_no', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'birth_date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'first_name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'last_name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'gender', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'hire_date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'EmployeeNo'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'BirthDate'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'FirstName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'LastName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'Gender'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimEmployees', @level2type=N'COLUMN', @level2name=N'HireDate'; 
;





/* Drop table dbo.DimDepartments */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDepartments') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDepartments 
;

/* Create table dbo.DimDepartments */
CREATE TABLE dbo.DimDepartments (
   [DeptKey]  int IDENTITY  NOT NULL
,  [DeptNo]  char(4)   NOT NULL
,  [DeptName]  varchar(40)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int   NOT NULL
,  [UpdateAuditKey]  int   NOT NULL
, CONSTRAINT [PK_dbo.DimDepartments] PRIMARY KEY CLUSTERED 
( [DeptKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDepartments
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Departments', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDepartments
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Departments dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDepartments
;

SET IDENTITY_INSERT dbo.DimDepartments ON
;
INSERT INTO dbo.DimDepartments (DeptKey, DeptNo, DeptName, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, '-1', '', 'Y', '12/31/1899', '12/31/9999', 'N/A', -1, -1)
;
SET IDENTITY_INSERT dbo.DimDepartments OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Departments]'))
DROP VIEW [MDWT].[Departments]
GO
CREATE VIEW [MDWT].[Departments] AS 
SELECT [DeptKey] AS [Dept Key]
, [DeptNo] AS [Dept ID]
, [DeptName] AS [Dept Name]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimDepartments
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Dept Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Dept ID', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Dept Name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each department in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'ID of each department', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of department', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Marketing', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'departments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'departments', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'dept_no', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'dept_name', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'char(4)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptNo'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(40)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDepartments', @level2type=N'COLUMN', @level2name=N'DeptName'; 
;





/* Drop table dbo.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDate 
;

/* Create table dbo.DimDate */
CREATE TABLE dbo.DimDate (
   [DateKey]  int IDENTITY  NOT NULL
,  [Date]  date   NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  varchar(9)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nvarchar(9)   NOT NULL
,  [MonthOfYear]  smallint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsAWeekday]  varchar(10)   NOT NULL
,  [RowIsCurrent]  bit   NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
,  [InsertAuditKey]  int   NOT NULL
,  [UpdateAuditKey]  int   NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Time dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimDate
;

SET IDENTITY_INSERT dbo.DimDate ON
;
INSERT INTO dbo.DimDate (DateKey, Date, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, Year, IsAWeekday, RowIsCurrent, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, '4/30/1975', 0, 'Tommorrow', 0, -1, 0, 'Unknown', -1, 0, -1, '-1', -1, 'Y', -1, -1)
;
SET IDENTITY_INSERT dbo.DimDate OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Date]'))
DROP VIEW [MDWT].[Date]
GO
CREATE VIEW [MDWT].[Date] AS 
SELECT [DateKey] AS [Date Key]
, [Date] AS [Date]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [Year] AS [Year]
, [IsAWeekday] AS [IsAWeekday]
, [RowIsCurrent] AS [Row Is Current]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimDate
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Year', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'IsAWeekday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each date in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'DayOfWeek', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'DayName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'DayOfMonth', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'DayOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'WeekOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'MonthName', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'MonthOfYear', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Quarter', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Year of order', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'IsAWeekday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'4/30/1975', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3...', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Sunday, Monday, ...', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3,4', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'June, July', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2,3', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1,2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2023', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Weekday', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Date'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DateKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfWeek'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfMonth'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'DayOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'WeekOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthName'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'MonthOfYear'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Quarter'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'Year'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'IsAWeekday'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimDate', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
;





/* Drop table dbo.DimTitles */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimTitles') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimTitles 
;

/* Create table dbo.DimTitles */
CREATE TABLE dbo.DimTitles (
   [TitleKey]  int IDENTITY  NOT NULL
,  [Title]  varchar(50)   NOT NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
,  [InsertAuditKey]  int   NOT NULL
,  [UpdateAuditKey]  int   NOT NULL
, CONSTRAINT [PK_dbo.DimTitles] PRIMARY KEY CLUSTERED 
( [TitleKey] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimTitles
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Titles', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimTitles
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Titles dimension', @level0type=N'SCHEMA', @level0name=dbo, @level1type=N'TABLE', @level1name=DimTitles
;

SET IDENTITY_INSERT dbo.DimTitles ON
;
INSERT INTO dbo.DimTitles (TitleKey, Title, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason, InsertAuditKey, UpdateAuditKey)
VALUES (-1, '', 'Y', '12/31/1899', '12/31/9999', 'N/A', -1, -1)
;
SET IDENTITY_INSERT dbo.DimTitles OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[MDWT].[Titles]'))
DROP VIEW [MDWT].[Titles]
GO
CREATE VIEW [MDWT].[Titles] AS 
SELECT [TitleKey] AS [Blank Dim Key]
, [Title] AS [Title]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
, [InsertAuditKey] AS [InsertAuditKey]
, [UpdateAuditKey] AS [UpdateAuditKey]
FROM dbo.DimTitles
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Blank Dim Key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Title', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'InsertAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'UpdateAuditKey', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'A unique identifier for each title in the table', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Title', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process loaded this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Description', @value=N'What process most recently updated this row?', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Engineer', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Y, N', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/2011', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard Audit dim', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'TitleKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Employees', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'InsertAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'UpdateAuditKey'; 
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'titles', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar(50)', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'Title'; 
;
ALTER TABLE dbo.DimAudit ADD CONSTRAINT
   FK_dbo_DimAudit_ParentAuditKey FOREIGN KEY
   (
   ParentAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_EnployeeKey FOREIGN KEY
   (
   EnployeeKey
   ) REFERENCES DimEmployees
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_DeptKey FOREIGN KEY
   (
   DeptKey
   ) REFERENCES DimDepartments
   ( DeptKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_TitlesKey FOREIGN KEY
   (
   TitlesKey
   ) REFERENCES DimTitles
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_FromDate FOREIGN KEY
   (
   FromDate
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_ToDate FOREIGN KEY
   (
   ToDate
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPerformance ADD CONSTRAINT
   FK_dbo_FactPerformance_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_EmployeeKey FOREIGN KEY
   (
   EmployeeKey
   ) REFERENCES DimEmployees
   ( EmployeeKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_DeptKey FOREIGN KEY
   (
   DeptKey
   ) REFERENCES DimDepartments
   ( DeptKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES DimTitles
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_FromDate FOREIGN KEY
   (
   FromDate
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_ToDate FOREIGN KEY
   (
   ToDate
   ) REFERENCES DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactPromotions ADD CONSTRAINT
   FK_dbo_FactPromotions_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimEmployees ADD CONSTRAINT
   FK_dbo_DimEmployees_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimEmployees ADD CONSTRAINT
   FK_dbo_DimEmployees_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimDepartments ADD CONSTRAINT
   FK_dbo_DimDepartments_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimDepartments ADD CONSTRAINT
   FK_dbo_DimDepartments_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimDate ADD CONSTRAINT
   FK_dbo_DimDate_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimDate ADD CONSTRAINT
   FK_dbo_DimDate_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimTitles ADD CONSTRAINT
   FK_dbo_DimTitles_InsertAuditKey FOREIGN KEY
   (
   InsertAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.DimTitles ADD CONSTRAINT
   FK_dbo_DimTitles_UpdateAuditKey FOREIGN KEY
   (
   UpdateAuditKey
   ) REFERENCES DimAudit
   ( AuditKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
