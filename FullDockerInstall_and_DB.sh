#!/bin/bash     
#
#description     :Script for a clean Docker/Docker-Compose instalation fallowed by Mysql container creation with PriceSurfer Database
#company         :NemoGroup
#author          :Roger Moreno
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

# update software repositories
update() {
  echo "****UPDATING****"
  sudo apt update -y
}

check_directory_exists() {
  if [ -d "$DIRECTORY" ]; then
    return 1
  else
    return 0  
  fi
}

check_program_exists() {
  if [ type "$PROGRAM" ]; then
    return 1
  else
    return 0  
  fi
}

# remove old docker and docker-compose installation, if you have one
remove_docker() {
  echo "****REMOVING OLD DOCKER, DOCKER IMAGES AND CONTAINERS****"
  sudo apt-get purge -y docker-engine docker docker.io docker-ce
  sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
  
  if check_directory_exists /var/lib/docker == $1; then
    sudo rm -rf /var/lib/docker
  fi 
  
  if check_program_exists /etc/apparmor.d/docker == $1; then
    sudo rm -rf /etc/apparmor.d/docker
  fi 

  if check_program_exists /var/run/docker.sock == $1; then
    sudo rm -rf /var/run/docker.sock
  fi 
  
  if check_program_exists /usr/local/bin/docker-compose == $1; then
    sudo rm -rf /usr/local/bin/docker-compose
  fi 

  if check_program_exists /etc/docker == $1; then
    sudo rm -rf /etc/docker
  fi 

  if check_program_exists docker-ce-cli == $1; then
    sudo apt-get purge docker-ce-cli
  fi 

  if check_program_exists ~/.docker == $1; then
    sudo rm -rf ~/.docker
  fi 

  update
}

# docker installation
install_docker() {
  echo "****DOCKER INSTALLATION****"
  sudo apt install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  update
  sudo apt install docker-ce -y
  sudo usermod -aG docker ${USER}
}

# docker-compose 1.24.0 installation
install_docker_compose() {
  echo "****DOCKER-COMPOSE INSTALLATION****"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# Clean Docker Images and Containers
clean_docker(){
  echo "****Cleaning Docker****"

  # just in case
  containers=`sudo docker ps -a -q`
  if [ -n "$containers" ] ; then
    sudo docker stop $containers
  fi

  # Delete all containers
  containers=`sudo docker ps -a -q`
  if [ -n "$containers" ]; then
    sudo docker rm -f -v $containers
  fi

    # Delete all images
  images=`sudo docker images -q -a`
  if [ -n "$images" ]; then
    sudo docker rmi -f $images
  fi

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
  sudo ./start.sh
}

# run
remove_docker
install_docker
install_docker_compose
clean_docker
check_datadir_path
# init_mysql_container

echo "\e[33m***********INSTALLATION FINISHED. Please Log out and log back for use Docker without sudo rights***********"
exit 0