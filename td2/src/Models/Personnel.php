<?php

namespace iutnc\Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "personnel", schema: "public")]
class Personnel
{
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

    public function setMail(string $mail): void
    {
        $this->mail = $mail;
    }

    public function setTelephone(string $telephone): void
    {
        $this->telephone = $telephone;
    }

    public function setGroupe(Groupement $groupe): void
    {
        $this->groupe = $groupe;
    }
    #[ORM\Id]
    #[ORM\Column(type: "uuid")]
    private string $id;

    #[ORM\Column(type: "string", length: 48)]
    private string $nom;

    #[ORM\Column(type: "string", length: 48)]
    private string $prenom;

    #[ORM\Column(type: "string", length: 128)]
    private string $mail;

    #[ORM\Column(type: "string", length: 24)]
    private string $telephone;

    #[ORM\ManyToOne(targetEntity: Groupement::class, inversedBy: "personnels")]
    #[ORM\JoinColumn(name: "groupe_id", referencedColumnName: "id", nullable: false)]
    private Groupement $groupe;

    public function getId(): string{
        return $this->id;
    }
    public function getNom(): string{
        return $this->nom;
    }
    public function getPrenom(): string{
        return $this->prenom;
    }
    public function getMail(): string{
        return $this->mail;
    }
    public function getTelephone(): string{
        return $this->telephone;
    }
    public function getGroupe(): Groupement{
        return $this->groupe;
    }
}
