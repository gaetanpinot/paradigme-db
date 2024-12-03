<?php


require_once __DIR__ . '/../vendor/autoload.php';

//setup
use Doctrine\DBAL\DriverManager;
// contenant les classes entité
use Doctrine\ORM\EntityManager;
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
$prat = $pratiecienRepo->findOneBy();
var_dump($prat);

