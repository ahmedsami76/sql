# Creating and using databases 
CREATE DATABASE lucy;
CREATE DATABASE IF NOT EXISTS lucy;

# Delete Database
DROP DATABASE lucy;
DROP DATABASE IF NOT EXISTS lucy;

############################################

# Check folder structure

# Creating TABLES
DROP DATABASE IF EXISTS sakila;
CREATE DATABASE sakila;
# Check folder structure

USE sakila;

CREATE TABLE actor (
    actor_id SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    first_name VARCHAR(45) DEFAULT NULL,
    last_name VARCHAR(45),
    last_update TIMESTAMP,
    PRIMARY KEY (actor_id)
);

# Check folder structure


#USE sakila;
create table actor (
    actor_id SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    first_name VARCHAR(45) DEFAULT NULL,
    last_name VARCHAR(45),
    last_updated TIMESTAMP,
    PRIMARY KEY (actor_id)
);

# Collation and Character Sets
SHOW CHARACTER SET;
SHOW COLLATION;
SHOW VARIABLES LIKE 'c%';


# Column Types 










INSERT INTO test_binary_data
VALUES (
        'something',
        'something',
        'something',
        'something'
    );
0x736F6D657468696E6700000000000000
SELECT d1
from test_binary_data;
create database sakila;
create table testdate (mydate DATE);
insert into testdate
VALUES ('1976/12/08')
select *
from testdate;
insert into testdate
VALUES ('2011/02/30')