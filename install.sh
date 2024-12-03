#!/usr/bin/bash 
source ./paradb.env
contphp=paradb-phpparadb-1
contsql=paradb-paradb.db-1
docker compose -p paradb up -d --build
docker exec $contsql bash -c "cat /var/sql/arti.sql | mariadb -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE"
docker exec $contphp composer install --working-dir=td1

