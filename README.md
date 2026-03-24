# Telco Churn Analytics & Retention Strategy
A Data-Driven Framework for Customer Value Protection and Churn Prevention
# **Project Overview**

This analysis aims to design a targeted churn reduction strategy that maximizes financial return by identifying which customers to prioritize, understanding why they leave, and defining actionable interventions with measurable ROI. Rather than addressing churn broadly, the objective is to focus on **value preservation**, ensuring that retention investments are directed toward customers who contribute the highest economic impact.

# **The Approach and Process**

### **Methodology**

The analysis is structured around a core conviction: not all churners are equal, and not all churn is preventable. The approach progresses through four layers. 

- First, it begins by constructing a standardized customer dataset, consolidating tenure, contract type, service usage, payment behavior, churn indicators, and lifetime value. This foundation enables consistent segmentation across all subsequent steps.
- Second, it then expands the analysis across multiple behavioral dimensions—contract type, internet service, and payment method—to identify structural drivers of churn.
- Third, it introduces a financial lens by calculating **value at risk**, combining churn probability and customer lifetime value to quantify potential revenue loss.
- Finally, the model translates insights into **priority-based action groups**, linking customer segments with specific retention strategies and enabling ROI evaluation.

This ensures that every retention action is **economically justified, behaviorally informed, and operationally scalable**. The diagram below illustrates the flow from raw data to actionable output.

<img width="1305" height="199" alt="image" src="https://github.com/user-attachments/assets/35882e9f-f056-476f-832d-4dbb1b483c07" />

# Analysis & Findings by Stage

### **Module 1 — The Churn Lifecycle: Understanding When Customers Leave**

**Problem Statement**: the first step addresses a fundamental question: *at which stage of the customer lifecycle does churn concentrate?.*  Understanding timing is critical because retention effectiveness depends heavily on **intervening before churn intent stabilizes**.

**Analytical Approach:** Customer tenures are grouped into six lifecycle bands — 0–3 months, 4–6 months, 7–12 months, 13–24 months, 25–36 months, and 36+ months — and churn rates are computed for each band. This cohort structure is deliberately chosen over a continuous measure because it reflects the natural inflection points in a customer's relationship with the provider: post-onboarding, post-trial, first-year renewal, and long-tenure consolidation.
<img width="1100" height="568" alt="image" src="https://github.com/user-attachments/assets/a0a24245-88a9-41fa-b771-e4ed1fe84efa" />
<img width="1121" height="639" alt="image" src="https://github.com/user-attachments/assets/954e0fd9-91d8-407b-959d-d0d83f941f49" />

**Key Findings:** The data reveals a pronounced front-loaded churn pattern. Customers in the **first three months** of their lifecycle exhibit a churn rate of approximately 57% — the highest of any cohort and more than double the rate observed at the 7–12 month stage. This pattern is consistent with a **survivorship dynamic**: customers who navigate the initial onboarding period successfully develop stronger inertia and are materially less likely to churn. This finding anchors the entire intervention framework: early-stage customers are both the most vulnerable and — from a lifecycle economics perspective — the most important cohort to retain.

### **Module 2 — Root-Cause Segmentation: Why and Who Is Leaving**

**Problem Statement**: After identifying when churn occurs, the next step is to understand *why customers leave*. The goal is to isolate structural drivers that consistently correlate with higher churn risk.

**Analytical Approach:** Three dimensions are evaluated in parallel — contract type, internet service category, and payment method — using an unpivoted data structure that enables consistent, cross-comparable analysis. For each dimension, churn rates and churn share are computed within each tenure group, producing a ranked view of which segments drive the most attrition both in proportional and absolute terms. Window functions are applied to calculate within-group shares, ensuring that the analysis captures relative concentration rather than simple frequency.

**Key Assumption:** 

| **Assumption** | **Rationale** |
| --- | --- |
| Customer decisions are influenced by contract flexibility | Short-term contracts reduce switching barriers |
| Service quality perception affects churn | Higher-priced services should deliver higher satisfaction |
| Payment friction impacts early retention | Complex payment methods increase onboarding drop-off |

<img width="1375" height="346" alt="image" src="https://github.com/user-attachments/assets/f5765323-994d-4520-aa6a-9d4b23fcd1e2" />


**Key Findings:** the analysis identifies three dominant drivers of churn.

First, **contract type is the strongest structural factor**, with Month-to-Month customers accounting for nearly all churn across lifecycle stages. The absence of commitment significantly increases exit probability.

Second, **Fiber Optic users exhibit consistently higher churn rates**, despite paying a premium. This indicates a mismatch between customer expectations and actual service experience, suggesting a quality perception issue rather than pricing sensitivity.

Third, **payment methods contribute to early-stage churn**, particularly manual or friction-heavy options such as bank withdrawals and mailed checks. However, this effect diminishes over time as customers adapt their payment behavior.

These findings confirm that churn is driven by a combination of **low commitment, unmet expectations, and onboarding friction**.

### **Module 3 — Value-at-Risk Scoring: Who Is Worth Saving**

**Problem Statement**: Not all churn has equal impact. This step answers the question: *which customers should we prioritize based on financial risk?. This stage introduces an economic filter into the segmentation logic.*

**Analytical Approach:** A value-at-risk (VaR) metric is constructed for each customer as the product of their Customer Lifetime Value and their normalised churn probability score. This composite measure captures both the scale of potential loss and the likelihood of its realisation. Customers are then segmented along two axes — CLTV tier (High: ≥$3,500; Low: <$3,500) and risk tier (High Risk: churn score ≥60; Low Risk: <60) — yielding a two-by-two prioritisation matrix. Aggregate VaR and per-customer VaR are computed for each cell, enabling both absolute and relative comparisons across segments.

**Key Assumption:** 

| **Assumption** | **Detail** |
| --- | --- |
| **CLTV threshold** | $3,500 is applied as the boundary between High and Low Value; this is a business-defined threshold and should be recalibrated periodically. |
| **Churn score threshold** | A score of 60 is used to define High Risk; this reflects a meaningful probability elevation above the population baseline |
| **VaR linearity** | The VaR formula assumes a linear relationship between churn probability and expected revenue loss — interaction effects are not modelled. Fomular: Value at Risk = CLTV × Churn Probability |

<img width="1280" height="814" alt="image" src="https://github.com/user-attachments/assets/6b02c7ff-2762-4a53-ab7a-ec6e7ab2f477" />



**Key Findings:** The VaR analysis reveals that the 36+ month tenure cohort carries the largest absolute value at risk, a consequence of their combination of high CLTV accumulation and non-trivial churn scores. 
However, on a per-customer basis, **early-stage customers exhibit disproportionately high risk relative to their value**, making them highly sensitive to intervention.
Most critically, The High Value / High Risk quadrant — customers with CLTV above $3,500 and a churn score above 60 — represents the primary retention target. This group combines the highest probability of imminent departure with the most material financial consequence. The High Value / Low Risk quadrant, while less urgent, represents a proactive opportunity: these customers are valuable and relatively stable, 

### **Module 4 — Action Plan & ROI Layer: Translating Insight into Action**

**Problem Statement**: Analytical insight generates no value until it is operationalised. The final step operationalizes insights into a clear action plan: *which actions should be taken, for which customers, and with what expected return?.* The focus is on **prioritization and execution clarity**, not just analysis. The ROI framework ensures that retention spend is treated as an investment, not a cost — subject to the same rigour applied to any other commercial allocation decision.

**Analytical Approach:** Customers has not yet churned are grouped into four priority tiers based on value, risk, contract type, and revenue contribution. An average monthly charge floor of $30 is applied to deprioritise marginal-value accounts within otherwise eligible segments. For each tier, ROI is calculated as: **Expected Value Saved = Total Value at Risk × Save Rate**, and **ROI = (Expected Value Saved − Total Intervention Cost) / Total Intervention Cost**.

**Priority Tier and Key Assumption**

| Priority Tier | Label             | Target Group                                              | Average Cost per Customer | Average Save Rate | ROI   |
|--------------|------------------|-----------------------------------------------------------|--------------------------|-------------------|-------|
| P1           | Save Now         | High Value + High Risk + M2M<br>Unit Economy > 30         | $15                      | 30%               | 67.1x |
| P2           | Prevent Churn    | High Value + Low Risk + M2M<br>Unit Economy > 30          | $10                      | 20%               | 38.5x |
| P3           | Protect & Upsell | High Value + Contracted 1Y/2Y<br>Unit Economy > 30        | $6                       | 12%               | 49.9x |
| P4           | Monitor          | Others                                                    | —                        | —                 | —     |


**ROI SUMMARY**

| **Tier** | **Customers** | **Value at Risk ($)** | **Expected Saved ($)** | **Total Cost ($)** | **ROI (×)** |
| --- | --- | --- | --- | --- | --- |
| **P1 — Save Now** | 341 | 1,161,810 | 348,543 | 5,115 | **67.1×** |
| **P2 — Prevent Churn** | 700 | 1,384,186 | 276,837 | 7,000 | **38.5×** |
| **P3 — Protect & Upsell** | 1,904 | 4,841,650 | 580,998 | 11,424 | **49.9×** |
| **TOTAL (P1–P3)** | **2,945** | **7,387,645** | **1,206,378** | **23,539** | **~51×** |

<img width="1375" height="346" alt="image" src="https://github.com/user-attachments/assets/feb27e20-c08e-4757-bfa8-16a0de0c34e7" />


**Key Findings:** 

Across all three actionable tiers, the ROI case is compelling. The P1 tier — 341 customers classified as high value, high risk, and month-to-month — delivers a projected ROI of 67.1× against a total intervention cost of just $5,115. This exceptional ratio reflects the concentration of value at risk within a numerically small but commercially critical segment. The P3 tier, while lower in per-customer urgency, represents the largest absolute value protection opportunity at $4.84M in value at risk — and delivers a 49.9× ROI through a low-cost digital channel.

In aggregate, the P1 through P3 programme covers 2,945 customers, protects $7.4M in value at risk, and is projected to recover $1.2M in expected value saved against a total programme cost of $23,539 — an overall ROI of approximately 51 times. This is not a marginal efficiency gain; it is a structurally significant retention opportunity that can be activated at low incremental cost with existing CRM infrastructure.
# **End Results and Recommendations**

### **Recommendation**

To operationalize this strategy effectively, the business should focus on three priority actions.

- **P1 – Save Now:** With a **30% save rate at $15 cost**, the strategy yields **67.1× ROI**. Remove friction and create an immediate switching barrier through **targeted discounts (10–20%) or bill credits**, combined with **contract conversion incentives (MTM → 1Y)**. This is the only tier where high cost is not only acceptable but necessary to prevent significant value leakage.
- **P2 – Prevent Churn:** With a **20% save rate at $10 cost**, delivering **38.5× ROI**, the focus is to lock in customers before risk escalates. Reduce future churn probability through **soft contract upgrade incentives** and **bundle offers (Internet + add-ons)**, ensuring increased stickiness at a controlled cost.
- **P3 – Protect & Upsell:** With a **12% save rate at $6 cost**, generating **49.9× ROI**, the strategy shifts from retention to value expansion. Increase stickiness and revenue through **upselling premium plans/add-ons** and **loyalty rewards (tenure-based perks)**, leveraging an already stable customer base.
- **P4 – Monitor:** With no defined cost or measurable save rate, this segment delivers **no justifiable ROI**. Maintain a **zero-investment approach**, limiting actions to monitoring only, to ensure resources remain focused on higher-impact tiers.
