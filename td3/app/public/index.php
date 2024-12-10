<?php
/**
 * Created by PhpStorm.
 * User: canals5
 * Date: 28/10/2019
 * Time: 16:16
 */

use MongoDB\Client;

require_once __DIR__ . "/../src/vendor/autoload.php";

$c = new Client("mongodb://mongo");
echo "connected to mongo <br>";

try {
    $db = $c->chopizza;

    //q1
    echo "<br>=========Q1===========<br>";
    $produits = $db->produits->find([], [
        'projection' => [
            'numero' => 1,
            'categorie' => 1,
            'libelle' => 1,
            '_id' => 1
        ]
    ]);

    echo "Liste des produits:<br>";
    foreach ($produits as $produit) {
        echo "Numéro: {$produit['numero']}, Catégorie: {$produit['categorie']}, Libellé: {$produit['libelle']}<br>";
    }


    //q2
    echo "<br>=========Q2===========<br>";

    $produit = $db->produits->findOne(['numero' => 6], [
        'projection' => [
            'libelle' => 1,
            'categorie' => 1,
            'description' => 1,
            'tarifs' => 1,
            '_id' => 0
        ]
    ]);

    if ($produit) {
        echo "Détails du produit numéro 6:<br>";
        echo "Libellé: {$produit['libelle']}<br>";
        echo "Catégorie: {$produit['categorie']}<br>";
        echo "Description: {$produit['description']}<br>";
        echo "Tarifs:<br>";
        foreach ($produit['tarifs'] as $tarif) {
            echo "- Taille: {$tarif['taille']}, Tarif: {$tarif['tarif']}<br>";
        }
    } else {
        echo "Produit numéro 6 non trouvé";
    }

    //q3
    echo "<br>=========Q3===========<br>";
    $produits = $db->produits->find([
        'tarifs' => [
            '$elemMatch' => [
                'taille' => 'normale',
                'tarif' => ['$lte' => 3.0]
            ]
        ]
    ]);

    echo "Produits dont le tarif en taille normale est <= 3.0<br>";
    foreach ($produits as $produit) {
        echo "Numéro: {$produit['numero']}, Libellé: {$produit['libelle']}, Catégorie: {$produit['categorie']}<br>";
    }

    //q4
    echo "<br>=========Q4===========<br>";

    $produits = $db->produits->find([
        '$where' => 'this.recettes.length === 4'
    ]);

    echo "Produits associés à 4 recettes :<br>";
    foreach ($produits as $produit) {
        echo "Numéro : {$produit['numero']}, Libellé : {$produit['libelle']}, Catégorie : {$produit['categorie']}<br>";
    }

    //q5
    echo "<br>=========Q5===========<br>";

    $produit = $db->produits->findOne(['numero' => 6]);

    if ($produit) {
        echo "Produit n°6 :<br>";
        echo "Libellé : {$produit['libelle']}<br>";
        echo "Catégorie : {$produit['categorie']}<br>";
        echo "Description : {$produit['description']}<br>";
        echo "Tarifs :<br>";
        foreach ($produit['tarifs'] as $tarif) {
            echo "- Taille : {$tarif['taille']}, Tarif : {$tarif['tarif']}<br>";
        }

        $recettes = $db->recettes->find([
            '_id' => ['$in' => $produit['recettes']]
        ]);

        echo "Recettes associées :<br>";
        foreach ($recettes as $recette) {
            echo "- Nom : {$recette['nom']}, Difficulté : {$recette['difficulte']}<br>";
        }
    } else {
        echo "Produit n°6 non trouvé.<br>";
    }

    //q6
    echo "<br>=========Q6===========<br>";

    function obtenirProduit($db, $numero, $taille)
    {
        $produit = $db->produits->findOne(['numero' => $numero]);

        if ($produit) {
            foreach ($produit['tarifs'] as $tarif) {
                if ($tarif['taille'] === $taille) {
                    return [
                        'numero' => $produit['numero'],
                        'libelle' => $produit['libelle'],
                        'categorie' => $produit['categorie'],
                        'taille' => $taille,
                        'tarif' => $tarif['tarif']
                    ];
                }
            }
        }

        return null;
    }

    $numeroProduit = 6;
    $tailleProduit = 'normale';

    $resultat = obtenirProduit($db, $numeroProduit, $tailleProduit);

    if ($resultat) {
        echo json_encode($resultat, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    } else {
        echo "Produit introuvable ou taille non disponible.";
    }

} catch (Exception $e) {
    echo "Erreur: " . $e->getMessage();
}