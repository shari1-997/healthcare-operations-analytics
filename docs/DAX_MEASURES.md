# DAX Measures and Calculated Columns

This reference documents the measures and calculated columns used or confirmed during the dashboard build. Names are shown as used in the Power BI model. Keep numeric measures for calculations and use `FORMAT`-based display measures only in KPI cards.

## Appointments (`healthcare_ops appointments`)

### Total Appointments
```dax
Total Appointments =
COUNTROWS('healthcare_ops appointments')
```

### Completed Appointments
```dax
Completed Appointments =
CALCULATE(
    COUNTROWS('healthcare_ops appointments'),
    'healthcare_ops appointments'[appointment_status] = "Completed"
)
```

### Cancelled Appointments
```dax
Cancelled Appointments =
CALCULATE(
    COUNTROWS('healthcare_ops appointments'),
    'healthcare_ops appointments'[appointment_status] = "Cancelled"
)
```

### No-show Appointments
```dax
No-show Appointments =
CALCULATE(
    COUNTROWS('healthcare_ops appointments'),
    'healthcare_ops appointments'[appointment_status] = "No-show"
)
```

### Appointment Completion Rate
```dax
Appointment Completion Rate =
DIVIDE(
    [Completed Appointments],
    [Total Appointments],
    0
)
```

Format as Percentage with two decimal places in the report.

### Appointment Cancellation Rate
```dax
Appointment Cancellation Rate =
DIVIDE(
    [Cancelled Appointments],
    [Total Appointments],
    0
)
```

Format as Percentage with one decimal place in the report.

### Average Waiting Time
```dax
Average Waiting Time =
AVERAGE(
    'healthcare_ops appointments'[wait_minutes]
)
```

The `AVERAGE` function ignores blank waiting-time values.

### Completed Appointments Display
```dax
Completed Appointments Display =
VAR TotalCompleted = [Completed Appointments]
RETURN
    IF(
        TotalCompleted >= 1000,
        FORMAT(TotalCompleted / 1000, "0.0") & "K",
        FORMAT(TotalCompleted, "#,##0")
    )
```

This is a text display measure for the KPI card; use `[Completed Appointments]` in calculations and charts.

### Appointment Year (calculated column)
```dax
Appointment Year =
YEAR('healthcare_ops appointments'[appointment_date])
```

### Month Short (calculated column)
```dax
Month Short =
FORMAT('healthcare_ops appointments'[appointment_date], "MMM")
```

### Month Number (calculated column)
```dax
Month Number =
MONTH('healthcare_ops appointments'[appointment_date])
```

Sort `Month Short` by `Month Number` so months appear January through December rather than alphabetically.

### Booking Channel Display (calculated column)
```dax
Booking Channel Display =
VAR ChannelValue =
    'healthcare_ops appointments'[booking_channel]
RETURN
    IF(
        ISBLANK(ChannelValue) || ChannelValue = "",
        "Unknown",
        ChannelValue
    )
```

The original `booking_channel` column is retained; this column replaces blank labels in the visual.

## Patients (`healthcare_ops patients`)

### Total Patients
```dax
Total Patients =
DISTINCTCOUNT(
    'healthcare_ops patients'[patient_id]
)
```

### Total Patients Display
```dax
Total Patients Display =
FORMAT(
    [Total Patients],
    "#,##0"
)
```

Use `[Total Patients]` for numeric calculations and charts. The display version is text and is intended for a KPI card.

### Insurance Plan Display (calculated column)
```dax
Insurance Plan Display =
VAR PlanValue =
    'healthcare_ops patients'[insurance_plan]
RETURN
    IF(
        ISBLANK(PlanValue) || PlanValue = "",
        "Unknown",
        PlanValue
    )
```

Patient count visuals are labelled **All-Time** because they represent the entire patient table, not only patients with an appointment in the selected year.

## Billing (`healthcare_ops billing`)

### Total Billed Amount
```dax
Total Billed Amount =
SUM(
    'healthcare_ops billing'[net_amount]
)
```

### Total Bills
```dax
Total Bills =
COUNTROWS(
    'healthcare_ops billing'
)
```

### Outstanding Balance
```dax
Outstanding Balance =
[Total Billed Amount] - [Posted Payment Amount]
```

For this dataset, MySQL bill-level reconciliation found no overpaid bills, so the aggregate difference matches the sum of each bill's positive remaining balance.

### Payment Collection Rate
```dax
Payment Collection Rate =
DIVIDE(
    [Posted Payment Amount],
    [Total Billed Amount],
    0
)
```

Format as Percentage with one decimal place.

### Bill Month Short (calculated column)
```dax
Bill Month Short =
FORMAT('healthcare_ops billing'[bill_date], "MMM")
```

### Bill Month Number (calculated column)
```dax
Bill Month Number =
MONTH('healthcare_ops billing'[bill_date])
```

### Bill Year (calculated column)
```dax
Bill Year =
YEAR('healthcare_ops billing'[bill_date])
```

Sort `Bill Month Short` by `Bill Month Number`.

## Payments (`healthcare_ops payments`)

### Total Payment Amount
```dax
Total Payment Amount =
SUM(
    'healthcare_ops payments'[payment_amount]
)
```

This includes all payment statuses represented in the source table.

### Posted Payment Amount
```dax
Posted Payment Amount =
CALCULATE(
    SUM('healthcare_ops payments'[payment_amount]),
    'healthcare_ops payments'[payment_status] = "Posted"
)
```

This measure includes only `Posted` payment rows.

### Payment Month Short (calculated column)
```dax
Payment Month Short =
FORMAT('healthcare_ops payments'[payment_date], "MMM")
```

### Payment Month Number (calculated column)
```dax
Payment Month Number =
MONTH('healthcare_ops payments'[payment_date])
```

### Payment Year (calculated column)
```dax
Payment Year =
YEAR('healthcare_ops payments'[payment_date])
```

Sort `Payment Month Short` by `Payment Month Number`.

## Date interpretation in the Revenue Trends page

- **Monthly Payment Collections** uses payment month/year and the posted-payment measure. It groups by the actual `payment_date`.
- **Monthly Billed vs Posted Payments** uses bill month/year. Posted payments are associated with bills through `bill_id`, so the chart compares the amount billed in each bill month with posted payments linked to those bills. It is not a chart of cash receipts by payment month.

## Formatting conventions

- Percentages: 1-2 decimal places as appropriate.
- Waiting time: minutes, one decimal place.
- Full counts: use whole numbers or abbreviated K labels depending on the visual.
- Currency-like amounts: use numeric measures for calculation; K/M display units are presentation-only.
