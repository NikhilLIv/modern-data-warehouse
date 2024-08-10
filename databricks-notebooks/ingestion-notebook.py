fileName = dbutils.widgets.get('fileName')
tableSchema = dbutils.widgets.get('table_schema')
tableName = dbutils.widgets.get('table_name')

#create db if doesn't exist

spark.sql(f"CREATE DATABASE IF NOT EXISTS {tableSchema}")

#create table if doesn't exist

spark.sql("""CREATE TABLE IF NOT EXISTS """+tableSchema+"""."""+tableName+"""
          USING PARQUET LOCATION '/mnt/bronze/"""+fileName+"""/"""+tableSchema+"""."""+tableName+""".parquet'""")
