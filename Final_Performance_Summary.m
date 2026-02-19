clc; close all;

if ~exist('out','var')
    error('Run Simulink model first.');
end

load('data/MultiUAV_References.mat')

logs = out.logsout;
t = out.tout;

x1 = logs{1}.Values.Data;
x2 = logs{2}.Values.Data;
x3 = logs{3}.Values.Data;
x4 = logs{4}.Values.Data;

states = {x1,x2,x3,x4};

%% Separation Analysis
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
minSep = zeros(6,1);

for i = 1:6
    xi = states{pairs(i,1)}(:,1:3);
    xj = states{pairs(i,2)}(:,1:3);
    d = vecnorm(xi - xj,2,2);
    minSep(i) = min(d);
end

globalMin = min(minSep);

fprintf('\nGlobal minimum separation: %.2f m\n',globalMin);

%% Mission Completion & Final Error
finalErr = zeros(4,1);
completionTime = zeros(4,1);

for i = 1:4
    xi = states{i};
    goal = missions(i).goal;

    finalErr(i) = norm(xi(end,1:3) - goal);

    threshold = 20;
    idx = find(vecnorm(xi(:,1:3) - goal,2,2) < threshold,1);

    if isempty(idx)
        completionTime(i) = NaN;
    else
        completionTime(i) = t(idx);
    end
end

%% RMSE Tracking
rmse = zeros(4,1);

for i = 1:4
    xi = states{i};
    ref = missions(i).refTS.Data(:,1:3);
    err = vecnorm(xi(:,1:3) - ref,2,2);
    rmse(i) = sqrt(mean(err.^2));
end

%% Control Effort
controlEffort = zeros(4,1);

for i = 1:4
    ui = logs{i}.Values.Data(:,4:6);
    controlEffort(i) = sum(vecnorm(ui,2,2))*mean(diff(t));
end

%% Display Summary
disp(' ')
disp('===== PERFORMANCE SUMMARY =====')

for i = 1:4
    fprintf('UAV %d:\n',i)
    fprintf('  Completion time: %.2f s\n',completionTime(i))
    fprintf('  Final position error: %.2f m\n',finalErr(i))
    fprintf('  RMSE tracking error: %.2f m\n',rmse(i))
    fprintf('  Control effort (proxy): %.2f\n\n',controlEffort(i))
end

%% Bar Chart Visualization
figure('Color','w','Position',[100 100 1000 600])

subplot(2,2,1)
bar(minSep)
title('Minimum Separation (All Pairs)')
ylabel('Distance (m)')
grid on

subplot(2,2,2)
bar(finalErr)
title('Final Position Error')
ylabel('Meters')
grid on

subplot(2,2,3)
bar(rmse)
title('RMSE Tracking Error')
ylabel('Meters')
grid on

subplot(2,2,4)
bar(controlEffort)
title('Control Effort')
grid on

sgtitle('Multi-UAV Performance Metrics')

exportgraphics(gcf,'Final_Performance_Summary.png','Resolution',300)
