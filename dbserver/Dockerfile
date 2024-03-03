# Use the official MariaDB version 10 image as the base image
FROM mariadb:10

# Remove a specific private key file which might have been added to the image.
# This is often done for security purposes to avoid using default keys.
RUN rm -f /etc/ssl/private/ssl-cert-snakeoil.key

# Update the package list, install some commonly used utilities like net-tools, mlocate, vim, and sudo,
# then clean up to keep the image size down.
RUN apt update && \
    apt-get install -y net-tools mlocate vim sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install the iputils-ping package which provides the ping command.
# This is useful for network troubleshooting within the container.
RUN apt-get update && \
    apt-get install -y iputils-ping

# Install apparmor profiles which can be used to enhance security by restricting program capabilities.
# Then clean up to keep the image size down.
RUN apt update && \
    apt-get install -y apparmor-profiles && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Find all files with setuid or setgid permissions (which grant users the ability to run an executable
# with the permissions of the executable's owner or group) and remove those permissions.
# Exceptions are made for common and necessary setuid/setgid binaries.
RUN find / -perm /6000 -type f \
    ! -path "/usr/bin/sudo" \
    ! -path "/usr/bin/passwd" \
    ! -path "/usr/bin/chfn" \
    ! -path "/usr/bin/newgrp" \
    -exec chmod a-s {} + || true

# Define a healthcheck command to check if the container is working properly.
# This first healthcheck uses curl to check if the HTTP server is responding.
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Define a second healthcheck command, which is incorrect because Dockerfiles should only contain one HEALTHCHECK.
# This command checks if MariaDB is responding to commands.
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD mysqladmin ping -h localhost || exit 1

# Copy a custom MySQL configuration file from the host to the container.
COPY mysqld.cnf /mysql/mysql.conf.d/mysqld.cnf

# Switch to the 'mysql' user for running subsequent commands. It's good practice to run processes
# as a non-root user for security reasons.
USER mysql

# Expose port 3306 to the host so that it can accept connections to the MariaDB server.
EXPOSE 3306
