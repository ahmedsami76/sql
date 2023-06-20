-- create, drop, alter rename, etc
--

-- create database
CREATE DATABASE testdb;
CREATE DATABASE IF NOT EXISTS testdb;

-- drop database
DROP DATABASE testdb;
DROP DATABASE IF EXISTS testdb;

CREATE DATABASE testdb;

-- create table
USE testdb;
CREATE TABLE t1 (id INT, first_name VARCHAR(20));

-- drop table
DROP TABLE t1;

-- create table with column specs
CREATE TABLE t1 (
    id INT NOT NULL,
    first_name VARCHAR(20) NULL
);

SHOW COLUMNS FROM t1;

-- create table with more column specs
CREATE TABLE t1 (
    id MEDIUMINT NOT NULL,
    first_name VARCHAR(20) NULL,
    date_of_birth DATE NULL, -- add date type column
    country VARCHAR(25) NOT NULL DEFAULT 'Egypt' -- adding default value 
);

-- alter table
--
ALTER TABLE t1 ADD COLUMN last_name VARCHAR(25); -- add column
ALTER TABLE t1 DROP COLUMN last_name; -- drop column
ALTER TABLE t1 MODIFY COLUMN date_of_birth DATETIME; -- modify column definition
ALTER TABLE t1 RENAME COLUMN date_of_birth TO dob; -- change column name

ALTER TABLE t1 RENAME TO tbl1; -- rename table
RENAME TABLE tbl1 TO t1; -- rename table

-- like
CREATE TABLE t2 LIKE t1;

-- as select
CREATE TABLE t3 AS SELECT * FROM t1;

-- create view
CREATE VIEW v1 AS
SELECT id, first_name FROM t1;

-- alter view
ALTER VIEW v1 AS
SELECT first_name, id FROM t1;

-- DROP VIEW
DROP VIEW v1;

-- check schema and table inspection from workbench
SHOW CREATE TABLE t1;
SHOW CREATE DATABASE testdb;



