# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set non-interactive installation mode for apt-get and specify terminal type
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm

# Update the package list before installing any package
RUN apt-get update

# Install Nginx
RUN apt-get install -y nginx

# Install net-tools (contains utilities like ifconfig, netstat, etc.)
RUN apt-get install -y net-tools

# Install iputils-ping (provides ping command for network troubleshooting)
RUN apt-get install -y iputils-ping

# Install mlocate (provides updatedb and locate commands for searching files)
RUN apt install -y mlocate

# Install Vim text editor
RUN apt install -y vim

# Install sudo, allows running commands with elevated privileges
RUN apt-get install -y sudo

# Install systemctl, init system and service manager for Linux (Note: systemctl is not typically functional in a container)
RUN apt install -y systemctl

# Install PHP
RUN apt-get install -y php

# Install PHP-FPM (FastCGI Process Manager)
RUN apt-get install -y php-fpm

# Install PHP MySQL extension
RUN apt-get install -y php-mysql

# Remove setuid and setgid permissions from files that don't need them for security reasons
RUN find / -perm /6000 -type f \
    ! -path "/usr/bin/sudo" \
    ! -path "/usr/bin/passwd" \
    ! -path "/usr/bin/chfn" \
    ! -path "/usr/bin/newgrp" \
    -exec chmod a-s {} + || true

# Remove APT cache and temporary files to reduce the image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Give www-data user passwordless sudo access to specific services
RUN echo "www-data ALL=(ALL) NOPASSWD: /usr/sbin/nginx, /usr/sbin/php-fpm8.1" >> /etc/sudoers

# Create a new user 'alexis' and assign the user to a new group 'alexis'
RUN groupadd -r alexis && useradd -r -g alexis alexis

# Change the default shell for the 'alexis' user to bash
RUN chsh -s /bin/bash alexis

# Define a healthcheck to verify that the Nginx server is serving content
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Set environment variable for the home directory of 'alexis'
ENV HOME /home/alexis

# Copy local files into the image for Nginx web server
COPY webfiles/ /usr/share/nginx/html
COPY configfiles/nginx.conf     /etc/nginx/nginx.conf
COPY configfiles/php.ini        /etc/php/8.1/php.ini
COPY configfiles/www.conf       /etc/php/8.1/php-fpm.d/www.conf
COPY configfiles/php-fpm.conf   /etc/nginx/conf.d/php-fpm.conf
COPY configfiles/www.conf      /etc/php/8.1/fpm/pool.d/www.conf
COPY configfiles/docker-entrypoint.sh /

# Remove default Nginx files
RUN rm -f /usr/share/nginx/html/index.html /usr/share/nginx/html/nginx-logo.png /usr/share/nginx/html/poweredby.png

# Make the custom entrypoint script executable and change its owner to www-data
RUN chmod +x /docker-entrypoint.sh && \
    chown www-data:www-data /usr/share/nginx/html/*.php

# Ensure www-data owns the entrypoint script and set appropriate permissions
RUN chown www-data:www-data /docker-entrypoint.sh && \
    chmod 755 /docker-entrypoint.sh

# Expose port 80 to the host so it can accept HTTP traffic
EXPOSE 80

# Set the user to run the Nginx server as 'www-data' for security reasons
USER www-data

# Define the entrypoint script to be executed when the container starts
ENTRYPOINT ["/docker-entrypoint.sh"]
