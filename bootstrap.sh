#!/usr/bin/env bash

##Based on this https://www.dev-metal.com/super-simple-vagrant-lamp-stack-bootstrap-installable-one-command/ provisioning script
##but with locale setting and nvm

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='{?quc9]xLnd:hT+('
PROJECTFOLDER='gyunu'

#set the locale, which causes issues with the package manager if not set
sudo locale-gen en_GB.UTF-8

# create project folder
sudo mkdir "/var/www/vhosts/${PROJECTFOLDER}"

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 5.5
sudo apt-get install -y apache2
sudo apt-get install -y php5

# install mysql and give password to installer

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo apt-get install php5-mysql

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/vhosts/${PROJECTFOLDER}/dist"
    <Directory "/var/www/vhosts/${PROJECTFOLDER}/dist">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
sudo echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart

# install git
sudo apt-get -y install git

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


#remove apache default index
rm -rf /var/www/html/index.html
