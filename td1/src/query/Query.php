<?php 
<<<<<<< HEAD
namespace iutnc\hellokant\query;

use iutnc\hellokant\ConnectionFactory; 


use \PDO as PDO;
class Query {
    protected $table;
    protected $columns = '*';

    protected $whereConditions = [];

    protected $args = [];

    protected PDO $pdo;
    /**
     * @param mixed $tablename
     */
    static public function table($tablename): Query {
        $query = new Query();
        $query->table = $tablename;
        $query->pdo = ConnectionFactory::getConnection();
        return $query;
    }
    /**
     * @param mixed $column
     * @param mixed $operator
     * @param mixed $value
     */
    public function where($column, $operator,$value): Query {
        array_push($this->whereConditions,$column.' '.$operator.' ?');
        array_push($this->args,$value);
        return $this;  
    }

    public function get(): array{
        $statement = $this->pdo->prepare('SELECT '.$this->columns.' FROM '.$this->table.' WHERE '.implode(' AND ',$this->whereConditions));
        $statement->execute($this->args);
        return($statement->fetchAll());
    }
    /**
     * @param mixed $columns
     */
    public function select($columns): Query {
        $this->columns = implode(', ',$columns); 
        return $this;
    }

    public function delete(): void {
        $statement = $this->pdo->prepare('DELETE FROM '.$this->table.' WHERE '.implode(' AND ',$this->whereConditions));
        $statement->execute($this->args);
    }
    /**
     * @return void
     * @param mixed $data
     */
    public function insert(array $data): string|false {
        $colonnes = array_keys($data); 
        $colonnesInsert = array_map(function($c){
            return ':'.$c;
        },$colonnes);
        $statement = $this->pdo->prepare('INSERT INTO '. $this->table.' ('. implode(',', $colonnes) .') VALUES ('. implode(',', $colonnesInsert) .')');
        $statement->execute($data);
        return $this->pdo->lastInsertId();
    }

}
