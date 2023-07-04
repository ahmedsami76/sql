-- indexes
-- b-tree by default    
-- unique
-- primary key
-- foreign key

-- column indexes
--

DROP DATABASE IF EXISTS testdb;
CREATE DATABASE IF NOT EXISTS testdb;

USE testdb;

CREATE TABLE t1 (
    id INT, 
    first_name VARCHAR(20),
    INDEX (first_name)
    );

DESC t1;

-- other ways to define index
CREATE INDEX idx_first_name ON t1 (first_name);

-- drop index

DROP INDEX idx_first_name ON t1;
-- insert some rows
INSERT INTO t1 VALUES (1, 'ahmed'), (2, 'aya'), (3, 'john'),
                      (4, 'sami'), (5, 'fekri'), (6, 'michael'),
                      (7, 'eissa'), (8, 'samira'), (9, 'jane');
TABLE t1;

SELECT * FROM t1 WHERE first_name = 'ahmed';

-- explain query plan

EXPLAIN SELECT * FROM t1;
EXPLAIN SELECT * FROM t1 WHERE id > 2;
EXPLAIN SELECT * FROM t1 WHERE first_name like 'ahmed';

-- show on mysql workbench