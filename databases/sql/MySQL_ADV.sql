DROP DATABASE IF EXISTS mytest ;
CREATE DATABASE IF NOT EXISTS mytest ;
Alter DATABASE mytest READ ONLY = 0 ;

CREATE TABLE Employee
(
    EmployeeID INT PRIMARY Key AUTO_Increment, 

);

Show VIEW From (Table name)
RENAME TABLE Employee TO Teacher ;

DROP Table Teacher ;

Alter Table Employee ADD Phone varchar(50) ;

-- ALTER TABLE Employee ADD Phone char(20) ;

SELECT *
FROM Teacher ; 

TABLE Teacher ;

SELECT Instuctors LIKE Teacher ;
SELECT Instuctors AS SELECT * From Teacher ;


CREATE VIEW vw_modify_email
AS
ALTER Table Employee RENAME Column Phone TO Email CHAR(10);


ALTER Table Employee Modify Column Email varchar(50);

SELECT (Email::int)  --casting 

SELECT CAST(Email AS varchar(20));
Alter TABLE Employee Modify COLUMN Email int ;

ALTER Table Employee MODIFY Email AFTER EMployeeID ; 


ALTER Table Employee MODIFY Email First ;

ALTER Table Employee DROP COLUMN Email ; 

DROP Table Employee ;

INSERT INTO Employee 
VALUES (
            1235 , 'hazematww'
        ),
        (

        ),
        (

        );   


INSERT  INTO (EmployeeID, Phone) 
VALUES (123 ,'016565959'),(),(); 

SELECT *
FROM Employee 
WHERE hire_date IS NOT NULL; 


UPDATE Employee
SET Email = 'Omar' , 
    Phone = '0326265'
WHERE  EmployeeID = 2 ; 


SELECT CURDATE() , Now(), Current_Time() ;



SELECT employeeID, count(rental_id) 
FROM Employee
GROUP BY employeeID 
ORDER BY COUNT(rental_id) DESC ;

SELECT ADDDate('6/10/1995', 25); 

UNIQUE , KEYS , PRIMARY KEY 

CREATE Table t1 
(
    id int  ,
    Name CHAR(20), 
    Phone(20), 
    UNIQUE(id)
);

/* For forget UNIQUE when create table  */
ALter Table t1  ADD CONSTRAINT UNIQUE (id)  ;


CREATE Table t2
(
    CONSTRAINT cnst_first_name UNIQUE(first_name), 
    CHECK(LENGTH(first_Name) > 3) 
);



CREATE Table t6 (

        id int ,  
        Name char(20) ,
        price decimal(5,2) Default 0.0 
); 


ALter Table t6 Alter set default 0.0 ;


INSERT
Into t6 (id , Name)
VALUES(1, 'hazem');

TABLE t6 ;



--another example for using default 

CREATE TABLE t7
(
    transaction_id int , 
    transation_name VARCHAR(30) , 
    date DATE DEFAULT NOW()
); 


INSERT
INTO t7(transaction_id , tramsaction_name)
VALUES(5, 'jajds')


--Primary key 

CREATE Table t8
(
    student_id char(10) PRIMARY KEY Auto_increment , 
    name char(20), 
    constraint ct_stuid PRIMARY KEY (student_id)
)

Alter TABLE t8 Auto_increment = 100 ;  --treat with run time for table 
INSERT
INTO t8 
VALUES ('hazem' , 1) ;  /* start from 100*/

--Drop Foreign Key () REFERENCES

ALTER TABLE t8 DROP View (view Name )
Alter Table t8 DROP FOREIGN KEY (Name of FOREIGN key )

ALTER Table t8 ADD Constraint cts_foreign FOREIGN Key employeeid REFERENCES t8(employeeid);

SELECT id , name , phone 
FROM t9 AS tr9
WHERE NOT name = 'Ahmed'; --name != 'Ahmed'

SELECT id , DISTINCT name , phone 
FROM t9 AS tr9
WHERE name IN ('Ahmed' , 'Mohamed' , 'Amr');


SELECT name
FROM t9
WHERE name = 's' ; --error

--wild cards 
SELECT *
FROM t9 
WHERE name LIKE 's%';

--wild cards 
SELECT *
FROM t9 
WHERE name LIKE '%sh%';

SELECT 
FROM t9 
WHERE name LIKE '_oc';

DELIMITER $$
CREATE Function set_Avg(param_price Decimal(5,2))
RETURNS VARCHAR(30)
DETERMINISTIC 
BEGIN
    DECLARE Avg_check
    SET @AVG = (SELECT AVG(price) From Product )
    SET Avg_check = CASE 
        WHEN @AVG > parma_price THEN 'your price greater than avg amount' 
        WHEN  @AVG < param_price THEN 'your price smaller than avg amount'
        ELSE 'equal'

    RETURNS @Avg_check 
    END ;

END $$
DELIMITER ;


--sub queries 

SELECT employee_id , count(*) CASE 
    WHEN  count(*) > (SELECT employee_id, AVG(price) , employee_name , employee_address FROM Employee GROUP BY employee_id order by Avg(price) )THEN 'Hight' 
    ELSE  'low'
END
FROM  Employee 






SELECT set_AVG(19.021);