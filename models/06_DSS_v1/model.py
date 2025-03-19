import sys
sys.stdout.reconfigure(encoding='utf-8')
import json
from ortools.constraint_solver import routing_enums_pb2
from ortools.constraint_solver import pywrapcp

def read_json_file(file_path):
    """Read JSON data from a file and return as a dictionary."""
    with open(file_path, 'r') as file:
        return json.load(file)

def create_data_model(data):
    """Returns the data model from the provided JSON data."""

    #Debugging: Print vehicles
    print(f"DEBUG: Vehicles Data = {json.dumps(data['vehicles'], indent=4)}")

    max_node = max(max(row['from_node'], row['to_node']) for row in data['distances']) + 1
    distance_matrix = [[0] * max_node for _ in range(max_node)]
    
    for row in data['distances']:
        distance_matrix[row['from_node']][row['to_node']] = int(float(row['distance']) * 1000)
    
    demands = [[row['location_index'], int(float(row['delivery_request']) * 1000), int(float(row['pickup_request']) * 1000)] for row in data['demands']]
    vehicle_capacities = [int(float(vehicle['capacity']) * 1000) for vehicle in data['vehicles']]
    num_vehicles = len(data['vehicles'])
    depot = data['depot'] if 'depot' in data else 0
    max_distances = [int(float(vehicle['max_distance']) * 1000) for vehicle in data['vehicles']]
    vehicle_ids = [vehicle['vehicle_id'] for vehicle in data['vehicles']]
    coordinates = data["coordinates"] if "coordinates" in data else None
    
    return {
        'distance_matrix': distance_matrix,
        'demands': demands,
        'vehicle_capacities': vehicle_capacities,
        'num_vehicles': num_vehicles,
        'depot': depot,
        'max_distances': max_distances,
        'vehicle_ids': vehicle_ids,
        'coordinates': coordinates
    }

def create_distance_callback(data, manager):
    def distance_callback(from_index, to_index):
        from_node = manager.IndexToNode(from_index)
        to_node = manager.IndexToNode(to_index)
        return data['distance_matrix'][from_node][to_node]
    return distance_callback

def add_distance_dimension(routing, transit_callback_index, data):
    """Add Global Span constraint per vehicle."""
    distance_dimension_name = 'Distance'
    routing.AddDimension(
        transit_callback_index,
        0,  # no slack
        max(data['max_distances']),  # maximum distance per vehicle
        True,  # start cumul to zero
        distance_dimension_name)
    distance_dimension = routing.GetDimensionOrDie(distance_dimension_name)
    for vehicle_id in range(data['num_vehicles']):
        distance_dimension.SetCumulVarSoftUpperBound(
            routing.End(vehicle_id),
            data['max_distances'][vehicle_id],
            100  # Penalty for exceeding the maximum distance
        )
    distance_dimension.SetGlobalSpanCostCoefficient(100)

def create_delivery_and_pickup_callbacks(data, manager):
    def delivery_callback(from_index):
        from_node = manager.IndexToNode(from_index)
        return data['demands'][from_node][1]
    
    def pickup_callback(from_index):
        from_node = manager.IndexToNode(from_index)
        return data['demands'][from_node][2]
    
    return delivery_callback, pickup_callback

def add_pickup_and_delivery_constraints(routing, manager, data):
    delivery_callback, pickup_callback = create_delivery_and_pickup_callbacks(data, manager)
    delivery_callback_index = routing.RegisterUnaryTransitCallback(delivery_callback)
    pickup_callback_index = routing.RegisterUnaryTransitCallback(pickup_callback)

    routing.AddDimensionWithVehicleCapacity(
        delivery_callback_index,
        0,
        data['vehicle_capacities'],
        True,
        'Delivery')

    routing.AddDimensionWithVehicleCapacity(
        pickup_callback_index,
        0,
        data['vehicle_capacities'],
        True,
        'Pickup')

def add_return_to_depot_constraint(routing, manager, data):
    distance_dimension_name = 'Distance'
    distance_dimension = routing.GetDimensionOrDie(distance_dimension_name)
    for vehicle_id in range(data['num_vehicles']):
        end_index = routing.End(vehicle_id)
        routing.AddVariableMinimizedByFinalizer(distance_dimension.CumulVar(end_index))

def print_solution(data, manager, routing, solution):
    """Generates a user-friendly solution report with real coordinates."""

    print("DEBUG: Loaded Data Keys =", data.keys())  # Debugging
    
    # Ensure 'coordinates' exists
    if "coordinates" not in data or data["coordinates"] is None:
        print("X ERROR: 'coordinates' key is missing or None in JSON!")
        return

    depot_coords = data["coordinates"][data["depot"]]  # Fix: Extract correct depot coordinates

    total_distance = 0.0
    total_pickup_load = 0.0
    total_delivery_load = 0.0
    solution_dict = {
        'solution_found': True,
        'routes': [],
        'depot_coords': depot_coords  # Store extracted depot coordinates
    }

    for vehicle_id in range(data['num_vehicles']):
        index = routing.Start(vehicle_id)
        route_distance = 0.0
        route_pickup_load = 0.0
        route_delivery_load = 0.0
        route = {
            'vehicle_id': data['vehicle_ids'][vehicle_id],
            'route': []
        }

        while not routing.IsEnd(index):
            node_index = manager.IndexToNode(index)
            pickup_load = data['demands'][node_index][2] / 1000.0
            delivery_load = data['demands'][node_index][1] / 1000.0
            route_pickup_load += pickup_load
            route_delivery_load += delivery_load

            route['route'].append({
                'location_index': node_index,
                'delivery_load': delivery_load,
                'pickup_load': pickup_load,
                'location_lat': data['coordinates'][node_index][0],  # Fix: Use correct index
                'location_lng': data['coordinates'][node_index][1]   # Fix: Use correct index
            })

            previous_index = index
            index = solution.Value(routing.NextVar(index))
            route_distance += routing.GetArcCostForVehicle(previous_index, index, vehicle_id) / 1000.0

        # Add depot as last node in route (return trip)
        route['route'].append({
            'location_index': data["depot"],
            'delivery_load': 0,
            'pickup_load': route_pickup_load,
            'location_lat': depot_coords[0],  # Fix: Use extracted depot coordinates
            'location_lng': depot_coords[1]   # Fix: Use extracted depot coordinates
        })
        
        route['distance'] = route_distance

        if route_distance > 0:
            solution_dict['routes'].append(route)

        total_distance += route_distance
        total_pickup_load += route_pickup_load
        total_delivery_load += route_delivery_load

    solution_dict['total_distance'] = total_distance
    solution_dict['total_pickup_load'] = total_pickup_load
    solution_dict['total_delivery_load'] = total_delivery_load  # Added total delivery load

    # Save JSON with real coordinates
    solution_path = "cvrp/cvrp_solution.json"
    with open(solution_path, "w") as solution_file:
        json.dump(solution_dict, solution_file, indent=4)

    print(f"Solution saved successfully to {solution_path}")



def main():
    data = read_json_file('cvrp/cvrp.json')

    # Debugging: Ensure JSON is loaded correctly
    print("Loaded JSON Data:")
    print(json.dumps(data, indent=4))

    data_model = create_data_model(data)

    manager = pywrapcp.RoutingIndexManager(len(data_model['distance_matrix']),
                                           data_model['num_vehicles'], data_model['depot'])
    routing = pywrapcp.RoutingModel(manager)

    transit_callback_index = routing.RegisterTransitCallback(create_distance_callback(data_model, manager))
    routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index)

    add_distance_dimension(routing, transit_callback_index, data_model)
    add_pickup_and_delivery_constraints(routing, manager, data_model)
    add_return_to_depot_constraint(routing, manager, data_model)

    search_parameters = pywrapcp.DefaultRoutingSearchParameters()
    search_parameters.first_solution_strategy = (routing_enums_pb2.FirstSolutionStrategy.PATH_CHEAPEST_ARC)
    search_parameters.local_search_metaheuristic = routing_enums_pb2.LocalSearchMetaheuristic.GUIDED_LOCAL_SEARCH
    search_parameters.time_limit.FromSeconds(3)

    solution = routing.SolveWithParameters(search_parameters)

    if solution:
        print_solution(data_model, manager, routing, solution)

        # Ensure Solution is written
        #solution_path = "cvrp/cvrp_solution.json"
        #with open(solution_path, "w") as solution_file:
            #json.dump({"solution_found": True}, solution_file)

        #print(f"Solution saved successfully to {solution_path}")
    else:
        print('X No solution found!')

if __name__ == '__main__':
    main()

