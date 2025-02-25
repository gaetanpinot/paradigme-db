<?php

namespace iutnc\hellokant\models;

use iutnc\hellokant\models\Model;

class Article extends Model{

    public static string $primaryKey = "id";

    public static string $table = "article";
    
    public function categorie() {
        return $this->belongs_to('Categorie', 'id_categ');
    }
}
