SELECT
	n as name,
	d as purchase_date
FROM purchases
WHERE
	CAST(EXTRACT(ISODOW FROM d) AS int) = 5
	AND
	CAST(EXTRACT(MONTH FROM (d+7)) AS int) = CAST(EXTRACT(MONTH FROM d) AS int)+1
ORDER BY purchase_date;