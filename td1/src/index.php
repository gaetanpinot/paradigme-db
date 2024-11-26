<?php
require_once __DIR__ . '/../vendor/autoload.php';
use iutnc\hellokant\models\Article;
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

$article = new Article();
$article->descr = "huit";
$article->nom = "porudi";
$article->tarif = 888; 
$article->id_categ = 1;
$id = $article->insert();
var_dump(Query::table('article')->where('id', '=', $id)->select(['*'])->get());

$article = new Article();
$article->id = 114;
$article->delete();

Article::all();
