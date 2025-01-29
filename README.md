# Data Engineering Project: Medallion Architecture

This project demonstrates a data engineering pipeline using the Medallion Architecture on Azure. The pipeline involves data extraction, transformation, and loading (ETL) processes, utilizing various Azure services, including Azure Storage, Azure SQL Database, Azure Data Factory, Azure Databricks, and DBT (Data Build Tool).

## Project Overview

### Architecture Layers

- **Bronze Layer**: Raw data storage.
- **Silver Layer**: Processed and clean data.
- **Gold Layer**: Curated data for analysis and reporting.

### Components

1. **Azure Storage Containers**:
   - **Bronze**: Stores raw Parquet files.
   - **Silver**: Stores processed data.
   - **Gold**: Stores curated and aggregated data.

2. **Azure SQL Database**:
   - A database created with Adventure Works data, used as the source for this pipeline.

3. **Azure Data Factory**:
   - **Lookup and ForEach Activities**: Used to fetch data from all tables in the Azure SQL Database and store them as Parquet files in the Bronze container.
   - **Azure Key Vault Integration**: Securely stores and retrieves the storage account access key.

4. **Azure Databricks**:
   - **Mounting Containers**: Bronze, Silver, and Gold containers are mounted in DBFS using Databricks Secret Scope and Azure Key Vault.
   - **Data Ingestion Notebook**: A Databricks notebook that is triggered by Azure Data Factory after data is loaded into the Bronze container. This notebook:
     - Creates a database and tables in the Databricks catalog.
     - Loads data into these tables from the mounted containers.

5. **Databricks CLI & DBT**:
   - **Databricks CLI**: Installed on the local system to connect with the Databricks workspace.
   - **DBT Configuration**: DBT is configured to connect with the Databricks workspace for transforming data.
   - **DBT Snapshots**: Used to track changes in the data over time.
   - **SQL Queries**: Created and executed in DBT, with outputs stored in the Silver container and Databricks catalog.

6. **Gold Layer**:
   - **Final Tables**: Using DBT, snapshot tables were joined to create `dim_customer`, `dim_product`, and `sales` tables.
   - Data is loaded into the Databricks catalog and the Gold container.

7. **Documentation**:
   - DBT documentation is generated for the entire project, providing insights into the data model, lineage, and transformation steps.

## Getting Started

### Prerequisites

- Azure Subscription
- Azure Storage Account
- Azure SQL Database
- Azure Data Factory
- Azure Databricks Workspace
- Databricks CLI installed locally
- DBT installed and configured

### Setup Instructions

1. **Create Storage Containers**:
   - Create three containers in Azure Storage Account: Bronze, Silver, and Gold.

2. **Setup Azure SQL Database**:
   - Import Adventure Works data into the Azure SQL Database.

3. **Azure Data Factory**:
   - Create a pipeline to fetch data from the SQL Database and store it in the Bronze container.

4. **Azure Key Vault**:
   - Store the storage account access key securely and integrate it with Data Factory and Databricks.

5. **Azure Databricks**:
   - Mount the Bronze, Silver, and Gold containers in DBFS.
   - Run the data ingestion notebook to create and populate tables in the Databricks catalog.

6. **Databricks CLI & DBT**:
   - Install and configure Databricks CLI to connect with the workspace.
   - Configure DBT to connect with Databricks.
   - Run DBT snapshots and queries to populate the Silver and Gold layers.

7. **Generate DBT Documentation**:
   - Run DBT commands to generate documentation for the project.

## Project Structure

```
/project-root
│
├── data-factory-pipeline/
│   └── pipeline.json
├── databricks-notebooks/
│   └── ingestion-notebook.py
├── dbt/
│   ├── models/
│   │   ├── bronze/
│   │   ├── silver/
│   │   └── gold/
│   └── snapshots/
└── README.md
```

## Conclusion

This project demonstrates the implementation of the Medallion Architecture using Azure services. By following the steps outlined above, you can replicate the process and adapt it to your own data engineering needs.

## References

- [Azure Data Factory Documentation](https://docs.microsoft.com/en-us/azure/data-factory/)
- [Azure Databricks Documentation](https://docs.microsoft.com/en-us/azure/databricks/)
- [DBT Documentation](https://docs.getdbt.com/)
