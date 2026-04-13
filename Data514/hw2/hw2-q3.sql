SELECT F1.tail_num, C.cname AS carrier, A.mfr, A.model, COUNT(*) AS cnt --gives us all the columns we want and renames them
FROM Flights AS F1, N_Numbers AS N, Aircraft_Types AS A, Carriers AS C --all the places we are pulling from
WHERE F1.tail_num = N.n_number --inner join Flights and N_numbers
AND N.mfr_mdl_code = A.atid --inner join aircarft types and n_numbers
AND C.cid = F1.cid --inner join carriers and flights
AND F1.cancelled = 0 --set cancellations to 0 (they were not cancelled)
GROUP BY F1.cid, F1.tail_num --group by both the manufacturer and the tailnumber
ORDER BY cnt DESC, F1.tail_num ASC --this makes it decending count but asceninding tail number after for ties
LIMIT 25; --only the top 25