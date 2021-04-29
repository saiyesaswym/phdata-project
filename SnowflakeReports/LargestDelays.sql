CREATE OR REPLACE VIEW Largest_Delays AS
WITH cte_flights AS(
  SELECT airline, 
  SUM(CASE WHEN arrival_delay>0 OR departure_delay>0 THEN 1 ELSE 0 END) AS delayed_cnt
  FROM USER_SAI.public.flights
  GROUP BY airline)
SELECT a.airline, f.delayed_cnt FROM cte_flights f
JOIN USER_SAI.public.airlines a ON f.airline = a.iata_code;