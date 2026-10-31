# SQL scripts

Run the scripts in this order from MySQL Workbench:

1. `01_schema.sql` - creates the `healthcare_ops` schema and six tables.
2. `02_load_data.sql` - loads the source CSV files from the `Data/` folder. Update local file paths inside the script if they differ on your computer. The MySQL Workbench connection must allow local infile loading.
3. `03_data_quality_checks.sql` - optional repeatable row-count, referential-integrity, duplicate-key, and financial reconciliation checks.

Do not place database usernames or passwords in SQL scripts. If `02_load_data.sql` contains a local absolute path, change it to a project-relative or local path before publishing.
