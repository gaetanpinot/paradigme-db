<?php

namespace iutnc\Repository;

use Doctrine\ORM\EntityRepository;
use iutnc\Models\Praticien;
use iutnc\Models\Specialite;
use iutnc\Repository\PraticienRepositoryInterface;

class PraticienRepository extends EntityRepository implements PraticienRepositoryInterface{


    public function getPraticiensBySpecialite(Specialite $spe): array
    {

	$dql = "select p from iutnc\Models\Praticien p
	where p.specialite = :spe";
	$query = $this->getEntityManager()->createQuery($dql);
	$query->setParameters(['spe'=>$spe]);
	return $query->getResult();
    }

    public function getPraticiensBySpecialiteAndVille(Specialite $spe, string $ville): array
    {
	$dql = "select p from iutnc\Models\Praticien p
	where p.specialite = :spe
	and lower(p.ville) = lower(:ville) ";
	$query = $this->getEntityManager()->createQuery($dql);
	$query->setParameters(['spe'=>$spe,
	    'ville'=>$ville]);
	return $query->getResult();
    }

}
