#!/bin/bash     
#
#description     :Script for a clean Docker/Docker-Compose installation
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


echo -e "\e[33m**********BEGINNING INSTALLATION**********"

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


print_finish_message(){
  echo "****Installation complete.****"
  echo "All Docker components installed successfully."
  echo -e "Please \e[5m\e[33mLog out and log back\e[0m\e[0m in for use docker commands without sudo prefix."
  echo -"After, execute start.sh file for init a Mysql Container"
}

# run
remove_docker
install_docker
install_docker_compose
clean_docker
print_finish_message

exit 0