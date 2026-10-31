-- Healthcare Operations Analytics: repeatable data-quality checks
-- Schema: healthcare_ops
-- Run after executing 01_schema.sql and 02_load_data.sql.

USE healthcare_ops;

-- 1) Row counts: expected counts are shown in the result for comparison.
SELECT 'departments' AS table_name, COUNT(*) AS actual_rows, 10 AS expected_rows FROM departments
UNION ALL
SELECT 'doctors', COUNT(*), 60 FROM doctors
UNION ALL
SELECT 'patients', COUNT(*), 1500 FROM patients
UNION ALL
SELECT 'appointments', COUNT(*), 8000 FROM appointments
UNION ALL
SELECT 'billing', COUNT(*), 5760 FROM billing
UNION ALL
SELECT 'payments', COUNT(*), 3470 FROM payments;

-- 2) Required appointment fields.
SELECT
    COUNT(*) AS total_appointments,
    SUM(patient_id IS NULL) AS missing_patient_ids,
    SUM(doctor_id IS NULL) AS missing_doctor_ids,
    SUM(appointment_date IS NULL) AS missing_appointment_dates,
    SUM(appointment_status IS NULL) AS missing_appointment_statuses
FROM appointments;

-- 3) Appointment foreign-key/reference checks.
SELECT 'Missing patients' AS issue, COUNT(*) AS affected_rows
FROM appointments a
LEFT JOIN patients p ON a.patient_id = p.patient_id
WHERE p.patient_id IS NULL
UNION ALL
SELECT 'Missing doctors', COUNT(*)
FROM appointments a
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.doctor_id IS NULL
UNION ALL
SELECT 'Missing departments', COUNT(*)
FROM appointments a
LEFT JOIN departments d ON a.department_id = d.department_id
WHERE d.department_id IS NULL;

-- 4) Billing key uniqueness and appointment references.
SELECT
    COUNT(*) AS total_bills,
    COUNT(DISTINCT bill_id) AS distinct_bill_ids,
    COUNT(DISTINCT appointment_id) AS distinct_appointment_ids,
    COUNT(*) - COUNT(DISTINCT bill_id) AS duplicate_bill_id_rows,
    COUNT(*) - COUNT(DISTINCT appointment_id) AS duplicate_appointment_id_rows
FROM billing;

SELECT
    COUNT(*) AS total_bills,
    SUM(a.appointment_id IS NULL) AS unmatched_appointments
FROM billing b
LEFT JOIN appointments a ON b.appointment_id = a.appointment_id;

-- 5) Payment-to-billing references.
SELECT
    COUNT(*) AS total_payments,
    SUM(p.bill_id IS NULL) AS missing_bill_ids,
    SUM(p.bill_id IS NOT NULL AND b.bill_id IS NULL) AS unmatched_bill_ids
FROM payments p
LEFT JOIN billing b ON p.bill_id = b.bill_id;

-- 6) Total payment amount by payment status.
SELECT
    payment_status,
    COUNT(*) AS payment_count,
    SUM(payment_amount) AS payment_amount
FROM payments
GROUP BY payment_status
ORDER BY payment_status;

-- 7) Bill-level financial reconciliation.
-- Aggregate posted payments by bill_id first, so multiple payment rows do not
-- multiply billing rows during the join.
SELECT
    COUNT(*) AS total_bills,
    SUM(b.net_amount) AS total_billed,
    SUM(COALESCE(p.posted_amount, 0)) AS total_posted,
    SUM(GREATEST(b.net_amount - COALESCE(p.posted_amount, 0), 0)) AS actual_outstanding,
    SUM(GREATEST(COALESCE(p.posted_amount, 0) - b.net_amount, 0)) AS overpaid_amount
FROM billing b
LEFT JOIN (
    SELECT
        bill_id,
        SUM(payment_amount) AS posted_amount
    FROM payments
    WHERE payment_status = 'Posted'
    GROUP BY bill_id
) p ON b.bill_id = p.bill_id;

-- 8) Overall recorded payments versus posted payments.
SELECT
    SUM(payment_amount) AS total_recorded_payments,
    SUM(CASE WHEN payment_status = 'Posted' THEN payment_amount ELSE 0 END) AS total_posted_payments
FROM payments;
