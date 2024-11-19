<?php
require_once __DIR__ . '/../vendor/autoload.php';
use iutnc\hellokant\query\Query;
Query::table('employeuh')->where('nom','=','Pierre')->select(['nom', 'prenom', 'age'])->get();
