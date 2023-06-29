-- Active: 1688066368502@@pg-db@5432@sfpolice
-- get the data from the below link
-- https://data.sfgov.org/Public-Safety/Police-Department-Incident-Reports-Historical-2003/tmnf-yvry/data

-- make sure you have a connection created using the vscode extension

-- Exploring data
-- 1. How many police districts are there?
SELECT COUNT(DISTINCT pddistrict) FROM police_incident_reports;

-- How many neighborhoods are there?
SELECT COUNT(DISTINCT "Neighborhoods 2") FROM police_incident_reports;

-- How many incidents by neighborhood?
SELECT "Neighborhoods 2", COUNT(*) AS COUNT FROM police_incident_reports GROUP BY "Neighborhoods 2" order by COUNT(*); -- Try to visualize in pgadmin

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

select category, count(incidentnum) from police_incident_reports group by category

--What if I want to display the count of incidents by category but still see the rest of the columns in the table?

select category, pddistrict, count(incidentnum) from police_incident_reports group by category, pddistrict --This will not work as this still shows the breakdown of the count by category then pddistrict

-- Must use the window function
select *, count(incidentnum) over() from police_incident_reports

-- take a window of the full table
Select category, pddistrict, descript, count(incidentnum) over() from police_incident_reports

-- change the scope of the window to the category alone
Select category, pddistrict, descript, count(incidentnum) over(partition by category) from police_incident_reports