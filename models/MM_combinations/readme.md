# Math_Combinatorics

## Overview

The `Math_Combinatorics` class provides functionality to find all combinations and permutations given a set and a subset size. It preserves associative arrays and offers efficient methods for combinatorial operations.

## Features

- **Combinations**: Find all possible combinations of a given size from a set.
- **Permutations**: Find all possible permutations of a given size from a set.
- **Associative Arrays**: Supports and preserves associative arrays.

## Requirements

- PHP 5.6 or higher

## Usage

### Finding Combinations

To find all combinations of a given size from a set, use the `combinations` method.

```php
require_once 'Math_Combinatorics.php';

$combinatorics = new Math_Combinatorics();
$set = ['a', 'b', 'c'];
$subset_size = 2;

$combinations = $combinatorics->combinations($set, $subset_size);
print_r($combinations);
```

### Finding Permutations

To find all permutations of a given size from a set, use the `permutations` method.

```php
require_once 'Math_Combinatorics.php';

$combinatorics = new Math_Combinatorics();
$set = ['a', 'b', 'c'];
$subset_size = 2;

$permutations = $combinatorics->permutations($set, $subset_size);
print_r($permutations);
```

## Methods

### `combinations(array $set, $subset_size = null)`

Finds all combinations given a set and a subset size.

- **Parameters:**
  - `array $set`: The parent set.
  - `int $subset_size`: The size of each subset. If not provided, defaults to the size of the set.
- **Returns:** `array` An array of combinations.

### `permutations(array $set, $subset_size = null)`

Finds all permutations given a set and a subset size.

- **Parameters:**
  - `array $set`: The parent set.
  - `int $subset_size`: The size of each subset. If not provided, defaults to the size of the set.
- **Returns:** `array` An array of permutations.

## License

The MIT License (MIT)
---------------------

Copyright © `2024` `kgrigor@geosense.gr`

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the “Software”), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

## Acknowledgements

This implementation is inspired by combinatorial algorithms commonly used in mathematics and computer science.

Feel free to contribute to this project by submitting issues or pull requests.
