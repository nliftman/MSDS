SELECT F1.tail_num AS tail_numbers, F1.dest AS airport --rename the columns
FROM Flights AS F1, Flights AS F2 --iterate over flights twice
WHERE F1.tail_num = F2.tail_num --want same plane
AND F1.origin = F2.origin --same city
AND F1.year = F2.year --same year
AND F1.month = F2.month --same month
AND F1.day_of_month = F2.day_of_month --same day of month
AND F1.dest != F2.dest --different destinations
AND F1.distance_mi + F2.distance_mi >= 5200 --the distnace between them equal to or over 5200
GROUP BY F1.tail_num, F1.origin, F2.tail_num --grouping them by the tial number and the place they come from
HAVING COUNT(F1.tail_num) > 1; --want only the ones departed two or more times!
