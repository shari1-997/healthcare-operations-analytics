# Power BI Data Model

The Power BI model uses six imported MySQL tables from the `healthcare_ops` schema.

## Relationships

| One side | Many / related side | Cardinality | State | Purpose |
|---|---|---|---|---|
| `patients` | `appointments` | 1:* | Active | Connect patient attributes to appointment events |
| `doctors` | `appointments` | 1:* | Active | Connect doctor attributes to appointment events |
| `departments` | `appointments` | 1:* | Active | Connect department attributes to appointment events |
| `appointments` | `billing` | 1:1 | Active | Connect bills to the originating appointment |
| `billing` | `payments` | 1:* | Active | Connect payment transactions to bills |
| `patients` | `billing` | 1:* | Inactive | Alternate patient-to-billing path |
| `departments` | `doctors` | 1:* | Inactive | Alternate department-to-doctor path |

The direct Patients-to-Billing and Departments-to-Doctors relationships remain inactive because active routes already exist through the appointment table. Keeping these alternate paths inactive avoids competing active filter paths in this report.

## Model validation

- Appointments contain valid patient, doctor, and department references.
- All billing rows link to an existing appointment.
- All payment rows link to an existing bill.
- `bill_id` is unique in the billing table.
- The billing table has 5,760 rows and 5,760 distinct appointment IDs in the validation results.

## Date semantics

The report deliberately uses two separate date concepts on the Revenue Trends page:

1. **Bill date** (`billing[bill_date]`) is the date the bill was recorded. The `Bill Year` slicer filters the monthly billed-versus-posted comparison. Posted payments are attributed to their related bill for this view.
2. **Payment date** (`payments[payment_date]`) is the date a payment transaction was recorded. The `Payment Year` slicer filters Monthly Payment Collections, which uses posted payments.

The year slicers on the Revenue Trends page have separate visual interactions so each slicer filters the chart that uses its corresponding date.

## All-time patient visuals

The Booking & Patient Insights page includes an Appointment Year slicer for appointment-related visuals. The patient population visuals use the patient table and are explicitly labelled **All-Time** because they represent all 1,500 patient records, not only patients connected to appointments in the selected year.

## Relationship maintenance

If you change relationships in the future, re-check:

- Cardinality and uniqueness on the one side.
- Referential integrity in MySQL.
- Active/inactive state and filter direction.
- Whether slicers filter the intended visuals only.
- Whether a change introduces multiple active filter paths.
