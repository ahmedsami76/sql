-- update table t2
UPDATE t2 SET first_name = 'amr' WHERE id = 4;
SELECT * from t2;

-- update table t1 using LIMIT
UPDATE t2 SET first_name = 'amr' WHERE id = 4 LIMIT 1;

-- update table t1 using ORDER BY
UPDATE t2 SET first_name = 'amr' WHERE id = 4 ORDER BY id DESC LIMIT 3;

