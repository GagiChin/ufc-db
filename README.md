# ufc-db

UFC data engineering project implementing a Bronze / Silver / Gold architecture in MySQL.

## Bronze Layer
The Bronze layer ingests raw UFC CSV datasets into MySQL using `LOAD DATA INFILE`.
All columns are stored as VARCHAR to preserve raw source data and avoid ingestion failures.

## Running the Bronze Layer
1. Place the source CSV files in your MySQL `secure_file_priv` directory.
2. Run the ingestion script:
   ```sql
   SOURCE sql/01_bronze/01_create_load_bronze.sql;
