# Vehicle Routing Problem with Pickups and Deliveries (VRPPD)

## Overview

This repository contains a solution to the Vehicle Routing Problem with Pickups and Deliveries (VRPPD) using Google's OR-Tools. The program reads data from a JSON file, creates a data model, sets up the constraints and parameters for the problem, and solves it using OR-Tools' constraint solver. The problem involves routing a fleet of vehicles with different capacities and maximum distances from a single depot to a set of customers, ensuring that the vehicles return to the depot after completing their routes.

## Features

- Reads input data from a JSON file.
- Creates a data model for the VRPPD problem.
- Uses OR-Tools to solve the VRPPD with various constraints.
- Outputs the solution in a structured JSON format.

## Requirements

- Python 3.x
- OR-Tools (Google Optimization Tools)
- JSON data file for input

## Usage

1. **Prepare the JSON Input File:**
    - The input file should be a JSON file containing distance matrix, demands, and vehicle information.
    - Example structure of the `cvrp.json` file:
    ```json
    {
        "distances": [
            {"from_node": 0, "to_node": 1, "distance": 1.5},
            {"from_node": 0, "to_node": 2, "distance": 2.5},
            ...
        ],
        "demands": [
            {"location_index": 0, "delivery_request": 0, "pickup_request": 0},
            {"location_index": 1, "delivery_request": 1.0, "pickup_request": 0.5},
            ...
        ],
        "vehicles": [
            {"vehicle_id": 1, "capacity": 15.0, "max_distance": 50.0},
            {"vehicle_id": 2, "capacity": 15.0, "max_distance": 50.0},
            ...
        ],
        "depot": 0
    }
    ```

2. **Run the Python Script:**
    ```sh
    python cvrp_pickup_delivery_distance_1.1.1.0.py
    ```

## Functions

### `read_json_file(file_path)`

- Reads JSON data from a file and returns it as a dictionary.

### `create_data_model(data)`

- Processes the JSON data to create a data model required for the OR-Tools solver.
- Converts distances, demands, vehicle capacities, and maximum distances to a suitable format.
- Returns a dictionary containing:
	- `distance_matrix`: A matrix of distances between nodes.
	- `demands`: A list of demands (delivery and pickup) at each location.
	- `vehicle_capacities`: Capacities of each vehicle.
	- `num_vehicles`: Number of vehicles.
	- `depot`: Index of the depot.
	- `max_distances`: Maximum distances each vehicle can travel.
	- `vehicle_ids`: IDs of the vehicles.


### `create_distance_callback(data, manager)`

- Creates a callback function to return the distance between two nodes.
- Uses the `distance_matrix` from the data model.

### `add_distance_dimension(routing, transit_callback_index, data)`

- Adds a distance dimension to the routing model.
- Sets a soft upper bound for each vehicle's distance using `SetCumulVarSoftUpperBound`.
- Adds a global span cost coefficient to ensure distances are minimized.

### `create_delivery_and_pickup_callbacks(data, manager)`

- Creates callback functions for delivery and pickup demands.
- These callbacks return the delivery and pickup demands for each node.

### `add_pickup_and_delivery_constraints(routing, manager, data)`

- Adds capacity constraints for deliveries and pickups using the callbacks.
- Uses `AddDimensionWithVehicleCapacity` to ensure vehicle capacities are not exceeded.

### `add_return_to_depot_constraint(routing, manager, data)`

- Ensures that all vehicles return to the depot by adding a finalizer to the distance dimension.

### `print_solution(data, manager, routing, solution)`

- Prints the solution in a structured format.
- Iterates through each vehicle's route, calculating total distances and loads.
- Constructs and prints a JSON object containing the routes, total distance, and total pickup load.

### `main()`

- Reads the input JSON data.
- Creates the data model.
- Initializes the routing index manager and model.
- Registers transit, delivery, and pickup callbacks.
- Sets up the routing constraints and search parameters.
- Solves the problem and prints the solution if found.

## License

This project is licensed under the MIT License.

MIT License
-----------
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

Apache License 2.0

This project includes software developed by Google OR-Tools, which is licensed under the Apache License 2.0.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


## Acknowledgements

- This project uses Google's OR-Tools for solving the VRPPD.
- OR-Tools: https://developers.google.com/optimization

Feel free to contribute to this project by submitting issues or pull requests.
