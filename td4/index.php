<?php

//Get liste praticien 

$baseUrl = 'localhost:8055/';
//Get liste praticien 
echo fetch($baseUrl.'/items/praticien')
.then(function ($response) {
  return $response.text();
});

//Get specialité d'ID 2 
echo fetch($baseUrl.'/items/specialite?filter={"id":{"_eq": "2"}}')
.then(function ($response) {
  return $response.text();
});

//Get spécialité d'id 2, libellé uniquement
echo fetch($baseUrl.'/items/specialite?filter={"id":{"_eq": "2"}}&fields=libelle')
.then(function ($response) {
  return $response.text();
});

// Un praticien avec sa spécialité (libellé)
echo fetch($baseUrl.'/items/praticien?fields=id, nom, prenom, specialites.libelle')
.then(function ($response) {
  return $response.text();
});

//Un groupement (nom, ville), avec son type (libelle) et la liste des praticiens (nom, prenom)
echo fetch($baseUrl.'/items/praticien')
.then(function ($response) {
  return $response.text();
});

//idem en ajoutant le libellé de la spécialité des praticiens 
echo fetch($baseUrl.'/items/praticien')
.then(function ($response) {
  return $response.text();
});

//Les groupements dont le nom de la ville contient "sur" avec leur type (libelle) et la liste des praticiens (nom, prénom, spécialité)
echo fetch($baseUrl.'/items/praticien')
.then(function ($response) {
  return $response.text();
});