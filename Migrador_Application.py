from Migrador_De_Datos import DataMigrator

# Example usage
try:
    migrator = DataMigrator(server="LAPTOP-FNPBMJAR\PROYECTODB2", database="Home_Credit_Default_Risk", username="sa",
                            password="1234")
    migrator.connect_to_sql_server()

    migrator.migrate_data(
        "application_test.csv",
        (migrator.migrate_application_test_data, ()),
        "application_train.csv",
        (migrator.migrate_application_train_data, ())
    )

finally:
    migrator.close_connection()
