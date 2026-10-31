# GitHub publishing and data-safety notes

This repository is public and includes the synthetic CSV datasets, Power BI Desktop report, SQL scripts, dashboard screenshots, PDF export, and project documentation.

## Data included in this portfolio

The project owner confirms that the six CSV datasets and the data embedded in the PBIX report are fake/synthetic records created for this portfolio project. The repository includes:

- `Data/` - six CSV files, 18,800 rows in total.
- `Power BI/` - the four-page Power BI Desktop report.
- `SQL/` - schema creation, data loading, and repeatable quality checks.
- `Dashboard Screenshots/` - four page previews.
- `docs/` - data dictionary, model, DAX measures, validation notes, and portfolio text.

## Before making future changes

- Do not add real patient records, confidential transactions, passwords, database credentials, API keys, or private connection strings.
- Keep `.env`, credential files, temporary files, and Power BI autorecovery files out of Git.
- Review `git status` before committing and confirm that only intended files are staged.
- If you replace the supplied synthetic data, independently verify that the replacement data is safe and authorized for public release.
- Update local file paths in `SQL/02_load_data.sql` before running it on another computer. Do not commit personal machine paths.

## Reproducing the project

1. Clone or download this repository.
2. Create the `healthcare_ops` schema by running `SQL/01_schema.sql` in MySQL Workbench.
3. Update the generic path placeholder in `SQL/02_load_data.sql` to the local `Data/` folder, then run the import script. Enable local-infile support in the client connection if required.
4. Run `SQL/03_data_quality_checks.sql` and compare the results with `docs/DATA_QUALITY_AND_VALIDATION.md`.
5. Install Power BI Desktop and the Oracle MySQL Connector/NET driver.
6. Open the PBIX file from `Power BI/`, connect to your local `healthcare_ops` database, and refresh the report.

See the root `README.md` for the project overview and `docs/PORTFOLIO_DESCRIPTION.md` for a concise project summary.
