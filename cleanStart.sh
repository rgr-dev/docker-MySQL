#!/bin/bash

set -e

clean_datadir_path(){
	if [ -d "./datadir" ]; then
		echo "Deleting datadir"
		sudo rm -rf datadir/
		mkdir datadir/
	else
		echo "No datadir Path for deleting"
	fi
}

init_clean_database(){
	echo "Init a Clean Database using .sql files in ./scripts"
	docker volume prune
	docker builder prune
	docker-compose -f docker-compose-SetUpDB.yml up -d
	contIp=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' PSCOREDEV-DB)
	echo -e "The IP of MySQL Database is : \e[92m$contIp"
}

clean_datadir_path
init_clean_database


exit 0