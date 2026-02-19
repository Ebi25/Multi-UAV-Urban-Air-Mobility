clc; close all;

if ~exist('out','var')
    error('Run Simulink model first.');
end

load('data/UrbanScenario_3D.mat')

logs = out.logsout;
t = out.tout;

x1 = logs{1}.Values.Data(:,1:3);
x2 = logs{2}.Values.Data(:,1:3);
x3 = logs{3}.Values.Data(:,1:3);
x4 = logs{4}.Values.Data(:,1:3);

figure('Color','w','Position',[100 100 1100 800],'Renderer','opengl');
hold on; grid on; axis equal;

show(occMap3D);
alpha 0.2

xlabel('X (m)','FontSize',14)
ylabel('Y (m)','FontSize',14)
zlabel('Z (m)','FontSize',14)
title('Multi-UAV Coordinated Flight Animation','FontSize',16)

view(45,30)
set(gca,'FontSize',12)

% UAV markers
h1 = plot3(x1(1,1),x1(1,2),x1(1,3),'ro','MarkerSize',8,'MarkerFaceColor','r');
h2 = plot3(x2(1,1),x2(1,2),x2(1,3),'go','MarkerSize',8,'MarkerFaceColor','g');
h3 = plot3(x3(1,1),x3(1,2),x3(1,3),'bo','MarkerSize',8,'MarkerFaceColor','b');
h4 = plot3(x4(1,1),x4(1,2),x4(1,3),'mo','MarkerSize',8,'MarkerFaceColor','m');

% Trajectory traces
p1 = animatedline('Color','r','LineWidth',1.5);
p2 = animatedline('Color','g','LineWidth',1.5);
p3 = animatedline('Color','b','LineWidth',1.5);
p4 = animatedline('Color','m','LineWidth',1.5);
v = VideoWriter('MultiUAV_Flight.mp4','MPEG-4');
v.FrameRate = 20;
open(v);


for k = 1:length(t)

    set(h1,'XData',x1(k,1),'YData',x1(k,2),'ZData',x1(k,3));
    set(h2,'XData',x2(k,1),'YData',x2(k,2),'ZData',x2(k,3));
    set(h3,'XData',x3(k,1),'YData',x3(k,2),'ZData',x3(k,3));
    set(h4,'XData',x4(k,1),'YData',x4(k,2),'ZData',x4(k,3));

    addpoints(p1,x1(k,1),x1(k,2),x1(k,3));
    addpoints(p2,x2(k,1),x2(k,2),x2(k,3));
    addpoints(p3,x3(k,1),x3(k,2),x3(k,3));
    addpoints(p4,x4(k,1),x4(k,2),x4(k,3));

    drawnow
    frame = getframe(gcf);
    writeVideo(v,frame);

end
close(v);
disp('Video saved as MultiUAV_Flight.mp4');

