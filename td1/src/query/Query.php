<?php 
namespace iutnc\hellokant\query; 



class Query {
    protected $table;
    protected $columns = '*';

    protected $whereConditions = [];

    protected $args = [];

    protected $pdo; 

    static public function table($tablename): Query {
        $query = new Query();
        $query->table = $tablename;
        $pdo = ConnectionFactory::getConnection();
        return $query;
    }

    public function where($column, $operator,$value): Query {
        array_push($this->whereConditions,$column.' '.$operator.' ?');
        array_push($this->args,$value);
        return $this;  
    }

    public function get() {
        $this->pdo->prepare('SELECT '.$this->columns.' FROM '.$this->table.' WHERE '.implode(' AND ',$this->whereConditions));
        $this->pdo->execute($this->args);
    }

    public function select($columns): Query {
        $this->columns = implode(', ',$columns); 
        return $this;
    }

    public function delete() {
        $this->pdo->prepare('DELETE FROM'.$this->table.' WHERE '.implode(' AND ',$this->whereConditions));
        $this->pdo->execute();
    }

    public function insert($data) {
        $this->pdo->prepare('INSERT INTO '. $this->table.' ('.$this->columns.') VALUES (?)');
        $this->pdo->execute($data);
    }

}