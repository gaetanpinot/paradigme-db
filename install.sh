#!/usr/bin/bash 
source "./paradb.env";
source ./paradbpgsql.env;
contphp=paradb-phpparadb-1;
contsql=paradb-paradb.db-1;
contpgsql=paradb-pgsql.db-1;
contmongo=paradb-mongo-1;
# docker compose -p paradb up -d --build;

docker compose -p paradb up -d --build;

docker exec $contpgsql bash -c "PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -f /var/sql/prati.schema.sql";
docker exec $contpgsql bash -c "PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -f /var/sql/prati.data.sql";
docker exec $contsql bash -c "cat /var/sql/arti.sql | mariadb -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE";
docker exec $contmongo bash -c "mongoimport -d chopizza --collection produits --jsonArray < pizzashop.produits.json"
docker exec $contmongo bash -c "mongoimport -d chopizza --collection recettes --jsonArray < pizzashop.recettes.json"
docker exec $contphp composer install --working-dir=td1;
docker exec $contphp composer update --working-dir=td1;
docker exec $contphp composer install --working-dir=td2;
docker exec $contphp composer update --working-dir=td2;
docker exec $contphp composer install --working-dir=td3;
docker exec $contphp composer update --working-dir=td3;
