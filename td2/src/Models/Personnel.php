<?php

namespace Models;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: "personnel", schema: "public")]
class Personnel
{
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

}
