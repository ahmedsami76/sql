-- Active: 1688236555284@@mysql-db@3306@testdb
-- delete all rows from the t1
USE testdb;
DELETE FROM t1;

DELETE * FROM t1;

-- delete rows from t1 where id = 1
DELETE FROM t1 WHERE id = 1;

-- delete rows from t1 using LIMIT
DELETE FROM t1 LIMIT 1;

-- you can also use the TRUNCATE statement
TRUNCATE TABLE t2;


