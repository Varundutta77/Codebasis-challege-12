-- Q4 What are the quarterly trends based on sales volume for the top 5 EV makers (4-wheelers) from 2022 to 2024?
WITH RankedSales AS (
    SELECT 
        maker,
        dd.fiscal_year,
        dd.quarter,
        SUM(evsm.electric_vehicles_sold) AS total_ev_sale,
        RANK() OVER (PARTITION BY dd.fiscal_year, dd.quarter ORDER BY SUM(evsm.electric_vehicles_sold) DESC) AS ranking
    FROM 
        cars.electric_vehicle_sales_by_makers evsm
    JOIN 
        dim_date dd ON dd.sale_date = evsm.sale_date
    WHERE
        evsm.vehicle_category = '4-Wheelers' 
        AND dd.fiscal_year BETWEEN 2022 AND 2024
    GROUP BY
        fiscal_year,
        maker,
        quarter
)

SELECT 
    fiscal_year,
    quarter,
    maker,
    total_ev_sale
FROM 
    RankedSales
WHERE 
    ranking <= 5
ORDER BY 
    fiscal_year,
    quarter,
    total_ev_sale DESC;
