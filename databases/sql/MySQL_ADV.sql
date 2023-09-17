CREATE DATABASE mytest ;
Alter DATABASE mytest READ ONLY = 0 ;

CREATE TABLE Employee
(
    EmployeeID INT PRIMARY Key AUTO_Increment , 

);


RENAME TABLE Employee TO Teacher ;

DRop Table Teacher ;


Alter Table Employee ADD Phone varchar(50) ;

SELECT *
FROM Teacher ; 

TABLE Teacher ;

SELECT Instuctors LIKE Teacher ;
SELECT Instuctors AS SELECT * From Teacher ;

ALTER Table Employee RENAME Column Phone TO Email CHAR(10);

ALTER Table Employee Modify Column Email varchar(50) ;

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
WHERE  EmployeeID = 1 ; 


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
ALter Table t1  ADD CONSTRAINT UNION (id)  ;


CREATE Table t2
(
    CONSTRAINT cnst_first_name UNIQUE(first_name), 
    CHECK(LENGTH(first_Name) > 3) 
);