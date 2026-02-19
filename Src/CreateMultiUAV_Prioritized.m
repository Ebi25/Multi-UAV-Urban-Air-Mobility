clc; clear; close all;

%% Load map
load data/UrbanScenario_3D.mat
load data/UrbanScenario.mat

%% Map bounds
xmin = min(bboxes(:,1));
ymin = min(bboxes(:,2));
xmax = max(bboxes(:,4));
ymax = max(bboxes(:,5));
zmax = max(bboxes(:,6));

zSafe = zmax + 5;

%% Define 4 missions (crossing layout)
missions(1).start = [-245  -53  zSafe];
missions(1).goal  = [  20  146  zSafe];

missions(2).start = [  20  146  zSafe];
missions(2).goal  = [-245  -53  zSafe];

missions(3).start = [xmax-20  ymin+30  zSafe];
missions(3).goal  = [xmin+30  ymax-30  zSafe];

missions(4).start = [xmin+40  ymax-20  zSafe];
missions(4).goal  = [xmax-40  ymin+20  zSafe];

%% Estimate straight-line distance (priority rule)
for k = 1:4
    missions(k).approxDist = norm(missions(k).goal - missions(k).start);
end

[~,priorityOrder] = sort([missions.approxDist],'descend');

fprintf("Planning priority order (longest first):\n");
disp(priorityOrder)

%% State space
ss = stateSpaceSE3;
ss.StateBounds = [xmin xmax;
                  ymin ymax;
                  0 zSafe+5;
                  -1 1;
                  -1 1;
                  -1 1;
                  -1 1];

sv = validatorOccupancyMap3D(ss);
sv.Map = occMap3D;
sv.ValidationDistance = 1.0;

planner = plannerRRTStar(ss, sv);
planner.MaxIterations = 3000;
planner.MaxConnectionDistance = 15;

Ts = 0.1;
N = 300;
safetyRadius = 15;

plannedMissions = [];

%% Centralized prioritized planning
for idx = 1:4

    k = priorityOrder(idx);
    fprintf("Planning UAV %d...\n",k);

    startState = [missions(k).start 1 0 0 0];
    goalState  = [missions(k).goal  1 0 0 0];

    attempt = 0;
    maxAttempts = 5;
    isCollision = true;

    while attempt < maxAttempts && isCollision

        attempt = attempt + 1;
        fprintf("Attempt %d\n",attempt);

        [pathObj,~] = plan(planner,startState,goalState);

        if isempty(pathObj.States)
            continue;
        end

        pathXYZ = pathObj.States(:,1:3);

        % Spline smoothing
        d = sqrt(sum(diff(pathXYZ).^2,2));
        s = [0; cumsum(d)];

        ppX = spline(s, pathXYZ(:,1));
        ppY = spline(s, pathXYZ(:,2));
        ppZ = spline(s, pathXYZ(:,3));

        sFine = linspace(0,s(end),N);
        xs = ppval(ppX,sFine);
        ys = ppval(ppY,sFine);
        zs = ppval(ppZ,sFine);

        pathSmooth = [xs' ys' zs'];
        t = (0:N-1)' * Ts;

        % Check against previously planned UAVs
        isCollision = false;

        for j = 1:length(plannedMissions)

            prev = plannedMissions(j);
            prevPos = interp1(prev.t, prev.pathSmooth, t, 'linear','extrap');

            for n = 1:N
                if norm(pathSmooth(n,:) - prevPos(n,:)) < safetyRadius
                    isCollision = true;
                    break;
                end
            end

            if isCollision
                break;
            end
        end

        if isCollision
            fprintf("Conflict detected. Replanning...\n");
        end
    end

    if isCollision
        error("Failed to find collision-free path for UAV %d",k);
    end

    % Time parameterization
    vx = gradient(pathSmooth(:,1),Ts);
    vy = gradient(pathSmooth(:,2),Ts);
    vz = gradient(pathSmooth(:,3),Ts);

    refTrajectory = [t pathSmooth vx vy vz];

    refTS = timeseries(refTrajectory(:,2:7),t);
    refTS = setinterpmethod(refTS,'linear');

    % Store results
    missions(k).pathXYZ_smooth = pathSmooth;
    missions(k).refTS = refTS;
    missions(k).Ts = Ts;

    plannedMissions(end+1).pathSmooth = pathSmooth;
    plannedMissions(end).t = t;

end

%% Visualization
figure('Color','k'); hold on; grid on; axis equal
show(occMap3D)
colors = {'r','g','c','y'};

for k = 1:4
    p = missions(k).pathXYZ_smooth;
    plot3(p(:,1),p(:,2),p(:,3), ...
          'Color',colors{k}, ...
          'LineWidth',2);
end

title('Centralized Prioritized Multi-UAV Planning','Color','w')
xlabel('X'); ylabel('Y'); zlabel('Z')
view(45,30)

%% Save
save('C:\Users\Lenovo\MATLAB Drive\Multi-UAV-Urban-Air-Mobility\Multi-UAV-Urban-Air-Mobility\Multi-UAV-Urban-Air-Mobility\data\MultiUAV_References.mat','missions','Ts')
disp("Centralized multi-UAV missions saved successfully.")
