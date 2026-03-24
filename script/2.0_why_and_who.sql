--Why do they leave?
----Churn rate by dimension
--- 'base' CTE to unpivot 3 dimensions
WITH base AS (
    SELECT
        tenure_group,
        flag_churn,
        'Contract' AS dimension,
        contract AS segment
    FROM base_table

UNION ALL

    SELECT
        tenure_group,
        flag_churn,
        'Internet' AS dimension,
        internet_type_service AS segment
    FROM base_table

UNION ALL

    SELECT
        tenure_group,
        flag_churn,
        'Payment' AS dimension,
        payment_method AS segment
    FROM base_table
),
-- then agg table to add churn_rate and churn_share by using window function
agg AS (
    SELECT
        tenure_group,
        dimension,
        segment,
        COUNT(*) AS total_customers,
        SUM(flag_churn) AS churned_customers,
        ROUND(AVG(flag_churn), 2) AS churn_rate,
        ROUND(SUM(flag_churn) * 1.0/ SUM(SUM(flag_churn)) OVER (PARTITION BY tenure_group, dimension),2) AS churn_share
    FROM base
    GROUP BY tenure_group, dimension, segment
)
--ranking those dimension
SELECT *
 		,RANK() OVER (PARTITION BY  dimension ORDER BY churn_rate DESC) AS churn_dimension_rank
		,RANK() OVER (PARTITION BY  tenure_group, dimension ORDER BY churn_rate DESC) AS churn_rank
FROM agg
ORDER BY churn_dimension_rank,dimension ASC,churn_rate DESC;
/* comment: with top 1 at each dimesion, we have some findings, contract dimension is a structural driver with 99% in early stage and still dominent in later stage. 
Internet dimension show Fiber product are at highest churn rate while customer pay an extra money for high quality, 
this raise a concerns about mix match between customer expectation and service experience. Third dimension is payment, show the bank withdrawal are at top of churn rate, 
folow is mailed check but customer will change their payment behavior through life cycle so that payment effect is less dominent.

-------------->findings:
Churn is structurally driven by contract type, with Month-to-Month customers accounting for nearly all churn across lifecycle stages.
Fiber Optic users consistently exhibit the highest churn rates, indicating a potential gap between expected and delivered service quality.
Payment method impacts early-stage churn, with manual or friction-heavy methods contributing to higher attrition during onboarding.
Churn risk declines significantly after 6 months, suggesting a strong survivorship effect.


