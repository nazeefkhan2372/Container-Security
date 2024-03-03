#!/bin/bash


# Create directory for PHP-FPM socket
mkdir -p /run/php/

# Remove the private key retrieved when scanning with trivy 
rm /etc/ssl/private/ssl-cert-snakeoil.key

if [ -n "$ROOT_PASSWORD" ]; then
  echo "root:${ROOT_PASSWORD}" | chpasswd
fi

 Check and set the alexis user password if specified
if [ -n "$ALEXIS_PASSWORD" ]; then
  echo "alexis:${ALEXIS_PASSWORD}" | chpasswd
fi

# Start Nginx and PHP-FPM directly
sudo /usr/sbin/nginx
sudo /usr/sbin/php-fpm8.1 -F