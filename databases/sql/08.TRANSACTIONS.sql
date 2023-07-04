-- Active: 1688236555284@@mysql-db@3306
-- ACID
-- Atomicity
-- Consistency
-- Isolation - locks
-- Durability - rollback


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
-- autocommit
-- start transaction
START TRANSACTION;
-- update t1 
UPDATE t1 SET first_name = 'sawsan' WHERE id = 1;

-- check the t1 rows from another session
table t1;
-- commit transaction
COMMIT; -- or ROLLBACK;

TABLE t1;

-- start transaction without commit 
START TRANSACTION;
-- update t1
UPDATE t1 SET first_name = 'fekri' WHERE id = 1;

ROLLBACK;

TABLE t1;


-- autocommit
SET autocommit = 0;

UPDATE t1 SET first_name = 'fekri' WHERE id = 1;
ROLLBACK;

SET autocommit = 1;

UPDATE t1 SET first_name = 'fekri' WHERE id = 1;

-- acid features
-- atomicity
-- consistency
-- isolation
-- durability

-- buffer pool, redo logs, flush to disk 
/*
Atomicity
    All changes to data are performed as if they are a single operation. That is, all the changes are performed, or none of them are.
    For example, in an application that transfers funds from one account to another, the atomicity property ensures that, if a debit is made successfully from one account, the corresponding credit is made to the other account.
Consistency
    Data is in a consistent state when a transaction starts and when it ends.
    For example, in an application that transfers funds from one account to another, the consistency property ensures that the total value of funds in both the accounts is the same at the start and end of each transaction.
Isolation
    The intermediate state of a transaction is invisible to other transactions. As a result, transactions that run concurrently appear to be serialized.
    For example, in an application that transfers funds from one account to another, the isolation property ensures that another transaction sees the transferred funds in one account or the other, but not in both, nor in neither.
Durability
    After a transaction successfully completes, changes to data persist and are not undone, even in the event of a system failure.
    For example, in an application that transfers funds from one account to another, the durability property ensures that the changes made to each account will not be reversed. 
*/