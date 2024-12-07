<?php

namespace iutnc\Repository;

use Doctrine\ORM\EntityRepository;
use iutnc\Repository\SpecialiteRepositoryInterface;

class SpecialiteRepository extends EntityRepository implements SpecialiteRepositoryInterface{
    public function getSpecialiteWithWord(string $word): array
    {
	$dql = "
	select s from iutnc\Models\Specialite s 
	where s.libelle like :word or
	s.description like :word
	";
	$query = $this->getEntityManager()->createQuery($dql);
	$query->setParameters(["word"=>"%$word%"]);
	return $query->getResult();
    }
}
