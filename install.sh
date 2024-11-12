#!/usr/bin/bash 
source ./paradb.env
contphp=paradb-phpparadb-1
contsql=paradb-paradb.db-1
docker compose -p paradb up -d --build
docker exec $contsql mariadb -U $MYSQL_USER --password=$MYSQL_PASSWORD  /var/sql/arti.sql > $MYSQL_DATABASE
docker exec $contphp composer install --working-dir=td1

