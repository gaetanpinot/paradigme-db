<?php

require_once __DIR__ . '/../vendor/autoload.php';

use iutnc\hellokant\models\Article;
use iutnc\hellokant\models\Categorie;
use iutnc\hellokant\query\Query;
use iutnc\hellokant\ConnectionFactory;

ConnectionFactory::makeConnectionFromFile(__DIR__ . '/config/pdoConfig.ini');
echo "<h1> TD1 </h1>
<H1> Il n'y à pas de question qui demande d'utiliser les methodes crée, voila la liste de tout les articles et quelque var_dump </H1>";
$liste = Article::all() ;
foreach ($liste as $article) {
    print "<p>".$article->nom .",". $article->tarif. "€". $article->descr."</p>";
}
echo "<h2>Insertion d'un article</h2>";
$id = (Query::table('article')
    ->insert(
        ['descr' => "super vell de cousre o",
            'nom' => "pp",
            'tarif' => 88,
            'id_categ' => 1]
    ));
echo "<h2>On voit les articles avec une description contenant velo</h2>";
var_dump(Query::table('article')->where('descr', 'like', '%velo%')->select(['id', 'nom', 'tarif'])->get());
echo "<h2>On voit l'article avec l'id $id</h2>";
var_dump(Query::table('article')->where('id', '=', $id)->select(['*'])->get());

var_dump(get_class(new Categorie([])));
echo "<h2>On voit la catégorie du premier article avec un tarif inferieur à 400</h2>";
var_dump(Article::find(['tarif', '<','400'], ['*'])[0]->categorie());
echo "<h2>On voit les articles de la catégorie 1</h2>";
var_dump(Categorie::find(['id', '=','1'])[0]->articles());
