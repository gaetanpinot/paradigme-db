<?php


require_once __DIR__ . '/../vendor/autoload.php';

//setup
use Doctrine\DBAL\DriverManager;
// contenant les classes entité
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\ORMSetup;
use iutnc\Models\Praticien;
use iutnc\Models\Specialite;
$entity_path = [__DIR__ . '/Models'];
$isDevMode=true;
$dbParams = parse_ini_file(__DIR__ . '/config/pgsql.ini');
$config = ORMSetup::
createAttributeMetadataConfiguration($entity_path, $isDevMode);
$connection = DriverManager::getConnection($dbParams, $config);
$entityManager = new EntityManager($connection, $config);
$pratiecienRepo = $entityManager->getRepository(Praticien::class);
$specialiteRepo = $entityManager->getRepository(Specialite::class);
//Exercice 1
echo "
<h1> TD2</h1>
<h3> Exercice 1</h3>
";
$specialite = $specialiteRepo->find(1);
echo "
<p><h4>1</h4>
id : {$specialite->getId()}, libelle : {$specialite->getLibelle()}, description : {$specialite->getDescription()}.
</p>
";
