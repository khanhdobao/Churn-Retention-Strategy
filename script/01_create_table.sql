
-- Create the Demographics Table
CREATE TABLE telco_Demographics (
    CustomerID VARCHAR(50) PRIMARY KEY,
    Count INT,
    Gender VARCHAR(10),
    Age INT,
    Senior_Citizen VARCHAR(5),
    Married VARCHAR(5),
    Dependents VARCHAR(5),
    Number_of_Dependents INT
);

-- Create the Location Table
CREATE TABLE telco_Location (
    CustomerID VARCHAR(50) PRIMARY KEY,
    Count INT,
    Country VARCHAR(100),
    State VARCHAR(100),
    City VARCHAR(100),
    Zip_Code VARCHAR(20),
    Lat_Long VARCHAR(100),
    Latitude DECIMAL(10, 8),
    Longitude DECIMAL(11, 8)
);

-- Create the Population Table
CREATE TABLE telco_Population (
    ID INT PRIMARY KEY,
    Zip_Code VARCHAR(20),
    Population INT
);

-- Create the Services Table
CREATE TABLE telco_Services (
    CustomerID VARCHAR(50) PRIMARY KEY,
    Count INT,
    Quarter VARCHAR(5),
    Referred_a_Friend VARCHAR(5),
    Number_of_Referrals INT,
    Tenure_in_Months INT,
    Offer VARCHAR(50),
    Phone_Service VARCHAR(5),
    Avg_Monthly_Long_Distance_Charges DECIMAL(10, 2),
    Multiple_Lines VARCHAR(5),
    Internet_Service VARCHAR(50),
    Avg_Monthly_GB_Download INT,
    Online_Security VARCHAR(5),
    Online_Backup VARCHAR(5),
    Device_Protection_Plan VARCHAR(5),
    Premium_Tech_Support VARCHAR(5),
    Streaming_TV VARCHAR(5),
    Streaming_Movies VARCHAR(5),
    Streaming_Music VARCHAR(5),
    Unlimited_Data VARCHAR(5),
    Contract VARCHAR(20),
    Paperless_Billing VARCHAR(5),
    Payment_Method VARCHAR(50),
    Monthly_Charge DECIMAL(10, 2),
    Total_Charges DECIMAL(10, 2),
    Total_Refunds DECIMAL(10, 2),
    Total_Extra_Data_Charges DECIMAL(10, 2),
    Total_Long_Distance_Charges DECIMAL(10, 2)
);

-- Create the Status Table
CREATE TABLE telco_Status (
    CustomerID VARCHAR(50) PRIMARY KEY,
    Count INT,
    Quarter VARCHAR(5),
    Satisfaction_Score INT,
    Satisfaction_Score_Label VARCHAR(50),
    Customer_Status VARCHAR(20),
    Churn_Label VARCHAR(5),
    Churn_Value INT,
    Churn_Score INT,
    Churn_Score_Category VARCHAR(50),
    CLTV INT,
    CLTV_Category VARCHAR(50),
    Churn_Category VARCHAR(50),
    Churn_Reason TEXT
);