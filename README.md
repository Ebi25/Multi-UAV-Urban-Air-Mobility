Multi-UAV Urban Air Mobility Simulation

Centralized 3D Path Planning, MPC Tracking \& Multi-Drone Coordination in Urban Environments



Overview:



This project presents a complete simulation framework for multi-UAV path planning and coordinated flight in urban environments using:

* MATLAB



* Simulink



* UAV Toolbox



* Model Predictive Control (MPC)



* 3D Occupancy Mapping



* RRT\* Path Planning with Spline Smoothing



The system enables multiple drones to:



* Plan collision-free 3D paths



* Track optimized trajectories using MPC



* Avoid static obstacles in urban scenarios



* Execute coordinated missions in simulation



**Problem Statement:**



* Urban Air Mobility (UAM) requires:



* Safe navigation in dense 3D environments



* Collision avoidance between UAVs



* Optimal path generation



* Smooth trajectory tracking



* Centralized coordination







Project Architecture

3D Map / Urban Scenario

&nbsp;       ↓

Occupancy Map Generation

&nbsp;       ↓

RRT\* Path Planning

&nbsp;       ↓

Spline Path Smoothing

&nbsp;       ↓

Multi-UAV Prioritization

&nbsp;       ↓

MPC-Based Trajectory Tracking

&nbsp;       ↓

Simulink Multi-Drone Simulation



Repository Structure

data/       → Scenario files, reference trajectories, MPC models

Models/     → Simulink UAV tracking models

Results/    → Figures, performance plots, simulation videos

Src/        → Core planning and control algorithms



Cuboidscenario.mlx              → Urban environment setup

Final\_Animated\_Flight.m         → Multi-UAV simulation execution

Final\_Performance\_Summary.m     → Performance evaluation

MP2.uavpathplanning.prj         → MATLAB project file



**Core Components:**



1\.3D Urban Scenario



Cuboid obstacle representation



Urban building layout



Static obstacle modeling



2\.Occupancy Map Generation



Conversion of building bounding boxes into occupancy grid



3D collision validation



3\.Global Path Planning (RRT\*)



Rapidly Exploring Random Tree Star algorithm



Asymptotically optimal path search



Obstacle-aware sampling



4\.Spline Smoothing



Trajectory refinement



Removal of sharp turns



Improved tracking feasibility



5\.Multi-UAV Coordination



Mission assignment



Prioritized planning



Centralized coordination



6\.MPC Tracking Controller



Discrete 3D state-space model



Model Predictive Control



Position tracking error minimization



Smooth control input generation



**Simulation Results:**



The project includes:



* Multi-UAV flight animation



* RRT\* path visualization



* Spline path comparison



* 3D tracking error analysis



* Performance metrics evaluation



* See /Results folder for:



* Flight video



* Tracking plots



**Performance Highlights:**



* Collision-free path generation



* Stable 3D trajectory tracking



* Low tracking error



* Smooth velocity profiles



* Coordinated multi-drone operation



**Tools \& Toolboxes Used:**



* MATLAB



* Simulink



* UAV Toolbox



* Optimization Toolbox



* Model Predictive Control Toolbox

**How to Run**



Open MP2.uavpathplanning.prj







Execute:



1.CreateMultiUAV\_Prioritized

2.Final\_Animated\_Flight



Run:

**CreateMultiUAV_Prioritized**

**Final\_Performance\_Summary**



**Advanced Extensions -Future Work:**



* Sensor Fusion-based UAV state estimation



* Decentralized obstacle avoidance



* Task allocation optimization



* Photorealistic urban simulation



* Dynamic obstacle handling



* Real-time multi-drone coordination



* OSM map import \& automated occupancy generation



* App-based user interface for mission planning



**Outcome:**



This project demonstrates a complete pipeline for:



* Urban 3D path planning
* Multi-UAV coordination
* Optimal trajectory tracking
* Performance validation



It provides a scalable foundation for advanced Urban Air Mobility research and deployment frameworks.



Author



**Ebiron A**

Aeronautical Engineering

GitHub: https://github.com/Ebi25

