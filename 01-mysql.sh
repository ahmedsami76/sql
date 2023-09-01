####
docker run --rm -it -v $(pwd)/databases:/usr/databases ubuntu:latest bash

# Install MySQL from root user
apt update && apt full-upgrade -y
apt install mysql-server -y
service mysql start # or  'systemctl start mysql' if systemd is installed

# Connect to mysql interactive shell
mysql 
# To allow remote connections from root user to mysql server
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'P@ssw0rd';

# to list the current databases
SHOW DATABASES;

# to check the folder where the databases are stored
SHOW VARIABLES WHERE Variable_name = 'datadir';

# to create a database called testdb
CREATE DATABASE testdb;

# to create a table called tbl1
USE testdb;
CREATE TABLE tbl1 (id INT, name VARCHAR(20));
exit




# Check the file structure after creating the database and the table
cd /var/lib/mysql
ls -l testdb

# To restore a database called 'sakila' from a dump file
# Download the dump file from https://dev.mysql.com/doc/index-other.html
# make sure to download the schema and data files
# make sure to change the path to the dump file
SOURCE /usr/databases/sakila-db/sakila-schema.sql;
USE sakila;
SOURCE /usr/databases/sakila-db/sakila-data.sql;
SHOW TABLES FROM sakila;
SELECT * FROM actor LIMIT 10;
DESCRIBE actor;
SHOW COLUMNS FROM actor;
SHOW CREATE TABLE actor\G


#### 
# cleanup
sudo apt remove mysql-server -y
sudo apt autoremove -y 

####
# clone repo
git clone https://github.com/ahmedsami76/sql.git
cd sql

# Use Docker
docker run -d -v /var/run/docker.sock:/tmp/docker.sock -v /etc/hosts:/tmp/hosts asami76/docker-hoster

docker-compose -f mysql.yml up -d 
