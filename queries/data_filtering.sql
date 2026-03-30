-- Count observations for each region-year and identify time-frame for reliable analysis 
  SELECT COUNT(*) AS total_amt,
EXTRACT(YEAR FROM date) AS year
FROM `food-inflation-data.Ethiopian_food_prices.ETH food price table`
WHERE commodity = 'Maize (white)'
  AND EXTRACT(YEAR FROM date) > 2017
GROUP BY year
ORDER BY year;

### Results showed significant increase in observations from 2020-2025 
--(2019 had 64 total observations, and 2020 had 401)

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
