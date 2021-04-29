CREATE OR REPLACE VIEW Delay_Reasons AS
WITH cte_reasons AS (
SELECT a.airport, SUM(arrival_delay) AS total_delay,
    SUM(air_system_delay) AS air_system_delay,
    SUM(security_delay) AS security_delay,
    SUM(airline_delay) AS airline_delay,
    SUM(late_aircraft_delay) AS late_aircraft_delay,
    SUM(weather_delay) AS weather_delay,
    SUM(IFF(air_system_delay IS NULL, arrival_delay, 0)) AS unknown_delay
FROM USER_SAI.public.flights f
JOIN USER_SAI.public.airports a 
ON f.origin_airport = a.iata_code
WHERE arrival_delay > 0
GROUP BY airport)
SELECT airport,total_delay,
    CAST((air_system_delay/total_delay)*100 AS Numeric(20,2)) AS air_system_percent,
    CAST((security_delay/total_delay)*100 AS Numeric(20,2)) AS security_percent,
    CAST((airline_delay/total_delay)*100 AS Numeric(20,2)) AS airline_percent,
    CAST((late_aircraft_delay/total_delay)*100 AS Numeric(20,2)) AS late_aircraft_percent,
    CAST((weather_delay/total_delay)*100 AS Numeric(20,2)) AS weather_percent,
    CAST((unknown_delay/total_delay)*100 AS Numeric(20,2)) AS unknown_percent
FROM cte_reasons;