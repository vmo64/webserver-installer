#!/bin/sh
echo "###################################################"
echo "Preparing to launch script and installing prerequisites!"
echo "Please wait!"
echo "###################################################"
apt update
apt install -y aptitude
apt-get -y install expect
echo " "
echo "###################################################"
echo  "LAMP Stack install Script"
echo  "Contact me on discord NGX#6969 if you have any questions"
echo "Do not run this script on a system with already installed/broken lamp stack or it will fail!"
echo "Continuing in 5 seconds...."
echo "###################################################"
sleep 5;
echo " "
echo "###################################################"
echo "Pre-Installation Questions"
echo "###################################################"
echo " "
read -p "Please enter the desired MySQL root password: " MYSQL_ROOT_PASS
echo " "
echo "###################################################"
echo "Configuring Firewall (UFW)"
echo "This may cause ssh to disconnect"
echo "###################################################"
systemctl start ufw >> lamp-install.log
ufw allow 80 >> lamp-install.log
ufw allow 443 >> lamp-install.log
ufw allow 22 >> lamp-install.log
ufw allow 21 >> lamp-install.log
echo " "
echo "###################################################"
echo "Installing Apache2 Web Server"
echo "###################################################"
aptitude install -y apache2 >> lamp-install.log
systemctl status apache2 >> lamp-install.log
systemctl is-enabled apache2 >> lamp-install.log
echo " "
echo "###################################################"
echo "Installing MariaDB"
echo "###################################################"
aptitude install -y mariadb-server >> lamp-install.log
aptitude install -y mariadb-client >> lamp-install.log
systemctl status mariadb >> lamp-install.log
systemctl is-enabled mariadb >> lamp-install.log
echo " "
echo "###################################################"
echo "Configuring MariaDB"
echo "###################################################"
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
# send \"1234567890\r\"
echo " "
echo "###################################################"
echo "Installing PHP"
echo "###################################################"
aptitude install -y php >> lamp-install.log
aptitude install -y libapache2-mod-php >> lamp-install.log
aptitude install -y php-mysql >> lamp-install.log
aptitude install -y php-redis php-zip >> lamp-install.log
echo " "
echo "###################################################"
echo "Restarting Apache2 service!"
echo "###################################################"
systemctl restart apache2 >> lamp-install.log
echo " "
echo "###################################################"
echo "Installing PhpMyAdmin"
echo "###################################################"

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
sudo systemctl reload apache2.service >> lamp-install.log

echo " "
echo " "
echo " "
echo " "
echo " "
echo "###################################################"
echo "Installation completed!"
echo "HTML folder located under /var/www/html/"
echo "PhpMyAdmin is located at http://YOUR_SERVER_IP/phpmyadmin"
echo "We recommend you reboot the machine if you can!"
echo "Install log is located in lamp-install.log"
echo "###################################################"
echo "MariaDB (MySQL) password: 1234567890"
echo "PhpMyAdmin username: phpmyadmin"
echo "PhpMyAdmin password: 1234567890"
echo "###################################################"
