#!/bin/bash
apt-get -y update && sudo apt upgrade -y
apt-get -y install nginx
apt-get -y install mysql-server
add-apt-repository universe
apt-get -y install php-fpm
apt-get install php8.1-gd
apt-get -y install php-mysql
apt-get -y install net-tools

echo "12 2 * * * root find /tmp -depth -mtime +14 -size +5 -exec rm -rf {} \;" >> /etc/crontab
echo PubkeyAcceptedKeyTypes +ssh-rsa >>/etc/ssh/sshd_config
systemctl start sshd
systemctl enable nginx
systemctl start nginx
systemctl enable mysql
systemctl start mysql
