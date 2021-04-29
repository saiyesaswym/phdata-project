CREATE OR REPLACE VIEW Unique_routes AS
SELECT distinct a.airline, count(distinct origin_airport, destination_airport) as unique_routes FROM
USER_SAI.public.flights f
JOIN
USER_SAI.public.airlines a
ON f.airline = a.iata_code
GROUP BY 1;