<?php

namespace iutnc\Models;

use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping\Column;
use Doctrine\ORM\Mapping\Entity;
use Doctrine\ORM\Mapping\JoinColumn;
use Doctrine\ORM\Mapping\ManyToOne;
use Doctrine\ORM\Mapping\Id;
use Doctrine\ORM\Mapping\Table;


#[Entity]
#[Table(name: "praticien", schema: "public")]
class Praticien
{
    #[Id]
    #[Column(type: Types::GUID)]
    private string $id;

    public function setId(string $id): void
    {
        $this->id = $id;
    }

    public function setNom(string $nom): void
    {
        $this->nom = $nom;
    }

    public function setPrenom(string $prenom): void
    {
        $this->prenom = $prenom;
    }

    public function setVille(string $ville): void
    {
        $this->ville = $ville;
    }

    public function setEmail(string $email): void
    {
        $this->email = $email;
    }

    public function setTelephone(string $telephone): void
    {
        $this->telephone = $telephone;
    }

    public function setSpecialite(Specialite $specialite): void
    {
        $this->specialite = $specialite;
    }

    public function setGroupe(?Groupement $groupe): void
    {
        $this->groupe = $groupe;
    }


    #[Column(type: "string", length: 48)]
    private string $nom;

    #[Column(type: "string", length: 48)]
    private string $prenom;

    #[Column(type: "string", length: 48)]
    private string $ville;

    #[Column(type: "string", length: 128)]
    private string $email;

    #[Column(type: "string", length: 24)]
    private string $telephone;

    #[ManyToOne(targetEntity: Specialite::class, inversedBy: "praticiens")]
    #[JoinColumn(name: "specialite_id", referencedColumnName: "id", nullable: false)]
    private Specialite $specialite;

    #[ManyToOne(targetEntity: Groupement::class, inversedBy: "praticiens")]
    #[JoinColumn(name: "groupe_id", referencedColumnName: "id", nullable: true)]
    private ?Groupement $groupe;

    public function getId(): string{
        return $this->id;
    }
    public function getNom(): string{
        return $this->nom;
    }
    public function getPrenom(): string{
        return $this->prenom;
    }
    public function getVille(): string{
        return $this->ville;
    }
    public function getEmail(): string{
        return $this->email;
    }
    public function getTelephone(): string{
        return $this->telephone;
    }
    public function getGroupe(): Groupement{
        return $this->groupe;
    }
}
