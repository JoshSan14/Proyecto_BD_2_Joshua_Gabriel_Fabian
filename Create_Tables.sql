-- Create the database
CREATE DATABASE Home_Credit_Default_Risk;
GO

USE Home_Credit_Default_Risk;
GO

-- Create the client schema
CREATE SCHEMA client;
GO

-- Create the credit schema
CREATE SCHEMA credit;
GO

-- Create the repayment schema
CREATE SCHEMA repayment;
GO

-- Create the client table in the client schema
CREATE TABLE client.client (
    id_client INT PRIMARY KEY,
    gender CHAR(1),
    days_birth INT,
    education_type VARCHAR(30),
    family_stat VARCHAR(25),
    income_type VARCHAR(20),
    occupation_type VARCHAR(30),
    cnt_children TINYINT,
    cnt_family_members TINYINT,
    days_employed INT
);
GO

-- Create the contact_flags table in the client schema
CREATE TABLE client.contact_flags (
    id_client INT PRIMARY KEY,
    mobile BIT,
    emp_phone BIT,
    work_phone BIT,
    cont_mobile BIT,
    phone BIT,
    email BIT,
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the heritage_flags table in the client schema
CREATE TABLE client.heritage_flags (
    id_client INT PRIMARY KEY,
    own_realty BIT,
    own_car BIT,
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the document_flags table in the client schema
CREATE TABLE client.document_flags (
    id_client INT PRIMARY KEY,
    document_2 BIT,
    document_3 BIT,
    document_4 BIT,
    document_5 BIT,
    document_6 BIT,
    document_7 BIT,
    document_8 BIT,
    document_9 BIT,
    document_10 BIT,
    document_11 BIT,
    document_12 BIT,
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the application table in the client schema
CREATE TABLE client.application (
    id_application INT PRIMARY KEY IDENTITY(1,1),
    id_client INT,
    contract_type VARCHAR(20),
    target BIT,
    amt_income_total INT,
    amt_anuity INT,
    amt_goods_price INT,
    amt_credit INT,
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the previous_application table in the client schema
CREATE TABLE client.previous_application (
    id_previous_application INT PRIMARY KEY,
    id_client INT,
    contract_type VARCHAR(20),
    amt_annuity INT,
    amt_application INT,
    amt_credit INT,
    amt_down_payment INT,
    amt_goods_price INT,
    contract_status VARCHAR(15),
    days_decision SMALLINT,
    product_type VARCHAR(10),
    channel_type VARCHAR(30),
    payment_type VARCHAR(50),
    client_type VARCHAR(10),
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the credit_card_balance table in the credit schema
CREATE TABLE credit.credit_card_balance (
    id_credit_card_balance INT PRIMARY KEY IDENTITY(1,1),
    id_client INT,
	id_previous_application INT,
    months_balance SMALLINT,
    amt_balance INT,
    amt_credit_limit_actual INT,
    amt_drawings_current INT,
    amt_payment_current INT,
    amt_recivable INT,
    cnt_drawings_current SMALLINT,
    contract_status VARCHAR(15),
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the pos_cash_balance table in the credit schema
CREATE TABLE credit.pos_cash_balance (
    id_pos_cash INT PRIMARY KEY IDENTITY(1,1),
    id_client INT,
	id_previous_application INT,
    months_balance SMALLINT,
    cnt_installment SMALLINT,
    cnt_installment_future SMALLINT,
    contract_status VARCHAR(30),
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the bureau table in the credit schema
CREATE TABLE credit.bureau (
    id_bureau INT PRIMARY KEY,
    id_client INT,
    credit_active BIT,
    days_credit INT,
    credit_day_overdue INT,
    days_credit_enddate INT,
    amt_credit_sum INT,
    credit_type VARCHAR(50),
    days_credit_update INT,
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);
GO

-- Create the bureau_balance table in the credit schema
CREATE TABLE credit.bureau_balance (
    id_bureau_balance INT PRIMARY KEY IDENTITY(1,1),
    id_bureau INT,
    months_balance SMALLINT,
    status CHAR(1),
    FOREIGN KEY (id_bureau) REFERENCES credit.bureau (id_bureau)
);
GO

-- Create the installment_payment table in the repayment schema
CREATE TABLE repayment.installment_payment (
	id_installment_payment INT PRIMARY KEY IDENTITY(1,1),
    id_client INT,
	id_previous_application INT,
    installment_version TINYINT,
    installment_number TINYINT,
    days_installment SMALLINT,
    days_entry_payment SMALLINT,
    amt_installment INT,
    amt_payment INT,
    FOREIGN KEY (id_client) REFERENCES client.client (id_client)
);