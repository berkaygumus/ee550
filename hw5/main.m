close all;
clear;
%% training data
%random fi and alfa angles for spherical coordinates:
angles1 = [2*pi*rand(30,1),pi*rand(30,1)/6];%top
cluster1 = [sin(angles1(:,2)).*cos(angles1(:,1)),sin(angles1(:,2)).*sin(angles1(:,1)),cos(angles1(:,2))];

angles2 = [2*pi*rand(30,1),pi - pi*rand(30,1)/6];%bottom
cluster2 = [sin(angles2(:,2)).*cos(angles2(:,1)),sin(angles2(:,2)).*sin(angles2(:,1)),cos(angles2(:,2))];

angles3 = [pi*rand(30,1)/3,pi/3 + pi*rand(30,1)/3];%side
cluster3 = [sin(angles3(:,2)).*cos(angles3(:,1)),sin(angles3(:,2)).*sin(angles3(:,1)),cos(angles3(:,2))];

figure;
plot3(cluster1(:,1),cluster1(:,2),cluster1(:,3),'rx',cluster2(:,1),cluster2(:,2),cluster2(:,3),'bx',cluster3(:,1),cluster3(:,2),cluster3(:,3),'gx');
legend("cluster1","cluster2","cluster3");
title("desired clusters");
data= [cluster1;cluster2;cluster3];

%% training part
%random spherical angles for weights
random_angle = [2*pi*rand(3,1),pi*rand(3,1)];
%random weights on unit sphere
random_weight = [sin(random_angle(:,2)).*cos(random_angle(:,1)),sin(random_angle(:,2)).*sin(random_angle(:,1)),cos(random_angle(:,2))];
weight = random_weight;%initial weight
prev_weight = zeros(3,3);%previous weight to compare changes at the weight, for the beginning it must be different from initial weight
diff = ones(3,3);%difference vectors 3x3
winner_cluster = zeros(90,1);%data labels
d = 0.001;%learning rate
itr = 1;
weight1 = zeros(1500,3);%recording of weight1's
weight2 = zeros(1500,3);%recording of weight2's
weight3 = zeros(1500,3);%recording of weight3's
weight1(itr,:) = weight(1,:);
weight2(itr,:) = weight(2,:);
weight3(itr,:) = weight(3,:);
while sum(sum(prev_weight==weight)) ~=9 %prev_weight ~= weight
    itr = itr + 1;
    diff = zeros(3,3);
    for i=1:90
        result = weight*transpose(data(i,:));% [sample*cluster1_w; sample*cluster2_w; sample*cluster3_w]
        c = find(result == max(result));%winner cluster
        diff(c,:) = diff(c,:) +(data(i,:)-weight(c,:)); %adding of difference vector for cluster c
        winner_cluster(i,1) = c;%data label update
    end
    prev_weight = weight;
    weight = weight + d*diff; %weight update
    weight(1,:) = weight(1,:)/norm(weight(1,:));%normalization
    weight(2,:) = weight(2,:)/norm(weight(2,:));
    weight(3,:) = weight(3,:)/norm(weight(3,:));
    %weight_change = weight - prev_weight;%change at weight
    
    weight1(itr,:) = weight(1,:);%recording the weights
    weight2(itr,:) = weight(2,:);
    weight3(itr,:) = weight(3,:);
    
end

weight1 = weight1(1:itr,:);%removal of unnecesary part 
weight2 = weight2(1:itr,:);
weight3 = weight3(1:itr,:);

%cluster1: red
%cluster2: green
%cluster3: blue
figure;
%weight trajectories
plot3(weight1(:,1),weight1(:,2),weight1(:,3),'r',weight2(:,1),weight2(:,2),weight2(:,3),'g',weight3(:,1),weight3(:,2),weight3(:,3),'b')
hold on
%final weights
plot3(weight(1,1),weight(1,2),weight(1,3),'rx','MarkerSize',50);
hold on;
plot3(weight(2,1),weight(2,2),weight(2,3),'gx','MarkerSize',50);
hold on;
plot3(weight(3,1),weight(3,2),weight(3,3),'bx','MarkerSize',50);
hold on;
%cluster 1
plot3(data(winner_cluster==1,1),data(winner_cluster==1,2),data(winner_cluster==1,3),'r*');
hold on;
%cluster 2
plot3(data(winner_cluster==2,1),data(winner_cluster==2,2),data(winner_cluster==2,3),'g*');
hold on;
%cluster 3
plot3(data(winner_cluster==3,1),data(winner_cluster==3,2),data(winner_cluster==3,3),'b*');
legend("weight1 trajectory","weight2 trajectory","weight3 trajectory","weight1","weight2","weight3","cluster1","cluster2","cluster3");
title("estimated training data and clusters");

%% test part
test_angles1 = [2*pi*rand(3,1),pi*rand(3,1)/6];
test_cluster1 = [sin(test_angles1(:,2)).*cos(test_angles1(:,1)),sin(test_angles1(:,2)).*sin(test_angles1(:,1)),cos(test_angles1(:,2))];

test_angles2 = [2*pi*rand(3,1),pi - pi*rand(3,1)/6];
test_cluster2 = [sin(test_angles2(:,2)).*cos(test_angles2(:,1)),sin(test_angles2(:,2)).*sin(test_angles2(:,1)),cos(test_angles2(:,2))];

test_angles3 = [pi*rand(3,1)/3,pi/3 + pi*rand(3,1)/3];
test_cluster3 = [sin(test_angles3(:,2)).*cos(test_angles3(:,1)),sin(test_angles3(:,2)).*sin(test_angles3(:,1)),cos(test_angles3(:,2))];

test_data = [test_cluster1;test_cluster2;test_cluster3];%test data
estimated_cluster = zeros(9,1);%test data label
for i=1:9
    test_result = weight*transpose(test_data(i,:));% [test_data*cluster1_w; test_data*cluster2_w; test_data*cluster3_w]
    c = find(test_result == max(test_result));%winner cluster
    estimated_cluster(i,1) = c;%test data label
end

%cluster1: red
%cluster2: green
%cluster3: blue
figure;
%weights
plot3(weight(1,1),weight(1,2),weight(1,3),'rx','MarkerSize',50);
hold on;
plot3(weight(2,1),weight(2,2),weight(2,3),'gx','MarkerSize',50);
hold on;
plot3(weight(3,1),weight(3,2),weight(3,3),'bx','MarkerSize',50);
hold on;
%cluster1
plot3(test_data(estimated_cluster==1,1),test_data(estimated_cluster==1,2),test_data(estimated_cluster==1,3),'r*');
hold on;
%cluster2
plot3(test_data(estimated_cluster==2,1),test_data(estimated_cluster==2,2),test_data(estimated_cluster==2,3),'g*');
hold on;
%cluster3
plot3(test_data(estimated_cluster==3,1),test_data(estimated_cluster==3,2),test_data(estimated_cluster==3,3),'b*');
legend("weight1","weight2","weight3","cluster1","cluster2","cluster3");
title("estimated test data and clusters");
