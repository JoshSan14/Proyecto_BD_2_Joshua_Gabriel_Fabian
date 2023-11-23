-- Create audit in the server
USE [master]
GO

CREATE SERVER AUDIT [Home_Credit_Default_Risk_Audit]
TO FILE 
(	
    FILEPATH = N'C:\HCDR_Audit'
    ,MAXSIZE = 50 MB
    ,MAX_ROLLOVER_FILES = 2147483647
    ,RESERVE_DISK_SPACE = OFF
)
WITH
(	
    QUEUE_DELAY = 1000
    ,ON_FAILURE = CONTINUE
)

GO

-- Enable server audit
ALTER SERVER AUDIT [Home_Credit_Default_Risk_Audit]
WITH (STATE = ON)

-- Create audit in DB
USE [Home_Credit_Default_Risk]
GO

CREATE DATABASE AUDIT SPECIFICATION [Home_Credit_Default_Risk_Audit_Specification]
FOR SERVER AUDIT [Home_Credit_Default_Risk_Audit]
ADD (SELECT ON DATABASE::[Home_Credit_Default_Risk] BY [public]),
ADD (INSERT ON DATABASE::[Home_Credit_Default_Risk] BY [public])
WITH (STATE = ON);
GO

USE [Home_Credit_Default_Risk]
GO

SELECT * FROM credit.bureau
SELECT * FROM credit.bureau_balance

SELECT *
FROM sys.fn_get_audit_file('C:\HCDR_Audit*', default, default)