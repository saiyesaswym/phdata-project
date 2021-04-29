CREATE OR REPLACE VIEW totalFlights_Monthly AS
WITH origin_cte AS
(
  SELECT f.year, f.month, al.airline, ap.airport, count(*) AS origin_count
  FROM USER_SAI.public.flights f
  JOIN USER_SAI.PUBLIC.airlines al 
  ON f.airline = al.iata_code
  JOIN USER_SAI.PUBLIC.airports ap 
  ON f.origin_airport = ap.iata_code
  WHERE f.cancelled = 0
  GROUP BY al.airline, ap.airport, f.year, f.month
)
,destin_cte AS
(
  SELECT f.year, f.month, al.airline, ap.airport, count(*) AS destin_count
  FROM USER_SAI.public.flights f
  JOIN USER_SAI.PUBLIC.airlines al ON f.airline = al.iata_code
  JOIN USER_SAI.PUBLIC.airports ap ON f.destination_airport = ap.iata_code
  WHERE f.cancelled = 0
  GROUP BY al.airline, ap.airport, f.year, f.month
)
SELECT oa.year, oa.month, oa.airline, oa.airport, SUM(oa.origin_count + da.destin_count) AS TotalFlights
FROM origin_cte oa
JOIN destin_cte da 
ON oa.year=da.year AND 
oa.month=da.month AND oa.airline=da.airline AND oa.airport = da.airport
GROUP BY oa.airline, oa.airport, oa.year, oa.month;
