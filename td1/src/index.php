<?php
require_once __DIR__ . '/../vendor/autoload.php';
Query::table('employé')->where('nom','=','Pierre')->select('nom, prenom, age')->get();
