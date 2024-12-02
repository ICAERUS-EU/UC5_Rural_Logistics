# Genetic Algorithm for Traveling Salesman Problem (TSP)

## Overview

This repository contains an implementation of a Genetic Algorithm (GA) to solve the Traveling Salesman Problem (TSP). The algorithm initializes a population of routes, evaluates their fitness, performs selection, crossover, and mutation operations, and iterates for a fixed number of generations to evolve a solution. Finally, it returns the best route found.

## Features

- **Initialization**: Creates an initial population of routes.
- **Fitness Evaluation**: Ranks routes based on total distance.
- **Selection**: Selects the best routes for breeding.
- **Crossover (Breeding)**: Combines parts of two routes to create new routes.
- **Mutation**: Randomly swaps two cities in a route to introduce diversity.
- **Generations**: Iterates over multiple generations to improve solutions.

## Requirements

- Python 3.x
- NumPy

## Example usage:
city_list = list(range(5))

distance_matrix = np.array([[0, 2, 2, 5, 7],
                            [2, 0, 4, 8, 2],
                            [2, 4, 0, 1, 3],
                            [5, 8, 1, 0, 2],
                            [7, 2, 3, 2, 0]])

best_route = genetic_algorithm(population=city_list, pop_size=100, elite_size=20, mutation_rate=0.01, generations=500, distance_matrix=distance_matrix)
print("Best route: " + str(best_route))

## Functions

### `create_route(city_list)`

Creates a random route from the list of cities.

- **Parameters:**
  - `city_list`: List of cities.
- **Returns:** A random route.

### `initial_population(pop_size, city_list)`

Generates an initial population of routes.

- **Parameters:**
  - `pop_size`: Population size.
  - `city_list`: List of cities.
- **Returns:** A list of routes.

### `rank_routes(population, distance_matrix)`

Ranks routes based on their fitness (total distance).

- **Parameters:**
  - `population`: List of routes.
  - `distance_matrix`: Matrix of distances between cities.
- **Returns:** Sorted list of routes by fitness.

### `route_distance(route, distance_matrix)`

Calculates the total distance of a route.

- **Parameters:**
  - `route`: A route (list of city indices).
  - `distance_matrix`: Matrix of distances between cities.
- **Returns:** Total distance of the route.

### `selection(pop_ranked, elite_size)`

Selects the best routes for breeding.

- **Parameters:**
  - `pop_ranked`: Ranked population.
  - `elite_size`: Number of elite routes to retain.
- **Returns:** List of selected routes.

### `mating_pool(population, selection_results)`

Creates a mating pool from the selected routes.

- **Parameters:**
  - `population`: List of routes.
  - `selection_results`: List of selected routes.
- **Returns:** Mating pool.

### `breed(parent1, parent2)`

Breeds two parent routes to create a child route.

- **Parameters:**
  - `parent1`: First parent route.
  - `parent2`: Second parent route.
- **Returns:** Child route.

### `breed_population(matingpool, elite_size)`

Breeds the entire population.

- **Parameters:**
  - `matingpool`: Mating pool.
  - `elite_size`: Number of elite routes to retain.
- **Returns:** New population of routes.

### `mutate(individual, mutation_rate)`

Mutates a route by swapping two cities.

- **Parameters:**
  - `individual`: A route.
  - `mutation_rate`: Probability of mutation.
- **Returns:** Mutated route.

### `mutate_population(population, mutation_rate)`

Mutates the entire population.

- **Parameters:**
  - `population`: List of routes.
  - `mutation_rate`: Probability of mutation.
- **Returns:** Mutated population.

### `next_generation(current_gen, elite_size, mutation_rate, distance_matrix)`

Creates the next generation of routes.

- **Parameters:**
  - `current_gen`: Current generation of routes.
  - `elite_size`: Number of elite routes to retain.
  - `mutation_rate`: Probability of mutation.
  - `distance_matrix`: Matrix of distances between cities.
- **Returns:** Next generation of routes.

### `genetic_algorithm(population, pop_size, elite_size, mutation_rate, generations, distance_matrix)`

Runs the genetic algorithm to find the best route.

- **Parameters:**
  - `population`: List of cities.
  - `pop_size`: Population size.
  - `elite_size`: Number of elite routes to retain.
  - `mutation_rate`: Probability of mutation.
  - `generations`: Number of generations.
  - `distance_matrix`: Matrix of distances between cities.
- **Returns:** Best route found.

## License

This project is licensed under the MIT License - see the LICENSE file for details.


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

This implementation is based on common genetic algorithm techniques for solving the Traveling Salesman Problem (TSP).

Feel free to contribute to this project by submitting issues or pull requests.