-- stored procedure
-- functions
-- triggers
-- views

--
-- stored procedures
--
DROP DATABASE IF EXISTS testdb;
CREATE DATABASE IF NOT EXISTS testdb;

USE testdb;

CREATE TABLE t1 (
    id INT, 
    first_name VARCHAR(20)
    );

DESC t1;

INSERT INTO t1 VALUES (1, 'ahmed'), (2, 'aya'), (3, 'john');

SELECT * FROM t1;

-- create stored procedure
CREATE PROCEDURE sp1()
BEGIN
    SELECT * FROM t1;
END;

-- call stored procedure
CALL sp1();

-- create stored procedure with parameters
CREATE PROCEDURE sp2(IN param_id INT)
BEGIN
    SELECT * FROM t1 WHERE id = param_id;
END;

-- call stored procedure
CALL sp2(2);

-- create stored procedure with parameters and return value
CREATE PROCEDURE sp3(IN param_id INT, OUT param_first_name VARCHAR(20))
BEGIN
    SELECT first_name INTO param_first_name -- assign value to param_first_name
    FROM t1 WHERE id = param_id;
END;

-- call stored procedure
CALL sp3(2, @first_name);
SELECT @first_name;


-- functions
--

-- create function

CREATE FUNCTION fn1(param_id INT) RETURNS CHAR(20)
DETERMINISTIC
BEGIN
    DECLARE fn CHAR(20);
    SET fn = (SELECT first_name FROM t1 WHERE id = param_id);
    RETURN fn;
END;

-- call function
SELECT fn1(3);
