#!/bin/bash
# The shebang line above specifies that this script should be executed with Bash, a Unix shell.

docker-compose down
# This command stops and removes all the containers, networks, and volumes defined in the docker-compose.yml file 
# in the current directory or any specified as an argument. It essentially cleans up all the resources specified 
# by Docker Compose to bring the application to a stopped state.

docker rmi -f u5579496/csvs_webserver_i u5579496/csvs_dbserver_i
# `docker rmi` is the Docker command used to remove one or more images.
# The `-f` flag forces the removal of the image even if it's being used in stopped containers or has dependent child images.
# `u5579496/csvs_webserver_i` and `u5579496/csvs_dbserver_i` are the names or IDs of the Docker images to be removed.
