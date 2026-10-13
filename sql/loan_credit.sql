create database loan_risk_portfolio;
use loan_risk_portfolio;

create table credit_risk_dataset(
 person_age INT,
 person_income BIGINT,
 person_home_ownership VARCHAR(20),
 person_emp_length DECIMAL(5,2),
 loan_intent VARCHAR(30),
 loan_grade VARCHAR(5),
 loan_amnt INT,
 loan_int_rate DECIMAL(5,2),
 loan_status TINYINT,
 loan_percent_income DECIMAL(6,4),
 cb_person_default_on_file CHAR(1),
 cb_person_cred_hist_length int,
 age_group VARCHAR(10),
 income_band VARCHAR(20),
 employment_length_band VARCHAR(20),
 loan_risk_category VARCHAR(20)
); 
 
describe credit_risk_dataset; 

ALTER TABLE CREDIT_RISK_DATASET
 DROP COLUMN `MYUNKNOWNCOLUMN`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[0]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[1]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[2]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[3]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[4]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[5]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[6]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[7]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[8]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[9]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[10]`,
 DROP COLUMN `MYUNKNOWNCOLUMN_[11]`;
 
 describe credit_risk_dataset;
 
 select * from credit_risk_dataset LIMIT 5;
 
 SELECT COUNT(*) FROM CREDIT_RISK_DATASET;
 
 CREATE DATABASE IF NOT EXISTS credit_risk_db;
USE credit_risk_db;

-- 1. Show all tables
SHOW TABLES;

-- 2. Check table structure
DESCRIBE credit_risk_dataset;

-- 3. Display first 10 records
SELECT *
FROM credit_risk_dataset
LIMIT 10;

-- 4. Count total records
SELECT COUNT(*) AS total_records
FROM credit_risk_dataset;

-- 5. Count distinct loan grades
SELECT COUNT(DISTINCT loan_grade) AS distinct_loan_grades
FROM credit_risk_dataset;

-- 6. List loan purposes
SELECT DISTINCT loan_intent
FROM credit_risk_dataset
ORDER BY loan_intent;

-- 7. Check missing values
SELECT
    SUM(person_age IS NULL) AS missing_age,
    SUM(person_income IS NULL) AS missing_income,
    SUM(person_emp_length IS NULL) AS missing_employment_length,
    SUM(loan_amnt IS NULL) AS missing_loan_amount,
    SUM(loan_int_rate IS NULL) AS missing_interest_rate,
    SUM(loan_grade IS NULL) AS missing_loan_grade,
    SUM(loan_status IS NULL) AS missing_loan_status
FROM credit_risk_dataset;

-- 8. Check loan status values
SELECT loan_status, COUNT(*) AS record_count
FROM credit_risk_dataset
GROUP BY loan_status;

-- 9. Check suspicious ages
SELECT *
FROM credit_risk_dataset
WHERE person_age IS NULL
   OR person_age < 18
   OR person_age > 100;

-- 10. Check invalid loan amounts
SELECT *
FROM credit_risk_dataset
WHERE loan_amnt IS NULL
   OR loan_amnt <= 0;

-- 11. Check invalid interest rates
SELECT *
FROM credit_risk_dataset
WHERE loan_int_rate < 0
   OR loan_int_rate > 100;

-- 12. Check employment length
SELECT *
FROM credit_risk_dataset
WHERE person_emp_length < 0
   OR person_emp_length > 60;

-- 13. Find repeated combinations of loan attributes
SELECT
    person_age,
    person_income,
    loan_amnt,
    loan_grade,
    loan_intent,
    loan_status,
    COUNT(*) AS occurrences
FROM credit_risk_dataset
GROUP BY
    person_age,
    person_income,
    loan_amnt,
    loan_grade,
    loan_intent,
    loan_status
HAVING COUNT(*) > 1;

-- 14. Count distinct combinations across selected columns
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT
        person_age,
        person_income,
        person_home_ownership,
        person_emp_length,
        loan_intent,
        loan_grade,
        loan_amnt,
        loan_int_rate,
        loan_status,
        cb_person_default_on_file,
        cb_person_cred_hist_length
    ) AS distinct_combinations
FROM credit_risk_dataset;



-- 15. Default and non-default percentages
SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM credit_risk_dataset), 2
    ) AS percentage
FROM credit_risk_dataset
GROUP BY loan_status;

-- 16. Applications by loan grade
SELECT loan_grade, COUNT(*) AS total_applications
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY loan_grade;

-- 17. Applications by loan purpose
SELECT loan_intent, COUNT(*) AS total_applications
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY total_applications DESC;

-- 18. Applications by home ownership
SELECT person_home_ownership, COUNT(*) AS total_applications
FROM credit_risk_dataset
GROUP BY person_home_ownership
ORDER BY total_applications DESC;

-- 19. Average annual income
SELECT ROUND(AVG(person_income), 2) AS average_income
FROM credit_risk_dataset;

-- 20. Average loan amount
SELECT ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM credit_risk_dataset;

-- 21. Average interest rate
SELECT ROUND(AVG(loan_int_rate), 2) AS average_interest_rate
FROM credit_risk_dataset;

-- 22. Minimum and maximum loan amount
SELECT
    MIN(loan_amnt) AS minimum_loan,
    MAX(loan_amnt) AS maximum_loan
FROM credit_risk_dataset;

-- 23. Numeric summary
SELECT
    MIN(person_age) AS minimum_age,
    MAX(person_age) AS maximum_age,
    ROUND(AVG(person_age), 2) AS average_age,
    MIN(person_income) AS minimum_income,
    MAX(person_income) AS maximum_income,
    ROUND(AVG(loan_amnt), 2) AS average_loan
FROM credit_risk_dataset;

-- 24. Average loan amount by status
SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM credit_risk_dataset
GROUP BY loan_status;

-- 25. Average income by status
SELECT
    loan_status,
    ROUND(AVG(person_income), 2) AS average_income
FROM credit_risk_dataset
GROUP BY loan_status;

-- 26. Average interest rate by status
SELECT
    loan_status,
    ROUND(AVG(loan_int_rate), 2) AS average_interest_rate
FROM credit_risk_dataset
GROUP BY loan_status;

-- 27. Find borrowers with above-average income
SELECT *
FROM credit_risk_dataset
WHERE person_income > (
    SELECT AVG(person_income)
    FROM credit_risk_dataset
)
ORDER BY person_income DESC;

-- 28. Top 10 largest loans
SELECT
    person_age,
    person_income,
    loan_amnt,
    loan_grade,
    loan_int_rate,
    loan_status
FROM credit_risk_dataset
ORDER BY loan_amnt DESC
LIMIT 10;

USE credit_risk_db;

-- 29. Overall default rate
SELECT
    COUNT(*) AS total_applications,
    SUM(loan_status = 1) AS defaulted_loans,
    ROUND(
        100.0 * SUM(loan_status = 1) / COUNT(*), 2
    ) AS default_rate_pct
FROM credit_risk_dataset;

-- 30. Default rate by loan grade
SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(loan_status = 1) AS defaulted_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY default_rate_pct DESC;

-- 31. Default rate by loan purpose
SELECT
    loan_intent,
    COUNT(*) AS total_loans,
    SUM(loan_status = 1) AS defaulted_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY default_rate_pct DESC;

-- 32. Default rate by home ownership
SELECT
    person_home_ownership,
    COUNT(*) AS total_loans,
    SUM(loan_status = 1) AS defaulted_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY person_home_ownership
ORDER BY default_rate_pct DESC;

-- 33. Default rate by previous default history
SELECT
    cb_person_default_on_file,
    COUNT(*) AS total_loans,
    SUM(loan_status = 1) AS defaulted_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY cb_person_default_on_file;

-- 34. Default rate by employment band
SELECT
    CASE
        WHEN person_emp_length < 2 THEN '0-1 years'
        WHEN person_emp_length < 5 THEN '2-4 years'
        WHEN person_emp_length < 10 THEN '5-9 years'
        ELSE '10+ years'
    END AS employment_band,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
WHERE person_emp_length IS NOT NULL
GROUP BY employment_band
ORDER BY employment_band;

-- 35. Default rate by age group
SELECT
    CASE
        WHEN person_age < 25 THEN 'Under 25'
        WHEN person_age < 35 THEN '25-34'
        WHEN person_age < 45 THEN '35-44'
        WHEN person_age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY age_group;

-- 36. Loan grades above overall default rate
SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_grade
HAVING AVG(loan_status) > (
    SELECT AVG(loan_status)
    FROM credit_risk_dataset
)
ORDER BY default_rate_pct DESC;

-- 37. Default rate by income band
SELECT
    CASE
        WHEN person_income < 30000 THEN 'Low Income'
        WHEN person_income < 60000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS income_band,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
WHERE person_income > 0
GROUP BY income_band
ORDER BY default_rate_pct DESC;

-- 38. Default rate by credit history length
SELECT
    CASE
        WHEN cb_person_cred_hist_length < 3 THEN 'Under 3 years'
        WHEN cb_person_cred_hist_length < 6 THEN '3-5 years'
        WHEN cb_person_cred_hist_length < 10 THEN '6-9 years'
        ELSE '10+ years'
    END AS credit_history_band,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
WHERE cb_person_cred_hist_length IS NOT NULL
GROUP BY credit_history_band;



-- 39. Total loan amount by grade
SELECT loan_grade, SUM(loan_amnt) AS total_loan_amount
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY total_loan_amount DESC;

-- 40. Total loan amount by purpose
SELECT loan_intent, SUM(loan_amnt) AS total_loan_amount
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY total_loan_amount DESC;

-- 41. Average loan amount by grade
SELECT loan_grade, ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY loan_grade;

-- 42. Amount associated with defaulted loans
SELECT SUM(loan_amnt) AS defaulted_loan_amount
FROM credit_risk_dataset
WHERE loan_status = 1;

-- 43. Defaulted loan amount by grade
SELECT
    loan_grade,
    SUM(loan_amnt) AS defaulted_loan_amount
FROM credit_risk_dataset
WHERE loan_status = 1
GROUP BY loan_grade
ORDER BY defaulted_loan_amount DESC;

-- 44. Applications, loan amount and default rate by purpose
SELECT
    loan_intent,
    COUNT(*) AS applications,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY total_loan_amount DESC;

-- 45. Average loan-to-income ratio
SELECT
    ROUND(
        AVG(loan_amnt / NULLIF(person_income, 0)) * 100, 2
    ) AS average_loan_to_income_pct
FROM credit_risk_dataset
WHERE person_income > 0;

-- 46. Loans above average loan amount
SELECT
    person_age,
    person_income,
    loan_amnt,
    loan_grade,
    loan_int_rate,
    loan_status
FROM credit_risk_dataset
WHERE loan_amnt > (
    SELECT AVG(loan_amnt)
    FROM credit_risk_dataset
)
ORDER BY loan_amnt DESC
LIMIT 20;

-- 47. Default rate by interest-rate band
SELECT
    CASE
        WHEN loan_int_rate < 10 THEN 'Low Rate'
        WHEN loan_int_rate < 15 THEN 'Medium Rate'
        ELSE 'High Rate'
    END AS interest_rate_band,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
WHERE loan_int_rate IS NOT NULL
GROUP BY interest_rate_band
ORDER BY default_rate_pct DESC;

-- 48. Loan purpose and grade combination
SELECT
    loan_intent,
    loan_grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_intent, loan_grade
HAVING COUNT(*) >= 100
ORDER BY default_rate_pct DESC;

USE credit_risk_db;

-- 49. Loan grades with more than 1,000 applications
SELECT loan_grade, COUNT(*) AS total_applications
FROM credit_risk_dataset
GROUP BY loan_grade
HAVING COUNT(*) > 1000;

-- 50. Loan purposes with average loan amount above 8,000
SELECT loan_intent, AVG(loan_amnt) AS average_loan_amount
FROM credit_risk_dataset
GROUP BY loan_intent
HAVING AVG(loan_amnt) > 8000;

-- 51. Home ownership groups with default rate above 10%
SELECT
    person_home_ownership,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY person_home_ownership
HAVING AVG(loan_status) > 0.10;

-- 52. Loan grades with average interest rate above 12
SELECT loan_grade, AVG(loan_int_rate) AS average_interest_rate
FROM credit_risk_dataset
GROUP BY loan_grade
HAVING AVG(loan_int_rate) > 12;

-- 53. Loans larger than their grade's average
SELECT
    c.loan_grade,
    c.loan_amnt,
    c.loan_status
FROM credit_risk_dataset c
WHERE c.loan_amnt > (
    SELECT AVG(x.loan_amnt)
    FROM credit_risk_dataset x
    WHERE x.loan_grade = c.loan_grade
);

-- 54. CTE for default rate by grade
WITH risk_summary AS (
    SELECT
        loan_grade,
        COUNT(*) AS total_loans,
        SUM(loan_status = 1) AS defaulted_loans
    FROM credit_risk_dataset
    GROUP BY loan_grade
)
SELECT
    loan_grade,
    total_loans,
    defaulted_loans,
    ROUND(100.0 * defaulted_loans / total_loans, 2) AS default_rate_pct
FROM risk_summary
ORDER BY default_rate_pct DESC;

-- 55. Compare grade default rates with overall rate
WITH overall AS (
    SELECT AVG(loan_status) AS overall_default_rate
    FROM credit_risk_dataset
),
grade_summary AS (
    SELECT loan_grade, COUNT(*) AS total_loans,
           AVG(loan_status) AS grade_default_rate
    FROM credit_risk_dataset
    GROUP BY loan_grade
)
SELECT
    g.loan_grade,
    g.total_loans,
    ROUND(g.grade_default_rate * 100, 2) AS grade_default_pct,
    ROUND(o.overall_default_rate * 100, 2) AS overall_default_pct,
    ROUND(
        (g.grade_default_rate - o.overall_default_rate) * 100, 2
    ) AS difference_percentage_points
FROM grade_summary g
CROSS JOIN overall o
ORDER BY difference_percentage_points DESC;

-- 56. Portfolio share by loan purpose
WITH purpose_summary AS (
    SELECT loan_intent, SUM(loan_amnt) AS purpose_loan_amount
    FROM credit_risk_dataset
    GROUP BY loan_intent
)
SELECT
    loan_intent,
    purpose_loan_amount,
    ROUND(
        100.0 * purpose_loan_amount /
        SUM(purpose_loan_amount) OVER (), 2
    ) AS portfolio_share_pct
FROM purpose_summary
ORDER BY portfolio_share_pct DESC;

-- 57. Rank loan grades by default rate
SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct,
    RANK() OVER (ORDER BY AVG(loan_status) DESC) AS risk_rank
FROM credit_risk_dataset
GROUP BY loan_grade;

-- 58. Rank purposes by loan amount
SELECT
    loan_intent,
    SUM(loan_amnt) AS total_loan_amount,
    DENSE_RANK() OVER (
        ORDER BY SUM(loan_amnt) DESC
    ) AS amount_rank
FROM credit_risk_dataset
GROUP BY loan_intent;

-- 59. Cumulative loan amount by grade
WITH grade_totals AS (
    SELECT loan_grade, SUM(loan_amnt) AS total_loan_amount
    FROM credit_risk_dataset
    GROUP BY loan_grade
)
SELECT
    loan_grade,
    total_loan_amount,
    SUM(total_loan_amount) OVER (
        ORDER BY loan_grade
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_loan_amount
FROM grade_totals
ORDER BY loan_grade;

-- 60. Portfolio contribution by grade
SELECT
    loan_grade,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(
        100.0 * SUM(loan_amnt) /
        SUM(SUM(loan_amnt)) OVER (), 2
    ) AS portfolio_share_pct
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY portfolio_share_pct DESC;

-- 61. Top three grades by default rate
WITH grade_ranking AS (
    SELECT
        loan_grade,
        COUNT(*) AS total_loans,
        AVG(loan_status) AS default_rate,
        DENSE_RANK() OVER (
            ORDER BY AVG(loan_status) DESC
        ) AS risk_rank
    FROM credit_risk_dataset
    GROUP BY loan_grade
)
SELECT
    loan_grade,
    total_loans,
    ROUND(default_rate * 100, 2) AS default_rate_pct,
    risk_rank
FROM grade_ranking
WHERE risk_rank <= 3;

-- 62. Default rate by home ownership and grade
SELECT
    person_home_ownership,
    loan_grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct,
    RANK() OVER (
        PARTITION BY person_home_ownership
        ORDER BY AVG(loan_status) DESC
    ) AS grade_rank
FROM credit_risk_dataset
GROUP BY person_home_ownership, loan_grade;

-- 63. Loan amount compared with grade average
SELECT
    loan_grade,
    loan_amnt,
    AVG(loan_amnt) OVER (
        PARTITION BY loan_grade
    ) AS grade_average_loan,
    loan_amnt - AVG(loan_amnt) OVER (
        PARTITION BY loan_grade
    ) AS difference_from_average
FROM credit_risk_dataset;



-- 64. Purpose with the most defaults
SELECT loan_intent, SUM(loan_status = 1) AS defaulted_loans
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY defaulted_loans DESC
LIMIT 1;

-- 65. Grade with the largest amount associated with defaults
SELECT loan_grade, SUM(loan_amnt) AS defaulted_loan_amount
FROM credit_risk_dataset
WHERE loan_status = 1
GROUP BY loan_grade
ORDER BY defaulted_loan_amount DESC
LIMIT 1;

-- 66. Purpose with highest default rate among groups of at least 100
SELECT
    loan_intent,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_intent
HAVING COUNT(*) >= 100
ORDER BY default_rate_pct DESC
LIMIT 1;

-- 67. Default rates by home ownership and purpose
SELECT
    person_home_ownership,
    loan_intent,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY person_home_ownership, loan_intent
HAVING COUNT(*) >= 100
ORDER BY default_rate_pct DESC;

-- 68. Ten highest-income defaulted records
SELECT
    person_age,
    person_income,
    loan_amnt,
    loan_grade,
    loan_status
FROM credit_risk_dataset
WHERE loan_status = 1
ORDER BY person_income DESC
LIMIT 10;

-- 69. Historical default status and loan grade
SELECT
    cb_person_default_on_file,
    loan_grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY cb_person_default_on_file, loan_grade
ORDER BY cb_person_default_on_file, loan_grade;

-- 70. Consolidated summary for Power BI
SELECT
    loan_grade,
    loan_intent,
    person_home_ownership,
    COUNT(*) AS total_applications,
    SUM(loan_status = 1) AS defaulted_loans,
    SUM(loan_status = 0) AS non_defaulted_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount,
    ROUND(AVG(loan_int_rate), 2) AS average_interest_rate
FROM credit_risk_dataset
GROUP BY
    loan_grade,
    loan_intent,
    person_home_ownership
ORDER BY total_applications DESC;

-- 71. Loan amount by grade and status
SELECT
    loan_grade,
    loan_status,
    COUNT(*) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount
FROM credit_risk_dataset
GROUP BY loan_grade, loan_status
ORDER BY loan_grade, loan_status;

-- 72. Loan applications by age group
SELECT
    CASE
        WHEN person_age < 25 THEN 'Under 25'
        WHEN person_age < 35 THEN '25-34'
        WHEN person_age < 45 THEN '35-44'
        WHEN person_age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_applications
FROM credit_risk_dataset
GROUP BY age_group;

-- 73. Income and loan amount by grade
SELECT
    loan_grade,
    ROUND(AVG(person_income), 2) AS average_income,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY loan_grade;

-- 74. Loan amount by home ownership
SELECT
    person_home_ownership,
    COUNT(*) AS total_applications,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM credit_risk_dataset
GROUP BY person_home_ownership
ORDER BY total_loan_amount DESC;

-- 75. Overall portfolio summary
SELECT
    COUNT(*) AS total_applications,
    SUM(loan_status = 1) AS defaulted_loans,
    SUM(loan_status = 0) AS non_defaulted_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_pct,
    SUM(loan_amnt) AS total_loan_amount,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount,
    ROUND(AVG(person_income), 2) AS average_annual_income,
    ROUND(AVG(loan_int_rate), 2) AS average_interest_rate
FROM credit_risk_dataset;