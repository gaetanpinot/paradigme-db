<?php
require_once();
use \iutnc\hellokant\query\Query; 

Query::table('employé')->where('nom','=','Pierre')->select('nom, prenom, age')->get();