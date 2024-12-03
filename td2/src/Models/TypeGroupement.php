<?php

namespace iutnc\Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "type_groupement", schema: "public")]
class TypeGroupement
{
    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function setTypeLibelle(string $typeLibelle): void
    {
        $this->typeLibelle = $typeLibelle;
    }

    public function setTypeDescription(string $typeDescription): void
    {
        $this->typeDescription = $typeDescription;
    }

    public function setGroupements(iterable $groupements): void
    {
        $this->groupements = $groupements;
    }
    #[ORM\Id]
    #[ORM\Column(type: "integer")]
    private int $id;

    #[ORM\Column(type: "string", length: 48)]
    private string $typeLibelle;

    #[ORM\Column(type: "text")]
    private string $typeDescription;

    #[ORM\OneToMany(targetEntity: Groupement::class, mappedBy: "type")]
    private iterable $groupements;
    
    public function getId(){
        return $this->id;
    }
    public function getTypeLibelle(){
        return $this->typeLibelle;
    }
    public function getTypeDescription(){
        return $this->typeDescription;
    }
    public function getGroupements(){
        return $this->groupements;
    }
}
