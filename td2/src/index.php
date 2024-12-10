<?php


require_once __DIR__ . '/../vendor/autoload.php';

//setup
use Doctrine\DBAL\DriverManager;
// contenant les classes entité
use Doctrine\DBAL\Types\Type;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\ORMSetup;
use iutnc\Models\Groupement;
use iutnc\Models\Personnel;
use iutnc\Models\Praticien;
use iutnc\Models\Specialite;
use iutnc\Models\TypeGroupement;
$entity_path = [__DIR__ . '/Models'];
$isDevMode=true;
$dbParams = parse_ini_file(__DIR__ . '/config/pgsql.ini');
$config = ORMSetup::
createAttributeMetadataConfiguration($entity_path, $isDevMode);
$connection = DriverManager::getConnection($dbParams, $config);

$entityManager = new EntityManager($connection, $config);
$pratiecienRepo = $entityManager->getRepository(Praticien::class);
$specialiteRepo = $entityManager->getRepository(Specialite::class);
$groupementRepo = $entityManager->getRepository(Groupement::class);
$typegroupementRepo = $entityManager->getRepository(TypeGroupement::class);
$personnelRepo = $entityManager->getRepository(Personnel::class);

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

$groupement = $typegroupementRepo->find(1);
echo "
<p><h4>2</h4>
id : {$groupement->getId()}, libelle : {$groupement->getTypeLibelle()}, description : {$groupement->getTypeDescription()}.
</p>
";

$prat = $pratiecienRepo->find('8ae1400f-d46d-3b50-b356-269f776be532');
echo "
<p><h4>3 et 4</h4>
id : {$prat->getId()}, nom : {$prat->getNom()}, prenom : {$prat->getPrenom()}, ville : {$prat->getVille()}, email : {$prat->getEmail()}, telephone : {$prat->getTelephone()},
groupe : {$prat->getGroupe()->getNom()}, specialite {$prat->getSpecialite()->getLibelle()}
</p>
";

$prat = new Praticien();
$prat->setNom( "Superman");
$prat->setPrenom( "il à pas de prenom superman");
$prat->setSpecialite( $specialiteRepo->findOneBy(['libelle'=>'pédiatrie']));
$prat->setGroupe($groupementRepo->findOneBy(['nom'=>'Barbe']));
$prat->setVille("tourcoing");
$prat->setEmail("super@man.org");
$prat->setTelephone("3615");

$entityManager->persist($prat);
$entityManager->flush();

$prat = $pratiecienRepo->findOneBy(['nom'=>'Superman']);
echo "
<p><h4>5</h4>
id : {$prat->getId()}, nom : {$prat->getNom()}, prenom : {$prat->getPrenom()}, ville : {$prat->getVille()}, email : {$prat->getEmail()}, telephone : {$prat->getTelephone()},
groupe : {$prat->getGroupe()->getNom()}, specialite {$prat->getSpecialite()->getLibelle()}
</p>
";

$prat->setGroupe($groupementRepo->findOneBy(['nom'=>'Bigot']));
$prat->setVille("Paris");

$entityManager->flush();

echo "
<p><h4>6</h4>
id : {$prat->getId()}, nom : {$prat->getNom()}, prenom : {$prat->getPrenom()}, ville : {$prat->getVille()}, email : {$prat->getEmail()}, telephone : {$prat->getTelephone()},
groupe : {$prat->getGroupe()->getNom()}, specialite {$prat->getSpecialite()->getLibelle()}
</p>
";

$entityManager->remove($prat);
$entityManager->flush();

echo "
<p><h4>7</h4>
Praticien supprimé
</p>
";

$specialite = $specialiteRepo->find(1);
echo "
<h3>Exercice 3</h3>
<p><h4> 1</h4>";
$prats = $pratiecienRepo->getPraticiensBySpecialite($specialite); 
foreach($prats as $prat){
	echo "<p>
	id : {$prat->getId()}, nom : {$prat->getNom()}, prenom : {$prat->getPrenom()}, ville : {$prat->getVille()}, email : {$prat->getEmail()}, telephone : {$prat->getTelephone()},
	groupe : {$prat->getGroupe()->getNom()}, specialite {$prat->getSpecialite()->getLibelle()}
	</p>";
}
echo "</p>";

$mot = "des";
$specialites = $specialiteRepo->getSpecialiteWithWord($mot);
echo "
<p><h4>2</h4>
Mot chérché : $mot";
foreach($specialites as $specialite){
	echo "<p> id : {$specialite->getId()}, libelle : {$specialite->getLibelle()}, description : {$specialite->getDescription()}. </p>";
}
echo "</p>";


$specialite = $specialiteRepo->find(1);
$ville = "paris";
echo "
<p><h4> 3</h4>
Ville cherché : $ville
Specialite cherché : {$specialite->getLibelle()}";
$prats = $pratiecienRepo->getPraticiensBySpecialiteAndVille($specialite, $ville); 
foreach($prats as $prat){
	echo "<p>
	id : {$prat->getId()}, nom : {$prat->getNom()}, prenom : {$prat->getPrenom()}, ville : {$prat->getVille()}, email : {$prat->getEmail()}, telephone : {$prat->getTelephone()},
	groupe : {$prat->getGroupe()->getNom()}, specialite {$prat->getSpecialite()->getLibelle()}
	</p>";
}
echo "</p>";


$ville = "paris";
echo "
<p><h4> 4</h4>
Ville cherché : $ville";
$personnels = $personnelRepo->getPersonnelByVille($ville);
foreach($personnels as $perso){
	echo "<p>
	id : {$perso->getId()}, nom : {$perso->getNom()}, prenom : {$perso->getPrenom()}, ville : {$perso->getGroupe()->getVille()}, email : {$perso->getMail()}, telephone : {$perso->getTelephone()},
	groupe : {$perso->getGroupe()->getNom()}
	</p>";
}
echo "</p>";
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
