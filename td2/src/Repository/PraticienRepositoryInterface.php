<?php

namespace iutnc\Repository;

use iutnc\Models\Praticien;
use iutnc\Models\Specialite;


interface PraticienRepositoryInterface{
	public function getPraticiensBySpecialite(Specialite $spe): array;
	public function getPraticiensBySpecialiteAndVille(Specialite $spe,string $ville): array;
}
