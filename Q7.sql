-- Q7 List down the top 10 states that had the highest compounded annual growth rate (CAGR) from 2022 to 2024 in total vehicles sold.
WITH initial_value AS (
    SELECT state,
           SUM(total_vehicles_sold) AS initial_sale
    FROM electric_vehicle_sales_by_state evss
    JOIN dim_date dd ON dd.sale_date = evss.sale_date
    WHERE fiscal_year = 2022 
    GROUP BY state
),
final_value AS (
    SELECT state,
           SUM(total_vehicles_sold) AS final_sale
    FROM electric_vehicle_sales_by_state evss
    JOIN dim_date dd ON dd.sale_date = evss.sale_date
    WHERE fiscal_year = 2024 
    GROUP BY state
)
SELECT iv.state,
       CASE 
           WHEN iv.initial_sale = 0 THEN NULL  -- Avoid division by zero
           ELSE ROUND(POWER(fv.final_sale / iv.initial_sale, 1.0 / 2.0) - 1,2)
       END AS CAGR
FROM initial_value iv
JOIN final_value fv ON iv.state = fv.state
ORDER BY CAGR DESC 
LIMIT 10;
