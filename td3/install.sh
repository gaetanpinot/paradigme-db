#!/bin/bash
docker compose up -d
docker exec td3-php-1 composer install --working-dir=./src
docker exec td3-mongo-1 bash -c "mongoimport -d chopizza --collection produits --jsonArray < pizzashop.produits.json"
docker exec td3-mongo-1 bash -c "mongoimport -d chopizza --collection recettes --jsonArray < pizzashop.recettes.json"
