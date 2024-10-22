-- Q6 List down the compounded annual growth rate (CAGR) in 4-wheeler units for the top 5 makers from 2022 to 2024.
WITH initial_value AS (
    SELECT maker,
           SUM(electric_vehicles_sold) AS initial_sale
    FROM electric_vehicle_sales_by_makers evsm
    JOIN dim_date dd ON dd.sale_date = evsm.sale_date
    WHERE fiscal_year = 2022 AND vehicle_category ='4-Wheelers'
    GROUP BY maker
),
final_value AS (
    SELECT maker,
           SUM(electric_vehicles_sold) AS final_sale
    FROM electric_vehicle_sales_by_makers evsm
    JOIN dim_date dd ON dd.sale_date = evsm.sale_date
    WHERE fiscal_year = 2024 AND vehicle_category='4-Wheelers'
    GROUP BY maker
)
SELECT iv.maker,CASE 
           WHEN initial_sale = 0 THEN NULL  -- Avoid division by zero
           ELSE ((POWER(final_sale / initial_sale, 1 / 2.0)) - 1)
       END AS CAGR
FROM initial_value iv
JOIN final_value fv ON iv.maker = fv.maker
ORDER BY CAGR DESC LIMIT 5

