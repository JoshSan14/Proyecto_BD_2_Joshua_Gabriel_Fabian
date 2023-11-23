import pandas as pd
import pyodbc
import logging

logging.basicConfig(level=logging.INFO)

class DataMigrator:
    def __init__(self, server, database, username, password):
        self.connection = None
        self.cursor = None
        self.server = server
        self.database = database
        self.username = username
        self.password = password

    def connect_to_sql_server(self):
        try:
            connection_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={self.server};DATABASE={self.database};UID={self.username};PWD={self.password}"
            self.connection = pyodbc.connect(connection_string)
            self.cursor = self.connection.cursor()
            logging.info("Connected to the SQL Server database!")
        except pyodbc.Error as e:
            logging.error("Unable to connect to the SQL Server database.")
            logging.error(e)
            self.close_connection()

    def close_connection(self):
        if self.connection:
            self.connection.close()
            logging.info("Connection closed.")

    def migrate_data(self, csv_path, *args):
        try:
            df = pd.read_csv(csv_path)
            for func, params in args:
                func(df, *params)
            self.connection.commit()
            logging.info(f"Data migration from {csv_path} completed successfully!")
        except Exception as e:
            self.connection.rollback()
            logging.error(f"Data migration from {csv_path} failed.")
            logging.error(e)

    def migrate_application_test_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_client = int(row['SK_ID_CURR'])
                target = 0
                contract_type = str(row['NAME_CONTRACT_TYPE'])
                gender = str(row['CODE_GENDER'])
                own_car = 1 if row['FLAG_OWN_CAR'] == 'Y' else 0
                own_realty = 1 if row['FLAG_OWN_REALTY'] == 'Y' else 0
                cnt_children = int(row['CNT_CHILDREN']) if pd.notna(row['CNT_CHILDREN']) else 0
                amt_income_total = int(row['AMT_INCOME_TOTAL']) if pd.notna(row['AMT_INCOME_TOTAL']) else 0
                amt_credit = int(row['AMT_CREDIT']) if pd.notna(row['AMT_CREDIT']) else 0
                amt_annuity = int(row['AMT_ANNUITY']) if pd.notna(row['AMT_ANNUITY']) else 0
                amt_goods_price = int(row['AMT_GOODS_PRICE']) if pd.notna(row['AMT_GOODS_PRICE']) else 0
                income_type = str(row['NAME_INCOME_TYPE'])
                education_type = str(row['NAME_EDUCATION_TYPE'])
                family_status = str(row['NAME_FAMILY_STATUS'])
                days_birth = int(row['DAYS_BIRTH']) if pd.notna(row['DAYS_BIRTH']) else 0
                days_employed = int(row['DAYS_EMPLOYED']) if pd.notna(row['DAYS_EMPLOYED']) else 0
                mobile = int(row['FLAG_MOBIL'])
                emp_phone = int(row['FLAG_EMP_PHONE'])
                work_phone = int(row['FLAG_WORK_PHONE'])
                cont_mobile = int(row['FLAG_CONT_MOBILE'])
                phone = int(row['FLAG_PHONE'])
                email = int(row['FLAG_EMAIL'])
                occupation_type = (
                    str(row['OCCUPATION_TYPE']) if pd.notna(row['OCCUPATION_TYPE']) and str(
                        row['OCCUPATION_TYPE']) != "nan"
                    else "")
                cnt_family_members = int(row['CNT_FAM_MEMBERS']) if pd.notna(row['CNT_FAM_MEMBERS']) else 0
                document_2 = int(row['FLAG_DOCUMENT_2'])
                document_3 = int(row['FLAG_DOCUMENT_3'])
                document_4 = int(row['FLAG_DOCUMENT_4'])
                document_5 = int(row['FLAG_DOCUMENT_5'])
                document_6 = int(row['FLAG_DOCUMENT_6'])
                document_7 = int(row['FLAG_DOCUMENT_7'])
                document_8 = int(row['FLAG_DOCUMENT_8'])
                document_9 = int(row['FLAG_DOCUMENT_9'])
                document_10 = int(row['FLAG_DOCUMENT_10'])
                document_11 = int(row['FLAG_DOCUMENT_11'])
                document_12 = int(row['FLAG_DOCUMENT_12'])

                # Execute stored procedures with the extracted values
                print("Inserting into client:", id_client, gender, days_birth, education_type, family_status,
                      income_type, occupation_type,
                      cnt_children, cnt_family_members, days_employed)
                # For Insert_Client
                self.cursor.execute("""
                                            INSERT INTO client.client
                                            (id_client, gender, days_birth, education_type, family_stat, income_type, occupation_type,
                                            cnt_children, cnt_family_members, days_employed)
                                            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                            """,
                                    id_client, gender, days_birth, education_type, family_status, income_type,
                                    occupation_type,
                                    cnt_children, cnt_family_members, days_employed)

                print("Inserting into contact flags:", id_client, mobile, emp_phone, work_phone, cont_mobile, phone,
                      email)
                # For Insert_Contact_Flags
                self.cursor.execute("""
                                            INSERT INTO client.contact_flags
                                            (id_client, mobile, emp_phone, work_phone, cont_mobile, phone, email)
                                            VALUES (?, ?, ?, ?, ?, ?, ?)
                                            """,
                                    id_client, mobile, emp_phone, work_phone, cont_mobile, phone, email)

                print("Inserting into heritage flags:", id_client, own_realty, own_car)
                # For Insert_Heritage_Flags
                self.cursor.execute("""
                                            INSERT INTO client.heritage_flags
                                            (id_client, own_realty, own_car)
                                            VALUES (?, ?, ?)
                                            """,
                                    id_client, own_realty, own_car)

                print("Inserting into document flags:", id_client, document_2, document_3, document_4, document_5,
                      document_6, document_7,
                      document_8, document_9, document_10, document_11, document_12)
                # For Insert_Document_Flags
                self.cursor.execute("""
                                            INSERT INTO client.document_flags
                                            (id_client, document_2, document_3, document_4, document_5, document_6, document_7,
                                            document_8, document_9, document_10, document_11, document_12)
                                            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                            """,
                                    id_client, document_2, document_3, document_4, document_5, document_6, document_7,
                                    document_8, document_9, document_10, document_11, document_12)

                print("Inserting into application:", id_client, contract_type, target, amt_income_total, amt_annuity,
                      amt_goods_price,
                      amt_credit)
                # For Insert_Application
                self.cursor.execute("""
                                            INSERT INTO client.application
                                            (id_client, contract_type, target, amt_income_total, amt_anuity, amt_goods_price, amt_credit)
                                            VALUES (?, ?, ?, ?, ?, ?, ?)
                                            """,
                                    id_client, contract_type, target, amt_income_total, amt_annuity, amt_goods_price,
                                    amt_credit)

            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from application_test.csv completed successfully!")

    def migrate_application_train_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_client = int(row['SK_ID_CURR'])
                target = int(row['TARGET'])
                contract_type = str(row['NAME_CONTRACT_TYPE'])
                gender = str(row['CODE_GENDER']) if str(row['CODE_GENDER']) == 'F' or str(row['CODE_GENDER']) == 'M' else ' '
                own_car = 1 if row['FLAG_OWN_CAR'] == 'Y' else 0
                own_realty = 1 if row['FLAG_OWN_REALTY'] == 'Y' else 0
                cnt_children = int(row['CNT_CHILDREN']) if pd.notna(row['CNT_CHILDREN']) else 0
                amt_income_total = int(row['AMT_INCOME_TOTAL']) if pd.notna(row['AMT_INCOME_TOTAL']) else 0
                amt_credit = int(row['AMT_CREDIT']) if pd.notna(row['AMT_CREDIT']) else 0
                amt_annuity = int(row['AMT_ANNUITY']) if pd.notna(row['AMT_ANNUITY']) else 0
                amt_goods_price = int(row['AMT_GOODS_PRICE']) if pd.notna(row['AMT_GOODS_PRICE']) else 0
                income_type = str(row['NAME_INCOME_TYPE'])
                education_type = str(row['NAME_EDUCATION_TYPE'])
                family_status = str(row['NAME_FAMILY_STATUS'])
                days_birth = int(row['DAYS_BIRTH']) if pd.notna(row['DAYS_BIRTH']) else 0
                days_employed = int(row['DAYS_EMPLOYED']) if pd.notna(row['DAYS_EMPLOYED']) else 0
                mobile = int(row['FLAG_MOBIL'])
                emp_phone = int(row['FLAG_EMP_PHONE'])
                work_phone = int(row['FLAG_WORK_PHONE'])
                cont_mobile = int(row['FLAG_CONT_MOBILE'])
                phone = int(row['FLAG_PHONE'])
                email = int(row['FLAG_EMAIL'])
                occupation_type = str(row['OCCUPATION_TYPE']) if pd.notna(row['OCCUPATION_TYPE']) and str(row['OCCUPATION_TYPE']) != "nan" else ""
                cnt_family_members = int(row['CNT_FAM_MEMBERS']) if pd.notna(row['CNT_FAM_MEMBERS']) else 0
                document_2 = int(row['FLAG_DOCUMENT_2'])
                document_3 = int(row['FLAG_DOCUMENT_3'])
                document_4 = int(row['FLAG_DOCUMENT_4'])
                document_5 = int(row['FLAG_DOCUMENT_5'])
                document_6 = int(row['FLAG_DOCUMENT_6'])
                document_7 = int(row['FLAG_DOCUMENT_7'])
                document_8 = int(row['FLAG_DOCUMENT_8'])
                document_9 = int(row['FLAG_DOCUMENT_9'])
                document_10 = int(row['FLAG_DOCUMENT_10'])
                document_11 = int(row['FLAG_DOCUMENT_11'])
                document_12 = int(row['FLAG_DOCUMENT_12'])

                # Execute stored procedures with the extracted values
                print("Inserting into client:", id_client, gender, days_birth, education_type, family_status, income_type, occupation_type,
                                cnt_children, cnt_family_members, days_employed)
                # For Insert_Client
                self.cursor.execute("""
                                INSERT INTO client.client
                                (id_client, gender, days_birth, education_type, family_stat, income_type, occupation_type,
                                cnt_children, cnt_family_members, days_employed)
                                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                """,
                                    id_client, gender, days_birth, education_type, family_status, income_type,
                                    occupation_type,
                                    cnt_children, cnt_family_members, days_employed)

                print("Inserting into contact flags:", id_client, mobile, emp_phone, work_phone, cont_mobile, phone, email)
                # For Insert_Contact_Flags
                self.cursor.execute("""
                                INSERT INTO client.contact_flags
                                (id_client, mobile, emp_phone, work_phone, cont_mobile, phone, email)
                                VALUES (?, ?, ?, ?, ?, ?, ?)
                                """,
                                    id_client, mobile, emp_phone, work_phone, cont_mobile, phone, email)

                print("Inserting into heritage flags:", id_client, own_realty, own_car)
                # For Insert_Heritage_Flags
                self.cursor.execute("""
                                INSERT INTO client.heritage_flags
                                (id_client, own_realty, own_car)
                                VALUES (?, ?, ?)
                                """,
                                    id_client, own_realty, own_car)

                print("Inserting into document flags:", id_client, document_2, document_3, document_4, document_5, document_6, document_7,
                                    document_8, document_9, document_10, document_11, document_12)
                # For Insert_Document_Flags
                self.cursor.execute("""
                                INSERT INTO client.document_flags
                                (id_client, document_2, document_3, document_4, document_5, document_6, document_7,
                                document_8, document_9, document_10, document_11, document_12)
                                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                """,
                                    id_client, document_2, document_3, document_4, document_5, document_6, document_7,
                                    document_8, document_9, document_10, document_11, document_12)

                print("Inserting into application:", id_client, contract_type, target, amt_income_total, amt_annuity, amt_goods_price,
                                    amt_credit)
                # For Insert_Application
                self.cursor.execute("""
                                INSERT INTO client.application
                                (id_client, contract_type, target, amt_income_total, amt_anuity, amt_goods_price, amt_credit)
                                VALUES (?, ?, ?, ?, ?, ?, ?)
                                """,
                                    id_client, contract_type, target, amt_income_total, amt_annuity, amt_goods_price,
                                    amt_credit)

            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from application_train.csv completed successfully!")

    def migrate_previous_application_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_previous_application = int(row['SK_ID_PREV'])
                id_client = int(row['SK_ID_CURR'])
                contract_type = str(row['NAME_CONTRACT_TYPE'])
                amt_annuity = int(row['AMT_ANNUITY']) if pd.notna(row['AMT_ANNUITY']) else 0
                amt_application = int(row['AMT_APPLICATION']) if pd.notna(row['AMT_APPLICATION']) else 0
                amt_credit = int(row['AMT_CREDIT']) if pd.notna(row['AMT_CREDIT']) else 0
                amt_down_payment = int(row['AMT_DOWN_PAYMENT']) if pd.notna(row['AMT_DOWN_PAYMENT']) else 0
                amt_goods_price = int(row['AMT_GOODS_PRICE']) if pd.notna(row['AMT_GOODS_PRICE']) else 0
                contract_status = str(row['NAME_CONTRACT_STATUS'])
                days_decision = int(row['DAYS_DECISION'])
                payment_type = str(row['NAME_PAYMENT_TYPE'])
                client_type = str(row['NAME_CLIENT_TYPE'])
                product_type = str(row['NAME_PRODUCT_TYPE'])
                channel_type = str(row['CHANNEL_TYPE'])

                # Use INSERT INTO statements
                print("Inserting into previous application:", id_client, id_previous_application, contract_type, amt_annuity,
                                 amt_application, amt_credit, amt_down_payment, amt_goods_price,
                                 contract_status, days_decision, product_type, channel_type,
                                 payment_type, client_type)
                self.cursor.execute("""
                                INSERT INTO client.previous_application (id_client, id_previous_application, contract_type, amt_annuity, 
                                amt_application, amt_credit, amt_down_payment, amt_goods_price, contract_status, days_decision, 
                                    product_type, channel_type, payment_type, client_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                """,
                                (id_client, id_previous_application, contract_type, amt_annuity,
                                 amt_application, amt_credit, amt_down_payment, amt_goods_price,
                                 contract_status, days_decision, product_type, channel_type,
                                 payment_type, client_type))

            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from previous_application.csv completed successfully!")

    def migrate_installments_payments_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_previous_application = int(row['SK_ID_PREV'])
                id_client = int(row['SK_ID_CURR'])
                installment_version = int(row['NUM_INSTALMENT_VERSION']) if pd.notna(row['NUM_INSTALMENT_VERSION']) else 0
                installment_number = int(row['NUM_INSTALMENT_NUMBER']) if pd.notna(row['NUM_INSTALMENT_NUMBER']) else 0
                days_installment = int(row['DAYS_INSTALMENT']) if pd.notna(row['DAYS_INSTALMENT']) else 0
                days_entry_payment = int(row['DAYS_ENTRY_PAYMENT']) if pd.notna(row['DAYS_ENTRY_PAYMENT']) else 0
                amt_installment = int(row['AMT_INSTALMENT']) if pd.notna(row['AMT_INSTALMENT']) else 0
                amt_payment = int(row['AMT_PAYMENT']) if pd.notna(row['AMT_PAYMENT']) else 0

                # Use INSERT INTO statements
                print("Inserting into installments payments:", id_client, id_previous_application, installment_version,
                                     installment_number, days_installment, days_entry_payment,
                                     amt_installment, amt_payment)
                self.cursor.execute("""
                    INSERT INTO repayment.installment_payment (id_client, id_previous_application, installment_version,
                        installment_number, days_installment, days_entry_payment,
                        amt_installment, amt_payment) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                                    (id_client, id_previous_application, installment_version,
                                     installment_number, days_installment, days_entry_payment,
                                     amt_installment, amt_payment))

            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from installments_payments.csv completed successfully!")

    def migrate_credit_card_balance_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_previous_application = int(row['SK_ID_PREV'])
                id_client = int(row['SK_ID_CURR'])
                months_balance = int(row['MONTHS_BALANCE']) if pd.notna(row['MONTHS_BALANCE']) else 0
                amt_balance = int(row['AMT_BALANCE']) if pd.notna(row['AMT_BALANCE']) else 0
                amt_credit_limit_actual = int(row['AMT_CREDIT_LIMIT_ACTUAL']) if pd.notna(row['AMT_CREDIT_LIMIT_ACTUAL']) else 0
                amt_drawings_current = int(row['AMT_DRAWINGS_CURRENT']) if pd.notna(row['AMT_DRAWINGS_CURRENT']) else 0
                amt_payment_current = int(row['AMT_PAYMENT_CURRENT']) if pd.notna(row['AMT_PAYMENT_CURRENT']) else 0
                amt_recivable = int(row['AMT_RECIVABLE']) if pd.notna(row['AMT_RECIVABLE']) else 0
                cnt_drawings_current = int(row['CNT_DRAWINGS_CURRENT']) if pd.notna(row['CNT_DRAWINGS_CURRENT']) else 0
                contract_status = str(row['NAME_CONTRACT_STATUS'])

                # Use INSERT INTO statements
                print("Inserting into credit card balance:", id_client, id_previous_application, months_balance, amt_balance,
                                     amt_credit_limit_actual, amt_drawings_current, amt_payment_current,
                                     amt_recivable, cnt_drawings_current, contract_status)
                self.cursor.execute("""
                    INSERT INTO credit.credit_card_balance (id_client, id_previous_application, months_balance, amt_balance,
                        amt_credit_limit_actual, amt_drawings_current, amt_payment_current,
                        amt_recivable, cnt_drawings_current, contract_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                                    (id_client, id_previous_application, months_balance, amt_balance,
                                     amt_credit_limit_actual, amt_drawings_current, amt_payment_current,
                                     amt_recivable, cnt_drawings_current, contract_status))

            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from credit_card_balance.csv completed successfully!")

    def migrate_pos_cash_balance_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_previous_application = int(row['SK_ID_PREV'])
                id_client = int(row['SK_ID_CURR'])
                months_balance = int(row['MONTHS_BALANCE']) if pd.notna(row['MONTHS_BALANCE']) else 0
                cnt_installment = int(row['CNT_INSTALMENT']) if pd.notna(row['CNT_INSTALMENT']) else 0
                cnt_installment_future = int(row['CNT_INSTALMENT_FUTURE']) if pd.notna(row['CNT_INSTALMENT_FUTURE']) else 0
                contract_status = str(row['NAME_CONTRACT_STATUS'])

                # Use INSERT INTO statements
                print("Inserting into POS CASH balance:", id_client, id_previous_application, months_balance,
                                     cnt_installment, cnt_installment_future, contract_status)
                self.cursor.execute("""
                    INSERT INTO credit.pos_cash_balance (id_client, id_previous_application, months_balance,
                        cnt_installment, cnt_installment_future, contract_status) VALUES (?, ?, ?, ?, ?, ?)
                    """,
                                    (id_client, id_previous_application, months_balance,
                                     cnt_installment, cnt_installment_future, contract_status))
            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from POS_CASH_balance.csv completed successfully!")

    def migrate_bureau_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_client = int(row['SK_ID_CURR'])
                id_bureau = int(row['SK_ID_BUREAU'])
                credit_active = 1 if str(row['CREDIT_ACTIVE']) == 'Active' else 0
                days_credit = int(row['DAYS_CREDIT']) if pd.notna(row['DAYS_CREDIT']) else 0
                credit_day_overdue = int(row['CREDIT_DAY_OVERDUE']) if pd.notna(row['CREDIT_DAY_OVERDUE']) else 0
                days_credit_enddate = int(row['DAYS_CREDIT_ENDDATE']) if pd.notna(row['DAYS_CREDIT_ENDDATE']) else 0
                amt_credit_sum = int(row['AMT_CREDIT_SUM']) if pd.notna(row['AMT_CREDIT_SUM']) else 0
                credit_type = str(row['CREDIT_TYPE'])
                days_credit_update = int(row['DAYS_CREDIT_UPDATE']) if pd.notna(row['DAYS_CREDIT_UPDATE']) else 0

                # Use INSERT INTO statements
                print("Inserting into bureau:", id_bureau, id_client, credit_active, days_credit,
                                     credit_day_overdue, days_credit_enddate, amt_credit_sum,
                                     credit_type, days_credit_update)
                self.cursor.execute("""
                    INSERT INTO credit.bureau (id_bureau, id_client, credit_active, days_credit,
                        credit_day_overdue, days_credit_enddate, amt_credit_sum,
                        credit_type, days_credit_update) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                                    (id_bureau, id_client, credit_active, days_credit,
                                     credit_day_overdue, days_credit_enddate, amt_credit_sum,
                                     credit_type, days_credit_update))
            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from bureau.csv completed successfully!")

    def migrate_bureau_balance_data(self, df):
        # Iterate through each row in the DataFrame
        for _, row in df.iterrows():
            try:
                # Extract values from the row
                id_bureau = int(row['SK_ID_BUREAU'])
                months_balance = int(row['MONTHS_BALANCE']) if pd.notna(row['MONTHS_BALANCE']) else 0
                status = str(row['STATUS'])

                # Use INSERT INTO statements
                print("Inserting into bureau balance:", id_bureau, months_balance, status)
                self.cursor.execute("""
                    INSERT INTO credit.bureau_balance (id_bureau, months_balance, status) VALUES (?, ?, ?)
                    """,
                                    (id_bureau, months_balance, status))

            except Exception as e:
                logging.error(f"Error processing row: {e}")

        self.connection.commit()
        logging.info(f"Data migration from bureau_balance.csv completed successfully!")
