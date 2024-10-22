-- Q1 List the top 3 and bottom 3 makers for the fiscal years 2023 and 2024 in terms of the number of 2-wheelers sold.

WITH Electric_2wheeler_Sold AS (
    SELECT maker, SUM(electric_vehicles_sold) AS total_electric_vehicle_sold
    FROM electric_vehicle_sales_by_makers evsm
    JOIN dim_date dd ON dd.sale_date = evsm.sale_date
    WHERE vehicle_category = '2-Wheelers' AND fiscal_year IN (2023, 2024)
    GROUP BY maker
)

SELECT maker, total_electric_vehicle_sold, 'Top' AS position
FROM (
    SELECT maker, total_electric_vehicle_sold
    FROM Electric_2wheeler_Sold
    ORDER BY total_electric_vehicle_sold DESC
    LIMIT 3
) AS TopMakers

UNION ALL

SELECT maker, total_electric_vehicle_sold, 'Bottom' AS position
FROM (
    SELECT maker, total_electric_vehicle_sold
    FROM Electric_2wheeler_Sold
    ORDER BY total_electric_vehicle_sold ASC
    LIMIT 3
) AS BottomMakers;

