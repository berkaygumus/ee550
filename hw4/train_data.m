function [optimal_weight,epoch_errors] = train_data(input,init_weight,target,layers,step_size,max_error)
    m = size(target,1);
   
    max_node = max(layers);
    layer_size = size(layers,2);
    %init_weight = rand(layer_size-1,max_node,max_node);
    weight = init_weight;
    s_values = zeros(m,layer_size,max_node);
    o_values = zeros(m,layer_size,max_node);
    del_values = zeros(m,layer_size,max_node);

    epoch_errors = zeros(10000000,1);

    
    error = 10000;
    epoch = 0;
    while error > max_error && epoch < 1000000
            epoch = epoch + 1;
            %% forward propagation
            for i=1:layers(1)
                for sample = 1:m
                    s_values(sample,1,i) = input(sample,i);
                    o_values(sample,1,i) = (s_values(sample,1,i));
                end
            end

            %layer k >> node i
            %layer k+1 >> node j



            %for layer k+1 : 2 >> output layer = layer_size
            for k=1:layer_size-1
                for j=1:layers(k+1)
                    s_values(:,k+1,j) = 0;
                    for i=1:layers(k)
                        s_values(:,k+1,j) = s_values(:,k+1,j) + o_values(:,k,i)*weight(k,i,j);
                    end
                    for sample = 1:m
                        o_values(sample,k+1,j) = f(s_values(sample,k+1,j));
                    end
                end       
            end
            error = sum((target - o_values(:,layer_size,1)).^2)/2/m;
            epoch_errors(epoch) = error;

            %% backward error propagation




            output_layer = layer_size;
            for j=1:layers(output_layer)
                for sample = 1:m                  
                    del_values(sample,output_layer,j) = (target(sample) - o_values(sample,output_layer,j))*f_dot(s_values(sample,output_layer,j));
                end
                for i=1:layers(output_layer-1)
                    weight(output_layer-1,i,j) = weight(output_layer-1,i,j) + step_size*transpose(del_values(:,output_layer,j))*o_values(:,output_layer-1,i);
                end
            end

            %hidden_layer = layer_size-1;
            for hidden_layer = layer_size-1:-1:2
                for j=1:layers(hidden_layer) 
                    del_sum = zeros(m,1);
                    for l = 1:layers(hidden_layer+1)
                        del_sum = del_sum + del_values(:,hidden_layer+1,l)*weight(hidden_layer,j,l);
                    end
                    for sample = 1:m
                        del_values(sample,hidden_layer,j) = del_sum(sample)* f_dot(s_values(sample,hidden_layer,j));
                    end
                    for i=1:layers(hidden_layer-1)
                        weight(hidden_layer-1,i,j) = weight(hidden_layer-1,i,j) + step_size*transpose(del_values(:,hidden_layer,j))*o_values(:,hidden_layer-1,i);
                    end
                end
            end
    end
    optimal_weight = weight;
    epoch_errors = epoch_errors(1:epoch);
end

