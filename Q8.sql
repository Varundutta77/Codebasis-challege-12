-- Q8 What are the peak and low season months for EV sales based on the data from 2022 to 2024?
WITH peak_season AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(dd.sale_date, '%d-%b-%y'),'%M') AS month,
        fiscal_year,
        SUM(electric_vehicles_sold) AS total_peak_sold
    FROM electric_vehicle_sales_by_state evss
    JOIN dim_date dd ON dd.sale_date = evss.sale_date
    WHERE fiscal_year IN (2022, 2023, 2024)
    GROUP BY month, fiscal_year
    ORDER BY total_peak_sold DESC
    LIMIT 1 
),
low_season AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(dd.sale_date, '%d-%b-%y'),'%M') AS month,
        fiscal_year,
        SUM(electric_vehicles_sold) AS total_low_sold
    FROM electric_vehicle_sales_by_state evss
    JOIN dim_date dd ON dd.sale_date = evss.sale_date
    WHERE fiscal_year IN (2022, 2023, 2024)
    GROUP BY month, fiscal_year
    ORDER BY total_low_sold ASC
    LIMIT 1 
)
SELECT 
    'Peak Season' AS season,
    month,
    fiscal_year,
    total_peak_sold AS total_sold
FROM peak_season
UNION ALL
SELECT 
    'Low Season' AS season,
    month,
    fiscal_year,
    total_low_sold AS total_sold
FROM low_season;
