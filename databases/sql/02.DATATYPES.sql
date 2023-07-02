-- https://www.w3schools.com/mysql/mysql_datatypes.asp
-- https://dev.mysql.com/doc/refman/8.0/en/data-types.html 
-- numeric data types
-- bit, tinyint, smallint, int, bigint
-- decimal, float, double
-- +----------------+-----------+-------------------+-------------------+
-- |	type		|	Length	|	Min				|	Max				|
-- +----------------+-----------+-------------------+-------------------+
-- |	tinyint		|	1		|	-128			|	127				|
-- |	smallint	|	2		|	-32768			|	32767			|
-- |	mediumint	|	3		|	-8388608		|	8388607			|
-- |	int			|	4		|	-21474783648	|	21474783647		|
-- |	bigint		|	8		|	-2E+63			|	2E+63			|
-- |	float		|	4		|	-3.402823466E+38|	-1.175494351E-38|
-- |	double		|	8		| -1.797xxxxxE+308	|	-2.225xxxxxE-308|
-- +----------------+-----------+-------------------+-------------------+
-- is there a way to find a data type of a value in MySQL? No :(

SELECT 1;
SELECT 1 / 2;
SELECT SQRT(15);
SELECT 2.1E+2, -3.98E-4;

-- type conversion
SELECT CONVERT( SQRT(15) , DECIMAL);-- will round up 
SELECT CEILING(SQRT(15));-- same as above

SELECT CONVERT( SQRT(15) , DECIMAL (5 , 2 )); -- will round up based on defined precision

-- -------------------
-- string data types
-- char, varchar, binary, varbindary, text, blob, enum
-- char (0 to 255) - varchar(0 to 65535)
-- binary (0 to 255) - varbinary (0 to 65535)
-- tinytext (255), text (64K), mediumtext (16MB), longtext (4GB)
-- tinyblob, blob, mediumblob, longblob (same as text but binary)

SELECT _latin1'string';
SELECT _binary'string';
SELECT N'string'; -- national character set
SELECT _utf8mb4'string' COLLATE utf8mb4_danish_ci;
SELECT HEX(CAST('a' AS BINARY));

-- --------------------
-- date and time data types
-- date, time, datetime, timestamp, year
-- date ('0000-00-00'), time ('00:00:00'), datetime ('0000-00-00 00:00:00'), year(0000)
--
SELECT DATE'2009-11-09';
SELECT TIMESTAMP'2012#12#31 11^30^45';
