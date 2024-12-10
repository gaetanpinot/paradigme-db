<?php

namespace iutnc\Repository;

use Doctrine\ORM\EntityRepository;
use iutnc\Repository\PersonnelRepositoryInterface;

class PersonnelRepository extends EntityRepository implements PersonnelRepositoryInterface{
    public function getPersonnelByVille(string $ville): array
    {
	$dql = "select p from iutnc\Models\Personnel p 
	join p.groupe g 
	     where lower(g.ville) like lower(:ville)
	";
	$query = $this->getEntityManager()->createQuery($dql);
	$query->setParameters(['ville' => "%$ville%"]);
	return $query->getResult();
    }

}
