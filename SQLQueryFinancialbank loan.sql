select * from financial_loan_data_excel

USE [Financial Bank Loan DataBasw];
GO
--Key Performance Indicators (KPIs) Requirements:
##1)Total Loan Applications: We need to calculate the total number of loan applications received during a specified period. Additionally, it is essential to monitor the Month-to-Date (MTD) Loan Applications and track changes Month-over-Month (MoM).

select count( id ) as  Total_Loan_Applications from financial_loan_data_excel

select count( id ) as  PMTD_Total_Loan_Applications from financial_loan_data_excel
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)=2021

--(MTD-PMTD)/PMTD

##2)Total Funded Amount: Understanding the total amount of funds disbursed as loans is crucial. We also want to keep an eye on the MTD Total Funded Amount and analyse the Month-over-Month (MoM) changes in this metric.

SELECT SUM(loan_amount) as MTD_Total_Funded_Amount FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

SELECT SUM(loan_amount) as PMTD_Total_Funded_Amount FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

##3)Total Amount Received: Tracking the total amount received from borrowers is essential for assessing the banks cash flow and loan repayment. We should analyse the Month-to-Date (MTD) Total Amount Received and observe the Month-over-Month (MoM) changes.

SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan_data_excel

--MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 12

--PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 11


##4)Average Interest Rate: Calculating the average interest rate across all loans, MTD, and monitoring the Month-over-Month (MoM) variations in interest rates will provide insights into our lending portfolios overall cost.

SELECT Round(AVG(int_rate),4)*100 AS Avg_Interest_Rate FROM financial_loan_data_excel

--MTD Average Interest
SELECT Round(AVG(int_rate),4)*100  AS MTD_Avg_Interest_Rate FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 12

--PMTD Average Interest
SELECT Round(AVG(int_rate),4)*100  AS PMTD_Avg_Interest_Rate FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 11


##5)Average Debt-to-Income Ratio (DTI): Evaluating the average DTI for our borrowers helps us gauge their financial health. We need to compute the average DTI for all loans, MTD, and track Month-over-Month (MoM) fluctuations.
--Avg DTI

SELECT Round(AVG(dti),4)*100 AS Avg_DTI FROM financial_loan_data_excel

--MTD Avg DTI
SELECT Round(AVG(dti),4)*100 AS MTD_Avg_DTI FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 12

--PMTD Avg DTI
SELECT Round(AVG(dti),4)*100 AS PMTD_Avg_DTI FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 11

##Good Loan v Bad Loan KPI’s
--1)Good Loan Application Percentage: We need to calculate the percentage of loan applications classified as 'Good Loans.' This category includes loans with a loan status of 'Fully Paid' and 'Current.'

select loan_status from financial_loan_data_excel

select (COUNT(case when loan_status ='Fully Paid' or loan_status ='Current' then id END)*100)/COUNT(id) as Good_loan_percentage
from financial_loan_data_excel 


--2)Good Loan Applications: Identifying the total number of loan applications falling under the 'Good Loan' category, which consists of loans with a loan status of 'Fully Paid' and 'Current.'
select COUNT (id) as Good_Loan_Applications
from financial_loan_data_excel
where loan_status = 'Fully Paid' OR loan_status= 'Current'


--3)Good Loan Funded Amount: Determining the total amount of funds disbursed as 'Good Loans.' This includes the principal amounts of loans with a loan status of 'Fully Paid' and 'Current.'
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM financial_loan_data_excel
where loan_status = 'Fully Paid' OR loan_status= 'Current'


--4)Good Loan Total Received Amount: Tracking the total amount received from borrowers for 'Good Loans,' which encompasses all payments made on loans with a loan status of 'Fully Paid' and 'Current.'

SELECT SUM(total_payment) AS Good_Loan_Total_Received_Amount
from financial_loan_data_excel 
where loan_status = 'Fully Paid' OR loan_status= 'Current'

##Bad Loan KPIs:

--1)Bad Loan Application Percentage: Calculating the percentage of loan applications categorized as 'Bad Loans.' This category specifically includes loans with a loan status of 'Charged Off.'
SELECT (count(case when loan_status ='Charged Off' then id END)*100)/
COUNT(id) as Bad_Loan_Application_Percentage 
from financial_loan_data_excel

--2)Bad Loan Applications: Identifying the total number of loan applications categorized as 'Bad Loans,' which consists of loans with a loan status of 'Charged Off.'
SELECT COUNT(id) as Bad_Loan_Applications
from financial_loan_data_excel
where loan_status = 'Charged Off'

--3)Bad Loan Funded Amount: Determining the total amount of funds disbursed as 'Bad Loans.' This comprises the principal amounts of loans with a loan status of 'Charged Off.'
select sum(loan_amount) as Bad_Loan_Funded_Amount
from financial_loan_data_excel
 where loan_status = 'Charged Off'


--4)Bad Loan Total Received Amount: Tracking the total amount received from borrowers for 'Bad Loans,' which includes all payments made on loans with a loan status of 'Charged Off.'

select sum(total_payment) as Bad_Loan_Total_Received_Amount
from financial_loan_data_excel
 where loan_status = 'Charged Off'

 ## LOAN STATUS
	
    SELECT loan_status,
        COUNT(id) AS Total_Loan_applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan_data_excel
    GROUP BY
        loan_status

--You are working as a Data Analyst in a bank.
--Management wants to build a Loan Status Grid View Dashboard to monitor overall loan performance.

--Using the table financial_loan_data_excel, create a SQL query that generates a summary report grouped by loan_status.

--The report should include the following metrics:

--Total Loan Applications

--Total Funded Amount

--Total Amount Received

--Month-to-Date (MTD) Funded Amount

--Month-to-Date (MTD) Amount Received

--Average Interest Rate (in percentage)

--Average Debt-to-Income Ratio (DTI) (in percentage)

--The result should be grouped by loan_status to allow performance comparison across different loan categories (Fully Paid, Current, Charged Off).
        
        SELECT
    loan_status,
    COUNT(*) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    ROUND(AVG(int_rate) * 100, 2) AS Avg_Interest_Rate,
    ROUND(AVG(dti) * 100, 2) AS Avg_DTI
FROM financial_loan_data_excel
GROUP BY loan_status
ORDER BY Total_Loan_Applications DESC;

    --The management team wants to analyze December’s loan performance by loan status.
    --Provide a report showing:
    --Total funded amount
    --Total amount received
    --grouped by loan status for that month.
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan_data_excel
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status        


----B.BANK LOAN REPORT | OVERVIEW
--DASHBOARD 2: OVERVIEW
--In our Bank Loan Report project, we aim to visually represent critical loan-related metrics and trends using a variety of chart types. These charts will provide a clear and insightful view of our lending operations, facilitating data-driven decision-making and enabling us to gain valuable insights into various loan parameters. Below are the specific chart requirements:
--1. Monthly Trends by Issue Date (Line Chart):
--Chart Type: Line Chart
--Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
--X-Axis: Month (based on 'Issue Date')
--Y-Axis: Metrics' Values
--Objective: This line chart will showcase how 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received' vary over time, allowing us to identify seasonality and long-term trends in lending activities.
----MONTH

SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
 FROM financial_loan_data_excel
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--2. Regional Analysis by State (Filled Map):STATE
--Chart Type: Filled Map
--Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
--Geographic Regions: States
--Objective: This filled map will visually represent lending metrics categorized by state, enabling us to identify regions with significant lending activity and assess regional disparities

SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data_excel
GROUP BY address_state
ORDER BY address_state

--3. Loan Term Analysis (Donut Chart):
--Chart Type: Donut Chart
--Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
--Segments: Loan Terms (e.g., 36 months, 60 months)
--Objective: This donut chart will depict loan statistics based on different loan terms, allowing us to understand the distribution of loans across various term lengths.
--TERM

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data_excel
GROUP BY term
ORDER BY term

--4. Employee Length Analysis (Bar Chart):
--Chart Type: Bar Chart
--Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
--X-Axis: Employee Length Categories (e.g., 1 year, 5 years, 10+ years)
--Y-Axis: Metrics' Values
--Objective: This bar chart will illustrate how lending metrics are distributed among borrowers with different employment lengths, helping us assess the impact of employment history on loan applications
--EMPLOYEE LENGTH

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data_excel
GROUP BY emp_length
ORDER BY emp_length

--5. Loan Purpose Breakdown (Bar Chart):
--Chart Type: Bar Chart
--Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
--X-Axis: Loan Purpose Categories (e.g., debt consolidation, credit card refinancing)
--Y-Axis: Metrics' Values
--Objective: This bar chart will provide a visual breakdown of loan metrics based on the stated purposes of loans, aiding in the understanding of the primary reasons borrowers seek financing.
--PURPOSE

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data_excel
GROUP BY purpose
ORDER BY purpose

--6. Home Ownership Analysis (Tree Map):
--Chart Type: Tree Map
--Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
--Hierarchy: Home Ownership Categories (e.g., own, rent, mortgage)
--Objective: This tree map will display loan metrics categorized by different home ownership statuses, allowing for a hierarchical view of how home ownership impacts loan applications and disbursements.
--These diverse chart types will enhance our ability to visualize and communicate loan-related insights effectively, supporting data-driven decisions and strategic planning within our lending operations."
--HOME OWNERSHIP

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data_excel
GROUP BY home_ownership
ORDER BY home_ownership


SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data_excel
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose