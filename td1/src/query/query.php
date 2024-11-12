<?php 

namespace \iutnc\hellokant\query\Query; 

class Query {
    protected $table;
    protected $columns = '*';

    protected $whereConditions = [];
    
 

    static public function table($tablename): Query {
        $query = new Query();
        $query->table = $tablename;
        return $query;
    }

    public function where($column, $operator,$value): Query {
        array_push($this->whereConditions,$column.' '.$operator.' '.$value);
        return $this;  
    }

    public function get() {
        echo 'SELECT'.$this->columns.' FROM '.$this->table.' WHERE '.implode(' AND ',$this->whereConditions);
    }

    public function select($columns): Query {
        $this->columns = implode(', ',$columns); 
        return $this;
    }

    public function delete() {
        echo 'DELETE FROM'.$this->table.' WHERE '.implode(' AND ',$this->whereConditions);
    }

    public function insert($data) {
        echo 'INSERT INTO '. $this->table.' ('.$this->columns.') VALUES '.implode(', ',$data);
    }

}