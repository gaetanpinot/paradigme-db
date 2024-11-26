#!/usr/bin/bash 
source ./paradb.env
source ./paradbpgsql.env
contphp=paradb-phpparadb-1
contsql=paradb-paradb.db-1
contpgsql=paradb-pgsql.db-1
# docker compose -p paradb up -d --build;

docker compose -p paradb up -d;
docker exec $contpgsql bash -c "PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -f /var/sql/prati.schema.sql";
docker exec $contpgsql bash -c "PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -f /var/sql/prati.data.sql";
docker exec $contsql bash -c "cat /var/sql/arti.sql | mariadb -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE";
docker exec $contphp composer install --working-dir=td1;

