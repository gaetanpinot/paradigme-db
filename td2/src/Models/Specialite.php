<?php

namespace Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "specialite", schema: "public")]
class Specialite
{
    #[ORM\Id]
    #[ORM\GeneratedValue(strategy: "SEQUENCE")]
    #[ORM\SequenceGenerator(sequenceName: "specialite_id_seq", allocationSize: 1, initialValue: 1)]
    #[ORM\Column(type: "integer")]
    private int $id;

    #[ORM\Column(type: "string", length: 48)]
    private string $libelle;

    #[ORM\Column(type: "text", nullable: true)]
    private ?string $description;

    #[ORM\OneToMany(targetEntity: Praticien::class, mappedBy: "specialite")]
    private iterable $praticiens;

}
