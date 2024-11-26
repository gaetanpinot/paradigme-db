<?php
require_once __DIR__ . '/../vendor/autoload.php';
use iutnc\hellokant\query\Query;
use iutnc\hellokant\ConnectionFactory;
ConnectionFactory::makeConnectionFromFile(__DIR__ . '/config/pdoConfig.ini');
var_dump(Query::table('article')
    ->insert(
        ['descr' => "super velo",
            'nom' => "pp",
            'tarif' => 88,
            'id_categ' => 1]));
var_dump(Query::table('article')->where('descr','like','%velo%')->select(['id', 'nom', 'tarif'])->get());
