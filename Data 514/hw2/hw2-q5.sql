SELECT N.n_number AS n_number, A.num_seats AS capacity, A.model AS model
FROM N_numbers AS N, Aircraft_Types AS A
WHERE N.mfr_mdl_code = A.atid
AND UPPER(N.name) = 'UNIVERSITY OF WASHINGTON'
ORDER BY A.model ASC, N.n_number ASC;