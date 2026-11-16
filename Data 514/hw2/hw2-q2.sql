SELECT C.cname AS carrier_name, F1.op_carrier_flight_num AS f1_flight_num, F1.duration_mins AS f1_duration_mins, F1.dest_city AS intermediate_city, F2.op_carrier_flight_num AS f2_flight_num, F2.duration_mins AS f2_duration_mins, F1.duration_mins + F2.duration_mins AS total_duration_mins
FROM Flights AS F1, Flights AS F2, Carriers AS C
WHERE F1.cid = C.cid --this gives us access to the name of the airline and combines them?
AND F1.month = 9 --ocuring in september
AND F2.month = 9
AND F2.year = 2024
AND F1.year = 2024 --in 2024
AND F1.day_of_month = 7 -- on the seventh
AND F2.day_of_month = 7
AND F1.origin = "SEA" --the origin of the flight is seatac
AND F2.dest_city = "Chicago, IL" --and goes to any airport in Chicago
AND F1.cid = F2.cid --make sure have same CID 
AND F1.dest = F2.origin
AND F1.dep_time < F2.dep_time --make sure F1 takes off before F2 
AND F1.duration_mins + F2.duration_mins < 360 --made sure duration is less than 360
AND F1.day_of_month = F2.day_of_month --same day for both
AND F1.dest_city != "Chicago, IL"; -- need to have a stop 
--only want the unique ones 

; --and same days for both 

