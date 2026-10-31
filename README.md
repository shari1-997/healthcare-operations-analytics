# Healthcare Operations Analytics
### MySQL · Power BI · SQL · DAX

An end-to-end data analytics portfolio project exploring healthcare appointment operations, patient demographics, billing performance, and payment collections. The project combines a relational MySQL database, repeatable SQL validation, and a four-page interactive Power BI dashboard.

<p align="center">
  <a href="https://github.com/shari1-997/healthcare-operations-analytics">
    <img src="https://img.shields.io/badge/Project-Healthcare%20Analytics-E8CF3E?style=for-the-badge&labelColor=242424" alt="Healthcare Operations Analytics">
  </a>
  <img src="https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Visualization-Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" alt="Power BI">
  <img src="https://img.shields.io/badge/Language-SQL-4479A1?style=for-the-badge" alt="SQL">
</p>

> **Dataset note:** The project owner confirms that the six CSV datasets and the data embedded in the Power BI report are synthetic/fake records created for this portfolio project. They are intended for learning and demonstration, not for real clinical, patient-care, or financial decisions. Do not add real patient information, confidential business records, passwords, or database credentials to this public repository.

---

## Project at a glance

| Area | Summary |
|---|---|
| Business context | Healthcare operations and financial performance |
| Database | MySQL — `healthcare_ops` |
| BI tool | Power BI Desktop |
| Source files | 6 synthetic CSV datasets |
| Total source records | **18,800** |
| Database tables | 6 |
| Dashboard pages | 4 |
| SQL scripts | 3 |
| Main techniques | SQL querying, data validation, data modelling, DAX, KPI reporting, interactive slicers |

## Dashboard preview

The Power BI report is organized into four pages. Select an image to open the corresponding full-size screenshot.

### 1. Overview

Monitors appointment volume, completion and cancellation rates, monthly trends, department activity, and average waiting time.

![Healthcare Operations Dashboard - Overview](Dashboard%20Screenshots/01_Overview.jpg)

### 2. Booking & Patient Insights

Explores booking channels, appointment mix by patient age group, and the all-time patient population by insurance plan and home region. Missing booking-channel and insurance-plan values are retained and labelled **Unknown**.

![Healthcare Operations Dashboard - Booking and Patient Insights](Dashboard%20Screenshots/02_Booking_Patient_Insights.jpg)

### 3. Billing & Financial Analysis

Reviews billed amounts, recorded payments, posted payments, outstanding balance, collection rate, payment methods, payment status, and billing status.

![Healthcare Operations Dashboard - Billing and Financial Analysis](Dashboard%20Screenshots/03_Billing_Financial_Analysis.jpg)

### 4. Revenue Trends

Compares monthly payment collections with monthly billed-versus-posted payments. Payment Year and Billing Year slicers are provided separately because the visuals use different date fields.

![Healthcare Operations Dashboard - Revenue Trends](Dashboard%20Screenshots/04_Revenue_Trends.jpg)

**Explore the deliverables:**
- [Download the Power BI report (.pbix)](Power%20BI/Healthcare%20Operations%20Analytics%20Dashboard.pbix)
- [View the dashboard PDF](Healthcare%20Operations%20Analytics%20Dashboard.pdf)
- [Open all dashboard screenshots](Dashboard%20Screenshots/)

---

## Key performance indicators

The figures below reflect the full-dataset view with the year slicers set to **All**. K/M values are rounded for display; the validated monetary amounts are shown in full.

### Appointment operations

| KPI | Result |
|---|---:|
| Total appointments | **8,000** |
| Completed appointments | **6.1K** |
| Appointment completion rate | **76.48%** |
| Appointment cancellation rate | **10.6%** |
| Average waiting time | **42.5 minutes** |
| All-time patients | **1,500** |

### Billing and payment collections

| KPI | Result |
|---|---:|
| Total billed amount | **1,513,480.00** |
| Recorded payments — all payment statuses | **710,014.08** |
| Posted payment amount | **649,224.08** |
| Outstanding balance | **864,255.92** |
| Payment collection rate | **42.9%** |
| Total bills | **5,760** |

**Metric definitions**

- **Recorded Payments** includes payment transactions across all statuses.
- **Posted Payment Amount** includes only transactions where `payment_status = "Posted"`.
- **Payment Collection Rate** is Posted Payment Amount divided by Total Billed Amount.
- **Outstanding Balance** is Total Billed Amount less Posted Payment Amount for this analysis.

---

## Selected dataset observations

These are descriptive findings from the supplied synthetic dataset:

- **Booking channels:** Online accounts for 2,748 appointments, Phone 2,573, Referral 1,783, Walk-in 876, and Unknown 20.
- **Insurance plan:** The all-time patient view includes 18 records with an unknown insurance plan; these are retained rather than excluded.
- **Home region:** West 314, East 306, North 298, Central 296, and South 286 patients.
- **Department activity:** Neurology has 834 appointments and Cardiology 832; Orthopedics has 743.
- **Waiting time:** Women's Health has the highest department average shown (43.7 minutes), while Cardiology has the lowest shown (41.7 minutes).
- **Payment status:** Posted payments total 649,224.08. Pending and reversed transactions are included in Recorded Payments but not in the collection-rate numerator.

These observations describe this dataset only. They should not be generalized to an actual healthcare provider.

---

## Technology and skills demonstrated

| Technology / skill | How it is used |
|---|---|
| **MySQL** | Relational database and structured data storage |
| **MySQL Workbench** | Schema creation, CSV loading, query execution, and validation |
| **SQL** | Table creation, bulk loading, joins, aggregations, duplicate checks, and reconciliation |
| **Power BI Desktop** | Interactive report, data model, slicers, and visual design |
| **Power Query** | Data inspection and display-field preparation |
| **DAX** | Measures, KPIs, rates, and formatted display measures |
| **Data modelling** | Relationships across appointments, patients, doctors, departments, billing, and payments |
| **Data visualization** | KPI cards, trend charts, bar/column charts, and status breakdowns |

## Repository structure

```text
healthcare-operations-analytics/
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
    ├── DATA_MODEL.md
    ├── DATA_QUALITY_AND_VALIDATION.md
    ├── DAX_MEASURES.md
    ├── GITHUB_UPLOAD_GUIDE.md
    └── PORTFOLIO_DESCRIPTION.md
```

## Data model

The Power BI model uses six related tables:

- `patients`
- `doctors`
- `departments`
- `appointments`
- `billing`
- `payments`

The model includes active relationships for the primary appointment, billing, and payment analysis paths, plus two inactive alternate relationships to avoid ambiguous filtering in the report. Patient population visuals are explicitly labelled **All-Time** because they represent the full patient table and do not change with the Appointment Year slicer.

See [DATA_MODEL.md](docs/DATA_MODEL.md) for relationship details.

## Data quality and SQL validation

The source data was loaded into MySQL and checked before the dashboard was finalized.

- All six table row counts matched the expected totals.
- Required appointment fields had zero missing values.
- Appointment references to patients, doctors, and departments had zero unmatched records.
- All **5,760** billing records referenced an existing appointment.
- Billing IDs were unique across the 5,760 billing records.
- Payment records had zero missing or unmatched billing references.
- Financial reconciliation returned total billed of **1,513,480.00**, posted payments of **649,224.08**, outstanding balance of **864,255.92**, and overpaid amount of **0.00**.

Run [03_data_quality_checks.sql](SQL/03_data_quality_checks.sql) to repeat the principal validation checks.

## Reproduce the project

### Requirements

- MySQL Server and MySQL Workbench
- Power BI Desktop
- Oracle MySQL Connector/NET driver for the Power BI MySQL connector

### Setup

1. Clone or download this repository.
   ```bash
   git clone https://github.com/shari1-997/healthcare-operations-analytics.git
   ```
2. In MySQL Workbench, open and run `SQL/01_schema.sql` to create the `healthcare_ops` schema and six tables.
3. Open `SQL/02_load_data.sql`. Replace the generic `C:/path/to/01_Healthcare_Operations_Analytics/Data/` file path prefix with the local path to this repository's `Data/` folder. The MySQL Workbench client connection must allow local-infile loading.
4. Run the load script in the order provided. It imports the reference tables before the dependent transaction tables.
5. Run `SQL/03_data_quality_checks.sql` and compare the results with [DATA_QUALITY_AND_VALIDATION.md](docs/DATA_QUALITY_AND_VALIDATION.md).
6. Open the PBIX file from `Power BI/` in Power BI Desktop.
7. Connect to your local MySQL instance (typically `localhost`) and the `healthcare_ops` database using your own credentials, then refresh the model.
8. Review the four report pages and test the year slicers.

**Do not store database usernames, passwords, connection secrets, or real patient data in this repository.**

---

## Documentation

| Document | Description |
|---|---|
| [Data Dictionary](docs/DATA_DICTIONARY.md) | Tables, fields, and dataset descriptions |
| [Data Model](docs/DATA_MODEL.md) | Table relationships and modelling notes |
| [DAX Measures](docs/DAX_MEASURES.md) | KPI and calculation definitions |
| [Data Quality & Validation](docs/DATA_QUALITY_AND_VALIDATION.md) | Validation approach and results |
| [SQL Scripts](SQL/README.md) | Script order and execution notes |
| [Data Folder](Data/README.md) | Dataset contents and row counts |
| [Power BI Report](Power%20BI/README.md) | Report contents and setup notes |
| [Portfolio Description](docs/PORTFOLIO_DESCRIPTION.md) | Short project summary for LinkedIn or a portfolio |
| [GitHub Upload Guide](docs/GITHUB_UPLOAD_GUIDE.md) | Repository publishing notes |

## Limitations

- The dataset is synthetic and intended for demonstration; it does not represent a real healthcare provider.
- All-Time patient metrics are not scoped by the Appointment Year slicer.
- Monthly Payment Collections is grouped by actual `payment_date` and uses posted payments.
- Monthly Billed vs Posted Payments is grouped by `bill_date`; it compares bills created in each month with posted payments associated with those bills. It is not a cash-receipt-by-month chart.
- K/M visual labels are rounded for presentation; underlying measures retain their numeric values.
- The dashboard is not intended for clinical, patient-care, or real financial decision-making.

## Author

**Shaheryar Khan**  
Data Analytics Portfolio Project

Skills: MySQL, SQL, Power BI, Power Query, DAX, data validation, data modelling, KPI design, and dashboard storytelling.
