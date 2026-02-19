clc; clear; close all;

%  LOAD URBAN SCENARIO
data = load("data/UrbanScenario.mat");
bboxes = data.bboxes;     % [xmin ymin zmin xmax ymax zmax]
%  PARAMETERS
resolution = 1;           % cells per meter
padding    = 20;          % grid padding (cells)
%  COMPUTE GLOBAL EXTENTS
x_min_all = min(bboxes(:,1));
y_min_all = min(bboxes(:,2));

x_max_all = max(bboxes(:,4));
y_max_all = max(bboxes(:,5));

xRange = x_max_all - x_min_all;
yRange = y_max_all - y_min_all;

% Force square map 
maxRange = max(xRange, yRange);

mapWidth  = ceil(maxRange * resolution) + padding;
mapHeight = ceil(maxRange * resolution) + padding;

mapSize = [mapHeight mapWidth];
%  INITIALIZE OCCUPANCY GRID
OccMap = zeros(mapSize);   % 0 = free, 1 = occupied
%  RASTERIZE BOUNDING BOXES
for i = 1:size(bboxes,1)

    % Bounding box corners (world coordinates)
    x_min = bboxes(i,1);
    y_min = bboxes(i,2);

    x_max = bboxes(i,4);
    y_max = bboxes(i,5);

    % World to grid conversion (centered)
    x_idx = round((x_min:x_max) * resolution) ...
            - round(x_min_all * resolution) + padding/2;

    y_idx = round((y_min:y_max) * resolution) ...
            - round(y_min_all * resolution) + padding/2;

    % Bounds check
    % To avoid "Index exceeds matrix dimensions"

    x_idx = x_idx(x_idx >= 1 & x_idx <= mapSize(2));
    y_idx = y_idx(y_idx >= 1 & y_idx <= mapSize(1));

    % Mark occupied
    OccMap(y_idx, x_idx) = 1;
end

%  VISUALIZATION
figure;
imagesc(OccMap);
axis equal tight;
set(gca,'YDir','normal');
colormap(gray);
colorbar;
title('Urban Occupancy Map Generated from Bounding Boxes');
xlabel('X (grid)');
ylabel('Y (grid)');

%  SANITY CHECK
fprintf("Occupied cells: %d\n", nnz(OccMap));

%  DEFINE START & GOAL 
Start_Pos = [padding, padding];                 % bottom-left
Goal_Pos  = [mapWidth-padding, mapHeight-padding]; % top-right

%  SAVE FINAL
save data/UrbanScenario_WithOccMap.mat ...
     OccMap resolution mapSize bboxes Start_Pos Goal_Pos

disp("UrbanScenario_WithOccMap.mat successfully created");
