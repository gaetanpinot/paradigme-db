<?php
require_once __DIR__ . '/../vendor/autoload.php';
use iutnc\hellokant\models\Article;
use iutnc\hellokant\models\Categorie;
use iutnc\hellokant\query\Query;
use iutnc\hellokant\ConnectionFactory;
ConnectionFactory::makeConnectionFromFile(__DIR__ . '/config/pdoConfig.ini');
// $id = (Query::table('article')
//     ->insert(
//         ['descr' => "super vell de cousre o",
//             'nom' => "pp",
//             'tarif' => 88,
//             'id_categ' => 1]));
// var_dump(Query::table('article')->where('descr','like','%velo%')->select(['id', 'nom', 'tarif'])->get());
// var_dump(Query::table('article')->where('id', '=', $id)->select(['*'])->get());

//var_dump(get_class(new Categorie([])));
var_dump(Article::find(['tarif', '<','400'],['*'])[0]->categorie());

//var_dump(Categorie::find(['id', '=','2'])[0]->articles());