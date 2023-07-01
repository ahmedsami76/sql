-- make sure you have the mysql.yml compose up and running and you execute the below commands from mysql-workbench or the vscode database client extention
SOURCE /usr/databases/sakila-db/sakila-schema.sql;
USE sakila;
SOURCE /usr/databases/sakila-db/sakila-data.sql;

SHOW TABLES FROM sakila;
