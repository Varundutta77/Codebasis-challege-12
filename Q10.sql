-- Q10 Estimate the revenue growth rate of 4-wheeler and 2-wheelers EVs in India for 2022 vs 2024 and 2023 vs 2024, assuming an average unit price.
SELECT 
	fiscal_year,
    SUM(CASE WHEN vehicle_category ='2-Wheelers' THEN electric_vehicles_sold ELSE 0 END)*85000 as average_2_wheeler_sale,
	SUM(CASE WHEN vehicle_category ='4-Wheelers' THEN electric_vehicles_sold ELSE 0 END)*1500000 as average_4_wheeler_sale
FROM 
	electric_vehicle_sales_by_state evss
JOIN dim_date dd ON dd.sale_date = evss.sale_date
GROUP BY 
	fiscal_year
