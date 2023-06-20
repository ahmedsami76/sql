-- update table t1
UPDATE t1 SET name = 'amr' WHERE id = 4;

-- update table t1 using LIMIT
UPDATE t1 SET name = 'amr' WHERE id = 4 LIMIT 1;

-- update table t1 using ORDER BY
UPDATE t1 SET name = 'amr' WHERE id = 4 ORDER BY id DESC LIMIT 1;

