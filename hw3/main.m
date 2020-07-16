clc;
clear;
close ALL;
%random points from the 1. and 8. quadrants are taken
%the numbers are between -100 and 100
maks = 1;
data = [rand(30,3)*maks;-rand(30,3)*maks];
%labels are created:
%the 1. quadrant is label 1
%the 8. quadrant is label -1
label = [ones(30,1);-ones(30,1)];
%visualization of training data
%the points from the 1.quadrant is represented by x
plot3(data(1:20,1),data(1:20,2),data(1:20,3),'x');
hold on;
%the points from the 8.quadrant is represented by o
plot3(data(31:50,1),data(31:50,2),data(31:50,3),'o');
hold on;

%trainig and test data is created
training_data = [data(1:20,:);data(31:50,:)];
training_label = [label(1:20,:);label(31:50,:)]; %aka desired output 
test_data = [data(21:30,:);data(51:60,:)];
test_label = [label(21:30,:);label(51:60,:)];


%% training part
%initial weight vector, numbers between -1 and 1
w = 2*rand(3,1)-1;
%threshold value, it can be changed
threshold =100;

%actual output for initial weight
actual_output = sign(training_data*w-threshold);
%cost value for initial weight
cost = 1/2*transpose((training_label-actual_output))*(training_label-actual_output);
%cost vector for the plot
cost_vector = [cost];

while cost~=0
    for i=1:40 %each points at the training data
        actual_output = sign(training_data*w-threshold);
        error = training_label(i)-actual_output(i);%error check for the selected point at the training data
        if error ~=0%if this point is misallocated, the weight vector is updated             
            w = w + error*training_data(i)/2;        
            actual_output = sign(training_data*w-threshold);%actual output for updated weight
            cost = 1/2*transpose((training_label-actual_output))*(training_label-actual_output);%cost after this iteration
            cost_vector = [cost_vector; cost];%this cost value is added to cost vector
        end      
    end
    actual_output = sign(training_data*w-threshold);
    cost = 1/2*transpose((training_label-actual_output))*(training_label-actual_output);
    
end

%decision plane
[x1, x2] = meshgrid(-maks:2*maks:maks); % Generate x1 and x2 data
x3 = -1/w(3)*(w(1)*x1 + w(2)*x2 - threshold); %x3 in terms of x1 and x2
surf(x1,x2,x3) %Plot the surface
legend("positive points","negative points","decision plane");
title("training data with decision plane");

figure;
plot(cost_vector);
xlabel("iteration index");
ylabel("cost value")
title("iteration index & cost value ")

%% test part

test_output = sign(test_data*w-threshold);

test_error = abs(test_output - test_label)/2;
total_error = sum(test_error);%the number of misallocated points at test data
test_accuracy = 1-total_error/20

%visualization of test data and decision plane
figure;
plot3(data(21:30,1),data(21:30,2),data(21:30,3),'*');
hold on;
plot3(data(51:60,1),data(51:60,2),data(51:60,3),'o');
hold on;
[x1, x2] = meshgrid(-maks:2*maks:maks); 
x3 = -1/w(3)*(w(1)*x1 + w(2)*x2 - threshold);
surf(x1,x2,x3); 
legend("positive points","negative points","boundary plane");
title("test data with decision plane (#misallocated points: " + total_error + " )" )
