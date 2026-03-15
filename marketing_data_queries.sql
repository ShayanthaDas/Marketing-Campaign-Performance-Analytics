SET GLOBAL local_infile = 1;
CREATE DATABASE IF NOT EXISTS marketing_portfolio;
USE marketing_portfolio;
SELECT DATABASE();
SHOW TABLES;
CREATE DATABASE ads_portfolio;
USE ads_portfolio;
SHOW TABLES;
DROP TABLE IF EXISTS marketing_raw;
SELECT DATABASE();
SHOW TABLES;
CREATE TABLE marketing_raw (
	Ad_Impressions VARCHAR(50),
    CTR VARCHAR(50),
    Clicks VARCHAR(50),
    Site_Conversion VARCHAR(50),
    Leads VARCHAR(50),
    Sales_conversion VARCHAR(50),
    Number_of_clients VARCHAR(50),
    Average_check VARCHAR(50),
    Revenue VARCHAR(50),
    Cost_price VARCHAR(50),
    Advertising_budget VARCHAR(50),
    CPC VARCHAR(50),
    Cost_per_lead VARCHAR(50),
    Customer_price VARCHAR(50),
    Net_profit VARCHAR(50),
    ROI VARCHAR(50),
    Selling_text_scheme VARCHAR(100),
    Ad_display_time VARCHAR(100),
    Targeting_type VARCHAR(100),
    Advertising_placement VARCHAR(100),
    User_device VARCHAR(100),
    Advertising_design_method VARCHAR(100)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/marketing_data.csv'
INTO TABLE marketing_raw
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
CREATE TABLE marketing_clean AS
SELECT
	CAST(Ad_Impressions AS UNSIGNED) AS Ad_Impressions,
    CAST(CTR AS DECIMAL(8,4)) AS CTR,
    CAST(Clicks AS UNSIGNED) AS Clicks,
    CAST(Leads AS UNSIGNED) AS Leads,
    CAST(Revenue AS DECIMAL(12,2)) AS Revenue,
    CAST(Advertising_budget AS DECIMAL(12,2)) AS Advertising_budget,
    CAST(Net_profit AS DECIMAL(12,2)) AS Net_profit,
    CAST(ROI AS DECIMAL(10,4)) AS ROI,
    User_device,
    Targeting_type,
    Advertising_placement
FROM marketing_raw;
CREATE VIEW device_performance AS
SELECT
	User_device,
    SUM(Revenue) AS total_revenue,
    SUM(Net_profit) AS total_profit,
    SUM(Advertising_budget) AS total_spend
FROM marketing_clean
GROUP BY User_device;
SELECT * FROM device_performance;
SELECT * 
FROM device_performance
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/device_performance.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


    