SELECT
	n as name,
	d as purchase_date
FROM purchases
WHERE ((((CAST(EXTRACT(YEAR FROM d)AS int) % 4 = 0)
AND NOT (CAST(EXTRACT(YEAR FROM d)AS int) % 100 = 0) 
AND (CAST(EXTRACT(YEAR FROM d)AS int) % 400 = 0)
OR (CAST(EXTRACT(YEAR FROM d)AS int) = 2000)
AND (CAST(EXTRACT(MONTH FROM d)AS int) = 2 OR (CAST(EXTRACT(MONTH FROM d)AS int) = 3)))))
ORDER BY name, purchase_date;
