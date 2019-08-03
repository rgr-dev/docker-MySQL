#!/bin/bash     
#
#description     :Script for a clean Docker-Compose instalation
#company         :NemoGroup
#author		     :Roger Moreno
#date            :20190801
#version         :0.1    

#################################################################################
# 
# This script is being tested in Kubuntu/Ubuntu 18 LTS 
# WARN - This script removes all the docker containers and images that you have
#
#################################################################################

# Exit on first error
set -e

echo -e "\e[33m**********BEGINNING INSTALLATION**********"

# docker-compose 1.24.0 installation
install_docker_compose() {
  echo "****DOCKER-COMPOSE INSTALLATION****"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

print_finish_message(){
  echo "****Installation complete.****"
  echo "All Docker components installed successfully."
  echo -e "Please \e[5m\e[33mLog out and log back\e[0m\e[0m in for use docker commands without sudo prefix."
  echo "After, execute start.sh file for init a Mysql Container"
}

# run
install_docker_compose
print_finish_message

exit 0