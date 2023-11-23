from Migrador_De_Datos import DataMigrator

# Example usage
try:
    migrator = DataMigrator(server="LAPTOP-FNPBMJAR\PROYECTODB2", database="Home_Credit_Default_Risk", username="sa",
                            password="1234")
    migrator.connect_to_sql_server()

    migrator.migrate_data(
        "previous_application.csv",
        (migrator.migrate_previous_application_data, ()),
        "installments_payments.csv",
        (migrator.migrate_installments_payments_data, ()),
        "credit_card_balance.csv",
        (migrator.migrate_credit_card_balance_data, ())
    )

finally:
    migrator.close_connection()