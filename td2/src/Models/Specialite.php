<?php

namespace iutnc\Models;

use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping\Column;
use Doctrine\ORM\Mapping\Entity;
use Doctrine\ORM\Mapping\GeneratedValue;
use Doctrine\ORM\Mapping\Id;
use Doctrine\ORM\Mapping\OneToMany;
use Doctrine\ORM\Mapping\Table;

#[Entity]
#[Table(name: "specialite")]
class Specialite
{
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

}
