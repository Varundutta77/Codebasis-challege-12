-- EXPORT FILES IN EXCEL
SELECT * 
FROM cars.electric_vehicle_sales_by_makers evsm
JOIN electric_vehicle_sales_by_state evss ON evss.sale_date = evsm.sale_date
JOIN dim_date dd ON dd.sale_date = evss.sale_date
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/int-1.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';
