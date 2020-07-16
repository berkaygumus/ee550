%% initialization
close all;

%input = [0;30;60;90;120;150;180;210;240;270;300;330;360]*pi/180-pi;
%target = sin(input)/2 +0.5;

input = rand(60,1)*2*pi; %training samples
target = (sin(input)+1)/2; %mapping -1:1 to 0:1

%% training data
layers = [1 4 6 4 1]; %layer model
max_node = max(layers);
layer_size = size(layers,2);
%init_weight = w_init_q2; %initial weight matrix from mat file
%init_weight = optimal_weight;
random_weight = rand(layer_size-1,max_node,max_node);
init_weight = random_weight; %random initial weight matrix
step_size = 0.025;
max_error = 0.01; %max error
[optimal_weight,epoch_errors] = train_data(input,init_weight,target,layers,step_size,max_error);
  
plot(epoch_errors);
title("total error (cost) function vs number of epochs");
xlabel("number of epochs");
ylabel("total error (cost) function");


%% test data
data = rand(2500,1)*4*pi; %test samples
desired_output = sin(data); %desired output
actual_output = 2*test_data(data, optimal_weight, layers)-1 %actual out
output_error = actual_output - desired_output

figure;
plot(data,actual_output,'*',data,desired_output,'o');
legend("actual output","desired output");
%target = (sin(input)+1)/2; %mapping -1:1 to 0:1
