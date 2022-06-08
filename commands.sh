####
# Install MySQL
sudo apt install mysql-server -y
sudo systemctl start mysql

# Connect to mysql interactive shell
sudo mysql 
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'P@ssw0rd';
SOURCE /home/sami/relational-databases/databases/sakila-db/sakila-schema.sql;
USE sakila;
SOURCE /home/sami/relational-databases/databases/sakila-db/sakila-data.sql;
SHOW TABLES FROM sakila;
SELECT * FROM actor LIMIT 10;
DESC actor;
SHOW COLUMNS FROM actor;
SHOW CREATE TABLES actor\G

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
