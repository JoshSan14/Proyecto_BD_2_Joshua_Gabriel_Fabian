-- Create an administrator user
USE [master];
GO

CREATE LOGIN AdminUser WITH PASSWORD = '8095b76e4b6d46f529d65c8e75936c8d3bd689189b68cca59826783031b64f79';
GO

USE [Home_Credit_Default_Risk];
GO

CREATE USER AdminUser FOR LOGIN AdminUser;
GO

ALTER ROLE db_owner ADD MEMBER AdminUser;
GO

-- Create an normal user with access to selects and functions
USE [master];
GO

CREATE LOGIN NormalUser WITH PASSWORD = '8f14f91f90c9aad6e5001a6a89556bb69764a014d3136067225dd36c667d11c7';
GO

USE [Home_Credit_Default_Risk];
GO

CREATE USER NormalUser FOR LOGIN NormalUser;
GO

GRANT SELECT ON SCHEMA :: client TO NormalUser;
GRANT SELECT ON SCHEMA :: credit TO NormalUser;
GRANT SELECT ON SCHEMA :: repayment TO NormalUser;
GRANT EXECUTE ON Insert_Client TO NormalUser;
GRANT EXECUTE ON Insert_Contact_Flags TO NormalUser;
GRANT EXECUTE ON Insert_Heritage_Flags TO NormalUser;
GRANT EXECUTE ON Insert_Document_Flags TO NormalUser;
GRANT EXECUTE ON Insert_Application TO NormalUser;
GRANT EXECUTE ON Insert_Previous_Application TO NormalUser;
GRANT EXECUTE ON Insert_Credit_Card_Balance TO NormalUser;
GRANT EXECUTE ON Insert_Pos_Cash_Balance TO NormalUser;
GRANT EXECUTE ON Insert_Bureau TO NormalUser;
GRANT EXECUTE ON Insert_Bureau_Balance TO NormalUser;
GRANT EXECUTE ON Insert_Installment_Payment TO NormalUser;
GO

-- Create a backup user with backup permission
USE [master];
GO

CREATE LOGIN BackupUser WITH PASSWORD = '213f17d9ca7adb0064a25cff65cb60a3e2def3492e0dda6f1a17bb573bcc17ea';
GO

USE [Home_Credit_Default_Risk];
GO

CREATE USER BackupUser FOR LOGIN BackupUser;
GO

GRANT BACKUP DATABASE TO BackupUser;
GO
