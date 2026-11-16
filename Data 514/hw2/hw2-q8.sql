SELECT C1.description AS cancellation_reason, COUNT(Flights.fid) as num_flights
FROM Cancellation_Codes AS C1
LEFT OUTER JOIN Flights ON Flights.cancellation_code = C1.ccid
GROUP BY C1.description;

