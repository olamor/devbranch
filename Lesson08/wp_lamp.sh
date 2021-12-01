#!/bin/bash

clear

echo "Please, enter the NAME of the new MySQL database!"
read DB

echo "Please, enter the USERNAME for the new MySQL database!"
read USER

echo "Please, enter the PASSWORD for new user"
read PASS

echo "Please, enter the PASSWORD for root user (MySQL)"
read PASSWORDROOT

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
echo "               Installing SSL"
echo "=============================================="

echo ""
echo ""
echo ""

sudo apt-get install unzip openssl -y
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


echo "====================================================================="
echo "If you drank coffee, go to https://<your IP> to continue instalation"
echo "====================================================================="
