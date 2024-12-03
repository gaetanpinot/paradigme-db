<?php

namespace iutnc\Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "type_groupement", schema: "public")]
class TypeGroupement
{
    #[ORM\Id]
    #[ORM\Column(type: "integer")]
    private int $id;

    #[ORM\Column(type: "string", length: 48)]
    private string $typeLibelle;

    #[ORM\Column(type: "text")]
    private string $typeDescription;

    #[ORM\OneToMany(targetEntity: Groupement::class, mappedBy: "type")]
    private iterable $groupements;
    
}
