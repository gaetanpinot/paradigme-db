<?php

namespace iutnc\hellokant\model;

class Article extends Model
{
    public function delete() {
        if (empty($this->id) ) {
            throw new \Exception("id is missing");
        }

        $id = $this->id;

        $query = "DELETE FROM " . $this->__get('article') . " WHERE id =" . " = :id";

//        $stmt = Database::getInstance()->prepare($query);
//        $stmt->execute([':id' => $id]);
    }


}