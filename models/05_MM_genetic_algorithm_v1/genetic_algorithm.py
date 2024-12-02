import numpy as np
import random

def create_route(city_list):
    route = random.sample(city_list, len(city_list))
    return route

def initial_population(pop_size, city_list):
    population = []
    for i in range(pop_size):
        population.append(create_route(city_list))
    return population

def rank_routes(population, distance_matrix):
    fitness_results = {}
    for i in range(len(population)):
        fitness_results[i] = 1 / float(route_distance(population[i], distance_matrix))
    return sorted(fitness_results.items(), key=lambda x: x[1], reverse=True)

def route_distance(route, distance_matrix):
    distance = 0
    for i in range(len(route)):
        from_city = route[i]
        to_city = route[(i + 1) % len(route)]
        distance += distance_matrix[from_city][to_city]
    return distance

def selection(pop_ranked, elite_size):
    selection_results = []
    df = sum([pop_ranked[i][1] for i in range(len(pop_ranked))])
    cum_sum = 0
    for i in range(len(pop_ranked)):
        cum_sum += pop_ranked[i][1]
        pop_ranked[i] = (pop_ranked[i][0], cum_sum / df)
    
    for i in range(elite_size):
        selection_results.append(pop_ranked[i][0])
    for i in range(len(pop_ranked) - elite_size):
        pick = random.random()
        for j in range(len(pop_ranked)):
            if pick <= pop_ranked[j][1]:
                selection_results.append(pop_ranked[j][0])
                break
    return selection_results

def mating_pool(population, selection_results):
    matingpool = []
    for i in range(len(selection_results)):
        index = selection_results[i]
        matingpool.append(population[index])
    return matingpool

def breed(parent1, parent2):
    child = []
    childP1 = []
    childP2 = []

    geneA = int(random.random() * len(parent1))
    geneB = int(random.random() * len(parent1))

    startGene = min(geneA, geneB)
    endGene = max(geneA, geneB)

    for i in range(startGene, endGene):
        childP1.append(parent1[i])

    childP2 = [item for item in parent2 if item not in childP1]

    child = childP1 + childP2
    return child

def breed_population(matingpool, elite_size):
    children = []
    length = len(matingpool) - elite_size
    pool = random.sample(matingpool, len(matingpool))

    for i in range(elite_size):
        children.append(matingpool[i])

    for i in range(length):
        child = breed(pool[i], pool[len(matingpool) - i - 1])
        children.append(child)
    return children

def mutate(individual, mutation_rate):
    for swapped in range(len(individual)):
        if random.random() < mutation_rate:
            swapWith = int(random.random() * len(individual))

            city1 = individual[swapped]
            city2 = individual[swapWith]

            individual[swapped] = city2
            individual[swapWith] = city1
    return individual

def mutate_population(population, mutation_rate):
    mutated_pop = []

    for ind in range(len(population)):
        mutated_ind = mutate(population[ind], mutation_rate)
        mutated_pop.append(mutated_ind)
    return mutated_pop

def next_generation(current_gen, elite_size, mutation_rate, distance_matrix):
    pop_ranked = rank_routes(current_gen, distance_matrix)
    selection_results = selection(pop_ranked, elite_size)
    matingpool = mating_pool(current_gen, selection_results)
    children = breed_population(matingpool, elite_size)
    next_gen = mutate_population(children, mutation_rate)
    return next_gen

def genetic_algorithm(population, pop_size, elite_size, mutation_rate, generations, distance_matrix):
    pop = initial_population(pop_size, population)
    print("Initial distance: " + str(1 / rank_routes(pop, distance_matrix)[0][1]))

    for i in range(generations):
        pop = next_generation(pop, elite_size, mutation_rate, distance_matrix)

    print("Final distance: " + str(1 / rank_routes(pop, distance_matrix)[0][1]))
    best_route_index = rank_routes(pop, distance_matrix)[0][0]
    best_route = pop[best_route_index]
    return best_route

# Example usage:
city_list = list(range(5))

distance_matrix = np.array([[0, 2, 2, 5, 7],
                            [2, 0, 4, 8, 2],
                            [2, 4, 0, 1, 3],
                            [5, 8, 1, 0, 2],
                            [7, 2, 3, 2, 0]])

best_route = genetic_algorithm(population=city_list, pop_size=100, elite_size=20, mutation_rate=0.01, generations=500, distance_matrix=distance_matrix)
print("Best route: " + str(best_route))
