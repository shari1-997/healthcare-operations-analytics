# Power BI report

Keep the Power BI Desktop report in this folder with the filename:

`Healthcare Operations Analytics Dashboard.pbix`

The working report is maintained locally by the project owner. It connects to the MySQL database `healthcare_ops` and contains four pages: Overview, Booking & Patient Insights, Billing & Financial Analysis, and Revenue Trends.

Before adding the `.pbix` file to a public GitHub repository, verify that its embedded model does not contain confidential or identifiable patient-level data. The root `.gitignore` excludes `*.pbix` by default for this reason.
