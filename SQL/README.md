# SQL scripts

Run the scripts in this order from MySQL Workbench:

1. `01_schema.sql` - creates the `healthcare_ops` schema and six tables.
2. `02_load_data.sql` - loads the six source CSV files from the `Data/` folder. Replace the generic `C:/path/to/01_Healthcare_Operations_Analytics` path in the script with your local project folder before running. The MySQL Workbench client connection must allow local-infile loading.
3. `03_data_quality_checks.sql` - optional repeatable row-count, referential-integrity, duplicate-key, and financial reconciliation checks.

Do not place database usernames or passwords in SQL scripts. The shared script uses a generic path placeholder rather than a personal computer path. Never commit your own private credentials or unrelated local file paths.
