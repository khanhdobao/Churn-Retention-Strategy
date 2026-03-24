
-- ================================
-- STEP 4: Action + ROI Layer
-- ================================

WITH value_risk_base AS (
    SELECT *,
        CASE 
            WHEN churn_score > 60 AND cltv >= 3500 THEN 'High Value - High Risk'
            WHEN churn_score <= 60 AND cltv >= 3500 THEN 'High Value - Low Risk'
            WHEN churn_score > 60 AND cltv < 3500 THEN 'Low Value - High Risk'
            ELSE 'Low Value - Low Risk' END AS value_risk_segment
    FROM base_table
)


,agg AS (
    SELECT
    value_risk_segment
    ,internet_type_service
    ,Contract
	,ROUND(COUNT(customerid),2) AS number_customer
    ,ROUND(AVG(tenure_in_months),2) as avg_tenure
	,ROUND(AVG(churn_score), 2) AS avg_churn_score
    ,ROUND(AVG(Monthly_Charge),2) as avg_monthly_charge
	,ROUND(SUM(Monthly_Charge)/COUNT(customerid),2) as avg_revenue_per_customer
	,ROUND(SUM(value_at_risk),2) AS value_at_risk_sum
	
FROM value_risk_base
WHERE 2=2
AND flag_Churn = 0
GROUP BY value_risk_segment, internet_type_service, Contract
ORDER BY value_risk_segment ASC, value_at_risk_sum DESC
)
-----nếu flag churned , cho thấy insight là fiber - mtm - tenure <6 tháng là nhóm high value và đã churn => áp dụng vào nhóm chưa churn và prevent chúng khỏi churn,
--đối với nhóm chưa churn flag churn =0, lấy nhóm high value at risk là nhóm ưu tiên đầu tiên để cứu, nhóm 2 là nhóm prevention có đặc tính từ historical
/* group nhóm : group 1: high value- high risk  + month to month , group 2 : high value- low risk + month-to-month, group 3 : tier 1+2+1/2Y; group 4: mornitor*/
----avg_monthly_charge < 30 → deprioritize
-- ,group_action AS (
SELECT 
		CASE 	WHEN value_risk_segment = 'High Value - High Risk' AND contract = 'Month-to-Month' AND avg_monthly_charge >30 THEN 'P1 - Save Now'
				WHEN value_risk_segment = 'High Value - Low Risk' AND contract = 'Month-to-Month' AND avg_monthly_charge >30  THEN 'P2 - Prevent Churn'
				WHEN value_risk_segment IN ('High Value - High Risk','High Value - Low Risk') AND contract IN ('Two Year','One Year') AND avg_monthly_charge >30   THEN 'P3 - Protect & Upsell'
				ELSE 'P4 - Low Priority' END AS priority_actions,
		,ROUND(SUM(number_customer),2) AS number_customer_
	    ,ROUND(AVG(avg_tenure),2) as avg_tenure_
		,ROUND(AVG(avg_churn_score), 2) AS avg_churn_score_
	    ,ROUND(AVG(avg_monthly_charge),2) as avg_monthly_charge_
		,ROUND(SUM(value_at_risk_sum),2) AS value_at_risk_sum_

		FROM agg
		GROUP BY priority_actions


--------

