<?php

class Math_Combinatorics
{
    private $_pointers = [];

    /**
     * Find all combinations given a set and a subset size.
     *
     * @param  array $set          Parent set
     * @param  int   $subset_size  Subset size
     * @return array An array of combinations
     */
    public function combinations(array $set, $subset_size = null)
    {
        $set_size = count($set);

        if (is_null($subset_size)) {
            $subset_size = $set_size;
        }

        if ($subset_size >= $set_size) {
            return [$set];
        } elseif ($subset_size == 1) {
            return array_chunk($set, 1);
        } elseif ($subset_size == 0) {
            return [];
        }

        $combinations = [];
        $set_keys = array_keys($set);
        $this->_pointers = array_slice(array_keys($set_keys), 0, $subset_size);

        do {
            $combinations[] = $this->_getCombination($set);
        } while ($this->_advancePointers($subset_size - 1, $set_size - 1));

        return $combinations;
    }

    /**
     * Recursive function used to advance the list of 'pointers' that record the current combination.
     *
     * @param  int $pointer_number The ID of the pointer that is being advanced
     * @param  int $limit          Pointer limit
     * @return bool True if a pointer was advanced, false otherwise
     */
    private function _advancePointers($pointer_number, $limit)
    {
        if ($pointer_number < 0) {
            return false;
        }

        if ($this->_pointers[$pointer_number] < $limit) {
            $this->_pointers[$pointer_number]++;
            return true;
        } else {
            if ($this->_advancePointers($pointer_number - 1, $limit - 1)) {
                $this->_pointers[$pointer_number] = $this->_pointers[$pointer_number - 1] + 1;
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * Get the current combination.
     *
     * @param  array $set The parent set
     * @return array The current combination
     */
    private function _getCombination($set)
    {
        $combination = [];

        foreach ($this->_pointers as $pointer) {
            $combination[] = $set[array_keys($set)[$pointer]];
        }

        return $combination;
    }

    /**
     * Find all permutations given a set and a subset size.
     *
     * @param  array $set          Parent set
     * @param  int   $subset_size  Subset size
     * @return array An array of permutations
     */
    public function permutations(array $set, $subset_size = null)
    {
        $combinations = $this->combinations($set, $subset_size);
        $permutations = [];

        foreach ($combinations as $combination) {
            $permutations = array_merge($permutations, $this->_findPermutations($combination));
        }

        return $permutations;
    }

    /**
     * Recursive function to find the permutations of the current combination.
     *
     * @param array $set Current combination set
     * @return array Permutations of the current combination
     */
    private function _findPermutations($set)
    {
        if (count($set) <= 1) {
            return [$set];
        }

        $permutations = [];
        foreach ($set as $key => $val) {
            $remaining = $set;
            unset($remaining[$key]);
            $sub_permutations = $this->_findPermutations($remaining);

            foreach ($sub_permutations as $permutation) {
                $permutations[] = array_merge([$key => $val], $permutation);
            }
        }

        return $permutations;
    }
}

?>
