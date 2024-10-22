-- Q9 What is the projected number of EV sales (including 2-wheelers and 4-wheelers) for the top 10 states by penetration rate in 2030, based on the compounded annual growth rate (CAGR) from previous years?
WITH historical_sales AS (
    SELECT
        state,
        SUM(CASE WHEN fiscal_year = 2022 THEN electric_vehicles_sold ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN fiscal_year = 2024 THEN electric_vehicles_sold ELSE 0 END) AS sales_2024
    FROM electric_vehicle_sales_by_state evss
    JOIN dim_date dd ON dd.sale_date= evss.sale_date
    WHERE fiscal_year IN (2022, 2024)
    GROUP BY state
),
cagr_calculation AS (
    SELECT 
        state,
        sales_2022,
        sales_2024,
        (POWER(sales_2024 / sales_2022, 1.0 / 2) - 1) AS CAGR  
    FROM historical_sales
)
SELECT 
    state,
    sales_2024 * POWER(1 + CAGR, 6) AS projected_sales_2030  
FROM cagr_calculation
ORDER BY projected_sales_2030 DESC
LIMIT 10; 
