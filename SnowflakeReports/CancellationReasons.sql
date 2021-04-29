CREATE OR REPLACE VIEW Cancellation_Reasons AS
SELECT a.airport,
CASE f.cancellation_reason WHEN 'A' THEN 'Airline/Carrier'
  WHEN 'B' THEN 'Weather'
  WHEN 'C' THEN 'National Air System'
  WHEN 'D' THEN 'Security'
  ELSE 'Unknown' END AS Cancellation_Reason,
COUNT(*) AS reasons_count
FROM USER_SAI.public.flights f
JOIN USER_SAI.public.airports a
ON f.origin_airport = a.iata_code
WHERE f.Cancelled = 1
GROUP BY 1,2;