<?php

namespace Entities;


#[Entity]
#[Table(name: "groupement")]
class Groupement
{
//"id" uuid DEFAULT gen_random_uuid() NOT NULL,
//    "nom" character varying(48) NOT NULL,
//    "type_id" integer NOT NULL,
//    "adresse" text NOT NULL,
//    "ville" character varying(128)

    #[Id]
    #[Column(type: "uuid")]
    #[GeneratedValue(strategy: "AUTO")]
    private int $id;
    #[Column(name: "nom",
        type: Types::STRING,
        length: 64)]
    private string $nom;

    #[Column( type: Types::TEXT)]
    private string $description;


}