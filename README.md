# LAMP-Debian-11-whit-CLI-virtualhosts
I create script sh, for Debian 11 LAMP whit insert name CLI for two VirtualHost. 


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


