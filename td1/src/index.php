<?php
require_once __DIR__ . '/../vendor/autoload.php';

use iutnc\hellokant\model\Article;
use iutnc\hellokant\query\Query;
//Query::table('employeuh')->where('nom','=','Pierre')->select(['nom', 'prenom', 'age'])->get();


//Article test
$article  = new Article(['title' => 'Hello', 'content' => 'World']);
echo $article->title . "<br>";
echo $article->content;
$article->title = 'Bonjour';


$article->delete();
echo "Article deleted!";