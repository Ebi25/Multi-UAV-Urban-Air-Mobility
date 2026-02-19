clc;
clear;
close all;

projectRoot = fileparts(mfilename('fullpath'));
cd(projectRoot);
addpath(genpath(projectRoot));

disp("Running Multi-UAV Urban Air Mobility Project");

CreateMultiUAV_Prioritized;

out = sim("Models/UAV_MPC_Tracking3D.slx");

Final_Performance_Summary;

disp("Simulation Completed Successfully");
