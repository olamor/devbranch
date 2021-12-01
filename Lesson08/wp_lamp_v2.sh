#!/bin/bash

clear

DB=wordpress
USER=username
PASS=password
PASSWORDROOT=ROOTPassword

sleep 1

echo ""
echo ""
echo "------------- OK, we starting ----------------"
sleep 2

echo ""
echo ""

echo "=============================================="
echo "                Make coffee ..."
echo "=============================================="

echo "                      .."
echo "                    ..  .."
echo "                          .."
echo "                           .."
echo "                          .."
echo "                         .."
echo "                       .."
echo "              ##       ..    ####"
echo "              ##.............##  ##"
echo "              ##.............##   ##"
echo "              ##.............## ##"
echo "              ##.............###"
echo "               ##...........##"
echo "                #############"
echo "                #############"
echo "              #################"

echo "=============================================="
echo "               ... and relax!"
echo "=============================================="
sleep 3
echo ""
echo ""
echo ""

echo "=============================================="
echo "              Installing Apache2"
echo "=============================================="

echo ""
echo ""
echo ""

sleep 1

sudo apt update -y
sudo apt install apache2 apache2-utils -y
sudo a2enmod rewrite
sudo a2enmod ssl
sudo systemctl restart apache2


echo ""
echo ""
echo ""

echo "=============================================="
echo "              Installing MySQL"
echo "=============================================="

echo ""
echo ""
echo ""
sleep 1

sudo apt install mysql-client mysql-server -y

echo ""
echo ""
echo ""

echo "=============================================="
echo "          Secure Installation MySQL"
echo "=============================================="

echo ""
echo ""
echo ""
sleep 1

sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
sudo mysql -e "DROP DATABASE test;DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';"
sudo mysql -e "UPDATE mysql.user SET authentication_string=null WHERE User='root';"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$PASSWORDROOT';"

echo ""
echo ""
echo ""

echo "=============================================="
echo "              Installing PHP"
echo "=============================================="

echo ""
echo ""
echo ""
sleep 1

sudo apt install php7.4 php7.4-mysql libapache2-mod-php7.4 php7.4-cli php7.4-cgi php7.4-gd -y


echo ""
echo ""
echo ""

echo "=============================================="
echo "           Installing WordPress"
echo "=============================================="

echo ""
echo ""
echo ""

sleep 1

wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
sudo rsync -av wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo rm /var/www/html/index.html

echo ""
echo ""
echo ""

echo "=============================================="
echo "               Configuring SSL"
echo "=============================================="

echo ""
echo ""
echo ""

sudo apt-get install unzip git openssl -y
sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt -subj "/C=SI/ST=Ljubljana/L=Ljubljana/O=Security/OU=IT Department/CN=www.example.com"
cd ~
wget https://github.com/olamor/devbranch/archive/refs/heads/main.zip
unzip main.zip
sudo rm /etc/apache2/sites-available/default-ssl.conf
sudo cp devbranch-main/Lesson08/default-ssl.conf /etc/apache2/sites-available/
rm -r devbranch-main
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo service apache2 reload

echo ""
echo ""
echo ""

echo "=============================================="
echo "               Create DB"
echo "=============================================="

echo ""
echo ""
echo ""

sleep 1

mysql -uroot -p${PASSWORDROOT} -e "CREATE DATABASE $DB";
mysql -uroot -p${PASSWORDROOT} -e "CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASS'";
mysql -uroot -p${PASSWORDROOT} -e "GRANT ALL PRIVILEGES ON $DB.* TO '$USER'@'localhost'";
mysql -uroot -p${PASSWORDROOT} -e "FLUSH PRIVILEGES";
mysql -uroot -p${PASSWORDROOT} -e "show databases;"

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""

echo "=====================================================================
If you drank coffee, go to https://<your IP> to continue instalation

Info for DB:
-----------------------------------
DB name             - wordpress
USER name           - username
PASS for user       - password
PASS for root MySQL - ROOTPassword
-----------------------------------
====================================================================="
