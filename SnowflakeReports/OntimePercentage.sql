CREATE OR REPLACE VIEW Ontime_Percentage AS
SELECT al.airline, 
CAST((SUM(CASE WHEN f.arrival_delay<=0 THEN 1 ELSE 0 END)/COUNT(*))*100 AS NUMERIC(20,2)) AS PercentageOnTime
FROM USER_SAI.public.flights f
JOIN USER_SAI.public.airlines al ON f.airline = al.iata_code
WHERE f.cancelled = 0
AND f.year=2015
GROUP BY al.airline;