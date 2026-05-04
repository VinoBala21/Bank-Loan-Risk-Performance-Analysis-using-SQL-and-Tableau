-- Dashboard
-- 1 Total Applications
SELECT COUNT(id) AS Total_Applications 
FROM financial_loan;
 
--  2.MTD (Month-to-Date) — December
SELECT COUNT(id) AS MTD_Total_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 12;
 
-- 3.PMTD (Previous Month-to-Date) — November
SELECT COUNT(id) AS PMTD_Total_Applications 
FROM financial_loan
WHERE MONTH(issue_date) = 11;
 
-- 4 Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM financial_loan;
 
-- 5  MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12;
 
-- 6 PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 11;
 
-- 7 Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received 
FROM financial_loan;
 
-- 8 MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received 
FROM financial_loan
WHERE MONTH(issue_date) = 12;
 
-- 9 PMTD Total Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received 
FROM financial_loan
WHERE MONTH(issue_date) = 11;
  
-- 10 Average Interest Rate
SELECT ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate 
FROM financial_loan;
 
-- 11 MTD Average Interest Rate
SELECT ROUND(AVG(int_rate) * 100, 2) AS MTD_Avg_Interest_Rate 
FROM financial_loan
WHERE MONTH(issue_date) = 12;
 
-- 12 PMTD Average Interest Rate
SELECT ROUND(AVG(int_rate) * 100, 2) AS PMTD_Avg_Interest_Rate 
FROM financial_loan
WHERE MONTH(issue_date) = 11;
 
-- 13 Average DTI
SELECT ROUND(AVG(dti) * 100, 2) AS Avg_DTI 
FROM financial_loan;
 
-- 14 MTD Average DTI
SELECT ROUND(AVG(dti) * 100, 2) AS MTD_Avg_DTI 
FROM financial_loan
WHERE MONTH(issue_date) = 12;
 
-- 15 PMTD Average DTI
SELECT ROUND(AVG(dti) * 100, 2) AS PMTD_Avg_DTI 
FROM financial_loan
WHERE MONTH(issue_date) = 11;
 

-- 16 Good Loan Percentage
SELECT
    ROUND(
        COUNT(CASE WHEN loan_status = 'Fully Paid' 
                     OR loan_status = 'Current' 
              THEN id END) * 100.0 / COUNT(id)
    , 2) AS Good_Loan_Percentage
FROM financial_loan;
 
--  17 Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications 
FROM financial_loan
WHERE loan_status = 'Fully Paid' 
   OR loan_status = 'Current';
 
--  18 Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount 
FROM financial_loan
WHERE loan_status = 'Fully Paid' 
   OR loan_status = 'Current';
 
--  19 Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received 
FROM financial_loan
WHERE loan_status = 'Fully Paid' 
   OR loan_status = 'Current';
 
 
-- 20 Bad Loan Percentage
SELECT
    ROUND(
        COUNT(CASE WHEN loan_status = 'Charged Off' 
              THEN id END) * 100.0 / COUNT(id)
    , 2) AS Bad_Loan_Percentage
FROM financial_loan;
 
-- 21 Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM financial_loan
WHERE loan_status = 'Charged Off';
 
-- 22 Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount 
FROM financial_loan
WHERE loan_status = 'Charged Off';
 
-- 23 Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received 
FROM financial_loan
WHERE loan_status = 'Charged Off';
 

-- 24 Full Loan Status Breakdown
SELECT
    loan_status,
    COUNT(id)                    AS Loan_Count,
    SUM(total_payment)           AS Total_Amount_Received,
    SUM(loan_amount)             AS Total_Funded_Amount,
    ROUND(AVG(int_rate * 100),2) AS Avg_Interest_Rate,
    ROUND(AVG(dti * 100), 2)     AS Avg_DTI
FROM financial_loan
GROUP BY loan_status;
 
-- 25 MTD Loan Status
SELECT
    loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount)   AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;
 

--  26 ── BY MONTH ─────────────────────────────────────────────────
SELECT
    MONTH(issue_date)                    AS Month_Number,
    MONTHNAME(issue_date)                AS Month_Name,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);
 
-- 27  ── BY STATE ─────────────────────────────────────────────────
SELECT
    address_state                        AS State,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;
 
--  28 ── BY TERM ──────────────────────────────────────────────────
SELECT
    term                                 AS Loan_Term,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;
 
--  29 ── BY EMPLOYEE LENGTH ───────────────────────────────────────
SELECT
    emp_length                           AS Employee_Length,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;
 
-- 30 ── BY PURPOSE ───────────────────────────────────────────────
SELECT
    purpose                              AS Loan_Purpose,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC;
 
-- 31 ── BY HOME OWNERSHIP ────────────────────────────────────────
SELECT
    home_ownership                       AS Home_Ownership,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;
 
--  32 ── FILTER EXAMPLE: Grade A Only ─────────────────────────────
SELECT
    purpose                              AS Loan_Purpose,
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;
-- BUSINESS PROBLEM --
-- 1 What is the overall lending performance of the bank?
SELECT
    COUNT(id)                            AS Total_Loan_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(AVG(dti) * 100, 2)             AS Avg_DTI
FROM financial_loan;
-- 2 How does this month's performance compare to last month?
SELECT
    'MTD (Dec)'  AS period,
    COUNT(id)                            AS Loan_Applications,
    SUM(loan_amount)                     AS Funded_Amount,
    SUM(total_payment)                   AS Amount_Received,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(AVG(dti) * 100, 2)             AS Avg_DTI
FROM financial_loan
WHERE MONTH(issue_date) = 12
 
UNION ALL
 
SELECT
    'PMTD (Nov)' AS period,
    COUNT(id),
    SUM(loan_amount),
    SUM(total_payment),
    ROUND(AVG(int_rate) * 100, 2),
    ROUND(AVG(dti) * 100, 2)
FROM financial_loan
WHERE MONTH(issue_date) = 11;
-- 3 What percentage of loans are Good vs Bad?
SELECT
    ROUND(COUNT(CASE WHEN loan_status IN ('Fully Paid','Current')
                THEN id END) * 100.0 / COUNT(id), 2)   AS Good_Loan_Pct,
    ROUND(COUNT(CASE WHEN loan_status = 'Charged Off'
                THEN id END) * 100.0 / COUNT(id), 2)   AS Bad_Loan_Pct,
    COUNT(CASE WHEN loan_status IN ('Fully Paid','Current')
               THEN id END)                             AS Good_Loan_Count,
    COUNT(CASE WHEN loan_status = 'Charged Off'
               THEN id END)                             AS Bad_Loan_Count,
    SUM(CASE WHEN loan_status IN ('Fully Paid','Current')
             THEN loan_amount ELSE 0 END)               AS Good_Loan_Funded,
    SUM(CASE WHEN loan_status = 'Charged Off'
             THEN loan_amount ELSE 0 END)               AS Bad_Loan_Funded
FROM financial_loan;
-- 4 What is the loan performance breakdown by loan status?
SELECT
    loan_status,
    COUNT(id)                            AS Loan_Count,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received,
    SUM(total_payment) - SUM(loan_amount) AS Net_Return,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(AVG(dti) * 100, 2)             AS Avg_DTI
FROM financial_loan
GROUP BY loan_status
ORDER BY Loan_Count DESC;
-- 5 Which months have the highest loan applications and funding?
SELECT
    MONTH(issue_date)                    AS Month_Number,
    MONTHNAME(issue_date)                AS Month_Name,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate
FROM financial_loan
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);
-- 6 Which states generate the most loan applications and revenue?
SELECT
    address_state                        AS State,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END)          AS Bad_Loans
FROM financial_loan
GROUP BY address_state
ORDER BY Total_Funded_Amount DESC
LIMIT 10;
-- 7 Which loan purpose has the highest default (Charged Off) rate?
SELECT
    purpose                              AS Loan_Purpose,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END)          AS Charged_Off_Count,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY purpose
ORDER BY Default_Rate_Pct DESC;
-- 8 How does employment length affect loan default rate?
SELECT
    emp_length                           AS Employment_Length,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END)          AS Defaults,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY emp_length
ORDER BY Total_Applications DESC;
-- 9 Which loan grade and sub-grade carry the highest risk?
SELECT
    grade,
    sub_grade,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(AVG(dti) * 100, 2)             AS Avg_DTI,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade;
-- 10 How does home ownership status affect loan behavior?
SELECT
    home_ownership                       AS Home_Ownership,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    SUM(total_payment)                   AS Total_Amount_Received,
    ROUND(AVG(loan_amount), 2)           AS Avg_Loan_Amount,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY home_ownership
ORDER BY Total_Applications DESC;
-- 11 What is the relationship between loan term and default rate?
SELECT
    TRIM(term)                           AS Loan_Term,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(AVG(loan_amount), 2)           AS Avg_Loan_Amount,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY TRIM(term)
ORDER BY Loan_Term;
-- 12 What is the DTI distribution among Good vs Bad loan borrowers?
SELECT
    loan_status,
    ROUND(AVG(dti) * 100, 2)             AS Avg_DTI,
    ROUND(AVG(annual_income), 2)         AS Avg_Annual_Income,
    ROUND(AVG(loan_amount), 2)           AS Avg_Loan_Amount,
    ROUND(AVG(installment), 2)           AS Avg_Monthly_Installment,
    COUNT(id)                            AS Total_Borrowers,
    CASE
        WHEN AVG(dti) * 100 > 20 THEN 'High Risk DTI'
        WHEN AVG(dti) * 100 > 15 THEN 'Medium Risk DTI'
        ELSE                           'Low Risk DTI'
    END                                  AS DTI_Risk_Level
FROM financial_loan
GROUP BY loan_status;
-- 13 Which verification status has the lowest default rate?
SELECT
    verification_status                  AS Verification_Status,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(AVG(annual_income), 2)         AS Avg_Annual_Income,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY verification_status
ORDER BY Default_Rate_Pct ASC;
-- 14 What is the annual income distribution of defaulted borrowers?
SELECT
    CASE
        WHEN annual_income < 30000  THEN 'Low Income (<30K)'
        WHEN annual_income < 60000  THEN 'Lower-Mid (30K-60K)'
        WHEN annual_income < 100000 THEN 'Mid Income (60K-100K)'
        WHEN annual_income < 150000 THEN 'Upper-Mid (100K-150K)'
        ELSE                             'High Income (150K+)'
    END                                  AS Income_Bracket,
    COUNT(id)                            AS Total_Applications,
    SUM(loan_amount)                     AS Total_Funded_Amount,
    ROUND(AVG(loan_amount), 2)           AS Avg_Loan_Amount,
    ROUND(SUM(CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END) * 100.0
             / COUNT(id), 2)             AS Default_Rate_Pct
FROM financial_loan
GROUP BY Income_Bracket
ORDER BY Default_Rate_Pct DESC;
-- 15 What is the bank's net profit/loss from Good vs Bad loans?
WITH loan_performance AS (
    SELECT
        CASE
            WHEN loan_status IN ('Fully Paid', 'Current') THEN 'Good Loan'
            WHEN loan_status = 'Charged Off'              THEN 'Bad Loan'
            ELSE                                               'Other'
        END                              AS loan_category,
        loan_amount,
        total_payment,
        int_rate
    FROM financial_loan
)
SELECT
    loan_category,
    COUNT(*)                             AS Total_Loans,
    SUM(loan_amount)                     AS Total_Funded,
    SUM(total_payment)                   AS Total_Received,
    SUM(total_payment - loan_amount)     AS Net_Return,
    ROUND(AVG(int_rate) * 100, 2)        AS Avg_Interest_Rate,
    ROUND(SUM(total_payment - loan_amount) * 100.0
          / SUM(loan_amount), 2)         AS Return_On_Loan_Pct
FROM loan_performance
GROUP BY loan_category
ORDER BY Net_Return DESC;






