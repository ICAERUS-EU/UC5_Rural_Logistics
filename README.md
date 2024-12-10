<div align="center">
  <a href="https://icaerus.eu" target="_blank">
    <img width="300" src="https://icaerus.eu/wp-content/uploads/2022/09/ICAERUS-logo-white.svg" alt="ICAERUS Logo">
  </a>
  <a href="https://daedalus.geosenseapps.com" target="_blank">
    <img width="120" src="https://daedalus.geosenseapps.com/images/dlogo2.png" alt="DAEDALUS Logo">
  </a>
  <h3 align="center">UC5: Rural Logistics</h3>
  
  <p align="center">
    This repository contains tools and models designed for drone-based rural logistics solutions, focusing on isolated and underserved areas.
    <br/>
    <br/>
    <a href="https://github.com/icaerus-eu/icaerus-repo-template/issues">Report Bug</a>
    -
    <a href="https://github.com/icaerus-eu/icaerus-repo-template/issues">Request Feature</a>
  </p>
</div>


![Downloads](https://img.shields.io/github/downloads/icaerus-eu/UC5_Rural_Logistics/total) ![Contributors](https://img.shields.io/github/contributors/icaerus-eu/UC5_Rural_Logistics?color=dark-green) ![Forks](https://img.shields.io/github/forks/icaerus-eu/UC5_Rural_Logistics?style=social) ![Stargazers](https://img.shields.io/github/stars/icaerus-eu/UC5_Rural_Logistics?style=social) ![Issues](https://img.shields.io/github/issues/icaerus-eu/UC5_Rural_Logistics) ![License](https://img.shields.io/github/license/icaerus-eu/UC5_Rural_Logistics) 

## Table Of Contents

* [Summary](#summary)
* [Structure](#structure)
* [Models](#models)
* [Tools](#tools)
* [Authors](#authors)
* [Acknowledgements](#acknowledgements)

## Summary
Within this repository, you'll find various models and computational tools designed to enable and enhance rural logistics operations using drones. These tools address challenges in transporting essential goods, medical supplies, and other critical resources to remote and isolated areas.

## Structure
The repository is structured as follows: 

- **data:** Contains datasets used for training and testing the models. Some datasets are available for download from [Zenodo](https://zenodo.org/).
- **images:** Contains images related to the models..
- **models:** Contains machine learning models and algorithms developed specifically for rural logistics.
- **platform.json:** Structured information about the models and their parameters.
- **LICENSE:** The license file for the repository.
- **README.md:** This file, providing an overview of the repository.

## Models
The [models](https://github.com/ICAERUS-EU/UC5_Rural_Logistics/blob/main/models/) are the following:

#### _[Ant Colony Optimization Model](https://github.com/ICAERUS-EU/UC5_Rural_Logistics/blob/main/models/01_MM_ant_colony_v1/)_
This model uses Ant Colony Optimization (ACO) techniques to solve logistics routing problems efficiently by mimicking the behavior of ant colonies in nature.

#### _[Traveling Salesman Problem Solver](https://github.com/ICAERUS-EU/UC5_Rural_Logistics/blob/main/models/02_MM_tsp_v1/)_
This model provides a robust solution to the Traveling Salesman Problem (TSP) for optimizing routes among multiple delivery points.

#### _[Combination-Based Optimization](https://github.com/ICAERUS-EU/UC5_Rural_Logistics/blob/main/models/03_MM_combinations_v1/)_
A model designed for generating and evaluating combinations to optimize resource allocation and delivery routes.

#### _[CVRP with Distance Optimization](https://github.com/ICAERUS-EU/UC5_Rural_Logistics/blob/main/models/04_cvrp_pickup_delivery_distance_v1/)_
This model solves the Capacitated Vehicle Routing Problem (CVRP) for pickup and delivery while minimizing travel distances.

#### _[Genetic Algorithm Optimization](https://github.com/ICAERUS-EU/UC5_Rural_Logistics/blob/main/models/05_MM_genetic_algorithm_v1/)_
An advanced optimization model leveraging Genetic Algorithms (GA) to handle complex logistics scenarios with multiple constraints.

## Authors
* **Konstantinos Grigoriadis** - *Geosense* - [Konstantinos Grigoriadis](https://www.linkedin.com/in/kostas-grigoriadis-53382432/)

## Acknowledgements
This project is funded by the European Union, grant ID 101060643.

<img src="https://rea.ec.europa.eu/sites/default/files/styles/oe_theme_medium_no_crop/public/2021-04/EN-Funded%20by%20the%20EU-POS.jpg" alt="https://cordis.europa.eu/project/id/101060643" width="200"/>
