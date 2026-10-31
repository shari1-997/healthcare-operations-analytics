# Healthcare Operations Analytics | MySQL + Power BI

A portfolio project analyzing healthcare appointment operations, patient demographics, billing activity, and payment collections. The project uses **MySQL** for relational data storage and validation and **Power BI Desktop** for the interactive four-page dashboard.

> **Data note:** The project owner confirms that the six CSV datasets and the embedded data in the Power BI report are synthetic/fake records created for this portfolio project. No real patient records are intended to be included. Do not add real patient information, confidential business records, passwords, or database credentials to this public repository.

## Dashboard preview

The report contains four pages:

### 1. Overview

Appointment volume and status, monthly appointment trends, appointments by department, and average waiting time by department.

![Overview dashboard](Dashboard%20Screenshots/01_Overview.jpg)

### 2. Booking & Patient Insights

Booking channel analysis, appointment mix by patient age band, all-time patient counts by insurance plan, and all-time patients by home region. Missing booking channels and insurance plans are represented as **Unknown**, not discarded.

![Booking and patient insights](Dashboard%20Screenshots/02_Booking_Patient_Insights.jpg)

### 3. Billing & Financial Analysis

Billed amount, recorded payments, posted payments, outstanding balance, collection rate, payment status, payment method, billing status, and bill count by status.

![Billing and financial analysis](Dashboard%20Screenshots/03_Billing_Financial_Analysis.jpg)

### 4. Revenue Trends

Monthly payment collections by actual payment date and monthly billed-versus-posted payments by bill date. Separate year slicers are used for payment year and billing year.

![Revenue trends](Dashboard%20Screenshots/04_Revenue_Trends.jpg)

A PDF export of the dashboard is also included: [Healthcare Operations Analytics Dashboard.pdf](Healthcare%20Operations%20Analytics%20Dashboard.pdf).

## Project objectives

- Monitor appointment volume, completion, cancellations, no-shows, and waiting time.
- Understand how appointments are distributed across booking channels, departments, and patient age bands.
- Summarize the all-time patient population by insurance plan and home region.
- Analyze billed amounts, recorded and posted payments, and outstanding balances.
- Compare monthly billing with posted payments and separately analyze the timing of actual payment collections.
- Validate source row counts, key relationships, and financial calculations in MySQL before presenting the metrics in Power BI.

## Technology stack

| Tool | Use |
|---|---|
| MySQL | Relational database and SQL validation |
| MySQL Workbench | Schema creation, CSV loading, and query execution |
| Power BI Desktop | Data model, DAX measures, slicers, and dashboard visuals |
| Power Query | Data preview and display-field preparation |
| DAX | KPI calculations and display measures |
| CSV | Source data files |

## Repository structure

```text
01_Healthcare_Operations_Analytics/
├── README.md
├── .gitignore
├── Healthcare Operations Analytics Dashboard.pdf
├── Dashboard Screenshots/
│   ├── 01_Overview.jpg
│   ├── 02_Booking_Patient_Insights.jpg
│   ├── 03_Billing_Financial_Analysis.jpg
│   └── 04_Revenue_Trends.jpg
├── Data/
│   ├── README.md
│   ├── appointments.csv
│   ├── billing.csv
│   ├── departments.csv
│   ├── doctors.csv
│   ├── patients.csv
│   └── payments.csv
├── Power BI/
│   ├── README.md
│   └── Healthcare Operations Analytics Dashboard.pbix
├── SQL/
│   ├── README.md
│   ├── 01_schema.sql
│   ├── 02_load_data.sql
│   └── 03_data_quality_checks.sql
└── docs/
    ├── DATA_DICTIONARY.md
    ├── DAX_MEASURES.md
    ├── DATA_QUALITY_AND_VALIDATION.md
    ├── DATA_MODEL.md
    └── GITHUB_UPLOAD_GUIDE.md
```

The repository includes the six synthetic CSV datasets in `Data/`, the interactive Power BI report in `Power BI/`, the SQL schema/load/validation scripts, four dashboard screenshots, a PDF export, and supporting documentation. The `02_load_data.sql` script uses a generic local-path placeholder; update it to the location of your project folder before running it on your computer.

## Dataset overview

The MySQL schema is `healthcare_ops`. The six source files contain **18,800 rows in total**:

| Table | Rows | Role |
|---|---:|---|
| `appointments` | 8,000 | Appointment events and operational outcomes |
| `billing` | 5,760 | Bill and charge records |
| `departments` | 10 | Department reference data |
| `doctors` | 60 | Doctor reference data |
| `patients` | 1,500 | Patient demographic and insurance attributes |
| `payments` | 3,470 | Payment transactions |
| **Total** | **18,800** | Across the six tables |

See [Data Dictionary](docs/DATA_DICTIONARY.md) for the key fields used in the analysis.

## Dashboard KPI snapshot

Values below reflect the report's full-dataset view with year slicers set to **All**. K/M labels in the report are rounded for presentation.

### Appointment operations

| KPI | Displayed result | Meaning |
|---|---:|---|
| Total appointments | 8K | Appointment records |
| Completed appointments | 6.1K | Appointments with `Completed` status |
| Appointment completion rate | 76.48% | Completed appointments divided by total appointments |
| Appointment cancellation rate | 10.6% | Cancelled appointments divided by total appointments |
| Average waiting time | 42.5 min | Average of nonblank `wait_minutes` values |
| All-time patients | 1,500 | Distinct patient IDs |

### Billing and collections

| KPI | Displayed result | Validated amount |
|---|---:|---:|
| Total billed amount | 1.51M | 1,513,480.00 |
| Recorded payments | 710.01K | 710,014.08 |
| Posted payment amount | 649.22K | 649,224.08 |
| Outstanding balance | 864.26K | 864,255.92 |
| Payment collection rate | 42.9% | Posted payments / total billed amount |
| Total bills | 5,760 | 5,760 bill records |

**Metric definitions:** `Recorded Payments` includes all payment statuses in the payment table. `Posted Payment Amount` includes only rows whose `payment_status` is `Posted`. The collection rate uses posted payments, not all recorded transactions. Outstanding balance was independently checked bill-by-bill in MySQL; the validation returned zero overpaid amount for this dataset.

## Selected observations

- Online (2,748) and phone (2,573) are the two largest booking channels. Referral contributes 1,783 appointments, walk-in 876, and 20 appointments have an unknown booking channel.
- The all-time patient insurance-plan visual includes 18 patients with an unknown insurance plan; those records are retained in the visual.
- The all-time patient home-region counts are West 314, East 306, North 298, Central 296, and South 286.
- Neurology (834) and Cardiology (832) have the highest appointment counts in the department chart; Orthopedics has 743.
- Women's Health has the highest department-level average waiting time shown (43.7 minutes), while Cardiology has the lowest shown (41.7 minutes).
- Posted payments total 649,224.08; pending and reversed amounts are included in Recorded Payments but excluded from the collection-rate numerator.

These are descriptive observations from the supplied dataset, not clinical conclusions or forecasts.

## Data model

The Power BI model contains seven relationships:

| From | To | Cardinality | Status |
|---|---|---|---|
| `patients` | `appointments` | 1 to many | Active |
| `doctors` | `appointments` | 1 to many | Active |
| `departments` | `appointments` | 1 to many | Active |
| `appointments` | `billing` | 1 to 1 | Active |
| `billing` | `payments` | 1 to many | Active |
| `patients` | `billing` | 1 to many | Inactive |
| `departments` | `doctors` | 1 to many | Inactive |

The two inactive relationships provide alternate paths and were left inactive to avoid ambiguous filtering in the current model. The patient-population visuals are intentionally labelled **All-Time** because they show the entire patient table and do not change with the Appointment Year slicer.

See [Data Model](docs/DATA_MODEL.md) for relationship details and date-field interpretation.

## SQL validation completed

The project was checked in MySQL before dashboard completion:

- All six table row counts matched the expected counts shown above.
- Required appointment fields (`patient_id`, `doctor_id`, `appointment_date`, and `appointment_status`) had zero missing values.
- Appointment references to patients, doctors, and departments had zero unmatched records.
- All 5,760 billing records referenced an existing appointment.
- Billing IDs were unique; billing contained 5,760 distinct bill IDs and 5,760 distinct appointment IDs.
- Payment records had zero missing or unmatched bill references.
- Bill-level financial reconciliation returned total billed of 1,513,480.00, posted payments of 649,224.08, outstanding of 864,255.92, and overpaid amount of 0.00.

Run [03_data_quality_checks.sql](SQL/03_data_quality_checks.sql) to repeat the principal checks after loading the data.

## Reproducing the project

1. Install MySQL Server and MySQL Workbench.
2. Place the six CSV files in the local `Data/` folder.
3. In MySQL Workbench, run `SQL/01_schema.sql` to create the `healthcare_ops` schema and tables.
4. Run `SQL/02_load_data.sql` to import the CSV files. If the import script uses local file paths, update those paths for your computer and enable the required local-infile client option in your MySQL Workbench connection.
5. Run `SQL/03_data_quality_checks.sql` and confirm that the checks match the validation summary above.
6. Install Power BI Desktop and the Oracle MySQL Connector/NET driver required by the Power BI MySQL connector.
7. Open the `.pbix` file from `Power BI/` and connect to the local MySQL instance (`localhost`) and database (`healthcare_ops`) using your own local credentials. Do not store database passwords in this repository.
8. Refresh the model and verify the four report pages and slicers.

The included CSV datasets and `.pbix` are synthetic portfolio assets, as confirmed by the project owner. Anyone adapting this repository should independently verify their own data before publishing. Never include real patient records, confidential data, database passwords, or connection credentials.

## Documentation

- [Data Dictionary](docs/DATA_DICTIONARY.md)
- [DAX Measures](docs/DAX_MEASURES.md)
- [Data Quality & Validation](docs/DATA_QUALITY_AND_VALIDATION.md)
- [Data Model](docs/DATA_MODEL.md)
- [GitHub Upload Guide](docs/GITHUB_UPLOAD_GUIDE.md)
- [Portfolio / LinkedIn Project Text](docs/PORTFOLIO_DESCRIPTION.md)

## Limitations and interpretation notes

- The dataset covers the records provided in the six CSV files; findings should not be generalized to a real healthcare provider.
- All-Time patient metrics are not year-scoped by the Appointment Year slicer.
- Monthly Payment Collections is grouped by the actual `payment_date` and uses posted payments.
- Monthly Billed vs Posted Payments is grouped by `bill_date`; it compares bills created in each month with posted payments associated with those bills. It is not a cash-receipt-by-month chart.
- Rounded chart labels (K/M) may not sum exactly due to display rounding; underlying measures retain numeric values.
- No real-world clinical, patient-care, or financial decisions should be made from this portfolio dataset.

## Author

**Data Analytics Portfolio Project**  
Skills demonstrated: SQL, MySQL, Power BI, Power Query, DAX, data validation, data modelling, KPI design, and dashboard storytelling.
