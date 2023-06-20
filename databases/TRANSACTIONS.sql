
show databases;

CREATE DATABASE IF NOT EXISTS testdb;

-- create table
USE testdb;
CREATE TABLE t1 (id INT, first_name VARCHAR(20));

SHOW COLUMNS FROM t1;

-- insert some rows 
INSERT INTO t1 VALUES (1, 'ahmed'), (2, 'aya'), (3, 'john');

TABLE t1;

-- update a row in t1
UPDATE t1 SET first_name = 'ali' WHERE id = 1;

-- transactions

-- start transaction
START TRANSACTION;
-- update t1 
UPDATE t1 SET first_name = 'ali' WHERE id = 1;
-- commit transaction
COMMIT;

TABLE t1;

-- start transaction without commit 
START TRANSACTION;
-- update t1
UPDATE t1 SET first_name = 'fekri' WHERE id = 1;
TABLE t1;
-- autocommit
SET autocommit = 1;

START TRANSACTION;
-- update t1
UPDATE t1 SET first_name = 'abc' WHERE id = 1;
TABLE t1;

COMMIT;