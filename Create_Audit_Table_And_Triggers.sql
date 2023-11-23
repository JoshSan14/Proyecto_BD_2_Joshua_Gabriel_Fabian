USE [Home_Credit_Default_Risk]
GO

-- Create the audit schema
CREATE SCHEMA audit;
GO

-- Create the audit table
CREATE TABLE audit.auditLog (
    AuditLogID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(128),
    ActionPerformed NVARCHAR(100),
    DateTimePerformed DATETIME,
    UserID NVARCHAR(50)
);
GO

-- Triggers for INSERT
CREATE TRIGGER Trigger_Insert_Application_Audit
ON client.application
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.application', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Client_Audit
ON client.client
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.client', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Contact_Flags_Audit
ON client.contact_flags
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.contact_flags', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Document_Flags_Audit
ON client.document_flags
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.document_flags', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Heritage_Flags_Audit
ON client.heritage_flags
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.heritage_flags', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Previous_Application_Audit
ON client.previous_application
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.previous_application', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Bureau_Audit
ON credit.bureau
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.bureau', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Bureau_Balance_Audit
ON credit.bureau_balance
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.bureau_balance', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Credit_Card_Balance_Audit
ON credit.credit_card_balance
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.credit_card_balance', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_POS_CASH_Balance_Audit
ON credit.pos_cash_balance
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.pos_cash_balance', 'INSERT', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Insert_Installment_Payment_Audit
ON repayment.installment_payment
AFTER INSERT
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'repayment.installment_payment', 'INSERT', GETDATE(), USER_NAME();
END;
GO

-- Triggers for UPDATE
CREATE TRIGGER Trigger_Update_Application_Audit
ON client.application
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.application', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Client_Audit
ON client.client
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.client', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Contact_Flags_Audit
ON client.contact_flags
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.contact_flags', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Document_Flags_Audit
ON client.document_flags
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.document_flags', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Heritage_Flags_Audit
ON client.heritage_flags
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.heritage_flags', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Previous_Application_Audit
ON client.previous_application
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.previous_application', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Bureau_Audit
ON credit.bureau
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.bureau', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Bureau_Balance_Audit
ON credit.bureau_balance
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.bureau_balance', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Credit_Card_Balance_Audit
ON credit.credit_card_balance
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.credit_card_balance', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_POS_CASH_Balance_Audit
ON credit.pos_cash_balance
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.pos_cash_balance', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Update_Installment_Payment_Audit
ON repayment.installment_payment
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'repayment.installment_payment', 'UPDATE', GETDATE(), USER_NAME();
END;
GO

-- Triggers for DELETE
CREATE TRIGGER Trigger_Delete_Application_Audit
ON client.application
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.application', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Client_Audit
ON client.client
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.client', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Contact_Flags_Audit
ON client.contact_flags
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.contact_flags', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Document_Flags_Audit
ON client.document_flags
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.document_flags', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Heritage_Flags_Audit
ON client.heritage_flags
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.heritage_flags', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Previous_Application_Audit
ON client.previous_application
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'client.previous_application', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Bureau_Audit
ON credit.bureau
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.bureau', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Bureau_Balance_Audit
ON credit.bureau_balance
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.bureau_balance', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Credit_Card_Balance_Audit
ON credit.credit_card_balance
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.credit_card_balance', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_POS_CASH_Balance_Audit
ON credit.pos_cash_balance
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'credit.pos_cash_balance', 'DELETE', GETDATE(), USER_NAME();
END;
GO

CREATE TRIGGER Trigger_Delete_Installment_Payment_Audit
ON repayment.installment_payment
AFTER DELETE
AS
BEGIN
    INSERT INTO audit.auditLog (TableName, ActionPerformed, DateTimePerformed, UserID)
    SELECT 'repayment.installment_payment', 'DELETE', GETDATE(), USER_NAME();
END;
GO