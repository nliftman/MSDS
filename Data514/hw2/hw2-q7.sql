SELECT F.year, F.month, F.day_of_month, C2.cname, F.op_carrier_flight_num AS flight_num
FROM Flights AS F, Cancellation_Codes AS C1, Aircraft_Types AS A, N_Numbers AS N, Carriers AS C2
WHERE F.cancellation_code = C1.ccid
AND N.mfr_mdl_code = A.atid
AND N.n_number = F.tail_num
AND F.origin_city = "Atlanta, GA"
AND C2.cid = F.cid
AND A.model LIKE "%737%"
AND C1.description LIKE "%Weather%";