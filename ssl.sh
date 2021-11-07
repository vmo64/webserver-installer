#!/bin/sh
echo "###################################################"
echo "Preparing to launch script and installing prerequisites!"
echo "Please wait!"
echo "###################################################"
apt update >> x3-ssl.log
apt install -y certbot >> x3-ssl.log
sudo apt install -y python3-certbot-apache >> x3-ssl.log
echo " "
echo "###################################################"
echo "Let's Encrypt SSL Script"
echo  "Contact me on discord NGX#9909 if you have any questions"
echo "Continuing in 5 seconds...."
echo "###################################################"
sleep 5;
echo " "
certbot certonly --apache
echo " "
echo "###################################################"
echo "Let's Encrypt SSL is installed!"
echo "###################################################"
