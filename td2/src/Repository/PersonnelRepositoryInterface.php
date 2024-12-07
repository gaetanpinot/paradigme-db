<?php

namespace iutnc\Repository;

interface PersonnelRepositoryInterface {
    public function getPersonnelByVille(string $ville): array;

}
