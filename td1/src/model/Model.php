<?php

namespace iutnc\hellokant\model;

abstract class Model
{
    private $attributes = [];

    public function __construct(array $attributes = [])
    {
        $this->attributes = $attributes;
    }

    public function __get(string $name)
    {
        return $this->attributes[$name] ?? null;
    }

    public function __set(string $name, $value): void
    {
        $this->attributes[$name] = $value;
    }

    abstract public function delete();
    abstract public function insert();

}