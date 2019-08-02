#!/bin/bash     
#
#description     :Script for a clean Docker/Docker-Compose instalation fallowed by Mysql container creation with PriceSurfer Database
#company         :Nemo Group
#author		       :Roger Moreno
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

echo "\e[33m**********BEGINNING INSTALLATION**********"

# docker-compose 1.24.0 installation
install_docker_compose() {
  echo "****DOCKER-COMPOSE INSTALLATION****"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# Check previous mysql content for avoid DB generation
check_datadir_path(){
  if [ -d "./datadir" ]; then
    echo "existe BD"
    cp -f ./scripts/plugins.sql ./scripts/initscript.sql
  else
    echo "No existe BD"
    mkdir datadir
    cp -f ./scripts/plugins_DB.sql ./scripts/initscript.sql
  fi
}

# Mysql Container init
init_mysql_container(){
  echo "****MySQL SetUp****"

  # Init Mysql Docker
  ./start.sh
}

# run
install_docker_compose
check_datadir_path
init_mysql_container


echo "\e[33m***********INSTALLATION FINISHED. Please Log out and log back for use Docker without sudo rights***********"
exit 0