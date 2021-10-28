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
echo "If you drank coffee, go to http://<your IP> to continue instalation"
echo "====================================================================="

