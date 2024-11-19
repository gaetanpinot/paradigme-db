<?php
require_once __DIR__ . '/../vendor/autoload.php';
use iutnc\hellokant\query\Query;
use iutnc\hellokant\ConnectionFactory;
$co = ConnectionFactory::makeConnectionFromFile(__DIR__ . '/config/pdoConfig.ini');
$bd  = $co->prepare ("select * from article;");
$bd->execute([]);
$res  = $bd->fetchAll();
var_dump($res);
Query::table('employeuh')->where('nom','=','Pierre')->select(['nom', 'prenom', 'age'])->get();
