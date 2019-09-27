
USE master
GO
DROP DATABASE SQLOS_SCHEDULING
GO
CREATE DATABASE SQLOS_SCHEDULING
GO
USE SQLOS_SCHEDULING
GO
CREATE TABLE tEmployee(intRoll int, strName varchar(50))
GO
SET NOCOUNT ON
INSERT INTO tEmployee VALUES(1001,'AAAA')
GO 1000
-- Get  SPID of this session. To be used later.
SELECT @@SPID
-- Run below *poor* query (parallelism is forced with 8649 traceflag).
SELECT * FROM tEmployee A 
CROSS JOIN tEmployee B  
OPTION (RECOMPILE, QUERYTRACEON 8649)
GO 100 