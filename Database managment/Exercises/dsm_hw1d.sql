
SELECT
  p1.n AS p1_name,
  p1.d AS p1_first_purchase,
  p1.i AS p1_last_purchase,
  p2.n AS p2_name,
  p2.d AS p2_first_purchase,
  p2.i AS p2_last_purchase
FROM
  purchases p1
JOIN
  purchases p2 ON p1.n != p2.n
WHERE
  p1.d <= p2.d
GROUP BY
  p1.n,
  p1.d,
  p1.i,
  p2.n,
  p2.d,
  p2.i
HAVING
  COUNT(*) > 1
ORDER BY
  p1.n,
  p2.n,
  p1.d,
  p2.d;


