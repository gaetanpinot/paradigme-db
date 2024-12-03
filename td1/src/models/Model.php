<?php

namespace iutnc\hellokant\models;

use iutnc\hellokant\query\Query;

class Model{


    protected array $attributs;

    //Nom de la clé primaire dans la table
    public static string $primaryKey = "";

    //Nom de la table
    public static string $table = "";

    public Query $query;

    /**
     * @param array<int,mixed> $attributs
     */
    public function __construct(array $attributs=[])
    {
        $this->attributs = $attributs;
        $this->query = Query::table($this::$table);
    }

    public static function all(){
        $results = Query::table(static::$table)->select(['*'])->get();
        $arrayMap = array_map(function($row) {
            return new static($row);
        }, $results);
        return $arrayMap;
    }

    public static function find($where, $select = ['*']) {
        $results = Query::table(static::$table)->select($select)->where($where[0], $where[1], $where[2])->get();
        $arrayMap = array_map(function($row) {
            return new static($row);
        }, $results);
        return $arrayMap;
    }

    /**
     * @param mixed $att
     */
    public function __get($att): mixed {
        if( isset($this->attributs[$att])){
            return $this->attributs[$att];
        }
        return null;
    }

    /**
     * @return void
     * @param mixed $att
     * @param mixed $val
     */
    public function __set($att, $val): void{
        $this->attributs[$att] = $val;
    }

    public function delete(): void{
        if( isset($this->attributs[$this::$primaryKey])){
            $this->query->where($this::$primaryKey, '=' ,$this->attributs[$this::$primaryKey])->delete();
        }
    }

    public function insert(): string|false{
        $att = $this->attributs;
        unset($att[$this::$primaryKey] );
        return $this->query->insert($att);

    }

    public function belongs_to($table, $foreignKey) {
        $fullTableName = 'iutnc\hellokant\models\\'.$table;
        $secondClass = new $fullTableName();
        return Query::table(strtolower($table))->where($secondClass::$primaryKey, '=',$this->attributs[$foreignKey])->select(['*'])->get();
    }

    public function has_many($table, $foreignKey) {
        return Query::table(strtolower($table))->where($foreignKey, '=',$this->attributs[$this::$primaryKey])->select(['*'])->get();
    }

}
