#!/bin/bash

# Start Docker containers
docker-compose up -d

# Wait for the database container to start
echo "Waiting for the database container to start..."
sleep 20  # Adjust the sleep time according to your environment and container startup time


# Variables
MYSQL_ROOT_PASSWORD=Sirgimmedistintion90%
MYSQL_CONTAINER=u5579496_csvs_dbserver_c  # Replace with your actual MySQL container name
MYSQL_DATABASE=csvs23db # Replace with your actual database name




# Wait for the database container to start
echo "Waiting for the database container to start..."
sleep 20  # Adjust based on your container startup time

# Try connecting with the new password
if docker exec -i $MYSQL_CONTAINER mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;" &>/dev/null; then
    echo "Connected to MySQL with the new password. No reset needed."
else
    echo "Failed to connect to MySQL with the new password. Attempting reset..."

    # Attempt to reset the password
    docker exec -i $MYSQL_CONTAINER mysql -uroot -p"CorrectHorseBatteryStaple" --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

    # Verify if the password reset was successful
    if docker exec -i $MYSQL_CONTAINER mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;" &>/dev/null; then
        echo "Password reset successful."
    else
        echo "Password reset failed. Please reset the password manually."
        # Provide manual reset instructions or automate further based on your requirements
    fi
fi


# Check if the 'suggestion' table exists in the database
if ! docker exec -i u5579496_csvs_dbserver_c mysql -uroot -p"Sirgimmedistintion90%" -e "USE csvs23db; SHOW TABLES LIKE 'suggestion';" | grep suggestion; then
    echo "Table 'suggestion' does not exist. Executing SQL script..."
    # Execute the SQL script
    docker exec -i u5579496_csvs_dbserver_c mysql -uroot -p"Sirgimmedistintion90%" csvs23db < /dbserver/sqlconfig/csvs23db.sql
    echo "SQL script has been executed."
else
    echo "Table 'suggestion' already exists. Skipping SQL script execution."
fi
