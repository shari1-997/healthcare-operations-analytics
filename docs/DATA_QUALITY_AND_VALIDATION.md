# Data Quality and Validation

Validation was performed in MySQL Workbench after CSV import and again before the Power BI model was treated as complete.

## Row counts

| Table | Expected / validated rows |
|---|---:|
| `departments` | 10 |
| `doctors` | 60 |
| `patients` | 1,500 |
| `appointments` | 8,000 |
| `billing` | 5,760 |
| `payments` | 3,470 |
| **Total across six tables** | **18,800** |

## Key and relationship checks

| Check | Validated result |
|---|---:|
| Missing appointment patient IDs | 0 |
| Missing appointment doctor IDs | 0 |
| Missing appointment dates | 0 |
| Missing appointment statuses | 0 |
| Appointment rows with unmatched patient references | 0 |
| Appointment rows with unmatched doctor references | 0 |
| Appointment rows with unmatched department references | 0 |
| Billing rows with unmatched appointment references | 0 of 5,760 |
| Duplicate bill IDs | 0 |
| Duplicate appointment IDs in billing | 0 |
| Payment rows with missing bill IDs | 0 |
| Payment rows with unmatched bill IDs | 0 |

There are 20 blank booking channels and 18 blank insurance-plan values. They are retained and displayed as `Unknown` by dedicated Power BI calculated columns.

## Financial reconciliation

A MySQL reconciliation grouped posted payments by `bill_id` before joining to billing, avoiding multiplication of bill rows when a bill has multiple payment transactions.

| Metric | Validated value |
|---|---:|
| Total bills | 5,760 |
| Total billed (`SUM(net_amount)`) | 1,513,480.00 |
| Posted payment amount | 649,224.08 |
| Outstanding balance | 864,255.92 |
| Overpaid amount | 0.00 |
| Total recorded payment transactions | 710,014.08 |

For each bill, the validation calculated the remaining amount as `GREATEST(net_amount - posted_amount, 0)`. Because the overpaid amount was zero in this dataset, the sum of bill-level outstanding amounts matched the aggregate difference between billed and posted amounts.

Payment collection rate:

```text
649,224.08 / 1,513,480.00 = approximately 42.9%
```

## Repeatable checks

Run `SQL/03_data_quality_checks.sql` after loading or refreshing the source tables. It contains row-count, null-key, orphan-reference, duplicate-key, and financial reconciliation queries.

## Scope and limitations

These checks demonstrate consistency within the supplied dataset. They do not establish that the dataset represents a real provider, that all business rules are clinically appropriate, or that the files are safe for public disclosure. Confirm data provenance and privacy status before publishing row-level data.
