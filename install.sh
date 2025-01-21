#!/usr/bin/bash 
source "./paradb.env";
source ./paradbpgsql.env;
contphp=paradb-phpparadb-1;
contsql=paradb-paradb.db-1;
contmongo=paradb-mongo-1;

docker compose -p paradb up -d --build;

docker exec $contsql bash -c "cat /var/sql/arti.sql | mariadb -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE";
docker exec $contmongo bash -c "mongoimport -d chopizza --collection produits --jsonArray < pizzashop.produits.json"
docker exec $contmongo bash -c "mongoimport -d chopizza --collection recettes --jsonArray < pizzashop.recettes.json"
docker exec $contphp composer install --working-dir=td1;
docker exec $contphp composer update --working-dir=td1;
docker exec $contphp composer install --working-dir=td3;
docker exec $contphp composer update --working-dir=td3;
