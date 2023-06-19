####
# Install MySQL
sudo apt install mysql-server -y
sudo systemctl start mysql # if systemctl is not available, use 'service mysql start'

# Connect to mysql interactive shell
sudo mysql 
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

# Check the file structure after creating the database and the table
cd /var/lib/mysql
ls -l testdb

# To restore a database called 'sakila' from a dump file
# Download the dump file from https://dev.mysql.com/doc/index-other.html
# make sure to download the schema and data files
# make sure to change the path to the dump file
SOURCE /home/sami/relational-databases/databases/sakila-db/sakila-schema.sql;
USE sakila;
SOURCE /home/sami/relational-databases/databases/sakila-db/sakila-data.sql;
SHOW TABLES FROM sakila;
SELECT * FROM actor LIMIT 10;
DESC actor;
SHOW COLUMNS FROM actor;
SHOW CREATE TABLES actor\G

# to check the tables in the current database
SHOW TABLES;

#### 
# cleanup
sudo apt remove mysql-server -y
sudo apt autoremove -y 

####
# clone repo
git config user.name "Ahmed Sami"
git config user.email "ahmed.sami@yahoo.com"
git clone https://github.com/ahmedsami76/relational-databases.git
cd relational-databases

# Use Docker
docker run -d -v /var/run/docker.sock:/tmp/docker.sock -v /etc/hosts:/tmp/hosts asami76/docker-hoster

docker-compose -f mysql.yml up -d 
