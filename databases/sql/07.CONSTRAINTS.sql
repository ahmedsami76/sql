-- Active: 1687117690530@@mysql-db@3306@testdb
show databases;

DROP DATABASE IF EXISTS testdb;
CREATE DATABASE IF NOT EXISTS testdb;


-- unique constraint

-- create table

USE testdb;

DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
    id INT UNIQUE, 
    first_name VARCHAR(20)
    );
DESC t1;

INSERT INTO t1 VALUES (1, 'ahmed'), (2, 'aya'), (3, 'john');

TABLE t1;

-- insert a row with the same id 
INSERT INTO t1 VALUES (1, 'ali'); -- error

-- other ways to define unique constraint
CREATE TABLE t2 (
    id INT, 
    first_name VARCHAR(20),
    UNIQUE (id)
    );
DESC t2;

CREATE TABLE t3 (
    id INT, 
    first_name VARCHAR(20),
    CONSTRAINT id_unique UNIQUE (id)
    );
DESC t3;

-- auto increment
CREATE TABLE t4 (
    id INT AUTO_INCREMENT, 
    first_name VARCHAR(20),
    CONSTRAINT id_unique UNIQUE (id)
    );
DESC t4;

-- insert a row without id
INSERT INTO t4 (first_name) VALUES ('ahmed');
TABLE t4;
INSERT INTO t4 (first_name) VALUES ('sami'), ('aya');

-- insert a row with id
INSERT INTO t4 VALUES (10, 'ali');
INSERT INTO t4 (first_name) VALUES ('hasan');

-- check the auto increment value
SHOW VARIABLES LIKE 'auto_increment%';

-- check constraints
CREATE TABLE t5 (
    id INT AUTO_INCREMENT, 
    first_name VARCHAR(20),
    CONSTRAINT id_unique UNIQUE (id),
    CHECK (LENGTH(first_name) > 4)
    );

DESC t5; -- won't show the check constraint
SHOW CREATE TABLE t5; -- will show the check constraint
-- insert a row with first_name length > 4
INSERT INTO t5 (first_name) VALUES ('ahmed');

-- insert a row with first_name length <= 4
INSERT INTO t5 (first_name) VALUES ('ali'); -- error
TABLE t5;
-- drop constraint
ALTER TABLE t5 DROP CONSTRAINT id_unique;

-- primay and foreign keys
CREATE TABLE t6 (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(20),
    CONSTRAINT id_unique UNIQUE (id)
    );

-- another way to define primary key
CREATE TABLE t6 (
    id INT AUTO_INCREMENT, 
    first_name VARCHAR(20),
    CONSTRAINT id_unique UNIQUE (id),
    PRIMARY KEY (id)
    );

-- insert a few rows into t6
INSERT INTO t6 (first_name) VALUES ('ahmed'), ('ali'), ('aya');
TABLE t6;

-- insert a row with existing id
INSERT INTO t6 VALUES (1, 'sami'); -- error

-- create a table t7 with foreign key
CREATE TABLE t7 (
    id INT, 
    class VARCHAR(20),
    FOREIGN KEY (id) REFERENCES t6(id)
    );
TABLE t7;

-- insert a few rows into t7
INSERT INTO t7 
VALUES  (1, 'Math'), 
        (1, 'English'), 
        (2, 'Math'), 
        (3, 'Science'),
        (3, 'Math');        
TABLE t7;

-- insert a row with non-existing id
INSERT INTO t7 VALUES (4, 'Math'); -- error
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;

-- reverse engineer in mysql workbench
