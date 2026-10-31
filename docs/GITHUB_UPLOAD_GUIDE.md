# GitHub Upload Guide

This guide assumes the project folder already contains the source data, Power BI report, and original SQL scripts on your computer.

## 1. Review data privacy before creating a public repository

This is healthcare-themed data. The `.gitignore` excludes `/Data/*.csv` and `/Power BI/*.pbix` by default because those files can contain row-level data. Before changing that setting, confirm that:

- The dataset is synthetic or properly de-identified.
- You have permission to publish it.
- The `.pbix` does not contain hidden confidential data, credentials, or sensitive model content.
- The SQL load script does not expose personal local file paths or credentials.

If you cannot confirm those points, leave the CSV and PBIX files excluded. The dashboard screenshots, PDF, SQL documentation, and project explanation can still demonstrate the project.

## 2. Review the folder

The root folder should contain:

- `README.md`
- `.gitignore`
- `Healthcare Operations Analytics Dashboard.pdf`
- `Dashboard Screenshots/`
- `Data/`
- `Power BI/`
- `SQL/`
- `docs/`

Keep your existing `Data/*.csv`, `Power BI/*.pbix`, `SQL/01_schema.sql`, and `SQL/02_load_data.sql` files in their current folders.

## 3. Create the GitHub repository

1. Sign in to GitHub.
2. Create a new repository named `healthcare-operations-analytics`.
3. Add a short description such as: `Healthcare operations, billing, and payment analytics using MySQL and Power BI.`
4. Choose Public only if the material you plan to upload is cleared for public release; otherwise choose Private.
5. Do not initialize a second README on GitHub if you will push the local project folder that already has one.

## 4. Initialize and push from the project folder

Open PowerShell or Git Bash in the project root. Review `git status` and confirm excluded data files are not staged.

```bash
git init
git branch -M main
git add README.md .gitignore "Healthcare Operations Analytics Dashboard.pdf" "Dashboard Screenshots" docs SQL
# Review the staged files before committing:
git status
git commit -m "Add healthcare operations analytics portfolio project"
git remote add origin https://github.com/YOUR-USERNAME/healthcare-operations-analytics.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username. Add the CSV and `.pbix` files only if they have passed the privacy and permission checks above and after you update `.gitignore` intentionally.

## 5. Check the repository after upload

- Open the repository page and confirm the README renders correctly.
- Open each dashboard screenshot from the README.
- Confirm the PDF opens.
- Confirm no passwords, connection strings, local machine paths, or patient-level data were accidentally committed.
- Keep the local `.pbix` and CSV files backed up separately.

## 6. Add the project to your portfolio

Use the text in `PORTFOLIO_DESCRIPTION.md` for your LinkedIn Projects section or portfolio website. Link to the GitHub repository and the PDF dashboard preview.
