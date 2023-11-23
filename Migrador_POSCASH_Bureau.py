from Migrador_De_Datos import DataMigrator

# Example usage
try:
    migrator = DataMigrator(server="LAPTOP-FNPBMJAR\PROYECTODB2", database="Home_Credit_Default_Risk", username="sa",
                            password="1234")
    migrator.connect_to_sql_server()

    migrator.migrate_data(
        #"POS_CASH_balance.csv",
        #(migrator.migrate_pos_cash_balance_data, ()),
        #"bureau.csv",
        #(migrator.migrate_bureau_data, ()),
        "bureau_balance.csv",
        (migrator.migrate_bureau_balance_data, ())
    )

finally:
    migrator.close_connection()