<?php

namespace Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "praticien", schema: "public")]
class Praticien
{
    #[ORM\Id]
    #[ORM\Column(type: "uuid")]
    private string $id;

    #[ORM\Column(type: "string", length: 48)]
    private string $nom;

    #[ORM\Column(type: "string", length: 48)]
    private string $prenom;

    #[ORM\Column(type: "string", length: 48)]
    private string $ville;

    #[ORM\Column(type: "string", length: 128)]
    private string $email;

    #[ORM\Column(type: "string", length: 24)]
    private string $telephone;

    #[ORM\ManyToOne(targetEntity: Specialite::class, inversedBy: "praticiens")]
    #[ORM\JoinColumn(name: "specialite_id", referencedColumnName: "id", nullable: false)]
    private Specialite $specialite;

    #[ORM\ManyToOne(targetEntity: Groupement::class, inversedBy: "praticiens")]
    #[ORM\JoinColumn(name: "groupe_id", referencedColumnName: "id", nullable: true)]
    private ?Groupement $groupe;

}
