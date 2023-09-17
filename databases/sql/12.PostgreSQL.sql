-- Active: 1688525394700@@pg-db@5432@testdb
SELECT version();

SHOW server_version;

SERIAl -- auto increment in postgres 

SHOW data_directory;

create database testdb;

select current_database();

-- change current database in extension

-- \c (in command line %% change database )

use testdb; -- ERROR this does not work with PostgreSQL :(

create table t1(id int,first_name varchar(30));


-- some statements that work with MySQL but not with PostgreSQL
CREATE TABLE t2 LIKE t1; -- ERROR
-- equivalent to CREATE TABLE t2 AS TABLE t1; in PostgreSQL
CREATE TABLE t2 AS SELECT * FROM t1;
SHOW COLUMNS FROM t1; -- ERROR 
DESC t1; -- ERROR
-- equivalent to SHOW COLUMNS FROM t1; in MySQL
SELECT column_name, data_type, table_name FROM information_schema.columns;
--WHERE table_name = 't1';


-----------------------

-- insert values into table t1
INSERT INTO t1 VALUES (1, 'ahmed');

-- insert mutliple values into table t1
INSERT INTO t1 VALUES (2, 'aya'), (3, 'john');

-- create a table t2 based on t1
CREATE TABLE t3 AS TABLE t1;
CREATE TABLE t3 AS SELECT * FROM t1 ;
-- create a new table type 
CREATE TYPE t1_type AS (id int, first_name varchar(30));
-- create a table based on that TYPE
CREATE TABLE t4 OF t1_type;

 
CREATE TABLE t4
(
    last_name VARCHAR(30) ,
    phone CHAR(15)
)
 OF t1_type;

-- create a new data type
CREATE DOMAIN t1_domain AS varchar(30);


