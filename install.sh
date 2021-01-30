#!/bin/sh
clear
echo "###################################################"
echo  "LAMP Stack install Script"
echo  "Contact me on discord NGX#6969 if you have any questions"
echo "Do not run this script on a system with already installed/broken lamp stack or it will fail!"
echo "Continuing in 5 seconds...."
echo "###################################################"
sleep 5;
echo "###################################################"
echo "Updating System!"
echo "###################################################"
aptitude update
echo "###################################################"
echo "Installing Apache2 Web Server"
echo "###################################################"
aptitude install -y apache2
systemctl status apache2
systemctl is-enabled apache2
clear
echo "###################################################"
echo "Installing MariaDB"
echo "###################################################"
aptitude install -y mariadb-server
aptitude install -y mariadb-client
systemctl status mariadb
systemctl is-enabled mariadb
clear
echo "###################################################"
echo "Configuring MariaDB"
echo "Please follow this guide!"
echo "Set a root password? Y"
echo "Remove anonymous users? Y"
echo "Disallow root login remotely? Y"
echo "Remove test database and access to it? Y"
echo "Reload privilege tables now? Y"
echo "Continuing in 15 seconds..."
echo "###################################################"
sleep 15s;
mysql_secure_installation
clear
echo "###################################################"
echo "Installing PHP"
echo "###################################################"
aptitude install -y php
aptitude install -y libapache2-mod-php
aptitude install -y php-mysql
aptitude-cache search php | grep php-
aptitude install -y php-redis php-zip
clear
echo "###################################################"
echo "Restarting Apache2 service!"
echo "###################################################"
systemctl restart apache2
clear
echo "###################################################"
echo "Installing PhpMyAdmin"
echo "Please follow this guide!"
echo "If you select yes you will be prompted there questions."
echo "Web Server to reconfigure automatically: apache2"
echo "Configure database for phpmyadmin with dbconfig-common: Yes"
echo "MySQL application password for phpmyadmin: The password you set while making root password earlier"
echo "###################################################"
echo "Continuing in 15 seconds..."
echo "###################################################"
sleep 15s;
aptitude install -y phpmyadmin
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin.conf
sudo systemctl reload apache2.service
sleep 2s;
clear
echo "###################################################"
echo "Installation completed!
echo "HTML folder located under /ver/www/html/"
echo "PhpMyAdmin is located at http://YOUR_SERVER_IP/phpmyadmin"
echo "We recommend you reboot the machine if you can!"
echo "###################################################"
