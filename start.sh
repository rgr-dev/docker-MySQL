#!/bin/bash

set -e

docker volume prune
docker-compose -f docker-compose.yml up -d
contIp=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' test-mysql)
echo -e "The IP of MySQL Database is : \e[92m$contIp"

exit 0