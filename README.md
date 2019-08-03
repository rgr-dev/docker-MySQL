
# Mysql database in a Docker container

Tool for create a mysql DB container.

# Instructions:
If you have Docker and Docker-Composer installed go to step **3**.
If you want to execute the tool and the database was already loaded go to step **6**.

 1. Docker and docker-compose installation. exucute:
```sh
        $ cd SETUP
        $ ./FullDockerInstall.sh
```
 2. IF the installation process ends successfully go to step 3. If not visite the Docker and docker-compose docs.

 3. For brand new installation, first you must copy your .sql files into **/scripts** folder.For ensure execution order you must put in alphabetical order. 
 4. After .sql files copy into **/scripts** directory execute:
```sh
        $ ./cleanStart.sh
        WARNING! This will remove all local volumes not used by at least one container.
	Are you sure you want to continue? [y/N] y
	Total reclaimed space: 0B
	Creating network "docker-mysql_default" with the default driver
	Creating test-mysql ... done
	The IP of MySQL Database is : 192.168.224.2

```
 5. How can see, after execute the .sh command, the prompt print a message with the container IP. <br />
 Use for connect with MySQL database 

 6.  If you already executed the first 5 steps just execute this .sh:
```sh
        $ ./start.sh
```
 7.  this **start.sh** ignores **scripts/** path without execute any .sql file. 
 
 8. Por Stop the container execute:
 ```sh
        $ ./stop.sh
```


## Database connection params
User root = **root** <br /> 
Password = **mypassword**<br /> 

### Notas finales.
- Make sure to stop the **stop.sh**.
- Sorry for my english.