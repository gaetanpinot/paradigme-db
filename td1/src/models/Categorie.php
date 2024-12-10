<?php

namespace iutnc\hellokant\models;

use iutnc\hellokant\models\Model;

class Categorie extends Model{

    public static string $primaryKey = "id";

    public static string $table = "categorie";

    public function articles() {
        return $this->has_many('Article', 'id_categ');
    }

    
    
}
