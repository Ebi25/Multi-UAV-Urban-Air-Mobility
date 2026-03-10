# Multi-UAV Urban Air Mobility Simulation

Centralized 3D Path Planning, MPC Tracking, and Multi-Drone Coordination in Urban Environments

---
This repository contains a MATLAB-Simulink simulation framework for centralized multi-UAV path planning and trajectory tracking in urban air mobility environments.
# Overview

This project implements a complete simulation framework for multi-UAV path planning and coordinated flight in dense urban environments using MATLAB and Simulink.

The system enables multiple UAVs to autonomously:

- Plan collision-free paths in a 3D urban environment
- Avoid static obstacles such as buildings
- Coordinate with other UAVs using centralized planning
- Track smooth trajectories using Model Predictive Control (MPC)

The framework integrates global path planning, trajectory generation, and closed-loop control simulation within a unified MATLAB environment.

Technologies used include:

- 3D Urban Environment Modeling
- Occupancy Map Generation
- RRT* Global Path Planning
- Spline Path Smoothing
- Multi-UAV Prioritized Planning
- Model Predictive Control (MPC)
- Simulink-based UAV flight simulation

---

# Problem Statement

Urban Air Mobility (UAM) requires UAVs to operate safely in dense city environments.

Key challenges include:

- Safe navigation through complex 3D environments
- Avoidance of buildings and obstacles
- Collision avoidance between multiple UAVs
- Generation of optimal and smooth trajectories
- Coordinated multi-UAV mission execution

This project demonstrates a complete simulation pipeline addressing these challenges.

---

# System Architecture

The overall pipeline of the system is shown below.

3D Urban Scenario  
↓  
Occupancy Map Creation  
↓  
RRT* Global Path Planning  
↓  
Spline Path Smoothing  
↓  
Multi-UAV Prioritized Planning  
↓  
MPC-Based Trajectory Tracking  
↓  
Simulink Multi-Drone Flight Simulation  

Each stage contributes to generating safe, smooth, and coordinated UAV trajectories.

---

# Repository Structure

data/ → Urban environment data and reference trajectories  
Models/ → Simulink UAV tracking models  
Results/ → Simulation outputs and figures  
Src/ → Core planning algorithms  

Key files:

Cuboidscenario.mlx → Urban environment generation  
CreateMultiUAV_Prioritized.m → Multi-UAV path planner  
Final_Animated_Flight.m → UAV simulation and animation  
Final_Performance_Summary.m → Performance evaluation  
MP2.uavpathplanning.prj → MATLAB project file  
run_MultiUAV_Project.m → Main project execution script  

---

# Core Components

## 1. 3D Urban Scenario

The urban environment is generated using cuboid building representations.

Features include:

- Static obstacle modeling
- Urban building layout generation
- Configurable environment size

These structures define the environment through which UAVs navigate.

---

## 2. Occupancy Map Generation

Building bounding boxes are converted into a 3D occupancy map.

This map enables:

- Collision detection
- Path validation
- Obstacle avoidance during planning

The occupancy grid provides efficient spatial queries for path planning.

---

## 3. Global Path Planning (RRT*)

The project uses the Rapidly Exploring Random Tree Star (RRT*) algorithm to generate optimal collision-free paths.

Key features of RRT*:

- Sampling-based motion planning
- Asymptotically optimal solutions
- Efficient exploration of large environments

The planner finds feasible paths while avoiding obstacles defined in the occupancy map.

---

## 4. Path Smoothing

The raw path produced by RRT* may contain sharp turns.

Spline interpolation is used to smooth the path.

Benefits include:

- Smooth trajectory generation
- Reduced control effort
- Improved tracking feasibility

The smoothed trajectory becomes the reference path for the UAV controller.

---

## 5. Multi-UAV Coordination

A centralized prioritized planning strategy is used.

Steps include:

1. Missions are assigned priorities
2. UAV paths are planned sequentially
3. Each UAV considers previously planned UAV paths
4. Safety constraints prevent collisions between UAVs

This ensures safe coordinated operation.

---

## 6. MPC Trajectory Tracking

Each UAV tracks its trajectory using Model Predictive Control (MPC) implemented in Simulink.

MPC provides:

- Optimal control input generation
- Smooth trajectory tracking
- Constraint handling
- Robust flight behavior

The controller minimizes trajectory tracking error while maintaining stable flight.

---

# Simulation Results

The simulation generates:

- Multi-UAV flight animation
- RRT* path visualization
- Spline trajectory comparison
- 3D tracking error plots
- UAV performance metrics

Results are available in the Results/ folder.

---

# Performance Highlights

The system demonstrates:

- Collision-free multi-UAV path generation
- Stable 3D trajectory tracking
- Smooth velocity profiles
- Coordinated multi-drone flight
- Maintained safety separation distances

Metrics include:

- Tracking error
- Completion time
- Minimum UAV separation
- Control effort

---

# Technologies and Toolboxes Used

The project uses the following MATLAB technologies:

- MATLAB
- Simulink
- UAV Toolbox
- Navigation Toolbox
- Model Predictive Control Toolbox
- Optimization Toolbox

---

# How to Run the Project

1. Clone the repository:

git clone https://github.com/Ebi25/Multi-UAV-Urban-Air-Mobility.git

2. Open MATLAB.

3. Open the MATLAB project file:

MP2.uavpathplanning.prj

4. Run the following scripts:

CreateMultiUAV_Prioritized  
Final_Animated_Flight  
Final_Performance_Summary  

These scripts will:

- Generate collision-free UAV paths
- Simulate UAV flight using MPC control
- Display visualization and performance metrics

---

# Simulation Video

Simulation output can be viewed in:

Results/MultiUAV_Flight.mp4

---

# Future Work

Possible extensions include:

- Sensor fusion for UAV state estimation
- Decentralized collision avoidance
- Dynamic obstacle handling
- Photorealistic urban simulation
- Task allocation optimization
- Real-time multi-drone coordination
- OpenStreetMap-based urban environment generation
- Mission planning graphical interface

---

# Author

Ebiron A  
Aeronautical Engineering  

GitHub: https://github.com/Ebi25