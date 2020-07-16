%% initialization
close all;
input = [0,0;0,1;1,0;1,1];
target = [0;1;1;0];


%input = [0;30;60;90;120;150;180;210;240;270;300;330]*pi/180;
%target = sin(input)/2 +0.5;

%% training data
layers = [2 4 4 1];
max_node = max(layers);
layer_size = size(layers,2);
%init_weight = optimal_weight;
init_weight = rand(layer_size-1,max_node,max_node);
step_size = 0.25;
total_itr = 1000000;
max_error = 0.0001;
[optimal_weight,epoch_errors] = train_data(input,init_weight,target,layers,step_size,max_error);
  
plot(epoch_errors);
title("total error (cost) function vs number of epochs");
xlabel("number of epochs");
ylabel("total error (cost) function");

%% test data
data = input;
desired_output = target;
actual_output = test_data(data, optimal_weight, layers)
output_error = actual_output - desired_output