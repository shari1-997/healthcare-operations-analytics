# Data folder

This folder contains the six synthetic CSV datasets used to build and validate the `healthcare_ops` MySQL schema.

| File | Rows | Description |
|---|---:|---|
| `appointments.csv` | 8,000 | Appointment events and operational outcomes |
| `billing.csv` | 5,760 | Bill and charge records |
| `departments.csv` | 10 | Department reference data |
| `doctors.csv` | 60 | Doctor reference data |
| `patients.csv` | 1,500 | Synthetic patient demographic and insurance attributes |
| `payments.csv` | 3,470 | Payment transactions |
| **Total** | **18,800** | Across all six files |

The project owner confirms that these are fake/synthetic records created for this portfolio project. They are included so others can reproduce the MySQL import, validation queries, and Power BI report.

Use the scripts in `SQL/` to create and load the `healthcare_ops` schema. Update the local file paths in `SQL/02_load_data.sql` for your own computer before running the import.

**Data safety:** Do not replace these sample files with real patient information or confidential transactions in a public repository. Never include database credentials or connection secrets.
