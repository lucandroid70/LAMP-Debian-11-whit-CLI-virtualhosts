#!/bin/bash

###################### CREATED By Luca S. ITA Ministry of Defense employee ######################### 

sudo apt update
sudo apt upgrade

# install Apache web server
sudo apt install apache2 -y

# enable Apache modules
sudo a2enmod rewrite
sudo a2enmod ssl

sudo systemctl enable apache2 
sudo systemctl start apache2


# install MySQL server
sudo apt install mariadb-server -y
sudo systemctl enable mariadb 
sudo systemctl start mariadb

# secure the MySQL installation
sudo mysql_secure_installation

# install PHP and necessary modules
sudo apt install php libapache2-mod-php php-mysql phpmyadmin -y

# Enable the PHPMyAdmin Apache configuration file
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin




###################### CREATED By Luca S. ITA Ministry of Defense employee ######################### 

# prompt user for virtual host name
read -p "Inserisci il primo virtual host name 1 di 2: " vhost_name

# create virtual host directory
sudo mkdir -p /var/www/html/$vhost_name

# give ownership of directory to current user
sudo chown -R www-data:www-data /var/www/html/$vhost_name

# create virtual host configuration file
sudo bash -c "cat <<EOF > /etc/apache2/sites-available/$vhost_name.conf
<VirtualHost *:80>
    ServerName $vhost_name
    ServerAdmin webmaster@$vhost_name
    DocumentRoot /var/www/html/$vhost_name
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

# enable virtual host
sudo a2ensite $vhost_name.conf

# disable default virtual host
sudo a2dissite 000-default.conf

# restart Apache
#sudo systemctl restart apache2


###################### CREATED By Luca S. ITA Ministry of Defense employee #########################  

# prompt user for virtual host name
read -p "Inserisci il primo virtual host name 2 di 2: " vhost_name2

# create virtual host directory
sudo mkdir -p /var/www/html/$vhost_name2

# give ownership of directory to current user
sudo chown -R www-data:www-data /var/www/html/$vhost_name2

# create virtual host configuration file
sudo bash -c "cat <<EOF > /etc/apache2/sites-available/$vhost_name2.conf
<VirtualHost *:80>
    ServerName $vhost_name2
    ServerAdmin webmaster@$vhost_name2
    DocumentRoot /var/www/html/$vhost_name2
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

# enable virtual host
sudo a2ensite $vhost_name2.conf

# disable default virtual host
sudo a2dissite 000-default.conf

# restart Apache
sudo systemctl restart apache2


###################### CREATED By Luca Sabato, eploiee Minister of Defense ITA ######################### 




# Restart Apache for the changes to take effect
sudo systemctl restart apache2

# Install the SSL/TLS certificate and key
sudo apt install certbot python3-certbot-apache -y

# Obtain an SSL/TLS certificate and key
sudo certbot --apache


# Follow the prompts to select the appropriate virtual host and enter your email address

# Once the SSL/TLS certificate and key are installed, enable the SSL/TLS configuration for the virtual hosts
sudo a2enmod ssl
sudo a2enmod headers
sudo a2ensite default-ssl
sudo a2enmod rewrite

# Enable the virtual hosts
sudo a2ensite $vhost_name.conf
sudo a2ensite $vhost_name2.conf

# Restart Apache for the changes to take effect
sudo systemctl reload apache2

# Restart Apache for the changes to take effect
sudo systemctl restart apache2


# disable the default virtual host
sudo a2dissite 000-default.conf

