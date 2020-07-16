close all;
clear;
%% equilibrium points for lambda=1.4
lambda = 1.4;
[eq_point1, eq_point2] = find_eq_points(lambda)

%% energy map for lambda=1.4
%%199X199 map with 0.01 precision between -1 and +1 for v1 and v2
energy_map = zeros(199);
lambda = 1.4;
for index1 = 1:199
   for index2 = 1:199
        v1 = (index1-100)/100;%potential of the first node
        v2 = (index2-100)/100;%potential of the second node
        energy_map(index1,index2) = calculate_energy(v1,v2,lambda);
   end
end

x = -0.99:0.01:0.99;
y = -0.99:0.01:0.99;
[X,Y] = meshgrid(x,y);
v = [-0.041 -0.023 -0.003 0.017 0.156  0.449 ];
figure;
contour(X,Y,energy_map,v,'ShowText','on');
title("energy counter map for lambda=1.4");

%% simulate the system
lambda = 1.4;
init_v = [0.2;0.6];
vv = init_v;
alpha = 0.01;
vv_array = [];
while norm(vv-eq_point1) > 0.001 && norm(vv-eq_point2) > 0.001
    v1_dot = -vv(1) + 2/pi*atan(lambda*pi*vv(2)/2);
    v2_dot = -vv(2) + 2/pi*atan(lambda*pi*vv(1)/2);
    vv(1) = vv(1) + alpha * v1_dot;
    vv(2) = vv(2) + alpha * v2_dot;
    vv_array = [vv_array vv];
end

hold on;
plot(vv_array(1,:),vv_array(2,:),'r');
title("energy counter map for lambda=1.4 and simulation");
legend("counters","convergence path",'Location','northwest');

%% eq points movements
eq_points1_array = [];
eq_points2_array = [];
for lambda = 1.4:0.1:20
    [eq_point1, eq_point2] = find_eq_points(lambda);
    eq_points1_array = [eq_points1_array eq_point1];
    eq_points2_array = [eq_points2_array eq_point2];
end

figure;
plot(eq_points1_array(1,:),eq_points1_array(2,:),eq_points2_array(1,:),eq_points2_array(2,:));
title("eq points movements");
