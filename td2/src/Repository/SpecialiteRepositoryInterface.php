<?php

namespace iutnc\Repository;

interface SpecialiteRepositoryInterface {

    public function getSpecialiteWithWord(string $word):array;
}
