# Data folder

Place the six source CSV files here:

- `appointments.csv` - 8,000 rows
- `billing.csv` - 5,760 rows
- `departments.csv` - 10 rows
- `doctors.csv` - 60 rows
- `patients.csv` - 1,500 rows
- `payments.csv` - 3,470 rows

The combined source row count is 18,800. The project expects the MySQL schema name `healthcare_ops`.

**Privacy:** These files may contain row-level healthcare-related information. Do not commit them to a public repository unless you have confirmed they are synthetic or properly de-identified and are permitted to publish them. The root `.gitignore` excludes `Data/*.csv` by default.
