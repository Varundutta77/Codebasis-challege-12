-- Q5 How do the EV sales and penetration rates in Delhi compare to Karnataka for 2024?
WITH EV_Sale AS (
	SELECT
		 ROUND(SUM(CASE WHEN state ="delhi" THEN electric_vehicles_sold ELSE 0 END),1) as EV_Sale_Delhi,
		 ROUND(SUM(CASE WHEN state ="karnataka" THEN electric_vehicles_sold ELSE 0 END),1) as EV_Sale_karnataka
	FROM electric_vehicle_sales_by_state evss
	JOIN dim_date dd ON dd.sale_date = evss.sale_date
	WHERE fiscal_year IN (2024)
),
Penetration_rate AS (
	SELECT
		 SUM(CASE WHEN state ="delhi" THEN electric_vehicles_sold ELSE 0 END)/
         NULLIF(SUM(CASE WHEN state ="delhi" THEN total_vehicles_sold ELSE 0 END),0)*100 as pnt_Delhi,
		 SUM(CASE WHEN state ="karnataka" THEN electric_vehicles_sold ELSE 0 END)/
         NULLIF(SUM(CASE WHEN state ="delhi" THEN total_vehicles_sold ELSE 0 END),0)*100 as pnt_karnataka
	FROM electric_vehicle_sales_by_state evss
	JOIN dim_date dd ON dd.sale_date = evss.sale_date
	WHERE fiscal_year IN (2024)
)
SELECT 
    EV_Sale.EV_Sale_Delhi,
    EV_Sale.EV_Sale_Karnataka,
    Penetration_rate.pnt_Delhi,
    Penetration_rate.pnt_Karnataka
FROM 
    EV_Sale, Penetration_rate;