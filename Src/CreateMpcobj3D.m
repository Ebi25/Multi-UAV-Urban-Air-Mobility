%% FINAL MPC OBJECT CREATION (NO MEASURED DISTURBANCE)

load('data/MPC_Reference_3D.mat','Ts')

%% Continuous-time 3D kinematic model
A = [ 0 0 0 1 0 0
      0 0 0 0 1 0
      0 0 0 0 0 1
      0 0 0 0 0 0
      0 0 0 0 0 0
      0 0 0 0 0 0 ];

B = [ 0 0 0
      0 0 0
      0 0 0
      1 0 0
      0 1 0
      0 0 1 ];

%% Discretize
sys_c = ss(A,B,eye(6),zeros(6,3));
sys_d = c2d(sys_c, Ts);

Ad = sys_d.A;
Bd = sys_d.B;

%% Create discrete plant (NO disturbances)
plant3D = ss(Ad, Bd, eye(6), zeros(6,3), Ts);

%% Create MPC object (this plant has NO MD by design)
mpcObj3D = mpc(plant3D, Ts);

%% Horizons
mpcObj3D.PredictionHorizon = 40;
mpcObj3D.ControlHorizon    = 8;

%% Weights
mpcObj3D.Weights.OutputVariables          = [20 20 20 5 5 5];
mpcObj3D.Weights.ManipulatedVariables     = [0 0 0];
mpcObj3D.Weights.ManipulatedVariablesRate = [0.15 0.15 0.15];



%% Constraints
mpcObj3D.MV(1).Max = 7;  mpcObj3D.MV(1).Min = -7;
mpcObj3D.MV(2).Max = 7;  mpcObj3D.MV(2).Min = -7;
mpcObj3D.MV(3).Max = 4;  mpcObj3D.MV(3).Min = -4;


%% Save FINAL controller and plant matrices
save('C:\Users\Lenovo\MATLAB Drive\Multi-UAV-Urban-Air-Mobility\Multi-UAV-Urban-Air-Mobility\Multi-UAV-Urban-Air-Mobility\data\mpcController3D.mat','mpcObj3D','Ad','Bd')
