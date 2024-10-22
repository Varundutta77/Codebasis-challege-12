-- Q2 Identify the top 5 states with the highest penetration rate in 2-wheeler EV sales in FY 2024. 
WITH PENETRATE_RATE AS
(	
	SELECT  
	state,
    fiscal_year,
    evss.vehicle_category,
	ROUND(SUM(evss.electric_vehicles_sold)/SUM(total_vehicles_sold)*100,2) as Penetration_Rate
FROM 
	cars.electric_vehicle_sales_by_makers evsm
JOIN
	electric_vehicle_sales_by_state evss ON evss.sale_date = evsm.sale_date
JOIN
	dim_date dd ON dd.sale_date = evsm.sale_date
WHERE
	fiscal_year IN (2024)
GROUP BY
	state,
	fiscal_year,
    evss.vehicle_category
)
SELECT state,fiscal_year,vehicle_category,CONCAT(Penetration_Rate,"%") as Penetration_Rate
FROM PENETRATE_RATE
WHERE vehicle_category IN ('4-Wheelers','2-Wheelers')

ORDER BY penetration_rate DESC LIMIT 5
