-- stored procedure
-- functions
-- triggers
-- views

-- functions
--

-- create function

-- CREATE FUNCTION func_name (param1 type, param2 type, ...) RETURNS type
-- BEGIN
--     -- statements
-- END;


-- A function to calculate age
CREATE FUNCTION fnAge(p_birth_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_age INT;
    SET v_age = YEAR(CURDATE()) - YEAR(p_birth_date);
    RETURN v_age;
END;

SELECT fnAge('1990-01-01');

-- A function to calculate the area of a circle
DELIMITER $$
CREATE FUNCTION fnArea(p_radius DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_area DECIMAL(10,2);
    SET v_area = PI() * p_radius * p_radius;
    RETURN v_area;
END $$
DELIMITER ;

SELECT fnArea(5);



-- we can also execute routines against existing objects
CREATE FUNCTION fn1(param_id INT) RETURNS CHAR(20)
DETERMINISTIC
BEGIN
    DECLARE fn CHAR(20);
    SET fn = (SELECT first_name FROM t1 WHERE id = param_id);
    RETURN fn;
END;

-- call function
SELECT fn1(3);


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
    SELECT @first_name;
END;

-- call stored procedure
CALL sp3(2, @first_name);
SELECT @first_name;


