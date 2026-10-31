# Data Dictionary

The project uses six CSV files loaded into the MySQL schema `healthcare_ops`. This document describes the principal fields used by the dashboard and the known row counts. It is a practical analysis dictionary, not a substitute for the full SQL table definitions in `SQL/01_schema.sql`.

## Table inventory

| Table | Source file | Rows | Analytical role |
|---|---|---:|---|
| `appointments` | `appointments.csv` | 8,000 | Appointment events and outcomes |
| `billing` | `billing.csv` | 5,760 | Bill, charge, discount, and net amount records |
| `departments` | `departments.csv` | 10 | Department lookup |
| `doctors` | `doctors.csv` | 60 | Doctor lookup and department assignment |
| `patients` | `patients.csv` | 1,500 | Patient demographic and insurance attributes |
| `payments` | `payments.csv` | 3,470 | Payment transactions and status |

## Appointments

| Field | Description / use |
|---|---|
| `appointment_id` | Unique appointment identifier |
| `patient_id` | Patient reference |
| `doctor_id` | Doctor reference |
| `department_id` | Department reference |
| `appointment_date` | Date used for appointment trends and Appointment Year |
| `scheduled_start` | Scheduled appointment timestamp |
| `appointment_status` | Outcome such as Completed, Cancelled, No-show, or Rescheduled |
| `visit_type` | Appointment/visit category |
| `booking_channel` | Booking source such as Online, Phone, Referral, or Walk-in |
| `duration_minutes` | Appointment duration |
| `check_in_time` / `check_out_time` | Visit check-in and check-out timestamps |
| `wait_minutes` | Waiting time in minutes |
| `created_date` | Record creation date |

Calculated columns used: `Appointment Year`, `Month Short`, `Month Number`, and `Booking Channel Display`.

## Billing

| Field | Description / use |
|---|---|
| `bill_id` | Bill identifier; validated as unique in this dataset |
| `appointment_id` | Appointment reference |
| `patient_id` | Patient reference (the direct patient-billing model relationship is inactive) |
| `bill_date` | Bill date used for billing-month analysis and Bill Year |
| `billing_status` | Bill status, including Paid, Pending, Partially Paid, Denied, and Written Off |
| `charge_amount` | Gross charge amount |
| `discount_amount` | Discount amount |
| `adjustment_amount` | Adjustment amount |
| `net_amount` | Net billed amount used by `Total Billed Amount` |
| `claim_status` | Claim processing status |

Calculated columns used: `Bill Month Short`, `Bill Month Number`, and `Bill Year`.

## Departments

| Field | Description / use |
|---|---|
| `department_id` | Department key |
| `department_name` | Department label used in department visuals |
| `service_line` | Service-line grouping |
| `active_flag` | Department active/inactive indicator |

## Doctors

| Field | Description / use |
|---|---|
| `doctor_id` | Doctor key |
| `department_id` | Department reference |
| `specialty` | Doctor specialty |
| `employment_type` | Employment classification |
| `start_date` | Start date |
| `active_flag` | Active/inactive indicator |

## Patients

| Field | Description / use |
|---|---|
| `patient_id` | Patient key; used for distinct patient counts |
| `age_band` | Age group used in appointment-by-age analysis |
| `administrative_sex` | Demographic attribute |
| `home_region` | Region used in all-time patient distribution |
| `insurance_plan` | Insurance category used in all-time patient distribution |
| `active_flag` | Active/inactive indicator |

Calculated column used: `Insurance Plan Display`, which presents blank insurance values as `Unknown` without altering the source column.

## Payments

| Field | Description / use |
|---|---|
| `payment_id` | Payment transaction identifier |
| `bill_id` | Bill reference |
| `payment_date` | Actual payment transaction date; used for monthly collections and Payment Year |
| `payment_amount` | Transaction amount |
| `payment_method` | Method such as Check, Insurance EFT, ACH, Card, or Cash |
| `payment_status` | Status such as Posted, Pending, or Reversed |
| `reference_code` | Payment reference value |

Calculated columns used: `Payment Month Short`, `Payment Month Number`, and `Payment Year`.

## Known completeness notes

- Appointment `patient_id`, `doctor_id`, `appointment_date`, and `appointment_status` had zero missing values in the validation query.
- The appointment booking channel contains 20 blank values, represented as `Unknown` in the report.
- The patient insurance plan contains 18 blank values, represented as `Unknown` in the report.
- Original source columns remain intact; display columns are used to label missing categories in visuals.

For the authoritative column definitions, data types, and constraints, use `SQL/01_schema.sql`.
