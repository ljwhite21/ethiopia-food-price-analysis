-- Filter regions with sufficient yearly observations and enough usable years for analysis
WITH yearly_counts AS (
  SELECT admin1 AS region,
    commodity,
    EXTRACT(YEAR FROM date) AS year,
    COUNT(*) AS observations
  FROM `food-inflation-data.Ethiopian_food_prices.ETH food price table`
  WHERE commodity = 'Maize (white)'
    AND admin1 IS NOT NULL
    AND EXTRACT(YEAR FROM date) BETWEEN 2020 AND 2025
  GROUP BY region, commodity, year
  HAVING COUNT(*) >= 15
)

SELECT region,
  commodity,
  COUNT(*) AS usable_years
FROM yearly_counts
GROUP BY region, commodity
HAVING COUNT(*) >= 5
ORDER BY region;
