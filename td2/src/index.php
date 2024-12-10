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
$prat = $pratiecienRepo->findOneBy(['nom'=>'Paul']);
//var_dump($prat);


//Exercice 2 : 
//1. Afficher le praticien dont le mail est Gabrielle.Klein@live.com (requête simple)
var_dump($pratiecienRepo->findBy(array('email' => 'Gabrielle.Klein@live.com' )));
//2. Afficher le praticien de nom Goncalves à Paris (requête simple)
var_dump($pratiecienRepo->findBy(array('nom' => 'Goncalves', "ville" => 'Paris' )));
//3. Afficher la spécialité de libellé 'pédiatrie' ainsi que les praticiens associés. (requête simple)
var_dump($specialiteRepo->findBy(array('libelle' => 'pédiatrie' )));
//4. afficher les types de groupements contenants 'santé' dans leur description (utiliser une
//requête critères)
//5. afficher les praticiens de la spécialité ‘ophtalmologie exerçants à Paris
