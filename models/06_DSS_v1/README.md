# DSS System - ICAERUS

## Overview
The **Decision Support System (DSS)** for ICAERUS is designed to optimize UAV logistics using a **Capacitated Vehicle Routing Problem (CVRP)** solver. The system now includes **compiled execution (`model.exe`)**, improved **route storage and retrieval**, and a **refactored class-based structure** (`dss_class.php`).

## Features
- **Optimized UAV Route Planning** using Google OR-Tools.
- **Standalone Execution** via `model.exe` (no Python installation required).
- **Dynamic Filtering of Orders and UAVs** before optimization.
- **Storage & Retrieval of Past Routes** from the database.
- **REST API for integration with PHP backend**.
- **Leaflet.js-based Route Visualization**.

---

## Installation & Setup

### **1. Requirements**
- A server running **PHP** and **MySQL**.
- **Google OR-Tools** (included in `model.exe`).
- **MySQL database** (to store routes and UAV orders).

### **2. Installation Steps**
1. Clone the repository:
   ```sh
   git clone https://github.com/ICAERUS/DSS-System.git
   ```
2. **Create a new database** and **import the demo Database** (`database/dss.sql`).
3. **Access the Web Interface** at:
   ```sh
   http://localhost/DSS/
   ```

---

## System Architecture
### **1. Backend**
- Main class (`dss_class.php`).
- API handling (storing and fetching routes`).
- UAV & order filtering before optimization.

### **2. `model.exe` (Compiled CVRP Solver)**
- Replaces `model.py`.
- Reads `cvrp.json`, processes UAV routes, and outputs `cvrp_solution.json`.
- Uses **Google OR-Tools** for optimal route calculation.

### **3. Frontend (Leaflet Map Visualization)**
- Displays optimized routes interactively.
- Fetches stored routes dynamically.

---

## JSON Data Schemas

### **1. Input (`cvrp.json`)**
```json
{
    "vehicles": [
        {
            "vehicle_id": 1,
            "capacity": 2.5,
            "max_distance": 5,
            "max_cargo_length": 30,
            "max_cargo_width": 20,
            "max_cargo_height": 15
        },
        {
            "vehicle_id": 4,
            "capacity": 10,
            "max_distance": 50,
            "max_cargo_length": 54,
            "max_cargo_width": 28,
            "max_cargo_height": 28
        }
    ],
    "demands": [
        {
            "location_index": 0,
            "delivery_request": 0,
            "pickup_request": 0
        },
        {
            "location_index": 1,
            "delivery_request": 1,
            "pickup_request": 0
        },
        {
            "location_index": 2,
            "delivery_request": 2,
            "pickup_request": 0
        }
    ],
    "distances": [
        {
            "from_node": 0,
            "to_node": 1,
            "distance": 1.7076808607511058
        },
        {
            "from_node": 0,
            "to_node": 2,
            "distance": 1.6720740532398557
        },
        {
            "from_node": 1,
            "to_node": 0,
            "distance": 1.7076808607511058
        },
        {
            "from_node": 1,
            "to_node": 2,
            "distance": 1.471191136783408
        },
        {
            "from_node": 2,
            "to_node": 0,
            "distance": 1.6720740532398557
        },
        {
            "from_node": 2,
            "to_node": 1,
            "distance": 1.471191136783408
        }
    ],
    "depot": 0,
    "coordinates": [
        [
            40.6050811,
            22.9533302
        ],
        [
            40.59920486748849,
            22.9720182819242
        ],
        [
            40.59062,
            22.95876
        ]
    ]
}
```

---

### **2. Output (`cvrp_solution.json`)**
```json
{
    "solution_found": true,
    "routes": [
        {
            "vehicle_id": 1,
            "route": [
                {
                    "location_index": 0,
                    "delivery_load": 0.0,
                    "pickup_load": 0.0,
                    "location_lat": 40.6050811,
                    "location_lng": 22.9533302
                },
                {
                    "location_index": 2,
                    "delivery_load": 2.0,
                    "pickup_load": 0.0,
                    "location_lat": 40.59062,
                    "location_lng": 22.95876
                },
                {
                    "location_index": 0,
                    "delivery_load": 0,
                    "pickup_load": 0.0,
                    "location_lat": 40.6050811,
                    "location_lng": 22.9533302
                }
            ],
            "distance": 3.344
        },
        {
            "vehicle_id": 4,
            "route": [
                {
                    "location_index": 0,
                    "delivery_load": 0.0,
                    "pickup_load": 0.0,
                    "location_lat": 40.6050811,
                    "location_lng": 22.9533302
                },
                {
                    "location_index": 1,
                    "delivery_load": 1.0,
                    "pickup_load": 0.0,
                    "location_lat": 40.59920486748849,
                    "location_lng": 22.9720182819242
                },
                {
                    "location_index": 0,
                    "delivery_load": 0,
                    "pickup_load": 0.0,
                    "location_lat": 40.6050811,
                    "location_lng": 22.9533302
                }
            ],
            "distance": 3.414
        }
    ],
    "depot_coords": [
        40.6050811,
        22.9533302
    ],
    "total_distance": 6.758,
    "total_pickup_load": 0.0,
    "total_delivery_load": 3.0
}
```

---

## API Endpoints
### **1. Retrieve Stored Routes**
**GET `fetch_route.php?route_id={id}`**  
Returns stored UAV route data.

### **2. Store a New Route**
**POST `store_routes.php`**  
Saves an optimized route into the database.

---

## Usage Example
1. **Access the Web Interface** at:  
   ```sh
   http://localhost/DSS/
   ```
2. **Modify or Add Data** in the `orders` table as needed.  

3. **View Previous DSS Results** at:  
   ```sh
   http://localhost/DSS/dss_results.php
   ```
---   

## Future Enhancements
- **Advanced analytics dashboard** for UAV performance tracking.
- **Support for multiple UAV hubs** (multi-depot optimization).
- **Live UAV tracking integration**.

---

## Contributors
Developed by **Geosense** for the **ICAERUS Project**.
```

