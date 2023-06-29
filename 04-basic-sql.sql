# 1. Creating and using databases 
CREATE DATABASE lucy;
CREATE DATABASE IF NOT EXISTS lucy;

# Delete Database
DROP DATABASE lucy;
DROP DATABASE IF NOT EXISTS lucy;

############################################

# Check folder structure

# 2. Creating TABLES
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

SHOW DATABASES;
SHOW TABLES FROM sakila;
SHOW COLUMNS FROM actor;
DESC sakila.actor;


# Collation and Character Sets
SHOW CHARACTER SET;
SHOW COLLATION;
SHOW VARIABLES LIKE 'c%';

###############################
# Column Types 


## Numeric
### INTEGER
-- INT[(width)] [UNSIGNED] [ZEROFILL]
-- BIGINT[(width)] [UNSIGNED] [ZEROFILL]

CREATE TABLE test_bigint (id BIGINT UNSIGNED);
INSERT INTO test_bigint VALUES (18446744073709551615);
INSERT INTO test_bigint VALUES (184467440737095516*100);

-- BOOL[(width)]
CREATE TABLE test_bool (i BOOL);
INSERT INTO test_bool VALUES (true),(false);
SELECT * FROM test_bool;

INSERT INTO test_bool VALUES (1),(0),(-128),(127);
SELECT i, IF(i,"true","false") FROM test_bool;


### Fixed-point types
-- DECIMAL[(width[,decimals])] [UNSIGNED] [ZEROFILL]
CREATE TABLE test_decimal (d DECIMAL(6,2));
INSERT INTO test_decimal VALUES (1234.56);
INSERT INTO test_decimal VALUES (123.456);
INSERT INTO test_decimal VALUES (12.3456);
INSERT INTO test_decimal VALUES (123456.78); -- Error
SELECT * FROM test_decimal;


### Floating-point types
-- FLOAT[(width, decimals)] [UNSIGNED] [ZEROFILL]
-- DOUBLE[(width, decimals)] [UNSIGNED] [ZEROFILL]

CREATE TABLE wage (monthly DOUBLE);
INSERT INTO wage VALUES (50000/12);
SELECt * FROM wage;
SELECT monthly*12 FROM wage;
SELECT ROUND(monthly*12,5) FROM wage;


### String types
-- VARCHAR(width) [CHARACTER SET charset_name] [COLLATE collation_name]
CREATE TABLE test_varchar_trailing(d VARCHAR(2) UNIQUE);
INSERT INTO test_varchar_trailing VALUES ('a'), ('a ');
SELECT d, LENGTH(d) FROM test_varchar_trailing;
INSERT INTO test_varchar_trailing VALUES ('a  '); -- error

-- BINARY[(width)] and VARBINARY(width)
CREATE TABLE test_binary_data (
    d1 BINARY(16),
    d2 VARBINARY(16),
    d3 CHAR(16),
    d4 VARCHAR(16)
    );

INSERT INTO test_binary_data
VALUES (
        'something',
        'something',
        'something',
        'something'
    );
SELECT * FROM test_binary_data; -- then try mysql>

SELECT UPPER(d2), UPPER(d4) FROM test_binary_data; -- try mysql> 

SELECT CAST(d1 AS CHAR) d1t, CAST(d2 AS CHAR) d2t FROM test_binary_data; -- try mysql>


### Date and time types
-- DATE
-- YYYY-MM-DD or YY-MM-DD
-- YYYY/MM/DD, YYYY:MM:DD, YY-MM-DD

CREATE TABLE testdate (mydate DATE);
INSERT INTO testdate VALUES ('2020/02/1');
INSERT INTO testdate VALUES ('2020-02-2');
INSERT INTO testdate VALUES ('2020:02:3');
INSERT INTO testdate VALUES ('20200203');
INSERT INTO testdate VALUES (NOW());

SELECT * FROM testdate;
INSERT INTO testdate VALUES ('2020-02-0'); -- error
INSERT INTO testdate VALUES ('2020-02-30'); -- error

-- TIME [fraction]
-- HHH:MM:SS, DD HH:MM:SS[.fraction], HH:MM:SS[.fraction], DD HH:MM, HH:MM, DD HH, or SS[.fraction] 
CREATE TABLE test_time(id SMALLINT, mytime TIME);
INSERT INTO test_time VALUES(1, "2 13:25:59");
INSERT INTO test_time VALUES(2, "35 13:25:59"); -- error
INSERT INTO test_time VALUES(3, "900.32");
INSERT INTO test_time VALUES(4, NOW()); 

SELECT * FROM test_time;

-- TIMESTAMP[(fraction)] and DATETIME[(fraction)]
-- YYYY-MM-DD HH:MM:SS[.fraction][time zone offset]

CREATE TABLE test_timestamp(id SMALLINT, mytimestamp TIMESTAMP);
INSERT INTO test_timestamp VALUES(1, NOW());
SELECT * FROM test_timestamp;

## Keys and Indexes
### PRIMARY KEY 
SHOW INDEX FROM actor;
SHOW CREATE TABLE actor;

CREATE TABLE customer_mod (
    customer_id smallint unsigned NOT NULL AUTO_INCREMENT,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    email varchar(50) DEFAULT NULL,
    PRIMARY KEY (customer_id),
    KEY idx_names_email (first_name, last_name, email)
    );

# drop and re import sakila database
# examine indexes on actor table
SHOW INDEX FROM actor;

SELECT actor_id,first_name,last_name,last_update 
FROM actor
WHERE last_name = 'SWANK';

EXPLAIN SELECT actor_id,first_name,last_name,last_update 
FROM actor
WHERE last_name = 'SWANK';

####
# The AUTO_INCREMENT Feature
SHOW CREATE TABLE actor;

INSERT INTO actor VALUES (NULL, 'Magdy', 'Shatta', NOW());
INSERT INTO actor VALUES (NULL, 'Samah', 'Anwar', NOW());
SELECT * FROM actor;

#####
# 3. Altering Structures

## Adding, Removing, and Changing Columns

-- RENAME rename column only
ALTER TABLE language RENAME COLUMN last_update TO last_updated_time;
SHOW COLUMNS FROM language;

-- CHANGE change cloumn name and specs
ALTER TABLE language 
CHANGE last_updated_time last_updated_time2 TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- MODIFY Change column specs
ALTER TABLE language MODIFY name CHAR(20) DEFAULT 'n/a';

-- ADD add a new column to the TABLE
SHOW COLUMNS FROM language;
ALTER TABLE language ADD native_name CHAR(20) FIRST;
SHOW COLUMNS FROM language;

-- DROP to remove a column from a table 
ALTER TABLE language DROP native_name;

## Adding, Removing, and Changing Indexes
CREATE TABLE no_pk (id INT);
INSERT INTO no_pk VALUES (1),(2),(3);
ALTER TABLE no_pk ADD PRIMARY KEY (id);
DESC no_pk;
SHOW INDEX FROM no_pk;
ALTER TABLE no_pk DROP PRIMARY KEY;


## Renaming Tables and Altering Other Structures
-- Rename a table
ALTER TABLE language RENAME TO languages;
-- same as 
RENAME TABLE languages TO language; 

-- You can use rename to move tables between databases 
CREATE DATABASE sakila_new;
RENAME TABLE sakila.language TO sakila_new.language;

# 4. Deleting Structures
## Dropping Databases

DROP DATABASE sakila_new;
DROP DATABASE IF EXISTS sakila_new;

# Removing Tables
CREATE TABLE temp (id SERIAL PRIMARY KEY);
DROP TABLE temp;
DROP TABLE IF EXISTS temp;

DROP TABLE IF EXISTS temp, temp1, temp2;
SHOW WARNINGS;










