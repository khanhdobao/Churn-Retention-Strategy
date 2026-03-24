---add value at risk metrics into base table

ALTER TABLE base_table ADD COLUMN value_at_risk NUMERIC;

UPDATE base_table
SET value_at_risk = cltv * churn_score / 100.0;

--segmentation x-axis and y-axis

SELECT
   tenure_group
   ,cltv_group
    ,risk_group
   ,COUNT(*) AS total_customers
   ,ROUND(AVG(cltv),2) AS avg_cltv
   ,ROUND(AVG(churn_score),2) AS avg_churn_score
   ,ROUND(SUM(value_at_risk),2) AS total_value_at_risk
   ,ROUND(SUM(value_at_risk) * 1.0 / COUNT(*), 2) AS var_per_customer
FROM base_table
WHERE 2=2
GROUP BY 
    tenure_group,
    cltv_group,
    risk_group
ORDER BY total_value_at_risk DESC;
/* Value at risk is where the scale of money, we can see top of them are 36++ months tenure contribute a large scale, 
with this segment tenure we see high risk and medium/high value to protect. value at risk per customer let tenure comparable across group,
where we can find tenure 0-3 have relative high risk and high value churn
*/
-------------then segment priority
