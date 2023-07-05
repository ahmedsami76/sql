-- if elseif else 
-- case when then else end
-- while end while

-- create a sql statement on film_list view to return high if rent is more than 3 and low if less than 3 using if statement 

-- If sakila database is not created, create it using the below commands using mysql cli
-- SOURCE /usr/databases/sakila-db/sakila-schema.sql;
-- SOURCE /usr/databases/sakila-db/sakila-data.sql;

USE sakila;
SELECT title,
    price,
    if(price>3,'high','low') as rental_rate_status 
FROM film_list;


-- use case when then else end in sql statement
-- create a sql statement on film_list view to return high if rent is more than 3 and low if less than 3 using case when then else end statement
SELECT title,
    price,
    CASE 
        WHEN price > 3 THEN 'high'
        WHEN price < 3 AND price > 2 THEN 'medium'
        ELSE 'low'
    END AS rental_rate_status
FROM film_list;



-- use if stmt in functions or stored procedure

DELIMITER $$
CREATE FUNCTION fnComparePrice(p_price1 DECIMAL(5,2))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE v_result VARCHAR(30);

    SET @avg = (SELECT AVG(price) FROM film_list);
    IF p_price1 > @avg THEN
        SET v_result = 'price1 is greater';
    ELSE 
        SET v_result = 'price1 is less';
    END IF;
    RETURN v_result;
END $$
DELIMITER ;

use sakila;
SELECT AVG(price) FROM film_list;
SELECT fnComparePrice(2.99);






-- use case when then else end in functions or stored procedure
DELIMITER $$
CREATE FUNCTION fnComparePrice2(p_price1 DECIMAL(5,2))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE v_result VARCHAR(30);

    SET @avg = (SELECT AVG(price) FROM film_list);
    SET v_result = CASE 
        WHEN p_price1 > @avg THEN 'price1 is greater'
        WHEN p_price1 < @avg THEN 'price1 is less'
        ELSE 'price1 is equal'
    END;
    RETURN v_result;
END $$
DELIMITER ;



-- while end while 
-- WHILE condition DO
--     statements;
-- END WHILE;


CREATE PROCEDURE dowhile()
BEGIN 
    DECLARE v_counter INT DEFAULT 0;
    WHILE v_counter < 5 DO
        SET v_counter = v_counter + 1;
        SELECT v_counter;
    END WHILE;
END;


CALL dowhile();