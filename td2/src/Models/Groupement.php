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

    public function setId(string $id): void
    {
        $this->id = $id;
    }

    public function setNom(string $nom): void
    {
        $this->nom = $nom;
    }

    public function setType(TypeGroupement $type): void
    {
        $this->type = $type;
    }

    public function setAdresse(string $adresse): void
    {
        $this->adresse = $adresse;
    }

    public function setVille(?string $ville): void
    {
        $this->ville = $ville;
    }

    public function setPersonnels(iterable $personnels): void
    {
        $this->personnels = $personnels;
    }

    public function setPraticiens(iterable $praticiens): void
    {
        $this->praticiens = $praticiens;
    }

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

    public function getId(): string{
        return $this->id;
    }
    public function getNom(): string{
        return $this->nom;
    }
    public function getType(): TypeGroupement{
        return $this->type;
    }
    public function getAdresse(): string{
        return $this->adresse;
    }
    public function getVille(): ?string{
        return $this->ville;
    }
    public function getPersonnels(): iterable{
        return $this->personnels;
    }
    public function getPraticiens(): iterable{
        return $this->praticiens;
    }
}

