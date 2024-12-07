<?php

namespace iutnc\Models;

use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping\Column;
use Doctrine\ORM\Mapping\Entity;
use Doctrine\ORM\Mapping\GeneratedValue;
use Doctrine\ORM\Mapping\Id;
use Doctrine\ORM\Mapping\OneToMany;
use Doctrine\ORM\Mapping\Table;
use iutnc\Repository\SpecialiteRepository;

#[Entity(repositoryClass: SpecialiteRepository::class)]
#[Table(name: "specialite")]
class Specialite
{
    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function setLibelle(string $libelle): void
    {
        $this->libelle = $libelle;
    }

    public function setDescription(?string $description): void
    {
        $this->description = $description;
    }

    public function setPraticiens(iterable $praticiens): void
    {
        $this->praticiens = $praticiens;
    }
    #[Id]
    #[Column(type: Types::INTEGER)]
    #[GeneratedValue(strategy: "AUTO")]
    private int $id;

    #[Column(name: "libelle", type: Types::STRING, length: 48)]
    private string $libelle;

    #[Column(name: "description", type: Types::STRING, nullable: true)]
    private ?string $description;

    #[OneToMany(targetEntity: Praticien::class, mappedBy: "specialite")]
    private iterable $praticiens;

    public function getId(){
        return $this->id;
    }
    public function getLibelle(){
        return $this->libelle;
    }
    public function getDescription(){
        return $this->description;
    }
    public function getPraticiens(){
        return $this->praticiens;
    }
}
