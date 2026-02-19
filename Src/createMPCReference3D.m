% Spline path → time-parameterized reference

clc; clear;

% Load smoothed 3D path 
load data/globalPath3D.mat   % pathXYZ_smooth

% Parameters
Ts = 0.1;          % MPC sample time (s)
v_ref = 6;         % reference speed (m/s)

% Path points 
P = pathXYZ_smooth;
N = size(P,1);

% Arc-length calculation
ds = sqrt(sum(diff(P).^2,2)); % Pythagorean Theorem
s  = [0; cumsum(ds)];
totalLength = s(end); % total length of the entire flight
disp(totalLength)

% Time vector
t_total = totalLength / v_ref; % total duration(distance/speed)
t_ref   = (0:Ts:t_total)'; 

% Interpolate path wrt time 
s_ref = linspace(0, totalLength, numel(t_ref))';
% Shape-Preserving Piecewise Cubic Hermite Interpolating Polynomial interpolation
x_ref = interp1(s, P(:,1), s_ref, 'pchip');
y_ref = interp1(s, P(:,2), s_ref, 'pchip');
z_ref = interp1(s, P(:,3), s_ref, 'pchip');

% Velocity reference 
vx_ref = gradient(x_ref, Ts); % Instantaneous Velocity at every single timestamp
vy_ref = gradient(y_ref, Ts);
vz_ref = gradient(z_ref, Ts);

% Final reference matrix 
refTrajectory3D = [t_ref x_ref y_ref z_ref vx_ref vy_ref vz_ref];

% Save for MPC & Simulink 
save data/MPC_Reference3D.mat refTrajectory3D Ts

disp('Saved');
