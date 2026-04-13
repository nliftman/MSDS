SELECT DISTINCT(C.cname) AS name
FROM Flights AS F, Carriers AS C
WHERE F.cid = C.cid
AND origin = "SEA" 
AND dest_city = "Chicago, IL";