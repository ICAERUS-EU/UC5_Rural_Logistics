# Travelling Salesman Problem Using Branch and Bound Approach in PHP

## Overview

This repository contains an implementation of the Travelling Salesman Problem (TSP) using the Branch and Bound approach in PHP. The algorithm aims to find the shortest possible route that visits each city exactly once and returns to the origin city. 

## Features

- Calculation of distances between cities using latitude and longitude.
- Implementation of the Branch and Bound algorithm to find the optimal path.
- Reading city data from an external file (`cities.txt`).

## Requirements

- PHP 5.6 or higher.

## Usage

1. **Prepare the City Data:**
    - Create a file named `cities.txt` in the project directory.
    - Add city data in the format: `id latitude longitude`, one city per line.
    - Example:
      ```
      1 40.712776 -74.005974
      2 34.052235 -118.243683
      3 41.878113 -87.629799
      ```

2. **Run the PHP Script:**
    - Execute the script from the command line:
      ```sh
      php tsp.php
      ```
    - The script will read the city data, calculate the optimal path using the Branch and Bound algorithm, and print the result.

## Classes and Methods

### `class TspLocation`

- **Properties:**
  - `public $latitude`
  - `public $longitude`
  - `public $id`

- **Methods:**
  - `__construct($latitude, $longitude, $id = null)`: Initializes a TspLocation object.
  - `public static function getInstance($location)`: Creates an instance of TspLocation from an array.
  - `public static function distance($lat1, $lon1, $lat2, $lon2, $unit = 'M')`: Calculates the distance between two points.

### `class TspNode`

- **Properties:**
  - `public $path = array()`
  - `public $reducedMatrix = array()`
  - `public $cost`
  - `public $vertex`
  - `public $level`

- **Methods:**
  - `__construct($parentMatrix, $path, $level, $i, $j)`: Initializes a TspNode object.

### `class PqTsp extends SplPriorityQueue`

- **Methods:**
  - `public function compare($lhs, $rhs)`: Compares two nodes for priority queue.

### `class TspBranchBound`

- **Properties:**
  - `protected $n = 0`
  - `protected $locations = array()`
  - `protected $costMatrix = array()`
  - `protected static $instances = array()`

- **Methods:**
  - `__construct($costMatrix = array())`: Initializes a TspBranchBound object.
  - `public static function getInstance($name = 'TspBranchBound', $locations = null)`: Returns an instance of TspBranchBound.
  - `public function load($locations)`: Loads locations into the instance.
  - `public function loadMatrix()`: Loads the cost matrix.
  - `public function addLocation($location)`: Adds a location to the instance.
  - `protected function rowReduction(&$reducedMatrix, &$row)`: Reduces the rows of the cost matrix.
  - `protected function columnReduction(&$reducedMatrix, &$col)`: Reduces the columns of the cost matrix.
  - `protected function calculateCost(&$reducedMatrix)`: Calculates the cost for the matrix.
  - `public function printPath($list)`: Prints the path.
  - `public function solve()`: Solves the TSP using Branch and Bound.

## Example

The example provided demonstrates how to create a `TspBranchBound` instance, add locations from a file, and solve the TSP to find the optimal path.

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

Credits to [Srimax](http://www.srimax.com/index.php/travelling-salesman-problem-using-branch-bound-approach-php/) for the original implementation.

Feel free to contribute to this project by submitting issues or pull requests.
