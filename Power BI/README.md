# Power BI report

This folder contains the interactive Power BI Desktop report:

`Healthcare Operations Analytics Dashboard.pbix`

The report connects to the MySQL schema `healthcare_ops` and contains four pages:

1. Overview
2. Booking & Patient Insights
3. Billing & Financial Analysis
4. Revenue Trends

The report uses the six synthetic CSV datasets included in the repository. The project owner confirms the embedded model data is fake/synthetic and prepared for this portfolio project.

## Open the report

1. Install Power BI Desktop.
2. Install the Oracle MySQL Connector/NET driver required by the Power BI MySQL connector.
3. Ensure the `healthcare_ops` schema is loaded in your local MySQL instance.
4. Open the PBIX file.
5. Connect using your own local MySQL credentials and refresh the model.

Do not save database passwords, private connection details, or real patient data in the report or repository. The PDF and screenshots in the project root and `Dashboard Screenshots/` provide static previews.
