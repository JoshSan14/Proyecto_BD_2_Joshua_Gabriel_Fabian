USE [Home_Credit_Default_Risk]
GO

-- Indexes
-- Indexes for Query 1
CREATE INDEX IX_InstallmentPayment_Client_PrevApp ON repayment.installment_payment (id_client, id_previous_application);
GO

CREATE INDEX IX_Bureau_Client_CreditActive ON credit.bureau (id_client, credit_active);
GO

CREATE INDEX IX_BureauBalance_Bureau_MonthsBalance ON credit.bureau_balance (id_bureau, months_balance);
GO

-- Indexes for Query 2
CREATE INDEX IX_Client_DaysBirth ON client.client (id_client, days_birth);
GO

-- Indexes for Query 4
CREATE INDEX IX_PrevApp_Client_Contract ON client.previous_application (id_client, contract_status, contract_type);
GO

CREATE INDEX IX_Client_Gender ON client.client (gender, id_client);
GO

-- Indexes for Query 5
CREATE INDEX IX_PosCashBalance_Client_Installment ON credit.pos_cash_balance (id_client, cnt_installment);
GO

-- Index for Query 3
CREATE INDEX IX_Client_OccupationType ON client.client (id_client, occupation_type);
GO

-- SARGABLE queries
-- Purpose: Retrieve installment payment details with bureau and bureau balance info
-- Functionality: Fetches installment payments for active credit in the bureau with specific months balance
SELECT	ip.id_installment_payment, ip.id_client,  ip.id_previous_application, 
		ip.amt_installment, ip.amt_payment, b.id_bureau, b.credit_active, 
		bb.id_bureau_balance, bb.months_balance
FROM repayment.installment_payment ip
JOIN credit.bureau b ON ip.id_client = b.id_client
JOIN credit.bureau_balance bb ON b.id_bureau = bb.id_bureau
WHERE b.credit_active = 1 AND bb.months_balance < -5;
GO

-- Purpose: Fetch installment payment data with client details and specific bureau balance status
-- Functionality: Retrieves installment payments with client birth date and bureau balance status
SELECT  ip.id_installment_payment, c.id_client, c.days_birth, ip.id_previous_application, 
		ip.amt_installment, ip.amt_payment, b.id_bureau, bb.id_bureau_balance, bb.status 
FROM repayment.installment_payment ip
JOIN credit.bureau b ON ip.id_client = b.id_client
JOIN credit.bureau_balance bb ON b.id_bureau = bb.id_bureau
JOIN client.client c ON ip.id_client = c.id_client
WHERE c.days_birth < -10962 AND bb.status = 'C';
GO

-- Purpose: Retrieve client, previous application, credit card, and pos cash balance details
-- Functionality: Gathers client, previous app, credit card, and pos cash data based on specific conditions
SELECT	c.id_client, c.occupation_type, pa.id_previous_application,
		pa.contract_status, pa.contract_type, cc.id_credit_card_balance, 
		cc.amt_balance, pc.id_pos_cash, pc.cnt_installment
FROM client.client c
JOIN client.previous_application pa ON c.id_client = pa.id_client
JOIN credit.credit_card_balance cc ON c.id_client = cc.id_client
JOIN credit.pos_cash_balance pc ON c.id_client = pc.id_client
WHERE c.occupation_type = 'Laborers'
  AND pa.contract_type = 'Consumer loans'
  AND cc.amt_balance > 50000
  AND pc.cnt_installment > 15;
GO

SELECT * FROM client.previous_application;
SELECT * FROM credit.credit_card_balance;
SELECT * FROM credit.pos_cash_balance;
SELECT * FROM repayment.installment_payment;

-- Purpose: Retrieve installment payments for specific gender, bureau balance status, and pos cash installment count
-- Functionality: Gathers installment payments with specific conditions on gender, bureau balance status, and pos cash installment count
SELECT c.id_client, c.gender, ip.id_installment_payment, ip.amt_installment,
       bb.id_bureau_balance, bb.status, pc.id_pos_cash, pc.cnt_installment
FROM client.client c
JOIN repayment.installment_payment ip ON c.id_client = ip.id_client
JOIN credit.bureau b ON c.id_client = b.id_client
JOIN credit.bureau_balance bb ON b.id_bureau = bb.id_bureau
JOIN credit.pos_cash_balance pc ON c.id_client = pc.id_client
WHERE c.gender = 'F'
  AND bb.status = 'C'
  AND pc.cnt_installment > 25
  AND ip.amt_installment < 25000;
GO

-- Purpose: Gather client and installment payment details based on specific contract and bureau balance status
-- Functionality: Retrieves client and installment payment data based on contract, bureau balance status, and installment payment amount
SELECT c.id_client, pa.contract_status, pa.contract_type, ip.id_installment_payment,
       ip.amt_installment, ip.amt_payment, bb.id_bureau_balance, bb.status
FROM client.client c
JOIN client.previous_application pa ON c.id_client = pa.id_client
JOIN repayment.installment_payment ip ON c.id_client = ip.id_client
JOIN credit.bureau b ON c.id_client = b.id_client
JOIN credit.bureau_balance bb ON b.id_bureau = bb.id_bureau
WHERE pa.contract_status = 'Approved'
  AND pa.contract_type = 'Cash loans'
  AND bb.status = 'X'
  AND ip.amt_payment > 5000;
