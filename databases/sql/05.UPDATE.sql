-- update table t2
UPDATE t2 SET name = 'amr' WHERE id = 4;

-- update table t1 using LIMIT
UPDATE t2 SET name = 'amr' WHERE id = 4 LIMIT 1;

-- update table t1 using ORDER BY
UPDATE t2 SET name = 'amr' WHERE id = 4 ORDER BY id DESC LIMIT 1;

