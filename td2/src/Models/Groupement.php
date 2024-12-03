<?php

namespace iutnc\Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "groupement", schema: "public")]
class Groupement
{
    #[ORM\Id]
    #[ORM\Column(type: "guid")]
    private string $id;

    #[ORM\Column(type: "string", length: 48)]
    private string $nom;

    #[ORM\ManyToOne(targetEntity: TypeGroupement::class, inversedBy: "groupements")]
    #[ORM\JoinColumn(name: "type_id", referencedColumnName: "id", nullable: false)]
    private TypeGroupement $type;

    #[ORM\Column(type: "text")]
    private string $adresse;

    #[ORM\Column(type: "string", length: 128, nullable: true)]
    private ?string $ville;

    #[ORM\OneToMany(targetEntity: Personnel::class, mappedBy: "groupe")]
    private iterable $personnels;

    #[ORM\OneToMany(targetEntity: Praticien::class, mappedBy: "groupe")]
    private iterable $praticiens;

}

