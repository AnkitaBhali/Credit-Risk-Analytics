Credit Risk Analytics | Excel, MySQL & Power BI

📌 Project Overview

This project analyzes borrower information and loan applications to identify credit risk patterns, understand loan default behavior, and generate insights that can support data-driven lending decisions.

Using Excel, MySQL, and Power BI, I performed data analysis, explored borrower characteristics, examined loan distribution, and developed interactive dashboards to highlight potential risk factors.

🎯 Project Objectives

- Analyze loan applications and borrower characteristics.
- Measure the overall loan default rate.
- Examine credit risk across loan grades and purposes.
- Analyze loan applications by age group, income, employment length, and home ownership.
- Identify patterns in interest rates and loan amounts.
- Present key findings through interactive Power BI dashboards.

🛠️ Tools & Technologies

- Microsoft Excel: Data inspection, cleaning, analysis, and preliminary exploration.
- MySQL: Data quality checks, exploratory analysis, aggregations, subqueries, CTEs, and window functions.
- Power BI: Interactive dashboards, visualizations, slicers, and DAX measures.
- DAX: KPI calculations and credit risk metrics.

📊 Dataset

The project uses a credit risk dataset containing 32,581 loan records.

Key columns include:

Column| Description
"person_age"| Borrower's age
"person_income"| Annual income
"person_home_ownership"| Home ownership category
"person_emp_length"| Employment length in years
"loan_intent"| Purpose of the loan
"loan_grade"| Assigned loan grade
"loan_amnt"| Loan amount requested
"loan_int_rate"| Loan interest rate
"loan_status"| Loan status: 0 or 1, according to the dataset's coding
"cb_person_default_on_file"| Historical default indicator
"cb_person_cred_hist_length"| Length of credit history



🔍 Project Workflow

1. Excel Analysis

- Inspected the dataset and reviewed column values.
- Examined borrower and loan characteristics.
- Used formulas and summary analysis to explore credit risk patterns.

2. SQL Analysis — MySQL

Created a single SQL file containing queries organized into sections for:

- Data quality checks and validation.
- Exploratory data analysis (EDA).
- Loan default and risk analysis.
- Loan portfolio analysis.
- CTEs, subqueries, aggregations, and window functions.
- Business insights and summary metrics.

3. Power BI Dashboard

Developed an interactive, three-page dashboard to explore credit risk from different perspectives.

Page 1: Credit Risk Overview

- Total loan applications.
- Defaulted and non-defaulted loans.
- Default rate.
- Loan amount distribution by grade.
- Applications by loan purpose.
- Interactive slicers for exploring the data.

Page 2: Borrower & Loan Analysis

- Loan applications by purpose.
- Average interest rate by loan grade.
- Applications by age group.
- Borrower income and loan amount comparison.
- Analysis by home ownership.

Page 3: Risk Drivers & Business Insights

- Default rate by loan grade.
- Default patterns by loan purpose and home ownership.
- Loan amount and interest rate analysis.
- Summary of key findings and potential lending-risk indicators.

📈 Key Business Questions

- What proportion of loan applications are classified as defaults?
- Which loan grades have higher default rates?
- Which loan purposes account for the largest number of applications?
- How do borrower income and home ownership relate to loan patterns?
- How do interest rates and loan amounts vary across loan grades?
- Which borrower or loan segments may warrant closer risk assessment?

💡 Business Value

This analysis demonstrates how data analytics can help lending teams:

- Monitor portfolio-level credit risk.
- Compare default patterns across borrower and loan segments.
- Identify areas for further credit-risk investigation.
- Support evidence-based lending and portfolio monitoring decisions.

📁 Repository Structure

credit-risk-analytics/
│
├── README.md
├── excel/
│   └── credit_risk_dataset.xlsx
├── sql/
│   └── loan_credit.sql
├── powerbi/
│   └── LOAN CREDIT.pbix
└── images/
    ├── Portfolio_Overview.png
    ├── Borrower_Analysis.png
    └── Risk_Drivers.png



🧠 Skills Demonstrated

- Data cleaning and validation
- Exploratory data analysis (EDA)
- SQL querying and aggregation
- CTEs, subqueries, and window functions
- Credit risk and portfolio analysis
- DAX measures and KPI development
- Interactive dashboard development
- Data visualization and business insight communication

👩‍💻 Conclusion

This project demonstrates my ability to analyze structured financial data using Excel, MySQL, and Power BI. It combines SQL-based investigation with interactive visualization to explore loan portfolio characteristics, default patterns, and potential credit-risk indicators.

The project strengthened my practical skills in data analysis, reporting, and communicating insights for business decision-making.


