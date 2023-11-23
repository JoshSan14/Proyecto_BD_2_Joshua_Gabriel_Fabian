USE Home_Credit_Default_Risk;
GO

-- Create the procedure to insert data into the client table
CREATE PROCEDURE Insert_Client
    @id_client INT,
    @gender CHAR(1),
    @days_birth INT,
    @education_type VARCHAR(30),
    @family_stat VARCHAR(25),
    @income_type VARCHAR(20),
    @occupation_type VARCHAR(30),
    @cnt_children TINYINT,
    @cnt_family_members TINYINT,
    @days_employed INT
AS
BEGIN
    INSERT INTO client.client (id_client, gender, days_birth, education_type, family_stat, income_type, occupation_type, cnt_children, cnt_family_members, days_employed)
    VALUES (@id_client, @gender, @days_birth, @education_type, @family_stat, @income_type, @occupation_type, @cnt_children, @cnt_family_members, @days_employed);
END;
GO

-- Create the trigger to check gender after data is inserted
CREATE TRIGGER Trigger_Insert_Client
ON client.client
AFTER INSERT
AS
BEGIN
    DECLARE @gender CHAR(1);
    SELECT @gender = gender FROM inserted;
    
    IF @gender NOT IN ('F', 'M', ' ')
    BEGIN
        ROLLBACK;
    END;
END;
GO

-- Create the procedure to insert data into the contact_flags table
CREATE PROCEDURE Insert_Contact_Flags
    @id_client INT,
    @mobile BIT,
    @emp_phone BIT,
    @work_phone BIT,
    @cont_mobile BIT,
    @phone BIT,
    @email BIT
AS
BEGIN
    INSERT INTO client.contact_flags (id_client, mobile, emp_phone, work_phone, cont_mobile, phone, email)
    VALUES (@id_client, @mobile, @emp_phone, @work_phone, @cont_mobile, @phone, @email);
END;
GO

-- Create the trigger to check if all boolean values are either 0 or 1 after data is inserted
CREATE TRIGGER Trigger_Check_Contact_Flags
ON client.contact_flags
AFTER INSERT
AS
BEGIN 
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE 
            mobile NOT IN (0, 1) OR
            emp_phone NOT IN (0, 1) OR
            work_phone NOT IN (0, 1) OR
            cont_mobile NOT IN (0, 1) OR
            phone NOT IN (0, 1) OR
            email NOT IN (0, 1)
    )
    BEGIN
        ROLLBACK;
    END;
END;
GO

-- Create the procedure to insert data into the heritage_flags table
CREATE PROCEDURE Insert_Heritage_Flags
    @id_client INT,
    @own_realty BIT,
    @own_car BIT
AS
BEGIN
    INSERT INTO client.heritage_flags (id_client, own_realty, own_car)
    VALUES (@id_client, @own_realty, @own_car);
END;
GO

-- Create the trigger to check if all bits are either 0 or 1 after data is inserted
CREATE TRIGGER Trigger_Check_Heritage_Flags
ON client.heritage_flags
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE 
            own_realty NOT IN (0, 1) OR
            own_car NOT IN (0, 1)
    )
    BEGIN
        ROLLBACK;
    END;
END;
GO

-- Create the procedure to insert data into the document_flags table
CREATE PROCEDURE Insert_Document_Flags
    @id_client INT,
    @document_2 BIT,
    @document_3 BIT,
    @document_4 BIT,
    @document_5 BIT,
    @document_6 BIT,
    @document_7 BIT,
    @document_8 BIT,
    @document_9 BIT,
    @document_10 BIT,
    @document_11 BIT,
    @document_12 BIT
AS
BEGIN
    INSERT INTO client.document_flags (
        id_client,
        document_2, document_3, document_4,
        document_5, document_6, document_7,
        document_8, document_9, document_10,
        document_11, document_12
    )
    VALUES (
        @id_client,
        @document_2, @document_3, @document_4,
        @document_5, @document_6, @document_7,
        @document_8, @document_9, @document_10,
        @document_11, @document_12
    );
END;
GO

-- Create the trigger to check if all bits are either 0 or 1 after data is inserted
CREATE TRIGGER Trigger_Check_Document_Flags
ON client.document_flags
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE 
            document_2 NOT IN (0, 1) OR
            document_3 NOT IN (0, 1) OR
            document_4 NOT IN (0, 1) OR
            document_5 NOT IN (0, 1) OR
            document_6 NOT IN (0, 1) OR
            document_7 NOT IN (0, 1) OR
            document_8 NOT IN (0, 1) OR
            document_9 NOT IN (0, 1) OR
            document_10 NOT IN (0, 1) OR
            document_11 NOT IN (0, 1) OR
            document_12 NOT IN (0, 1)
    )
    BEGIN
        ROLLBACK;
    END;
END;
GO

-- Create the procedure to insert data into the application table
CREATE PROCEDURE Insert_Application
    @id_client INT,
    @contract_type VARCHAR(20),
    @target BIT,
    @amt_income_total INT,
    @amt_anuity INT,
    @amt_goods_price INT,
    @amt_credit INT
AS
BEGIN
    INSERT INTO client.application (
        id_client, contract_type, target,
        amt_income_total, amt_anuity, amt_goods_price, amt_credit
    )
    VALUES (
        @id_client, @contract_type, @target,
        @amt_income_total, @amt_anuity, @amt_goods_price, @amt_credit
    );
END;
GO

-- Create the trigger to check if the target value is either 0 or 1 after data is inserted
CREATE TRIGGER Trigger_Check_Application_Target
ON client.application
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE target NOT IN (0, 1)
    )
    BEGIN
        ROLLBACK;
    END;
END;
GO

-- Create the procedure to insert data into the previous_application table
CREATE PROCEDURE Insert_Previous_Application
    @id_previous_application INT,
    @id_client INT,
    @contract_type VARCHAR(20),
    @amt_annuity INT,
    @amt_application INT,
    @amt_credit INT,
    @amt_down_payment INT,
    @amt_goods_price INT,
    @contract_status VARCHAR(15),
    @days_decision SMALLINT,
    @product_type VARCHAR(10),
    @channel_type VARCHAR(30),
    @payment_type VARCHAR(50),
    @client_type VARCHAR(10)
AS
BEGIN
    INSERT INTO client.previous_application (
        id_previous_application, id_client, contract_type, amt_annuity,
        amt_application, amt_credit, amt_down_payment, amt_goods_price,
        contract_status, days_decision, product_type, channel_type,
        payment_type, client_type
    )
    VALUES (
        @id_previous_application, @id_client, @contract_type, @amt_annuity,
        @amt_application, @amt_credit, @amt_down_payment, @amt_goods_price,
        @contract_status, @days_decision, @product_type, @channel_type,
        @payment_type, @client_type
    );
END;
GO

-- Create the procedure to insert data into the credit_card_balance table
CREATE PROCEDURE Insert_Credit_Card_Balance
    @id_client INT,
	@id_previous_application INT,
    @months_balance SMALLINT,
    @amt_balance INT,
    @amt_credit_limit_actual INT,
    @amt_drawings_current INT,
    @amt_payment_current INT,
    @amt_receivable INT,
    @cnt_drawings_current SMALLINT,
    @contract_status VARCHAR(15)
AS
BEGIN
    INSERT INTO credit.credit_card_balance (
        id_client, id_previous_application, months_balance, amt_balance,
        amt_credit_limit_actual, amt_drawings_current, amt_payment_current,
        amt_recivable, cnt_drawings_current, contract_status
    )
    VALUES (
        @id_client, @id_previous_application, @months_balance, @amt_balance,
        @amt_credit_limit_actual, @amt_drawings_current, @amt_payment_current,
        @amt_receivable, @cnt_drawings_current, @contract_status
    );
END;
GO

-- Create the procedure to insert data into the pos_cash_balance table
CREATE PROCEDURE Insert_Pos_Cash_Balance
    @id_client INT,
	@id_previous_application INT,
    @months_balance SMALLINT,
    @cnt_installment SMALLINT,
    @cnt_installment_future SMALLINT,
    @contract_status VARCHAR(30)
AS
BEGIN
    INSERT INTO credit.pos_cash_balance (
        id_client, id_previous_application, months_balance,
        cnt_installment, cnt_installment_future, contract_status
    )
    VALUES (
        @id_client, @id_previous_application, @months_balance,
        @cnt_installment, @cnt_installment_future, @contract_status
    );
END;
GO

-- Create the procedure to insert data into the bureau table
CREATE PROCEDURE Insert_Bureau
    @id_bureau INT,
    @id_client INT,
    @credit_active BIT,
    @days_credit INT,
    @credit_day_overdue INT,
    @days_credit_enddate INT,
    @amt_credit_sum INT,
    @credit_type VARCHAR(50),
    @days_credit_update INT
AS
BEGIN
    INSERT INTO credit.bureau (
        id_bureau, id_client, credit_active, days_credit,
        credit_day_overdue, days_credit_enddate, amt_credit_sum,
        credit_type, days_credit_update
    )
    VALUES (
        @id_bureau, @id_client, @credit_active, @days_credit,
        @credit_day_overdue, @days_credit_enddate, @amt_credit_sum,
        @credit_type, @days_credit_update
    );
END;
GO

-- Create the trigger to check if the credit_active bit is either 0 or 1 after data is inserted
CREATE TRIGGER Trigger_Check_Bureau_Credit_Active
ON credit.bureau
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE credit_active NOT IN (0, 1)
    )
    BEGIN
        ROLLBACK;
    END;
END;
GO

-- Create the procedure to insert data into the bureau_balance table
CREATE PROCEDURE Insert_Bureau_Balance
    @id_bureau INT,
    @months_balance SMALLINT,
    @status CHAR(1)
AS
BEGIN
    INSERT INTO credit.bureau_balance (
        id_bureau, months_balance, status
    )
    VALUES (
        @id_bureau, @months_balance, @status
    );
END;
GO

-- Create the procedure to insert data into the installment_payment table
CREATE PROCEDURE Insert_Installment_Payment
    @id_client INT,
	@id_previous_application INT,
    @installment_version TINYINT,
    @installment_number TINYINT,
    @days_installment SMALLINT,
    @days_entry_payment SMALLINT,
    @amt_installment INT,
    @amt_payment INT
AS
BEGIN
    INSERT INTO repayment.installment_payment (
        id_client, id_previous_application, installment_version,
        installment_number, days_installment, days_entry_payment,
        amt_installment, amt_payment
    )
    VALUES (
        @id_client, @id_previous_application, @installment_version,
        @installment_number, @days_installment, @days_entry_payment,
        @amt_installment, @amt_payment
    );
END;
GO