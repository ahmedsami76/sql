-- Active: 1688525394700@@pg-db@5432@sfpolice
-- 1. get the data from the below link
----  https://data.sfgov.org/Public-Safety/Police-Department-Incident-Reports-Historical-2003/tmnf-yvry/data
-- 2. save the csv file in the rdbms/databases/csv folder
-- 3. make sure the pg container is running and attach to its shell 
-- 4. create a table in the database using the below command
-- # psql -U postgres
-- postgres=# CREATE DATABASE sfpolice;
-- poatgres=# \c sfpolice
poatgres=# CREATE TABLE
    police_incident_reports (
        pd_id BIGINT,
        IncidentNum VARCHAR(10),
        "Incident Code" VARCHAR(10),
        Category VARCHAR(50),
        Descript VARCHAR(100),
        DayOfWeek VARCHAR(10),
        Date DATE,
        Time TIME,
        PdDistrict VARCHAR(10),
        Resolution VARCHAR(50),
        Address VARCHAR(100),
        X NUMERIC(9, 6),
        Y NUMERIC(9, 6),
        location VARCHAR(55),
        "SF Find Neighborhoods 2 2" FLOAT,
        "Current Police Districts 2 2" INT,
        "Current Supervisor Districts 2 2" INT,
        "Analysis Neighborhoods 2 2" INT,
        "DELETE - Fire Prevention Districts 2 2" INT,
        "DELETE - Police Districts 2 2" INT,
        "DELETE - Supervisor Districts 2 2" INT,
        "DELETE - Zip Codes 2 2" INT,
        "DELETE - Neighborhoods 2 2" INT,
        "DELETE - 2017 Fix It Zones 2 2" INT,
        "Civic Center Harm Reduction Project Boundary 2 2" INT,
        "Fix It Zones as of 2017-11-06 2 2" INT,
        "DELETE - HSOC Zones 2 2" INT,
        "Fix It Zones as of 2018-02-07 2 2" INT,
        "CBD, BID and GBD Boundaries as of 2017 2 2" INT,
        "Areas of Vulnerability, 2016 2 2" INT,
        "Central Market/Tenderloin Boundary 2 2" INT,
        "Central Market/Tenderloin Boundary Polygon - Updated 2 2" INT,
        "HSOC Zones as of 2018-06-05 2 2" INT,
        "OWED Public Spaces 2 2" INT,
        "Neighborhoods 2" INT
    );
-- postgres=# \COPY police_incident_reports FROM '/usr/databases/csv/Police_Department_Incident_Reports__Historical_2003_to_May_2018.csv'  DELIMITER ',' CSV HEADER QUOTE '"';

-- what is the data?
SELECT 
	pd_id, 
	incidentnum, 
	"Incident Code", 
	category, 
	descript, 
	dayofweek, 
	date, 
	"time", 
	pddistrict, 
	resolution, 
	address, 
	x, 
	y, 
	location 
-- 	"SF Find Neighborhoods 2 2", 
-- 	"Current Police Districts 2 2", 
-- 	"Current Supervisor Districts 2 2", 
-- 	"Analysis Neighborhoods 2 2"
-- 	"Civic Center Harm Reduction Project Boundary 2 2", 
-- 	"Fix It Zones as of 2017-11-06 2 2", 
-- 	"Fix It Zones as of 2018-02-07 2 2", 
-- 	"CBD, BID and GBD Boundaries as of 2017 2 2", 
-- 	"Areas of Vulnerability, 2016 2 2", 
-- 	"Central Market/Tenderloin Boundary 2 2", 
-- 	"Central Market/Tenderloin Boundary Polygon - Updated 2 2", 
-- 	"HSOC Zones as of 2018-06-05 2 2", 
-- 	"OWED Public Spaces 2 2", 
-- 	"Neighborhoods 2"
	FROM public.police_incident_reports LIMIT 100;

-- date span
SELECT DATE_PART('year', max(date)) , DATE_PART('year', min(date))  FROM public.police_incident_reports

-- drop columns marked to be deleted

-- make sure you have a connection created using the vscode extension

-- Exploring data

-- 1. How many police districts are there?
SELECT COUNT(DISTINCT pddistrict) FROM police_incident_reports;

-- How many neighborhoods are there?
SELECT COUNT('Neighborhoods 2') FROM police_incident_reports;

-- How many incidents by neighborhood?
SELECT "Neighborhoods 2" , COUNT(*) AS COUNT FROM police_incident_reports GROUP BY 1 order by COUNT(*); -- Try to visualize in pgadmin

-- Check the min and max number of incidents by neighborhood
SELECT MAX(s.COUNT) AS MAX, MIN(s.COUNT) AS MIN, AVG(s.COUNT) As AVG 
FROM (
    SELECT "Neighborhoods 2" AS Neighborhood, COUNT(*) FROM police_incident_reports GROUP BY "Neighborhoods 2" order by COUNT(*)
    ) s;


-- KPIs for incidents by neighborhood
-- declare min, max, and avg as variables


CREATE OR REPLACE FUNCTION avergae_no_of_incidents()
RETURNS INT 
AS $$
DECLARE 
    average integer := 0;

BEGIN
    SELECT AVG(s.COUNT) INTO average
    FROM (
        SELECT "Neighborhoods 2" AS Neighborhood, COUNT(*) FROM police_incident_reports GROUP BY "Neighborhoods 2" order by COUNT(*)
        ) s;
    return average;
END;
$$ LANGUAGE plpgsql;

select avergae_no_of_incidents()

SELECT "Neighborhoods 2" AS Neighborhood, COUNT(*), 
		CASE 
			WHEN COUNT(*) > avergae_no_of_incidents() THEN 'High'
			ELSE 'LOW'
		END  AS State
	FROM police_incident_reports GROUP BY "Neighborhoods 2" order by COUNT(*)


-- replace the function with a subquery
SELECT "Neighborhoods 2" AS Neighborhood, COUNT(*), 
		CASE 
			WHEN COUNT(*) > (SELECT AVG(s.COUNT) FROM (SELECT "Neighborhoods 2" AS Neighborhood, COUNT(*) FROM police_incident_reports GROUP BY "Neighborhoods 2" order by COUNT(*)) s) THEN 'High'
			ELSE 'LOW'
		END  AS State
	FROM police_incident_reports GROUP BY "Neighborhoods 2" order by COUNT(*)


-- Data Cleanup 
-- Deduplication using Group By and Distinct 
-- Data Cleaning using CASE WHEN and LIKE
-- Data Cleaning using TRIM, UPPER, LOWER, INITCAP, SUBSTRING, POSITION, LENGTH, CONCAT, REPLACE, TRANSLATE, REGEXP_REPLACE, REGEXP_MATCHES, REGEXP_SPLIT_TO_ARRAY, REGEXP_SPLIT_TO_TABLE, SPLIT_PART, TO_CHAR, TO_NUMBER, TO_DATE, TO_TIMESTAMP, TO_TIMESTAMP_TZ, TO_JSON, TO_JSONB, TO_ASCII, TO_HEX, TO_BASE64, TO_REGCLASS, TO_REGPROC, TO_REGPROCEDURE, TO_REGOPER, TO_RE
-- Type Conversion using CAST and :: 
SELECT pd_id FROM police_incident_reports LIMIT 3; -- it's bigint now 
SELECT pd_id*2 FROM police_incident_reports LIMIT 3; -- it's bigint now 
SELECT (pd_id::varchar) + 2 FROM police_incident_reports LIMIT 3; -- Error as it's varchar now
SELECT CAST(pd_id AS varchar) * 2 FROM police_incident_reports LIMIT 3; -- Error as it's varchar now

-- split string 
SELECT split_part(CAST(pd_id AS varchar), '0', 1) FROM police_incident_reports LIMIT 3; -- can be split now as it's string
SELECT split_part(pd_id, '0', 1) FROM police_incident_reports LIMIT 3; -- Error as it's bigint now and cannot be split 



-- Window Functions

select * from public.police_incident_reports limit 5;

select category, count(incidentnum) from police_incident_reports group by category;

--What if I want to display the count of incidents by category but still see the rest of the columns in the table?

select category, pddistrict, count(incidentnum) from police_incident_reports group by category, pddistrict --This will not work as this still shows the breakdown of the count by category then pddistrict

-- Must use the window function
select *, count(incidentnum) over() from police_incident_reports

-- take a window of the full table
Select category, pddistrict, descript, count(incidentnum) over() from police_incident_reports

-- change the scope of the window to the category alone
Select category, pddistrict, descript, count(incidentnum) over(partition by category) from police_incident_reports

-- if you would like to get the equivalent to Group By
Select category, count(incidentnum) over(partition by category) from police_incident_reports -- this will list all rows with the count without flattening the rows
-- You must add DISTINCT statement to the above to get the equivalent to Group By
Select DISTINCT category, count(incidentnum) over(partition by category) from police_incident_reports 

-- running count of pd_id by incident category
SELECT pd_id, category, count(pd_id) over(partition by category order by pd_id) from public.police_incident_reports;

<<<<<<< HEAD
-- the most ocurring category by year
SELECT category, date_part('year', date) as year, count(category) over(partition by date_part('year', date) order by count(category) desc) from public.police_incident_reports;


=======
SELECT pd_id, category, concat(cast(count(pd_id) over(partition by category order by pd_id) AS text), '/', cast(count(incidentnum) over(partition by category) as text)) from public.police_incident_reports;
>>>>>>> f1735f0 (updates to da)


-- row_number()
-- return a unique number for each row
select *, row_number() over() from police_incident_reports

-- you can create different windows by spcifying a partition
select category, pddistrict, date, row_number() over(partition by category) from police_incident_reports

-- order the window to change the row number
select category, pddistrict, date, row_number() over(partition by category order by date) from police_incident_reports

-- show the first 2 incidents by category and pddistrict
-- use subquery
select * from (
	select category, pddistrict, date, (row_number() over(partition by category order by date)) as rn  from police_incident_reports 
) x
where x.rn < 3

-- rank()

select category, pddistrict, rank() over(partition by "Incident Code" order by pddistrict) from police_incident_reports

-- dense_rank()
select category, pddistrict, dense_rank() over(partition by "Incident Code" order by pddistrict) from police_incident_reports



-- as another example create a new database and table 
create database hr;

-- create and populate employee table
CREATE TABLE employees (
	employee_id INT,
	first_name VARCHAR (20) DEFAULT NULL,
	last_name VARCHAR (25) NOT NULL,
	email VARCHAR (100) NOT NULL,
	phone_number VARCHAR (20) DEFAULT NULL,
	hire_date DATE NOT NULL,
	job_id INT NOT NULL,
	salary DECIMAL (8, 2) NOT NULL,
	manager_id INT DEFAULT NULL,
	department_id VARCHAR (25) DEFAULT NULL
);



INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (100,'Steven','King','steven.king@sqltutorial.org','515.123.4567','1987-06-17',4,24000.00,NULL,'Executive');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (101,'Neena','Kochhar','neena.kochhar@sqltutorial.org','515.123.4568','1989-09-21',5,17000.00,100,'Executive');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (102,'Lex','De Haan','lex.de haan@sqltutorial.org','515.123.4569','1993-01-13',5,17000.00,100,'Executive');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (103,'Alexander','Hunold','alexander.hunold@sqltutorial.org','590.423.4567','1990-01-03',9,9000.00,102,'IT');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (104,'Bruce','Ernst','bruce.ernst@sqltutorial.org','590.423.4568','1991-05-21',9,6000.00,103,'IT');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (105,'David','Austin','david.austin@sqltutorial.org','590.423.4569','1997-06-25',9,4800.00,103,'IT');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (106,'Valli','Pataballa','valli.pataballa@sqltutorial.org','590.423.4560','1998-02-05',9,4800.00,103,'IT');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (107,'Diana','Lorentz','diana.lorentz@sqltutorial.org','590.423.5567','1999-02-07',9,4200.00,103,'IT');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (108,'Nancy','Greenberg','nancy.greenberg@sqltutorial.org','515.124.4569','1994-08-17',7,12000.00,101,'Finance');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (109,'Daniel','Faviet','daniel.faviet@sqltutorial.org','515.124.4169','1994-08-16',6,9000.00,108,'Finance');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (110,'John','Chen','john.chen@sqltutorial.org','515.124.4269','1997-09-28',6,8200.00,108,'Finance');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (111,'Ismael','Sciarra','ismael.sciarra@sqltutorial.org','515.124.4369','1997-09-30',6,7700.00,108,'Finance');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (112,'Jose Manuel','Urman','jose manuel.urman@sqltutorial.org','515.124.4469','1998-03-07',6,7800.00,108,'Finance');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (113,'Luis','Popp','luis.popp@sqltutorial.org','515.124.4567','1999-12-07',6,6900.00,108,'Finance');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (114,'Den','Raphaely','den.raphaely@sqltutorial.org','515.127.4561','1994-12-07',14,11000.00,100,'Administration Assistant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (115,'Alexander','Khoo','alexander.khoo@sqltutorial.org','515.127.4562','1995-05-18',13,3100.00,114, 'Administration Assistant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (116,'Shelli','Baida','shelli.baida@sqltutorial.org','515.127.4563','1997-12-24',13,2900.00,114,'Administration Assistant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (117,'Sigal','Tobias','sigal.tobias@sqltutorial.org','515.127.4564','1997-07-24',13,2800.00,114,'Administration Assistant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (118,'Guy','Himuro','guy.himuro@sqltutorial.org','515.127.4565','1998-11-15',13,2600.00,114,'Administration Assistant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (119,'Karen','Colmenares','karen.colmenares@sqltutorial.org','515.127.4566','1999-08-10',13,2500.00,114,'Administration Assistant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (120,'Matthew','Weiss','matthew.weiss@sqltutorial.org','650.123.1234','1996-07-18',19,8000.00,100,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (121,'Adam','Fripp','adam.fripp@sqltutorial.org','650.123.2234','1997-04-10',19,8200.00,100,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (122,'Payam','Kaufling','payam.kaufling@sqltutorial.org','650.123.3234','1995-05-01',19,7900.00,100,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (123,'Shanta','Vollman','shanta.vollman@sqltutorial.org','650.123.4234','1997-10-10',19,6500.00,100,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (126,'Irene','Mikkilineni','irene.mikkilineni@sqltutorial.org','650.124.1224','1998-09-28',18,2700.00,120,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (145,'John','Russell','john.russell@sqltutorial.org',NULL,'1996-10-01',15,14000.00,100,'Sales');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (146,'Karen','Partners','karen.partners@sqltutorial.org',NULL,'1997-01-05',15,13500.00,100,'Sales');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (176,'Jonathon','Taylor','jonathon.taylor@sqltutorial.org',NULL,'1998-03-24',16,8600.00,100,'Sales');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (177,'Jack','Livingston','jack.livingston@sqltutorial.org',NULL,'1998-04-23',16,8400.00,100,'Sales');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (178,'Kimberely','Grant','kimberely.grant@sqltutorial.org',NULL,'1999-05-24',16,7000.00,100,'Sales');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (179,'Charles','Johnson','charles.johnson@sqltutorial.org',NULL,'2000-01-04',16,6200.00,100,'Sales');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (192,'Sarah','Bell','sarah.bell@sqltutorial.org','650.501.1876','1996-02-04',17,4000.00,123,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (193,'Britney','Everett','britney.everett@sqltutorial.org','650.501.2876','1997-03-03',17,3900.00,123,'Shipping');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (200,'Jennifer','Whalen','jennifer.whalen@sqltutorial.org','515.123.4444','1987-09-17',3,4400.00,101,'Public Accountant');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (201,'Michael','Hartstein','michael.hartstein@sqltutorial.org','515.123.5555','1996-02-17',10,13000.00,100,'Accounting Manager');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (202,'Pat','Fay','pat.fay@sqltutorial.org','603.123.6666','1997-08-17',11,6000.00,201,'Accounting Manager');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (203,'Susan','Mavris','susan.mavris@sqltutorial.org','515.123.7777','1994-06-07',8,6500.00,101,'President');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (204,'Hermann','Baer','hermann.baer@sqltutorial.org','515.123.8888','1994-06-07',12,10000.00,101,'Public Relations');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (205,'Shelley','Higgins','shelley.higgins@sqltutorial.org','515.123.8080','1994-06-07',2,12000.00,101,'Accounting');
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) VALUES (206,'William','Gietz','william.gietz@sqltutorial.org','515.123.8181','1994-06-07',1,8300.00,205,'Accounting');


-------
-- rank() and dense_rank()
-------
SELECT
    first_name,
    last_name,
    department_id,
    salary,
    RANK() OVER(partition by department_id ORDER BY salary DESC) rank
FROM
    employees;

SELECT
    first_name,
    last_name,
    department_id,
    salary,
    RANK() OVER(partition by department_id ORDER BY salary DESC) rank,
    DENSE_RANK() OVER(partition by department_id ORDER BY salary DESC) dense_rank
FROM
    employees;

    -- lead() and lag()
SELECT
    first_name,
    last_name,
    department_id,
    salary,
    LAG(salary, 1) OVER(partition by department_id ORDER BY salary DESC) lag,
    salary - LAG(salary, 1) OVER(partition by department_id ORDER BY salary DESC) diff
FROM
    employees;

SELECT
    first_name,
    last_name,
    department_id,
    salary,
    LEAD(salary, 1) OVER(partition by department_id ORDER BY salary DESC) lead,
    salary - LEAD(salary, 1) OVER(partition by department_id ORDER BY salary DESC) diff
FROM
    employees;


-- ntile()
SELECT
    first_name,
    last_name,
    department_id,
    salary,
    NTILE(4) OVER(partition by department_id ORDER BY salary) quartile
FROM
    employees
ORDER BY
    department_id,
    quartile;