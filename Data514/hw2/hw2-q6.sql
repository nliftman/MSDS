SELECT DISTINCT(N.n_number) AS n_number, N.name, N.city --getting all our columns
FROM N_Numbers AS N, Flights as F --the tables to merge
WHERE F.tail_num = N.n_number --the sneaky merge
AND N.year_mfr = 2024 --only made in 2024
AND N.city || ", " || N.state = UPPER(F.origin_city); --concat and set them equal!