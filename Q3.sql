-- Q3 List the states with negative penetration (decline) in EV sales from 2022 to 2024?

WITH Penetration_Rates AS 
(
    SELECT 
        state,
        SUM(CASE WHEN d.fiscal_year = 2022 THEN electric_vehicles_sold ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN d.fiscal_year = 2022 THEN total_vehicles_sold ELSE 0 END), 0) AS pen_rate_2022,
        
        SUM(CASE WHEN d.fiscal_year = 2023 THEN electric_vehicles_sold ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN d.fiscal_year = 2023 THEN total_vehicles_sold ELSE 0 END), 0) AS pen_rate_2023,
        
        SUM(CASE WHEN d.fiscal_year = 2024 THEN electric_vehicles_sold ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN d.fiscal_year = 2024 THEN total_vehicles_sold ELSE 0 END), 0) AS pen_rate_2024
    FROM 
        electric_vehicle_sales_by_state evsm
    JOIN 
        dim_date d ON evsm.sale_date = d.sale_date 
    WHERE 
        d.fiscal_year IN (2022, 2023, 2024)
    GROUP BY 
        state
)

SELECT 
    state,
    CASE 
        WHEN (pen_rate_2024 < pen_rate_2023 AND pen_rate_2023 IS NOT NULL) THEN 
            (pen_rate_2024 - pen_rate_2023) / NULLIF(pen_rate_2023, 0)
        WHEN (pen_rate_2023 < pen_rate_2022 AND pen_rate_2022 IS NOT NULL) THEN 
            (pen_rate_2023 - pen_rate_2022) / NULLIF(pen_rate_2022, 0)
    END AS neg_pen
FROM 
    Penetration_Rates
WHERE 
    (pen_rate_2024 < pen_rate_2023 AND pen_rate_2023 IS NOT NULL) OR 
    (pen_rate_2023 < pen_rate_2022 AND pen_rate_2022 IS NOT NULL);
