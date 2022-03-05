#!/bin/bash
echo "###################################################"
echo "Preparing to launch script and installing prerequisites!"
echo "Please wait!"
echo "###################################################" 
if [ "$EUID" -ne 0 ]
  then
  echo -e "[\e[31mFAIL\e[0m] Script was not run as root, exiting!"
  exit
else
  echo -e "[\e[32m OK \e[0m] Script was run by root, continuing!"
fi
apt update
apt install -y aptitude
apt-get -y install expect



#lamp script

lamp () {
echo "Installing LAMP stack"
echo " "
read -p "Please enter the desired MySQL root password: " MYSQL_ROOT_PASS
echo " "
echo "Installing Apache"
aptitude install -y apache2 >> lamp-install.log

echo " "
echo "Installing MariaDB (MySQL)"
aptitude install -y mariadb-server >> lamp-install.log
aptitude install -y mariadb-client >> lamp-install.log
[ ! -e /usr/bin/expect ]
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none): \"
send \"n\r\"
expect \"Change the root password? \[Y/n\] \"
send \"y\r\"
expect \"New password: \"
send \"$MYSQL_ROOT_PASS\r\"
expect \"Re-enter new password: \"
send \"$MYSQL_ROOT_PASS\r\"
expect \"Remove anonymous users? \[Y/n\] \"
send \"y\r\"
expect \"Disallow root login remotely? \[Y/n\] \"
send \"y\r\"
expect \"Remove test database and access to it? \[Y/n\] \"
send \"y\r\"
expect \"Reload privilege tables now? \[Y/n\] \"
send \"y\r\"
expect eof
")

echo " "
echo "Installing PHP"
aptitude install -y php >> lamp-install.log
aptitude install -y libapache2-mod-php >> lamp-install.log
aptitude install -y php-mysql >> lamp-install.log
aptitude install -y php-redis php-zip >> lamp-install.log
service apache2 restart >> lamp-install.log

echo " "
echo "Installing PhpMyAdmin"
if [ ! -f /etc/phpmyadmin/config.inc.php ];
then
# MYSQL_ROOT_PASS='1234567890'

  echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS" |debconf-set-selections
  echo "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS" | debconf-set-selections

  aptitude install -y phpmyadmin >> lamp-install.log
 fi
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf >> lamp-install.log
sudo a2enconf phpmyadmin.conf >> lamp-install.log
sudo service apache2 restart >> lamp-install.log

a2enmod ssl
echo " "
echo " "
echo " "
echo "###################################################"
echo "Installation completed! (LAMP Method)"
echo "HTML folder located under /var/www/html/"
echo "PhpMyAdmin is located at http://YOUR_SERVER_IP/phpmyadmin"
echo "We recommend you reboot the machine if you can!"
echo "Install log is located in lamp-install.log"
echo "###################################################"
echo "MariaDB (MySQL) password: $MYSQL_ROOT_PASS"
echo "PhpMyAdmin username: phpmyadmin"
echo "PhpMyAdmin password: $MYSQL_ROOT_PASS"
echo "###################################################"
}


# lemp script

lemp () {
echo "Installing LEMP stack"
echo " "
read -p "Please enter the desired MySQL root password: " MYSQL_ROOT_PASS
echo " "
echo "Installing NGINX"
aptitude install -y nginx >> lemp-install.log

echo " "
echo "Installing MariaDB (MySQL)"
aptitude install -y mariadb-server >> lemp-install.log
aptitude install -y mariadb-client >> lemp-install.log
[ ! -e /usr/bin/expect ]
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none): \"
send \"n\r\"
expect \"Change the root password? \[Y/n\] \"
send \"y\r\"
expect \"New password: \"
send \"$MYSQL_ROOT_PASS\r\"
expect \"Re-enter new password: \"
send \"$MYSQL_ROOT_PASS\r\"
expect \"Remove anonymous users? \[Y/n\] \"
send \"y\r\"
expect \"Disallow root login remotely? \[Y/n\] \"
send \"y\r\"
expect \"Remove test database and access to it? \[Y/n\] \"
send \"y\r\"
expect \"Reload privilege tables now? \[Y/n\] \"
send \"y\r\"
expect eof
")

echo " "
echo "Installing PHP"
aptitude install -y php >> lemp-install.log
aptitude install -y php-mysql >> lemp-install.log
aptitude install -y php-redis php-zip >> lemp-install.log
service apache2 restart >> lemp-install.log

echo " "
echo "Installing PhpMyAdmin"
if [ ! -f /etc/phpmyadmin/config.inc.php ];
then
# MYSQL_ROOT_PASS='1234567890'

  echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS" |debconf-set-selections
  echo "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS" | debconf-set-selections

  aptitude install -y phpmyadmin >> lemp-install.log
 fi
sudo service nginx restart >> lemp-install.log

echo " "
echo " "
echo " "
echo "###################################################"
echo "Installation completed! (LEMP Method)"
echo "HTML folder located under /var/www/html/"
echo "PhpMyAdmin is located at http://YOUR_SERVER_IP/phpmyadmin"
echo "We recommend you reboot the machine if you can!"
echo "Install log is located in lemp-install.log"
echo "NOTE: THIS SCRIPT IS IN BETA, SOME ADDITIONAL CONFIGURATION MIGHT BE REQUIRED"
echo "###################################################"
echo "MariaDB (MySQL) password: $MYSQL_ROOT_PASS"
echo "PhpMyAdmin username: phpmyadmin"
echo "PhpMyAdmin password: $MYSQL_ROOT_PASS"
echo "###################################################"
}


apache () {
echo "Installing Apache2"
aptitude install -y apache2 >> apache-install.log
echo " "
echo " "
echo "###################################################"
echo "Installed Apache2"
echo "HTML folder located under /var/www/html"
echo "###################################################"
}

nginx () {
echo "Installing NGINX"
aptitude install -y nginx >> nginx-install.log
echo " "
echo " "
echo "###################################################"
echo "Installed NGINX"
echo "HTML folder located under /var/www/html"
echo "###################################################"
}

mysql () {
echo "Installing MariaDB (MySQL)"
echo " "
read -p "Please enter the desired MySQL root password: " MYSQL_ROOT_PASS
aptitude install -y mariadb-server >> mysql-install.log
aptitude install -y mariadb-client >> mysql-install.log
[ ! -e /usr/bin/expect ]
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none): \"
send \"n\r\"
expect \"Change the root password? \[Y/n\] \"
send \"y\r\"
expect \"New password: \"
send \"$MYSQL_ROOT_PASS\r\"
expect \"Re-enter new password: \"
send \"$MYSQL_ROOT_PASS\r\"
expect \"Remove anonymous users? \[Y/n\] \"
send \"y\r\"
expect \"Disallow root login remotely? \[Y/n\] \"
send \"y\r\"
expect \"Remove test database and access to it? \[Y/n\] \"
send \"y\r\"
expect \"Reload privilege tables now? \[Y/n\] \"
send \"y\r\"
expect eof
")
echo " "
echo " "
echo "###################################################"
echo "Installed MySQL"
echo "###################################################"
}

phpmyadmin () {
echo "Installing PhpMyAdmin"
echo " "
read -p "Please enter your MySQL root password: " PHPMYADMIN_MYSQL_ROOT_PASS
if [ ! -f /etc/phpmyadmin/config.inc.php ];
then

  echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/admin-pass password $PHPMYADMIN_MYSQL_ROOT_PASS" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_MYSQL_ROOT_PASS" |debconf-set-selections
  echo "phpmyadmin phpmyadmin/app-password-confirm password $PHPMYADMIN_MYSQL_ROOT_PASS" | debconf-set-selections

  aptitude install -y phpmyadmin >> phpmyadmin-install.log
 fi
echo " "
echo " "
echo "###################################################"
echo "Installed PhpMyAdmin"
echo "###################################################"
}

ssl () {
echo "Running SSL Script"
apt install -y certbot >> ssl-install.log
apt install -y python3-certbot-apache >> ssl-install.log
apt install -y python3-certbot-nginx >> ssl-install.log
echo " "
read -p "Please enter your domain: " sys_domain
SERVER_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
DOMAIN_RECORD=$(dig +short ${SYS_DOMAIN})
if [ "${SERVER_IP}" != "${DOMAIN_RECORD}" ]; then
  echo -e "\e[31m###################################################\e[0m"
  echo -e "\e[31mThe entered domain does not resolve to the primary public IP of this server.\e[0m"
  echo -e "\e[31mPlease make an A record pointing to your server's IP\e[0m"
  echo -e "\e[31mPlease restart the script!\e[0m"
  echo -e "\e[31m###################################################\e[0m"
  exit
else
  echo -e "\e[32m###################################################\e[0m"
  echo -e "\e[32mDomain resolved correctly, going further.\e[0m"
  echo -e "\e[32m###################################################\e[0m"
  certbot certonly -d sys_domain
fi
echo " "
echo " "
echo " "
echo "###################################################"
echo "SSL Script Finished"
echo "###################################################"
}




#menu

menu () {

echo " "
echo "###################################################"
echo "WebServer Stack installer script by vmo64"
echo "NOTE: Run this on a clean system install for a good install"
echo "Starting install in 5 seconds..."
echo "###################################################"
sleep 5;

echo "###################################################"
echo "Install options:"
echo " "
echo " "
echo "Stack options:"
echo "1 - Install LAMP Stack (Linux, Apache, MySQL, PHP + PhpMyAdmin)"
echo "2 - Install LEMP Stack (Linux, NGINX, MySQL, PHP + PhpMyAdmin)"
echo " "
echo "Individual options:"
echo "3 - Install Apache2"
echo "4 - Install NGINX"
echo "5 - Install MySQL"
echo "6 - Install PhpMyAdmin"
echo "7 - Run SSL Script"
echo " "
echo "Enter the option you want to run below (eg. 1), if the script quits then you have entered an invalid option."
echo "###################################################"
echo " "
read -p "Please enter the desired option: " SELECTION
echo " "


if [[ $SELECTION == "1" ]]
then
    lamp
fi

if [[ $SELECTION == "2" ]]
then
    lemp
fi

if [[ $SELECTION == "3" ]]
then
    apache
fi

if [[ $SELECTION == "4" ]]
then
    nginx
fi

if [[ $SELECTION == "5" ]]
then
    mysql
fi

if [[ $SELECTION == "6" ]]
then
    phpmyadmin
fi

if [[ $SELECTION == "7" ]]
then
    ssl
fi

}

menu
