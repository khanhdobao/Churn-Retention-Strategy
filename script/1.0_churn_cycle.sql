-- 1. View all table
SELECT * FROM telco_demographics; d
SELECT * FROM telco_location; l
SELECT * FROM telco_population; p
SELECT * FROM telco_services; se
SELECT * FROM telco_status; st
SELECT * FROM telco_merge_data; m
SELECT * FROM base_table
----Table analysis data ----
CREATE TABLE base_table AS
(SELECT 
	customerid
	,customer_status
	,churn_value AS flag_churn
	,churn_score
	,tenure_in_months
	, CASE 
		WHEN tenure_in_months <=3 THEN '1.0-3'
		WHEN tenure_in_months <=6 THEN '2.4-6'
		WHEN tenure_in_months <=12 THEN '3.7-12'
		WHEN tenure_in_months <=24 THEN '4.13-24'
		WHEN tenure_in_months <=36 THEN '5.25-36' ELSE '6.36++' END tenure_group
	,contract
	,internet_type AS internet_type_service --none = no use
	,payment_method
	,monthly_charge
	,cltv
	, CASE 
		WHEN cltv < 3500 THEN 'Low Value' ELSE 'High Value' END AS cltv_group
	,CASE 
            WHEN churn_score >= 60 THEN 'High Risk' ELSE 'Low Risk' END AS risk_group
FROM telco_merge_data 
);

--  ## A. Timing (WHEN)
-- At which **tenure stage** does churn peak?
-- Is churn concentrated in early lifecycle or spread out?  

SELECT 
	tenure_group
	,COUNT(customerid) AS total_customers
	,SUM(flag_churn) AS churned_customers
	,ROUND(SUM(flag_churn)*1.0/COUNT(customerid),2) AS churn_rate
FROM base_table 
GROUP BY tenure_group
ORDER BY tenure_group ASC

/* comment: what we saw from this query is churn rate correlate with tenure group, the more customer stay in higher tenure the lower rate the leave us.
the most sensitive group is early stage customer within first 3 months have churn rate in 57%, and the churn risk decline after 6 months.*/

